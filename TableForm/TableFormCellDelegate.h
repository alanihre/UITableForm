//
//  TableFormCellDelegate.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableFormItem;

/*!
 @abstract Formal protocol that must be implemented by delegates of TableFormCellDelegate
 */
@protocol TableFormCellDelegate

- (void)valueChangedForFormItem:(TableFormItem *)formItem;

- (void)editingBeganForFormItem:(TableFormItem *)formItem;

- (void)editingEndedForFormItem:(TableFormItem *)formItem;

- (void)returnKeyPressedForFormItem:(TableFormItem *)formItem;

@end

