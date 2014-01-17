//
//  RegListViewController.m
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "RegListViewController.h"


@interface RegListViewController() <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *data;
    NSArray *data2;
}
@end

@implementation RegListViewController

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 컴포넌트별로항목개수

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 10;
    }
    else if (component == 1)
    {
        return 20;
    }
    
    else
        return [data count];
}

// 각 컴포넌트와 로우인덱스에 해당하는 문자열 항목반환

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"Row : %ld", row];
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"Row : %ld", row];
    }
    else
        return [data objectAtIndex:row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
        data = [[NSArray alloc] initWithObjects:@"오이",@"당근",@"가지",@"토마토",@"양배추", nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
