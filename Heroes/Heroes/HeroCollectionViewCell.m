//
//  HeroCollectionViewCell.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroCollectionViewCell.h"

@implementation HeroCollectionViewCell

- (void) setImage; {
    
    NSString *imageURL = [NSString stringWithFormat:@"%@/standard_medium.jpg", self.imageURLString];
    ImageGetter *imageGetter = [[ImageGetter alloc] initWithURLString:imageURL];
    [imageGetter getImage:^(UIImage *heroThumbnail) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.heroImageView.image = heroThumbnail;
        });
    }];
}

@end
