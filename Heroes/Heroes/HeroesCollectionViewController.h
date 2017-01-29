//
//  HeroesCollectionViewController.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroCollectionViewCell.h"
#import "MarvelHeroClient.h"

@interface HeroesCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *heroesArray;
@property (nonatomic, strong) MarvelHeroClient *heroClient;
@property (nonatomic) NSInteger offset;

@end
