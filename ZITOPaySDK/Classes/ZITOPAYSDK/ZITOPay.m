//
//  ZITOPay.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOPay.h"

#import "ZITOPayCache.h"
#import "ZITOPayAdapter.h"
#import "ZITOPay+Utils.h"

@interface ZITOPay ()
@property (nonatomic, weak) id<ZITOPayDelegate> delegate;
@end


@implementation ZITOPay

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZITOPay *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ZITOPay alloc] init];
    });
    return instance;
}

+ (BOOL)initWithAppID:(NSString *)appId andAppSecret:(NSString *)appSecret {
    ZITOPayCache *instance = [ZITOPayCache sharedInstance];
    if (appId.isValid && appSecret.isValid) {
        instance.appId = appId;
        instance.appSecret = appSecret;
        return YES;
    }
    return NO;
}

+ (BOOL)initWithAppID:(NSString *)appId andAppSecret:(NSString *)appSecret sandbox:(BOOL)isSandbox {
    BOOL flag = [ZITOPay initWithAppID:appId andAppSecret:appSecret];
    if (flag) {
        [ZITOPay setSandboxMode:isSandbox];
    }
    return flag;
}

+ (void)setSandboxMode:(BOOL)sandbox {
    [ZITOPayCache sharedInstance].sandbox = sandbox;
}

+ (BOOL)getCurrentMode {
    return [ZITOPayCache sharedInstance].sandbox;
}

+ (BOOL)initWeChatPay:(NSString *)wxAppID {
    if (!wxAppID.isValid) {
        return NO;
    }
    return [ZITOPayAdapter ZITOPayRegisterWeChat:wxAppID];
}

+ (void)setZITOPayDelegate:(id<ZITOPayDelegate>)delegate {
    [ZITOPay sharedInstance].delegate = delegate;
}

+ (id<ZITOPayDelegate>)getZITOPayDelegate {
    return [ZITOPay sharedInstance].delegate;
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    if (ZITOPayUrlWeChat == [ZITOPayUtil getUrlType:url]) {
        return [ZITOPayAdapter ZITOPay:kAdapterWXPay handleOpenUrl:url];
    } else if (ZITOPayUrlAlipay == [ZITOPayUtil getUrlType:url]) {
        return [ZITOPayAdapter ZITOPay:kAdapterAliPay handleOpenUrl:url];
    }
    return NO;
}

+ (BOOL)canMakeApplePayments:(NSUInteger)cardType {
    return [ZITOPayAdapter ZITOPayCanMakeApplePayments:cardType];
}

+ (NSString *)getZITOApiVersion {
    return kApiVersion;
}

+ (void)setWillPrintLog:(BOOL)flag {
    [ZITOPayCache sharedInstance].willPrintLogMsg = flag;
}

+ (void)setNetworkTimeout:(NSTimeInterval)time {
    [ZITOPayCache sharedInstance].networkTimeout = time;
}

+ (BOOL)sendZITOReq:(ZITOBaseReq *)req {
    ZITOPay *instance = [ZITOPay sharedInstance];
    BOOL bSend = YES;
    switch (req.type) {
        case ZITOObjsTypePayReq: //支付(微信、支付宝、银联、百度钱包)
            [instance reqPay:(ZITOPayReq *)req];
            break;
        default:
            bSend = NO;
            break;
    }
    return bSend;
}

@end
