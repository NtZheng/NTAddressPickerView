//
//  NTAddressPickerView.h
//  NTAddressPickerView
//
//  Created by nineteen on 4/26/17.
//  Copyright © 2017 nineteen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)(void);
typedef void(^ConfirmBlock)(void);

@interface NTAddressPickerView : UIView

+ (void)showAddressPickerViewWithAnimated :(BOOL)animated cancelAction: (CancelBlock)cancelBlock confirmBlock: (ConfirmBlock)confirmBlock;

@end
