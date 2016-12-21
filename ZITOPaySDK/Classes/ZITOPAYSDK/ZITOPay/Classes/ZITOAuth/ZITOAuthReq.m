//
//  ZITOAuthReq.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/22.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ZITOAuthReq.h"

@implementation ZITOAuthReq

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = ZITOObjsTypeAuthReq;
        self.name = @"";
        self.idNo = @"";
    }
    return self;
}

+ (void)authReqWithName:(NSString *)name idNo:(NSString *)idNo {
    [[ZITOAuthReq alloc] authReqWithName:name idNo:idNo];
}

- (void)authReqWithName:(NSString *)name idNo:(NSString *)idNo {
    self.name = name;
    self.idNo = idNo;
    [self authReq];
}

- (void)authReq {
    
    NSMutableDictionary *parameters = [ZITOPayUtil prepareParametersForRequest];
    if (parameters == nil) {
        [ZITOPayUtil doErrorResponse:@"请检查是否全局初始化"];
        return;
    }
    if (!self.name.isValid) {
        [ZITOPayUtil doErrorResponse:@"姓名错误"];
        return;
    }
    if (!self.idNo.isValid) {
        [ZITOPayUtil doErrorResponse:@"身份证号错误"];
        return;
    }
    parameters[@"name"] = self.name;
    parameters[@"id_no"] = self.idNo;
    
    ZITOHTTPSessionManager *manager = [ZITOPayUtil getZITOHTTPSessionManager];
    
    [manager POST:[NSString stringWithFormat:@"%@/2/auth", kZITOHost] parameters:parameters progress:nil
          success:^(NSURLSessionTask *task, id response) {
              [ZITOPayUtil getErrorInResponse:(NSDictionary *)response];
          } failure:^(NSURLSessionTask *operation, NSError *error) {
              [ZITOPayUtil doErrorResponse:kNetWorkError];
          }];
    
}

@end
