//
//  APIClient.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

+ (void) requestEndpoint: (NSString *) endpointString completion: (void(^)(NSArray *, NSError *)) completion;


@end
