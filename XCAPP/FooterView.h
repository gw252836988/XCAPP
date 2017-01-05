//
//  FooterView.h
//  MyTest
//
//  Created by 新城集团 on 16-9-20.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    FootViewStatusDragging,
    FootViewStatusReadyLoading,
    FootViewStatusEndDragging

} FootViewStatus;
@interface FooterView : UIView
@property(nonatomic,assign)FootViewStatus status;
-(void)refreshLocationByTableView:(UITableView *)tableview;
+(instancetype)footView;
@end
