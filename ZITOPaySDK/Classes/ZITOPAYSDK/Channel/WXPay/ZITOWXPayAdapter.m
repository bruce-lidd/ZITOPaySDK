//
//  ZITOWXPayAdapter.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOWXPayAdapter.h"
#import "WXApi.h"
#import "ZITOPayAdapterProtocol.h"
#import "ZITOPayUtil.h"

@interface ZITOWXPayAdapter ()<ZITOPayAdapterDelegate, WXApiDelegate>

@end

@implementation ZITOWXPayAdapter

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static ZITOWXPayAdapter *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ZITOWXPayAdapter alloc]init];
    });
    return instance;
}

/*
 *register wx
 */
- (BOOL)registerWeChat:(NSString *)appid{
    return [WXApi registerApp:appid];
}

/*
 *handleOpenUrl
 */
- (BOOL)handleOpenUrl:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[ZITOWXPayAdapter sharedInstance]];
}

/*
 *Installed
 */
- (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}

- (BOOL)wxPay:(NSMutableDictionary *)dic{
    PayReq *request = [[PayReq alloc]init];
    request.partnerId = [dic stringValueForKey:@"partner_id" defaultValue:@""];
    request.prepayId = [dic stringValueForKey:@"prepay_id" defaultValue:@""];
    request.package = [dic stringValueForKey:@"package" defaultValue:@""];
    request.nonceStr = [dic stringValueForKey:@"nonce_str" defaultValue:@""];
    NSString *time = [dic stringValueForKey:@"timestamp" defaultValue:@""];
    request.timeStamp = time.intValue;
    request.sign = [dic stringValueForKey:@"pay_sign" defaultValue:@""];
    return [WXApi sendReq:request];
}

#pragma mark - Implementation WXApiDelegate

- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *tempResp = (PayResp *)resp;
        NSString *strMsg = nil;
        int errcode = 0;
        switch (tempResp.errCode) {
            case WXSuccess:
                strMsg = @"支付成功";
                errcode = ZITOErrCodeSuccess;
                break;
            case WXErrCodeUserCancel:
                strMsg = @"支付取消";
                errcode = ZITOErrCodeUserCancel;
                break;
            default:
                strMsg = @"支付失败";
                errcode = ZITOErrCodeSentFail;
                break;
        }
        NSString *result = tempResp.errStr.isValid?[NSString stringWithFormat:@"%@,%@",strMsg,tempResp.errStr]:strMsg;
        ZITOPayResp *resp = (ZITOPayResp *)[ZITOPayCache sharedInstance].ZITOResp;
        resp.resultCode = errcode;
        resp.resultMsg = result;
        resp.errDetail = result;
        [ZITOPayCache zitoPayDoResponse];
    }
}

@end
