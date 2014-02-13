//
//  RegListViewController.m
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "RegListViewController.h"
#import "Food.h"


@interface RegListViewController() <UITableViewDelegate, UITableViewDataSource>

@end


@implementation RegListViewController
{
    Food *_food;
    __weak IBOutlet UIButton *changedButton;
}

- (IBAction)changedButton:(id)sender
{
//    if (changedButton == NO)
//    {
//        [editButton setImage:nil forState:UIControlStateNormal];
//        [editButton setImage:[UIImage imageNamed:@"done2.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [editButton setImage:nil forState:UIControlStateNormal];
//        [editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [_food.rottenItems count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    
    FoodItem *one = [_food.rottenItems objectAtIndex:indexPath.item];
    
//    NSDate *currentDate = [NSDate date];
//    NSTimeInterval timeInterval = [one.startDate timeIntervalSinceDate:currentDate];
//
//
//    if (timeInterval < 0) {
    
    NSString *foodName = [NSString stringWithString:one.name];
    NSURL *url = [_food imageURLForName:one.name];
    NSData *data = [NSData dataWithContentsOfURL:url];
        
        
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc]init];
    [endDateFormatter setDateFormat:@" 신선보관일 : yyyy-MM-dd "];
        
        
    NSString *foodEndDate = [endDateFormatter stringFromDate:one.endDate];
        
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:999];
    UIImageView *foodImage = (UIImageView *)[cell viewWithTag:99];
    UILabel *endDateLabel = (UILabel *)[cell viewWithTag:777];
        
    nameLabel.text = foodName;
    foodImage.image = [UIImage imageWithData:data];
    endDateLabel.text = foodEndDate;
  //  }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        FoodItem *one = [_food.rottenItems objectAtIndex:indexPath.row];
        [_food removeFood:one];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _food = [Food sharedFood];
    [_food resolveData];
    [self.table reloadData];

}
- (void)viewWillAppear:(BOOL)animated
{
    
    [_food resolveData];
    [self.table reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
