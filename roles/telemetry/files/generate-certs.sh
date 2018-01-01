#!/bin/sh

set -x

mkdir -p certs

if [ ! -f certs/ca.pem ]; then
    cfssl gencert -initca csr-ca.json | cfssljson -bare certs/ca
fi

cfssl gencert -profile=client \
    -ca=certs/ca.pem -ca-key certs/ca-key.pem \
    csr-logstash-client.json | cfssljson -bare certs/logstash-client

cfssl gencert -profile=www \
-ca=certs/ca.pem -ca-key certs/ca-key.pem \
    csr-logstash-server.json | cfssljson -bare certs/logstash-server

set +x
for t in ca logstash-client logstash-server; do
    echo
    openssl x509 -in certs/${t}.pem -noout -text -nameopt oneline -certopt no_sigdump
    cat certs/${t}.pem certs/${t}-key.pem > certs/${t}-bundle.pem
done