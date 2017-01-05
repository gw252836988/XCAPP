//
//  CarStockController.m
//  XCAPP
//
//  Created by 新城集团 on 2016/11/21.
//  Copyright © 2016年 新城集团. All rights reserved.
//

#import "CarStockController.h"
#import "HttpRequest.h"
#import "JsonDataCenter.h"
#import "CarCell.h"
#import "CarCreator.h"
#import "DropdownMenu.h"
@interface CarStockController ()<dropdownDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    ConditionDoubleTableView *tableView;
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rightArray;
    
    
}
@property(nonatomic,strong) UITableView  *contentView;
@property(nonatomic,strong)NSMutableArray *carArray;
@property(nonatomic,strong)NSString* organSelected;
@property(nonatomic,strong)NSString* carserSelected;
@end

@implementation CarStockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值
    
    [self setContentView:[[UITableView alloc]initWithFrame:CGRectMake(0, 104, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-104)] ];
    
    
    [self.contentView setDataSource:self];
    [self.contentView setDelegate:self];
    [self.contentView registerNib:[UINib nibWithNibName:@"CarCell" bundle:nil] forCellReuseIdentifier:@"CarCell"];
    
    [self.view addSubview:dropdown.view];
    [self.view addSubview:self.contentView];
    
    [self.view sendSubviewToBack:self.contentView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
       self.navigationItem.title=@"车辆库存";
    self.carArray =[NSMutableArray array];
    
    [self setCarserSelected:@""];
    [self setOrganSelected:@""];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)testData {
    [self testTitleArray];
    [self testLeftArray];
    [self testRightArray];
}

//每个下拉的标题
- (void) testTitleArray {
    _titleArray =[CarCreator GetTitleArray];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)testLeftArray {
    //NSArray *One_leftArray = @[@"永兴", @"观音山", @"如东", @"海门", @"盐城",@"启东"];
    // NSArray *Two_leftArray = @[@"年份"];
    //    NSArray *R_leftArray = @[@"Test1", @"Test2"];
    
    
    _leftArray = [CarCreator GetLeftArray];
    
    
}

- (void)testRightArray {
    
    
    _rightArray =[CarCreator GetRightArray];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.carArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarCell * cell=[tableView1  dequeueReusableCellWithIdentifier:@"CarCell"];
    NSDictionary * dic=[self.carArray objectAtIndex:indexPath.row];
    //    cell.text=[dic objectForKey:@"StaffName"];
    //    cell.staffPhone.text=[dic objectForKey:@"Mobile"];
    //    cell.staffPosition.text=[dic objectForKey:@"PositionName"];
    //    cell.staffIcon.image=[UIImage imageNamed:@"stafficon"];
 
    cell.CarSer.text=[dic objectForKey:@"carser"];
    cell.CarModel.text=[dic objectForKey:@"carmodel"];
    cell.CarColor.text=[dic objectForKey:@"color"];
    cell.Transmission.text=[dic objectForKey:@"Transmission"];
   
    
    
    cell.CarSer.font=[UIFont systemFontOfSize:12];
    cell.CarModel.font=[UIFont systemFontOfSize:12];
    cell.CarColor.font=[UIFont systemFontOfSize:12];
    cell.Transmission.font=[UIFont systemFontOfSize:12];
    
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
        //[self setCarserSelected:[NSString stringWithFormat:@"%@%@",left,right]];
        NSUInteger intLeft=[left integerValue];
        NSUInteger intRight=[right integerValue];
        
        
        NSArray *array=[_rightArray objectAtIndex:1];
        NSArray *array1 =[array objectAtIndex:intLeft];
        NSDictionary * dic1=[array1 objectAtIndex:intRight];
        
        NSString *value= [dic1 objectForKey:@"title"];
        
        [self setCarserSelected:value];
    }
    
    if (![self.organSelected isEqualToString:@""] && ![self.carserSelected isEqualToString:@""])
        
    {
        
        if([self.carserSelected isEqualToString:@"全部"])
           [self setCarserSelected:@""];
        
        
        NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:
                            self.organSelected, @"organ",
                            self.carserSelected, @"carser",
                            
                            nil];
        //NSDictionary *dic=[NSDictionary dictionaryWithObject:index forKey:@"Index"];
        
        [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/carstock.ashx" parameters:dic success:^(id responseObject) {
            
            JsonDataCenter* dc=[[JsonDataCenter alloc] init];
            NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
            
            NSArray *arr=[dc  getInfoArrayByDic:resultDic];
            [self.carArray removeAllObjects];
            
            for (NSDictionary *dataDic in arr) {
                
                [self.carArray addObject:dataDic];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.contentView reloadData];
                
                
                
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"error");
        }];
    }
    
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
