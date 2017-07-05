//
//  YHPickerview.m
//  YHPickerview Cordova Plugin
//
//  Created by ZhaoMin/278269606@qq.com on 17/5/10.
//  Copyright © 2016年 ZhaoMin.  All rights reserved.
//


#import "YHPickerview.h"
#import "PopViewController.h"

@interface YHPickerview()<PopDelegate>

@property (strong, nonatomic)YHPickerviewParams *param;
@property (strong, nonatomic) NSMutableArray *curSelected;
@property (strong, nonatomic) NSString *callbackId;
@property (strong, nonatomic)PopViewController *pop;

@end

@implementation YHPickerview

-(void)showPicker:(CDVInvokedUrlCommand*)command{
    
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        YHPickerviewParams *param = [[YHPickerviewParams alloc] init];
        param.isProvinceCity = [dict[@"isProvinceCity"] boolValue];
        if (param.isProvinceCity) {
            NSString *resPath = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"json"];
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:resPath] options:NSJSONReadingMutableContainers error:nil];
            param.pickerId = @"";//dict[@"pickerId"];
            param.title = @"";//dict[@"title"];
            param.options = jsonArray;
            param.depth = 3;
            param.selected = @[@(0), @(0), @(0)];
        }else{
            param.pickerId = dict[@"pickerId"];
            param.title = @"";//dict[@"title"];
            param.options = dict[@"options"];
            param.depth = [dict[@"depth"] integerValue];
            param.selected = dict[@"selected"];
        }
        
        
        _param = param;
        _curSelected = [param.selected mutableCopy];
        
        _callbackId = [command.callbackId copy];
        _pop = [[PopViewController alloc] init];
        /*设置这个属性背景就是透明的，而不是黑色的了*/
        //设置模式展示风格
        [_pop setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        //必要配置
        self.viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.viewController.providesPresentationContextTransitionStyle = YES;
        self.viewController.definesPresentationContext = YES;
        
        _pop.delegate = self;
        _pop.param = param;
        _pop.curSelected = _curSelected;
        [self.viewController presentViewController:_pop animated:NO completion:nil];
    }
}

- (void)popCallback:(NSDictionary *)dict{
    [self sendResult:dict];
    [_pop dismissVC];
}

-(void)hidePicker:(CDVInvokedUrlCommand*)command{
//    if (_containerPickView) {
//        [self _hidePicker];
//    }
    
    _callbackId = nil;
}

-(void)destoryPicker:(CDVInvokedUrlCommand*)command{
//    if (_containerPickView) {
//        [UIView animateWithDuration:0.2 animations:^{
//            _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT, APP_SCREEN_WIDTH, 206};
//        } completion:^(BOOL finished) {
//            [_pickView removeFromSuperview];
//            [_containerPickView removeFromSuperview];
//            _pickView = nil;
//            _containerPickView = nil;
//        }];
//    }
    
    _callbackId = nil;
}

-(void)sendResult:(NSDictionary*) resultDict{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}

@end
