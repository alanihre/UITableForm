//
//  TableForm.m
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-28.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import "TableForm.h"
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation TableForm
@synthesize sections;

- (id)init{
    self = [super init];
    if(self){
        [self initForm];
    }
    return self;
}

- (void)awakeFromNib{
    [self initForm];
}

- (void)initForm{
    sections = [NSMutableArray new];
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"TableFormCellTextField" bundle:nil] forCellReuseIdentifier:@"TableFormCellTextField"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellCheckmark" bundle:nil] forCellReuseIdentifier:@"TableFormCellCheckmark"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellButton" bundle:nil]
        forCellReuseIdentifier:@"TableFormCellButton"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellDatePicker" bundle:nil] forCellReuseIdentifier:@"TableFormCellDatePicker"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellMultipleSelection" bundle:nil] forCellReuseIdentifier:@"TableFormCellMultipleSelection"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellSegmented" bundle:nil] forCellReuseIdentifier:@"TableFormCellSegmented"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellSegmented+Title" bundle:nil] forCellReuseIdentifier:@"TableFormCellSegmented+Title"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellSlider" bundle:nil]
        forCellReuseIdentifier:@"TableFormCellSlider"];
    [self registerNib:[UINib nibWithNibName:@"TableFormCellStepper" bundle:nil]
        forCellReuseIdentifier:@"TableFormCellStepper"];
}

- (NSArray *)formItems{
    NSMutableArray *formItemsTemp = [NSMutableArray new];
    for (TableFormSection *section in sections) {
        [formItemsTemp addObjectsFromArray:[section items]];
    }
    return [NSArray arrayWithArray:formItemsTemp];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[sections objectAtIndex:section] items] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sections count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableFormItem *formItem = [[[sections objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier;
    
    switch (formItem.type) {
        case TableFormItemTypeTextField:
            CellIdentifier = @"TableFormCellTextField";
            break;
        case TableFormItemTypeCheckmark:
            CellIdentifier = @"TableFormCellCheckmark";
            break;
        case TableFormItemTypeButton:
            CellIdentifier = @"TableFormCellButton";
            break;
        case TableFormItemTypeMultipleSelection:
            CellIdentifier = @"TableFormCellMultipleSelection";
            break;
        case TableFormItemTypeDatePicker:
            CellIdentifier = @"TableFormCellDatePicker";
            break;
        case TableFormItemTypeSlider:
            CellIdentifier = @"TableFormCellSlider";
            break;
        case TableFormItemTypeStepper:
            CellIdentifier = @"TableFormCellStepper";
            break;
        case TableFormItemTypeSegmented:{
            if (formItem.title != nil) {
                CellIdentifier = @"TableFormCellSegmented+Title";
            }else{
                CellIdentifier = @"TableFormCellSegmented";
            }
            break;
        }
        case TableFormItemTypeCustom:
            CellIdentifier = formItem.customCellReuseIdentifier;
            break;
        default:
            break;
    }

    TableFormCell *tableFormCell = [self dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //---create new cell if no reusable cell is available---
	if (tableFormCell == nil) {
        tableFormCell = [[TableFormCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
    tableFormCell.formItem = formItem;
    tableFormCell.formDelegate = self;
    
    return tableFormCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[sections objectAtIndex:section] title];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [[sections objectAtIndex:section] footer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableFormItem *formItem = [[[sections objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row];
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.formDelegate tableForm:self didSelectCellForFormItem:formItem];
    
    if(formItem.expandable == YES){
        if(formItem.expanded == YES){
            formItem.expanded = NO;
        }else{
            formItem.expanded = YES;
        }
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(formItem.expanded == YES){
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }else{
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableFormItem *formItem = [[[sections objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row];
    switch (formItem.type) {
        case TableFormItemTypeMultipleSelection:
        case TableFormItemTypeDatePicker:{
            if(((formItem.expandable == YES && formItem.expanded == YES) || formItem.expandable == NO)){
                if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
                    return 261;
                }else{
                    return 260;
                }
            }else{
                return 44;
            }
            break;
        }
        case TableFormItemTypeSegmented:{
            if (formItem.title != nil) {
                return 82;
            }else{
                return 44;
            }
            break;
        }
        case TableFormItemTypeSlider:
            return 88;
            break;
        default:
            return 44;
    }
}

- (void)addFormItem:(TableFormItem *)formItem{
    [self addFormItem:formItem animated:NO];
}

- (void)addFormItem:(TableFormItem *)formItem animated:(BOOL)animated{
    [self addFormItem:formItem toSectionAtIndex:0 animated:animated];
}

- (void)addFormItem:(TableFormItem *)formItem toSectionAtIndex:(int)sectionIndex{
    [self addFormItem:formItem toSectionAtIndex:sectionIndex animated:NO];
}

- (void)addFormItem:(TableFormItem *)formItem toSectionAtIndex:(int)sectionIndex animated:(BOOL)animated{
    [self beginUpdates];
    
    if([sections count] == 0 || [sections count]-1 < sectionIndex){
        TableFormSection *section = [[TableFormSection alloc] init];
        [sections addObject:section];
        [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if(formItem.type == TableFormItemTypeCustom){
        [self registerNib:formItem.customCellNib forCellReuseIdentifier:formItem.customCellReuseIdentifier];
    }
    
    [(TableFormSection *)[sections objectAtIndex:sectionIndex] addItem:formItem];
    int rowIndex = 0;
    if([[[sections objectAtIndex:sectionIndex] items] count] != 0){
        rowIndex = [[[sections objectAtIndex:sectionIndex] items] count]-1;
    }
    
    if(animated == YES){
        [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self endUpdates];
}

- (void)addNewSection{
    TableFormSection *section = [[TableFormSection alloc] init];
    [self addSection:section animated:NO];
}

- (void)addSection:(TableFormSection *)section{
    [self addSection:section animated:NO];
}

- (void)addSection:(TableFormSection *)section animated:(BOOL)animated{
    [sections addObject:section];
    int sectionIndex = 0;
    if([sections count] != 0){
        sectionIndex = [sections count]-1;
    }
    
    [self beginUpdates];
    if(animated == YES){
        [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self endUpdates];
}

- (void)setTitle:(NSString *)title forSectionAtIndex:(int)sectionIndex{
    [self beginUpdates];
    
    if([sections count] == 0 || [sections count]-1 < sectionIndex){
        TableFormSection *section = [[TableFormSection alloc] init];
        [sections addObject:section];
        [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [[sections objectAtIndex:sectionIndex] setTitle:title];
    [self reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    
    [self endUpdates];
}

- (void)editingBeganForFormItem:(TableFormItem *)formItem{
    [self.formDelegate tableForm:self editingBeganForFormItem:formItem];
}

- (void)valueChangedForFormItem:(TableFormItem *)formItem{
    [self.formDelegate tableForm:self valueChangedForFormItem:formItem];
}

- (void)editingEndend:(TableFormItem *)formItem{
    if(formItem.type == TableFormItemTypeButton){
        [self.formDelegate tableForm:self didSelectCellForFormItem:formItem];
    }else{
        [self.formDelegate tableForm:self editingEndend:formItem];
    }
}

@end
