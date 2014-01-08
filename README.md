## Setup

### 1. Download openssl library

The library can be found [here](https://github.com/st3fan/ios-openssl)

### 2. Include library to project

Just drag the library _(with `include` & `lib` folders only)_ to the project. Go to project targets -> `Build Settings`:

* Look for **Header Search Paths**, add `"${SRCROOT}/Libraries/openssl/include"` for example
* Look for **Library Search Paths**, add `"${SRCROOT}/Libraries/openssl/lib"` for example

## Generate Key pair

```sh
$ openssl rsa -in private_key.pem -pubout -out public_key.der -outform DER
```
