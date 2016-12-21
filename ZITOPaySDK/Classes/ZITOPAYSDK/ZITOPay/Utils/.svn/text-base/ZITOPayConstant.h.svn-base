//
//  ZITOPayConstant.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#ifndef ZITOPayConstant_h
#define ZITOPayConstant_h

static NSString * const kApiVersion = @"1.0.0";//api版本号

static NSString * const kNetWorkError = @"网络请求失败";
static NSString * const kUnknownError = @"未知错误";
static NSString * const kKeyResponseResultCode = @"result_code";
static NSString * const kKeyResponseResultMsg = @"result_msg";
static NSString * const kKeyResponseErrDetail = @"err_detail";

static NSString * const kKeyResponseCodeUrl = @"code_url";
static NSString * const KKeyResponsePayResult = @"pay_result";
static NSString * const kKeyResponseRevertResult = @"revert_status";

static NSString * const kZITOHost = @"https://www.baidu.com";
static NSString * const kRestApiPay = @"%@%@/bill";

static NSString * const reqApiVersion = @"/2/rest";


//sandbox
static NSString * const kRestApiSandboxNotify = @"%@%@/notify/";

//Adapter
static NSString * const kAdapterWXPay = @"ZITOWXPayAdapter";
static NSString * const kAdapterAliPay = @"ZITOAliPayAdapter";
static NSString * const kAdapterSandbox = @"ZITOSandboxAdapter";

/**
 *  ZITOPay URL type for handling URLs.
 */
typedef NS_ENUM(NSInteger, ZITOPayUrlType) {
    /**
     *  Unknown type.
     */
    ZITOPayUrlUnknown,
    /**
     *  WeChat pay.
     */
    ZITOPayUrlWeChat,
    /**
     *  Alipay.
     */
    ZITOPayUrlAlipay
};


typedef NS_ENUM(NSInteger, PayChannel) {
    PayChannelNone = 0,
    PayChannelZITOApp,
    
    PayChannelWx = 10, //微信
    PayChannelWxApp,//微信APP
    
    PayChannelAli = 7,//支付宝
    PayChannelAliApp,//支付宝APP
    
    PayChannelUn = 30,//银联
    PayChannelUnApp,//银联APP
    PayChannelUnWeb,//银联网页
};

typedef NS_ENUM(NSInteger, ZITOErrCode) {
    ZITOErrCodeSuccess    = 0,    /**< 成功    */
    ZITOErrCodeCommon     = -1,   /**< 参数错误类型    */
    ZITOErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    ZITOErrCodeSentFail   = -3,   /**< 发送失败    */
    ZITOErrCodeUnsupport  = -4,   /**< ZITO不支持 */
};

typedef NS_ENUM(NSInteger, ZITOObjsType) {
    ZITOObjsTypeBaseReq = 100,
    ZITOObjsTypePayReq,
    ZITOObjsTypeQueryBillsReq,
    ZITOObjsTypeQueryBillByIdReq,
    ZITOObjsTypeQueryBillsCountReq,
    ZITOObjsTypeQueryRefundsReq,
    ZITOObjsTypeQueryRefundByIdReq,
    ZITOObjsTypeQueryRefundsCountReq,
    ZITOObjsTypeRefundStatusReq,
    ZITOObjsTypeOfflinePayReq,
    ZITOObjsTypeOfflineBillStatusReq,
    ZITOObjsTypeOfflineRevertReq,
    ZITOObjsTypePreRefundReq,
    ZITOObjsTypeAuthReq,
    
    ZITOObjsTypeBaseResp = 200,
    ZITOObjsTypePayResp,
    ZITOObjsTypeQueryBillsResp,
    ZITOObjsTypeQueryBillByIdResp,
    ZITOObjsTypeQueryBillsCountResp,
    ZITOObjsTypeQueryRefundsResp,
    ZITOObjsTypeQueryRefundByIdResp,
    ZITOObjsTypeQueryRefundsCountResp,
    ZITOObjsTypeRefundStatusResp,
    ZITOObjsTypeOfflinePayResp,
    ZITOObjsTypeOfflineBillStatusResp,
    ZITOObjsTypeOfflineRevertResp,
    ZITOObjsTypePreRefundResp,
    
    ZITOObjsTypeBaseResults = 300,
    ZITOObjsTypeBillResults,
    ZITOObjsTypeRefundResults,
    
    ZITOObjsTypePayPal = 400,
    ZITOObjsTypePayPalVerify,
    
};

typedef NS_ENUM(NSUInteger, BillStatus) {
    BillStatusAll, //所有支付订单
    BillStatusOnlySuccess,//支付成功的订单
    BillStatusOnlyFail //支付失败的订单
};

typedef NS_ENUM(NSUInteger, NeedApproval) {
    NeedApprovalAll,  //所有退款
    NeedApprovalOnlyTrue, //预退款
    NeedApprovalOnlyFalse //非预退款
};

static NSString * const kZITODateFormat = @"yyyy-MM-dd HH:mm";


#endif /* ZITOPayConstants_h */
