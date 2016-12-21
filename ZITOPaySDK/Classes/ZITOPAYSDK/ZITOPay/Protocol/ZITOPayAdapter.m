//
//  ZITOPayAdapter.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//


#import "ZITOPayAdapter.h"
#import "ZITOPayAdapterProtocol.h"
#import "ZITOPayCache.h"
#import "ZITOPayConfig.h"
#import "ZITOURLRequestSerialization.h"
@implementation ZITOPayAdapter

+ (BOOL)ZITOPayRegisterWeChat:(NSString *)appid {
    id adapter = [[NSClassFromString(kAdapterWXPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(registerWeChat:)]) {
        return [adapter registerWeChat:appid];
    }
    return NO;
}

+ (BOOL)ZITOPayIsWXAppInstalled {
    id adapter = [[NSClassFromString(kAdapterWXPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(isWXAppInstalled)]) {
        return [adapter isWXAppInstalled];
    }
    return NO;
}

+ (BOOL)ZITOPay:(NSString *)object handleOpenUrl:(NSURL *)url {
    id adapter = [[NSClassFromString(object) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(handleOpenUrl:)]) {
        return [adapter handleOpenUrl:url];
    }
    return NO;
}

+ (BOOL)ZITOPayWXPay:(NSMutableDictionary *)dic {
    id adapter = [[NSClassFromString(kAdapterWXPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(wxPay:)]) {
        return [adapter wxPay:dic];
    }
    return NO;
}

+ (BOOL)ZITOPayAliPay:(NSMutableDictionary *)dic {
    id adapter = [[NSClassFromString(kAdapterAliPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(aliPay:)]) {
        return [adapter aliPay:dic];
    }
    return NO;
}
+ (BOOL)ZITOPayApplePay:(NSMutableDictionary *)dic
{
    id adapter = [[NSClassFromString(kAdapterApplePay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(applePay:)]) {
        return [adapter applePay:dic];
    }
    return NO;
}

+ (BOOL)ZITOPaySumaQuickPay:(NSMutableDictionary *)dic
{
    NSMutableDictionary * tempDic = [[self class] getRequestData:dic];
    id adapter = [[NSClassFromString(kAdapterSumaPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(sumaPay:)]) {
        return [adapter sumaPay:tempDic];
    }
    return NO;
}
+(NSMutableDictionary *)getRequestData:(NSMutableDictionary *)dic
{
    NSString * jsonStr = ZITOQueryStringFromParameters(dic);
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
    ;
    NSString * urlStr = [ZITOPay getCurrentMode]?[NSString stringWithFormat:@"%@%@", kTESTZITOHost, kZITOURLAPI]:[NSString stringWithFormat:@"%@%@", kFORMALZITOHost, kZITOURLAPI];
    [tempDic setObject:urlStr forKey:@"urlStr"];
    [tempDic setObject:jsonStr forKey:@"jsonStr"];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    return tempDic;
}
+ (BOOL)ZITOPayChanQuickPay:(NSMutableDictionary *)dic
{
    NSMutableDictionary * tempDic = [[self class] getRequestData:dic];
    id adapter = [[NSClassFromString(kAdapterChanPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(chanPay:)]) {
        return [adapter chanPay:tempDic];
    }
    return NO;
}
+ (BOOL)ZITOPayYongYiUnionPay:(NSMutableDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *urlStr = [tempDic objectForKey:@"orderString"];
    [tempDic setObject:urlStr forKey:@"urlStr"];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    id adapter = [[NSClassFromString(kAdapterYongYiPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(yongyiPay:)]) {
        return [adapter yongyiPay:tempDic];
    }
    return NO;
}

+ (BOOL)ZITOPayFuQuickPay:(NSMutableDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic setObject:[tempDic objectForKey:@"formHtml"] forKey:@"formHtml"];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    id adapter = [[NSClassFromString(kAdapterFuQuickPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(fuQuickPay:)]) {
        return [adapter fuQuickPay:tempDic];
    }
    return NO;
}
+ (BOOL)ZITOPayJDUnionPay:(NSMutableDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [tempDic setObject:[tempDic objectForKey:@"formHtml"] forKey:@"formHtml"];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    id adapter = [[NSClassFromString(kAdapterJDPay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(jdPay:)]) {
        return [adapter jdPay:tempDic];
    }
    return NO;
}
+ (BOOL)ZITOPayBarCodePay:(NSMutableDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    id adapter = [[NSClassFromString(kAdapterBarCodePay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(barCodePay:)]) {
        return [adapter barCodePay:tempDic];
    }
    return NO;
}

+ (BOOL)ZITOPayScanCodePay:(NSMutableDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic setObject:dic[@"viewController"] forKey:@"viewController"];
    id adapter = [[NSClassFromString(kAdapterScanCodePay) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(scanCodePay:)]) {
        return [adapter scanCodePay:tempDic];
    }
    return NO;
}
@end
