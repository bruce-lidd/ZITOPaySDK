//
//  ZITOPay+Utils.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOPay+Utils.h"
#import "ZITOPayAdapter.h"
@implementation ZITOPay (Utils)


#pragma mark Pay Request

- (void)reqPay:(ZITOPayReq *)req {
    [req payReq];
}

@end
