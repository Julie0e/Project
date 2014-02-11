//
//  LeftViewController.m
//  Depol2
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "LeftViewController.h"
#import "Memo.h"
#import "MemoItem.h"

@interface LeftViewController ()


@property (weak, nonatomic) IBOutlet UIButton *save;

@end

@implementation LeftViewController {
    
    Memo *_memo;
    
  
}
- (IBAction)save:(UIButton *)button
{
    [_memo addMemo:self.textView.text];
    [button resignFirstResponder];
    NSLog(@"%@",self.textView.text);
  
}

- (IBAction)closeButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _memo = [Memo sharedMemo];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [_memo resolveData];
   // [self.textView reloadInputViews];
    MemoItem *one = [_memo.memo lastObject];

    self.textView.text = one.memo;

    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//- (void)textViewDidEndEditing:(UITextView *)textView{
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	[defaults setObject:textView.text forKey:[NSString stringWithFormat:@"text%d", textView.tag]];
//}

@end
