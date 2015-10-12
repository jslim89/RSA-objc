//
//  RSA_ExampleTests.m
//  RSA ExampleTests
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSRSA.h"

@interface RSA_ExampleTests : XCTestCase

@property (nonatomic) NSString *plainTextToTest;
@property (nonatomic) NSString *publicEncryptedCipherTextToTest;
@property (nonatomic) NSString *privateEncryptedCipherTextToTest;

@end

@implementation RSA_ExampleTests

- (void)setUp
{
    [super setUp];
    
    [JSRSA sharedInstance].publicKey = @"public_key.pem";
    [JSRSA sharedInstance].privateKey = @"private_key.pem";
    
    _plainTextToTest = @"The quick brown fox jumps over the lazy dog.";
    _publicEncryptedCipherTextToTest = @"G9L3vCX1iQesN4H3k7AiDOpD9pGUXT1NyQdSjbAiHWUpjvCUw3lcgKPfnBItIWjQ17r076KFk4K/moK1rz7cmg==";
    _privateEncryptedCipherTextToTest = @"adg7QvJIgwyyR3QU0x5kOtxLD9TVIEAngpINeE1STtVHHbCUZ9mDQDDALErfi58ajXKSSZsnFNxbg+Cd3vLgWw==";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPublicEncrypt
{
    NSString *cipher = [[JSRSA sharedInstance] publicEncrypt:_plainTextToTest];
    XCTAssertNotNil(cipher, @"Cipher text shouldn't be nil!");
    
    if (cipher) {
        NSString *plain = [[JSRSA sharedInstance] privateDecrypt:cipher];
        XCTAssertEqualObjects(_plainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
    }
}

- (void)testPrivateDecrypt
{
    NSString *plain = [[JSRSA sharedInstance] privateDecrypt:_publicEncryptedCipherTextToTest];
    XCTAssertEqualObjects(_plainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
}

- (void)testPrivateEncrypt
{
    NSString *cipher = [[JSRSA sharedInstance] privateEncrypt:_plainTextToTest];
    NSLog(@"testPrivateEncrypt - cipher: %@", cipher);
    XCTAssertNotNil(cipher, @"Cipher text shouldn't be nil!");
    
    if (cipher) {
        NSString *plain = [[JSRSA sharedInstance] publicDecrypt:cipher];
        XCTAssertEqualObjects(_plainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
    }
}

- (void)testPublicDecrypt
{
    NSString *plain = [[JSRSA sharedInstance] publicDecrypt:_privateEncryptedCipherTextToTest];
    XCTAssertEqualObjects(_plainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
}

@end
