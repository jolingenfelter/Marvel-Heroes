//
//  WebImageViewerViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/30/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "ImageViewerViewController.h"
#import "ImageGetter.h"

@interface ImageViewerViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ImageGetter *imageGetter;

@end

@implementation ImageViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ImageView Setup
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self imageViewConstraints];
    
    // Image Setup
    NSString *completeImageURLString = [NSString stringWithFormat:@"%@/portrait_incredible.jpg", self.imageURL];
    
    self.imageGetter = [[ImageGetter alloc] initWithURLString:completeImageURLString];
    
    [self.imageGetter getImage:^(UIImage *heroThumbnail) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.imageView.image = heroThumbnail;
        });
    }];
    
    // NavBarSetup
    self.navigationController.hidesBarsOnTap = true;
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style: UIBarButtonItemStyleDone target: self action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = closeButton;
}

- (void) imageViewConstraints {
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissSelf {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
