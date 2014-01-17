//
//  LoginViewController.h
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *numberInput;

@property (weak, nonatomic) IBOutlet UITextField *otherNumberInput;
@property (strong, nonatomic) NSString *msg;

@end

