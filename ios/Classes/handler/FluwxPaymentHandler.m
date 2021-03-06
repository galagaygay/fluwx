//
// Created by mo on 2018/8/24.
//

#import "FluwxPaymentHandler.h"


@implementation FluwxPaymentHandler
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];

    return self;
}

- (void)handlePayment:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (!isWeChatRegistered) {
        result([FlutterError errorWithCode:resultErrorNeedWeChat message:resultMessageNeedWeChat details:nil]);
        return;
    }

    if (![WXApi isWXAppInstalled]) {
        result([FlutterError errorWithCode:@"wechat not installed" message:@"wechat not installed" details:nil]);
        return;
    }

    NSString *partnerId = call.arguments[@"partnerId"];
    NSString *prepayId = call.arguments[@"prepayId"];
    NSString *packageValue = call.arguments[@"packageValue"];
    NSString *nonceStr = call.arguments[@"nonceStr"];
    UInt32 timeStamp = (UInt32) call.arguments[@"timeStamp"];
    NSString *sign = call.arguments[@"sign"];
    BOOL done = [WXApiRequestHandler sendPayment:call.arguments[@"appId"]
                                       PartnerId:partnerId
                                        PrepayId:prepayId
                                        NonceStr:nonceStr
                                       Timestamp:timeStamp
                                         Package:packageValue
                                            Sign:sign];
    result(@{fluwxKeyPlatform: fluwxKeyIOS, fluwxKeyResult: @(done)});
}
@end