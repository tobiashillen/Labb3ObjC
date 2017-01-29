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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@!",
                         [self.activities[indexPath.row] objectForKey:@"Activity"]];
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Add"]){
        AddViewController *addVC = [segue destinationViewController];
        addVC.activities = self.activities;
    } else if ([segue.identifier isEqualToString:@"Edit"]) {
        EditViewController *editVC = [segue destinationViewController];
        UITableViewCell *cell = sender;
        editVC.activities = self.activities;
        editVC.title = cell.textLabel.text;
        
        NSIndexPath *index = [self.tableView indexPathForCell:cell];
        int row = (int) index.row;
        editVC.taskId = row;


    }
    
}


@end
