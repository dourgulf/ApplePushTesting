# APNS-PUSH-TESTING
苹果各种推送服务测试工具

## APNS推送
### 使用P12证书方式
- 使用`apns-push-p12.sh`脚本;
- 替换变量 `P12_FILE` 为你导出的 p12 证书的路径；
- 替换`TOPIC`变量为你的bundle id;
- 替换`TOKEN`变量为你的token;
- 如果你的 p12 文件导出了密码, 那么第一步需要执行脚本 `remove-p12-password`;
```Shell
remove-p12-password.sh apns.p12
mv apns.p12 protected-apns.p12
mv unprotected.p12 apns.p12
```
### 使用p8证书方式
- 使用`apns-push-p8.sh`脚本;
- 替换变量 `P8_FILE` 为你产生的 p8 证书的路径;
- 并修改 `AUTH_KEYID` 和 `AUTH_TEAMID`（在创建 p8 证书时，从苹果开发者后台中获取）;
- 替换`TOPIC`变量为你的bundle id;
- 替换`TOKEN`变量为你的token;

## PushToTalk推送
`pushtotalk-push-p12.sh`
## LiveActivity推送
`liveactivity-push-p8.sh`
