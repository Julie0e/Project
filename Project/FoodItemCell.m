//
//  FoodItemCell.m
//  Project
//
//  Created by 주리 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FoodItemCell.h"
#import "FoodItemCellDelegate.h"


@implementation FoodItemCell

- (IBAction)foodDelete:(id)sender
{
    [self.delegate deleteFood:self];
    
    NSLog(@"dddddddddddd");
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
-(void)viewDidLoad
{

    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


//- (void)longPressed:(UILongPressGestureRecognizer *)longPresseRecognizer
//{
//    [self becomeFirstResponder];
//    NSLog(@"longPressed");
//}
//-(IBAction)longPressed:(id)sender
//{
//    NSLog(@"longPressed");
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
