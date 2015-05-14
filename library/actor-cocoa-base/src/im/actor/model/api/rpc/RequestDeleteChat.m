//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/rpc/RequestDeleteChat.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/OutPeer.h"
#include "im/actor/model/api/rpc/RequestDeleteChat.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Request.h"
#include "java/io/IOException.h"

@interface ImActorModelApiRpcRequestDeleteChat () {
 @public
  ImActorModelApiOutPeer *peer_;
}

@end

J2OBJC_FIELD_SETTER(ImActorModelApiRpcRequestDeleteChat, peer_, ImActorModelApiOutPeer *)

@implementation ImActorModelApiRpcRequestDeleteChat

+ (ImActorModelApiRpcRequestDeleteChat *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiRpcRequestDeleteChat_fromBytesWithByteArray_(data);
}

- (instancetype)initWithImActorModelApiOutPeer:(ImActorModelApiOutPeer *)peer {
  ImActorModelApiRpcRequestDeleteChat_initWithImActorModelApiOutPeer_(self, peer);
  return self;
}

- (instancetype)init {
  ImActorModelApiRpcRequestDeleteChat_init(self);
  return self;
}

- (ImActorModelApiOutPeer *)getPeer {
  return self->peer_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->peer_ = [((BSBserValues *) nil_chk(values)) getObjWithInt:1 withBSBserObject:new_ImActorModelApiOutPeer_init()];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  if (self->peer_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [((BSBserWriter *) nil_chk(writer)) writeObjectWithInt:1 withBSBserObject:self->peer_];
}

- (NSString *)description {
  NSString *res = @"rpc DeleteChat{";
  res = JreStrcat("$$", res, JreStrcat("$@", @"peer=", self->peer_));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiRpcRequestDeleteChat_HEADER;
}

@end

ImActorModelApiRpcRequestDeleteChat *ImActorModelApiRpcRequestDeleteChat_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiRpcRequestDeleteChat_initialize();
  return ((ImActorModelApiRpcRequestDeleteChat *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiRpcRequestDeleteChat_init(), data));
}

void ImActorModelApiRpcRequestDeleteChat_initWithImActorModelApiOutPeer_(ImActorModelApiRpcRequestDeleteChat *self, ImActorModelApiOutPeer *peer) {
  (void) ImActorModelNetworkParserRequest_init(self);
  self->peer_ = peer;
}

ImActorModelApiRpcRequestDeleteChat *new_ImActorModelApiRpcRequestDeleteChat_initWithImActorModelApiOutPeer_(ImActorModelApiOutPeer *peer) {
  ImActorModelApiRpcRequestDeleteChat *self = [ImActorModelApiRpcRequestDeleteChat alloc];
  ImActorModelApiRpcRequestDeleteChat_initWithImActorModelApiOutPeer_(self, peer);
  return self;
}

void ImActorModelApiRpcRequestDeleteChat_init(ImActorModelApiRpcRequestDeleteChat *self) {
  (void) ImActorModelNetworkParserRequest_init(self);
}

ImActorModelApiRpcRequestDeleteChat *new_ImActorModelApiRpcRequestDeleteChat_init() {
  ImActorModelApiRpcRequestDeleteChat *self = [ImActorModelApiRpcRequestDeleteChat alloc];
  ImActorModelApiRpcRequestDeleteChat_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiRpcRequestDeleteChat)