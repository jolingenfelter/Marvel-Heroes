//
//  ImageGetter.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageGetter : NSObject

@property (nonatomic, strong) NSString *imageURLString;

- (id) initWithURLString: (NSString *) urlString;
- (void) getImage: (void(^)(UIImage *heroThumbnail)) completion;

@end

