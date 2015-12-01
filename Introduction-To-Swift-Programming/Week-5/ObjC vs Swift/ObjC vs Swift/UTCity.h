//
//  UTCity.h
//  ObjC vs Swift
//
//  Created by Alexey Huralnyk on 9/29/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTCity : NSObject

@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) NSInteger population;

- (instancetype)initWithName:(NSString *)name population:(NSInteger)population;

@end

@interface UTCountry : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSArray * cities;

- (instancetype)initWithName:(NSString *)name cities:(NSArray *)cities;
- (UTCity *)findCityWithName:(NSString *)name;

@property (strong, nonatomic, readonly) UTCity * cityWithLargestPopulation;

@end