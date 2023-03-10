#!/bin/sh
# P12 file path
P12_FILE="./party/sandbox.p12"

# for Push To Talk
TOPIC="bundle-id"
# token
# TOKEN="5e8dbb8de32c0b231bf8b1ce89f0e3fdd52ab7603c197e7232206af781d3f396"
TOKEN="37bba44db143bfdb2c43e3c7230a0b41fe3514e03cd50407ed57d47ff145f500"

# production environment
# APNS_HOST_NAME=api.push.apple.com
# development environment
APNS_HOST_NAME=api.development.push.apple.com

read -r -d '' VPOPTT <<-'EOF'
{
    "fromId": "123403",
    "msgId": 1234,
    "remoteUrl": "https://cdnus101.183im.com/1/2/dc294e3a94b448873a7a6d7aeef0ea63/m/dd80a4ec07e845b896dab326e61a1c3a",
    "isGroup": false,
    "speakerUserInfo": {
        "name": "Test03",
        "portrait": "",
        "userId": "123403"
    },
    "alert" : {
      "title" : "Default title",
      "body" : "Default body"
    }  
}
EOF

# jq 不支持中横线的字段命令
PAYLOAD=$(  jq -n \
            --arg ptt "$VPOPTT" \
            '{aps: {ptttttttttttttt: $ptt, "groupId": "2550248706004322984579-1"}}' )
PAYLOAD=${PAYLOAD//ptttttttttttttt/voip-ptt}

curl -v \
    --header "apns-topic: ${TOPIC}.voip-ptt" \
    --header "apns-push-type: pushtotalk" \
    --header "apns-priority: 10" \
    --header "apns-expiration: 0" \
    --cert-type P12 --cert "${P12_FILE}" \
    --data "$PAYLOAD" \
    --http2  "https://${APNS_HOST_NAME}/3/device/${TOKEN}"
