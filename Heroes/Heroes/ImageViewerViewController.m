//
//  WebImageViewerViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/30/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "ImageViewerViewController.h"
#import "ImageGetter.h"

@interface ImageViewerViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ImageGetter *imageGetter;

@end

@implementation ImageViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // ScrollView Setup
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.scrollEnabled = true;
    self.scrollView.contentSize = self.imageView.image.size;
    [self.view addSubview: self.scrollView];
    [self scrollViewConstraints];
    
    // ImageView Setup
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview: self.imageView];
    
    // Image Setup
    NSString *completeImageURLString = [NSString stringWithFormat:@"%@/portrait_incredible.jpg", self.imageURL];
    
    self.imageGetter = [[ImageGetter alloc] initWithURLString:completeImageURLString];
    
    [self.imageGetter getImage:^(UIImage *heroThumbnail) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.imageView.image = heroThumbnail;
        });
    }];
    
    // Close Button
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    [closeButton setTitle:@"X" forState: UIControlStateNormal];
    [closeButton.titleLabel setTextColor: [UIColor whiteColor]];
    [closeButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [closeButton addTarget:self action:@selector(dismissSelf) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

- (void) scrollViewConstraints {
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissSelf {
    
    [UIView animateWithDuration:.45 animations:^{self.view.transform = CGAffineTransformMakeScale(.01, .01);
        self.navigationController.navigationBar.hidden = true;
        self.view.alpha = 0;
    }
                     completion:^(BOOL finished) {
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }];
    
}

#pragma mark - ScrollView Delegate

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
