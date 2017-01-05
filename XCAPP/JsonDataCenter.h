//
//  JsonDataCenter.h
//  XCAPP
//
//  Created by 新城集团 on 16-9-28.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonDataCenter : NSObject
-(NSDictionary * )isSuccessWithResponseObject:(id)responseObject ;

-(NSArray *)getInfoArrayByDic:(NSDictionary*) data;
-(NSDictionary *)getInfoDic:(NSDictionary*) data;
@end
