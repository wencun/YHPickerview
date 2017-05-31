//
//  YHPickerview.m
//  YHPickerview Cordova Plugin
//
//  Created by ZhaoMin/278269606@qq.com on 17/5/10.
//  Copyright © 2016年 ZhaoMin.  All rights reserved.
//


#import "YHPickerview.h"
#import "PickView.h"

#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)

@interface YHPickerviewParams : NSObject
@property (strong, nonatomic) NSString *pickerId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *options;
@property (assign, nonatomic) NSInteger depth; // 有多少列
@property (strong, nonatomic) NSArray *selected; //选中
@property (assign, nonatomic) BOOL isProvinceCity; //是否是省市联动。1为是，0为否
@end

@implementation YHPickerviewParams

@end


@interface YHPickerview()<PickViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickView;
    PickView *_containerPickView;
}
@property (assign, nonatomic)BOOL isPickViewVisible;
@property (strong, nonatomic)YHPickerviewParams *param;
@property (strong, nonatomic) NSMutableArray *curSelected;
@property (strong, nonatomic) NSString *callbackId;
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
        [self createPicker];
        [self _showPicker];
        _callbackId = [command.callbackId copy];
    }
}

-(void)hidePicker:(CDVInvokedUrlCommand*)command{
    if (_containerPickView) {
        [self _hidePicker];
    }
    
    _callbackId = nil;
}

-(void)destoryPicker:(CDVInvokedUrlCommand*)command{
    if (_containerPickView) {
        [UIView animateWithDuration:0.2 animations:^{
            _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT, APP_SCREEN_WIDTH, 206};
        } completion:^(BOOL finished) {
            self.isPickViewVisible = NO;
            [_pickView removeFromSuperview];
            [_containerPickView removeFromSuperview];
            _pickView = nil;
            _containerPickView = nil;
        }];
    }
    
    _callbackId = nil;
}

-(void)_showPicker{
    if (_containerPickView) {
        _containerPickView.pickTitle.text = self.param.title;
        [_pickView reloadAllComponents];
        [UIView animateWithDuration:0.2 animations:^{
            _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT-206, APP_SCREEN_WIDTH, 206};
        } completion:^(BOOL finished) {
            self.isPickViewVisible = YES;
        }];
        
        switch (self.param.depth) {
            case 1:
                [_pickView selectRow:[_curSelected[0] intValue] inComponent:0 animated:YES];
                break;
            case 2:
                [_pickView selectRow:[_curSelected[0] intValue] inComponent:0 animated:YES];
                [_pickView selectRow:[_curSelected[1] intValue] inComponent:1 animated:YES];
                break;
            case 3:
                [_pickView selectRow:[_curSelected[0] intValue] inComponent:0 animated:YES];
                [_pickView selectRow:[_curSelected[1] intValue] inComponent:1 animated:YES];
                [_pickView selectRow:[_curSelected[2] intValue] inComponent:2 animated:YES];
                break;
        }
    }
}

-(void)_hidePicker{
    [UIView animateWithDuration:0.2 animations:^{
        _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT, APP_SCREEN_WIDTH, 206};
    } completion:^(BOOL finished) {
        self.isPickViewVisible = NO;
    }];
}

#pragma mark - 创建pick
-(void)createPicker
{
    if (!_containerPickView)
    {
        _containerPickView = [[PickView alloc] initWithFrame:(CGRect){0,APP_SCREEN_HEIGHT, APP_SCREEN_WIDTH, 206}];
        _containerPickView.delegate = self;
        _containerPickView.backgroundColor = [UIColor whiteColor];
        _containerPickView.tag = 100;
        _containerPickView.pickTitle.text = @"";
        [self.viewController.view addSubview:_containerPickView];
        
    }
    
    if (!_pickView)
    {
        _pickView = [[UIPickerView alloc] initWithFrame:(CGRect){0,44, APP_SCREEN_WIDTH, 206-44}];
        _pickView.showsSelectionIndicator = YES;
        [_pickView setBackgroundColor:[UIColor whiteColor]];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        [_containerPickView addSubview:_pickView];
        
    }
}

#pragma mark - PickViewDelegate

-(void)toolBarDoneClick:(id)sender
{
    NSArray *selectedTextArray = nil;
    NSArray *selectedIDArray = nil;
    switch (self.param.depth) {
        case 1:
        {
            NSString *title = [self pickerView:_pickView titleForRow:[_curSelected[0] intValue] forComponent:0];
            selectedTextArray = @[title];
            NSDictionary *optionDict = self.param.options[[_curSelected[0] intValue]];
            NSString *titleId = [optionDict objectForKey:@"id"];
            selectedIDArray = @[titleId];
        }
            break;
        case 2:
        {
            NSString *title1 = [self pickerView:_pickView titleForRow:[_curSelected[0] intValue] forComponent:0];
            NSString *title2 = [self pickerView:_pickView titleForRow:[_curSelected[1] intValue] forComponent:1];
            selectedTextArray = @[title1, title2?:@""];
        }
            break;
            
        case 3:
        {
            NSString *title1 = [self pickerView:_pickView titleForRow:[_curSelected[0] intValue] forComponent:0];
            NSString *title2 = [self pickerView:_pickView titleForRow:[_curSelected[1] intValue] forComponent:1];
            NSString *title3 = [self pickerView:_pickView titleForRow:[_curSelected[2] intValue] forComponent:2];
            selectedTextArray = @[title1, title2?:@"", title3?:@""];
        }
            break;
    }
    
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [resultDict setObject:self.param.pickerId forKey:@"pickerId"];
    [resultDict setObject:selectedTextArray forKey:@"selectedTextArray"];
    [resultDict setObject:[_curSelected copy] forKey:@"selectedIndexArray"];
    
    if (selectedIDArray) {
        [resultDict setObject:selectedIDArray forKey:@"selectedIDArray"];
    }
    [self sendResult:resultDict];
    
    [self _hidePicker];
}

-(void)toolBarCanelClick:(id)sender
{
    [self _hidePicker];
}

#pragma mark PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger number = self.param.depth;
    return number;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger number = 0;
    if (component==0) {
        number = [self.param.options count];
    }else if (component==1){
        int selectedIndex = [_curSelected[0] intValue];
        number = [self.param.options[selectedIndex][@"options"] count];
    }else if (component==2){
        int selectedIndex0 = [_curSelected[0] intValue];
        int selectedIndex1 = [_curSelected[1] intValue];
        NSArray *component1Array = self.param.options[selectedIndex0][@"options"];
        number = [component1Array[selectedIndex1][@"options"] count];
    }
    return number;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    if (component==0) {
        title = [self.param.options[row] objectForKey:@"text"];
    }else if (component==1){
        int selectedIndex = [_curSelected[0] intValue];
        title = [self.param.options[selectedIndex][@"options"][row] objectForKey:@"text"];
    }else if (component==2){
        int selectedIndex0 = [_curSelected[0] intValue];
        int selectedIndex1 = [_curSelected[1] intValue];
        NSArray *component1Array = self.param.options[selectedIndex0][@"options"];
        if([component1Array[selectedIndex1][@"options"][row] isKindOfClass:[NSString class]]){
            title = component1Array[selectedIndex1][@"options"][row];
        }else{
            title = [component1Array[selectedIndex1][@"options"][row] objectForKey:@"text"];
        }
        
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (self.param.depth) {
        case 1:
        {
            self.curSelected[0] = @(row);
        }
            break;
        case 2:
        {
            if (component==0) {
                self.curSelected[0] = @(row);
                self.curSelected[1] = @(0);
                [_pickView reloadComponent:1];
            }else if (component==1){
                self.curSelected[1] = @(row);
            }
        }
            break;
            
        case 3:
        {
            if (component==0) {
                self.curSelected[0] = @(row);
                self.curSelected[1] = @(0);
                self.curSelected[2] = @(0);
                [_pickView reloadComponent:1];
                [_pickView reloadComponent:2];
            }else if (component==1){
                self.curSelected[1] = @(row);
                self.curSelected[2] = @(0);
                [_pickView reloadComponent:2];
            }else if (component==2){
                self.curSelected[2] = @(row);
            }
        }
            break;
    }
}

-(void)sendResult:(NSDictionary*) resultDict{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}

@end
