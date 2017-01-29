//
//  MarvelHeroClient.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"
#import "HeroModel.h"

@interface MarvelHeroClient : NSObject

- (void) fetchHeroesWithOffset: (NSInteger) offset completion: (void(^)(NSMutableArray *heroesArray, NSError *error)) completion;

@end
