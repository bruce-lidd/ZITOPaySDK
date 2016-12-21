//
//  ZITOPayReq.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//


#import "ZITOPayReq.h"
#import "ZITOPayUtil.h"
#import "ZITOPayAdapter.h"
#import "ZITOPay.h"
#pragma mark pay request

@implementation ZITOPayReq

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = ZITOObjsTypePayReq;
        self.channel = PayChannelNone;
        self.title = @"";
        self.totalFee = @"";
        self.billNo = @"";
        self.scheme = @"";
        self.viewController = nil;
        self.cardType = 0;
        self.billTimeOut = 0;
    }
    return self;
}

- (void)payReq {
    [ZITOPayCache sharedInstance].ZITOResp = [[ZITOPayResp alloc] initWithReq:self];
    
    if (![self checkParametersForReqPay]) return;
    
    NSString *cType = [ZITOPayUtil getChannelNumString:self.channel];
    
    NSMutableDictionary *parameters = [ZITOPayUtil prepareParametersForRequest:self];
    if (parameters == nil) {
        [ZITOPayUtil doErrorResponse:@"请检查是否全局初始化"];
        return;
    }
    //通道编号
    parameters[@"gid"] = cType;
    parameters[@"totalPrice"] = [NSNumber numberWithInteger:[self.totalFee integerValue]];
    parameters[@"orderidinf"] = self.billNo;
    parameters[@"ordertitle"] = self.title;
    
    if(self.goodsname){
        parameters[@"goodsname"] = self.goodsname;
    }
    
    if (self.goodsdetail) {
        parameters[@"goodsdetail"] = self.goodsdetail;
    }
    
    //后台回调暂时没用先写为test
    if (self.bgRetUrl) {
        parameters[@"bgRetUrl"] = @"test";
    }
    
//    if (self.billTimeOut > 0) {
//        parameters[@"bill_timeout"] = @(self.billTimeOut);
//    }
    
    if (self.optional) {
        parameters[@"optional"] = self.optional;
    }
    
    if (self.analysis) {
        parameters[@"analysis"] = self.analysis;
    }
    __weak ZITOPayReq *weakSelf = self;
    
    [ZITOPayRequest POST:kRestApiPay parameters:parameters resultBlock:^(id object) {
        if ([ZITOPayCache sharedInstance].sandbox) {
            [weakSelf doPayActionInSandbox:(NSDictionary *)object];
        } else {
            [weakSelf doPayAction:(NSDictionary *)object];
        }
    }];
}

#pragma mark - Pay Action

- (BOOL)doPayAction:(NSDictionary *)response {
    BOOL bSendPay = NO;
    if (response) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:
                                    (NSDictionary *)response];
        if (self.channel == PayChannelAliApp) {
            
            [dic setObject:self.scheme forKey:@"scheme"];
            
        }
        [ZITOPayCache sharedInstance].ZITOResp.ZITOId = [dic objectForKey:@"id"];
        switch (self.channel) {
            case PayChannelWxApp:
                bSendPay = [ZITOPayAdapter ZITOPayWXPay:dic];
                break;
            case PayChannelAliApp:
                bSendPay = [ZITOPayAdapter ZITOPayAliPay:dic];
                break;
            default:
                break;
        }
    }
    return bSendPay;
}

- (BOOL)doPayActionInSandbox:(NSDictionary *)response {
    
    if (response) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:
                                    (NSDictionary *)response];
        [ZITOPayCache sharedInstance].ZITOResp.ZITOId = [dic objectForKey:@"id"];
        [ZITOPayAdapter ZITOPaySandboxPay];
        return YES;
    }
    return NO;
}

- (BOOL)checkParametersForReqPay {
    if (!self.title.isValid || [ZITOPayUtil getBytes:self.title] > 32) {
        [ZITOPayUtil doErrorResponse:@"title 必须是长度不大于32个字节,最长16个汉字的字符串的合法字符串"];
        return NO;
    } else if (!self.totalFee.isValid || !self.totalFee.isPureFloat) {
        [ZITOPayUtil doErrorResponse:@"totalFee 以元为单位，必须是只包含数值的字符串"];
        return NO;
    } else if (!self.billNo.isValid || !self.billNo.isValidTraceNo || (self.billNo.length < 8) || (self.billNo.length > 32)) {
        [ZITOPayUtil doErrorResponse:@"billNo 必须是长度8~32位字母和/或数字组合成的字符串"];
        return NO;
    } else if ((self.channel == PayChannelAliApp) && !self.scheme.isValid) {
        [ZITOPayUtil doErrorResponse:@"scheme 不是合法的字符串，将导致无法从支付宝钱包返回应用"];
        return NO;
    }  else if ([ZITOPay getCurrentMode] && (self.viewController == nil)) {
        [ZITOPayUtil doErrorResponse:@"viewController 不合法，将导致无法正常执行银联支付"];
        return NO;
    } else if ((self.channel == PayChannelWxApp && ![ZITOPayAdapter ZITOPayIsWXAppInstalled]) && ![ZITOPay getCurrentMode]) {
        [ZITOPayUtil doErrorResponse:@"未找到微信客户端，请先下载安装"];
        return NO;
    }
    return YES;
}

@end
