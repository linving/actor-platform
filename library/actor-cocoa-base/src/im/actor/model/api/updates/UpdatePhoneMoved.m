//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/updates/UpdatePhoneMoved.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/updates/UpdatePhoneMoved.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Update.h"
#include "java/io/IOException.h"

@interface ImActorModelApiUpdatesUpdatePhoneMoved () {
 @public
  jint phoneId_;
  jint uid_;
}

@end

@implementation ImActorModelApiUpdatesUpdatePhoneMoved

+ (ImActorModelApiUpdatesUpdatePhoneMoved *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiUpdatesUpdatePhoneMoved_fromBytesWithByteArray_(data);
}

- (instancetype)initWithInt:(jint)phoneId
                    withInt:(jint)uid {
  ImActorModelApiUpdatesUpdatePhoneMoved_initWithInt_withInt_(self, phoneId, uid);
  return self;
}

- (instancetype)init {
  ImActorModelApiUpdatesUpdatePhoneMoved_init(self);
  return self;
}

- (jint)getPhoneId {
  return self->phoneId_;
}

- (jint)getUid {
  return self->uid_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->phoneId_ = [((BSBserValues *) nil_chk(values)) getIntWithInt:1];
  self->uid_ = [values getIntWithInt:2];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  [((BSBserWriter *) nil_chk(writer)) writeIntWithInt:1 withInt:self->phoneId_];
  [writer writeIntWithInt:2 withInt:self->uid_];
}

- (NSString *)description {
  NSString *res = @"update PhoneMoved{";
  res = JreStrcat("$$", res, JreStrcat("$I", @"phoneId=", self->phoneId_));
  res = JreStrcat("$$", res, JreStrcat("$I", @", uid=", self->uid_));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiUpdatesUpdatePhoneMoved_HEADER;
}

@end

ImActorModelApiUpdatesUpdatePhoneMoved *ImActorModelApiUpdatesUpdatePhoneMoved_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiUpdatesUpdatePhoneMoved_initialize();
  return ((ImActorModelApiUpdatesUpdatePhoneMoved *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiUpdatesUpdatePhoneMoved_init(), data));
}

void ImActorModelApiUpdatesUpdatePhoneMoved_initWithInt_withInt_(ImActorModelApiUpdatesUpdatePhoneMoved *self, jint phoneId, jint uid) {
  (void) ImActorModelNetworkParserUpdate_init(self);
  self->phoneId_ = phoneId;
  self->uid_ = uid;
}

ImActorModelApiUpdatesUpdatePhoneMoved *new_ImActorModelApiUpdatesUpdatePhoneMoved_initWithInt_withInt_(jint phoneId, jint uid) {
  ImActorModelApiUpdatesUpdatePhoneMoved *self = [ImActorModelApiUpdatesUpdatePhoneMoved alloc];
  ImActorModelApiUpdatesUpdatePhoneMoved_initWithInt_withInt_(self, phoneId, uid);
  return self;
}

void ImActorModelApiUpdatesUpdatePhoneMoved_init(ImActorModelApiUpdatesUpdatePhoneMoved *self) {
  (void) ImActorModelNetworkParserUpdate_init(self);
}

ImActorModelApiUpdatesUpdatePhoneMoved *new_ImActorModelApiUpdatesUpdatePhoneMoved_init() {
  ImActorModelApiUpdatesUpdatePhoneMoved *self = [ImActorModelApiUpdatesUpdatePhoneMoved alloc];
  ImActorModelApiUpdatesUpdatePhoneMoved_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiUpdatesUpdatePhoneMoved)