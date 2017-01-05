//
//  SecondViewController.m
//  XCAPP
//
//  Created by 新城集团 on 16-9-27.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "OAController.h"
#import "MessageController.h"
#import "GridLayOut.h"
#import "UIButton+ImageTitleSpacing.h"

@interface OAController ()<UICollectionViewDataSource>
@property(nonatomic,strong)NSDictionary* dicIcon;
@end

@implementation OAController

static NSString * const CellIdentifier=@"Cell";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"THIRD"];
    
    
    GridLayOut * gridLayOut=[[GridLayOut alloc]init];
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:gridLayOut];
    [collectionView setDataSource:self];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    self.dicIcon=@{@"通讯录":@"maillist"};
    [self.view addSubview:collectionView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.dicIcon.count;
    
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // [cell setBackgroundColor:[UIColor orangeColor]];
    NSInteger tag=indexPath.item+1;
    UIButton *img=(UIButton *)[cell.contentView viewWithTag:tag];
    
    
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
    
    if(!img)
    {
        
        img=[UIButton buttonWithType:UIButtonTypeCustom];
        
        //img.image=[UIImage imageNamed:@"stafficon"];
        
        [cell.contentView addSubview:img];
    }
    CGFloat cellWidth=40;
    CGFloat originX=(CGRectGetWidth(cell.frame)-cellWidth)/2;
    CGFloat originY=(CGRectGetHeight(cell.frame)-cellWidth)/2;
    id key, value;
    NSArray *keys;
    keys = [self.dicIcon allKeys];
    key = [keys objectAtIndex: indexPath.item];
    value = [self.dicIcon objectForKey: key];
    
    NSString* strTitle=(NSString*)key;
    NSString* strIcon=(NSString*)value;
    
    img.frame=CGRectMake(originX, originY, cellWidth,cellWidth);
    [img setImage:[UIImage imageNamed:strIcon] forState:UIControlStateNormal];
    [img layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20.0];
    [img setTitle:strTitle forState:UIControlStateNormal];
    [img setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    img.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [img addTarget:self action:@selector(ImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [img setTag:tag];
    //[label setText:[NSString stringWithFormat:@"%zd",indexPath.item]];
    //[label sizeToFit];
    return cell;
    
}

-(void)ImageClicked:(UIButton *)button
{
    
    NSLog(@"%d",button.tag);
    
    switch (button.tag) {
        case 1:
        {
            MessageController *vc7=[[MessageController alloc]init];
            [self.navigationController pushViewController:vc7 animated:NO];
        }
            break;
            
        default:
            break;
    }
    
}


@end
