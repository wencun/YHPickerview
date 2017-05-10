
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

    viewTitle.backgroundColor = [UIColor colorWithRed:2/255.0f green:3/255.0f blue:4/255.0f alpha:1.0];
    [self addSubview:viewTitle];
    
    
    self.pickTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 0,CGRectGetWidth(viewTitle.frame)-(70*2), 44)];
    self.pickTitle.text = @"";
    self.pickTitle.textColor = [UIColor whiteColor];
    self.pickTitle.font = [UIFont systemFontOfSize:15];
    [self.pickTitle setTextAlignment:NSTextAlignmentCenter];
    [viewTitle addSubview:self.pickTitle];
    
    
    UIButton * btnOK = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(viewTitle.frame)-60, 0, 60, 44)];
    [btnOK addTarget:self action:@selector(confirmChangeData:) forControlEvents:UIControlEventTouchUpInside];
    [btnOK setImage:[UIImage imageNamed:@"n_pick_add.png"] forState:(UIControlStateNormal)];
    [viewTitle addSubview:btnOK];
    
    UIButton * btnCencel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,60, 44)];
    [btnCencel addTarget:self action:@selector(canelChangeData:) forControlEvents:UIControlEventTouchUpInside];
    [btnCencel setImage:[UIImage imageNamed:@"n_pick_cancle.png"] forState:(UIControlStateNormal)];
    
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
