//
//  MarvelHeroClient.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "MarvelHeroClient.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MarvelHeroClient

- (void) fetchHeroesWithOffset: (NSInteger) offset completion: (void(^)(NSMutableArray *heroesArray, NSError *error)) completion {
    
    NSString *publicKey = @"ff3acd65c06955117d60117cfb02dba3";
    NSString *privateKey = @"cc965ee72d14cdb84cd7a6b9f14a0f9c69ddc1fe";
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    
    NSString *stringToHash = [NSString stringWithFormat:@"%lu%@%@",currentTime, privateKey, publicKey];
    NSString *hashedString = [self hashString: stringToHash];
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://gateway.marvel.com:80/v1/public/characters?ts=%lu&orderBy=name&offset=%lu&apikey=%@&hash=%@", currentTime, (long)offset, publicKey, hashedString];
    
    [APIClient requestEndpoint:urlString completion:^(NSArray *jsonArray, NSError *error) {
        
        if (error == nil) {
            
            NSMutableArray *heroesArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *heroDictionary in jsonArray) {
                HeroModel *hero = [[HeroModel alloc] initWithJSON:heroDictionary];
                [heroesArray addObject:hero];
            }
            
            completion(heroesArray, nil);
            
        } else {
            completion(nil, error);
        }
        
    }];
    
    
}

- (NSString *) hashString: (NSString *) stringToHash {
    const char* str = [stringToHash UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


@end

