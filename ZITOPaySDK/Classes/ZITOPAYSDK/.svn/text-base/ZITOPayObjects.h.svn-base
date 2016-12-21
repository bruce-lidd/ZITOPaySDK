//
//  ZITOPayObjects.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#ifndef ZITOPayObjects_h
#define ZITOPayObjects_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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
    
    PayChannelAliApp = 7,//支付宝APP
    PayChannelWxApp,//微信APP
    PayChannelSumaQuick,//丰付快捷支付
    PayChannelSumaUnion,//丰付银联支付
    PayChannelChangQuick,//畅捷通快捷支付
    
    PayChannelYongYiUnion = 17,//甬易银联快捷支付
    
    
    PayChannelBarCode,//超级码支付
    PayChannelScanCode,//扫码支付
    
    PayChannelWorthTechWXPay = 28,//华势微信支付
    PayChannelYongYiAliApp = 29,//甬易支付宝app支付
    
    
    PayChannelFuQuickPay=34,//富友快捷支付
    PayChannelJDUnion,//京东银联快捷支付
    
    PayChannelUn = 40,//银联
    PayChannelUnApp,//银联APP
    PayChannelUnWeb,//银联网页
    
    PayChannelApplePay,//apple pay
    PayChannelApplePayTest,
    
   
};

typedef NS_ENUM(NSInteger, ZITOErrCode) {
    ZITOErrCodeSuccess    = 0,    /**< 成功    */
    ZITOErrCodeCommon     = -1,   /**< 参数错误类型    */
    ZITOErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    ZITOErrCodeSentFail   = -3,   /**< 发送失败    */
    ZITOErrCodeUnsupport  = -4,   /**< ZITO不支持 */
    ZITOErrCodeProcessing  = -5,   /**< 处理中 */
    ZITOErrCodePending = -6,   /**< 待处理 */
    ZITOErrCodeAwaitConfirm = -7,   /**< 待确认 */
};

typedef NS_ENUM(NSInteger, ZITOObjsType) {
    ZITOObjsTypeBaseReq = 100,
    ZITOObjsTypePayReq,
    
    ZITOObjsTypeBaseResp = 200,
    ZITOObjsTypePayResp,
    
    ZITOObjsTypePayPal = 400,
    ZITOObjsTypePayPalVerify,
    
};


/**
 *  所有请求事件的基类,具体请参考ZITORequest目录
 */
@interface ZITOBaseReq : NSObject
/**
 *  请求事件类型
 */
@property (nonatomic, assign) ZITOObjsType type;//100

@end

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

#pragma mark ZITOPayReq
/**
 *  Pay Request请求结构体
 */
@interface ZITOPayReq : ZITOBaseReq //type=101
/**
 *  支付渠道(WX,Ali,Union)
 */
@property (nonatomic, assign) PayChannel channel;
/**
 *  币种必填
 */
@property (nonatomic, retain) NSString *currency;

/**
 *  服务端验证安全的key。必填
 */
@property (nonatomic, retain) NSString *sign;
/**
 *  订单标题,32个字节内,最长16个汉字。选填
 */
@property (nonatomic, retain) NSString *title;
/**
 *  支付金额,以分为单位,必须为整数,必填
 */
@property (nonatomic, retain) NSString *totalFee;
/**
 *  商品名称,选填
 */
@property (nonatomic, retain) NSString *goodsname;
/**
 *  商品描述,选填
 */
@property (nonatomic, retain) NSString *goodsdetail;
/**
 *  后台回调，必填
 */
@property (nonatomic, retain) NSString *bgRetUrl;
/**
 *  后台回调，必填
 */
@property (nonatomic, retain) NSString *retUrl;
/**
 *  后台回调，必填
 */
@property (nonatomic, retain) NSString *returnUrl;
/**
 *  商户系统内部的订单号,8~32位数字和/或字母组合,确保在商户系统中唯一。必填
 */
@property (nonatomic, retain) NSString *billNo;
/**
 *  订单失效时间,必须为非零正整数，单位为秒，建议不小于300。选填
 */
@property (nonatomic, assign) NSInteger billTimeOut;
/**
 *  消费者身份证号,必填
 */
@property (nonatomic, retain) NSString * idCard;
/**
 *  调用支付的app注册在info.plist中的scheme,支付宝支付必填
 */
@property (nonatomic, retain) NSString *scheme;
/**
 *  银联支付或者Sandbox环境必填
 */
@property (nonatomic, retain) UIViewController *viewController;
/**
 *  Apple Pay必填，0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
 */
@property (nonatomic, assign) NSUInteger cardType;
/**
 *  扩展参数,可以传入任意数量的key/value对来补充对业务逻辑的需求;此参数会在webhook回调中返回;
 */
@property (nonatomic, retain) NSMutableDictionary *optional;
/**
 *  用于统计分析的数据
 */
@property (nonatomic, retain) NSMutableDictionary *analysis;

#pragma mark - Functions

/**
 *  发起支付(微信、支付宝、银联、百度钱包)
 */
- (void)payReq ;

/**
 *  检查支付参数
 *
 *  @return 参数合法返回YES
 */
- (BOOL)checkParametersForReqPay;

/**
 *  从ZITOPay服务端获取渠道支付参数，发起支付
 *
 *  @param response ZITOPay服务端返回的渠道支付参数
 *
 *  @return 发起渠道支付成功返回YES
 */
- (BOOL)doPayAction:(NSDictionary *)response;

@end

/**
 *  支付请求的响应
 */
@interface ZITOPayResp : ZITOBaseResp  //type=201;
/**
 *  部分渠道(Ali,Baidu)回调会返回一些信息。
 *  Ali是@{@"resultStatus":@"9000",
 @"memo": @"",
 @"result": @"partner="2088101568358171"&seller_id= "xxx@ZITO.cn"&out_trade_no="2015111712120048"&subject="test"&body="test"
 "&total_fee="0.01"&it_b_pay= "30m"&..."}
 *  Baidu是结构为@{@"orderInfo":@"...."};其中orderInfo对应的value为前台支付必须;
 */
@property (nonatomic, retain) NSDictionary *paySource;

@end

/*!
 This header file is *NOT* included in the public release.
 */

/**
 *  ZITOCache stores system settings and content caches.
 */
@interface ZITOPayCache : NSObject

/**
 *  App key obtained when registering this app in ZITO website;
 */
@property (nonatomic, retain) NSString *zitoId;
/**
 *  App key obtained when registering this app in ZITO website. Change this value via [ZITO setAppKey:];
 */
@property (nonatomic, retain) NSString *appId;

/**
 *  生产环境密钥
 */
@property (nonatomic, retain) NSString *appSecret;


/**
 *  YES表示沙箱环境，NO表示生产环境，产生真实交易
 *  默认为NO，生产环境
 */
@property (nonatomic, assign) BOOL sandbox;

/**
 *  PayPal client ID
 */
@property (nonatomic, retain) NSString *payPalClientID;

/**
 *  PayPal secret
 */
@property (nonatomic, retain) NSString *payPalSecret;

/**
 *  PayPal Sandbox Client ID
 */
@property (nonatomic, assign) BOOL isPayPalSandbox;


/**
 *  Default network timeout in seconds for all network requests. Change this value via [ZITO setNetworkTimeout:];
 */
@property (nonatomic) NSTimeInterval networkTimeout;

/**
 *  Mark whether print log message.
 */
@property (nonatomic, assign) BOOL willPrintLogMsg;

/**
 *  base response instance
 */
@property (nonatomic, strong) ZITOBaseResp *ZITOResp;

/**
 *  Get the sharedInstance of ZITOCache.
 *
 *  @return ZITOCache shared instance.
 */
+ (instancetype)sharedInstance;

/**
 *  ZITO response
 */
+ (BOOL)zitoPayDoResponse;

@end


#endif /* ZITOPayObjects_h */
