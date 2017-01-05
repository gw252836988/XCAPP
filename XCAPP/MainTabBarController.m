//
//  MainTabBarController.m
//  XCAPP
//
//  Created by 新城集团 on 16-9-27.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavController.h"
#import "HomeController.h"
#import "OAController.h"
#import "ERPController.h"
#import "MainController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

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
    
  
	// Do any additional setup after loading the view.
     MainController *itemOneController=[[MainController alloc]init];
     //[itemOneController setTitle:@"主页"];   // [itemOneController.view setBackgroundColor:[UIColor whiteColor]];
     MainNavController *oneNav=[[MainNavController alloc]initWithRootViewController:itemOneController];
     oneNav.tabBarItem.title=@"主页";
       //[bbNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"发布按下.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"发布.png"]];
    
    oneNav.tabBarItem.image=[UIImage imageNamed:@"home"];//    OAController *itemTwoController=[[OAController alloc]init];
//     [itemTwoController setTitle:@"OA"];
//    
//   // [itemTwoController.view setBackgroundColor:[UIColor whiteColor]];
//    MainNavController *twoNav=[[MainNavController alloc]initWithRootViewController:itemTwoController];
//    
//    ERPController *itemThirdController=[[ERPController alloc]init];
//    [itemThirdController setTitle:@"ERP"];
//    
//    // [itemTwoController.view setBackgroundColor:[UIColor whiteColor]];
//    MainNavController *thirdNav=[[MainNavController alloc]initWithRootViewController:itemThirdController];
    
//    oneNav.tabBarItem  =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
//    twoNav.tabBarItem=[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:2];
//    thirdNav.tabBarItem=[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:3];
    
   // [oneNav.tabBarItem initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
//    [twoNav.tabBarItem initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:2];
//    [thirdNav.tabBarItem initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:3];
    
    [self setViewControllers:@[oneNav]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
