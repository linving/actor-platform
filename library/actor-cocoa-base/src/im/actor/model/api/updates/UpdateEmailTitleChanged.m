//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/updates/UpdateEmailTitleChanged.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/updates/UpdateEmailTitleChanged.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/network/parser/Update.h"
#include "java/io/IOException.h"

@interface ImActorModelApiUpdatesUpdateEmailTitleChanged () {
 @public
  jint emailId_;
  NSString *title_;
}

@end

J2OBJC_FIELD_SETTER(ImActorModelApiUpdatesUpdateEmailTitleChanged, title_, NSString *)

@implementation ImActorModelApiUpdatesUpdateEmailTitleChanged

+ (ImActorModelApiUpdatesUpdateEmailTitleChanged *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiUpdatesUpdateEmailTitleChanged_fromBytesWithByteArray_(data);
}

- (instancetype)initWithInt:(jint)emailId
               withNSString:(NSString *)title {
  ImActorModelApiUpdatesUpdateEmailTitleChanged_initWithInt_withNSString_(self, emailId, title);
  return self;
}

- (instancetype)init {
  ImActorModelApiUpdatesUpdateEmailTitleChanged_init(self);
  return self;
}

- (jint)getEmailId {
  return self->emailId_;
}

- (NSString *)getTitle {
  return self->title_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->emailId_ = [((BSBserValues *) nil_chk(values)) getIntWithInt:1];
  self->title_ = [values getStringWithInt:2];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  [((BSBserWriter *) nil_chk(writer)) writeIntWithInt:1 withInt:self->emailId_];
  if (self->title_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [writer writeStringWithInt:2 withNSString:self->title_];
}

- (NSString *)description {
  NSString *res = @"update EmailTitleChanged{";
  res = JreStrcat("$$", res, JreStrcat("$I", @"emailId=", self->emailId_));
  res = JreStrcat("$$", res, JreStrcat("$$", @", title=", self->title_));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (jint)getHeaderKey {
  return ImActorModelApiUpdatesUpdateEmailTitleChanged_HEADER;
}

@end

ImActorModelApiUpdatesUpdateEmailTitleChanged *ImActorModelApiUpdatesUpdateEmailTitleChanged_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiUpdatesUpdateEmailTitleChanged_initialize();
  return ((ImActorModelApiUpdatesUpdateEmailTitleChanged *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiUpdatesUpdateEmailTitleChanged_init(), data));
}

void ImActorModelApiUpdatesUpdateEmailTitleChanged_initWithInt_withNSString_(ImActorModelApiUpdatesUpdateEmailTitleChanged *self, jint emailId, NSString *title) {
  (void) ImActorModelNetworkParserUpdate_init(self);
  self->emailId_ = emailId;
  self->title_ = title;
}

ImActorModelApiUpdatesUpdateEmailTitleChanged *new_ImActorModelApiUpdatesUpdateEmailTitleChanged_initWithInt_withNSString_(jint emailId, NSString *title) {
  ImActorModelApiUpdatesUpdateEmailTitleChanged *self = [ImActorModelApiUpdatesUpdateEmailTitleChanged alloc];
  ImActorModelApiUpdatesUpdateEmailTitleChanged_initWithInt_withNSString_(self, emailId, title);
  return self;
}

void ImActorModelApiUpdatesUpdateEmailTitleChanged_init(ImActorModelApiUpdatesUpdateEmailTitleChanged *self) {
  (void) ImActorModelNetworkParserUpdate_init(self);
}

ImActorModelApiUpdatesUpdateEmailTitleChanged *new_ImActorModelApiUpdatesUpdateEmailTitleChanged_init() {
  ImActorModelApiUpdatesUpdateEmailTitleChanged *self = [ImActorModelApiUpdatesUpdateEmailTitleChanged alloc];
  ImActorModelApiUpdatesUpdateEmailTitleChanged_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiUpdatesUpdateEmailTitleChanged)