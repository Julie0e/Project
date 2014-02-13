
#import "NLViewController.h"
#import "FoodItemCell.h"
#import "FoodItemCellDelegate.h"
#import "UIImageView+AFNetworking.h"


@interface NLViewController () <UICollectionViewDataSource, UICollectionViewDelegate, FoodItemCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *foodCollection;
@property (weak, nonatomic) IBOutlet FoodItemCell *foodCell;
@property (weak, nonatomic) IBOutlet UICollectionView *foodCollection2;


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
    // 누르고 있을 때 : x이미지
    // 한번 더 클릭 시 : 지우기
    
   // - (NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point;
    
    // x, y 좌표 구하기 : PressGestureRecognizer에서
    // collectionView에서 좌표로 Cell얻어오기 -> log로 출력
}

- (void)deleteFood:(FoodItemCell *)foodItemCell
{
    NSIndexPath *num = [self.foodCollection indexPathForCell:foodItemCell];
    
    if (num) {
      //  NSLog(@"indexPath : %@", num);
        FoodItem *one = [_food.freezeData objectAtIndex:num.row];
        [_food removeFood:one];
        [_food.freezeData removeObject:one];
        [_food.items removeObject:one];
        [self.foodCollection deleteItemsAtIndexPaths:@[num]];
    }
    else
    {
        NSIndexPath *num2 = [self.foodCollection2 indexPathForCell:foodItemCell];
     //   NSLog(@"indexPath : %@", num2);
        FoodItem *one2 = [_food.refData objectAtIndex:num.row];
        [_food removeFood:one2];
        [_food.refData removeObject:one2];
        [_food.items removeObject:one2];
        [self.foodCollection2 deleteItemsAtIndexPaths:@[num2]];
    }
    //collectionView 는 cell에서 indexPath를 얻어옴
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _food = [Food sharedFood];
    
    [self.foodCollection setBackgroundColor:[UIColor whiteColor]];
    [self.foodCollection2 setBackgroundColor:[UIColor whiteColor]];

    [self.foodCollection setAutoresizesSubviews:YES];
    [self.foodCollection setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_food resolveData];
    [self.foodCollection reloadData];
    [self.foodCollection2 reloadData];
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
    if (collectionView == self.foodCollection)
    {
        return [_food.freezeData count];
    }
    else
    {
        return [_food.refData count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.foodCollection) {
        FoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FOOD_ITEM" forIndexPath:indexPath];
        FoodItem *one = [_food.freezeData objectAtIndex:indexPath.item];
        
        NSURL *url = [_food imageURLForName:one.name];
        NSString *foodName = [NSString stringWithString:one.name];
        
        [cell.foodImageView setImageWithURL:url];
        [cell.foodName setText:foodName];
        return cell;

    }
    else if (collectionView == self.foodCollection2)
    {
        FoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FOOD_ITEM" forIndexPath:indexPath];
        FoodItem *one2 = [_food.refData objectAtIndex:indexPath.item];
        
        NSURL *url2 = [_food imageURLForName:one2.name];
        NSString *foodName2 = [NSString stringWithString:one2.name];

        [cell.foodImageView setImageWithURL:url2];
        [cell.foodName setText:foodName2];
        return cell;
        
    }
    else
        return NULL;

}

@end
