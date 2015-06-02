//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/ContactType.java
//

#ifndef _APContactType_H_
#define _APContactType_H_

#include "J2ObjC_header.h"
#include "java/lang/Enum.h"

typedef NS_ENUM(NSUInteger, APContactType) {
  APContactType_PHONE = 0,
  APContactType_EMAIL = 1,
  APContactType_UNSUPPORTED_VALUE = 2,
};

@interface APContactTypeEnum : JavaLangEnum < NSCopying >

#pragma mark Public

- (jint)getValue;

+ (APContactTypeEnum *)parseWithInt:(jint)value;

#pragma mark Package-Private

+ (IOSObjectArray *)values;
FOUNDATION_EXPORT IOSObjectArray *APContactTypeEnum_values();

+ (APContactTypeEnum *)valueOfWithNSString:(NSString *)name;
FOUNDATION_EXPORT APContactTypeEnum *APContactTypeEnum_valueOfWithNSString_(NSString *name);

- (id)copyWithZone:(NSZone *)zone;

@end

J2OBJC_STATIC_INIT(APContactTypeEnum)

FOUNDATION_EXPORT APContactTypeEnum *APContactTypeEnum_values_[];

#define APContactTypeEnum_PHONE APContactTypeEnum_values_[APContactType_PHONE]
J2OBJC_ENUM_CONSTANT_GETTER(APContactTypeEnum, PHONE)

#define APContactTypeEnum_EMAIL APContactTypeEnum_values_[APContactType_EMAIL]
J2OBJC_ENUM_CONSTANT_GETTER(APContactTypeEnum, EMAIL)

#define APContactTypeEnum_UNSUPPORTED_VALUE APContactTypeEnum_values_[APContactType_UNSUPPORTED_VALUE]
J2OBJC_ENUM_CONSTANT_GETTER(APContactTypeEnum, UNSUPPORTED_VALUE)

FOUNDATION_EXPORT APContactTypeEnum *APContactTypeEnum_parseWithInt_(jint value);

J2OBJC_TYPE_LITERAL_HEADER(APContactTypeEnum)

typedef APContactTypeEnum ImActorModelApiContactTypeEnum;

#endif // _APContactType_H_