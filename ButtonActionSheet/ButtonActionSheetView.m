//
//  ButtonActionSheetViewController.m
//
//  Created by Andreas Henriksson on 2013-04-07.
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

#import "ButtonActionSheetView.h"
#import "QuartzCore/CAGradientLayer.h"

#define kButtonHeight 60.0f

@interface ButtonActionSheetView ()

@end

@implementation ButtonActionSheetView

- (id)initWithFrame:(CGRect)frame {
    CGRect frame_ = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kButtonHeight);
    self = [super initWithFrame:frame_];
    
    if (self) {
        buttons = [[NSMutableArray alloc] init];
        separators = [[NSMutableArray alloc] init];
        
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame_.size.width, kButtonHeight)];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:NSLocalizedString(@"CANCEL", nil) forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.0f]];
        
        [self addSubview:cancelButton];
        [cancelButton release];
    }
    
    return self;
}

- (void)setTitles:(NSArray*)titles {
    int count = [titles count];
    int currentCount = [buttons count];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (count + 1) * kButtonHeight + count * 1.0)];
    
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    CGFloat currentY = 0;
    
    UIColor *bgColor = [UIColor colorWithRed:0.18f green:0.18f blue:0.18f alpha:1.0f];
    
    // Remove buttons if we have too many
    if (currentCount > count) {
        NSRange range = NSMakeRange(count, currentCount - count);
        for (NSInteger i = 0; i < range.length; i++) {
            UIButton *btn = (UIButton*)[buttons objectAtIndex:i+range.location];
            [btn removeFromSuperview];
        }
        [buttons removeObjectsInRange:range];
        [separators removeObjectsInRange:range];
    }
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *btn = i >= currentCount ? nil : [buttons objectAtIndex:i];
        if (btn == nil) {
            btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, currentY, size.width, kButtonHeight)];
            [btn setTag:i];
            [btn addTarget:self action:@selector(navigateAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundColor:bgColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self addSubview:btn];
            [buttons addObject:btn];
            [btn release];
            
            UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, currentY + kButtonHeight, size.width, 1.0f)];
            [separatorView setBackgroundColor:[UIColor colorWithRed:0.05f green:0.05f blue:0.05f alpha:1.0f]];
            [self addSubview:separatorView];
            [separators addObject:separatorView];
            [separatorView release];
        } else {
            [btn setFrame:CGRectMake(0.0, currentY, size.width, kButtonHeight)];
        }
        
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        
        currentY += kButtonHeight + 1.0;
    }
    
    [cancelButton setFrame:CGRectMake(0, currentY, size.width, kButtonHeight)];
}

- (void)dealloc {
    [buttons release];
    [separators release];
    
    [super dealloc];
}

-(void)cancelAction:(id)sender {
    [self.delegate closeSheet:self];
}

-(void)navigateAction:(id)sender {
    NSInteger index = ((UIButton*)sender).tag;
    [self.delegate sheet:self didSelectButtonIndex:index];
}

- (void)showSheetAtPoint:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
}

- (void)hideSheetAtPoint:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.bounds.size.width, self.bounds.size.height);
}

@end
