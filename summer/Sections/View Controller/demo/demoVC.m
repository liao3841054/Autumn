//
//  demoVC.m
//  
//
//  Created by Ding Soung on 15/5/27.
//
//

#import "demoVC.h"
#import "summer-swift.h"

@interface demoVC ()

@end

@implementation demoVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIView * view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
	view.backgroundColor = [UIColor yellowColor];
	[view setShadow:[UIColor yellowColor].CGColor offset:CGSizeMake(2, 3) opacity:0.5 radius:3];
	[self.view addSubview:view];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	
	
}

@end
