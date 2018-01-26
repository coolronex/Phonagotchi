//
//  Pet.h
//  Phonagotchi
//
//  Created by Aaron Chong on 1/25/18.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property (nonatomic) NSInteger currentRestfulness;
@property (nonatomic) NSTimer* timer;

- (void) decreaseRestfulness;
- (void) runRestfulnessTimer;


@end
