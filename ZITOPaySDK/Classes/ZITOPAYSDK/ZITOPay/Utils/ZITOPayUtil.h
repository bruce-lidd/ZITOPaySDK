//
//  ZITOPayUtil.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import "ZITONetworking.h"
#import "ZITOPayCache.h"
#import "ZITOPayObjects.h"

@interface ZITOPayUtil : NSObject

/** @name util functions*/

/*!
 A wrapper for ZITOHTTPSessionManager.
 */
+ (ZITOHTTPSessionManager *)getZITOHTTPSessionManager;

/**
 *  Get wrapped parameters in the format of "para" to a map for GET REST APIs.
 *
 *  @param parameters map
 *
 *  @return new map
 */
+ (NSMutableDictionary *)getWrappedParametersForGetRequest:(NSDictionary *) parameters;

/**
 *  prepare parameters
 *
 */
+ (NSMutableDictionary *)prepareParametersForRequest:(NSString *)billNo totalFee:(NSString *)totalFee;

/**
 *  生成签名
 *
 *  @param username 用户名
 *  @param totalprice 单价金额
 *
 *  @return 签名
 */
+ (NSString *)getAppSignature:(NSString *)username totalprice:(NSString *)totalprice;

/**
 *  获取url的类型，微信或者支付宝
 *
 *  @param url 渠道返回的url
 *
 *  @return 微信或者支付宝
 */
+ (ZITOPayUrlType)getUrlType:(NSURL *)url;

/**
 *  getBestHost
 *
 *  @param format url
 *
 *  @return url
 */
+ (NSString *)getBestHostWithFormat:(NSString *)format currentMode:(BOOL)currentMode;

/**
 *  get Channel String
 *
 *  @param channel enum PayChannel
 *
 *  @return Channel String
 */
+ (NSString *)getChannelNumString:(PayChannel)channel;

/**
 *  get Channel String
 *
 *  @param channel enum PayChannel
 *
 *  @return Channel String
 */
+ (NSString *)getChannelString:(PayChannel)channel;

/**
 *  执行错误回调
 *
 *  @param errMsg 错误信息
 */
+ (ZITOBaseResp *)doErrorResponse:(NSString *)errMsg;

/**
 *  服务端返回错误，执行错误回调
 *
 *  @param response 服务端返回参数
 */
+ (ZITOBaseResp *)getErrorInResponse:(NSDictionary *)response;

#pragma mark Util Functions
/**
 *  Generate a random UUID in the format of "550e8400-e29b-41d4-a716-446655440000", in lower case.
 *
 *  @return The generated UUID string in lower case.
 */
+ (NSString *)generateRandomUUID;

/**
 *  Convert int64 (long long) value of millisecond to NSDate.
 *
 *  @param millisecond Millisecond in int64 (long long).
 *
 *  @return NSDate object converted to.
 */
+ (NSDate *)millisecondToDate:(long long)millisecond;

/**
 *  Convert int64 (long long) value of millisecond to @"yyyy-MM-dd HH:mm".
 *
 *  @param millisecond Millisecond in int64 (long long).
 *
 *  @return NSDate object converted to.
 */
+ (NSString *)millisecondToDateString:(long long)millisecond;

/**
 *  Convert NSDate to int64 (long long) for the value of millisecond.
 *
 *  @param date NSDate object to be converted.
 *
 *  @return Number of milliseconds in the format of 1400000000000.
 */
+ (long long)dateToMillisecond:(NSDate *)date;

/**
 *  Convert date String @"yyyy-MM-dd HH:mm" to int64 (long long) for the value of millisecond.
 *
 *  @param string NSDate object to be converted.
 *
 *  @return Number of milliseconds in the format of 1400000000000.
 */
+ (long long)dateStringToMillisecond:(NSString *)string;

/**
 *  Converts a string in the format of "2014-02-25 14:27" to NSDate.
 *
 *  @param string The date string with format defined in kZITODateFormat.
 *
 *  @return NSDate object converted to.
 */
+ (NSDate *)stringToDate:(NSString *)string;

/**
 *  Converts a NSDate to a string in the format of "2014-02-25 14:27:44.037 GMT-08:00", where the time zone corresponds
 *  to your local timezone.
 *
 *  @param date NSDate object to be converted.
 *
 *  @return The date string with format defined in kZITODateFormat.
 */
+ (NSString *)dateToString:(NSDate *)date;

/**
 *  Converts a common string to MD5.
 *
 *  @param string common string.
 *
 *  @return MD5 string.
 */
+ (NSString *)stringToMD5:(NSString *)string;

/**
 *  check the email.
 *
 *  @param email email.
 *
 *  @return YES if it is valid.
 */
+ (BOOL)isValidEmail:(NSString *)email;

/**
 *  check the mobile number
 *
 *  @param mobile mobile number
 *
 *  @return YES if it is valid
 */
+ (BOOL)isValidMobile:(NSString *)mobile;

/**
 *  Check whether a unichar is a letter 'a' to 'z' or 'A' to 'Z'.
 *
 *  @param ch Character of type unichar to be checked.
 *
 *  @return YES if it is a letter; NO otherwise.
 */
+ (BOOL)isLetter:(unichar)ch;

/**
 *  Check whether a unichar is a digit '0' to '9'.
 *
 *  @param ch Character of type unichar to be checked.
 *
 *  @return YES if is a digit; NO otherwise.
 */
+ (BOOL)isDigit:(unichar)ch;

/**
 *  A string's bytes
 *
 *  @param str string
 *
 *  @return the string's bytes
 */
+ (NSUInteger)getBytes:(NSString *)str;

/**
 *  A string's bytes
 *
 *  @param dic string
 *
 *  @return the string's bytes
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 * 将二进制颜色转换成rgb
 *param color :二进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 * 校验银行卡
 *param cardNo :银行卡号
 */
+ (BOOL)checkCardNo:(NSString*)cardNo;
/**
 * @brief 把格式化的JSON格式字符串转成字典
 * @param jsonString :JSON格式的字符串
 * @return 返回字典
 */
+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 * 从bundle资源文件夹获取图片
 * @param imgName : 图片名称
 * @return 返回图片
 */
+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;
@end

FOUNDATION_EXPORT void ZITOPayLog(NSString *format,...) NS_FORMAT_FUNCTION(1,2) ;