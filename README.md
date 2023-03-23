# simple-taiko-node

Get started with the [guide](https://taiko.xyz/docs/guides/run-a-node).

## Volumes 
    docker volume create l2_execution_engine_data -d local --opt type=none --opt device=/mnt/blockstore/taiko --opt o=bind
## Run
    docker-compose up -d
