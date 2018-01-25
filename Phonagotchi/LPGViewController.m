//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *movingAppleView;

@end

@implementation LPGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.petImageView setUserInteractionEnabled:YES];
    
    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
   // [self.bucketImageView setUserInteractionEnabled:YES];
    
    self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.appleImageView setUserInteractionEnabled:YES];
    
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    
    [self.view addSubview:self.petImageView];
    [self.view addSubview:self.bucketImageView];
    [self.view addSubview:self.appleImageView];
    
                                ////////////////CAT CONSTRAINTS///////////////
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
                                ////////////////BUCKET CONSTRAINTS///////////////
    
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:100].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:100].active = YES;
     
     [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1.0
                                   constant:20].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-20].active = YES;
    
    
    
                                ////////////////APPLE CONSTRAINTS///////////////
    
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50].active = YES;

    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:30].active = YES;

    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-50].active = YES;

    
    
                                ////////////////GESTURE RECOGNIZERS///////////////
    
    UIPanGestureRecognizer *panGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    
    [self.petImageView addGestureRecognizer:panGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    longPressGestureRecognizer.minimumPressDuration = 0.2;
    
    [self.appleImageView addGestureRecognizer:longPressGestureRecognizer];
    
}


- (void)panDetected:(UIPanGestureRecognizer *)sender {
    
    //another method to check velocity using 'fabs'...
    //if (fabs(pet.x) > 600 || fabs(pet.y) > 600) ... fabs give x and y all positive numbers so only check for positives
    
    CGPoint pet = [sender velocityInView:self.petImageView];
    
    if ((pet.x > 400 || pet.x < -400) && (pet.y > 400 || pet.y < -400)) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
}


    - (void)longPressDetected:(UILongPressGestureRecognizer *)sender {
        
        CGPoint location = [sender locationInView:self.view];
       NSLog(@"pinch recognised");
        switch (sender.state) {
            
            case UIGestureRecognizerStateBegan: {

                self.movingAppleView = [[UIImageView alloc] initWithFrame:sender.view.bounds];
                self.movingAppleView.center = [sender locationInView:self.view];
                self.movingAppleView.userInteractionEnabled = NO;
                self.movingAppleView.image = self.appleImageView.image;
                [self.view addSubview:self.movingAppleView];
            }
                
            case UIGestureRecognizerStateChanged: {
                
                NSLog(@"YOU GOT IT");
                self.movingAppleView.center = location;
            }
                break;
                
            case UIGestureRecognizerStateEnded: {
                
                if (CGRectIntersectsRect(self.movingAppleView.frame, self.petImageView.frame)) {
                    self.movingAppleView.center = location;
                    [self.movingAppleView removeFromSuperview];
                    
                } else {
                    
                    [UIView animateWithDuration:0.5 animations:^ {
                        self.movingAppleView.center = CGPointMake(location.x, [[UIScreen mainScreen] bounds].size.height+50);
                        
                    } completion:^(BOOL finished) {
                        [self.movingAppleView removeFromSuperview];
                        self.movingAppleView = nil;
                    }];
                }
            default:
                break;
            }
        }
    }



@end
