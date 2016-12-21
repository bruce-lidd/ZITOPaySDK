//
//  ZITOPayAdapter.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZITOPayAdapter : NSObject
+ (BOOL)ZITOPayRegisterWeChat:(NSString *)appid;
+ (BOOL)ZITOPayIsWXAppInstalled;
+ (BOOL)ZITOPay:(NSString *)object handleOpenUrl:(NSURL *)url;

+ (BOOL)ZITOPayWXPay:(NSMutableDictionary *)dic;
+ (BOOL)ZITOPayAliPay:(NSMutableDictionary *)dic;
+ (BOOL)ZITOPaySandboxPay;
+ (BOOL)ZITOPayCanMakeApplePayments:(NSUInteger)cardType;



@end
