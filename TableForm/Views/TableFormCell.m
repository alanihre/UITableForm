 //
//  TableFormCell.m
//  Elevkårsadministration
//
//  Created by Alan Ihre on 2013-10-27.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import "TableFormCell.h"
#import <QuartzCore/QuartzCore.h>
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation TableFormCell
@synthesize formItem;

- (void)awakeFromNib{
    [super awakeFromNib];
}

-(id)initWithReuseIdentifier:(NSString *)theReuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:theReuseIdentifier];
    if (self){
        formItem = nil;
    }
    return self;
}

- (void)setFormItem:(TableFormItem *)theFormItem{
    if (![formItem isEqual:theFormItem]) {
        formItem = theFormItem;
        switch (formItem.type) {
            case TableFormItemTypeTextField:{
                [(UITextField *)self.inputElement setPlaceholder:formItem.title];
                [(UITextField *)self.inputElement setText:formItem.value];
                [(UITextField *)self.inputElement setKeyboardType:formItem.keyboardType];
                [(UITextField *)self.inputElement setReturnKeyType:formItem.keyboardReturnKeyType];
                break;
            }
            case TableFormItemTypeCheckmark:{
                [titleLabel setText:formItem.title];
                if([formItem.value boolValue] == YES){
                    [(UISwitch *)self.inputElement setOn:YES];
                }else if([formItem.value boolValue] == NO){
                    [(UISwitch *)self.inputElement setOn:NO];
                }else{
                    formItem.value = [NSNumber numberWithBool:NO];
                    [(UISwitch *)self.inputElement setOn:NO];
                }
                break;
            }
            case TableFormItemTypeButton:{
                [(UIButton *)self.inputElement setTitle:formItem.title forState:UIControlStateNormal];
                break;
            }
            case TableFormItemTypeDatePicker:{
                if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
                    NSLog(@"TableFormItemTypeDatePicker is not supported for iOS versions lower than 7.0.");
                }
                
                [(UIDatePicker *)self.inputElement setDatePickerMode:formItem.datePickerMode];
                
                if(formItem.value != nil){
                    [(UIDatePicker *)self.inputElement setDate:formItem.value];
                }else{
                    formItem.value = [(UIDatePicker *)self.inputElement date];
                }
                
                [titleLabel setText:formItem.title];
                
                if(formItem.dateFormatter != nil){
                    [valueLabel setText:[formItem.dateFormatter stringFromDate:formItem.value]];
                }else{
                    NSString *dateString = [NSDateFormatter localizedStringFromDate:formItem.value
                                                                          dateStyle:NSDateFormatterShortStyle
                                                                          timeStyle:NSDateFormatterShortStyle];
                    [valueLabel setText:dateString];
                }
                break;
            }
            case TableFormItemTypeMultipleSelection:{
                if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
                    NSLog(@"TableFormItemTypeMultipleSelection is not supported for iOS versions lower than 7.0.");
                }
                [(UIPickerView *)self.inputElement reloadComponent:0];
                if(formItem.value != nil){
                    for (int r = 0; r<[formItem.avalibleValues count]; r++) {
                        if ([[formItem.avalibleValues objectAtIndex:r] isEqualToString:formItem.value]) {
                            [(UIPickerView *)self.inputElement selectRow:r inComponent:0 animated:NO];
                            break;
                        }
                    }
                }else{
                    if([formItem.avalibleValues count] > 0){
                        formItem.value = [formItem.avalibleValues objectAtIndex:0];
                    }
                }
                [titleLabel setText:formItem.title];
                if([formItem.value isKindOfClass:[NSString class]]){
                    [valueLabel setText:formItem.value];
                }else{
                    [valueLabel setText:[formItem.value stringValue]];
                }
                break;
            }
            case TableFormItemTypeSlider:{
                if(formItem.minValue != nil){
                    [(UISlider *)self.inputElement setMinimumValue:[formItem.minValue floatValue]];
                }
                if(formItem.maxValue != nil){
                    [(UISlider *)self.inputElement setMaximumValue:[formItem.maxValue floatValue]];
                }
                
                if(formItem.value != nil){
                    [(UISlider *)self.inputElement setValue:[formItem.value floatValue]];
                }else{
                    [formItem setValue:[NSNumber numberWithFloat:[(UISlider *)self.inputElement value]]];
                }
                [titleLabel setText:formItem.title];
                [valueLabel setText:[formItem.value stringValue]];
                break;
            }
            case TableFormItemTypeStepper:{
                if(formItem.minValue != nil){
                    [(UIStepper *)self.inputElement setMinimumValue:[formItem.minValue floatValue]];
                }
                if(formItem.maxValue != nil){
                    [(UIStepper *)self.inputElement setMaximumValue:[formItem.maxValue floatValue]];
                }
                if(formItem.step != nil){
                    [(UIStepper *)self.inputElement setStepValue:[formItem.step floatValue]];
                }
                
                if(formItem.value != nil){
                    [(UIStepper *)self.inputElement setValue:[formItem.value floatValue]];
                }else{
                    [formItem setValue:[NSNumber numberWithFloat:[(UIStepper *)self.inputElement value]]];
                }
                [titleLabel setText:formItem.title];
                [valueLabel setText:[formItem.value stringValue]];
                break;
            }
                
            case TableFormItemTypeValueLabel:{
                [titleLabel setText:formItem.title];
                [valueLabel setText:[formItem.value stringValue]];
                break;
            }
            case TableFormItemTypeSegmented:{
                if (formItem.title != nil) {
                    [titleLabel setText:formItem.title];
                }
                if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
                    [(UISegmentedControl *)self.inputElement setSegmentedControlStyle:formItem.segmentedControlStyle]; //For older iOS versions
                }
                [(UISegmentedControl *)self.inputElement removeAllSegments];
                for (int segment=0; segment<[formItem.avalibleValues count]; segment++) {
                    [(UISegmentedControl *)self.inputElement insertSegmentWithTitle:[formItem.avalibleValues objectAtIndex:segment] atIndex:segment animated:NO];
                }
                if(formItem.value != nil){
                    for (int s = 0; s<[formItem.avalibleValues count]; s++) {
                        if ([[formItem.avalibleValues objectAtIndex:s] isEqualToString:formItem.value]) {
                            [(UISegmentedControl *)self.inputElement setSelectedSegmentIndex:s];
                            break;
                        }
                    }
                }
                break;
            }
            default:
                break;
        }
    }else{
        formItem = theFormItem;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.formDelegate respondsToSelector:@selector(editingBeganForFormItem:)])
        [self.formDelegate editingBeganForFormItem:formItem];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [formItem setValue:textField.text];
    if ([self.formDelegate respondsToSelector:@selector(editingEndedForFormItem:)])
        [self.formDelegate editingEndedForFormItem:formItem];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [formItem setValue:textField.text];
    if ([self.formDelegate respondsToSelector:@selector(valueChangedForFormItem:)])
        [self.formDelegate valueChangedForFormItem:formItem];
    return YES;
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)textField{
    if ([self.formDelegate respondsToSelector:@selector(returnKeyPressedForFormItem:)]) {
        [self.formDelegate returnKeyPressedForFormItem:self.formItem];
    }else{
        [textField resignFirstResponder];
    }
}

- (IBAction)buttonClicked:(id)sender{
    if ([self.formDelegate respondsToSelector:@selector(editingEndedForFormItem:)])
        [self.formDelegate editingEndedForFormItem:formItem];
}

- (IBAction)valueChanged:(id)sender{
    if ([sender isKindOfClass:[UIDatePicker class]]) {
        [formItem setValue:[(UIDatePicker *)sender date]];
        
        if(formItem.dateFormatter != nil){
            [valueLabel setText:[formItem.dateFormatter stringFromDate:formItem.value]];
        }else{
            NSString *dateString = [NSDateFormatter localizedStringFromDate:formItem.value
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterShortStyle];
            [valueLabel setText:dateString];
        }
    }else{
        if ([sender isKindOfClass:[UITextField class]]) {
            [formItem setValue:[(UITextField *)sender text]];
        }else if ([sender isKindOfClass:[UITextView class]]) {
            [formItem setValue:[(UITextView *)sender text]];
        }else if ([sender isKindOfClass:[UIStepper class]]) {
            [formItem setValue:[[NSNumber numberWithDouble:[(UIStepper *)sender value]] stringValue]];
        }else if ([sender isKindOfClass:[UISwitch class]]) {
            [formItem setValue:[NSNumber numberWithBool:[(UISwitch *)sender isOn]]];
        }else if ([sender isKindOfClass:[UISlider class]]) {
            [formItem setValue:[[NSNumber numberWithDouble:[(UISlider *)sender value]] stringValue]];
        }else if ([sender isKindOfClass:[UISegmentedControl class]]) {
            if (formItem.avalibleValues != nil) {
                [formItem setValue:[formItem.avalibleValues objectAtIndex:[(UISegmentedControl *)sender selectedSegmentIndex]]];
            }else{
                [formItem setValue:[NSNumber numberWithInteger:[(UISegmentedControl *)sender selectedSegmentIndex]]];
            }
        }
        [valueLabel setText:formItem.value];
    }
    [self.formDelegate valueChangedForFormItem:formItem];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [formItem.avalibleValues count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [formItem.avalibleValues objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    formItem.value = [formItem.avalibleValues objectAtIndex:row];
    valueLabel.text = formItem.value;
    [titleLabel sizeToFit];
    [valueLabel sizeToFit];
    [self.formDelegate valueChangedForFormItem:formItem];
}

@end
