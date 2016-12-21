//
//  ZITOBaseResp.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOBaseResp.h"

#pragma mark base response
@implementation ZITOBaseResp

- (instancetype)initWithReq:(ZITOBaseReq *)request {
    self = [super init];
    if (self) {
        self.type = ZITOObjsTypeBaseResp;
        self.request = request;
        self.resultCode = ZITOErrCodeCommon;
        self.resultMsg = @"";
        self.errDetail = @"";
    }
    return self;
}
@end
