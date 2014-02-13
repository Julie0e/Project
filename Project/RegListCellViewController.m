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
@property (weak, nonatomic) IBOutlet UIButton *freezeButton;
@property (weak, nonatomic) IBOutlet UIButton *refButton;


@end

@implementation RegListCellViewController
{
    Food *_food;
}

- (IBAction)refButtonClicked:(id)sender
{
    self.refButton.selected = YES;
    self.freezeButton.selected = NO;
    [self.table reloadData];
}

- (IBAction)freezeButtonClicked:(id)sender
{
    self.freezeButton.selected = YES;
    self.refButton.selected = NO;
    [self.table reloadData];
}

- (IBAction)closeModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_food addFoodWithName:textField.text endDate:NULL position:0 lifeTime:0];
    [self.table reloadData];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.refButton.selected)
    {
        return [_food.refData count];
    }
    else if (self.freezeButton.selected)
    {
        return [_food.freezeData count];
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    
    if (self.freezeButton.selected) {
        FoodItem *one = [_food.freezeData objectAtIndex:indexPath.item];
        NSString *foodName = [NSString stringWithString:one.name];
        NSURL *url = [_food imageURLForName:one.name];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        int lifetime = [_food lifetimeForName:one.name];
        
        int startDate = [_food startDateForName:one.name];
        NSDate *stringDate = [NSDate dateWithTimeIntervalSince1970:startDate];
        

        NSLog(@"stringDate : %@ - %@",stringDate, [stringDate descriptionWithLocale:[NSLocale currentLocale]]);
        
        NSDate *codeEndDate = [stringDate dateByAddingTimeInterval:(lifetime*24*60*60)];
        
        NSLog(@"codeEndDate : %@",codeEndDate);
        
        
        NSString *foodDate = [NSString stringWithFormat:@"구매일자 : %@",[_food.dateFormatter stringFromDate:stringDate]];
        
        NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc]init];
        [endDateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *test = [endDateFormatter stringFromDate:codeEndDate];
        
        NSString *foodEndDate = [NSString stringWithFormat:@"신선보관일 : %@",codeEndDate ];
        
        NSLog(@"foodDate : %@",foodDate);
        
        
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
    else if (self.refButton.selected){
        FoodItem *one = [_food.refData objectAtIndex:indexPath.item];
        NSString *foodName = [NSString stringWithString:one.name];
      //  _food.items = _food.refData;
        
        NSURL *url = [_food imageURLForName:one.name];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        int lifetime = [_food lifetimeForName:one.name];
        
        int startDate = [_food startDateForName:one.name];
        NSDate *stringDate = [NSDate dateWithTimeIntervalSince1970:startDate];
        
        NSLog(@"stringDate : %@ - %@",stringDate, [stringDate descriptionWithLocale:[NSLocale currentLocale]]);
        
        NSDate *codeEndDate = [stringDate dateByAddingTimeInterval:(lifetime*24*60*60)];
        
        NSLog(@"codeEndDate : %@",codeEndDate);
        
//        NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc]init];
//        [endDateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *foodDate = [NSString stringWithFormat:@"구매일자 : %@",[_food.dateFormatter stringFromDate:stringDate]];
        NSString *foodEndDate = [NSString stringWithFormat:@"신선보관일 : %@",[_food.dateFormatter stringFromDate:codeEndDate]];
        NSLog(@"foodDate : %@",foodDate);
        
        
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
    else
        _food.items = NULL;
    
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
    _food.dateFormatter = [[NSDateFormatter alloc]init];
    [_food.dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    [_food.dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"]];
    
    [super viewDidLoad];
    _food = [Food sharedFood];
    self.refButton.selected = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
  
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
