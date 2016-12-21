//
//  ZITOQueryRefundResult.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOQueryRefundResult.h"

@implementation ZITOQueryRefundResult
- (instancetype) initWithResult:(NSDictionary *)dic {
    self = [super initWithResult:dic];
    if (self) {
        self.type = ZITOObjsTypeRefundResults;
        if (dic) {
            self.refundNo = [dic stringValueForKey:@"refund_no" defaultValue:@""];
            self.refundFee = [dic integerValueForKey:@"refund_fee" defaultValue:0];
            self.finish = [dic boolValueForKey:@"finish" defaultValue:NO];
            self.result = [dic boolValueForKey:@"result" defaultValue:NO];
        }
    }
    return self;
}

@end
