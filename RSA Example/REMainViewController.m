//
//  REMainViewController.m
//  RSA Example
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#include "RSA.h"

#import "REMainViewController.h"

// the cipherText is encrypted from plainText (83 characters) value
static NSString *plainText = @"This is a plain text with very very long characters to test the long bit encryption.";
static NSString *cipherText = @"bMUUisItkVcHeZsRbSrJ5TYOP+HwZWXuQ4T0PZ/5B9vTMpwbP/c4x378+5HefDQOM0WZh+6Lv46YvF28VdeMd2lkt5qE/tTGI7FXuPqwUebCSF7RrYAeICRnEa3ruMIo86WJxTglAF+Mf0zy/DmqM7NTEFVbF6xXBV72TWyMI8k=";

@interface REMainViewController ()

@property (nonatomic, strong) UITextView *plainTextView;
@property (nonatomic, strong) UITextView *cipherTextView;
@property (nonatomic, strong) UIButton *runButton;

@end

@implementation REMainViewController

@synthesize plainTextView = _plainTextView;
@synthesize cipherTextView = _cipherTextView;
@synthesize runButton = _runButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(20, 20, 280, 20);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = @"Plain text";
    [self.view addSubview:label];
    
    frame.origin.y += frame.size.height + 10;
    frame.size.height = 60;
    self.plainTextView = [[UITextView alloc] initWithFrame:frame];
    self.plainTextView.editable = NO;
    self.plainTextView.layer.borderWidth = 1.0f;
    [self.view addSubview:self.plainTextView];
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = 20;
    label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.text = @"Cipher text";
    [self.view addSubview:label];
    
    [self.view addSubview:label];
    frame.origin.y += frame.size.height + 10;
    frame.size.height = 100;
    self.cipherTextView = [[UITextView alloc] initWithFrame:frame];
    self.cipherTextView.editable = NO;
    self.cipherTextView.layer.borderWidth = 1.0f;
    [self.view addSubview:self.cipherTextView];
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = 40;
    frame.size.width = 100;
    frame.origin.x = 110;
    self.runButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.runButton.frame = frame;
    [self.runButton setTitle:@"Run" forState:UIControlStateNormal];
    [self.runButton addTarget:self action:@selector(runTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.runButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)decryptFromCipherText:(NSString *)cipher
{
    
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"pem"];
    NSLog(@"privateKeyPath: %@", privateKeyPath);
    
    char *plainText = js_private_decrypt([cipherText UTF8String], [privateKeyPath UTF8String]);
    printf("Plain plain: %s\n", plainText);
    
    return [NSString stringWithUTF8String:plainText];
}

- (void)runTouched:(UIButton *)sender
{
    self.plainTextView.text = [self decryptFromCipherText:cipherText];
}

@end
