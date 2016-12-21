//
//  ZITOBaseResult.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ZITOPayConstant.h"
#import "NSDictionary+Utils.h"

#pragma mark ZITOBaseResult

/**
 *  订单查询结果的基类
 */
@interface ZITOBaseResult : NSObject
/**
 *  事件类型
 */
@property (nonatomic, assign) ZITOObjsType type;
/**
 *  订单记录id
 */
@property (nonatomic, retain) NSString *objectId;
/**
 *  发起支付时商户自定义的订单号
 */
@property (nonatomic, retain) NSString  *billNo;
/**
 *  订单支付金额，以分为单位
 */
@property (nonatomic, assign) NSInteger  totalFee;//NSInteger
/**
 *  订单标题
 */
@property (nonatomic, retain) NSString  *title;
/**
 *  订单创建时间
 */
@property (nonatomic, assign) long long  createTime;
/**
 *  支付主渠道(WX、ALI、UN、BD、PAYPAL),具体参考Enum PayChannel
 */
@property (nonatomic, retain) NSString  *channel;
/**
 *  支付子渠道，如WX_APP，WX_NATIVE, WX_JSAPI,具体参考Enum PayChannel
 */
@property (nonatomic, retain) NSString  *suZITOhannel;
/**
 *  商家自定义业务扩展参数
 */
@property (nonatomic, retain) NSDictionary *optional;
/**
 *  支付或者退款成功后渠道返回的详细信息
 */
@property (nonatomic, retain) NSDictionary *msgDetail;

/**
 *  初始化一个ZITOBaseResult实例
 *
 *  @param dic 订单信息
 *
 *  @return ZITOBaseResult实例
 */
- (instancetype) initWithResult:(NSDictionary *)dic;

@end


