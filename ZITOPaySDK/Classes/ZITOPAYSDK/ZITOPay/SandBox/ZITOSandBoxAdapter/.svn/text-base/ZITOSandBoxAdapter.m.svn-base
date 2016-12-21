//
//  ZITOSandBoxAdapter.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//


#import "ZITOSandboxAdapter.h"
#import "ZITOPayAdapterProtocol.h"
#import "ZITOPayUtil.h"
#import "ZITOPayCache.h"
#import "PaySandboxViewController.h"

@interface ZITOSandBoxAdapter () <ZITOPayAdapterDelegate>

@end

@implementation ZITOSandBoxAdapter

- (BOOL)sandboxPay {
    
    ZITOPayReq *req = (ZITOPayReq *)[ZITOPayCache sharedInstance].ZITOResp.request;
    
    if (req.viewController) {
        PaySandBoxViewController *view = [[PaySandBoxViewController alloc] init];
        [req.viewController presentViewController:view animated:YES completion:^{
        }];
        return YES;
    }
    return NO;
}

@end
