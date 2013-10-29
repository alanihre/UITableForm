//
//  TableFormCell.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-27.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableFormItem.h"
#import "TableFormCellDelegate.h"

@interface TableFormCell : UITableViewCell <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    IBOutlet UILabel *titleLabel;
    IBOutlet id inputElement;
    IBOutlet UILabel *valueLabel;
}

@property (retain) NSObject <TableFormCellDelegate> *formDelegate;

@property (nonatomic, retain) TableFormItem *formItem;

@property (nonatomic, retain) NSString *title;

-(id)initWithReuseIdentifier:(NSString *)theReuseIdentifier;

- (void)setFormItem:(TableFormItem *)theFormItem;

- (IBAction)textFieldDidEndOnExit:(UITextField *)textField;

- (IBAction)valueChanged:(id)sender;

- (IBAction)buttonClicked:(id)sender;

@end
