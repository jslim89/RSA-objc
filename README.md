# RSA for Objective-C
This is a plugin for RSA encryption & decryption in iOS _(Objective-C)_. I wrote a blog about [encryption](http://jslim.net/blog/2013/01/05/rsa-encryption-in-ios-and-decrypt-it-using-php/) and [decryption](http://jslim.net/blog/2013/06/24/rsa-decryption-on-ios/).

## Setup

### 1. Download openssl library

The library can be found [here](https://github.com/st3fan/ios-openssl)

### 2. Include library to project

Just drag the library _(with `include` & `lib` folders only)_ to the project. Go to project targets -> `Build Settings`:

* Look for **Header Search Paths**, add `"${SRCROOT}/Libraries/openssl/include"` for example
* Look for **Library Search Paths**, add `"${SRCROOT}/Libraries/openssl/lib"` for example

### 3. Include RSA-objc into your project

Drag the folder **RSA-objc** to your project.

### 4. Generate Key pair

Generate private key
```sh
$ openssl genrsa -out private_key.pem 512
```

Generate public key from private key
```sh
$ openssl rsa -in private_key.pem -pubout -out public_key.pem
```

Drag the key(s) to your project, and make sure it appear in **Copy Bundle Resources**.

![alt text](https://raw.github.com/jslim89/RSA-Example/master/screenshots/resource_bundle.png "Copy Bundle Resources")  

### 5. Add bridging header _(only if you want to port to Swift)_

Go to **Project Targets** -> select **Build Settings**, look for **Objective-C Bridging Header**

![alt text](https://raw.github.com/jslim89/RSA-Example/master/screenshots/bridging-header.png "Set bridging header")  

Make sure you set the correct path according to your file structure.

**The _SwiftBridgingHeader.h_ is included in this example**

## How to use

Include RSA

### Objective-C

```obj-c
#import "JSRSA.h"

// set the public/private key
[JSRSA sharedInstance].publicKey = @"public_key.pem";
[JSRSA sharedInstance].privateKey = @"private_key.pem";

NSString *plainText = [[JSRSA sharedInstance] privateDecrypt:cipherText];
...
```

### Swift

```swift
JSRSA.sharedInstance().privateKey = "private_key.pem"
JSRSA.sharedInstance().publicKey = "public_key.pem"

var plainText = JSRSA.sharedInstance().privateDecrypt(cipherText)
```

There are 4 methods here:

```obj-c
- (NSString *)publicEncrypt:(NSString *)plainText;
- (NSString *)privateDecrypt:(NSString *)cipherText;
- (NSString *)privateEncrypt:(NSString *)plainText;
- (NSString *)publicDecrypt:(NSString *)cipherText;
```

## Try the demo project

To pull the openssl for iOS

```sh
$ git submodule update --init --recursive
```

## Contributors

- [jslim89](https://github.com/jslim89) - Original author
- [flexih](https://github.com/flexih)
- [mengxiangyue](https://github.com/mengxiangyue)

## Credit

* [openssl use RSA private key to generate public key?](http://stackoverflow.com/questions/5244129/openssl-use-rsa-private-key-to-generate-public-key/5246045#5246045)

## Donate

<a href='https://pledgie.com/campaigns/31695'><img alt='Click here to lend your support to: RSA-objc and make a donation at pledgie.com !' src='https://pledgie.com/campaigns/31695.png?skin_name=chrome' border='0' ></a>

## License

The RSA-objc is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
