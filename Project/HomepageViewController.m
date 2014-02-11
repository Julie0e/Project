//
//  HomepageViewController.m
//  Project
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "HomepageViewController.h"


@interface HomepageViewController () <UITextFieldDelegate, UIWebViewDelegate>


@end

@implementation HomepageViewController

- (IBAction)closeModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *msg = [error localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"에러" message:msg delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
    [alert show];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}


- (void)viewWillAppear:(BOOL)animated
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.chonggakne.com/"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
