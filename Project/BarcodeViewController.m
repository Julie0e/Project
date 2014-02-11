//
//  BarcodeViewController.m
//  Project
//
//  Created by 주리 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "BarcodeViewController.h"

@interface BarcodeViewController () <ZBarReaderDelegate>

@end

@implementation BarcodeViewController
- (IBAction)barcode:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    
	reader = [ZBarReaderViewController new];
	reader.readerDelegate = self;
    
    ZBarImageScanner *scanner = reader.scanner;
	
	
	[scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
	[self presentModalViewController:reader animated:YES];
	
//	[scanner release];
//	[reader release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
	
	ZBarSymbol *symbol = nil;
	for(symbol in results)
		break;
	
//	barcode_number.text = symbol.data;
	//symbol.data가 바코드 번호이다.
	
	
    
//     if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//     [self performSelector: @selector(playBeep)
//     withObject: nil
//     afterDelay: 0.01];
  //   이부분은 스캔이 되었을때, 삐 소리가 하게 하는 부분이다.
     
     
 	[self dismissModalViewControllerAnimated:YES];
	
}
- (IBAction)closeModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
