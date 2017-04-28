//
//  NTAddressPickerView.m
//  NTAddressPickerView
//
//  Created by nineteen on 4/26/17.
//  Copyright © 2017 nineteen. All rights reserved.
//

#import "NTAddressPickerView.h"

#define NTDeviceSize [[UIScreen mainScreen] bounds].size
#define NTAddressPickerViewHeight 200
#define NTCurrentWindow [[UIApplication sharedApplication].windows lastObject]

@interface NTAddressPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) NSDictionary *citys;
@property (nonatomic, copy) NSArray *provinceArray;
@property (nonatomic, copy) NSArray *townArray;
@property (nonatomic, strong) UIView *baseContainerView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end

@implementation NTAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self autoLayout];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        // 背景添加事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskClickAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - interface

+ (void)showAddressPickerViewWithAnimated :(BOOL)animated cancelAction: (CancelBlock)cancelBlock confirmBlock: (ConfirmBlock)confirmBlock {
    NTAddressPickerView *addressPickerView = [[self alloc]initWithFrame:CGRectMake(0, 0, NTDeviceSize.width, NTDeviceSize.height)];
    
    // 动画操作
    if (animated) {
        addressPickerView.alpha = 0.0;
        [NTCurrentWindow addSubview:addressPickerView];
        [UIView animateWithDuration:0.5f animations:^{
            addressPickerView.alpha = 1.0;
        }];
    } else {
        [NTCurrentWindow addSubview:addressPickerView];
    }
    
    // 设置属性
    addressPickerView.cancelBlock = cancelBlock;
    addressPickerView.confirmBlock = confirmBlock;
}

#pragma mark - lazy load

- (UIView *)baseContainerView {
    if (_baseContainerView == nil) {
        _baseContainerView = [[UIView alloc]init];
        _baseContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _baseContainerView;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.87] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"确认" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.87] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (NSDictionary *)citys {
    if (_citys == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        _citys = [[NSDictionary alloc]initWithContentsOfFile:path];
    }
    return _citys;
}

- (NSArray *)provinceArray {
    if (_provinceArray == nil) {
        _provinceArray = [self.citys allKeys];
    }
    return _provinceArray;
}

- (NSArray *)townArray {
    if (_townArray == nil) {
        _townArray = [[[self.citys objectForKey:self.provinceArray[0]] objectAtIndex:0] allKeys];
    }
    return _townArray;
}

#pragma mark - autoLayout

- (void)autoLayout {
    // 基本背景view
    self.baseContainerView.frame = CGRectMake(0, NTDeviceSize.height - NTAddressPickerViewHeight, NTDeviceSize.width, NTAddressPickerViewHeight);
    [self addSubview:self.baseContainerView];
    
    // 左边的按钮
    self.leftButton.frame = CGRectMake(0, 5, 50, 20);
    [self.baseContainerView addSubview:self.leftButton];
    
    // 右边的按钮
    self.rightButton.frame = CGRectMake(NTDeviceSize.width - 50, 5, 50, 20);
    [self.baseContainerView addSubview:self.rightButton];
    
    // 选择器
    self.pickerView.frame = CGRectMake(0, 25, NTDeviceSize.width, NTAddressPickerViewHeight - 25);
    [self.baseContainerView addSubview:self.pickerView];
}

#pragma mark - dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

#pragma mark - delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.townArray = [[[self.citys objectForKey:self.provinceArray[row]] objectAtIndex:0] allKeys];
    }
    [self.pickerView reloadComponent:1];
}

#pragma mark - actions

- (void)leftButtonAction {
    self.cancelBlock();
    [self hideWithAnimation:YES];
}

- (void)rightButtonAction {
    // 第一列的值
    NSInteger firstComponentRow = [self.pickerView selectedRowInComponent:0];
    NSString *firstComponentText = self.provinceArray[firstComponentRow];
    // 第二列的值
    NSInteger secondComponentRow = [self.pickerView selectedRowInComponent:1];
    NSString *secondComponentText = self.townArray[secondComponentRow];
    [self hideWithAnimation:YES];
    self.confirmBlock(firstComponentText, secondComponentText);
}

- (void)maskClickAction {
    [self hideWithAnimation:YES];
}

#pragma mark - methods

- (void)hideWithAnimation :(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.5f animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

@end
