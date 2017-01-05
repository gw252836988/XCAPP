//
//  JsonDataCenter.m
//  XCAPP
//
//  Created by 新城集团 on 16-9-28.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "JsonDataCenter.h"
#import "HttpRequest.h"
@implementation JsonDataCenter

-(NSDictionary * )isSuccessWithResponseObject:(id)responseObject
 {
     NSString * strStatus;
     NSInteger intStauts=1;
     
     
     NSDictionary *objc=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
     strStatus=[objc objectForKey:@"status"];
     
     intStauts=[strStatus intValue];
     if(intStauts==0)
         return objc;
     else
         return nil;
 }

-(NSDictionary *)getInfoDic:(NSDictionary*) data
{
    
    NSDictionary* dataDic =[data objectForKey:@"data"];
    
    return dataDic;
}

-(NSArray *)getInfoArrayByDic:(NSDictionary*) data
{
    
    NSDictionary* dataDic =[data objectForKey:@"data"];
    
    NSArray * lstStaff=[dataDic objectForKey:@"info"];
    
    return lstStaff;
}


@end
