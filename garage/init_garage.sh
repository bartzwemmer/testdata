#!/bin/sh

# Exit on any error
set -e

echo "--- Running Garage Init Script ---"

# Add docker-cli and aws-cli
apk add --no-cache docker-cli aws-cli

echo "Attempting to get Garage ID..."

# It seems that `docker exec -t` might write to stderr or behave unexpectedly in a pipe.
# We will redirect stderr to stdout to ensure we capture everything.
GARAGE_ID=$(docker exec -t garage /garage status 2>&1 | grep -oE '^[0-9a-f]+' | head -n 1)

# Final check
if [ -z "$GARAGE_ID" ]; then
  echo "Failed to get garage ID. Dumping full status output:"
  docker exec -t garage /garage status 2>&1
  exit 1
fi

echo "Found garage ID: $GARAGE_ID"

# Only assign and apply layout if no role has been assigned yet
if docker exec -t garage /garage layout show 2>&1 | grep -q "No nodes currently have a role"; then
    echo "Assigning layout..."
    docker exec -t garage /garage layout assign -z dc1 -c 1G "$GARAGE_ID"

    echo "Applying layout..."
    docker exec -t garage /garage layout apply --version 1
else
    echo "Layout already applied, skipping."
fi

echo "Waiting for garage to be ready..."
sleep 5

# --- S3 Bucket and Key Creation ---
BUCKET_NAMES="simpsons test-data"
# Use a fixed name for the key that the WebUI will use
KEY_NAME="webui-key"
S3_ENDPOINT="http://garage:3900"

for BUCKET_NAME in $BUCKET_NAMES; do
    # 1. Create Bucket if it does not exist
    echo "Checking for bucket '$BUCKET_NAME'..."
    if ! docker exec -t garage /garage bucket list | tr -d '\r' | grep -q "${BUCKET_NAME}"; then
        echo "Creating bucket '$BUCKET_NAME'..."
        docker exec -t garage /garage bucket create "$BUCKET_NAME"
    else
        echo "Bucket '$BUCKET_NAME' already exists."
    fi

    # 2. Import WebUI Key if it does not exist
    # Credentials are read from the environment, passed via `env_file`
    echo "Checking for key '$KEY_NAME'..."
    if ! docker exec -t garage /garage key list | tr -d '\r' | grep -q "${KEY_NAME}"; then
        echo "Key '$KEY_NAME' not found. Importing from environment..."
        if [ -z "$S3_ACCESS_KEY" ] || [ -z "$S3_SECRET_KEY" ]; then
            echo "ERROR: S3_ACCESS_KEY and S3_SECRET_KEY must be set in the environment."
            exit 1
        fi
        docker exec -t garage /garage key import "$S3_ACCESS_KEY" "$S3_SECRET_KEY" -n "$KEY_NAME" --yes
    else
        echo "Key '$KEY_NAME' already exists."
    fi

    # 3. Grant Permissions
    echo "Applying permissions for key '$KEY_NAME' on bucket '$BUCKET_NAME'..."
    docker exec -t garage /garage bucket allow --read --write --owner "$BUCKET_NAME" --key "$KEY_NAME"

    # 4. Verification
    # Export credentials for the aws-cli to use
    export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$S3_SECRET_KEY
    export AWS_DEFAULT_REGION="garage"

    echo "Verifying bucket access..."
    if aws s3api head-bucket --bucket "$BUCKET_NAME" --endpoint-url "$S3_ENDPOINT" >/dev/null 2>&1; then
    echo "Verification successful: Bucket '$BUCKET_NAME' is accessible."
    else
    echo "Verification failed: Could not access bucket '$BUCKET_NAME' with provided key."
    exit 1
    fi
done

# 5. Upload test data
BUCKET_NAME="test-data"
echo "Checking for test data in bucket '$BUCKET_NAME'..."
if ! aws s3api head-object --bucket "$BUCKET_NAME" --key "house-price.parquet" --endpoint-url "$S3_ENDPOINT" >/dev/null 2>&1; then
    echo "Uploading house-price.parquet..."
    aws s3 cp /data/house-price.parquet "s3://$BUCKET_NAME/house-price.parquet" --endpoint-url "$S3_ENDPOINT"
else
    echo "house-price.parquet already exists in bucket, skipping upload."
fi
BUCKET_NAME="simpsons"
FILE_NAMES="characters.parquet episodes.parquet locations.parquet script_lines.parquet"
for FILE_NAME in $FILE_NAMES; do
    echo "Checking for test data in bucket '$BUCKET_NAME'..."
    if ! aws s3api head-object --bucket "$BUCKET_NAME" --key "$FILE_NAME" --endpoint-url "$S3_ENDPOINT" >/dev/null 2>&1; then
        echo "Uploading $FILE_NAME..."
        aws s3 cp /data/$FILE_NAME "s3://$BUCKET_NAME/$FILE_NAME" --endpoint-url "$S3_ENDPOINT"
    else
        echo "$FILE_NAME already exists in bucket, skipping upload."
    fi
done

echo "--- Garage Init Script Finished ---"
