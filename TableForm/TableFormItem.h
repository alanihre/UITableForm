//
//  TableFormItem.h
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-27.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TableFormItemType) {
    TableFormItemTypeTextField,
    TableFormItemTypeDatePicker,
    TableFormItemTypeCheckmark,
    TableFormItemTypeMultipleSelection,
    TableFormItemTypeMultipleSelectionModal,
    TableFormItemTypeCustom,
    TableFormItemTypeButton,
    TableFormItemTypeValueLabel,
    TableFormItemTypeSegmented,
    TableFormItemTypeSlider,
    TableFormItemTypeStepper
};

@interface TableFormItem : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) id value;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *customCellReuseIdentifier;
@property (nonatomic, retain) UINib *customCellNib;

@property (nonatomic) BOOL expandable;
@property (nonatomic) BOOL expanded;

@property (nonatomic, strong) NSArray *avalibleValues;

@property (nonatomic) UIDatePickerMode datePickerMode;
@property (nonatomic) NSDateFormatter *dateFormatter;

@property (nonatomic) UISegmentedControlStyle segmentedControlStyle;

@property (nonatomic, strong) NSNumber *minValue;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) NSNumber *step;

@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIReturnKeyType keyboardReturnKeyType;
@property (nonatomic) BOOL secureTextEntry;

@property (assign, nonatomic) TableFormItemType type;

- (id)initWithType:(TableFormItemType)theType;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
