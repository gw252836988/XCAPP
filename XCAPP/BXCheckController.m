//
//  BXCheckController.m
//  XCAPP
//
//  Created by 新城集团 on 2016/11/17.
//  Copyright © 2016年 新城集团. All rights reserved.
//

#import "BXCheckController.h"
#import "SPCell.h"
#import "HttpRequest.h"
#import "JsonDataCenter.h"
#import "AppDelegate.h"
@interface BXCheckController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView  *contentView;
@property(nonatomic,strong) NSMutableArray  *spArray;
@end

@implementation BXCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    CGFloat navheight=rectStatus.size.height + rectNav.size.height;
    // Do any additional setup after loading the view.
    [self setContentView:[[UITableView alloc]initWithFrame:CGRectMake(0, navheight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))] ];
    [self.contentView setDataSource:self];
    [self.contentView setDelegate:self];
    [self.contentView registerNib:[UINib nibWithNibName:@"SPCell" bundle:nil] forCellReuseIdentifier:@"SPCell"];
    
    [self.view addSubview:self.contentView];
    self.navigationItem.title=@"我的报销单";
    
    self.spArray=[NSMutableArray array];
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *dic=[NSDictionary dictionaryWithObject:appDelegate.UserId forKey:@"staffid"];
    
    [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/bxQ.ashx" parameters:dic success:^(id responseObject) {
        
        JsonDataCenter* dc=[[JsonDataCenter alloc] init];
        NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
        
        NSArray *arr=[dc getInfoArrayByDic:resultDic];
        
        
        for (NSDictionary *dataDic in arr) {
            
            [self.spArray addObject:dataDic];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.contentView reloadData];
            
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.spArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
    NSDictionary * dic=[self.spArray objectAtIndex:indexPath.row];
    cell.Title.text=[dic objectForKey:@"hdsqname"];
    cell.Sqtime.text=[dic objectForKey:@"editime"];
    NSString* status=[dic objectForKey:@"ok3"];
    if([status isEqualToString:@"t1"])
        status=@"同意";
    else
        status=@"未审核";
    cell.Status.text=status;
    cell.Title.font=[UIFont systemFontOfSize:12];
    cell.Sqtime.font=[UIFont systemFontOfSize:12];
    cell.Status.font=[UIFont systemFontOfSize:12];

    return cell;
    
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.hidesBottomBarWhenPushed=YES;
    return self;
}

/**
 <#Description#>

 @param tableView1 <#tableView1 description#>
 @param section <#section description#>
 @return <#return value description#>
 */
//- (CGFloat)tableView:(UITableView *)tableView1 heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0f;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSDictionary * dic=[self.spArray objectAtIndex:[indexPath row]];
//    NSString* mobile=[dic objectForKey:@"hdsqname"];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:NSLocalizedString(mobile, nil)
//                                                   delegate:self
//                                          cancelButtonTitle:nil
//                                          otherButtonTitles:NSLocalizedString(@"关闭", nil),
//                          nil];
//    [alert show];
//    
//}

//-(UIView *)tableView:(UITableView *)tableView1 viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *headerSectionID = @"headerSectionID";
//    UITableViewHeaderFooterView *headerView = [tableView1 dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
//    UILabel *labelName;
//    UILabel *labelPosition;
//    UILabel *labelPhone;
//    if (headerView == nil) {
//        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
//        //         NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SaleCell" owner:self options:nil];
//        //         SaleCell *tmpView = [nib objectAtIndex:0];
//        //         tmpView.month.text=@"月份";
//        // [headerView addSubview:tmpView];
//        headerView = [[UITableViewHeaderFooterView alloc]
//                      initWithReuseIdentifier:headerSectionID];
//     
//        labelName= [[UILabel alloc] initWithFrame:CGRectMake(22, 5, 123, 21)];
//        labelPosition = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 98, 21)];
//        labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(282, 5, 70, 21)];
//        
//        labelName.font=[UIFont systemFontOfSize:12];
//        labelPosition.font=[UIFont systemFontOfSize:12];
//        labelPhone.font=[UIFont systemFontOfSize:12];
//        
//        [headerView addSubview:labelName];
//        [headerView addSubview:labelPosition];
//        [headerView addSubview:labelPhone];
//    }
//    
//    labelName.text = @"标题";
//    labelPosition.text= @"申请时间";
//    labelPhone.text=@"董事长审批";
//    //self.navigationItem.title=@"我的报销单";
//    
//    return headerView;
//}

@end
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
