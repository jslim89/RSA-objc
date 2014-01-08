# About
This example is to perform RSA encryption & decryption in iOS _(Objective-C)_. I wrote a blog about [encryption](http://jslim.net/blog/2013/01/05/rsa-encryption-in-ios-and-decrypt-it-using-php/) and [decryption](http://jslim.net/blog/2013/06/24/rsa-decryption-on-ios/). Now I create this example is improvement on that _(In my blog post: Encryption is done totally in Objective-C; Decryption cannot support chunks decryption but written in C)_, This example shows both encryption & decryption in C and support for longer string.

## Setup

### 1. Download openssl library

The library can be found [here](https://github.com/st3fan/ios-openssl)

### 2. Include library to project

Just drag the library _(with `include` & `lib` folders only)_ to the project. Go to project targets -> `Build Settings`:

* Look for **Header Search Paths**, add `"${SRCROOT}/Libraries/openssl/include"` for example
* Look for **Library Search Paths**, add `"${SRCROOT}/Libraries/openssl/lib"` for example

## Generate Key pair

Generate private key
```sh
$ openssl genrsa -out private_key.pem 512
```

Generate public key from private key
```sh
$ openssl rsa -in private_key.pem -pubout -out public_key.pem
```

## How to use

Include RSA
```obj-c
#include "RSA.h"
```

Get the path of your private key _(make sure is in **Copy Bundle Resources)_

![alt text] (https://raw.github.com/jslim89/RSA-Example/master/screenshots/resource_bundle.png "Copy Bundle Resources")  

```obj-c
NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"pem"];
```

Decrypt using the function `js_private_decrypt`
```obj-c
char *plainText = js_private_decrypt([cipher UTF8String], [privateKeyPath UTF8String]);

// convert to NSString form
NSString *result = [NSString stringWithUTF8String:plainText];
NSLog(@"Plain text: %@", result);
```

**(NOTE: Encryption did the same way)**

## Credit

* [openssl use RSA private key to generate public key?](http://stackoverflow.com/questions/5244129/openssl-use-rsa-private-key-to-generate-public-key/5246045#5246045)
