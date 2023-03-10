#!/bin/sh
# P8 file path
P8_FILE="./party/sandbox.p8"
AUTH_KEYID="M57BWJ3LT5"
AUTH_TEAMID="HQUMU47JDU"
# bundle id
TOPIC="bundle-id"
# token
TOKEN="728b1d069362e877610ae3631f5572da5f58c132399c7782b255f0d40a3435d8"

# production environment
# APNS_HOST_NAME=api.push.apple.com
# development environment
APNS_HOST_NAME=api.development.push.apple.com

timestamp=$(date +%s)
read -r -d '' PAYLOAD <<-'EOF'
{
    "aps": {
        "timestamp": tttttttimestamp,
        "event": "end",
        "content-state": {
            "driverName": "Anne Johnson",
            "onlineState": "online"
        },
        "alert": {
            "title": "Delivery Update",
            "body": "Your pizza order will arrive soon."
        }
    }
}
EOF
PAYLOAD=${PAYLOAD//tttttttimestamp/${timestamp}}

python3 -c "import sys,json;p=r'''${PAYLOAD}''';print(p);json.loads(p);"

# --------------------------------------------------------------------------
base64() {
   openssl base64 -e -A | tr -- '+/' '-_' | tr -d =
}

sign() {
   printf "$1"| openssl dgst -binary -sha256 -sign "$P8_FILE" | base64
}

TIMESTAMP=$(date +%s)
HEADER=$(printf '{ "alg": "ES256", "kid": "%s" }' "$AUTH_KEYID" | base64)
CLAIMS=$(printf '{ "iss": "%s", "iat": %d }' "$AUTH_TEAMID" "$TIMESTAMP" | base64)
JWT="$HEADER.$CLAIMS.$(sign $HEADER.$CLAIMS)"

curl \
   --header "content-type: application/json" \
   --header "authorization: bearer $JWT" \
   --header "apns-topic: $TOPIC" \
   --data "$PAYLOAD" \
   https://$APNS_HOST_NAME/3/device/$TOKEN
