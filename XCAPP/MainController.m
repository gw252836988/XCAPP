//
//  MainController.m
//  XCAPP
//
//  Created by 新城集团 on 16-11-1.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "MainController.h"
#import "GridLayOut.h"
#import "UIButton+ImageTitleSpacing.h"
#import "MessageController.h"
#import "SReportController.h"
#import "XRCarouselView.h"
#import "AReportController.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "SPCheckController.h"
#import "BXCheckController.h"
#import "CarStockController.h"
#import "CustVisitController.h"
#import "MyRepsController.h"
#import "MySalesController.h"
@interface MainController ()<UINavigationControllerDelegate>
{
    CGFloat cellHeight;
    
}
@property(nonatomic,strong)NSDictionary* dicIcon;
@property(nonatomic,assign)CGFloat imgWidth;
@property (nonatomic, strong) XRCarouselView *carouselView;

@end

@implementation MainController
static NSString * const CellIdentifier=@"Cell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)doClickLeftAction:(id)object
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setImgWidth:50];
    CGFloat rowY=180;
    cellHeight=60;
    CGRect imgRect;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
     AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    //self.navigationItem.leftBarButtonItem.title=appDelegate.UserName;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]
                                          initWithTitle:@"登录"
                                          style:UIBarButtonItemStylePlain
                                          target:self
                                          action:@selector(doClickLeftAction:)];
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]
                                          initWithTitle:appDelegate.UserName
                                          style:UIBarButtonItemStylePlain
                                          target:self
                                          action:nil];
    self.navigationItem.rightBarButtonItem =rightBarButtonItem;

    float topHeight=rectStatus.size.height + rectNav.size.height;
    
     rowY=rowY+10;
    imgRect=[self OriginYOfImage:rowY RowOfImage:0];
   
    [self RectOfImage:imgRect NameOfImage:@"contact" TextOfImage:@"通讯录" TagOfImage:1];
    
    imgRect=[self OriginYOfImage:rowY RowOfImage:1];
    [self RectOfImage:imgRect NameOfImage:@"check" TextOfImage:@"申请单" TagOfImage:4];
    
    imgRect=[self OriginYOfImage:rowY RowOfImage:2];
    [self RectOfImage:imgRect NameOfImage:@"bx" TextOfImage:@"报销单" TagOfImage:5];
    
    rowY=rowY+cellHeight+20;
    imgRect=[self OriginYOfImage:rowY RowOfImage:0];
    [self RectOfImage:imgRect NameOfImage:@"salereport" TextOfImage:@"销售报表" TagOfImage:2];
    
    imgRect=[self OriginYOfImage:rowY RowOfImage:1];
    [self RectOfImage:imgRect NameOfImage:@"repreport" TextOfImage:@"售后报表" TagOfImage:3];
    
    imgRect=[self OriginYOfImage:rowY RowOfImage:2];
    [self RectOfImage:imgRect NameOfImage:@"car" TextOfImage:@"车辆库存" TagOfImage:6];

    imgRect=[self OriginYOfImage:rowY RowOfImage:3];
    [self RectOfImage:imgRect NameOfImage:@"visitors" TextOfImage:@"客流量" TagOfImage:7];
    
    
    rowY=rowY+cellHeight+20;
    imgRect=[self OriginYOfImage:rowY RowOfImage:0];
    [self RectOfImage:imgRect NameOfImage:@"myrep" TextOfImage:@"我的接车" TagOfImage:8];
    
    
    imgRect=[self OriginYOfImage:rowY RowOfImage:1];
    [self RectOfImage:imgRect NameOfImage:@"mysale" TextOfImage:@"我的销售" TagOfImage:9];
    
    
    NSArray *arr = @[
                       @"http://221.130.108.114:8082/XCAPI/1.jpg",//网络图片
                     @"http://221.130.108.114:8082/XCAPI/2.jpg",//本地图片，传image，不能传名称
                    //本地gif使用gifImageNamed(name)函数创建
                     ];

    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, topHeight, [UIScreen mainScreen].bounds.size.width, 120)];
    
    _carouselView.imageArray = arr;
    _carouselView.time = 2;
    [_carouselView setDescribeTextColor:nil font:nil bgColor:nil];
    [self.view addSubview:_carouselView];

    self.navigationController.delegate = self;
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:bar];
    
}

//#pragma mark - UINavigationControllerDelegate
//// 将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}


-(void) RectOfImage:(CGRect)rect NameOfImage:(NSString *)strName   TextOfImage:(NSString*) strText  TagOfImage:(NSInteger) tag

{
    UIButton *img=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width=CGRectGetWidth(self.view.bounds)/4;
    CGFloat offset=(width-self.imgWidth)/2;
    img.frame=CGRectMake(rect.origin.x+offset, rect.origin.y
                          +offset, self.imgWidth, self.imgWidth);
    [img setImage:[UIImage imageNamed:strName] forState:UIControlStateNormal];
   [img layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5.0];
    [img setTitle:strText forState:UIControlStateNormal];
    img.titleLabel.font = [UIFont systemFontOfSize: 10.0];
  
    [img setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [img setTag:tag];
    [img addTarget:self action:@selector(ImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: img];
    
}
-(void)ImageClicked:(UIButton *)button
{
    
   // NSLog(@"%d",button.tag);
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (button.tag) {
        case 1:
        {
            MessageController *vc7=[[MessageController alloc]init];
          
            [self.navigationController pushViewController:vc7 animated:NO];
        }
            break;
            
        case 2:
        {
            
            if([appDelegate.PosiName containsString:@"经理"] || [appDelegate.PosiName containsString:@"总"])
            {
                SReportController *vc2=[[SReportController alloc]init];
                [self.navigationController pushViewController:vc2 animated:NO];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                   message:NSLocalizedString(@"您无此权限", nil)
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:NSLocalizedString(@"确定", nil),
                  nil];
            
                [alert show];
                
            }
           break;
        }

        case 3:
        {
            
            
            
            
            if([appDelegate.PosiName containsString:@"经理"] || [appDelegate.PosiName containsString:@"总"])
            {
                
                AReportController *vc3=[[AReportController alloc]init];
                [self.navigationController pushViewController:vc3 animated:NO];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:NSLocalizedString(@"您无此权限", nil)
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:NSLocalizedString(@"确定", nil),
                                      nil];
                
                [alert show];
                
            }
            break;
        }
            
        case 4:
        {
            
            SPCheckController *vc4=[[SPCheckController alloc]init];
            [self.navigationController pushViewController:vc4 animated:NO];
            break;
        }
        case 5:
        {
            
            BXCheckController *vc5=[[BXCheckController alloc]init];
            [self.navigationController pushViewController:vc5 animated:NO];
            break;
        }
        case 6:
        {
            
            CarStockController *vc6=[[CarStockController alloc]init];
            [self.navigationController pushViewController:vc6 animated:NO];
            break;
        }
            
        case 7:
        {
            
            CustVisitController *vc8=[[CustVisitController alloc]init];
            [self.navigationController pushViewController:vc8 animated:NO];
            break;
        }
            
        case 8:
        {
            
            MyRepsController *vc9=[[MyRepsController alloc]init];
            [self.navigationController pushViewController:vc9 animated:NO];
            break;
        }
            
        case 9:
        {
            
            MySalesController *vc10=[[MySalesController alloc]init];
            [self.navigationController pushViewController:vc10 animated:NO];
            break;
        }
        default:
            break;
    }
    
}
-(CGRect)OriginYOfImage:(CGFloat)OriginY  RowOfImage:(NSInteger) Row
{
    
    CGFloat width=CGRectGetWidth(self.view.bounds)/4;
    CGFloat OriginX=Row*width;
    return  CGRectMake(OriginX, OriginY,width, cellHeight);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
