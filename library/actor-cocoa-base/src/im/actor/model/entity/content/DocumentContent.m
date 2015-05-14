//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/entity/content/DocumentContent.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/entity/content/AbsContent.h"
#include "im/actor/model/entity/content/DocumentContent.h"
#include "im/actor/model/entity/content/FastThumb.h"
#include "im/actor/model/entity/content/FileSource.h"
#include "java/io/IOException.h"

@implementation AMDocumentContent

+ (AMDocumentContent *)docFromBytesWithByteArray:(IOSByteArray *)data {
  return AMDocumentContent_docFromBytesWithByteArray_(data);
}

- (instancetype)initWithAMFileSource:(AMFileSource *)source
                        withNSString:(NSString *)mimetype
                        withNSString:(NSString *)name
                     withAMFastThumb:(AMFastThumb *)fastThumb {
  AMDocumentContent_initWithAMFileSource_withNSString_withNSString_withAMFastThumb_(self, source, mimetype, name, fastThumb);
  return self;
}

- (instancetype)init {
  AMDocumentContent_init(self);
  return self;
}

- (AMFileSource *)getSource {
  return source_;
}

- (NSString *)getName {
  return name_;
}

- (AMFastThumb *)getFastThumb {
  return fastThumb_;
}

- (NSString *)getExt {
  NSString *ext = @"";
  jint dotIndex = [((NSString *) nil_chk(name_)) lastIndexOf:'.'];
  if (dotIndex >= 0) {
    ext = [name_ substring:dotIndex + 1];
  }
  return ext;
}

- (NSString *)getMimetype {
  return mimetype_;
}

- (AMAbsContent_ContentTypeEnum *)getContentType {
  return AMAbsContent_ContentTypeEnum_get_DOCUMENT();
}

- (void)parseWithBSBserValues:(BSBserValues *)values {
  [super parseWithBSBserValues:values];
  source_ = AMFileSource_fromBytesWithByteArray_([((BSBserValues *) nil_chk(values)) getBytesWithInt:2]);
  mimetype_ = [values getStringWithInt:3];
  name_ = [values getStringWithInt:4];
  IOSByteArray *ft = [values optBytesWithInt:5];
  if (ft != nil) {
    fastThumb_ = AMFastThumb_fromBytesWithByteArray_(ft);
  }
}

- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  [super serializeWithBSBserWriter:writer];
  [((BSBserWriter *) nil_chk(writer)) writeBytesWithInt:2 withByteArray:[((AMFileSource *) nil_chk(source_)) toByteArray]];
  [writer writeStringWithInt:3 withNSString:mimetype_];
  [writer writeStringWithInt:4 withNSString:name_];
  if (fastThumb_ != nil) {
    [writer writeObjectWithInt:5 withBSBserObject:fastThumb_];
  }
}

@end

AMDocumentContent *AMDocumentContent_docFromBytesWithByteArray_(IOSByteArray *data) {
  AMDocumentContent_initialize();
  return ((AMDocumentContent *) BSBser_parseWithBSBserObject_withByteArray_(new_AMDocumentContent_init(), data));
}

void AMDocumentContent_initWithAMFileSource_withNSString_withNSString_withAMFastThumb_(AMDocumentContent *self, AMFileSource *source, NSString *mimetype, NSString *name, AMFastThumb *fastThumb) {
  (void) AMAbsContent_init(self);
  self->source_ = source;
  self->mimetype_ = mimetype;
  self->name_ = name;
  self->fastThumb_ = fastThumb;
}

AMDocumentContent *new_AMDocumentContent_initWithAMFileSource_withNSString_withNSString_withAMFastThumb_(AMFileSource *source, NSString *mimetype, NSString *name, AMFastThumb *fastThumb) {
  AMDocumentContent *self = [AMDocumentContent alloc];
  AMDocumentContent_initWithAMFileSource_withNSString_withNSString_withAMFastThumb_(self, source, mimetype, name, fastThumb);
  return self;
}

void AMDocumentContent_init(AMDocumentContent *self) {
  (void) AMAbsContent_init(self);
}

AMDocumentContent *new_AMDocumentContent_init() {
  AMDocumentContent *self = [AMDocumentContent alloc];
  AMDocumentContent_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(AMDocumentContent)