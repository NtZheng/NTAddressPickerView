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
    [NTAddressPickerView showAddressPickerViewWithAnimated:YES cancelAction:^{
        
    } confirmBlock:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
