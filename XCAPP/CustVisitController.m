//
//  CustVisitController.m
//  XCAPP
//
//  Created by 新城集团 on 2016/11/25.
//  Copyright © 2016年 新城集团. All rights reserved.
//

#import "CustVisitController.h"
#import "DropdownMenu.h"
#import "HttpRequest.h"
#import "JsonDataCenter.h"
#import "VisitCell.h"
#import "OrganCreator.h"

@interface CustVisitController ()<dropdownDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    ConditionDoubleTableView *tableView;
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rightArray;
}
@property(nonatomic,strong) UITableView  *contentView;
@property(nonatomic,strong)NSMutableArray *visitArray;
@property(nonatomic,strong)NSString* organSelected;
@property(nonatomic,strong)NSString* yearSelected;
@end

@implementation CustVisitController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.hidesBottomBarWhenPushed=YES;
    return self;
}


- (void)testData {
    [self testTitleArray];
    [self testLeftArray];
    [self testRightArray];
}

//每个下拉的标题
- (void) testTitleArray {
    _titleArray =[OrganCreator GetTitleArray];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)testLeftArray {
    //NSArray *One_leftArray = @[@"永兴", @"观音山", @"如东", @"海门", @"盐城",@"启东"];
    // NSArray *Two_leftArray = @[@"年份"];
    //    NSArray *R_leftArray = @[@"Test1", @"Test2"];
    
    
    _leftArray = [OrganCreator GetLeftArray];
}

- (void)testRightArray {
    
    
    _rightArray =[OrganCreator GetRightArray];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值
    
    [self setContentView:[[UITableView alloc]initWithFrame:CGRectMake(0, 104, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-104)] ];
    
    
    [self.contentView setDataSource:self];
    [self.contentView setDelegate:self];
    [self.contentView registerNib:[UINib nibWithNibName:@"VisitCell" bundle:nil] forCellReuseIdentifier:@"VisitCell"];
    
    [self.view addSubview:dropdown.view];
    [self.view addSubview:self.contentView];
    
    [self.view sendSubviewToBack:self.contentView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setOrganSelected:@""];
    [self setYearSelected:@""];
    self.navigationItem.title=@"客流量";
    self.visitArray =[NSMutableArray array];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.visitArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VisitCell * cell=[tableView1  dequeueReusableCellWithIdentifier:@"VisitCell"];
    NSDictionary * dic=[self.visitArray objectAtIndex:indexPath.row];
    //    cell.text=[dic objectForKey:@"StaffName"];
    //    cell.staffPhone.text=[dic objectForKey:@"Mobile"];
    //    cell.staffPosition.text=[dic objectForKey:@"PositionName"];
    //    cell.staffIcon.image=[UIImage imageNamed:@"stafficon"];
    NSInteger month=indexPath.item;
    month=month+1;
    cell.Month.text=[NSString stringWithFormat:@"%d月",month];
    cell.Count.text=[NSString stringWithFormat:@"%@:%@",@"来访数：",[dic objectForKey:@"num"]];
  
    
    cell.Month.font=[UIFont systemFontOfSize:12];
    cell.Count.font=[UIFont systemFontOfSize:12];
   
    
    return cell;
    
    
}

//实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedButtonIndex:(NSString *)index LeftIndex:(NSString *)left RightIndex:(NSString *)right {
    NSLog(@"%s : You choice button %@, left %@ and right %@", __FUNCTION__, index, left, right);
    
    //  NSString *index = [NSString stringWithFormat:@"%d",self.pageIndex];
    if ([index isEqualToString:@"0"])
    {
        [self setOrganSelected:[NSString stringWithFormat:@"%@%@",left,right]];
    }
    
    if ([index isEqualToString:@"1"])
    {
        [self setYearSelected:[NSString stringWithFormat:@"%@%@",left,right]];
        
        NSUInteger intLeft=[left integerValue];
        NSUInteger intRight=[right integerValue];
        
        
        NSArray *array=[_rightArray objectAtIndex:1];
        NSArray *array1 =[array objectAtIndex:intLeft];
        NSDictionary * dic1=[array1 objectAtIndex:intRight];
        
        NSString *value= [dic1 objectForKey:@"title"];
        [self setYearSelected:value];
    }
    
    if (![self.organSelected isEqualToString:@""] && ![self.yearSelected isEqualToString:@""])
        
    {
        
        NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:
                            self.organSelected, @"organ",
                            self.yearSelected, @"year",
                            
                            nil];
        //NSDictionary *dic=[NSDictionary dictionaryWithObject:index forKey:@"Index"];
        
        [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/custvisit.ashx" parameters:dic success:^(id responseObject) {
            
            JsonDataCenter* dc=[[JsonDataCenter alloc] init];
            NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
            
            NSArray *arr=[dc  getInfoArrayByDic:resultDic];
            [self.visitArray removeAllObjects];
            
            for (NSDictionary *dataDic in arr) {
                
                [self.visitArray addObject:dataDic];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.contentView reloadData];
                
                
                
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"error");
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
