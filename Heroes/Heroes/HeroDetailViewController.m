//
//  HeroDetailViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "ImageGetter.h"
#import "HeroWebInfoViewController.h"
#import "ImageViewerViewController.h"

@interface HeroDetailViewController ()

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navBarSetup];
    [self viewSetup];
    
    // Gesture Recognizer
    self.heroImageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayImageViewer)];
    [self.heroImageView addGestureRecognizer:tap];
}

- (void) navBarSetup {
    
    self.title = [NSString stringWithFormat:@"%@", self.hero.name];

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
    
    self.resourceButton.layer.cornerRadius = 3;
    self.resourceButton.layer.masksToBounds = true;
    
    self.wikiButton.layer.cornerRadius = 3;
    self.wikiButton.layer.masksToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    HeroWebInfoViewController *webInfoViewController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"ShowResource"]) {
       
        webInfoViewController.urlString = self.hero.characterResourceURL;
        
    }
    
    if ([segue.identifier isEqualToString:@"ShowWiki"]) {
        
        webInfoViewController.urlString = self.hero.wikipediaURL;
    }
}

#pragma mark - Gestures

- (void) displayImageViewer {
    
    ImageViewerViewController *imageViewer = [[ImageViewerViewController alloc] init];
    imageViewer.imageURL = self.hero.thumbnailPath;
    
    [self presentViewController:imageViewer animated:true completion:nil];

}

@end
