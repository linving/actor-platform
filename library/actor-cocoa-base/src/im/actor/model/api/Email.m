//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/Email.java
//


#include "IOSClass.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/Email.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "java/io/IOException.h"

@interface ImActorModelApiEmail () {
 @public
  jint id__;
  jlong accessHash_;
  NSString *email_;
  NSString *emailTitle_;
}

@end

J2OBJC_FIELD_SETTER(ImActorModelApiEmail, email_, NSString *)
J2OBJC_FIELD_SETTER(ImActorModelApiEmail, emailTitle_, NSString *)

@implementation ImActorModelApiEmail

- (instancetype)initWithInt:(jint)id_
                   withLong:(jlong)accessHash
               withNSString:(NSString *)email
               withNSString:(NSString *)emailTitle {
  ImActorModelApiEmail_initWithInt_withLong_withNSString_withNSString_(self, id_, accessHash, email, emailTitle);
  return self;
}

- (instancetype)init {
  ImActorModelApiEmail_init(self);
  return self;
}

- (jint)getId {
  return self->id__;
}

- (jlong)getAccessHash {
  return self->accessHash_;
}

- (NSString *)getEmail {
  return self->email_;
}

- (NSString *)getEmailTitle {
  return self->emailTitle_;
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->id__ = [((BSBserValues *) nil_chk(values)) getIntWithInt:1];
  self->accessHash_ = [values getLongWithInt:2];
  self->email_ = [values getStringWithInt:3];
  self->emailTitle_ = [values getStringWithInt:4];
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  [((BSBserWriter *) nil_chk(writer)) writeIntWithInt:1 withInt:self->id__];
  [writer writeLongWithInt:2 withLong:self->accessHash_];
  if (self->email_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [writer writeStringWithInt:3 withNSString:self->email_];
  if (self->emailTitle_ == nil) {
    @throw new_JavaIoIOException_init();
  }
  [writer writeStringWithInt:4 withNSString:self->emailTitle_];
}

- (NSString *)description {
  NSString *res = @"struct Email{";
  res = JreStrcat("$$", res, JreStrcat("$I", @"id=", self->id__));
  res = JreStrcat("$$", res, JreStrcat("$$", @", email=", self->email_));
  res = JreStrcat("$$", res, JreStrcat("$$", @", emailTitle=", self->emailTitle_));
  res = JreStrcat("$C", res, '}');
  return res;
}

@end

void ImActorModelApiEmail_initWithInt_withLong_withNSString_withNSString_(ImActorModelApiEmail *self, jint id_, jlong accessHash, NSString *email, NSString *emailTitle) {
  (void) BSBserObject_init(self);
  self->id__ = id_;
  self->accessHash_ = accessHash;
  self->email_ = email;
  self->emailTitle_ = emailTitle;
}

ImActorModelApiEmail *new_ImActorModelApiEmail_initWithInt_withLong_withNSString_withNSString_(jint id_, jlong accessHash, NSString *email, NSString *emailTitle) {
  ImActorModelApiEmail *self = [ImActorModelApiEmail alloc];
  ImActorModelApiEmail_initWithInt_withLong_withNSString_withNSString_(self, id_, accessHash, email, emailTitle);
  return self;
}

void ImActorModelApiEmail_init(ImActorModelApiEmail *self) {
  (void) BSBserObject_init(self);
}

ImActorModelApiEmail *new_ImActorModelApiEmail_init() {
  ImActorModelApiEmail *self = [ImActorModelApiEmail alloc];
  ImActorModelApiEmail_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiEmail)