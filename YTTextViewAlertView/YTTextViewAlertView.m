//
//  YTTextViewAlertView.m
//  YTTextViewAlertView
//
//  Created by TonyAng on 2018/4/23.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

/** 手机屏 比例 */
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
#define UIColorFromR_G_B(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//分割线颜色
#define main_line_color             UIColorFromR_G_B(243, 243, 243, 1)

//主题色
#define main_color                  UIColorFromR_G_B(254, 152, 8, 1)

//浅色字体主题色
#define main_font_light_color       UIColorFromR_G_B(153, 153, 153, 1)

//深色字体主题色
#define main_font_deep_color        UIColorFromR_G_B(51, 51, 51, 1)

#import "YTTextViewAlertView.h"
#import "Masonry.h"
@interface YTTextViewAlertView()<UITextViewDelegate>
@property (nonatomic,strong) UIView *alertview;

@property (nonatomic,strong) UILabel *repulse_label;//打回

@property (nonatomic,strong) UITextView *repulse_content_textView;//输入评价内容
@property (nonatomic, copy) NSString *repulse_content_str;//输入评价内容

@property (nonatomic,strong) UILabel *max_textCont_label;//500字内
@property (nonatomic,strong) UIButton *repulse_cancel_button;//取消
@property (nonatomic,strong) UIButton *repulse_makeSure_button;//打回

@end

@implementation YTTextViewAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(290)/2, kFit(130) + ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(290), kFit(189));
        //        self.alertview.center = self.center;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertview];
        [self createYTStsrAlertView];
    }
    return self;
}

-(void)createYTStsrAlertView{
    //打回
    self.repulse_label = [UILabel new];
    [self.alertview addSubview:self.repulse_label];
    [self.repulse_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kFit(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.repulse_label.text = @"打回";
    self.repulse_label.textColor = main_color;
    self.repulse_label.font = [UIFont systemFontOfSize:kFit(16)];
    
    //输入评价内容
    self.repulse_content_textView = [UITextView new];
    [self.alertview addSubview:self.repulse_content_textView];
    [self.repulse_content_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repulse_label.mas_bottom).offset(kFit(20));
        make.left.offset(kFit(20));
        make.right.offset(-kFit(20));
        make.height.offset(kFit(75));
    }];
    self.repulse_content_textView.delegate = self;
    self.repulse_content_textView.text = @"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～";
    self.repulse_content_textView.textColor = UIColorFromR_G_B(204, 204, 204, 1);
    self.repulse_content_textView.font = [UIFont systemFontOfSize:kFit(10)];
    //500字内
    self.max_textCont_label = [UILabel new];
    [self.alertview addSubview:self.max_textCont_label];
    [self.max_textCont_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kFit(15));
        make.bottom.offset(-kFit(43));
    }];
    self.max_textCont_label.text = @"500字内";
    self.max_textCont_label.textColor = main_font_light_color;
    self.max_textCont_label.font = [UIFont systemFontOfSize:kFit(10)];
    
    //取消
    self.repulse_cancel_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertview addSubview:self.repulse_cancel_button];
    [self.repulse_cancel_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.offset(0);
        make.height.offset(kFit(33));
        make.width.offset(kFit(145));
    }];
    self.repulse_cancel_button.backgroundColor = UIColorFromR_G_B(238, 238, 238, 1);
    [self.repulse_cancel_button setTitle:@"取消" forState:UIControlStateNormal];
    [self.repulse_cancel_button setTitleColor:UIColorFromR_G_B(84, 84, 84, 1) forState:UIControlStateNormal];
    self.repulse_cancel_button.titleLabel.font = [UIFont systemFontOfSize:kFit(14)];
    [self.repulse_cancel_button addTarget:self action:@selector(evaluate_cancel_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    //确定
    self.repulse_makeSure_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertview addSubview:self.repulse_makeSure_button];
    [self.repulse_makeSure_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.offset(0);
        make.height.offset(kFit(33));
        make.width.offset(kFit(145));
    }];
    self.repulse_makeSure_button.backgroundColor = main_color;
    [self.repulse_makeSure_button setTitle:@"打回" forState:UIControlStateNormal];
    [self.repulse_makeSure_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.repulse_makeSure_button.titleLabel.font = [UIFont systemFontOfSize:kFit(14)];
    [self.repulse_makeSure_button addTarget:self action:@selector(evaluate_makeSure_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -
#pragma mark -------->取消Action
-(void)evaluate_cancel_buttonAction{
    NSLog(@"取消了----view");
    if (self.ytAlertViewCloseBlock) {
        self.ytAlertViewCloseBlock();
        [self dismissAlertView];
    }
}

#pragma mark -
#pragma mark -------->评价Action
-(void)evaluate_makeSure_buttonAction{
    NSLog(@"评价了-----view");
    if (self.ytAlertViewMakeSureBlock) {
        self.ytAlertViewMakeSureBlock(@"打回内容详情");
        [self dismissAlertView];
    }
}


#pragma mark -
#pragma mark -------->textViewDidBeginEditing
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(290)/2, ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(290), kFit(189));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
    if([textView.text isEqualToString:@"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～"]){
        textView.text=@"";
        textView.textColor = main_font_deep_color;
        
    }
}

#pragma mark - textViewDidEndEditing
- (void)textViewDidEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(290)/2, kFit(130) + ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(290), kFit(189));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
    
    if(textView.text.length < 1){
        textView.text = @"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～";
        textView.textColor = UIColorFromR_G_B(204, 204, 204, 1);
    }else{
        textView.textColor = [UIColor blackColor];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    
    NSLog(@"length------->%ld",(long)length);
    
    if (length > 500 ) {
        //        self.iWantPraiseViewTextView.text =  [self.iWantPraiseViewTextView.text substringToIndex:200];
    }
}

#pragma mark -
#pragma mark -------->打回set方法
-(void)setYtAlertViewMakeSureBlock:(void (^)(NSString *))ytAlertViewMakeSureBlock{
    _ytAlertViewMakeSureBlock = ytAlertViewMakeSureBlock;
}

#pragma mark -
#pragma mark -------->取消set方法
-(void)setYtAlertViewCloseBlock:(void (^)(void))ytAlertViewCloseBlock{
    _ytAlertViewCloseBlock = ytAlertViewCloseBlock;
}

-(UIView *)alertview
{
    if (_alertview == nil) {
        _alertview = [[UIView alloc] init];
        _alertview.backgroundColor = [UIColor whiteColor];
        _alertview.layer.cornerRadius = 10.0;
        _alertview.layer.masksToBounds = YES;
        _alertview.userInteractionEnabled = YES;
    }
    return _alertview;
}

-(void)show
{
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertview.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = UIColorFromR_G_B(1, 1, 1, 0.3f);
        self.alertview.transform = transform;
        self.alertview.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAlertView{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

