//
//  ViewController.h
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate> {
    
//@private
    IBOutlet UILabel *numberLabel;
    
    IBOutlet UIButton *button0;
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    IBOutlet UIButton *button4;
    IBOutlet UIButton *button5;
    IBOutlet UIButton *button6;
    IBOutlet UIButton *button7;
    IBOutlet UIButton *button8;
    IBOutlet UIButton *button9;
    IBOutlet UIButton *buttonStar;
    IBOutlet UIButton *buttonCall;
    IBOutlet UIButton *buttonBack;
    
//    SoundEffect *tone0;
//    SoundEffect *tone1;
//    SoundEffect *tone2;
//    SoundEffect *tone3;
//    SoundEffect *tone4;
//    SoundEffect *tone5;
//    SoundEffect *tone6;
//    SoundEffect *tone7;
//    SoundEffect *tone8;
//    SoundEffect *tone9;
//    SoundEffect *toneStar;
//    SoundEffect *toneNumeral;

    
    
    UILabel *action;
    UITextField *textField;
    NSString *phoneNumber; 

}

@property (nonatomic, retain) UILabel *action;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) NSString *phoneNumber; 

@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) IBOutlet UIButton *button0;
@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;
@property (nonatomic, retain) IBOutlet UIButton *button5;
@property (nonatomic, retain) IBOutlet UIButton *button6;
@property (nonatomic, retain) IBOutlet UIButton *button7;
@property (nonatomic, retain) IBOutlet UIButton *button8;
@property (nonatomic, retain) IBOutlet UIButton *button9;
@property (nonatomic, retain) IBOutlet UIButton *buttonStar;
@property (nonatomic, retain) IBOutlet UIButton *buttonNumeral;
@property (nonatomic, retain) IBOutlet UIButton *buttonCall;
@property (nonatomic, retain) IBOutlet UIButton *buttonBack;

- (IBAction)typeNumberOrSymbol:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)cancelView:(id)sender; 
- (IBAction)dialNumber:(id)sender;


@end

