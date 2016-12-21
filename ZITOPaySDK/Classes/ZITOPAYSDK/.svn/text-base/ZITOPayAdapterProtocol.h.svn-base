//
//  ZITOPayAdapterProtocol.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#ifndef ZITOPayAdapterProtocol_h
#define ZITOPayAdapterProtocol_h

#import <Foundation/Foundation.h>
#import "ZITOPay.h"


@protocol ZITOPayAdapterDelegate <NSObject>

@optional
/*
 *注册微信代理方法
 *param appid
 */
- (BOOL)registerWeChat:(NSString *)appid;
/*
 *是否安装微信app
 *param no
 */
- (BOOL)isWXAppInstalled;
/*
 *处理回调通道的url
 *param url
 */
- (BOOL)handleOpenUrl:(NSURL *)url;
/*
 *微信支付代理方法
 *param dic
 */
- (BOOL)wxPay:(NSMutableDictionary *)dic;
/*
 *支付宝支付代理方法
 *param dic
 */
- (BOOL)aliPay:(NSMutableDictionary *)dic;
- (BOOL)sandboxPay;
- (BOOL)canMakeApplePayments:(NSUInteger)cardType;

/*
 *apple支付代理方法
 *param dic
 */
- (BOOL)applePay:(NSMutableDictionary *)dic;
/*
 *summPay支付代理方法
 *param dic
 */
- (BOOL)sumaPay:(NSMutableDictionary *)dic;
/*
 *chanPay支付代理方法
 *param dic
 */
- (BOOL)chanPay:(NSMutableDictionary *)dic;
/*
 *yongyiPay支付代理方法
 *param dic
 */
- (BOOL)yongyiPay:(NSMutableDictionary *)dic;
/*
 *fuQuickPay支付代理方法
 *param dic
 */
- (BOOL)fuQuickPay:(NSMutableDictionary *)dic;
/*
 *jdPay支付代理方法
 *param dic
 */
- (BOOL)jdPay:(NSMutableDictionary *)dic;
/*
 *barCodePay支付代理方法
 *param dic
 */
- (BOOL)barCodePay:(NSMutableDictionary *)dic;
/*
 *scanCodePay支付代理方法
 *param dic
 */
- (BOOL)scanCodePay:(NSMutableDictionary *)dic;
@end

#endif
