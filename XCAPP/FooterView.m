//
//  FooterView.m
//  MyTest
//
//  Created by 新城集团 on 16-9-20.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "FooterView.h"

@interface FooterView()

@property(nonatomic,strong) UILabel *statusLabel;

@end


@implementation FooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+(instancetype)footView
{
    FooterView * footviewer=[[self alloc]init];
    //[footviewer setBackgroundColor:[UIColor blackColor]];
    [footviewer setStatusLabel:[[UILabel alloc]init]];
    [footviewer.statusLabel setText:@"上拉加载更多......"];
    [footviewer.statusLabel setTextColor:[UIColor blackColor]];
    [footviewer.statusLabel setTextAlignment:NSTextAlignmentCenter];
    [footviewer addSubview:footviewer.statusLabel];
    return footviewer;
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView *tableview=( UITableView *)newSuperview;
    [self setFrame:CGRectMake(0, tableview.contentSize.height, CGRectGetWidth(tableview.bounds), 40)];
    [self.statusLabel setFrame:self.bounds];
    
}

-(void)refreshLocationByTableView:(UITableView *)tableview
{
    [self setStatus:FootViewStatusDragging];
    [self setFrame:CGRectMake(0, tableview.contentSize.height, CGRectGetWidth(tableview.bounds), 40)];
    [self.statusLabel setFrame:self.bounds];
    
}

-(void)setStatus:(FootViewStatus)status
{
    _status=status;
    switch (status) {
        case FootViewStatusDragging:
        {
              [self.statusLabel setText:@"上拉加载更多....."];
            break;
        }
        case FootViewStatusReadyLoading:
        {
            [self.statusLabel setText:@"松手加载更多....."];
            break;
        }
        case FootViewStatusEndDragging:
        {
            [self.statusLabel setText:@"加载中....."];
            break;
        }
            
            
        default:
            break;
    }
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
