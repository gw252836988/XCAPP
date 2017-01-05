//
//  CarCreator.m
//  XCAPP
//
//  Created by 新城集团 on 2016/11/21.
//  Copyright © 2016年 新城集团. All rights reserved.
//

#import "CarCreator.h"

@implementation CarCreator
+(NSArray*)GetTitleArray
{
    NSArray * tmp= @[@"门店", @"车系"];
    return tmp;
    
}

+(NSArray *)GetLeftArray
{
    NSArray *One_leftArray = @[@"永兴", @"观音山", @"如东", @"海门", @"盐城",@"启东"];
    NSArray *Two_leftArray = @[@"别克", @"雪佛兰",@"大众",@"荣威",@"广汽丰田",@"一汽丰田",@"广本",@"宝马",@"奔驰"];
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
                                   @{@"title":@"全部"},
                                  @{@"title":@"GL8"},
                                  @{@"title":@"昂科雷"},
                                  @{@"title":@"昂科威"},
                                  @{@"title":@"昂科拉"},
                                  @{@"title":@"君威"},
                                  @{@"title":@"君越"},
                                  @{@"title":@"威朗"},
                                  @{@"title":@"凯越"},
                                  @{@"title":@"英朗"}
                                 ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"创酷"},
                                   @{@"title":@"科鲁兹"},
                                   @{@"title":@"科帕奇"},
                                   @{@"title":@"乐风"},
                                   @{@"title":@"迈锐宝"},
                                   @{@"title":@"赛欧"},
                                   @{@"title":@"科沃兹"}
                                  
                                   ],
                              
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"CC"},
                                   @{@"title":@"高尔夫"},
                                   @{@"title":@"捷达"},
                                   @{@"title":@"迈腾"},
                                   @{@"title":@"速腾"},
                                   @{@"title":@"宝来"},
                                   @{@"title":@"蔚领"}
                                   
                                   ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"350"},
                                   @{@"title":@"550"},
                                   @{@"title":@"750"},
                                   @{@"title":@"950"},
                                   @{@"title":@"W5"},
                                   @{@"title":@"360"},
                                   @{@"title":@"RX5"}
                                   
                                   ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"汉兰达"},
                                   @{@"title":@"凯美瑞"},
                                   @{@"title":@"雷凌"},
                                   @{@"title":@"雅力士"},
                                   @{@"title":@"逸致"},
                                   @{@"title":@"致炫"},
                                   @{@"title":@"埃尔法"}
                                   
                                   ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"RAV4"},
                                   @{@"title":@"花冠"},
                                   @{@"title":@"皇冠"},
                                   @{@"title":@"卡罗拉"},
                                   @{@"title":@"普拉多"},
                                   @{@"title":@"锐志"},
                                   @{@"title":@"威驰"}
                                   
                                   ],
                          
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"CITY"},
                                   @{@"title":@"奥德赛"},
                                   @{@"title":@"宝来"},
                                   @{@"title":@"缤智"},
                                   @{@"title":@"飞度"},
                                   @{@"title":@"锋范"},
                                   @{@"title":@"歌诗图"},
                                   @{@"title":@"理念"},
                                   @{@"title":@"凌派"},
                                   @{@"title":@"雅阁"}
                                ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"1系"},
                                   @{@"title":@"2系"},
                                   @{@"title":@"3系"},
                                   @{@"title":@"4系"},
                                   @{@"title":@"5系"},
                                   @{@"title":@"6系"},
                                   @{@"title":@"7系"},
                                   @{@"title":@"X1"},
                                   @{@"title":@"X3"},
                                   @{@"title":@"X4"},
                                   @{@"title":@"X5"},
                                   @{@"title":@"X6"}
                                   ],
                               @[
                                    @{@"title":@"全部"},
                                   @{@"title":@"A级"},
                                   @{@"title":@"B级"},
                                   @{@"title":@"C级"},
                                   @{@"title":@"E级"},
                                   @{@"title":@"S级"},
                                   @{@"title":@"R级"},
                                   @{@"title":@"CLA"},
                                   @{@"title":@"GLC"},
                                   @{@"title":@"GLE"}
                                   
                                 
                                   ]

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
