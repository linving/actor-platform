//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/entity/content/FastThumb.java
//

#ifndef _AMFastThumb_H_
#define _AMFastThumb_H_

#include "J2ObjC_header.h"
#include "im/actor/model/droidkit/bser/BserObject.h"

@class BSBserValues;
@class BSBserWriter;
@class IOSByteArray;

@interface AMFastThumb : BSBserObject

#pragma mark Public

- (instancetype)initWithInt:(jint)w
                    withInt:(jint)h
              withByteArray:(IOSByteArray *)image;

+ (AMFastThumb *)fromBytesWithByteArray:(IOSByteArray *)data;

- (jint)getH;

- (IOSByteArray *)getImage;

- (jint)getW;

- (void)parseWithBSBserValues:(BSBserValues *)values;

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer;

@end

J2OBJC_EMPTY_STATIC_INIT(AMFastThumb)

FOUNDATION_EXPORT AMFastThumb *AMFastThumb_fromBytesWithByteArray_(IOSByteArray *data);

FOUNDATION_EXPORT void AMFastThumb_initWithInt_withInt_withByteArray_(AMFastThumb *self, jint w, jint h, IOSByteArray *image);

FOUNDATION_EXPORT AMFastThumb *new_AMFastThumb_initWithInt_withInt_withByteArray_(jint w, jint h, IOSByteArray *image) NS_RETURNS_RETAINED;

J2OBJC_TYPE_LITERAL_HEADER(AMFastThumb)

typedef AMFastThumb ImActorModelEntityContentFastThumb;

#endif // _AMFastThumb_H_