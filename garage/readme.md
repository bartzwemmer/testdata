# Garage
Garage is an S3 compatible storage. This compose starts a 1 node cluster, with a web ui on localhost:3909.

## Init
After starting the containers with:
`docker compose --profile garage  up`
Run the following commands to configure the cluster.
`docker exec -ti garage /garage status` copy the ID value
`docker exec -ti garage /garage layout assign -z dc1 -c 1G <<ID Value>>`
`docker exec -ti garage /garage layout apply --version 1`