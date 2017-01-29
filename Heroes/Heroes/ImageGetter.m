//
//  ImageGetter.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "ImageGetter.h"

@implementation ImageGetter

- (id) initWithURLString:(NSString *)urlString {
    
    self = [super init];
    
    if (self) {
        self.imageURLString = urlString;
    }
    
    return self;
}

- (void) getDataFromURL: (void(^)(NSData *data, NSURLResponse *response, NSError *error)) completion {
    NSURLSession *session = [NSURLSession sharedSession];
    
    if (self.imageURLString != nil) {
        
        NSURL *imageURL = [NSURL URLWithString:self.imageURLString];
        
        NSURLSessionDataTask * task = [session dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            completion(data, response, error);
        }];
        
        [task resume];
    }
    
}

- (void) getImage: (void(^)(UIImage *heroThumbnail)) completion {
    
    [self getDataFromURL:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data != nil) {
            
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
            
        } else {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        
    }];
    
}

@end

