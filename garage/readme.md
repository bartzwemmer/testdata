# Garage

Garage is an S3 compatible storage. This compose starts a 1 node cluster, with a web ui on localhost:3909. The init script creates a bucket and a file in that bucket.

## Ports

| Port | Description      |
| ---- | ---------------- |
| 3900 | S3 API server    |
| 3902 | Web server       |
| 3903 | Admin API server |
| 3904 | K2V API server   |
| 3909 | Web UI           |
