//
//  YHPickerview.h
//  test1
//
//  Created by ZhaoMin on 2017/5/9.
//
//


#import <Cordova/CDV.h>

@interface YHPickerview : CDVPlugin
-(void)showPicker:(CDVInvokedUrlCommand*)command;
-(void)hidePicker:(CDVInvokedUrlCommand*)command;
-(void)destoryPicker:(CDVInvokedUrlCommand*)command;
@end
