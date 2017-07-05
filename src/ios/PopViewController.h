//
//  PopViewController.h
//  haojie
//
//  Created by lv zaiyi on 2017/6/2.
//
//

#import <UIKit/UIKit.h>
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


@protocol PopDelegate <NSObject>

- (void)popCallback:(NSDictionary *)dict;

@end
@interface PopViewController : UIViewController

@property (nonatomic, assign)id<PopDelegate> delegate;
@property (strong, nonatomic)YHPickerviewParams *param;
@property (strong, nonatomic) NSMutableArray *curSelected;

- (void)dismissVC;

@end
