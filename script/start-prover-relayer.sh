#!/bin/sh

set -eou pipefail
: ${RPCD:=zkevm-chain-prover-rpcd}
if [ "$ENABLE_PROVER" == "true" ]; then
    if [ ! -f "./wait" ];then
        wget https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait
        chmod +x ./wait
    fi

    WAIT_HOSTS=${RPCD}:9000 WAIT_TIMEOUT=180 ./wait
    
    if [ ! -d "/data" ]; then
        mkdir "/data"
    fi
    
    taiko-client prover \
        --l1.ws ${L1_ENDPOINT_WS} \
        --l2.ws ws://l2_execution_engine:${PORT_L2_EXECTION_ENGINE_WS} \
        --l1.http ${L1_ENDPOINT_HTTP} \
        --l2.http http://l2_execution_engine:${PORT_L2_EXECTION_ENGINE_HTTP} \
        --taikoL1 ${TAIKO_L1_ADDRESS} \
        --taikoL2 ${TAIKO_L2_ADDRESS} \
        --zkevmRpcdEndpoint http://${RPCD}:${PORT_ZKEVM_CHAIN_PROVER_RPCD} \
        --zkevmRpcdParamsPath /data \
        --l1.proverPrivKey ${L1_PROVER_PRIVATE_KEY} \
        --maxConcurrentProvingJobs 1
else
    sleep infinity
fi
