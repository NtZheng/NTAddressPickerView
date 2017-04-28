//
//  NTAddressPickerView.h
//  NTAddressPickerView
//
//  Created by nineteen on 4/26/17.
//  Copyright © 2017 nineteen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)(void);
typedef void(^ConfirmBlock)(NSString *province, NSString *town);

@interface NTAddressPickerView : UIView

/*
 * @param animated : 是否进行动画
 * @param cancelBlock : 点击取消按钮所进行的操作（block）
 * @param confirmBlock : 点击确认按钮所进行的操作（block）
 */

+ (void)showAddressPickerViewWithAnimated :(BOOL)animated cancelAction: (CancelBlock)cancelBlock confirmBlock: (ConfirmBlock)confirmBlock;

@end
