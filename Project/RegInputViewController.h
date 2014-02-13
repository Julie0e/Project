//
//  RegInputViewController.h
//  Project
//
//  Created by 주리 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStateComponent 0
#define kZipComponent 1

@interface RegInputViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSDictionary *bigSmall;
    NSArray *big;
    NSArray *small;
    NSString *item;
    NSString *item2;
    
}
@property (retain, nonatomic) NSDictionary *bigSmallaa;
@property (retain, nonatomic) NSArray *bigaa;
@property (retain, nonatomic) NSArray *smallaa;


@end
