//
//  ZITOPayRequest.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/23.
//  Copyright © 2016年 ldd. All rights reserved.
//
#import "ZITOPayUtil.h"
#import <Foundation/Foundation.h>
typedef void (^ResultBlock)(id object);
@interface ZITOPayRequest : NSObject
/**
 *  SharedInstance
 *
 *  @return SharedInstance
 */
+ (instancetype)sharedInstance;
+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
                   currentMode:(BOOL)currentMode
                   resultBlock:(ResultBlock)resultBlock;

@end
