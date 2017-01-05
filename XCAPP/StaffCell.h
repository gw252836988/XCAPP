//
//  StaffCell.h
//  XCAPP
//
//  Created by 新城集团 on 16-9-29.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *staffName;
@property (weak, nonatomic) IBOutlet UILabel *staffPhone;
@property (weak, nonatomic) IBOutlet UIImageView *staffIcon;
@property (weak, nonatomic) IBOutlet UILabel *staffPosition;
@property (weak, nonatomic) IBOutlet UILabel *StaffId;

@end
