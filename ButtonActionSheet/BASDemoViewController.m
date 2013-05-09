//
//  BASDemoViewController.m
//  ButtonActionSheet
//
//  Created by Andreas Henriksson on 2013-05-09.
//  Copyright (c) 2013 Andreas Henriksson. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

#import "BASDemoViewController.h"

@interface BASDemoViewController ()

@end

@implementation BASDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect bounds = self.view.bounds;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Show sheet" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(bounds.size.width/5, bounds.size.width/5, (bounds.size.width/5)*3, 30.0f)];
    [btn addTarget:self action:@selector(showSheet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, btn.frame.origin.y + btn.frame.size.height + 10.0f, bounds.size.width - 20.0f, 20.0f)];
    [self.view addSubview:lbl];
}

-(void)showSheet:(id)sender {
    if (buttonSheetView == nil) {
        CGRect bounds = self.view.bounds;
        buttonSheetView = [[ButtonActionSheetView alloc] initWithFrame:CGRectMake(0, bounds.size.height, bounds.size.width, 50.0f)];
        [buttonSheetView setDelegate:self];
        [buttonSheetView setTitles:[NSArray arrayWithObjects:@"Button1", @"Button2", @"Button3", nil]];
        [self.view addSubview:buttonSheetView];
    }
    
    [UIView animateWithDuration:0.60f animations:^{
        [buttonSheetView showSheetAtPoint:CGPointMake(0, self.view.bounds.size.height)];
    }];
}

#pragma mark ButtonActionSheetDelegate

- (void)closeSheet:(ButtonActionSheetView*)sheet {
    [UIView animateWithDuration:0.60f animations:^{
        [sheet hideSheetAtPoint:CGPointMake(0, self.view.bounds.size.height)];
    }];
}

- (void)sheet:(ButtonActionSheetView*)sheet didSelectButtonIndex:(NSInteger)index {
    [lbl setText:[NSString stringWithFormat:@"Selected button number: %i", index + 1]];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [buttonSheetView release];
    buttonSheetView = nil;
    [lbl release];
    lbl = nil;
    
    [super dealloc];
}

@end
