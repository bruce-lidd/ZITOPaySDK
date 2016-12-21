//
//  ZITOPayUtil.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.

#import "ZITOPayUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "ZITOPayCache.h"

@implementation ZITOPayUtil

+ (ZITOHTTPSessionManager *)getZITOHTTPSessionManager {
    ZITOHTTPSessionManager *manager = [ZITOHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = NO;
    manager.requestSerializer = [ZITOJSONRequestSerializer serializer];
    return manager;
}

+ (NSMutableDictionary *)getWrappedParametersForGetRequest:(NSDictionary *) parameters {
    NSData *parameterData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *parameterString = [[NSString alloc] initWithBytes:[parameterData bytes] length:[parameterData length]
                                                       encoding:NSUTF8StringEncoding];
    NSMutableDictionary *paramWrapper = [NSMutableDictionary dictionary];
    [paramWrapper setObject:parameterString forKey:@"para"];
    return paramWrapper;
}

+ (NSMutableDictionary *)prepareParametersForRequest:(ZITOPayReq *)payReq {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSNumber *posttime = [NSNumber numberWithLongLong:[ZITOPayUtil dateToMillisecond:[NSDate date]]];
    NSString *appSign = [ZITOPayUtil getAppSignature:payReq.username totalprice:payReq.totalFee];
    if(appSign) {
        [parameters setObject:[ZITOPayCache sharedInstance].appId forKey:@"id"];
        [parameters setObject:payReq.username forKey:@"username"];
        [parameters setObject:posttime forKey:@"posttime"];
        [parameters setObject:appSign forKey:@"sign"];
        return parameters;
    }
    return nil;
}

+ (NSString *)getAppSignature:(NSString *)username totalprice:(NSString *)totalprice{
    NSString *appid = [ZITOPayCache sharedInstance].appId;
    NSString *appsecret = [ZITOPayCache sharedInstance].appSecret;
    
    if (!appid.isValid || !appsecret.isValid)
        return nil;
    
    NSString *input = [appid stringByAppendingString:username];
    input = [input stringByAppendingString:totalprice];
    input = [input stringByAppendingString:appsecret];
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (ZITOPayUrlType)getUrlType:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"])
        return ZITOPayUrlAlipay;
    else if ([url.scheme hasPrefix:@"wx"] && [url.host isEqualToString:@"pay"])
        return ZITOPayUrlWeChat;
    else
        return ZITOPayUrlUnknown;
}

+ (NSString *)getBestHostWithFormat:(NSString *)format {
    NSString *verHost = [NSString stringWithFormat:@"%@%@", kZITOHost, reqApiVersion];
    return [NSString stringWithFormat:format, verHost, [ZITOPayCache sharedInstance].sandbox ? @"/sandbox" : @""];
}

+ (NSString *)getChannelNumString:(PayChannel)channel {
    NSString *cType = @"";
    switch (channel) {
#pragma mark PayChannel_WX
        case PayChannelWx:
            cType = @"WX";
            break;
        case PayChannelWxApp:
            cType = @"WX_APP";
            break;
#pragma mark PayChannel_ALI
        case PayChannelAli:
            cType = [NSString stringWithFormat:@"%ld",channel];
            break;
        case PayChannelAliApp:
            cType = @"ALI_APP";
            break;
        default:
            break;
    }
    return cType;
}

+ (NSString *)getChannelString:(PayChannel)channel {
    NSString *cType = @"";
    switch (channel) {
#pragma mark PayChannel_WX
        case PayChannelWx:
            cType = @"WX";
            break;
        case PayChannelWxApp:
            cType = @"WX_APP";
            break;
#pragma mark PayChannel_ALI
        case PayChannelAli:
            cType = @"ALI";
            break;
        case PayChannelAliApp:
            cType = @"ALI_APP";
            break;
        default:
            break;
    }
    return cType;
}

#pragma mark - Util Response

+ (ZITOBaseResp *)doErrorResponse:(NSString *)errMsg {
    ZITOBaseResp *resp = [ZITOPayCache sharedInstance].ZITOResp;
    resp.resultCode = ZITOErrCodeCommon;
    resp.resultMsg = errMsg;
    resp.errDetail = errMsg;
    [ZITOPayCache zitoPayDoResponse];
    return resp;
}

+ (ZITOBaseResp *)getErrorInResponse:(NSDictionary *)response {
    ZITOBaseResp *resp = [ZITOPayCache sharedInstance].ZITOResp;
    resp.resultCode = [response integerValueForKey:kKeyResponseResultCode defaultValue:ZITOErrCodeCommon];
    resp.resultMsg = [response stringValueForKey:kKeyResponseResultMsg defaultValue:kUnknownError];
    resp.errDetail = [response stringValueForKey:kKeyResponseErrDetail defaultValue:kUnknownError];
    [ZITOPayCache zitoPayDoResponse];
    return resp;
}

#pragma mark - Util
+ (NSString *)generateRandomUUID {
    return [[NSUUID UUID] UUIDString].lowercaseString;
}

+ (NSDate *)millisecondToDate:(long long)millisecond {
    return [NSDate dateWithTimeIntervalSince1970:((double)millisecond / 1000.0)];
}

+ (NSString *)millisecondToDateString:(long long)millisecond {
    return [ZITOPayUtil dateToString:[ZITOPayUtil millisecondToDate:millisecond]];
}

+ (long long)dateToMillisecond:(NSDate *)date {
    if (date == nil) return 0;
    return (long long)([date timeIntervalSince1970] * 1000.0);
}

+ (long long)dateStringToMillisecond:(NSString *)string {
    NSDate *dat = [ZITOPayUtil stringToDate:string];
    if (dat) return [ZITOPayUtil dateToMillisecond:dat];
    return 0;
}

+ (NSDate *)stringToDate:(NSString *)string {
    if (string == nil || string.length == 0) return nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kZITODateFormat];
    return [dateFormatter dateFromString:string];
}

+ (NSString *)dateToString:(NSDate *)date {
    if (date == nil) return nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kZITODateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringToMD5:(NSString *)string {
    if(string == nil || [string isEqualToString:@""]) return @"";
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),result );
    NSMutableString *hash =[NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash uppercaseString];
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidMobile:(NSString *)mobile {
    NSString *phoneRegex = @"^([0|86|17951]?(13[0-9])|(15[^4,\\D])|(17[678])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isLetter:(unichar)ch {
    return (BOOL)((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'));
}

+ (BOOL)isDigit:(unichar)ch {
    return (BOOL)(ch >= '0' && ch <= '9');
}

+ (NSUInteger)getBytes:(NSString *)str {
    if (!str.isValid) {
        return 0;
    } else {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData* da = [str dataUsingEncoding:enc];
        return [da length];
    }
}

@end

void ZITOPayLog(NSString *format,...) {
    if ([ZITOPayCache sharedInstance].willPrintLogMsg) {
        va_list list;
        va_start(list,format);
        NSLogv(format, list);
        va_end(list);
    }
}
