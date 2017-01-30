//
//  HeroDetailViewController.h
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"

@interface HeroDetailViewController : UIViewController

@property (nonatomic, strong) HeroModel *hero;
@property (nonatomic, weak) IBOutlet UIImageView *heroImageView;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIButton *wikiButton;
@property (nonatomic, weak) IBOutlet UIButton *resourceButton;

@end
