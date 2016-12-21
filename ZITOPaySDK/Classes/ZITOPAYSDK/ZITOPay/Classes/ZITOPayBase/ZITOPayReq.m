//
//  ZITOPayReq.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOPayUtil.h"
#import "ZITOPayAdapter.h"
#import "ZITOPay.h"
#import "ZITOPayRequest.h"
#import "ZITOCategory.h"
#import <CommonCrypto/CommonDigest.h>
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
    
    NSMutableDictionary *parameters = [ZITOPayUtil prepareParametersForRequest:self.billNo totalFee:self.totalFee];
    if (parameters == nil) {
        [ZITOPayUtil doErrorResponse:@"请检查是否全局初始化"];
        return;
    }
    //通道编号
    parameters[@"gid"] = cType;
    parameters[@"totalPrice"] = self.totalFee;
    parameters[@"orderidinf"] = self.billNo;
    parameters[@"ordertitle"] = self.title;
    parameters[@"appid"] = [ZITOPayCache sharedInstance].appId;
    parameters[@"currency"] = self.currency;
    parameters[@"bgRetUrl"] = self.bgRetUrl;
    parameters[@"retUrl"] = self.retUrl;
    parameters[@"returnUrl"] = self.returnUrl;
    
    if(self.goodsname){
        parameters[@"goodsname"] = self.goodsname;
    }
    
    if (self.goodsdetail) {
        parameters[@"goodsdetail"] = self.goodsdetail;
    }
    
    if (self.optional) {
        parameters[@"optional"] = self.optional;
    }
    
    if (self.analysis) {
        parameters[@"analysis"] = self.analysis;
    }
    
    if (self.channel == PayChannelSumaQuick) {
        parameters[@"userIdIdentity"] =self.idCard;
    }
    __weak ZITOPayReq *weakSelf = self;
    
    if ( self.channel == PayChannelSumaQuick || self.channel == PayChannelChangQuick || self.channel == PayChannelBarCode || self.channel == PayChannelScanCode) {
        parameters[@"phone"] = @"1";
        [self doPayAction:parameters];
    }else{
        [ZITOPayRequest POST:@"" parameters:parameters currentMode:[ZITOPay getCurrentMode] resultBlock:^(id object) {
            if (object) {
                [weakSelf doPayAction:(NSDictionary *)object];
            }
            
        }];
    }
    
}


#pragma mark - Pay Action

- (BOOL)doPayAction:(NSDictionary *)response {
    BOOL ZSendPay = NO;
    if (response) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:
                                    (NSDictionary *)response];
        if (self.channel == PayChannelAliApp) {
            
            [dic setObject:self.scheme forKey:@"scheme"];
            
        }else if (self.channel == PayChannelApplePay || self.channel == PayChannelApplePayTest ||self.channel == PayChannelSumaQuick || self.channel == PayChannelChangQuick || self.channel == PayChannelYongYiUnion || self.channel == PayChannelJDUnion || self.channel == PayChannelBarCode || self.channel == PayChannelScanCode || self.channel == PayChannelFuQuickPay) {
            
            [dic setObject:self.viewController forKey:@"viewController"];
            
            if (self.channel == PayChannelApplePayTest || self.channel == PayChannelApplePay || self.channel == PayChannelYongYiUnion) {
                
                [dic setObject:@(self.channel) forKey:@"channel"];
                
            }
        }
        
        [ZITOPayCache sharedInstance].ZITOResp.ZITOId = [dic objectForKey:@"id"];
        
        switch (self.channel) {
            case PayChannelWxApp:
                ZSendPay = [ZITOPayAdapter ZITOPayWXPay:dic];
                break;
            case PayChannelWorthTechWXPay:
                if (dic[@"result"]) {
                    NSDictionary *resultDic = [ZITOPayUtil dictionaryWithJsonString:dic[@"result"]];
                    if (resultDic[@"prepayid"]) {
                        NSMutableDictionary *prepayidDic = [ZITOPayUtil dictionaryWithJsonString:resultDic[@"prepayid"]];
                        ZSendPay = [ZITOPayAdapter ZITOPayWXPay:prepayidDic];
                    }
            }
                break;
            case PayChannelAliApp:
                ZSendPay = [ZITOPayAdapter ZITOPayAliPay:dic];
                break;
            case PayChannelYongYiAliApp:
                ZSendPay = [ZITOPayAdapter ZITOPayYongYiUnionPay:dic];
                break;
            case PayChannelChangQuick:
                ZSendPay = [ZITOPayAdapter ZITOPayChanQuickPay:dic];
                break;
            case PayChannelSumaQuick:
                ZSendPay = [ZITOPayAdapter ZITOPaySumaQuickPay:dic];
                break;
            case PayChannelYongYiUnion:
                ZSendPay = [ZITOPayAdapter ZITOPayYongYiUnionPay:dic];
                break;
            case PayChannelJDUnion:
                ZSendPay = [ZITOPayAdapter ZITOPayJDUnionPay:dic];
                break;
            case PayChannelBarCode:
                ZSendPay = [ZITOPayAdapter ZITOPayBarCodePay:dic];
                break;
            case PayChannelScanCode:
                ZSendPay = [ZITOPayAdapter ZITOPayScanCodePay:dic];
            case PayChannelApplePay:
            case PayChannelApplePayTest:
                ZSendPay = [ZITOPayAdapter ZITOPayApplePay:dic];
                break;
            case PayChannelFuQuickPay:
                ZSendPay = [ZITOPayAdapter ZITOPayFuQuickPay:dic];
                break;
            default:
                break;
        }
    }
    return ZSendPay;
}
//test
-(NSString*)createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (  ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", @"f29cfcc03c4791f16081ed4d277e0f46"];
    //得到MD5 sign签名
    NSString *md5Sign =[ZITOPayUtil stringToMD5:contentString];
    return md5Sign;
}
- (NSString *)getTimeStmp{
    NSString* timeString = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    return timeString;
}
- (NSString *)getNoncestr:(NSString *)input
{
    const char* str = [input UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    
    NSMutableString* ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for(int i = 0 ;i <CC_MD5_DIGEST_LENGTH;i++) {

        [ret appendFormat:@"%02X",result[i]];
        
    }
    
    NSLog(@"%@",[ret uppercaseString]);
    return [ret uppercaseString];

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
