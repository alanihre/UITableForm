//
//  TableFormDelegate.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableForm;
@class TableFormItem;

/*!
 @abstract Formal protocol that must be implemented by delegates of TableFormDelegate
 */
@protocol TableFormDelegate

@optional
- (void)tableForm:(TableForm *)tableForm valueChangedForFormItem:(TableFormItem *)formItem;

- (void)tableForm:(TableForm *)tableForm editingBeganForFormItem:(TableFormItem *)formItem;

- (void)tableForm:(TableForm *)tableForm editingEndedForFormItem:(TableFormItem *)formItem;

- (void)tableForm:(TableForm *)tableForm didSelectCellForFormItem:(TableFormItem *)formItem;

@end
