#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "Api.pbrpc.h"
#import "Api.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import "core/Tron.pbobjc.h"
#import "core/Contract.pbobjc.h"
#import "google/api/Annotations.pbobjc.h"

@implementation TWallet

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protocol"
                 serviceName:@"Wallet"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark GetAccount(TronAccount) returns (TronAccount)

- (void)getAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronAccount class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransaction(TransferContract) returns (TronTransaction)

- (void)createTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCreateTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark BroadcastTransaction(TronTransaction) returns (Return)

- (void)broadcastTransactionWithRequest:(TronTransaction *)request handler:(void(^)(Return *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToBroadcastTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToBroadcastTransactionWithRequest:(TronTransaction *)request handler:(void(^)(Return *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"BroadcastTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Return class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAccount(AccountUpdateContract) returns (TronTransaction)

- (void)updateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUpdateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark VoteWitnessAccount(VoteWitnessContract) returns (TronTransaction)

- (void)voteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVoteWitnessAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToVoteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VoteWitnessAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAssetIssue(AssetIssueContract) returns (TronTransaction)

- (void)createAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAssetIssueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCreateAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAssetIssue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateWitness(WitnessUpdateContract) returns (TronTransaction)

- (void)updateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateWitnessWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUpdateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateWitness"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAccount(AccountCreateContract) returns (TronTransaction)

- (void)createAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCreateAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateWitness(WitnessCreateContract) returns (TronTransaction)

- (void)createWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateWitnessWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCreateWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateWitness"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TransferAsset(TransferAssetContract) returns (TronTransaction)

- (void)transferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTransferAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTransferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TransferAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ParticipateAssetIssue(ParticipateAssetIssueContract) returns (TronTransaction)

- (void)participateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToParticipateAssetIssueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToParticipateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ParticipateAssetIssue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark FreezeBalance(FreezeBalanceContract) returns (TronTransaction)

- (void)freezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToFreezeBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToFreezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"FreezeBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeBalance(UnfreezeBalanceContract) returns (TronTransaction)

- (void)unfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUnfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeAsset(UnfreezeAssetContract) returns (TronTransaction)

- (void)unfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUnfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark WithdrawBalance(WithdrawBalanceContract) returns (TronTransaction)

- (void)withdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToWithdrawBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToWithdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"WithdrawBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAsset(UpdateAssetContract) returns (TronTransaction)

- (void)updateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUpdateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ListNodes(EmptyMessage) returns (NodeList)

- (void)listNodesWithRequest:(EmptyMessage *)request handler:(void(^)(NodeList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListNodesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToListNodesWithRequest:(EmptyMessage *)request handler:(void(^)(NodeList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NodeList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAssetIssueByAccount(TronAccount) returns (AssetIssueList)

- (void)getAssetIssueByAccountWithRequest:(TronAccount *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAssetIssueByAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAssetIssueByAccountWithRequest:(TronAccount *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAssetIssueByAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AssetIssueList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccountNet(TronAccount) returns (AccountNetMessage)

- (void)getAccountNetWithRequest:(TronAccount *)request handler:(void(^)(AccountNetMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountNetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountNetWithRequest:(TronAccount *)request handler:(void(^)(AccountNetMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountNet"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountNetMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAssetIssueByName(BytesMessage) returns (AssetIssueContract)

- (void)getAssetIssueByNameWithRequest:(BytesMessage *)request handler:(void(^)(AssetIssueContract *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAssetIssueByNameWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAssetIssueByNameWithRequest:(BytesMessage *)request handler:(void(^)(AssetIssueContract *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAssetIssueByName"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AssetIssueContract class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockById(BytesMessage) returns (Block)

- (void)getBlockByIdWithRequest:(BytesMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByIdWithRequest:(BytesMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByLimitNext(BlockLimit) returns (BlockList)

- (void)getBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLimitNextWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLimitNext"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByLatestNum(NumberMessage) returns (BlockList)

- (void)getBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLatestNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLatestNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionById(BytesMessage) returns (TronTransaction)

- (void)getTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ListWitnesses(EmptyMessage) returns (WitnessList)

- (void)listWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListWitnessesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToListWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListWitnesses"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[WitnessList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAssetIssueList(EmptyMessage) returns (AssetIssueList)

- (void)getAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAssetIssueListWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAssetIssueList"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AssetIssueList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TotalTransaction(EmptyMessage) returns (NumberMessage)

- (void)totalTransactionWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTotalTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTotalTransactionWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TotalTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NumberMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNextMaintenanceTime(EmptyMessage) returns (NumberMessage)

- (void)getNextMaintenanceTimeWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNextMaintenanceTimeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNextMaintenanceTimeWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNextMaintenanceTime"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NumberMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
@implementation WalletSolidity

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protocol"
                 serviceName:@"WalletSolidity"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark GetAccount(TronAccount) returns (TronAccount)

- (void)getAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronAccount class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ListWitnesses(EmptyMessage) returns (WitnessList)

- (void)listWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListWitnessesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToListWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListWitnesses"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[WitnessList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAssetIssueList(EmptyMessage) returns (AssetIssueList)

- (void)getAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAssetIssueListWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAssetIssueList"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AssetIssueList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
@implementation WalletExtension

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protocol"
                 serviceName:@"WalletExtension"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark GetTransactionsFromThis(AccountPaginated) returns (TransactionList)

- (void)getTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsFromThisWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsFromThis"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionsToThis(AccountPaginated) returns (TransactionList)

- (void)getTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsToThisWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsToThis"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
@implementation Database

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protocol"
                 serviceName:@"Database"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark getBlockReference(EmptyMessage) returns (BlockReference)

/**
 * for tapos
 */
- (void)getBlockReferenceWithRequest:(EmptyMessage *)request handler:(void(^)(BlockReference *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCTogetBlockReferenceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * for tapos
 */
- (GRPCProtoCall *)RPCTogetBlockReferenceWithRequest:(EmptyMessage *)request handler:(void(^)(BlockReference *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"getBlockReference"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockReference class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetDynamicProperties(EmptyMessage) returns (DynamicProperties)

- (void)getDynamicPropertiesWithRequest:(EmptyMessage *)request handler:(void(^)(DynamicProperties *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetDynamicPropertiesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetDynamicPropertiesWithRequest:(EmptyMessage *)request handler:(void(^)(DynamicProperties *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetDynamicProperties"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DynamicProperties class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
@implementation Network

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protocol"
                 serviceName:@"Network"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

@end
#endif
