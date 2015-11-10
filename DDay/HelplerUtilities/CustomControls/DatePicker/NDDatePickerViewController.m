//
//  NDDatePickerViewController.m
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/22/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NDDatePickerViewController.h"
#import "UIColor+HexColor.h"
#import "Styles.h"
#import "NSDate+Utilities.h"

@interface NDDatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIView *navHeaderView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation NDDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setDatePickerStyles];
    [self setDatePickerProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDatePickerProperties{
    
    if (self.dateType == kTimeType) {
        self.headerLabel.text = @"Select Time";
        self.datePicker.datePickerMode = UIDatePickerModeTime;
        if (self.selectedDate != nil ) {
            [self.datePicker setDate:self.selectedDate];
        }
        if (self.maxDate != nil ) {
            [self.datePicker setMaximumDate:self.maxDate];
        }
        if (self.minDate != nil ) {
            [self.datePicker setMinimumDate:self.minDate];
        }
        [self.datePicker setMinuteInterval:30];
    } else {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.headerLabel.text = self.titleString;

    }
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:kCalendarLocale];
    self.datePicker.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:kCalendarType];

}

-(void)setDatePickerStyles{
    
    self.navHeaderView.backgroundColor = [UIColor colorWithHexString:kNavBarHeaderColor];
    
}

- (IBAction)closeAction:(id)sender {
    
    [self dismissViewController];
}

- (IBAction)doneAction:(id)sender {
    
    [self.delegate getSelectedDateFromDatePicker:[self getFormattedDate:self.datePicker.date] forTitle:self.title];
    [self dismissViewController];
}


-(void)dismissViewController{
    
       [self dismissViewControllerAnimated:true completion:nil];
}

-(NSString *)getFormattedDate:(NSDate *)date{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:kCalendarLocale]];
//    [formatter setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:kCalendarType]];
//    if (self.dateType == kDateType) {
//        [formatter setDateFormat:kDateFormat];
//    } else {
//        [formatter setDateFormat:kTimeFormat];
//    }
    return [date longDateString]; //[formatter stringFromDate:date];
}

@end
