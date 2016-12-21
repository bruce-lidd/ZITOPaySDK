//
//  ZITOSubscription.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/23.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOSubscription.h"


@implementation ZITOSubscription

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZITOSubscription *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ZITOSubscription alloc] init];
    });
    return instance;
}

+ (void)setSubDelegate:(id<ZITOSubscriptionDelegate>)delegate {
    [ZITOSubscription sharedInstance].delegate = delegate;
}

+ (void)smsReq:(NSString *)phone {
    if (phone.isValidMobile) {
        NSMutableDictionary *params = [ZITOPayUtil prepareParametersForRequest];
        ZITOHTTPSessionManager *manager = [ZITOPayUtil getZITOHTTPSessionManager];
        
        params[@"phone"] = phone;
        [manager POST:[NSString stringWithFormat:@"%@/sms",subscription_host] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableDictionary *response = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)responseObject];
            response[@"type"] = @(ZITOSubTypeSMS);
            [ZITOSubscription doSubscriptionResponse:response];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ZITOSubscription doSubscriptionErrorResponse:kNetWorkError];
        }];
    }
}

+ (void)subscriptionBanks {
    
    NSMutableDictionary *params = [ZITOPayUtil prepareParametersForRequest];
    ZITOHTTPSessionManager *manager = [ZITOPayUtil getZITOHTTPSessionManager];
    
    [manager GET:[NSString stringWithFormat:@"%@/subscription_banks", subscription_host] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *response = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)responseObject];
        response[@"type"] = @(ZITOSubTypeBanks);
        [ZITOSubscription doSubscriptionResponse:response];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ZITOSubscription doSubscriptionErrorResponse:kNetWorkError];
    }];
}

+ (void)subscriptionCancel:(NSString *)sub_id {
    NSMutableDictionary *params = [ZITOPayUtil prepareParametersForRequest];
    ZITOHTTPSessionManager *manager = [ZITOPayUtil getZITOHTTPSessionManager];
    
    [manager DELETE:[NSString stringWithFormat:@"%@/subscription/%@", subscription_host,sub_id] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *response = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)responseObject];
        response[@"type"] = @(ZITOSubTypeSubscriptionCancel);
        [ZITOSubscription doSubscriptionResponse:response];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ZITOSubscription doSubscriptionErrorResponse:kNetWorkError];
    }];
}

+ (void)doSubscriptionErrorResponse:(NSString *)errMsg {
    NSMutableDictionary *resp = [NSMutableDictionary dictionaryWithCapacity:10];
    resp[@"resultCode"] = @(ZITOErrCodeCommon);
    resp[@"resultMsg"] = errMsg;
    resp[@"errDetail"] = errMsg;
    
    [ZITOSubscription doSubscriptionResponse:resp];
}

+ (void)doSubscriptionResponse:(NSMutableDictionary *)response {
    
    ZITOSubscription *shared = [ZITOSubscription sharedInstance];
    
    if (shared.delegate && [shared.delegate respondsToSelector:@selector(onZITOSubscriptionResp:)]) {
        [shared.delegate onZITOSubscriptionResp:response];
    }
}


@end

