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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
