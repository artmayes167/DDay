//
//  NDDatePickerViewController.h
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/22/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

@protocol NDDatePickerViewControllerDelegate  <NSObject>

-(void)getSelectedDateFromDatePicker:(NSString *)selectedDate forTitle:(NSString *)title;

@end

@interface NDDatePickerViewController : UIViewController

@property (nonatomic,assign)id<NDDatePickerViewControllerDelegate>delegate;

@property (nonatomic,assign) enum NDDateType dateType;
@property (nonatomic,strong) NSDate *selectedDate;
@property (nonatomic,strong) NSDate *maxDate;
@property (nonatomic,strong) NSDate *minDate;



@property (nonatomic,assign) NSString *titleString;

@end
