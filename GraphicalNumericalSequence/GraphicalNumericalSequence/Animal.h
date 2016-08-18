//
//  Animal.h
//  GraphicalNumericalSequence
//
//  Created by xpg on 16/8/18.
//  Copyright © 2016年 China's Dream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (strong ,nonatomic) NSString * name;
@property (strong ,nonatomic) NSString * type;
@property (assign ,nonatomic) int yearIndex;
@property (strong ,nonatomic) NSMutableArray * numberArray;
//
//- (Animal * )setAnimalName:(NSString *)name andType:(NSString *)type andYearInadex:(int)yearIndex andNumberArray:(NSMutableArray *)numberArray;
@end
