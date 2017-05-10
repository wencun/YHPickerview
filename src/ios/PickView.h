//
//  PickView.h
//  YHPickerview Cordova Plugin
//
//  Created by ZhaoMin/278269606@qq.com on 17/5/10.
//  Copyright © 2016年 ZhaoMin.  All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol PickViewDelegate;

@interface PickView : UIView

@property(nonatomic,strong)UILabel * pickTitle;

@property(nonatomic,weak) NSObject<PickViewDelegate> * delegate;

@end

@protocol PickViewDelegate <NSObject>

-(void)toolBarDoneClick:(id)sender;
-(void)toolBarCanelClick:(id)sender;
//-(void)changeDate;

@end
