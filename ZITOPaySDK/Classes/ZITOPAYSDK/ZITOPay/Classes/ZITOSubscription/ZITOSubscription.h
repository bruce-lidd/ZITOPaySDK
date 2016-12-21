//
//  ZITOSubscription.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/23.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOBaseReq.h"
#import "ZITOPayUtil.h"

@protocol ZITOSubscriptionDelegate <NSObject>

- (void)onZITOSubscriptionResp:(NSMutableDictionary *)resp;

@end

static NSString * const subscription_host = @"https://apidynamic.beecloud.cn/2";

typedef NS_ENUM(NSInteger, ZITOSubType) {
    ZITOSubTypeSMS = 1,
    ZITOSubTypeBanks,
    
    ZITOSubTypeNewPlan = 10,
    ZITOSubTypePlans,
    ZITOSubTypePlansCount,
    
    ZITOSubTypeNewSubscription = 20,
    ZITOSubTypeSubscriptions,
    ZITOSubTypeSubscriptionsCount,
    ZITOSubTypeSubscriptionCancel
};

@interface ZITOSubscription : ZITOBaseReq

@property (nonatomic, weak) id<ZITOSubscriptionDelegate> delegate;

/**
 *  设置代理
 *
 *  @param delegate 代理
 */
+ (void)setSubDelegate:(id<ZITOSubscriptionDelegate>)delegate;
/**
 *  发送短信验证码
 *
 *  @param phone 手机号
 */
+ (void)smsReq:(NSString *)phone;
/**
 *  获取支持的银行列表
 */
+ (void)subscriptionBanks;
/**
 *  取消订阅
 *
 *  @param sub_id 订阅记录id
 */
+ (void)subscriptionCancel:(NSString *)sub_id;
/**
 *  返回请求结果
 *
 *  @param response 请求返回结果
 */
+ (void)doSubscriptionResponse:(NSMutableDictionary *)response;
/**
 *  请求出错返回结果
 *
 *  @param errMsg 返回请求出错结果
 */
+ (void)doSubscriptionErrorResponse:(NSString *)errMsg;


@end

