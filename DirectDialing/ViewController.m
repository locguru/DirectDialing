//
//  ViewController.m
//  DirectDialing
//
//  Created by Itai Ram on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize numberLabel;
@synthesize action;
@synthesize textField;
@synthesize phoneNumber;
@synthesize button0;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button7;
@synthesize button8;
@synthesize button9;
@synthesize buttonStar;
@synthesize buttonNumeral;
@synthesize buttonBack;
@synthesize buttonCall;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Keypad";
        self.tabBarItem.image = [UIImage imageNamed:@"tab-keypad.png"];
        
        numberLabel.text = @"";
//        NSBundle *mainBundle = [NSBundle mainBundle];
//        tone0 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"0" ofType:@"wav"]];
//        tone1 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"1" ofType:@"wav"]];
//        tone2 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"2" ofType:@"wav"]];
//        tone3 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"3" ofType:@"wav"]];
//        tone4 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"4" ofType:@"wav"]];
//        tone5 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"5" ofType:@"wav"]];
//        tone6 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"6" ofType:@"wav"]];
//        tone7 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"7" ofType:@"wav"]];
//        tone8 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"8" ofType:@"wav"]];
//        tone9 = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"9" ofType:@"wav"]];
//        toneStar = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"star" ofType:@"wav"]];
//        toneNumeral = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"numeral" ofType:@"wav"]];

        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //ADDING BACKGROUND IMAGE 
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
    imgView.image = [UIImage imageNamed:@"tel-normal.png"];
    [self.view addSubview: imgView];
    [self.view sendSubviewToBack:imgView];

    
    //TITLE AND NAV BAR ITEMS
    self.title = @"Direct Dialing";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelView:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    
//    self.title = @"Keypad";
//    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
    
//    //ACTION LABEL 
//    action = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 220, 40)];
//    action.backgroundColor = [UIColor clearColor]; 
//    action.font = [UIFont systemFontOfSize:12];
//    action.text = @"Please enter your phone number";
//    [self.view addSubview:action];
//    
//    //TEXT FIELD
//    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.font = [UIFont systemFontOfSize:15];
//    textField.placeholder = @"enter text";
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    textField.keyboardType = UIKeyboardTypeDefault; // UIKeyboardTypePhonePad;
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
//    textField.delegate = self;
//    [self.view addSubview:textField];
//
//    //ADDING DIAL BUTTON
//    UIButton *dialButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [dialButton addTarget:self action:@selector(dialNumber:) forControlEvents:UIControlEventTouchUpInside];
//    dialButton.frame = CGRectMake(70, 300, 180, 40.0);
//    dialButton.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:dialButton];    

    
    //DEFINING UI BUTTONS
    button0 = [[UIButton alloc] init];
    //button0.backgroundColor = [UIColor blueColor];
    button0.backgroundColor = [UIColor clearColor];
    button0.frame = CGRectMake(106, 279, 108, 69);
    [button0 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];    
    UIImage *button0Pressed = [UIImage imageNamed:@"tel-0-pressed.png"];
    [button0 setImage:button0Pressed forState:UIControlStateHighlighted];

    
    button1 = [[UIButton alloc] init];
//    button1.backgroundColor = [UIColor yellowColor];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(0, 74, 108, 69);
    [button1 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UIImage *button1Pressed = [UIImage imageNamed:@"tel-1-pressed.png"];
    [button1 setImage:button1Pressed forState:UIControlStateHighlighted];

    button2 = [[UIButton alloc] init];
//    button2.backgroundColor = [UIColor brownColor];
    button2.backgroundColor = [UIColor clearColor];
    button2.frame = CGRectMake(106, 74, 108, 69);
    [button2 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIImage *button2Pressed = [UIImage imageNamed:@"tel-2-pressed.png"];
    [button2 setImage:button2Pressed forState:UIControlStateHighlighted];
   
    button3 = [[UIButton alloc] init];
//    button3.backgroundColor = [UIColor purpleColor];
    button3.backgroundColor = [UIColor clearColor];
    button3.frame = CGRectMake(212, 74, 108, 69);
    [button3 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    UIImage *button3Pressed = [UIImage imageNamed:@"tel-3-pressed.png"];
    [button3 setImage:button3Pressed forState:UIControlStateHighlighted];

    button4 = [[UIButton alloc] init];
//    button4.backgroundColor = [UIColor blackColor];
    button4.backgroundColor = [UIColor clearColor];
    button4.frame = CGRectMake(0, 143, 108, 69);
    [button4 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    UIImage *button4Pressed = [UIImage imageNamed:@"tel-4-pressed.png"];
    [button4 setImage:button4Pressed forState:UIControlStateHighlighted];

    button5 = [[UIButton alloc] init];
//    button5.backgroundColor = [UIColor greenColor];
    button5.backgroundColor = [UIColor clearColor];
    button5.frame = CGRectMake(106, 143, 108, 69);
    [button5 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    UIImage *button5Pressed = [UIImage imageNamed:@"tel-5-pressed.png"];
    [button5 setImage:button5Pressed forState:UIControlStateHighlighted];

    button6 = [[UIButton alloc] init];
//    button6.backgroundColor = [UIColor grayColor];
    button6.backgroundColor = [UIColor clearColor];
    button6.frame = CGRectMake(212, 143, 108, 69);
    [button6 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    UIImage *button6Pressed = [UIImage imageNamed:@"tel-6-pressed.png"];
    [button6 setImage:button6Pressed forState:UIControlStateHighlighted];

    button7 = [[UIButton alloc] init];
//    button7.backgroundColor = [UIColor darkGrayColor];
    button7.backgroundColor = [UIColor clearColor];
    button7.frame = CGRectMake(0, 211, 108, 69);
    [button7 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    UIImage *button7Pressed = [UIImage imageNamed:@"tel-7-pressed.png"];
    [button7 setImage:button7Pressed forState:UIControlStateHighlighted];

    button8 = [[UIButton alloc] init];
//    button8.backgroundColor = [UIColor orangeColor];
    button8.backgroundColor = [UIColor clearColor];
    button8.frame = CGRectMake(106, 211, 108, 69);
    [button8 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
    UIImage *button8Pressed = [UIImage imageNamed:@"tel-8-pressed.png"];
    [button8 setImage:button8Pressed forState:UIControlStateHighlighted];

    button9 = [[UIButton alloc] init];
//    button9.backgroundColor = [UIColor redColor];
    button9.backgroundColor = [UIColor clearColor];
    button9.frame = CGRectMake(212, 211, 108, 69);
    [button9 addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button9];
    UIImage *button9Pressed = [UIImage imageNamed:@"tel-9-pressed.png"];
    [button9 setImage:button9Pressed forState:UIControlStateHighlighted];

    buttonStar = [[UIButton alloc] init];
//    buttonStar.backgroundColor = [UIColor brownColor];
    buttonStar.backgroundColor = [UIColor clearColor];
    buttonStar.frame = CGRectMake(0, 279, 108, 69);
    [buttonStar addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStar];
    UIImage *buttonStarPressed = [UIImage imageNamed:@"tel-star-pressed.png"];
    [buttonStar setImage:buttonStarPressed forState:UIControlStateHighlighted];

    buttonNumeral = [[UIButton alloc] init];
//    buttonNumeral.backgroundColor = [UIColor brownColor];
    buttonNumeral.backgroundColor = [UIColor clearColor];
    buttonNumeral.frame = CGRectMake(212, 279, 108, 69);
    [buttonNumeral addTarget:self action:@selector(typeNumberOrSymbol:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNumeral];
    UIImage *buttonNumeralPressed = [UIImage imageNamed:@"tel-numeral-pressed.png"];
    [buttonNumeral setImage:buttonNumeralPressed forState:UIControlStateHighlighted];

    buttonCall = [[UIButton alloc] init];
//    buttonCall.backgroundColor = [UIColor greenColor];
    buttonCall.backgroundColor = [UIColor clearColor];
    buttonCall.frame = CGRectMake(106, 345, 108, 69);
    [buttonCall addTarget:self action:@selector(dialNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCall];

    buttonBack = [[UIButton alloc] init];
//    buttonBack.backgroundColor = [UIColor blueColor];
    buttonBack.backgroundColor = [UIColor clearColor];
    buttonBack.frame = CGRectMake(213, 345, 108, 69);
    [buttonBack addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    UIImage *buttonBackPressed = [UIImage imageNamed:@"tel-back-pressed.png"];
    [buttonBack setImage:buttonBackPressed forState:UIControlStateHighlighted];

    //NUMBER LABEL
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 73)];
//    numberLabel.backgroundColor = [UIColor blueColor]; 
    numberLabel.backgroundColor = [UIColor clearColor]; 
    numberLabel.font = [UIFont systemFontOfSize:36];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.text = @"";
    numberLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    numberLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:numberLabel];

    
////    UIImage *btnImage = [[UIImage alloc] init];
////    button0.backgroundColor = [UIColor blueColor];
////    button0 = [[UIButton alloc] init];
////    button0.frame = CGRectMake(40, 140, 240, 30);
//////    btnImage = [UIImage imageNamed:@"tel-0-pressed.png"];
//////    [button0 setImage:btnImage forState:UIControlStateNormal];
////    [self.view addSubview:button0];
//
//    
//    UIButton *testb = [[UIButton alloc] init];
//    testb.frame = CGRectMake(40, 140, 240, 30);
//
//  //  testb = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
//    testb.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:testb];

    
//    [self dialNumber:nil];
}


- (IBAction)cancelView:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)typeNumberOrSymbol:(id)sender
{
    NSString *symbol = @"";
    if (sender == button0)
    {
//        [tone0 play];
        symbol = @"0";
    }
    else if (sender == button1)
    {
//        [tone1 play];
        symbol = @"1";
    }
    else if (sender == button2)
    {
//        [tone2 play];
        symbol = @"2";
    }
    else if (sender == button3)
    {
//        [tone3 play];
        symbol = @"3";
    }
    else if (sender == button4)
    {
//        [tone4 play];
        symbol = @"4";
    }
    else if (sender == button5)
    {
//        [tone5 play];
        symbol = @"5";
    }
    else if (sender == button6)
    {
//        [tone6 play];
        symbol = @"6";
    }
    else if (sender == button7)
    {
//        [tone7 play];
        symbol = @"7";
    }
    else if (sender == button8)
    {
//        [tone8 play];
        symbol = @"8";
    }
    else if (sender == button9)
    {
//        [tone9 play];
        symbol = @"9";
    }
    else if (sender == buttonStar)
    {
//        [toneStar play];
        symbol = @"*";
    }
    else if (sender == buttonNumeral)
    {
//        [toneNumeral play];
        symbol = @"#";
    }
    NSLog(@"Number typed: %@", symbol);
    numberLabel.text = [numberLabel.text stringByAppendingString:symbol];
    NSLog(@"numberLabel.text IS: %@", numberLabel.text );

}


- (IBAction)goBack:(id)sender
{
    NSString *currentValue = numberLabel.text;
    NSUInteger currentLength = [currentValue length];
    if (currentLength > 0)
    {
        NSRange range = NSMakeRange(0, currentLength - 1);
        numberLabel.text = [numberLabel.text substringWithRange:range];
    }
}


- (IBAction)dialNumber:(id)sender {

    
    NSString *accessNumber = [[NSString alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
    accessNumber = [defaults objectForKey:@"accessNumber"];
    
    NSLog(@"accessNumber is: %@", accessNumber);
    
    phoneNumber = [[NSString alloc] init];
    phoneNumber = numberLabel.text;


    NSLog(@"phone number is: %@", phoneNumber);

    NSString *fullNumber = [[NSString alloc] init];
    fullNumber = [NSString stringWithFormat:@"%@%@%@%@", @"tel:", accessNumber, @",", phoneNumber];

    
    NSLog(@"full number is: %@", fullNumber);
    
    NSURL *url = [ [ NSURL alloc ] initWithString: fullNumber ];
    [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {

    [textField1 resignFirstResponder];
//    if (textField == textField1) {
//        [textField2 becomeFirstResponder];
//    } else {
//        [textField resignFirstResponder];
//    }   
    return NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

@end
