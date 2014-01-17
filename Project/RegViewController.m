//
//  RegViewController.m
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "RegViewController.h"
#import "CHTCollectionViewWaterfallCell.h"

#define CELL_WIDTH 60
#define CELL_COUNT 8

#define CELL_IDENTIFIER @"WaterfallCell"


@interface RegViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *cellHeights;

@end
@implementation RegViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.cellWidth = CELL_WIDTH;        // Default if not setting runtime attribute
    }
    return self;
}

#pragma mark - Accessors
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        
    }
    return _collectionView;
}

- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:CELL_COUNT];
        for (NSInteger i = 0; i < CELL_COUNT; i++) {
            _cellHeights[i] = @(50);
        }
    }
    return _cellHeights;
}

#pragma mark - Life Cycle
- (void)dealloc {
    [_collectionView removeFromSuperview];
    _collectionView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.topView addSubview:self.collectionView];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayout];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayout];
}

- (void)updateLayout {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = self.collectionView.bounds.size.width / self.cellWidth;
    layout.itemWidth = self.cellWidth-10;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
  

    return CELL_COUNT;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
   //각 cell에 들어갈 string
    cell.displayString = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout
heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellHeights[indexPath.item] floatValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
heightForHeaderInLayout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout {
    return 30;
}


@end
