//
//  HeroesCollectionViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroesCollectionViewController.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface HeroesCollectionViewController ()

@end

@implementation HeroesCollectionViewController

static NSString * const reuseIdentifier = @"HeroCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationController.navigationBar.topItem.title = @"Marvel Heroes";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    // Initialize Variables
    self.heroClient = [[MarvelHeroClient alloc] init];
    self.heroesArray = [[NSMutableArray alloc] init];
    self.offset = 0;
    
    [self fetchHeroes];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch Heroes

- (void) fetchHeroes {
    
    [self.heroClient fetchHeroesWithOffset: self.offset completion:^(NSMutableArray *heroesArray, NSError *error) {
        
        if (error == nil) {
            
            self.heroesArray = heroesArray;
            
            self.offset += 20;
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self.collectionView reloadData];
            });
            
        } else {
            [self showAlertWithTitle:@"Error gathering heroes" andMessage: error.localizedDescription];
        }
        
    }];
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.heroClient fetchHeroesWithOffset:strongSelf.offset completion:^(NSMutableArray *heroesArray, NSError *error) {
            
            if (error == nil) {
                
                strongSelf.heroesArray = heroesArray;
                
                strongSelf.offset += 20;
                [strongSelf.collectionView.infiniteScrollingView stopAnimating];
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [strongSelf.collectionView reloadData];
                });
                
            } else {
                [strongSelf showAlertWithTitle:@"Error gathering heroes" andMessage:error.localizedDescription];
            }
            
        }];
    }];
    
}


 #pragma mark - Navigation
 
 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     NSArray *indexPaths = self.collectionView.indexPathsForSelectedItems;
     NSIndexPath *indexPath = indexPaths[0];
     HeroModel *hero = self.heroesArray[indexPath.row];
     NSLog(@"%@", hero.name);
 }


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.heroesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    HeroModel *hero = self.heroesArray[indexPath.row];
    
    // Configure the cell
    cell.imageURLString = hero.thumbnailPath;
    //[cell setImage];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [cell setImage];
    });
    
    
    return cell;
}

#pragma mark - Alert

- (void) showAlertWithTitle: (NSString *)title andMessage: (NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title message:message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:true completion:nil];
}
@end
