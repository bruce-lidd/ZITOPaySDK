//
//  ZITOPayCache.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOPayCache.h"
#import "ZITOPayConstant.h"
#import "ZITOPay.h"

@implementation ZITOPayCache

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    __strong static ZITOPayCache *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ZITOPayCache alloc] init];
        
        instance.appId = nil;
        instance.appSecret = nil;
        instance.sandbox = NO;
        
        instance.payPalClientID = nil;
        instance.payPalSecret = nil;
        instance.isPayPalSandbox = NO;
        
        instance.ZITOResp = [[ZITOBaseResp alloc] init];
        
        instance.networkTimeout = 5.0;
        instance.willPrintLogMsg = NO;
        
    });
    return instance;
}

+ (BOOL)zitoPayDoResponse {
    id<ZITOPayDelegate> delegate = [ZITOPay getZITOPayDelegate];
    if (delegate && [delegate respondsToSelector:@selector(onZITOPayResp:)]) {
        [delegate onZITOPayResp:[ZITOPayCache sharedInstance].ZITOResp];
        return YES;
    }
    return NO;
}

@end
