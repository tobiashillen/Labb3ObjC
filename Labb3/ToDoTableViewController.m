//
//  ToDoTableViewController.m
//  Labb3
//
//  Created by Tobias Hillén on 2017-01-23.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"

@interface ToDoTableViewController ()
@property (nonatomic) NSMutableArray* activities;
@end

@implementation ToDoTableViewController


-(NSMutableArray*)activities {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    if(!_activities) {
        if ([userDefault objectForKey:@"Activities"]) {
            _activities = [[userDefault objectForKey:@"Activities"] mutableCopy];
        } else {
            _activities = [[NSMutableArray alloc]init];
        }
    }
    return _activities;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To-Do";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if ([[self.activities[indexPath.row] objectForKey:@"Done"] boolValue]) {
        cell.textLabel.text = [NSString stringWithFormat:@"Klar: %@!",
                               [self.activities[indexPath.row] objectForKey:@"Activity"]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Att göra: %@!",
                               [self.activities[indexPath.row] objectForKey:@"Activity"]];
    }
    
    if ([[self.activities[indexPath.row] objectForKey:@"Important"] boolValue]) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Add"]){
        AddViewController *addVC = [segue destinationViewController];
        addVC.activities = self.activities;
    } else if ([segue.identifier isEqualToString:@"Edit"]) {
        EditViewController *editVC = [segue destinationViewController];
        UITableViewCell *cell = sender;
        NSIndexPath *index = [self.tableView indexPathForCell:cell];
        int row = (int) index.row;
        editVC.taskId = row;
        editVC.activities = self.activities;
        editVC.title  = [self.activities[row] objectForKey:@"Activity"];
    }
}


@end
