//
//  RegListCellViewController.m
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "RegListCellViewController.h"
#import <sqlite3.h>
#import "Food.h"
#import "AppDelegate.h"
#import "FoodItem.h"
#import "AFNetworking.h"



@interface RegListCellViewController () <UITextFieldDelegate, UITableViewDataSource, UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (strong, nonatomic) IBOutlet UILabel *foodName;

@end

@implementation RegListCellViewController
{
    Food *_food;
}

- (IBAction)closeModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [_food addFoodWithName:textField.text date:NULL ];
    [self.table reloadData];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_food getNumberOfFoods];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    
    FoodItem *one = [_food.items objectAtIndex:indexPath.item];
    
    NSString *foodName = [NSString stringWithString:one.name];
    NSURL *url = [NSURL URLWithString:one.image];
    NSData *data = [NSData dataWithContentsOfURL:url];
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@" 구매일자 : yyyy-MM-dd "];
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc]init];
    [endDateFormatter setDateFormat:@" 신선보관일 : yyyy-MM-dd "];


    NSString *foodDate = [dateFormatter stringFromDate:one.date];
    NSString *foodEndDate = [endDateFormatter stringFromDate:one.endDate];
    NSLog(@"%@",one.date);
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:99];
    UIImageView *foodImage = (UIImageView *)[cell viewWithTag:9];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:88];
    UILabel *endDateLabel = (UILabel *)[cell viewWithTag:77];
    
    nameLabel.text = foodName;
    foodImage.image = [UIImage imageWithData:data];
    dateLabel.text = foodDate;
    endDateLabel.text = foodEndDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        FoodItem *one = [_food.items objectAtIndex:indexPath.row];
        [_food removeFood:one];
        [_food resolveData];
        [self.table reloadData];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _food = [Food sharedFood];


}

- (void)viewWillAppear:(BOOL)animated
{
    //[_food resolveData];
//    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foodInfoUpdate:) name:@"foodInfoUpdate" object:nil];
//    [self.table reloadData];
  
}

- (void)foodInfoUpdate:(NSNotification *)notification
{
    [self.table reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
