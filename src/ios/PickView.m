//
//  PickView.m
//  YHPickerview Cordova Plugin
//
//  Created by ZhaoMin/278269606@qq.com on 17/5/10.
//  Copyright © 2016年 ZhaoMin.  All rights reserved.
//


#import "PickView.h"

@implementation PickView

-(id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self loadView];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
      [self loadView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self loadView];
}

-(void)loadView
{
    UIView * viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44)];

    viewTitle.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0];
    [self addSubview:viewTitle];
    
    
    self.pickTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 0,CGRectGetWidth(viewTitle.frame)-(70*2), 44)];
    self.pickTitle.text = @"";
    self.pickTitle.textColor = [UIColor whiteColor];
    self.pickTitle.font = [UIFont systemFontOfSize:15];
    [self.pickTitle setTextAlignment:NSTextAlignmentCenter];
    [viewTitle addSubview:self.pickTitle];
    
    
    UIButton * btnOK = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(viewTitle.frame)-60, 0, 60, 44)];
    [btnOK addTarget:self action:@selector(confirmChangeData:) forControlEvents:UIControlEventTouchUpInside];
//    [btnOK setImage:[UIImage imageNamed:@"n_pick_add.png"] forState:(UIControlStateNormal)];
    [btnOK setTitle:@"确定" forState:(UIControlStateNormal)];
    [btnOK setTitleColor:[UIColor colorWithRed:5/255.0f green:125/255.0f blue:255/255.0f alpha:1.0] forState:(UIControlStateNormal)];
    [viewTitle addSubview:btnOK];
    
    UIButton * btnCencel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,60, 44)];
    [btnCencel addTarget:self action:@selector(canelChangeData:) forControlEvents:UIControlEventTouchUpInside];
//    [btnCencel setImage:[UIImage imageNamed:@"n_pick_cancle.png"] forState:(UIControlStateNormal)];
    [btnCencel setTitle:@"取消" forState:(UIControlStateNormal)];
    [btnCencel setTitleColor:[UIColor colorWithRed:5/255.0f green:125/255.0f blue:255/255.0f alpha:1.0] forState:(UIControlStateNormal)];
    [viewTitle addSubview:btnCencel];
}


-(void)canelChangeData:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(toolBarCanelClick:)])
    {
        [self.delegate toolBarCanelClick:sender];
    }
}



-(void)confirmChangeData:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(toolBarDoneClick:)])
    {
        [self.delegate toolBarDoneClick:sender];
    }

}

@end
