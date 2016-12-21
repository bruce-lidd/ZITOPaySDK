//
//  ZITOQueryBillResult.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOQueryBillResult.h"

@implementation ZITOQueryBillResult
- (instancetype) initWithResult:(NSDictionary *)dic {
    self = [super initWithResult:dic];
    if (self) {
        self.type = ZITOObjsTypeBillResults;
        self.payResult = [dic boolValueForKey:@"spay_result" defaultValue:NO];
        self.tradeNo = [dic stringValueForKey:@"trade_no" defaultValue:@""];
        self.revertResult = [dic boolValueForKey:@"revert_result" defaultValue:NO];
        self.refundResult = [dic boolValueForKey:@"refund_result" defaultValue:NO];
    }
    return self;
}


@end
