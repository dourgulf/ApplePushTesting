# APNS-PUSH-TESTING
Apple push service testing tools

## APNS
### Using P12 certificate
- Use apns-push-p12.sh shell script;
- Replace variable `P12_FILE` with your exported p12 certificate file path;
- Replace `TOPIC` variable with your bundle id;
- Replace `TOKEN` variable with your token;
- If your p12 file exported with password, remove it first with script `remove-p12-password.sh`;
```Shell
remove-p12-password.sh apns.p12
mv apns.p12 protected-apns.p12
mv unprotected.p12 apns.p12
```
Note: When running script, you will prompt enter the password, this is the password of you p12,
And next time prompt you enter password, you should not enter anything, just press enter twice.
### Using P8 certificate
- Use apns-push-p8.sh shell script;
- Replace variable `P8_FILE` with your generated p8 certificate file path;
- Set `AUTH_KEYID` and `AUTH_TEAMID` (from your apple developer account information);
- Replace `TOPIC` variable with your bundle id;
- Replace `TOKEN` variable with your token;

## PushToTalk
`pushtotalk-p12.sh`

## LiveActivity
`liveactivity-push-p8.sh`
