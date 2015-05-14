//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/DocumentEx.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/DocumentEx.h"
#include "im/actor/model/api/DocumentExPhoto.h"
#include "im/actor/model/api/DocumentExUnsupported.h"
#include "im/actor/model/api/DocumentExVideo.h"
#include "im/actor/model/api/DocumentExVoice.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserParser.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "im/actor/model/droidkit/bser/DataInput.h"
#include "im/actor/model/droidkit/bser/DataOutput.h"
#include "im/actor/model/droidkit/bser/util/SparseArray.h"
#include "java/io/IOException.h"

#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation ImActorModelApiDocumentEx

+ (ImActorModelApiDocumentEx *)fromBytesWithByteArray:(IOSByteArray *)src {
  return ImActorModelApiDocumentEx_fromBytesWithByteArray_(src);
}

- (IOSByteArray *)buildContainer {
  BSDataOutput *res = new_BSDataOutput_init();
  BSBserWriter *writer = new_BSBserWriter_initWithBSDataOutput_(res);
  [writer writeIntWithInt:1 withInt:[self getHeader]];
  [writer writeBytesWithInt:2 withByteArray:[self toByteArray]];
  return [res toByteArray];
}

- (instancetype)init {
  ImActorModelApiDocumentEx_init(self);
  return self;
}

@end

ImActorModelApiDocumentEx *ImActorModelApiDocumentEx_fromBytesWithByteArray_(IOSByteArray *src) {
  ImActorModelApiDocumentEx_initialize();
  BSBserValues *values = new_BSBserValues_initWithImActorModelDroidkitBserUtilSparseArray_(BSBserParser_deserializeWithBSDataInput_(new_BSDataInput_initWithByteArray_withInt_withInt_(src, 0, ((IOSByteArray *) nil_chk(src))->size_)));
  jint key = [values getIntWithInt:1];
  IOSByteArray *content = [values getBytesWithInt:2];
  switch (key) {
    case 1:
    return ((ImActorModelApiDocumentExPhoto *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiDocumentExPhoto_init(), content));
    case 2:
    return ((ImActorModelApiDocumentExVideo *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiDocumentExVideo_init(), content));
    case 3:
    return ((ImActorModelApiDocumentExVoice *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiDocumentExVoice_init(), content));
    default:
    return new_ImActorModelApiDocumentExUnsupported_initWithInt_withByteArray_(key, content);
  }
}

void ImActorModelApiDocumentEx_init(ImActorModelApiDocumentEx *self) {
  (void) BSBserObject_init(self);
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiDocumentEx)