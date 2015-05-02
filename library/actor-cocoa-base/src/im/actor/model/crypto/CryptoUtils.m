//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/crypto/CryptoUtils.java
//


#line 1 "/Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/crypto/CryptoUtils.java"

#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/CryptoProvider.h"
#include "im/actor/model/crypto/CryptoKeyPair.h"
#include "im/actor/model/crypto/CryptoUtils.h"
#include "java/lang/RuntimeException.h"

@interface AMCryptoUtils ()

+ (jint)fromHexShortWithChar:(jchar)a;

@end

static id<AMCryptoProvider> AMCryptoUtils_provider_;
J2OBJC_STATIC_FIELD_GETTER(AMCryptoUtils, provider_, id<AMCryptoProvider>)
J2OBJC_STATIC_FIELD_SETTER(AMCryptoUtils, provider_, id<AMCryptoProvider>)

__attribute__((unused)) static jint AMCryptoUtils_fromHexShortWithChar_(jchar a);

J2OBJC_INITIALIZED_DEFN(AMCryptoUtils)

IOSCharArray *AMCryptoUtils_hexArray_;


#line 8
@implementation AMCryptoUtils


#line 14
+ (void)init__WithAMCryptoProvider:(id<AMCryptoProvider>)provider {
  AMCryptoUtils_init__WithAMCryptoProvider_(provider);
}

+ (AMCryptoKeyPair *)generateRSA1024KeyPair {
  return AMCryptoUtils_generateRSA1024KeyPair();
}

+ (IOSByteArray *)MD5WithByteArray:(IOSByteArray *)data {
  return AMCryptoUtils_MD5WithByteArray_(data);
}


#line 32
+ (IOSByteArray *)SHA256WithByteArray:(IOSByteArray *)data {
  return AMCryptoUtils_SHA256WithByteArray_(data);
}


#line 42
+ (IOSByteArray *)SHA512WithByteArray:(IOSByteArray *)data {
  return AMCryptoUtils_SHA512WithByteArray_(data);
}


#line 52
+ (jint)randomIntWithInt:(jint)maxValue {
  return AMCryptoUtils_randomIntWithInt_(maxValue);
}


#line 62
+ (IOSByteArray *)randomBytesWithInt:(jint)len {
  return AMCryptoUtils_randomBytesWithInt_(len);
}


#line 72
+ (NSString *)hexWithByteArray:(IOSByteArray *)bytes {
  return AMCryptoUtils_hexWithByteArray_(bytes);
}


#line 82
+ (jint)fromHexShortWithChar:(jchar)a {
  return AMCryptoUtils_fromHexShortWithChar_(a);
}


#line 93
+ (IOSByteArray *)fromHexWithNSString:(NSString *)hex {
  return AMCryptoUtils_fromHexWithNSString_(hex);
}

- (instancetype)init {
  AMCryptoUtils_init(self);
  return self;
}

+ (void)initialize {
  if (self == [AMCryptoUtils class]) {
    AMCryptoUtils_hexArray_ =
#line 10
    [@"0123456789abcdef" toCharArray];
    J2OBJC_SET_INITIALIZED(AMCryptoUtils)
  }
}

@end


#line 14
void AMCryptoUtils_init__WithAMCryptoProvider_(id<AMCryptoProvider> provider) {
  AMCryptoUtils_initialize();
  
#line 15
  AMCryptoUtils_provider_ = provider;
}


#line 18
AMCryptoKeyPair *AMCryptoUtils_generateRSA1024KeyPair() {
  AMCryptoUtils_initialize();
  
#line 19
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) generateRSA1024KeyPair];
}


#line 22
IOSByteArray *AMCryptoUtils_MD5WithByteArray_(IOSByteArray *data) {
  AMCryptoUtils_initialize();
  
#line 23
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) MD5WithByteArray:data];
}


#line 32
IOSByteArray *AMCryptoUtils_SHA256WithByteArray_(IOSByteArray *data) {
  AMCryptoUtils_initialize();
  
#line 33
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) SHA256WithByteArray:data];
}


#line 42
IOSByteArray *AMCryptoUtils_SHA512WithByteArray_(IOSByteArray *data) {
  AMCryptoUtils_initialize();
  
#line 43
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) SHA512WithByteArray:data];
}


#line 52
jint AMCryptoUtils_randomIntWithInt_(jint maxValue) {
  AMCryptoUtils_initialize();
  
#line 53
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) randomIntWithInt:maxValue];
}


#line 62
IOSByteArray *AMCryptoUtils_randomBytesWithInt_(jint len) {
  AMCryptoUtils_initialize();
  
#line 63
  return [((id<AMCryptoProvider>) nil_chk(AMCryptoUtils_provider_)) randomBytesWithInt:len];
}


#line 72
NSString *AMCryptoUtils_hexWithByteArray_(IOSByteArray *bytes) {
  AMCryptoUtils_initialize();
  
#line 73
  IOSCharArray *hexChars = [IOSCharArray newArrayWithLength:((IOSByteArray *) nil_chk(bytes))->size_ * 2];
  for (jint j = 0; j < bytes->size_; j++) {
    jint v = IOSByteArray_Get(bytes, j) & (jint) 0xFF;
    *IOSCharArray_GetRef(hexChars, j * 2) = IOSCharArray_Get(nil_chk(AMCryptoUtils_hexArray_), URShift32(v, 4));
    *IOSCharArray_GetRef(hexChars, j * 2 + 1) = IOSCharArray_Get(AMCryptoUtils_hexArray_, v & (jint) 0x0F);
  }
  return [NSString stringWithCharacters:hexChars];
}


#line 82
jint AMCryptoUtils_fromHexShortWithChar_(jchar a) {
  AMCryptoUtils_initialize();
  
#line 83
  if (a >= '0' && a <= '9') {
    return a - '0';
  }
  if (a >= 'a' && a <= 'f') {
    return 10 + (a - 'a');
  }
  
#line 90
  @throw new_JavaLangRuntimeException_init();
}


#line 93
IOSByteArray *AMCryptoUtils_fromHexWithNSString_(NSString *hex) {
  AMCryptoUtils_initialize();
  
#line 94
  IOSByteArray *res = [IOSByteArray newArrayWithLength:((jint) [((NSString *) nil_chk(hex)) length]) / 2];
  for (jint i = 0; i < res->size_; i++) {
    *IOSByteArray_GetRef(res, i) = (jbyte) ((LShift32(AMCryptoUtils_fromHexShortWithChar_([hex charAtWithInt:i * 2]), 4)) + AMCryptoUtils_fromHexShortWithChar_([hex charAtWithInt:i * 2 + 1]));
  }
  return res;
}

void AMCryptoUtils_init(AMCryptoUtils *self) {
  (void) NSObject_init(self);
}

AMCryptoUtils *new_AMCryptoUtils_init() {
  AMCryptoUtils *self = [AMCryptoUtils alloc];
  AMCryptoUtils_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(AMCryptoUtils)