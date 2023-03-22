#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <p12 file>"
    exit 1
fi

P12_FILE=$1
P12_FILENAME="${P12_FILE%.*}"
openssl pkcs12 -in ${P12_FILE} -out ${P12_FILENAME}_key.pem -nocerts -nodes
openssl pkcs12 -in ${P12_FILE} -out ${P12_FILENAME}_cert.pem -clcerts -nokeys
