//
//  HeroCollectionViewCell.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HeroCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *heroImageView;
@property (nonatomic, strong) NSString *imageURLString;

- (void) setImage;

@end
