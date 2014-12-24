//
//  REMainViewController.m
//  RSA Example
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#import "JSRSA.h"

#import "REMainViewController.h"

// the cipherText is encrypted from plainText (83 characters) value
static NSString *plainText = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

static NSString *publicEncryptedText = @"juM56/BE52ylurmydLvtSwpdh8ZPjjaAnQLSqVU3i4NXk3haFoabgvYHWOFMg0e3IrXw+W7spA42cMBZnbAO5wkjjUg8ALFOnoS8VxNanI00K14QbJAFsNe7kZ02j1OMnsonhvQgsOx0+lZXPO7uzYv5jGp7AjmGthMt2aFabxo6S1elXCHB0L3eHcRrQM0O0wppssw1gzxbtma361PwUYDg0Ty9wgHZ4Cp1eElmAqoiHx4E/w2fgl4ZFqgDgT4oC0OiF3Wl5ZB3hcvEjxkLAOxdcr3Cz3bvhPtCsi3iCvzMAcUFQckMc4+0WBSo0+7FmfwfzCptW3xK7rrRx6WayVeSqDJyGhrL+jg35LC2jr5lj2NnPpvG5vU4CVyFn2uv+xL8vbLvAmhCWMJZNoiJhF/G22fF3SVAnRtlDogvCGwZkPvGKN+kdYffpkj1VepN9V8cQsmHsj1FTGDG/kDzk6UaWHarUVD0MHydgEdsXzISG5pkGioxOT3X6ohJ368zh9iz3tfGUNi4AUN6SbDu9RbSB4SCTtpKtYP9NNObokU3WALOWTGFQ038or1XmsnCJBjLRlRDfPdvMylggM/AKISvCcmhZsd/kMsalSXlInEcY9rx6nwzGqOD9ue3zM0IeZXfwc+4lUKBJbkDK48hjOh2Z1O1OyRAJmAk03NGi3BYwMpXxLq9E7xxJBMu5QWtkk8ZXeiEADHk+WQB0VVzG9E8pOSakxeWCwKUlQqv6pWPOT0IE98epUEXwkqd3DxU";
static NSString *privateEncryptedText = @"QOudgDxHw7rYF3TLtDrZ6nKXCVoWZ6babm4Rr0qUiZfrovMQh2gLkyHcNIYgxnpCOdndhYlVwOt1ZL3NWTz0UACXDwCK8VWFikK7c1WQMYWSxvRSS1obkMusnx1A3MM9MMsXG71TfDUpD2jo0J27bktB5fvPQUEVLK77pCYtDZ5ARVFEKRWWLo8KLYraM6kYYNDewe8AjGijGSK36FaSqWV1E3O5dDbgi+XnDUz7Bv9A9t2y+j8kHb2K9UydZ5bfOsY7pAP8DiFrfkEMOfSXWzyYakrsFTNvv8pNtNag5Sxt0NIOiCoBebLMj4979MDENdew8ImStCM9kMGCKsMs9x3NFvUQIT9lutvh3wqasPBHD9eBFXwwd6tYUac2FbeJNukv2tDxCc+0ah9dkHyA3uKkQL4HVTBZ6iB4SbL4MpQIOOtbEOHWTb06LuoaNmXaMBQFHybzKPzJdW4z9b3iSIJ3A61ByWa8lgMYQuW8pqVvRzgVLgCc0l5hk/XiwPV5Djt4f82GdEAygsZKF3F5K8bEYJVE8W5XZ+9rhU6LD6kqYZcpKNUvmKR8F3J4epCO7+pGYd5FgEWw7+aPeM4gWmym0USiRtKQXNaTsWwLiEdhuD3AjiV33TWAXdqcSevnH8b8VvV+ecxj7QHmcDiYNg/xjLsoNQUyn5VuQ42VZ6xNuLDZLgfii08oQDtDmSMWahk5i8ukMSThbsE0EWYI7iFAoDs6Yz5rukM6oE7MYbbQ8n45YxbRRuQ7Kz2xlBhV";

@interface REMainViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

// public encrypt - encrypt plain text using public key
@property (nonatomic, strong) UITextView *publicEncryptInputTextView;
@property (nonatomic, strong) UITextView *publicEncryptOutputTextView;
@property (nonatomic, strong) UIButton *publicEncryptButton;

// private decrypt - decrypt cipher text using private key
@property (nonatomic, strong) UITextView *privateDecryptInputTextView;
@property (nonatomic, strong) UITextView *privateDecryptOutputTextView;
@property (nonatomic, strong) UIButton *privateDecryptButton;

// private encrypt - encrypt plain text using private key
@property (nonatomic, strong) UITextView *privateEncryptInputTextView;
@property (nonatomic, strong) UITextView *privateEncryptOutputTextView;
@property (nonatomic, strong) UIButton *privateEncryptButton;

// public decrypt - decrypt cipher text using public key
@property (nonatomic, strong) UITextView *publicDecryptInputTextView;
@property (nonatomic, strong) UITextView *publicDecryptOutputTextView;
@property (nonatomic, strong) UIButton *publicDecryptButton;

@end

@implementation REMainViewController {
    UIView *_dummyView;
    NSLayoutConstraint *_dummyViewHeightConstraint;
    
    NSArray *textViews, *labels, *buttons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSA Demo";
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetTapped:)];
    self.navigationItem.rightBarButtonItem = resetButton;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0 green:74/255.0 blue:84/255.0 alpha:1];
    
    [JSRSA sharedInstance].publicKey = @"public_key.pem";
    [JSRSA sharedInstance].privateKey = @"private_key.pem";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_scrollView];
    
    _dummyView = [[UIView alloc] init];
    _dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    _dummyView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_dummyView];
    
    // keyboard tool bar
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    [doneBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:87/255.0f green:83/255.0f blue:75/255.0f alpha:1], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    [doneBarButton setStyle:UIBarButtonItemStyleDone];
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar setTintColor:[UIColor whiteColor]];
    [keyboardToolbar sizeToFit];
    [keyboardToolbar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneBarButton, nil]];
    
    // public encrypt
    UILabel *publicEncryptLabel = [[UILabel alloc] init];
    publicEncryptLabel.translatesAutoresizingMaskIntoConstraints = NO;
    publicEncryptLabel.text = @"Public Encrypt";
    [_scrollView addSubview:publicEncryptLabel];
    
    _publicEncryptInputTextView = [[UITextView alloc] init];
    _publicEncryptInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _publicEncryptInputTextView.text = plainText;
    [_scrollView addSubview:_publicEncryptInputTextView];
    
    _publicEncryptOutputTextView = [[UITextView alloc] init];
    _publicEncryptOutputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _publicEncryptOutputTextView.editable = NO;
    [_scrollView addSubview:_publicEncryptOutputTextView];
    
    _publicEncryptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _publicEncryptButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_publicEncryptButton setTitle:@"Encrypt" forState:UIControlStateNormal];
    [_publicEncryptButton addTarget:self action:@selector(publicEncryptTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_publicEncryptButton];
    
    // private decrypt
    UILabel *privateDecryptLabel = [[UILabel alloc] init];
    privateDecryptLabel.translatesAutoresizingMaskIntoConstraints = NO;
    privateDecryptLabel.text = @"Private Decrypt";
    [_scrollView addSubview:privateDecryptLabel];
    
    _privateDecryptInputTextView = [[UITextView alloc] init];
    _privateDecryptInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _privateDecryptInputTextView.text = publicEncryptedText;
    [_scrollView addSubview:_privateDecryptInputTextView];
    
    _privateDecryptOutputTextView = [[UITextView alloc] init];
    _privateDecryptOutputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _privateDecryptOutputTextView.editable = NO;
    [_scrollView addSubview:_privateDecryptOutputTextView];
    
    _privateDecryptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _privateDecryptButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_privateDecryptButton setTitle:@"Decrypt" forState:UIControlStateNormal];
    [_privateDecryptButton addTarget:self action:@selector(privateDecryptTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_privateDecryptButton];
    
    // private encrypt
    UILabel *privateEncryptLabel = [[UILabel alloc] init];
    privateEncryptLabel.translatesAutoresizingMaskIntoConstraints = NO;
    privateEncryptLabel.text = @"Private Encrypt";
    [_scrollView addSubview:privateEncryptLabel];
    
    _privateEncryptInputTextView = [[UITextView alloc] init];
    _privateEncryptInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _privateEncryptInputTextView.text = plainText;
    [_scrollView addSubview:_privateEncryptInputTextView];
    
    _privateEncryptOutputTextView = [[UITextView alloc] init];
    _privateEncryptOutputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _privateEncryptOutputTextView.editable = NO;
    [_scrollView addSubview:_privateEncryptOutputTextView];
    
    _privateEncryptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _privateEncryptButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_privateEncryptButton setTitle:@"Encrypt" forState:UIControlStateNormal];
    [_privateEncryptButton addTarget:self action:@selector(privateEncryptTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_privateEncryptButton];
    
    // public decrypt
    UILabel *publicDecryptLabel = [[UILabel alloc] init];
    publicDecryptLabel.translatesAutoresizingMaskIntoConstraints = NO;
    publicDecryptLabel.text = @"Public Decrypt";
    [_scrollView addSubview:publicDecryptLabel];
    
    _publicDecryptInputTextView = [[UITextView alloc] init];
    _publicDecryptInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _publicDecryptInputTextView.text = privateEncryptedText;
    [_scrollView addSubview:_publicDecryptInputTextView];
    
    _publicDecryptOutputTextView = [[UITextView alloc] init];
    _publicDecryptOutputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _publicDecryptOutputTextView.editable = NO;
    [_scrollView addSubview:_publicDecryptOutputTextView];
    
    _publicDecryptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _publicDecryptButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_publicDecryptButton setTitle:@"Decrypt" forState:UIControlStateNormal];
    [_publicDecryptButton addTarget:self action:@selector(publicDecryptTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_publicDecryptButton];
    
    // configure textViews
    textViews = @[
                  _publicEncryptInputTextView
                  , _publicEncryptOutputTextView
                  , _privateDecryptInputTextView
                  , _privateDecryptOutputTextView
                  , _privateEncryptInputTextView
                  , _privateEncryptOutputTextView
                  , _publicDecryptInputTextView
                  , _publicDecryptOutputTextView
                  ];
    for (UITextView *textView in textViews) {
        textView.layer.borderWidth = 1.0f;
        textView.inputAccessoryView = keyboardToolbar;
        textView.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    }
    
    // configure buttons
    buttons = @[_publicEncryptButton, _privateDecryptButton, _privateEncryptButton, _publicDecryptButton];
    for (UIButton *button in buttons) {
        button.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    }
    
    labels = @[publicEncryptLabel, privateDecryptLabel, privateEncryptLabel, publicDecryptLabel];
    for (UILabel *label in labels) {
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:88/255.0 green:84/255.0 blue:75/255.0 alpha:0.7];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    }
    
    // auto-layout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_scrollView
                                                                   , _dummyView
                                                                   , publicEncryptLabel
                                                                   , _publicEncryptInputTextView
                                                                   , _publicEncryptOutputTextView
                                                                   , _publicEncryptButton
                                                                   , publicDecryptLabel
                                                                   , _publicDecryptInputTextView
                                                                   , _publicDecryptOutputTextView
                                                                   , _publicDecryptButton
                                                                   , privateDecryptLabel
                                                                   , _privateDecryptInputTextView
                                                                   , _privateDecryptOutputTextView
                                                                   , _privateDecryptButton
                                                                   , privateEncryptLabel
                                                                   , _privateEncryptInputTextView
                                                                   , _privateEncryptOutputTextView
                                                                   , _privateEncryptButton);
    
    NSDictionary *matrics = @{@"margin": @(20), @"sectionMargin": @(40), @"textHeight": @(100)};
    
    NSArray *constraints = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:|[_scrollView]|"
                            options:0
                            metrics:nil
                            views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|[_scrollView]|"
                   options:0
                   metrics:nil
                   views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"V:|-sectionMargin-[publicEncryptLabel]-margin-[_publicEncryptInputTextView(textHeight)]-margin-[_publicEncryptOutputTextView(textHeight)]-margin-[_publicEncryptButton]-sectionMargin-[privateDecryptLabel]-margin-[_privateDecryptInputTextView(textHeight)]-margin-[_privateDecryptOutputTextView(textHeight)]-margin-[_privateDecryptButton]-sectionMargin-[privateEncryptLabel]-margin-[_privateEncryptInputTextView(textHeight)]-margin-[_privateEncryptOutputTextView(textHeight)]-margin-[_privateEncryptButton]-sectionMargin-[publicDecryptLabel]-margin-[_publicDecryptInputTextView(textHeight)]-margin-[_publicDecryptOutputTextView(textHeight)]-margin-[_publicDecryptButton]-[_dummyView]-sectionMargin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:[NSString stringWithFormat:@"|-margin-[publicEncryptLabel(%.0f)]-margin-|", [UIScreen mainScreen].bounds.size.width - ([matrics[@"margin"] intValue] * 2)]
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicEncryptInputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicEncryptOutputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicEncryptButton]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[privateDecryptLabel]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateDecryptInputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateDecryptOutputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateDecryptButton]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[publicDecryptLabel]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicDecryptInputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicDecryptOutputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_publicDecryptButton]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[privateEncryptLabel]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateEncryptInputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateEncryptOutputTextView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_privateEncryptButton]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-margin-[_dummyView]-margin-|"
                   options:0
                   metrics:matrics
                   views:viewsDictionary];
    [_scrollView addConstraints:constraints];
    
    _dummyViewHeightConstraint = [NSLayoutConstraint
                                  constraintWithItem:_dummyView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0f
                                  constant:0];
    [_dummyView addConstraint:_dummyViewHeightConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event
- (void)publicEncryptTouched:(UIButton *)sender
{
    _publicEncryptOutputTextView.text = [[JSRSA sharedInstance] publicEncrypt:_publicEncryptInputTextView.text];
}

- (void)privateDecryptTouched:(UIButton *)sender
{
    _privateDecryptOutputTextView.text = [[JSRSA sharedInstance] privateDecrypt:_privateDecryptInputTextView.text];
}

- (void)privateEncryptTouched:(UIButton *)sender
{
    _privateEncryptOutputTextView.text = [[JSRSA sharedInstance] privateEncrypt:_privateEncryptInputTextView.text];
}

- (void)publicDecryptTouched:(UIButton *)sender
{
    _publicDecryptOutputTextView.text = [[JSRSA sharedInstance] publicDecrypt:_publicDecryptInputTextView.text];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.view endEditing:YES];
}

- (void)resetTapped:(UIBarButtonItem *)sender
{
    _publicEncryptInputTextView.text = plainText;
    _publicEncryptOutputTextView.text = @"";
    _privateDecryptInputTextView.text = publicEncryptedText;
    _privateDecryptOutputTextView.text = @"";
    _privateEncryptInputTextView.text = plainText;
    _privateEncryptOutputTextView.text = @"";
    _publicDecryptInputTextView.text = privateEncryptedText;
    _publicDecryptOutputTextView.text = @"";
}

#pragma mark - keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [_dummyView removeConstraint:_dummyViewHeightConstraint];
    
    _dummyViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_dummyView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:keyboardSize.height];
    [_dummyView addConstraint:_dummyViewHeightConstraint];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [_dummyView removeConstraint:_dummyViewHeightConstraint];
    
    _dummyViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_dummyView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:0];
    [_dummyView addConstraint:_dummyViewHeightConstraint];
}

@end
