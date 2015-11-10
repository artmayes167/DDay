//
//  NDDropDownViewController.m
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/22/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NDDropDownViewController.h"
#import "UIColor+HexColor.h"
#import "Styles.h"
#import "CommonDefines.h"

@interface NDDropDownViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITableView *dropDownTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *navHeaderView;

@end

@implementation NDDropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navHeaderView.backgroundColor = [UIColor colorWithHexString:kNavBarHeaderColor];
    self.titleLbl.text = self.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonAction:(id)sender {
      [self dismissViewController];
}

- (IBAction)doneButtonAction:(id)sender {
    
    switch (self.dropDownType) {
        case kMaterialDropDown:
        [self.delegate showMoMaterialView];
            break;
        case kLocationDropDown:
            break;
        default:
            break;
    }
    [self dismissViewController];
}

-(void)dismissViewController{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.dropDownType) {
        default:
            return self.dropDownDataSource.count;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropdowncell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dropdowncell"];
    }
    switch (self.dropDownType) {
        default:
        {
            cell.textLabel.text = [self.dropDownDataSource objectAtIndex:indexPath.row];
            
        }
            break;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    switch (self.dropDownType) {
        default:
        {
            NSString *str = [self.dropDownDataSource objectAtIndex:indexPath.row];
            [self.delegate getSelectedItem:str fromDropDown:self atIndex:indexPath.row];
            [self dismissViewController];
        }
            break;
    }

}

@end
