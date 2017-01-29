//
//  HeroesCollectionViewController.m
//  Heroes
//
//  Created by Joanna Lingenfelter on 1/29/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

#import "HeroesCollectionViewController.h"

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
            
            
            [self.collectionView reloadData];
            
        } else {
            [self showAlertWithTitle:@"Error gathering heroes" andMessage: error.localizedDescription];
        }
        
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
    [cell setImage];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HeroModel *hero = self.heroesArray[indexPath.row];
    NSLog(@"%@", hero.name);
}

#pragma mark - Alert

- (void) showAlertWithTitle: (NSString *)title andMessage: (NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title message:message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:true completion:nil];
}
@end
