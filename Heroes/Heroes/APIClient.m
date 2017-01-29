//
//  APIClient.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (void) requestEndpoint: (NSString *) endpointString completion: (void(^)(NSArray *, NSError *)) completion {
    
    NSURL *url = [NSURL URLWithString: endpointString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSURLSessionDownloadTask * task = [session downloadTaskWithRequest: request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL: location];
        
        if (data != nil) {
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];
            NSDictionary *jsonArrayDictionary = [jsonDictionary objectForKey:@"data"];
            NSArray *jsonArray = [jsonArrayDictionary valueForKey:@"results"];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                completion(jsonArray, nil);
            }];
        } else {
            completion(nil, error);
        }
        
    }];
    
    [task resume];
    
}

@end
