//
//  HeroModel.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *heroDescription;
@property (nonatomic) NSString *thumbnailPath;
@property (nonatomic) NSString *characterResourceURL;

- (id) initWithJSON: (NSDictionary *) json;

@end
