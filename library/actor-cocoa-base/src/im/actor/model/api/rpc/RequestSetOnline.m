//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/rpc/RequestSetOnline.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/rpc/RequestSetOnline.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Request.h"
#include "java/io/IOException.h"

@interface ImActorModelApiRpcRequestSetOnline () {
 @public
  jboolean isOnline__;
  jlong timeout_;
}

@end

@implementation ImActorModelApiRpcRequestSetOnline

+ (ImActorModelApiRpcRequestSetOnline *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiRpcRequestSetOnline_fromBytesWithByteArray_(data);
}

- (instancetype)initWithBoolean:(jboolean)isOnline
                       withLong:(jlong)timeout {
  ImActorModelApiRpcRequestSetOnline_initWithBoolean_withLong_(self, isOnline, timeout);
  return self;
}

- (instancetype)init {
  ImActorModelApiRpcRequestSetOnline_init(self);
  return self;
}

- (jboolean)isOnline {
  return self->isOnline__;
}

- (jlong)getTimeout {
  return self->timeout_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->isOnline__ = [((BSBserValues *) nil_chk(values)) getBoolWithInt:1];
  self->timeout_ = [values getLongWithInt:2];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  [((BSBserWriter *) nil_chk(writer)) writeBoolWithInt:1 withBoolean:self->isOnline__];
  [writer writeLongWithInt:2 withLong:self->timeout_];
}

- (NSString *)description {
  NSString *res = @"rpc SetOnline{";
  res = JreStrcat("$$", res, JreStrcat("$Z", @"isOnline=", self->isOnline__));
  res = JreStrcat("$$", res, JreStrcat("$J", @", timeout=", self->timeout_));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiRpcRequestSetOnline_HEADER;
}

@end

ImActorModelApiRpcRequestSetOnline *ImActorModelApiRpcRequestSetOnline_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiRpcRequestSetOnline_initialize();
  return ((ImActorModelApiRpcRequestSetOnline *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiRpcRequestSetOnline_init(), data));
}

void ImActorModelApiRpcRequestSetOnline_initWithBoolean_withLong_(ImActorModelApiRpcRequestSetOnline *self, jboolean isOnline, jlong timeout) {
  (void) ImActorModelNetworkParserRequest_init(self);
  self->isOnline__ = isOnline;
  self->timeout_ = timeout;
}

ImActorModelApiRpcRequestSetOnline *new_ImActorModelApiRpcRequestSetOnline_initWithBoolean_withLong_(jboolean isOnline, jlong timeout) {
  ImActorModelApiRpcRequestSetOnline *self = [ImActorModelApiRpcRequestSetOnline alloc];
  ImActorModelApiRpcRequestSetOnline_initWithBoolean_withLong_(self, isOnline, timeout);
  return self;
}

void ImActorModelApiRpcRequestSetOnline_init(ImActorModelApiRpcRequestSetOnline *self) {
  (void) ImActorModelNetworkParserRequest_init(self);
}

ImActorModelApiRpcRequestSetOnline *new_ImActorModelApiRpcRequestSetOnline_init() {
  ImActorModelApiRpcRequestSetOnline *self = [ImActorModelApiRpcRequestSetOnline alloc];
  ImActorModelApiRpcRequestSetOnline_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiRpcRequestSetOnline)