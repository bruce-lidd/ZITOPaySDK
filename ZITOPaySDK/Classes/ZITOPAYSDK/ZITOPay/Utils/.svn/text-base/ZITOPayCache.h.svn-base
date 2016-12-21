//
//  ZITOPayCache.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZITOBaseResp.h"
/*!
 This header file is *NOT* included in the public release.
 */

/**
 *  ZITOCache stores system settings and content caches.
 */
@interface ZITOPayCache : NSObject

/**
 *  App key obtained when registering this app in ZITO website. Change this value via [ZITO setAppKey:];
 */
@property (nonatomic, retain) NSString *appId;

/**
 *  生产环境密钥
 */
@property (nonatomic, retain) NSString *appSecret;

/**
 *  YES表示沙箱环境，不产生真实交易；NO表示生产环境，产生真实交易
 *  默认为NO，生产环境
 */
@property (nonatomic, assign) BOOL sandbox;

/**
 *  PayPal client ID
 */
@property (nonatomic, retain) NSString *payPalClientID;

/**
 *  PayPal secret
 */
@property (nonatomic, retain) NSString *payPalSecret;

/**
 *  PayPal Sandbox Client ID
 */
@property (nonatomic, assign) BOOL isPayPalSandbox;


/**
 *  Default network timeout in seconds for all network requests. Change this value via [ZITO setNetworkTimeout:];
 */
@property (nonatomic) NSTimeInterval networkTimeout;

/**
 *  Mark whether print log message.
 */
@property (nonatomic, assign) BOOL willPrintLogMsg;

/**
 *  base response instance
 */
@property (nonatomic, strong) ZITOBaseResp *ZITOResp;

/**
 *  Get the sharedInstance of ZITOCache.
 *
 *  @return ZITOCache shared instance.
 */
+ (instancetype)sharedInstance;

/**
 *  ZITO response
 */
+ (BOOL)zitoPayDoResponse;

@end
