//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/rpc/ResponseAuth.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/Config.h"
#include "im/actor/model/api/User.h"
#include "im/actor/model/api/rpc/ResponseAuth.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Response.h"
#include "java/io/IOException.h"

@interface ImActorModelApiRpcResponseAuth () {
 @public
  ImActorModelApiUser *user_;
  ImActorModelApiConfig *config_;
}

@end

J2OBJC_FIELD_SETTER(ImActorModelApiRpcResponseAuth, user_, ImActorModelApiUser *)
J2OBJC_FIELD_SETTER(ImActorModelApiRpcResponseAuth, config_, ImActorModelApiConfig *)

@implementation ImActorModelApiRpcResponseAuth

+ (ImActorModelApiRpcResponseAuth *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiRpcResponseAuth_fromBytesWithByteArray_(data);
}

- (instancetype)initWithImActorModelApiUser:(ImActorModelApiUser *)user
                  withImActorModelApiConfig:(ImActorModelApiConfig *)config {
  ImActorModelApiRpcResponseAuth_initWithImActorModelApiUser_withImActorModelApiConfig_(self, user, config);
  return self;
}

- (instancetype)init {
  ImActorModelApiRpcResponseAuth_init(self);
  return self;
}

- (ImActorModelApiUser *)getUser {
  return self->user_;
}

- (ImActorModelApiConfig *)getConfig {
  return self->config_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->user_ = [((BSBserValues *) nil_chk(values)) getObjWithInt:2 withBSBserObject:new_ImActorModelApiUser_init()];
  self->config_ = [values getObjWithInt:3 withBSBserObject:new_ImActorModelApiConfig_init()];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  if (self->user_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [((BSBserWriter *) nil_chk(writer)) writeObjectWithInt:2 withBSBserObject:self->user_];
  if (self->config_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [writer writeObjectWithInt:3 withBSBserObject:self->config_];
}

- (NSString *)description {
  NSString *res = @"response Auth{";
  res = JreStrcat("$$", res, JreStrcat("$$", @"user=", (self->user_ != nil ? @"set" : @"empty")));
  res = JreStrcat("$$", res, JreStrcat("$@", @", config=", self->config_));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiRpcResponseAuth_HEADER;
}

@end

ImActorModelApiRpcResponseAuth *ImActorModelApiRpcResponseAuth_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiRpcResponseAuth_initialize();
  return ((ImActorModelApiRpcResponseAuth *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiRpcResponseAuth_init(), data));
}

void ImActorModelApiRpcResponseAuth_initWithImActorModelApiUser_withImActorModelApiConfig_(ImActorModelApiRpcResponseAuth *self, ImActorModelApiUser *user, ImActorModelApiConfig *config) {
  (void) ImActorModelNetworkParserResponse_init(self);
  self->user_ = user;
  self->config_ = config;
}

ImActorModelApiRpcResponseAuth *new_ImActorModelApiRpcResponseAuth_initWithImActorModelApiUser_withImActorModelApiConfig_(ImActorModelApiUser *user, ImActorModelApiConfig *config) {
  ImActorModelApiRpcResponseAuth *self = [ImActorModelApiRpcResponseAuth alloc];
  ImActorModelApiRpcResponseAuth_initWithImActorModelApiUser_withImActorModelApiConfig_(self, user, config);
  return self;
}

void ImActorModelApiRpcResponseAuth_init(ImActorModelApiRpcResponseAuth *self) {
  (void) ImActorModelNetworkParserResponse_init(self);
}

ImActorModelApiRpcResponseAuth *new_ImActorModelApiRpcResponseAuth_init() {
  ImActorModelApiRpcResponseAuth *self = [ImActorModelApiRpcResponseAuth alloc];
  ImActorModelApiRpcResponseAuth_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiRpcResponseAuth)