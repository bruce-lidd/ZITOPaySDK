//
//  ZITOPayRequest.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/23.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOPayRequest.h"
#import "ZITOPayConfig.h"

@implementation ZITOPayRequest

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZITOPayRequest *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ZITOPayRequest alloc] init];
    });
    return instance;
}
+ (void)POST:(NSString *)hostStr parameters:(id)parameters currentMode:(BOOL)currentMode resultBlock:(ResultBlock)resultBlock;
{
    NSString * urlString = [ZITOPayUtil getBestHostWithFormat:hostStr currentMode:currentMode];
    ZITOHTTPSessionManager *manager = [ZITOPayUtil getZITOHTTPSessionManager];
    
    [manager POST:urlString parameters:parameters progress:nil
          success:^(NSURLSessionTask *task, id response) {
              NSDictionary * dic = (NSDictionary *)response;
              if ([[response valueForKey:@"return_code"] isEqualToString:@"success"]) {
                  NSDictionary *tempDic = [dic objectForKey:@"result_data"];
                  resultBlock(tempDic);
              } else {
                [ZITOPayUtil doErrorResponse:[dic objectForKey:@"return_msg"]];
              }
          } failure:^(NSURLSessionTask *operation, NSError *error) {
              [ZITOPayUtil doErrorResponse:kNetWorkError];
          }];
}

@end
