//
//  ViewController.m
//  Simple Form
//
//  Created by Alan Ihre on 2013-10-30.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setFormDelegate:self];
    
    [self.tableView setTitle:@"Personal" forSectionAtIndex:0];
    
    TableFormItem *firstName = [[TableFormItem alloc] initWithType:TableFormItemTypeTextField];
    firstName.key = @"firstName";
    firstName.title = @"First Name";
    [self.tableView addFormItem:firstName];
    
    TableFormItem *lastName = [[TableFormItem alloc] initWithType:TableFormItemTypeTextField];
    lastName.key = @"lastName";
    lastName.title = @"Last Name";
    [self.tableView addFormItem:lastName];
    
    TableFormItem *gender = [[TableFormItem alloc] initWithType:TableFormItemTypeSegmented];
    gender.key = @"gender";
    gender.title = @"Gender";
    gender.avalibleValues = @[@"Male", @"Female"];
    [self.tableView addFormItem:gender];
    
    TableFormItem *age = [[TableFormItem alloc] initWithType:TableFormItemTypeDatePicker];
    age.key = @"age";
    age.title = @"Age";
    age.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    age.dateFormatter = dateFormatter;
    age.expandable = YES;
    [self.tableView addFormItem:age];
    
    TableFormItem *submitButton = [[TableFormItem alloc] initWithType:TableFormItemTypeButton];
    submitButton.key = @"submit";
    submitButton.title = @"Submit form";
    [self.tableView addFormItem:submitButton toSectionAtIndex:1];
}

- (void)tableForm:(TableForm *)tableForm editingBeganForFormItem:(TableFormItem *)formItem{

}

- (void)tableForm:(TableForm *)tableForm editingEndedForFormItem:(TableFormItem *)formItem{

}

- (void)tableForm:(TableForm *)tableForm didSelectCellForFormItem:(TableFormItem *)formItem{
    if([formItem.key isEqualToString:@"submit"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Form submitted" message:@"The for was successfully submitted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)tableForm:(TableForm *)tableForm valueChangedForFormItem:(TableFormItem *)formItem{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
