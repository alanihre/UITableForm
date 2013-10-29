//
//  TableFormSection.m
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import "TableFormSection.h"

@implementation TableFormSection
@synthesize items;

- (id)init{
    self = [super init];
    if(self){
        items = [NSMutableArray new];
    }
    return self;
}

- (void)addItem:(TableFormItem *)formItem{
    [items addObject:formItem];
}

@end
