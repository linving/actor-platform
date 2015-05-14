//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/ServiceEx.java
//


#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/ServiceEx.h"
#include "im/actor/model/api/ServiceExChangedAvatar.h"
#include "im/actor/model/api/ServiceExChangedTitle.h"
#include "im/actor/model/api/ServiceExEmailContactRegistered.h"
#include "im/actor/model/api/ServiceExGroupCreated.h"
#include "im/actor/model/api/ServiceExUnsupported.h"
#include "im/actor/model/api/ServiceExUserAdded.h"
#include "im/actor/model/api/ServiceExUserKicked.h"
#include "im/actor/model/api/ServiceExUserLeft.h"
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

@implementation ImActorModelApiServiceEx

+ (ImActorModelApiServiceEx *)fromBytesWithByteArray:(IOSByteArray *)src {
  return ImActorModelApiServiceEx_fromBytesWithByteArray_(src);
}

- (IOSByteArray *)buildContainer {
  BSDataOutput *res = new_BSDataOutput_init();
  BSBserWriter *writer = new_BSBserWriter_initWithBSDataOutput_(res);
  [writer writeIntWithInt:1 withInt:[self getHeader]];
  [writer writeBytesWithInt:2 withByteArray:[self toByteArray]];
  return [res toByteArray];
}

- (instancetype)init {
  ImActorModelApiServiceEx_init(self);
  return self;
}

@end

ImActorModelApiServiceEx *ImActorModelApiServiceEx_fromBytesWithByteArray_(IOSByteArray *src) {
  ImActorModelApiServiceEx_initialize();
  BSBserValues *values = new_BSBserValues_initWithImActorModelDroidkitBserUtilSparseArray_(BSBserParser_deserializeWithBSDataInput_(new_BSDataInput_initWithByteArray_withInt_withInt_(src, 0, ((IOSByteArray *) nil_chk(src))->size_)));
  jint key = [values getIntWithInt:1];
  IOSByteArray *content = [values getBytesWithInt:2];
  switch (key) {
    case 1:
    return ((ImActorModelApiServiceExUserAdded *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExUserAdded_init(), content));
    case 2:
    return ((ImActorModelApiServiceExUserKicked *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExUserKicked_init(), content));
    case 3:
    return ((ImActorModelApiServiceExUserLeft *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExUserLeft_init(), content));
    case 4:
    return ((ImActorModelApiServiceExGroupCreated *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExGroupCreated_init(), content));
    case 5:
    return ((ImActorModelApiServiceExChangedTitle *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExChangedTitle_init(), content));
    case 6:
    return ((ImActorModelApiServiceExChangedAvatar *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExChangedAvatar_init(), content));
    case 7:
    return ((ImActorModelApiServiceExEmailContactRegistered *) BSBser_parseWithBSBserObject_withByteArray_(new_ImActorModelApiServiceExEmailContactRegistered_init(), content));
    default:
    return new_ImActorModelApiServiceExUnsupported_initWithInt_withByteArray_(key, content);
  }
}

void ImActorModelApiServiceEx_init(ImActorModelApiServiceEx *self) {
  (void) BSBserObject_init(self);
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiServiceEx)