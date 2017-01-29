//
//  HeroModel.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

- (id) initWithJSON:(NSDictionary *)json {
    
    self = [super init];
    
    self.name = [json objectForKey:@"name"];
    self.heroDescription = [json objectForKey:@"description"];
    
    NSDictionary *thumbnailDictionary = [json objectForKey:@"thumbnail"];
    self.thumbnailPath = [thumbnailDictionary objectForKey:@"path"];
    
    NSArray *characterInfoURLS = [json objectForKey:@"urls"];
    
    if ([[characterInfoURLS[0] objectForKey:@"url"] length] == 0) {
        self.characterResourceURL= @"No detail url";
    }else {
        self.characterResourceURL = [characterInfoURLS[0] objectForKey:@"url"];
    }
    
    return self;
    
}

@end
