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

![alt text] (https://raw.github.com/jslim89/RSA-Example/master/screenshots/resource_bundle.png "Copy Bundle Resources")  

## How to use

Include RSA
```obj-c
#import "JSRSA.h"

// set the public/private key
[JSRSA sharedInstance].publicKey = @"public_key.pem";
[JSRSA sharedInstance].privateKey = @"private_key.pem";

NSString *plainText = [[JSRSA sharedInstance] privateDecrypt:cipherText];
...
```

There are 4 methods here:

```obj-c
- (NSString *)publicEncrypt:(NSString *)plainText;
- (NSString *)privateDecrypt:(NSString *)cipherText;
- (NSString *)privateEncrypt:(NSString *)plainText;
- (NSString *)publicDecrypt:(NSString *)cipherText;
```

## TODO

Currently, only `privateDecrypt:` work.

If you are interested in this project, please fork it and submit a pull request here.

Now these 3 method still in progress.

- `publicEncrypt:`
- `privateEncrypt:`
- `publicDecrypt:`

Thanks

### Setup

To pull the openssl for iOS

```sh
$ git submodule update --init --recursive
```

## Credit

* [openssl use RSA private key to generate public key?](http://stackoverflow.com/questions/5244129/openssl-use-rsa-private-key-to-generate-public-key/5246045#5246045)

## License

The RSA-objc is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
