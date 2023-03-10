#!/bin/sh
# P12 file path
P12_FILE="./party/sandbox.p12"
# bundle id
TOPIC="bundle-id"
# token
TOKEN="728b1d069362e877610ae3631f5572da5f58c132399c7782b255f0d40a3435d8"


PUSH_TYPE="alert"

# production environment
# APNS_HOST_NAME=api.push.apple.com
# development environment
APNS_HOST_NAME=api.development.push.apple.com

read -r -d '' PAYLOAD <<-'EOF'
{
    "aps": {
        "sound": "default",
        "alert": {
            "title": "title",
            "subtitle": "subtitle",
            "body": "testing from dawenhing __i__"
        },
        "mutable-content":1
    }
}
EOF

# only support p12 without passphrase
for i in {0..10}
do
SEND_PAYLOAD=${PAYLOAD//__i__/$i}
python3 -c "import sys,json;p=r'''${SEND_PAYLOAD}''';print(p);json.loads(p);"
curl \
    --header "apns-topic: ${TOPIC}" \
    --header "apns-push-type: ${PUSH_TYPE}" \
    --header "apns-priority: 10" \
    --header "apns-expiration: 0" \
    --cert-type P12 --cert "${P12_FILE}" \
    --data "$SEND_PAYLOAD" \
    --http2  "https://${APNS_HOST_NAME}/3/device/${TOKEN}"
done