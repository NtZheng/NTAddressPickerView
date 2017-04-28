//
//  ViewController.m
//  NTAddressPickerView
//
//  Created by nineteen on 4/26/17.
//  Copyright © 2017 nineteen. All rights reserved.
//

#import "ViewController.h"
#import "NTAddressPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 100);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickAction {
    [NTAddressPickerView showAddressPickerViewWithAnimated:YES cancelAction:^{
        
    } confirmBlock:^(NSString *province, NSString *town) {
        NSLog(@"province: %@\ntown: %@",province,town);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
