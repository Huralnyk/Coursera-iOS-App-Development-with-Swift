//
//  AppDelegate.m
//  adasf
//
//  Created by Alexey Huralnyk on 9/29/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "AppDelegate.h"
#import "UTCity.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadStuff
{
    NSArray * cities = @[
         [[UTCity alloc] initWithName:@"Toronto" population:3000000],
         [[UTCity alloc] initWithName:@"Vancouver" population:5]
    ];
}

@end
