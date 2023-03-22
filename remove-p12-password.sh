
if [ $# -ne 1 ]; then
    echo "Usage: $0 <p12 file>"
    exit 1
fi

TEMP="$(mktemp)"
echo ${TEMP}
echo "Input the password"
openssl pkcs12 -in $1 -nodes -out ${TEMP}
echo "Don't input any password(just enter twice)"
openssl pkcs12 -export -in ${TEMP} -out unprotected.p12
