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

+ (BOOL)ZITOPaySandboxPay {
    id adapter = [[NSClassFromString(kAdapterSandbox) alloc] init];
    if (adapter && [adapter respondsToSelector:@selector(sandboxPay)]) {
        return [adapter sandboxPay];
    }
    return NO;
}

@end
