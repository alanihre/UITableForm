//
//  TableForm.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableFormDelegate.h"
#import "TableFormItem.h"
#import "TableFormSection.h"
#import "TableFormCell.h"

@interface TableForm : UITableView <UITableViewDelegate, UITableViewDataSource, TableFormCellDelegate>{
    NSMutableDictionary *formItems;
    NSMutableArray *sections;
}

@property (nonatomic, strong, readonly) NSDictionary *formItems;

@property (retain) NSObject <TableFormDelegate> *formDelegate;


- (void)addFormItem:(TableFormItem *)formItem;
- (void)addFormItem:(TableFormItem *)formItem animated:(BOOL)animated;
- (void)addFormItem:(TableFormItem *)formItem toSectionAtIndex:(int)sectionIndex;
- (void)addFormItem:(TableFormItem *)formItem toSectionAtIndex:(int)sectionIndex animated:(BOOL)animated;

- (void)addNewSection; //The methods above automatically creates new sections when necessary
- (void)addSection:(TableFormSection *)section;
- (void)addSection:(TableFormSection *)section animated:(BOOL)animated;
- (void)setTitle:(NSString *)title forSectionAtIndex:(int)sectionIndex;

- (void)updateFormItemWithKey:(NSString *)key withFormItem:(TableFormItem *)formItem;
- (void)updateFormItemWithKey:(NSString *)key withFormItem:(TableFormItem *)formItem animated:(BOOL)animated;

- (id)valueForFormItemWithKey:(NSString *)key;

- (id)init;

@end
