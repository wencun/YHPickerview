//
//  PopViewController.m
//  haojie
//
//  Created by lv zaiyi on 2017/6/2.
//
//

#import "PopViewController.h"

@implementation YHPickerviewParams

@end



@interface PopViewController ()<PickViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickView;
    PickView *_containerPickView;
}
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.layer.borderWidth = 2;
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5];
    [self createPicker];
    [self _showPicker];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissVC];
}

/**
 *  设置位置宽高
 */
- (void)viewWillLayoutSubviews {
    
//    self.view.frame = CGRectMake(self.view.frame.origin.x, 80, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - 80);
    //self.view.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.868f];
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)_showPicker{
    if (_containerPickView) {
        _containerPickView.pickTitle.text = self.param.title;
        [_pickView reloadAllComponents];
        [UIView animateWithDuration:0.2 animations:^{
            _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT-206, APP_SCREEN_WIDTH, 206};
        } completion:^(BOOL finished) {
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
        [self.view addSubview:_containerPickView];
        
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
//    [self sendResult:resultDict];
    
    //[self _hidePicker];
    [self.delegate popCallback:resultDict];
}

-(void)toolBarCanelClick:(id)sender
{
    //[self _hidePicker];
//    [self destoryPicker:nil];
    [self dismissVC];
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


@end
