//
//  NDDropDownViewController.h
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/22/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NDDropDownViewController;

@protocol NDDropDownViewControllerDelegate  <NSObject>

-(void)getSelectedItemFromDropDown:(NSString *)selectedItem atIndex:(int)index;
-(void)showMoMaterialView;
-(void)getSelectedItem:(NSString *)selectedItem fromDropDown:(NDDropDownViewController *)vc atIndex:(NSInteger)index;
@end

@interface NDDropDownViewController : UIViewController
@property (nonatomic,assign)id <NDDropDownViewControllerDelegate>delegate;
@property(nonatomic,retain)NSMutableArray *dropDownDataSource;
@property (nonatomic,retain)NSString *dropDownTitle;
@property (nonatomic,assign)enum NDDropDownType dropDownType;
@end
