//
//  TableFormItem.m
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-27.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import "TableFormItem.h"

@implementation TableFormItem

- (id)initWithType:(TableFormItemType)theType{
    self = [super init];
    if (self){
        self.type = theType;
    }
    return self;
}

@end
