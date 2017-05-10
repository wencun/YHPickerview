//
//  YHPickerview.h
//  YHPickerview Cordova Plugin
//
//  Created by ZhaoMin/278269606@qq.com on 17/5/10.
//  Copyright © 2016年 ZhaoMin.  All rights reserved.
//

#import <Cordova/CDV.h>

@interface YHPickerview : CDVPlugin
-(void)showPicker:(CDVInvokedUrlCommand*)command;
-(void)hidePicker:(CDVInvokedUrlCommand*)command;
-(void)destoryPicker:(CDVInvokedUrlCommand*)command;
@end
