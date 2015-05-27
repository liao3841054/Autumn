//
//  demoVC.m
//  
//
//  Created by Ding Soung on 15/5/27.
//
//

#import "demoVC.h"
#import "summer-Bridging-Header.h"

@interface demoVC ()

@end

@implementation demoVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIView * view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
	view.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:view];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
