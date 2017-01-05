//
//  LoginController.m
//  XCAPP
//
//  Created by 新城集团 on 16-11-4.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "LoginController.h"
#import "LoginBackground.h"
#import "MBProgressHUD.h"
#import "HttpRequest.h"
#import "JsonDataCenter.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
@interface LoginController ()<UITextFieldDelegate>
{
    UITextField *_account;
    UITextField *_password;
    UIButton * _loginButton;
    MBProgressHUD * HUD;
    LoginBackground *_background;
}
@end

@implementation LoginController

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
	// Do any additional setup after loading the view.
    
    
   
	
    //	HUD.delegate = self;
	
   [self.view setBackgroundColor:[UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1]];
    
    _background=[[LoginBackground alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    [_background setBackgroundColor:[UIColor whiteColor]];
    [[_background layer] setCornerRadius:5];
    [[_background layer] setMasksToBounds:YES];
    [self.view addSubview:_background];
    _account=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 50)];
    [_account setBackgroundColor:[UIColor clearColor]];
    _account.placeholder=[NSString stringWithFormat:@"工号"];
    _account.layer.cornerRadius=5.0;
    _account.delegate=self;
    [_background addSubview:_account];
    _password=[[UITextField alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-40, 50)];
    [_account setBackgroundColor:[UIColor clearColor]];
    _password.placeholder=[NSString stringWithFormat:@"密码"];
    _password.layer.cornerRadius=5.0;
    _password.secureTextEntry=YES;
    _password.delegate=self;
    [_background addSubview:_password];
    [self.view addSubview:_background];
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 310, self.view.frame.size.width-40, 40)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor colorWithRed:51/255.0 green:102/255.0 blue:255/255.0 alpha:1]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     _loginButton.layer.cornerRadius=5.0;
    [_loginButton addTarget:self action:@selector(LoginUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText = @"登录中...";
    
    UILabel * lblCompany=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, self.view.frame.size.height-20, 200, 15)];
    
    lblCompany.adjustsFontSizeToFitWidth=YES;
    lblCompany.text=@"Copyright © 2016 南通新城集团 All rights reserved ";
    lblCompany.textColor=[UIColor whiteColor];
   // lblCompany.font = [UIFont systemFontOfSize:10];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _account.text=  [defaults objectForKey:@"UserId"];
    _password.text=[defaults objectForKey:@"Pwd"];
    
    
    [self.view addSubview:lblCompany];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_account resignFirstResponder];
    [_password resignFirstResponder];
    return YES;
}

-(void)LoginUser
{
    //[HUD showWhileExecuting:@selector(BeginLogin) onTarget:self withObject:nil animated:YES];
    [HUD show:YES];
    
  
    NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:
                        @"0", @"type",
                          _account.text, @"staffid",
                        _password.text, @"pwd",
                        nil];
    
    [HttpRequest getWithURLString:@"http://221.130.108.114:8082/XCAPI/staffinfo.ashx" parameters:dic success:^(id responseObject) {
        
        JsonDataCenter* dc=[[JsonDataCenter alloc] init];
        NSDictionary *resultDic=[dc isSuccessWithResponseObject:responseObject];
        
        NSDictionary *dicData=[dc  getInfoDic:resultDic];
       
      // NSString* strStatus=[dicData objectForKey:@"LoginStatus"];
        
        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [self.contentView reloadData];
//        }];
        [self  performSelectorOnMainThread:@selector(goToMainView:) withObject:dicData waitUntilDone:FALSE];

        
    } failure:^(NSError *error) {
        NSLog(@"error");
          [HUD hide:NO];
    }];


}


-(void)goToMainView:(id)object
{
    //[HUD hide:NO];
    NSDictionary *dicData=object;
    NSString *status=[dicData objectForKey:@"LoginStatus"];
    
    if([status isEqualToString:@"1"])
    {
        HUD.labelText = @"密码或用户名错误";
        [HUD showAnimated:YES whileExecutingBlock:^{
           sleep(2);
        }];
    }
    else
    {
        [HUD hide:NO];
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.UserId=_account.text;
        appDelegate.UserName=[dicData objectForKey:@"UserName"];
        appDelegate.PosiName=[dicData objectForKey:@"PosiName"];
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:_account.text forKey:@"UserId"];
        [defaults setObject:_password.text forKey:@"Pwd"];
        
        MainTabBarController *mainTabController =[[MainTabBarController alloc]init];
        [self presentViewController:mainTabController animated:NO completion:nil];
    }
}

-(void)BeginLogin
{
     sleep(5);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// tap dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [_password resignFirstResponder];
}


@end
