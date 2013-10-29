//
//  TableFormSection.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableFormItem.h"

@interface TableFormSection : NSObject

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *footer;

- (void)addItem:(TableFormItem *)formItem;

@end
