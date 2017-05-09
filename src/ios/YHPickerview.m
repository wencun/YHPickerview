
#import "YHPickerview.h"
#import "PickView.h"

#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)

@interface YHPickerviewParams : NSObject
@property (strong, nonatomic) NSDictionary *options;
@property (assign, nonatomic) NSInteger column; // 有多少列
@property (strong, nonatomic) NSArray *selected; //选中

@end

@implementation YHPickerviewParams

@end


@interface YHPickerview()<PickViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickView;
    PickView *_containerPickView;
}
@property (assign, nonatomic)BOOL isPickViewVisible;
@end

@implementation YHPickerview

-(void)showPicker:(CDVInvokedUrlCommand*)command{
    
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        YHPickerviewParams *param = [[YHPickerviewParams alloc] init];
        param.options = dict[@"options"];
        param.column = [dict[@"column"] integerValue];
        param.selected = dict[@"selected"];
        
        [self createPicker];
        [self _showPicker];
    }
}

-(void)hidePicker:(CDVInvokedUrlCommand*)command{
    if (_containerPickView) {
        [self _hidePicker];
    }
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
}

-(void)_showPicker{
    if (_containerPickView) {
        [UIView animateWithDuration:0.2 animations:^{
            _containerPickView.frame = (CGRect){0,APP_SCREEN_HEIGHT-206, APP_SCREEN_WIDTH, 206};
        } completion:^(BOOL finished) {
            self.isPickViewVisible = YES;
        }];
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
    [self _hidePicker];
}

-(void)toolBarCanelClick:(id)sender
{
    [self _hidePicker];
}

#pragma mark PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger number = 0;
    return number;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
}


@end
