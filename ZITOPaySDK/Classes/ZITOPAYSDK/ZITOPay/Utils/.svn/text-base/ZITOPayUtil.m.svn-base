//
//  ZITOPayUtil.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.

#import "ZITOPayUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "ZITOPayCache.h"
#import <UIKit/UIKit.h>
#import "ZITOPayConfig.h"
#import "ZITOCategory.h"
@implementation ZITOPayUtil

+ (ZITOHTTPSessionManager *)getZITOHTTPSessionManager {
    ZITOHTTPSessionManager *manager = [ZITOHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:NO];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    manager.responseSerializer = [ZITOJSONResponseSerializer serializer];
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

+ (NSMutableDictionary *)prepareParametersForRequest:(NSString *)billNo totalFee:(NSString *)totalFee {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *posttime = [ZITOPayUtil dateToString:[NSDate date]];
    NSString *appSign = [ZITOPayUtil getAppSignature:billNo totalprice:totalFee];
    if(appSign) {
        [parameters setObject:[ZITOPayCache sharedInstance].zitoId forKey:@"id"];
        [parameters setObject:billNo forKey:@"billNo"];
        [parameters setObject:posttime forKey:@"posttime"];
        [parameters setObject:appSign forKey:@"sign"];
        return parameters;
    }
    return nil;
}

+ (NSString *)getAppSignature:(NSString *)billNo totalprice:(NSString *)totalprice{
    NSString *zitoId = [ZITOPayCache sharedInstance].zitoId;
    NSString *appid = [ZITOPayCache sharedInstance].appId;
    NSString *appsecret = [ZITOPayCache sharedInstance].appSecret;
    
    if (!appid.isValid || !appsecret.isValid)
        return nil;
    
    NSString *input = [zitoId stringByAppendingString:appid];
    input = [input stringByAppendingString:billNo];
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

+ (NSString *)getBestHostWithFormat:(NSString *)format currentMode:(BOOL)currentMode{
    //    return [NSString stringWithFormat:format, verHost, [ZITOPayCache sharedInstance].sandbox ? @"/sandbox" : @""];
    if (currentMode) {
        return [NSString stringWithFormat:@"%@%@", kTESTZITOHost, kZITOAPI];
    }else{
        return [NSString stringWithFormat:@"%@%@", kFORMALZITOHost, kZITOAPI];
    }
}

+ (NSString *)getChannelNumString:(PayChannel)channel {
    return  [NSString stringWithFormat:@"%ld",(long)channel];
}

+ (NSString *)getChannelString:(PayChannel)channel {
    NSString *cType = @"";
    switch (channel) {
#pragma mark PayChannel_WX
        case PayChannelWxApp:
            cType = @"WX_APP";
            break;
#pragma mark PayChannel_ALI
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

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (BOOL)checkCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if(!jsonString){
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    return dic;
}


#pragma mark - 从bundle文件夹读取图片
+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName {
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ZITOPay.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
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


