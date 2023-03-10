#!/bin/sh
# P12 file path
BUNDLE_ID="top.dawenhing.PushToTalkDemo"
PAYLOAD_FILE="push_payload.apns"
xcrun simctl push booted $BUNDLE_ID $PAYLOAD_FILE
