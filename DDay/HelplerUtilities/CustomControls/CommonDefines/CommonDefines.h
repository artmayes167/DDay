//
//  CommonDefines.h
//  Nidec
//
//  Created by Kumar Vijayakumar, D. on 10/16/15.
//  Copyright © 2015 Kumar Vijayakumar, D. All rights reserved.
//

#ifndef CommonDefines_h
#define CommonDefines_h

enum MenuItems {
    
    kGoodsReceiptItem = 0,
    kMoveLocationItem,
    kMOConfirmationItem,
    kConsumeDisposalItem,
    kQualityControlItem,
    kDeliveryPickingItem,
    kPhysicalInventoryItem,
    kTraceabilityItem,
    kSettingsItem,
    kLogoutItem
    
};

enum GoodsReceiptMenuItems {
    
    kGR_PrintPoIdTags = 0,
    kGR_GoodsReceipt,
    kGR_History
    
};

enum MOConfirmationMenuItems {
    
    kMO_MOIssue = 0,
    kMO_MOConfirmation,
    kMO_MOHistory
    
};


enum NDDateType {
    kDateType = 0,
    kTimeType
};
enum NDDropDownType{
    
    kMaterialDropDown,
    kLocationDropDown,
    kTimeDropDown,
    kReasonDropDown,
    kYieldQunatity,
    kDefectQunatity,
    kLotNumber,
    kNumberOfEmployee,
    kBreakTimeDropDown
};

/*sample users ID's */
//@start{
#define kUser1  NSLocalizedString(@"K100028730     A_QLIU",@"")
#define kUser2  NSLocalizedString(@"K100035984     A_SANDY",@"")
#define kUser3  NSLocalizedString(@"K100049320     A_KSATO",@"")
#define kUser4  NSLocalizedString(@"K100024365     A_TYAMADA",@"")
//@end}

#define kUserID NSLocalizedString(@"UserID",@"")
#define kPassword NSLocalizedString(@"Password",@"")
#define kLogin NSLocalizedString(@"Login",@"")
#define kForgotPassword NSLocalizedString(@"Forgot Password",@"")
#define kLogout NSLocalizedString(@"Logout",@"")
#define kSettings NSLocalizedString(@"Settings",@"")
#define kMenu NSLocalizedString(@"Menu",@"")
#define kTask NSLocalizedString(@"Task",@"")
#define kSelectFromMenu NSLocalizedString(@"Select Task",@"")

#define kGoodsReceipt NSLocalizedString(@"Goods Receipt",@"")
#define kMoveLocation NSLocalizedString(@"Move Location",@"")
#define kConsumeDisposal NSLocalizedString(@"Consume / Disposal",@"")
#define kMOConfirmation NSLocalizedString(@"MO Confirmation",@"")
#define kQualityControl NSLocalizedString(@"Quality Control",@"")
#define kDeliveryPicking NSLocalizedString(@"Delivery / Picking",@"")
#define kPhysicalInventory NSLocalizedString(@"Physical Inventory",@"")
#define kTraceability NSLocalizedString(@"Traceability",@"")
#define kHello NSLocalizedString(@"Hello",@"")
#define kSettings NSLocalizedString(@"Settings",@"")
#define kLoginWithBAPI NSLocalizedString(@"URL",@"")
#define kSmartManufacturingPlatform NSLocalizedString(@"Smart Manufacturing Platform",@"")


//Goods Receipt sub menu
#define kGoodsReceipt_PrintTags NSLocalizedString(@"Print Po Tags",@"")
#define kGoodsReceipt_GRHistory NSLocalizedString(@"GR History",@"")

//MO Confirmation sub menu
#define kMOConfirmation_MOHistory NSLocalizedString(@"MO Issue History",@"")
#define kMOConfirmation_MOIssues NSLocalizedString(@"MO Issue",@"")

//MO Settings sub menu
#define kSettingsDefaultPlant  NSLocalizedString(@"Default Plant",@"")
#define kSettingsDefaultMvpt  NSLocalizedString(@"Default MVT Type",@"")
#define kSettingsMyMoMaterial  NSLocalizedString(@"My MO Material",@"")
#define kSettingsLocation  NSLocalizedString(@"Location",@"")
#define kSettingsMyCostCenter  NSLocalizedString(@"My Cost Center",@"")
#define kSettingsProposalMO  NSLocalizedString(@"Proposal MO",@"")

#define kArrowHideImage @"arrow-hide.png"
#define kArrowShowImage @"arrow-show.png"

// Beacons

#define kBeaconNameKey @"beaconName"
#define kUUIDKey @"uuid"
#define kMajorKey @"major"
#define kMinorKey @"minor"


//@start{
//Network Switch
#define kFixturesEnvironment @"F"
#define kTestingEnvironment @"T"
#define kProductionEnvironment @"P"
//@end


//NSUserdefaults Keys
#define kBAPIUrlKey @"BAPIURLKey"

#define kCalendarType NSCalendarIdentifierGregorian
#define kCalendarLocale @"en_EN"
#define kDateFormat @"MM/dd/yyyy"
#define kTimeFormat @"HH:mm"

#define kMenuShadowLaunchKey @"shadow"

#endif /* CommonDefines_h */
