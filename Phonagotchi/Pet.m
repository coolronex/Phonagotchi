//
//  Pet.m
//  Phonagotchi
//
//  Created by Aaron Chong on 1/25/18.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"
#import "UIKit/UIKit.h"

@implementation Pet

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        _currentRestfulness = 60;
        
    }
    return self;
}

- (void) runRestfulnessTimer {
    

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decreaseRestfulness) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeToDefaultImage" object:self userInfo:nil];
}

- (void) decreaseRestfulness {
    
    if (self.currentRestfulness > 0) {
        self.currentRestfulness --;
        NSLog(@"current restfulness: %ld", self.currentRestfulness);
        
        
    } else {
        NSLog(@"Sleep");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeToSleepingImage" object:self userInfo:nil];
        [self.timer invalidate];
        [self sleepTimer];
        
    }
}

- (void) sleepTimer {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(restoreRestfulness) userInfo:nil repeats:NO];
}

- (void) restoreRestfulness {

    self.currentRestfulness = 60;
    [self runRestfulnessTimer];

}



@end
