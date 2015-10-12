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

// short string test case
@property (nonatomic) NSString *plainTextToTest;
@property (nonatomic) NSString *publicEncryptedCipherTextToTest;
@property (nonatomic) NSString *privateEncryptedCipherTextToTest;

// long string test case
@property (nonatomic) NSString *longPlainTextToTest;
@property (nonatomic) NSString *longPublicEncryptedCipherTextToTest;
@property (nonatomic) NSString *longPrivateEncryptedCipherTextToTest;

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
    
    _longPlainTextToTest = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    _longPublicEncryptedCipherTextToTest = @"juM56/BE52ylurmydLvtSwpdh8ZPjjaAnQLSqVU3i4NXk3haFoabgvYHWOFMg0e3IrXw+W7spA42cMBZnbAO5wkjjUg8ALFOnoS8VxNanI00K14QbJAFsNe7kZ02j1OMnsonhvQgsOx0+lZXPO7uzYv5jGp7AjmGthMt2aFabxo6S1elXCHB0L3eHcRrQM0O0wppssw1gzxbtma361PwUYDg0Ty9wgHZ4Cp1eElmAqoiHx4E/w2fgl4ZFqgDgT4oC0OiF3Wl5ZB3hcvEjxkLAOxdcr3Cz3bvhPtCsi3iCvzMAcUFQckMc4+0WBSo0+7FmfwfzCptW3xK7rrRx6WayVeSqDJyGhrL+jg35LC2jr5lj2NnPpvG5vU4CVyFn2uv+xL8vbLvAmhCWMJZNoiJhF/G22fF3SVAnRtlDogvCGwZkPvGKN+kdYffpkj1VepN9V8cQsmHsj1FTGDG/kDzk6UaWHarUVD0MHydgEdsXzISG5pkGioxOT3X6ohJ368zh9iz3tfGUNi4AUN6SbDu9RbSB4SCTtpKtYP9NNObokU3WALOWTGFQ038or1XmsnCJBjLRlRDfPdvMylggM/AKISvCcmhZsd/kMsalSXlInEcY9rx6nwzGqOD9ue3zM0IeZXfwc+4lUKBJbkDK48hjOh2Z1O1OyRAJmAk03NGi3BYwMpXxLq9E7xxJBMu5QWtkk8ZXeiEADHk+WQB0VVzG9E8pOSakxeWCwKUlQqv6pWPOT0IE98epUEXwkqd3DxU";
    _longPrivateEncryptedCipherTextToTest = @"QOudgDxHw7rYF3TLtDrZ6nKXCVoWZ6babm4Rr0qUiZfrovMQh2gLkyHcNIYgxnpCOdndhYlVwOt1ZL3NWTz0UACXDwCK8VWFikK7c1WQMYWSxvRSS1obkMusnx1A3MM9MMsXG71TfDUpD2jo0J27bktB5fvPQUEVLK77pCYtDZ5ARVFEKRWWLo8KLYraM6kYYNDewe8AjGijGSK36FaSqWV1E3O5dDbgi+XnDUz7Bv9A9t2y+j8kHb2K9UydZ5bfOsY7pAP8DiFrfkEMOfSXWzyYakrsFTNvv8pNtNag5Sxt0NIOiCoBebLMj4979MDENdew8ImStCM9kMGCKsMs9x3NFvUQIT9lutvh3wqasPBHD9eBFXwwd6tYUac2FbeJNukv2tDxCc+0ah9dkHyA3uKkQL4HVTBZ6iB4SbL4MpQIOOtbEOHWTb06LuoaNmXaMBQFHybzKPzJdW4z9b3iSIJ3A61ByWa8lgMYQuW8pqVvRzgVLgCc0l5hk/XiwPV5Djt4f82GdEAygsZKF3F5K8bEYJVE8W5XZ+9rhU6LD6kqYZcpKNUvmKR8F3J4epCO7+pGYd5FgEWw7+aPeM4gWmym0USiRtKQXNaTsWwLiEdhuD3AjiV33TWAXdqcSevnH8b8VvV+ecxj7QHmcDiYNg/xjLsoNQUyn5VuQ42VZ6xNuLDZLgfii08oQDtDmSMWahk5i8ukMSThbsE0EWYI7iFAoDs6Yz5rukM6oE7MYbbQ8n45YxbRRuQ7Kz2xlBhV";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Short string test cases
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

#pragma mark - Long string test cases
- (void)testLongPublicEncrypt
{
    NSString *cipher = [[JSRSA sharedInstance] publicEncrypt:_longPlainTextToTest];
    XCTAssertNotNil(cipher, @"Cipher text shouldn't be nil!");
    
    if (cipher) {
        NSString *plain = [[JSRSA sharedInstance] privateDecrypt:cipher];
        XCTAssertEqualObjects(_longPlainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
    }
}

- (void)testLongPrivateDecrypt
{
    NSString *plain = [[JSRSA sharedInstance] privateDecrypt:_longPublicEncryptedCipherTextToTest];
    XCTAssertEqualObjects(_longPlainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
}

- (void)testLongPrivateEncrypt
{
    NSString *cipher = [[JSRSA sharedInstance] privateEncrypt:_longPlainTextToTest];
    XCTAssertNotNil(cipher, @"Cipher text shouldn't be nil!");
    
    if (cipher) {
        NSString *plain = [[JSRSA sharedInstance] publicDecrypt:cipher];
        XCTAssertEqualObjects(_longPlainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
    }
}

- (void)testLongPublicDecrypt
{
    NSString *plain = [[JSRSA sharedInstance] publicDecrypt:_longPrivateEncryptedCipherTextToTest];
    XCTAssertEqualObjects(_longPlainTextToTest, plain, @"The decrypted value of the cipher text doesn't match!");
}

@end
