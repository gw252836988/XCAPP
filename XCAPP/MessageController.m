//
//  MessageController.m
//  XCAPP
//
//  Created by 新城集团 on 16-9-27.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "MessageController.h"
#import "HttpRequest.h"
#import "JsonDataCenter.h"
#import "FooterView.h"
#import "StaffCell.h"
#import "Tools.h"
@interface MessageController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSMutableArray  *staffArray;
@property(nonatomic,strong)FooterView * footerveiw;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,assign)BOOL IsSearchResult;
@end

@implementation MessageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.hidesBottomBarWhenPushed=YES;
    return self;
}

-(FooterView *)footerveiw
{
    if(!_footerveiw)
    {
        _footerveiw=[FooterView footView];
        
        [self.tableView addSubview:_footerveiw];
        
        
    }
    return _footerveiw;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setIsSearchResult:NO];
    [self setTitle:@"通讯录"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setPageIndex:1];
//    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn1.frame=CGRectMake(0, 70, 100, 30);
//    btn1.backgroundColor=[UIColor whiteColor];
//    [btn1 setTitle:@"PUSH" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(jumpTo) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    CGFloat navheight=rectStatus.size.height + rectNav.size.height;
    [self setSearchBar:[[UISearchBar alloc]initWithFrame:CGRectMake(0, navheight, CGRectGetWidth(self.view.bounds), 40)]];
    self.searchBar.delegate=self;
    self.searchBar.showsCancelButton=YES;
    navheight=navheight+40;
    
    [self setTableView:[[UITableView alloc]initWithFrame:CGRectMake(0, navheight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-navheight)] ];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StaffCell" bundle:nil] forCellReuseIdentifier:@"StaffCell"];
    [self.tableView setDataSource: self];
    
    [self.tableView  setDelegate:self];
    
   

    self.staffArray=[NSMutableArray array];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"默认" style:UIBarButtonItemStylePlain target:self action:@selector(DefaultShowData)];
    self.navigationItem.rightBarButtonItem=rightButton;
    //[self.view addSubview: btn1];
    [self LoadDataAndIsClearData:NO];
 
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGR.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPressGR];

       
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
        
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                     //   message:NSLocalizedString(@"isDeleteRecord", nil)
//                                                       delegate:self
//                                              cancelButtonTitle:NSLocalizedString(@"cancle", nil)
//                                              otherButtonTitles:NSLocalizedString(@"ok", nil),
                            //  nil];
        //alert.tag = kDeleteRecordAlertT;
        //[alert show];
        NSDictionary * dic=[self.staffArray objectAtIndex:[indexpath row]];
        NSString* mobile=[dic objectForKey:@"Mobile"];
           if ( ![Tools isBlankString:mobile]) {
            //    UIWebView *webView = [[UIWebView alloc]init];
        
//        
//              NSString *str = [NSString stringWithFormat:@"tel//%@",mobile];
//               NSURL *url = [NSURL URLWithString:str];
//               [webView loadRequest:[NSURLRequest requestWithURL:url ]];
//              [self.view addSubview:webView];
        
            
               UIWebView * callWebview = [[UIWebView alloc] init];
               [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:10010"]]];
               [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
               
               
    }
}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSDictionary * dic=[self.staffArray objectAtIndex:[indexPath row]];
    NSString* mobile=[dic objectForKey:@"Mobile"];
    
    if([Tools isBlankString:mobile])
        mobile=[dic objectForKey:@"LongMobile"];
    
    if ( ![Tools isBlankString:mobile]) {
        //    UIWebView *webView = [[UIWebView alloc]init];
        
        //
        //              NSString *str = [NSString stringWithFormat:@"tel//%@",mobile];
        //               NSURL *url = [NSURL URLWithString:str];
        //               [webView loadRequest:[NSURLRequest requestWithURL:url ]];
        //              [self.view addSubview:webView];
        
        
        UIWebView * callWebview = [[UIWebView alloc] init];
        NSString *str = [NSString stringWithFormat:@"tel:%@",mobile];

        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
        
        
    }}


-(void)DefaultShowData
{
    [self setPageIndex:1];
    [self LoadDataAndIsClearData:YES];
    [self.footerveiw setHidden:NO];
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //NSLog(@"seacheclicked");
    
    NSString* searchText=self.searchBar.text;
    if ([Tools isBlankString:searchText]==YES) {
        return;
        
    }
    
    NSDictionary *dic=[NSDictionary dictionaryWithObject:searchText forKey:@"Name"];
    
    [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/staffQ.ashx" parameters:dic success:^(id responseObject) {
        
        JsonDataCenter* dc=[[JsonDataCenter alloc] init];
        NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
        
        NSArray *arr=[dc getInfoArrayByDic:resultDic];
        [self.staffArray removeAllObjects];
        
        for (NSDictionary *dataDic in arr) {
            
            [self.staffArray addObject:dataDic];
        }
      
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self.footerveiw  refreshLocationByTableView:self.tableView];
            [self.footerveiw setHidden:YES];
            [self setIsSearchResult:YES];
            [self setPageIndex:1];
            
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
    
    [self.searchBar resignFirstResponder];
    self.searchBar.text=@"";
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchBar.text=@"";
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    return YES;
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    
    return YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.staffArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell *cell =[[UITableViewCell alloc]init];
//
//    
//    NSDictionary * dic=[self.staffArray objectAtIndex:indexPath.row];
//    NSString* name=[dic objectForKey:@"StaffName"];
//    cell.textLabel.text=name;
//    return cell;
    
    
    StaffCell * cell=[tableView dequeueReusableCellWithIdentifier:@"StaffCell"];
    NSDictionary * dic=[self.staffArray objectAtIndex:indexPath.row];
    cell.staffName.text=[dic objectForKey:@"StaffName"];
    cell.staffPhone.text=[dic objectForKey:@"Mobile"];
    cell.staffPosition.text=[dic objectForKey:@"PositionName"];
    cell.staffIcon.image=[UIImage imageNamed:@"stafficon"];
    cell.StaffId.text=[dic objectForKey:@"StaffId"];
;

   if([Tools isBlankString:cell.staffPhone.text])
     cell.staffPhone.text=[dic objectForKey:@"LongMobile"];
   
    cell.staffName.font=[UIFont systemFontOfSize:12];
    cell.staffPhone.font=[UIFont systemFontOfSize:12];
    cell.staffPosition.font=[UIFont systemFontOfSize:12];
    cell.StaffId.font=[UIFont systemFontOfSize:12];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.IsSearchResult==YES)return;
    CGFloat maxOffsetY = self.tableView.contentSize.height-self.tableView.frame.size.height;
    CGFloat footerViewHeight=CGRectGetHeight(self.footerveiw.frame);
    
    if(self.tableView.contentOffset.y >maxOffsetY && self.tableView.contentOffset.y<maxOffsetY+footerViewHeight)
    {
        
        [self.footerveiw setStatus:FootViewStatusDragging];
        
    }
    else if(self.tableView.contentOffset.y >=maxOffsetY +footerViewHeight && self.footerveiw.status!=FootViewStatusEndDragging)
    {
        
        [self.footerveiw setStatus:FootViewStatusReadyLoading];
        
    }
 
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.IsSearchResult==YES)return;
    if(self.footerveiw.status ==FootViewStatusReadyLoading)
    {
        [self.footerveiw setStatus:FootViewStatusEndDragging];
        [UIView animateWithDuration:0.2 animations:^
         {
             [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.footerveiw.bounds), 0)];
             
         }];
        [self LoadDataAndIsClearData:NO];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^
         {
             [self.tableView setContentInset:UIEdgeInsetsZero];
             
         }];
        
    }
    
    
}

-(void)LoadDataAndIsClearData:(BOOL) isClear
{
    NSString *index = [NSString stringWithFormat:@"%d",self.pageIndex];
    
    NSDictionary *dic=[NSDictionary dictionaryWithObject:index forKey:@"Index"];
                       
    [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/staff.ashx" parameters:dic success:^(id responseObject) {
        
        JsonDataCenter* dc=[[JsonDataCenter alloc] init];
        NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
        
        NSArray *arr=[dc getInfoArrayByDic:resultDic];
        
        if (isClear==YES) {
            [self.staffArray removeAllObjects];
        }
        for (NSDictionary *dataDic in arr) {
            
            [self.staffArray addObject:dataDic];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self.footerveiw  refreshLocationByTableView:self.tableView];
            [self setPageIndex:self.pageIndex+1];
            [self setIsSearchResult:NO];
            
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView1 heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0f;
//}
//
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
//        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
//        labelName= [[UILabel alloc] initWithFrame:CGRectMake(54, 5, 67, 22)];
//        labelPosition = [[UILabel alloc] initWithFrame:CGRectMake(129,5, 91, 21)];
//        labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(226, 5, 73, 21)];
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
//    labelName.text = @"姓名";
//    labelPosition.text= @"职位";
//    labelPhone.text=@"短号";
//    return headerView;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
