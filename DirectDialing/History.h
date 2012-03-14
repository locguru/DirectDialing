//
//  History.h
//  DirectDialing
//
//  Created by Itai Ram on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsTabViewController.h"
#import "AccessNumber.h"



//@protocol HistoryDelegate  
//
//@required
//- (void) addNewItem:(NSString *)newProduct withNewBrand:(NSString *)newBrand;
//
////- (void)setPlacemark:(MKPlacemark *)placemark;
////- (void) getResults:(NSString *)barcode withMethod:(NSString *)method;
//@end

@interface History : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *tblSimpleTable;
    NSString *product;
    NSString *brand;
    NSDictionary *dataDict;
    NSMutableArray *listOfItems;
    NSMutableArray *brandsArray;
    NSMutableArray *productNamesArray;
    NSUserDefaults *defaults;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *brand;
@property (nonatomic, retain) NSDictionary *dataDict;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *brandsArray;
@property (nonatomic, retain) NSMutableArray *productNamesArray;
@property (nonatomic, retain) NSUserDefaults *defaults;

//- (void) processSuccessful: (BOOL)success;
//- (void) addNewItem:(NSString *)newProduct withNewBrand:(NSString *)newBrand;
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;


@end
