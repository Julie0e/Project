//
//  NLViewController.m
//  ImageShowcase
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NLViewController.h"
#import "FoodItemCell.h"
#import "FoodItemCellDelegate.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface NLViewController () <UICollectionViewDataSource, UICollectionViewDelegate, FoodItemCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *foodCollection;
@property (weak, nonatomic) IBOutlet FoodItemCell *foodCell;


@end

@implementation NLViewController
{
    Food *_food;
}

- (IBAction)longPressed:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        sender.enabled = NO;
        NSLog(@"longPressed");
        [sender locationInView:sender.view];
        CGPoint point = [sender locationInView:self.foodCollection];
        NSLog(@"CGPoint : %@",NSStringFromCGPoint(point));
        
        NSIndexPath *num = [self.foodCollection indexPathForItemAtPoint:point];
        
        NSLog(@"indexPath : %@",num);
        
        
        if (num != NULL) {
            FoodItemCell *cell = [self.foodCollection cellForItemAtIndexPath:num];
       //     cell.deleteButton.hidden = YES;
            cell.deleteButton.hidden = !cell.deleteButton.hidden;
            
        }

    }
    
//    if (num != NULL) {
//        FoodItem *one = [_food.items objectAtIndex:num.row];
//        [_food removeFood:one];
//        [_food.items removeObject:one];
//        [self.foodCollection deleteItemsAtIndexPaths:@[num]];
//        NSLog(@"지워짐!! ");
//    }
    
    
    // 누르고 있을 때 : x이미지
    // 한번 더 클릭 시 : 지우기
    
   // - (NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point;
    
    // x, y 좌표 구하기 : PressGestureRecognizer에서
    // collectionView에서 좌표로 Cell얻어오기 -> log로 출력
}

- (void)deleteFood:(FoodItemCell *)foodItemCell
{
    NSIndexPath *num = [self.foodCollection indexPathForCell:foodItemCell];
    FoodItem *one = [_food.items objectAtIndex:num.row];
    [_food removeFood:one];
    [_food.items removeObject:one];
    [self.foodCollection deleteItemsAtIndexPaths:@[num]];
    
    //collectionView 는 cell에서 indexPath를 얻어옴
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _food = [Food sharedFood];
    
    [self.foodCollection setBackgroundColor:[UIColor whiteColor]];

    [self.foodCollection setAutoresizesSubviews:YES];
    [self.foodCollection setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foodInfoUpdate:) name:@"foodInfoUpdate" object:nil];
    [_food resolveData];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)foodInfoUpdate:(NSNotification *)notification
{
    [self.foodCollection reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"ddd : %ld",(long)[_food getNumberOfFoods]);
    NSLog(@"food : %@",_food);
    return [_food getNumberOfFoods] ;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FOOD_ITEM" forIndexPath:indexPath];
    FoodItem *one = [_food.items objectAtIndex:indexPath.item];
    
    NSURL *url = [NSURL URLWithString:one.image];
    NSString *foodName = [NSString stringWithString:one.name];
 //   NSData *foodDay = [one.date];
    
  //  NSLog(@"%@",foodDay);
    [cell.foodImageView setImageWithURL:url];
    [cell.foodName setText:foodName];
 //   [cell.dDay :foodDay];


    return cell;
}



@end
