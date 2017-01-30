//
//  HeroWebInfoViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/30/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroWebInfoViewController.h"

@interface HeroWebInfoViewController ()

@end

@implementation HeroWebInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString: self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
