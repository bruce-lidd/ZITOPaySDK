//
//  ZITOBaseResp.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ZITOPayConstant.h"
#import "ZITOBaseReq.h"

#pragma mark ZITOBaseResp
/**
 *  ZITO所有响应的基类,具体参考ZITOResponse目录
 */
@interface ZITOBaseResp : NSObject
/**
 *  响应的事件类型
 */
@property (nonatomic, assign) ZITOObjsType type;//200;
/**
 *  响应码,部分响应码请参考ZITOPayConstant.h/(Enum ZITOErrCode),默认为ZITOErrCodeCommon
 */
@property (nonatomic, assign) NSInteger resultCode;
/**
 *  响应提示字符串，默认为@""
 */
@property (nonatomic, retain) NSString *resultMsg;
/**
 *  错误详情,默认为@""
 */
@property (nonatomic, retain) NSString *errDetail;
/**
 *  请求体，具体参考ZITORequest目录
 */
@property (nonatomic, retain) ZITOBaseReq *request;
/**
 *  成功下单或者退款后返回的订单记录唯一标识;格式为UUID
 *  根据id查询支付或退款订单时,传入的ZITOId
 */
@property (nonatomic, retain) NSString *ZITOId;

/**
 *  初始化一个响应结构体
 *
 *  @param request 请求结构体
 *
 *  @return 响应结构体
 */
- (instancetype)initWithReq:(ZITOBaseReq *)request;

@end
