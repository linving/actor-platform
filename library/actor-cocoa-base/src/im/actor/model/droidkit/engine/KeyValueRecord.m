//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/droidkit/engine/KeyValueRecord.java
//


#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/droidkit/engine/KeyValueRecord.h"

@interface DKKeyValueRecord () {
 @public
  jlong id__;
  IOSByteArray *data_;
}

@end

J2OBJC_FIELD_SETTER(DKKeyValueRecord, data_, IOSByteArray *)

@implementation DKKeyValueRecord

- (instancetype)initWithLong:(jlong)id_
               withByteArray:(IOSByteArray *)data {
  DKKeyValueRecord_initWithLong_withByteArray_(self, id_, data);
  return self;
}

- (jlong)getId {
  return id__;
}

- (IOSByteArray *)getData {
  return data_;
}

@end

void DKKeyValueRecord_initWithLong_withByteArray_(DKKeyValueRecord *self, jlong id_, IOSByteArray *data) {
  (void) NSObject_init(self);
  self->id__ = id_;
  self->data_ = data;
}

DKKeyValueRecord *new_DKKeyValueRecord_initWithLong_withByteArray_(jlong id_, IOSByteArray *data) {
  DKKeyValueRecord *self = [DKKeyValueRecord alloc];
  DKKeyValueRecord_initWithLong_withByteArray_(self, id_, data);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(DKKeyValueRecord)