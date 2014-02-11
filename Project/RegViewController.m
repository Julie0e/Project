//
//  RegViewController.m
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//


//
//#import "RegViewController.h"
//#import "CHTCollectionViewWaterfallCell.h"
//
//#define CELL_WIDTH 80
//#define CELL_COUNT 6
//
//
//#define CELL_IDENTIFIER @"WaterfallCell"
//
//
//@interface RegViewController ()
//@property (weak, nonatomic) IBOutlet UIView *topView;
//@property (weak, nonatomic) IBOutlet UIView *bottomView;
//
//@property (nonatomic, strong) NSMutableArray *cellHeights;
//
//@end
//@implementation RegViewController
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        self.cellWidth = CELL_WIDTH;        // Default if not setting runtime attribute
//    }
//    return self;
//}
//
//#pragma mark - Accessors
//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
//        
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        layout.delegate = self;
//
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 250, 220) collectionViewLayout:layout];
//
//        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _collectionView.dataSource = self;
//        _collectionView.delegate = self;
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
//            forCellWithReuseIdentifier:CELL_IDENTIFIER];
//        
//    }
//    return _collectionView;
//}
//
//- (UICollectionView *)collectionView2 {
//    if (!_collectionView2) {
//        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
//        
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        layout.delegate = self;
//        
//        
////         _collectionView2 = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//        
//        _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 250, 220) collectionViewLayout:layout];
//
//        _collectionView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _collectionView2.dataSource = self;
//        _collectionView2.delegate = self;
//        _collectionView2.backgroundColor = [UIColor whiteColor];
//        [_collectionView2 registerClass:[CHTCollectionViewWaterfallCell class]
//            forCellWithReuseIdentifier:CELL_IDENTIFIER];
//        
//    }
//    return _collectionView2;
//}
//
//- (NSMutableArray *)cellHeights {
//    if (!_cellHeights) {
//        _cellHeights = [NSMutableArray arrayWithCapacity:CELL_COUNT];
//        for (NSInteger i = 0; i < CELL_COUNT; i++) {
//            _cellHeights[i] = @(60);
//        }
//    }
//    return _cellHeights;
//}
//
//
//
//#pragma mark - Life Cycle
//- (void)dealloc {
//    [_collectionView removeFromSuperview];
//    _collectionView = nil;
//    [_collectionView2 removeFromSuperview];
//    _collectionView2 = nil;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self.topView addSubview:self.collectionView];
//    [self.bottomView addSubview:self.collectionView2];
//    
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self updateLayout];
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//duration:(NSTimeInterval)duration {
//    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [self updateLayout];
//}
//
//- (void)updateLayout {
//    CHTCollectionViewWaterfallLayout *layout =
//    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
//    
//    CHTCollectionViewWaterfallLayout *layout2 =
//    (CHTCollectionViewWaterfallLayout *)self.collectionView2.collectionViewLayout;
//    
//    layout.columnCount = self.collectionView.bounds.size.width / self.cellWidth;
//    layout.itemWidth = self.cellWidth-5;
//    
//    layout2.columnCount = self.collectionView2.bounds.size.width / self.cellWidth;
//    layout2.itemWidth = self.cellWidth-5;
//}
//
//
//
//#pragma mark - UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
//{
//  
//
//    return CELL_COUNT;
//    
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
//cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CHTCollectionViewWaterfallCell *cell =
//    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
//   //각 cell에 들어갈 string
//    cell.displayString = [NSString stringWithFormat:@"%d", (int)indexPath.row];
//    return cell;
//}
//
//
//#pragma mark - UICollectionViewWaterfallLayoutDelegate
//- (CGFloat)collectionView:(UICollectionView *)collectionView
//layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout
//heightForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return [self.cellHeights[indexPath.item] floatValue];
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView
//heightForHeaderInLayout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout {
//    return 0;
//}
//
//
//@end
