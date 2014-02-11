//
//  RegListCellViewController.h
//  Project
//
//  Created by 주리 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItem.h"


@interface RegListCellViewController : UIViewController
   <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end
