//
//  OrganCreator.m
//  XCAPP
//
//  Created by 新城集团 on 16-11-3.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "OrganCreator.h"

@implementation OrganCreator


+(NSArray*)GetTitleArray
{
    NSArray * tmp= @[@"门店", @"日期"];
    return tmp;
    
}

+(NSArray *)GetLeftArray
{
    NSArray *One_leftArray = @[@"永兴", @"观音山", @"如东", @"海门", @"盐城",@"启东"];
    NSArray *Two_leftArray = @[@"年份"];
    //    NSArray *R_leftArray = @[@"Test1", @"Test2"];
    
    
    NSArray * tmp = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray, nil];
    return  tmp;
    
}

+(NSArray *)GetRightArray
{
    NSArray *F_rightArray = @[
                              @[
                                  @{@"title":@"别克(YX)"},
                                  @{@"title":@"一汽大众"},
                                  @{@"title":@"荣威(YX)"}
                                  
                                  ] ,
                              @[
                                  @{@"title":@"荣威(GYS)"},
                                  @{@"title":@"一汽丰田"},
                                  @{@"title":@"雪佛兰(GYS)"},
                                  @{@"title":@"广汽丰田"},
                                  @{@"title":@"北京现代"}
                                  
                                  ],
                              @[
                                  @{@"title":@"雪佛兰(RD)"},
                                  @{@"title":@"荣威(RD)"},
                                  @{@"title":@"广汽本田(RD)"},
                                  @{@"title":@"名爵"}
                                  ],
                              @[
                                  @{@"title":@"别克(HM)"},
                                  @{@"title":@"广汽本田(HM)"},
                                  @{@"title":@"雪佛兰(HM)"}
                                  
                                  ],
                              @[
                                  @{@"title":@"别克(YC)"}
                                  
                                  ],
                              @[
                                  @{@"title":@"宝马"}
                                  
                                  ]
                              
                              ]
    
    ;
    
    NSArray *S_rightArray = @[
                              @[
                                  @{@"title":@"2016"},
                                  @{@"title":@"2015"},
                                  @{@"title":@"2014"}
                                  ]
                              //                              @[
                              //                                  @{@"title":@"four"}
                              //                                  ]
                              ];
    
    
    //
    //    NSMutableArray* tmpArray=[NSMutableArray array];
    //    for( int i=0; i<2; i++)
    //    {
    //        NSMutableArray* tmpArray1=[NSMutableArray array];
    //
    //        for (NSInteger j=1; j<13; j++) {
    //             NSMutableDictionary* tmpDic=[NSMutableDictionary dictionary];
    //             NSString *month = [NSString stringWithFormat:@"%d月",j];
    //             [tmpDic setObject:month forKey:@"title" ];
    //             [tmpArray1 addObject:tmpDic];
    //        }
    //        [tmpArray addObject:tmpArray1];
    //
    //    }
    //    NSArray *S_rightArray=[tmpArray copy];
    
    NSArray * tmp= [[NSArray alloc] initWithObjects:F_rightArray, S_rightArray, nil];
    return tmp;
}


@end
