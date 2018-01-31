CFSSL := ${GOPATH}/bin/cfssl
CFSSLJSON := ${GOPATH}/bin/cfssljson
OUT := certs

certs : ca client server

ca : ${OUT}/ca.pem ${OUT}/ca-trust-store.jks

client : ${OUT}/kafka-client.pem ${OUT}/kafka-client-keystore.p12

server : ${OUT}/kafka-server.pem ${OUT}/kafka-server-keystore.p12

${OUT}/%-client.pem : csr-%-client.json ${OUT}/ca.pem
	 cfssl gencert -profile client -ca ${OUT}/ca.pem -ca-key ${OUT}/ca-key.pem $< | cfssljson -bare ${OUT}/$*-client

${OUT}/%-server.pem : csr-%-server.json ${OUT}/ca.pem
	 cfssl gencert -profile WWW -ca ${OUT}/ca.pem -ca-key ${OUT}/ca-key.pem $< | cfssljson -bare ${OUT}/$*-server

${OUT}/%-keystore.p12 : ${OUT}/%.pem ${OUT}/%-key.pem
	openssl pkcs12 -export -in ${OUT}/$*.pem -inkey ${OUT}/$*-key.pem -out $@ -name $* -noiter -nomaciter

${OUT}/ca.pem : csr-ca.json ${CFSSL} ${CFSSLJSON}
	mkdir -p ${OUT}
	cfssl genkey -initca $< | cfssljson -bare ${OUT}/ca

${OUT}/ca-trust-store.jks : ${OUT}/ca.pem
	keytool -keystore $@ -alias CAroot -import -file $<

${CFSSL} :
	go get -u github.com/cloudflare/cfssl/cmd/cfssl

${CFSSLJSON} :
	go get -u github.com/cloudflare/cfssl/cmd/cfssljson

.PHONY : certs ca client server