//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/updates/UpdateContactRegistered.java
//

#ifndef _ImActorModelApiUpdatesUpdateContactRegistered_H_
#define _ImActorModelApiUpdatesUpdateContactRegistered_H_

#include "J2ObjC_header.h"
#include "im/actor/model/network/parser/Update.h"

@class BSBserValues;
@class BSBserWriter;
@class IOSByteArray;

#define ImActorModelApiUpdatesUpdateContactRegistered_HEADER 5

@interface ImActorModelApiUpdatesUpdateContactRegistered : ImActorModelNetworkParserUpdate

#pragma mark Public

- (instancetype)init;

- (instancetype)initWithInt:(jint)uid
                withBoolean:(jboolean)isSilent
                   withLong:(jlong)date
                   withLong:(jlong)rid;

+ (ImActorModelApiUpdatesUpdateContactRegistered *)fromBytesWithByteArray:(IOSByteArray *)data;

- (jlong)getDate;

- (jint)getHeaderKey;

- (jlong)getRid;

- (jint)getUid;

- (jboolean)isSilent;

- (void)parseWithBSBserValues:(BSBserValues *)values;

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer;

- (NSString *)description;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelApiUpdatesUpdateContactRegistered)

J2OBJC_STATIC_FIELD_GETTER(ImActorModelApiUpdatesUpdateContactRegistered, HEADER, jint)

FOUNDATION_EXPORT ImActorModelApiUpdatesUpdateContactRegistered *ImActorModelApiUpdatesUpdateContactRegistered_fromBytesWithByteArray_(IOSByteArray *data);

FOUNDATION_EXPORT void ImActorModelApiUpdatesUpdateContactRegistered_initWithInt_withBoolean_withLong_withLong_(ImActorModelApiUpdatesUpdateContactRegistered *self, jint uid, jboolean isSilent, jlong date, jlong rid);

FOUNDATION_EXPORT ImActorModelApiUpdatesUpdateContactRegistered *new_ImActorModelApiUpdatesUpdateContactRegistered_initWithInt_withBoolean_withLong_withLong_(jint uid, jboolean isSilent, jlong date, jlong rid) NS_RETURNS_RETAINED;

FOUNDATION_EXPORT void ImActorModelApiUpdatesUpdateContactRegistered_init(ImActorModelApiUpdatesUpdateContactRegistered *self);

FOUNDATION_EXPORT ImActorModelApiUpdatesUpdateContactRegistered *new_ImActorModelApiUpdatesUpdateContactRegistered_init() NS_RETURNS_RETAINED;

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelApiUpdatesUpdateContactRegistered)

#endif // _ImActorModelApiUpdatesUpdateContactRegistered_H_