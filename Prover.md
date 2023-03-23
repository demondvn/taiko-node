docker run -d \
    --name taiko_client_prover_relayer \
    --restart unless-stopped \
    --env-file .env \
    --volumes ./script:/script \
    --entrypoint /bin/sh \
    -e ENABLE_PROVER=true
    -e 
    gcr.io/evmchain/taiko-client:askja \
    -c "/script/start-prover-relayer.sh"
