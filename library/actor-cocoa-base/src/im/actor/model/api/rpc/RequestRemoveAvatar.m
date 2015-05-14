//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/rpc/RequestRemoveAvatar.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/rpc/RequestRemoveAvatar.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Request.h"
#include "java/io/IOException.h"

@implementation ImActorModelApiRpcRequestRemoveAvatar

+ (ImActorModelApiRpcRequestRemoveAvatar *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiRpcRequestRemoveAvatar_fromBytesWithByteArray_(data);
}

- (instancetype)init {
  ImActorModelApiRpcRequestRemoveAvatar_init(self);
  return self;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
}

- (NSString *)description {
  NSString *res = @"rpc RemoveAvatar{";
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiRpcRequestRemoveAvatar_HEADER;
}

@end

ImActorModelApiRpcRequestRemoveAvatar *ImActorModelApiRpcRequestRemoveAvatar_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiRpcRequestRemoveAvatar_initialize();
  return ((ImActorModelApiRpcRequestRemoveAvatar *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiRpcRequestRemoveAvatar_init(), data));
}

void ImActorModelApiRpcRequestRemoveAvatar_init(ImActorModelApiRpcRequestRemoveAvatar *self) {
  (void) ImActorModelNetworkParserRequest_init(self);
}

ImActorModelApiRpcRequestRemoveAvatar *new_ImActorModelApiRpcRequestRemoveAvatar_init() {
  ImActorModelApiRpcRequestRemoveAvatar *self = [ImActorModelApiRpcRequestRemoveAvatar alloc];
  ImActorModelApiRpcRequestRemoveAvatar_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiRpcRequestRemoveAvatar)