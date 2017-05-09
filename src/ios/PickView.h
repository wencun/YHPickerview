
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
