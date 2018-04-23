//
//  YTTextViewAlertView.h
//  YTTextViewAlertView
//
//  Created by TonyAng on 2018/4/23.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTextViewAlertView : UIView

@property (nonatomic, copy) void(^ytAlertViewMakeSureBlock)(
NSString *repulse_evaluate_str/*打回内容*/
);//打回内容

@property (nonatomic, copy) void(^ytAlertViewCloseBlock)(void);//取消


-(void)show;//弹出

@end
