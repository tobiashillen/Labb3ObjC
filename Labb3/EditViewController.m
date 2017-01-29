//
//  EditViewController.m
//  Labb3
//
//  Created by Tobias Hillén on 2017-01-29.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UISwitch *doneSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *importanceSwitch;

@property (nonatomic) NSString* name;
@property (nonatomic) BOOL done;
@property (nonatomic) BOOL important;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskName.text = [self.activities[self.taskId] objectForKey:@"Activity"];
    
    // Setting up importance switch according to data.
   if ([[self.activities[self.taskId] objectForKey:@"Important"] boolValue]) {
        [self.importanceSwitch setOn:YES animated:YES];
    } else {
        [self.importanceSwitch setOn:NO animated:YES];
    }
    NSLog(@"%@", [self.activities[self.taskId] objectForKey:@"Important"]);
    
    // Setting up done switch according to data.
    if ([[self.activities[self.taskId] objectForKey:@"Done"] boolValue]) {
        [self.doneSwitch setOn:YES animated:YES];
    } else {
        [self.doneSwitch setOn:NO animated:YES];
    }
    NSLog(@"%@", [self.activities[self.taskId] objectForKey:@"Done"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)importantTrueOrFalse:(UISwitch *)sender {
    if ([sender isOn]) {
        self.important = YES;
    } else if (![sender isOn]){
        self.important = NO;
    }

}
- (IBAction)doneTrueOrFalse:(UISwitch *)sender {
    if ([sender isOn]) {
        self.done = YES;
    } else if (![sender isOn]){
        self.done = NO;
    }
}

- (IBAction)delete:(UIButton *)sender {
    [self.activities removeObjectAtIndex:self.taskId];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.activities forKey:@"Activities"];
    [userDefault synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(UIButton *)sender {
        if (![self.taskName.text isEqualToString:@""]) {
            NSMutableDictionary* editedTask = [self.activities[self.taskId]mutableCopy];
            [editedTask setValue:self.taskName.text forKey:@"Activity"];
            [editedTask setObject:[NSNumber numberWithBool:self.important] forKey:@"Important"];
            [editedTask setObject:[NSNumber numberWithBool:self.done] forKey:@"Done"];
            [self.activities removeObjectAtIndex:self.taskId];
            [self.activities insertObject:editedTask atIndex:self.taskId];

            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:self.activities forKey:@"Activities"];
            [userDefault synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
