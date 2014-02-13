//
//  RegInputViewController.m
//  Project
//
//  Created by 주리 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "RegInputViewController.h"
#import "Food.h"
#import "FoodItem.h"
#import <sqlite3.h>

@interface RegInputViewController ()
{

    UIActionSheet *sheet;
    UIActionSheet *sheet2;
    UIDatePicker *picker;
    NSDateFormatter *formatter;
    float height;
}

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIButton *big;
@property (strong, nonatomic) IBOutlet UIButton *small;
@property (strong, nonatomic) IBOutlet UIButton *date;
@property (strong, nonatomic) IBOutlet UIButton *num;
@property (strong, nonatomic) IBOutlet UISwitch *alarm;
@property (strong, nonatomic) IBOutlet UISwitch *refrigerator;
@property (nonatomic) int lifeTime;

@end

@implementation RegInputViewController
{
    Food *_food;
    __weak IBOutlet UIImageView *image;
    NSInteger on;
}



- (IBAction)closeModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (IBAction)alarm:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    if (sw.on)
    {
        NSLog(@"알람설정함");
    }
    else if (!sw.on)
    {
        NSLog(@"알람설정안함");
    }
}

- (IBAction)refrigerator:(id)sender
{
    UISwitch *ref = (UISwitch *)sender;
    if (ref.on) {
        on = 1;
        NSLog(@"냉장설정함 %d",on);
    }
    else if(!ref.on)
    {
        on = 0;
        NSLog(@"냉동설정함 %d", on);
    }
}


- (IBAction)chooseBig:(id)sender
{
    CGSize viewSize = self.view.bounds.size;
    
    if (sheet == nil) {
        // 액션시트생성
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        
        // 툴바와 Done 버튼
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, 44)];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDone:)];
        NSArray *items = [NSArray arrayWithObject:done];
        [toolbar setItems:items];
        
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        [pickerView setDelegate:self];
        [pickerView setDataSource:self];

        pickerView.frame = CGRectMake(0, toolbar.frame.size.height, viewSize.width, pickerView.frame.size.height);
        //시트에 추가
        [sheet addSubview:toolbar];
        [sheet addSubview:pickerView];
        //시트에 나타나기
        //액션시트크기와 위치 계산용
        height = toolbar.frame.size.height + pickerView.frame.size.height;
        
    }
    
    [sheet showInView:self.view];
    sheet.frame = CGRectMake(0, viewSize.height - height, viewSize.width, height);
}


- (IBAction)chooseNum:(id)sender
{

}


- (IBAction)save:(UIButton *)button
{
    [_food addFoodWithName:self.small.currentTitle endDate:self.date.currentTitle position:self.refrigerator.on lifeTime:self.lifeTime];
    [button resignFirstResponder];
//    NSLog(@"%@",self.small.currentTitle);
//    NSLog(@"%@",self.date.currentTitle);
}

- (IBAction)chooseDate:(id)sender
{
    CGSize viewSize = self.view.bounds.size;
    
    if (sheet2 == nil) {
    
        sheet2 = [[UIActionSheet alloc] init];
    
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, 44)];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDone:)];
        NSArray *items = [NSArray arrayWithObject:done];
        [toolbar setItems:items];
    
        //데이트피커
        picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.frame = CGRectMake(0, toolbar.frame.size.height, viewSize.width, picker.frame.size.height);
        //시트에 추가
        [sheet2 addSubview:toolbar];
        [sheet2 addSubview:picker];
        //시트에 나타나기
        [sheet2 showInView:self.view];
        //액션시트크기와 위치 계산용
        height = toolbar.frame.size.height + picker.frame.size.height;
    }
    [sheet2 showInView:self.view];
    sheet2.frame = CGRectMake(0, viewSize.height - height, viewSize.width, height);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.bigaa count];
    }
    return [self.smallaa count];
}


// 각 컴포넌트와 로우인덱스에 해당하는 문자열 항목반환

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.bigaa objectAtIndex:row];
    }
    return [self.smallaa objectAtIndex:row];
}


//사용자선택시
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString *selectedState = [self.bigaa objectAtIndex:row];
        NSArray *array = [self.bigSmallaa objectForKey:selectedState];
        
    //    NSLog(@"array : %@",array);
        self.smallaa = array;
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        
        item = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    else
        item2 = [self pickerView:pickerView titleForRow:row forComponent:component];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *plistPath = [bundle pathForResource:@"menu" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    self.bigSmallaa = dictionary;

    NSArray *components = [self.bigSmallaa allKeys];
    NSArray *sorted = [components sortedArrayUsingSelector:@selector(compare:)];
    self.bigaa = sorted;
    
    NSString *selectedState = [self.bigaa objectAtIndex:0];
    NSArray * array = [self.bigSmallaa objectForKey:selectedState];
    self.smallaa = array;
    
    _food = [Food sharedFood];
    
  //  NSLog(@"smallaa : %@",self.smallaa);

}

- (void)viewWillAppear:(BOOL)animated
{
//    [_food resolveData];
}


-(void)handleDone:(id)sender
{
    if (self.big) {
        [sheet dismissWithClickedButtonIndex:0 animated:YES];
        [self.big setTitle:item forState:UIControlStateNormal];
        
    }
    if (self.small) {
        [sheet2 dismissWithClickedButtonIndex:0 animated:YES];
        [self.small setTitle:item2 forState:UIControlStateNormal];
        if ([item2 isEqualToString:@"고추장"]) {
            UIImage *imageName = [UIImage imageNamed:@"고추장.png"];
            self.image.image = imageName;
        }
        
    }
    if (self.date) {
        [sheet2 dismissWithClickedButtonIndex:0 animated:YES];
        if (formatter == nil) {
            formatter = _food.dateFormatter;

        }
        
        NSDate *date = picker.date;
        NSString *dateStr = [formatter stringFromDate:date];
        [self.date setTitle:dateStr forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
