//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/messages/CursorReceiverActor.java
//

#ifndef _ImActorModelModulesMessagesCursorReceiverActor_H_
#define _ImActorModelModulesMessagesCursorReceiverActor_H_

@class AMPeer;
@class AMRpcException;
@class ImActorModelApiRpcResponseVoid;
@class ImActorModelModulesModules;

#include "J2ObjC_header.h"
#include "im/actor/model/modules/messages/CursorActor.h"
#include "im/actor/model/network/RpcCallback.h"

@interface ImActorModelModulesMessagesCursorReceiverActor : ImActorModelModulesMessagesCursorActor {
}

- (instancetype)initWithImActorModelModulesModules:(ImActorModelModulesModules *)messenger;

- (void)performWithAMPeer:(AMPeer *)peer
                 withLong:(jlong)date;

- (void)onReceiveWithId:(id)message;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesMessagesCursorReceiverActor)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesMessagesCursorReceiverActor)

@interface ImActorModelModulesMessagesCursorReceiverActor_MarkReceived : NSObject {
}

- (instancetype)initWithAMPeer:(AMPeer *)peer
                      withLong:(jlong)date;

- (AMPeer *)getPeer;

- (jlong)getDate;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesMessagesCursorReceiverActor_MarkReceived)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesMessagesCursorReceiverActor_MarkReceived)

@interface ImActorModelModulesMessagesCursorReceiverActor_$1 : NSObject < AMRpcCallback > {
}

- (void)onResultWithImActorModelNetworkParserResponse:(ImActorModelApiRpcResponseVoid *)response;

- (void)onErrorWithAMRpcException:(AMRpcException *)e;

- (instancetype)initWithImActorModelModulesMessagesCursorReceiverActor:(ImActorModelModulesMessagesCursorReceiverActor *)outer$
                                                            withAMPeer:(AMPeer *)capture$0
                                                              withLong:(jlong)capture$1;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesMessagesCursorReceiverActor_$1)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesMessagesCursorReceiverActor_$1)

#endif // _ImActorModelModulesMessagesCursorReceiverActor_H_