//
//  HeroDetailViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "ImageGetter.h"

@interface HeroDetailViewController ()

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navBarSetup];
    [self viewSetup];
}

- (void) navBarSetup {
    
    self.title = [NSString stringWithFormat:@"%@", self.hero.name];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar.topItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState: UIControlStateNormal];
}

- (void) viewSetup {
    
    NSString *imageURL = [NSString stringWithFormat:@"%@/portrait_fantastic.jpg", self.hero.thumbnailPath];
    ImageGetter *imageGetter = [[ImageGetter alloc] initWithURLString: imageURL];
    [imageGetter getImage:^(UIImage *heroThumbnail) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.heroImageView.image = heroThumbnail;
        });
    }];
    
    if ([self.hero.heroDescription isEqualToString: @""] ) {
        self.descriptionTextView.text = @"Description unavailable for this hero";
    } else {
        self.descriptionTextView.text = self.hero.heroDescription;
    }
    
    if ([self.hero.wikipediaURL isEqualToString:@""]) {
        [self.wikiButton setEnabled:false];
    } else {
        [self.wikiButton setEnabled:true];
    }
    
    if ([self.hero.characterResourceURL isEqualToString: @""]) {
        [self.resourceButton setEnabled:false];
    } else {
        [self.resourceButton setEnabled:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
