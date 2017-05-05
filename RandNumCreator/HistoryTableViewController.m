//
//  HistoryTableViewController.m
//  RandNumCreator
//
//  Created by 姚宇鴻 on 2017/4/25.
//  Copyright © 2017年 JordanYao. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryTableViewCell.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController{
    NSMutableArray *numMutArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //取用  Managed Object Context
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
    
    //取用 Entity Description
    //建立一個fetch request，指定提取的entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext: managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    //這裡用mutableArray，所以有稍微改寫
    NSMutableArray *fetchedObjects = [[ managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (fetchedObjects == nil) {
        NSLog(@"Fetch error, something's wrong. %@",error);
    }
    
    numMutArray = fetchedObjects;
    
    [self.tableView reloadData];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [numMutArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //設定Cell
    NSManagedObject *numArr = [numMutArray objectAtIndex:indexPath.row];
    cell.numLabel.text = [numArr valueForKey:@"number"];
    
    
    return cell;
}

- (IBAction)Delete:(UIBarButtonItem *)sender
{
    [self JumpAlert_BeforeDelete];
}

-(void)JumpAlert_BeforeDelete{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"" message:@"資料將清空，是否繼續？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"繼續" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
        //按鈕按下去之後執行的動作
        [self dismissViewControllerAnimated:YES completion:nil];
        
        //取用  Managed Object Context
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
        
        //取用 Entity Description
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext: managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSError *error = nil;
        NSMutableArray *fetchedObjects = [[ managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
        if(fetchedObjects==nil){
            NSLog(@"Delete error, something's wrong. %@",error);
        }
        
        //刪除Core data全部資料
        for(NSManagedObject *num in fetchedObjects){
            [managedObjectContext deleteObject:num];
        }
        
        [numMutArray removeAllObjects];
        [self.tableView reloadData];


    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *alertAction){
        //按鈕按下去之後執行的動作
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //把兩個按鈕加到controller
    [alert addAction:alertAction];
    [alert addAction:cancelAction];
    //顯示controller
    [self presentViewController:alert animated:YES completion:nil];
    
}






@end
