//
//  AddViewController.m
//  Labb3
//
//  Created by Tobias Hillén on 2017-01-23.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *activityName;
@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic) BOOL importance;
@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.importantSwitch setOn:NO animated:YES];
    self.importance = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)add:(UIButton *)sender {
    if (![self.activityName.text isEqualToString:@""]) {
        NSMutableDictionary* newActivity = [[NSMutableDictionary alloc] init].mutableCopy;
        [newActivity setObject:self.activityName.text forKey:@"Activity"];
        [newActivity setObject:[NSNumber numberWithBool:self.importance] forKey:@"Important"];
        [newActivity setObject:[NSNumber numberWithBool:NO] forKey:@"Done"];
        [self.activities addObject:newActivity];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:self.activities forKey:@"Activities"];
        [userDefault synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)importantTrueOrFalse:(UISwitch *)sender {
    if ([sender isOn]) {
        self.importance = YES;
    } else {
        self.importance = NO;
    }
}
@end
