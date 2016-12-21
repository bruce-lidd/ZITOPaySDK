//
//  ZITOBaseResult.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOBaseResult.h"

@implementation ZITOBaseResult

- (instancetype) initWithResult:(NSDictionary *)dic {
    if (dic == nil) return nil;
    self = [super init];
    if (self) {
        self.type = ZITOObjsTypeBaseResults;
        
        self.objectId = [dic stringValueForKey:@"id" defaultValue:@""];
        self.billNo = [dic stringValueForKey:@"bill_no" defaultValue:@""];
        self.title = [dic stringValueForKey:@"title" defaultValue:@""];
        self.channel = [dic stringValueForKey:@"channel" defaultValue:@""];
        self.suZITOhannel = [dic stringValueForKey:@"sub_channel" defaultValue:@""];
        self.createTime = [dic longlongValueForKey:@"create_time" defaultValue:0];
        self.totalFee = [dic integerValueForKey:@"total_fee" defaultValue:0];
        //optional
        NSString *optionalString = [dic stringValueForKey:@"optional" defaultValue:@""];
        NSData *opData = [optionalString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        self.optional = [NSJSONSerialization JSONObjectWithData:opData options:NSJSONReadingAllowFragments error:&error];
        //messageDetail
        NSString *msgString = [dic stringValueForKey:@"message_detail" defaultValue:@""];
        NSData *msgData = [msgString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *msgError = nil;
        self.msgDetail = [NSJSONSerialization JSONObjectWithData:msgData options:NSJSONReadingAllowFragments error:&msgError];
    }
    return self;
}
@end
