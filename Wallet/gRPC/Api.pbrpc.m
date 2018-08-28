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

#pragma mark GetAccount(Account) returns (Account)

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
#pragma mark GetAccountById(Account) returns (Account)

- (void)getAccountByIdWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountByIdWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronAccount class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransaction(TransferContract) returns (Transaction)

/**
 * Please use CreateTransaction2 instead of this function.
 */
- (void)createTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use CreateTransaction2 instead of this function.
 */
- (GRPCProtoCall *)RPCToCreateTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransaction2(TransferContract) returns (TransactionExtention)

/**
 * Use this function instead of CreateTransaction.
 */
- (void)createTransaction2WithRequest:(TransferContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransaction2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of CreateTransaction.
 */
- (GRPCProtoCall *)RPCToCreateTransaction2WithRequest:(TransferContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransaction2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark BroadcastTransaction(Transaction) returns (Return)

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
#pragma mark UpdateAccount(AccountUpdateContract) returns (Transaction)

/**
 * Please use UpdateAccount2 instead of this function.
 */
- (void)updateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use UpdateAccount2 instead of this function.
 */
- (GRPCProtoCall *)RPCToUpdateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetAccountId(SetAccountIdContract) returns (Transaction)

- (void)setAccountIdWithRequest:(SetAccountIdContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetAccountIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSetAccountIdWithRequest:(SetAccountIdContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetAccountId"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAccount2(AccountUpdateContract) returns (TransactionExtention)

/**
 * Use this function instead of UpdateAccount.
 */
- (void)updateAccount2WithRequest:(AccountUpdateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAccount2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of UpdateAccount.
 */
- (GRPCProtoCall *)RPCToUpdateAccount2WithRequest:(AccountUpdateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAccount2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark VoteWitnessAccount(VoteWitnessContract) returns (Transaction)

/**
 * Please use VoteWitnessAccount2 instead of this function.
 */
- (void)voteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVoteWitnessAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use VoteWitnessAccount2 instead of this function.
 */
- (GRPCProtoCall *)RPCToVoteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VoteWitnessAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateSetting(UpdateSettingContract) returns (TransactionExtention)

/**
 * modify the consume_user_resource_percent
 */
- (void)updateSettingWithRequest:(UpdateSettingContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateSettingWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * modify the consume_user_resource_percent
 */
- (GRPCProtoCall *)RPCToUpdateSettingWithRequest:(UpdateSettingContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateSetting"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark VoteWitnessAccount2(VoteWitnessContract) returns (TransactionExtention)

/**
 * Use this function instead of VoteWitnessAccount.
 */
- (void)voteWitnessAccount2WithRequest:(VoteWitnessContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVoteWitnessAccount2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of VoteWitnessAccount.
 */
- (GRPCProtoCall *)RPCToVoteWitnessAccount2WithRequest:(VoteWitnessContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VoteWitnessAccount2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAssetIssue(AssetIssueContract) returns (Transaction)

/**
 * Please use CreateAssetIssue2 instead of this function.
 */
- (void)createAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAssetIssueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use CreateAssetIssue2 instead of this function.
 */
- (GRPCProtoCall *)RPCToCreateAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAssetIssue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAssetIssue2(AssetIssueContract) returns (TransactionExtention)

/**
 * Use this function instead of CreateAssetIssue.
 */
- (void)createAssetIssue2WithRequest:(AssetIssueContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAssetIssue2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of CreateAssetIssue.
 */
- (GRPCProtoCall *)RPCToCreateAssetIssue2WithRequest:(AssetIssueContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAssetIssue2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateWitness(WitnessUpdateContract) returns (Transaction)

/**
 * Please use UpdateWitness2 instead of this function.
 */
- (void)updateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateWitnessWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use UpdateWitness2 instead of this function.
 */
- (GRPCProtoCall *)RPCToUpdateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateWitness"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateWitness2(WitnessUpdateContract) returns (TransactionExtention)

/**
 * Use this function instead of UpdateWitness.
 */
- (void)updateWitness2WithRequest:(WitnessUpdateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateWitness2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of UpdateWitness.
 */
- (GRPCProtoCall *)RPCToUpdateWitness2WithRequest:(WitnessUpdateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateWitness2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAccount(AccountCreateContract) returns (Transaction)

/**
 * Please use CreateAccount2 instead of this function.
 */
- (void)createAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use CreateAccount2 instead of this function.
 */
- (GRPCProtoCall *)RPCToCreateAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAccount2(AccountCreateContract) returns (TransactionExtention)

/**
 * Use this function instead of CreateAccount.
 */
- (void)createAccount2WithRequest:(AccountCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccount2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of CreateAccount.
 */
- (GRPCProtoCall *)RPCToCreateAccount2WithRequest:(AccountCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccount2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateWitness(WitnessCreateContract) returns (Transaction)

/**
 * Please use CreateWitness2 instead of this function.
 */
- (void)createWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateWitnessWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use CreateWitness2 instead of this function.
 */
- (GRPCProtoCall *)RPCToCreateWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateWitness"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateWitness2(WitnessCreateContract) returns (TransactionExtention)

/**
 * Use this function instead of CreateWitness.
 */
- (void)createWitness2WithRequest:(WitnessCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateWitness2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of CreateWitness.
 */
- (GRPCProtoCall *)RPCToCreateWitness2WithRequest:(WitnessCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateWitness2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TransferAsset(TransferAssetContract) returns (Transaction)

/**
 * Please use TransferAsset2 instead of this function.
 */
- (void)transferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTransferAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use TransferAsset2 instead of this function.
 */
- (GRPCProtoCall *)RPCToTransferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TransferAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TransferAsset2(TransferAssetContract) returns (TransactionExtention)

/**
 * Use this function instead of TransferAsset.
 */
- (void)transferAsset2WithRequest:(TransferAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTransferAsset2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of TransferAsset.
 */
- (GRPCProtoCall *)RPCToTransferAsset2WithRequest:(TransferAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TransferAsset2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ParticipateAssetIssue(ParticipateAssetIssueContract) returns (Transaction)

/**
 * Please use ParticipateAssetIssue2 instead of this function.
 */
- (void)participateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToParticipateAssetIssueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use ParticipateAssetIssue2 instead of this function.
 */
- (GRPCProtoCall *)RPCToParticipateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ParticipateAssetIssue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ParticipateAssetIssue2(ParticipateAssetIssueContract) returns (TransactionExtention)

/**
 * Use this function instead of ParticipateAssetIssue.
 */
- (void)participateAssetIssue2WithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToParticipateAssetIssue2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of ParticipateAssetIssue.
 */
- (GRPCProtoCall *)RPCToParticipateAssetIssue2WithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ParticipateAssetIssue2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark FreezeBalance(FreezeBalanceContract) returns (Transaction)

/**
 * Please use FreezeBalance2 instead of this function.
 */
- (void)freezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToFreezeBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use FreezeBalance2 instead of this function.
 */
- (GRPCProtoCall *)RPCToFreezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"FreezeBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark FreezeBalance2(FreezeBalanceContract) returns (TransactionExtention)

/**
 * Use this function instead of FreezeBalance.
 */
- (void)freezeBalance2WithRequest:(FreezeBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToFreezeBalance2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of FreezeBalance.
 */
- (GRPCProtoCall *)RPCToFreezeBalance2WithRequest:(FreezeBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"FreezeBalance2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeBalance(UnfreezeBalanceContract) returns (Transaction)

/**
 * Please use UnfreezeBalance2 instead of this function.
 */
- (void)unfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use UnfreezeBalance2 instead of this function.
 */
- (GRPCProtoCall *)RPCToUnfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeBalance2(UnfreezeBalanceContract) returns (TransactionExtention)

/**
 * Use this function instead of UnfreezeBalance.
 */
- (void)unfreezeBalance2WithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeBalance2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of UnfreezeBalance.
 */
- (GRPCProtoCall *)RPCToUnfreezeBalance2WithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeBalance2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeAsset(UnfreezeAssetContract) returns (Transaction)

/**
 * Please use UnfreezeAsset2 instead of this function.
 */
- (void)unfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use UnfreezeAsset2 instead of this function.
 */
- (GRPCProtoCall *)RPCToUnfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnfreezeAsset2(UnfreezeAssetContract) returns (TransactionExtention)

/**
 * Use this function instead of UnfreezeAsset.
 */
- (void)unfreezeAsset2WithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnfreezeAsset2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of UnfreezeAsset.
 */
- (GRPCProtoCall *)RPCToUnfreezeAsset2WithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnfreezeAsset2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark WithdrawBalance(WithdrawBalanceContract) returns (Transaction)

/**
 * Please use WithdrawBalance2 instead of this function.
 */
- (void)withdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToWithdrawBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use WithdrawBalance2 instead of this function.
 */
- (GRPCProtoCall *)RPCToWithdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"WithdrawBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark WithdrawBalance2(WithdrawBalanceContract) returns (TransactionExtention)

/**
 * Use this function instead of WithdrawBalance.
 */
- (void)withdrawBalance2WithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToWithdrawBalance2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of WithdrawBalance.
 */
- (GRPCProtoCall *)RPCToWithdrawBalance2WithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"WithdrawBalance2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAsset(UpdateAssetContract) returns (Transaction)

/**
 * Please use UpdateAsset2 instead of this function.
 */
- (void)updateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAssetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use UpdateAsset2 instead of this function.
 */
- (GRPCProtoCall *)RPCToUpdateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAsset"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAsset2(UpdateAssetContract) returns (TransactionExtention)

/**
 * Use this function instead of UpdateAsset.
 */
- (void)updateAsset2WithRequest:(UpdateAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateAsset2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of UpdateAsset.
 */
- (GRPCProtoCall *)RPCToUpdateAsset2WithRequest:(UpdateAssetContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateAsset2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ProposalCreate(ProposalCreateContract) returns (TransactionExtention)

- (void)proposalCreateWithRequest:(ProposalCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToProposalCreateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToProposalCreateWithRequest:(ProposalCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ProposalCreate"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ProposalApprove(ProposalApproveContract) returns (TransactionExtention)

- (void)proposalApproveWithRequest:(ProposalApproveContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToProposalApproveWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToProposalApproveWithRequest:(ProposalApproveContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ProposalApprove"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ProposalDelete(ProposalDeleteContract) returns (TransactionExtention)

- (void)proposalDeleteWithRequest:(ProposalDeleteContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToProposalDeleteWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToProposalDeleteWithRequest:(ProposalDeleteContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ProposalDelete"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark BuyStorage(BuyStorageContract) returns (TransactionExtention)

- (void)buyStorageWithRequest:(BuyStorageContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToBuyStorageWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToBuyStorageWithRequest:(BuyStorageContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"BuyStorage"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark BuyStorageBytes(BuyStorageBytesContract) returns (TransactionExtention)

- (void)buyStorageBytesWithRequest:(BuyStorageBytesContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToBuyStorageBytesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToBuyStorageBytesWithRequest:(BuyStorageBytesContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"BuyStorageBytes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SellStorage(SellStorageContract) returns (TransactionExtention)

- (void)sellStorageWithRequest:(SellStorageContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSellStorageWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSellStorageWithRequest:(SellStorageContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SellStorage"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ExchangeCreate(ExchangeCreateContract) returns (TransactionExtention)

- (void)exchangeCreateWithRequest:(ExchangeCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExchangeCreateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToExchangeCreateWithRequest:(ExchangeCreateContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExchangeCreate"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ExchangeInject(ExchangeInjectContract) returns (TransactionExtention)

- (void)exchangeInjectWithRequest:(ExchangeInjectContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExchangeInjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToExchangeInjectWithRequest:(ExchangeInjectContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExchangeInject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ExchangeWithdraw(ExchangeWithdrawContract) returns (TransactionExtention)

- (void)exchangeWithdrawWithRequest:(ExchangeWithdrawContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExchangeWithdrawWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToExchangeWithdrawWithRequest:(ExchangeWithdrawContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExchangeWithdraw"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ExchangeTransaction(ExchangeTransactionContract) returns (TransactionExtention)

- (void)exchangeTransactionWithRequest:(ExchangeTransactionContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExchangeTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToExchangeTransactionWithRequest:(ExchangeTransactionContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExchangeTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
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
#pragma mark GetAssetIssueByAccount(Account) returns (AssetIssueList)

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
#pragma mark GetAccountNet(Account) returns (AccountNetMessage)

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
#pragma mark GetAccountResource(Account) returns (AccountResourceMessage)

- (void)getAccountResourceWithRequest:(TronAccount *)request handler:(void(^)(AccountResourceMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountResourceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountResourceWithRequest:(TronAccount *)request handler:(void(^)(AccountResourceMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountResource"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountResourceMessage class]
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

/**
 * Please use GetNowBlock2 instead of this function.
 */
- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetNowBlock2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock2(EmptyMessage) returns (BlockExtention)

/**
 * Use this function instead of GetNowBlock.
 */
- (void)getNowBlock2WithRequest:(EmptyMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlock2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetNowBlock.
 */
- (GRPCProtoCall *)RPCToGetNowBlock2WithRequest:(EmptyMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum(NumberMessage) returns (Block)

/**
 * Please use GetBlockByNum2 instead of this function.
 */
- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetBlockByNum2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum2(NumberMessage) returns (BlockExtention)

/**
 * Use this function instead of GetBlockByNum.
 */
- (void)getBlockByNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNum2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetBlockByNum.
 */
- (GRPCProtoCall *)RPCToGetBlockByNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionCountByBlockNum(NumberMessage) returns (NumberMessage)

- (void)getTransactionCountByBlockNumWithRequest:(NumberMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionCountByBlockNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionCountByBlockNumWithRequest:(NumberMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionCountByBlockNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NumberMessage class]
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

/**
 * Please use GetBlockByLimitNext2 instead of this function.
 */
- (void)getBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLimitNextWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetBlockByLimitNext2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLimitNext"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByLimitNext2(BlockLimit) returns (BlockListExtention)

/**
 * Use this function instead of GetBlockByLimitNext.
 */
- (void)getBlockByLimitNext2WithRequest:(BlockLimit *)request handler:(void(^)(BlockListExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLimitNext2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetBlockByLimitNext.
 */
- (GRPCProtoCall *)RPCToGetBlockByLimitNext2WithRequest:(BlockLimit *)request handler:(void(^)(BlockListExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLimitNext2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockListExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByLatestNum(NumberMessage) returns (BlockList)

/**
 * Please use GetBlockByLatestNum2 instead of this function.
 */
- (void)getBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLatestNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetBlockByLatestNum2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLatestNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByLatestNum2(NumberMessage) returns (BlockListExtention)

/**
 * Use this function instead of GetBlockByLatestNum.
 */
- (void)getBlockByLatestNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockListExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByLatestNum2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetBlockByLatestNum.
 */
- (GRPCProtoCall *)RPCToGetBlockByLatestNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockListExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByLatestNum2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockListExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionById(BytesMessage) returns (Transaction)

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
#pragma mark DeployContract(CreateSmartContract) returns (TransactionExtention)

- (void)deployContractWithRequest:(CreateSmartContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeployContractWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToDeployContractWithRequest:(CreateSmartContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeployContract"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetContract(BytesMessage) returns (SmartContract)

- (void)getContractWithRequest:(BytesMessage *)request handler:(void(^)(SmartContract *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetContractWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetContractWithRequest:(BytesMessage *)request handler:(void(^)(SmartContract *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetContract"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SmartContract class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TriggerContract(TriggerSmartContract) returns (TransactionExtention)

- (void)triggerContractWithRequest:(TriggerSmartContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerContractWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTriggerContractWithRequest:(TriggerSmartContract *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerContract"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
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
#pragma mark ListProposals(EmptyMessage) returns (ProposalList)

- (void)listProposalsWithRequest:(EmptyMessage *)request handler:(void(^)(ProposalList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListProposalsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToListProposalsWithRequest:(EmptyMessage *)request handler:(void(^)(ProposalList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListProposals"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ProposalList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetProposalById(BytesMessage) returns (Proposal)

- (void)getProposalByIdWithRequest:(BytesMessage *)request handler:(void(^)(Proposal *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetProposalByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetProposalByIdWithRequest:(BytesMessage *)request handler:(void(^)(Proposal *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetProposalById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Proposal class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ListExchanges(EmptyMessage) returns (ExchangeList)

- (void)listExchangesWithRequest:(EmptyMessage *)request handler:(void(^)(ExchangeList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListExchangesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToListExchangesWithRequest:(EmptyMessage *)request handler:(void(^)(ExchangeList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListExchanges"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ExchangeList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetExchangeById(BytesMessage) returns (Exchange)

- (void)getExchangeByIdWithRequest:(BytesMessage *)request handler:(void(^)(Exchange *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetExchangeByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetExchangeByIdWithRequest:(BytesMessage *)request handler:(void(^)(Exchange *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetExchangeById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Exchange class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetChainParameters(EmptyMessage) returns (ChainParameters)

- (void)getChainParametersWithRequest:(EmptyMessage *)request handler:(void(^)(ChainParameters *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetChainParametersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetChainParametersWithRequest:(EmptyMessage *)request handler:(void(^)(ChainParameters *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetChainParameters"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChainParameters class]
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
#pragma mark GetPaginatedAssetIssueList(PaginatedMessage) returns (AssetIssueList)

- (void)getPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaginatedAssetIssueListWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPaginatedAssetIssueList"
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
#pragma mark GetTransactionSign(TransactionSign) returns (Transaction)

/**
 * Warning: do not invoke this interface provided by others.
 * Please use GetTransactionSign2 instead of this function.
 */
- (void)getTransactionSignWithRequest:(TransactionSign *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionSignWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 * Please use GetTransactionSign2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetTransactionSignWithRequest:(TransactionSign *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionSign"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TronTransaction class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionSign2(TransactionSign) returns (TransactionExtention)

/**
 * Warning: do not invoke this interface provided by others.
 * Use this function instead of GetTransactionSign.
 */
- (void)getTransactionSign2WithRequest:(TransactionSign *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionSign2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 * Use this function instead of GetTransactionSign.
 */
- (GRPCProtoCall *)RPCToGetTransactionSign2WithRequest:(TransactionSign *)request handler:(void(^)(TransactionExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionSign2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAddress(BytesMessage) returns (BytesMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)createAddressWithRequest:(BytesMessage *)request handler:(void(^)(BytesMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToCreateAddressWithRequest:(BytesMessage *)request handler:(void(^)(BytesMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BytesMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EasyTransfer(EasyTransferMessage) returns (EasyTransferResponse)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)easyTransferWithRequest:(EasyTransferMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEasyTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToEasyTransferWithRequest:(EasyTransferMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EasyTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EasyTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EasyTransferByPrivate(EasyTransferByPrivateMessage) returns (EasyTransferResponse)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)easyTransferByPrivateWithRequest:(EasyTransferByPrivateMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEasyTransferByPrivateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToEasyTransferByPrivateWithRequest:(EasyTransferByPrivateMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EasyTransferByPrivate"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EasyTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GenerateAddress(EmptyMessage) returns (AddressPrKeyPairMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)generateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGenerateAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToGenerateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GenerateAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddressPrKeyPairMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionInfoById(BytesMessage) returns (TransactionInfo)

- (void)getTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionInfoByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionInfoById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionInfo class]
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

#pragma mark GetAccount(Account) returns (Account)

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
#pragma mark GetAccountById(Account) returns (Account)

- (void)getAccountByIdWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountByIdWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountById"
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
#pragma mark GetPaginatedAssetIssueList(PaginatedMessage) returns (AssetIssueList)

- (void)getPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaginatedAssetIssueListWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPaginatedAssetIssueList"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AssetIssueList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock(EmptyMessage) returns (Block)

/**
 * Please use GetNowBlock2 instead of this function.
 */
- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetNowBlock2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNowBlock2(EmptyMessage) returns (BlockExtention)

/**
 * Use this function instead of GetNowBlock.
 */
- (void)getNowBlock2WithRequest:(EmptyMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNowBlock2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetNowBlock.
 */
- (GRPCProtoCall *)RPCToGetNowBlock2WithRequest:(EmptyMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNowBlock2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum(NumberMessage) returns (Block)

/**
 * Please use GetBlockByNum2 instead of this function.
 */
- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetBlockByNum2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Block class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlockByNum2(NumberMessage) returns (BlockExtention)

/**
 * Use this function instead of GetBlockByNum.
 */
- (void)getBlockByNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlockByNum2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetBlockByNum.
 */
- (GRPCProtoCall *)RPCToGetBlockByNum2WithRequest:(NumberMessage *)request handler:(void(^)(BlockExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlockByNum2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionCountByBlockNum(NumberMessage) returns (NumberMessage)

- (void)getTransactionCountByBlockNumWithRequest:(NumberMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionCountByBlockNumWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionCountByBlockNumWithRequest:(NumberMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionCountByBlockNum"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NumberMessage class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionById(BytesMessage) returns (Transaction)

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
#pragma mark GetTransactionInfoById(BytesMessage) returns (TransactionInfo)

- (void)getTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionInfoByIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionInfoById"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionInfo class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GenerateAddress(EmptyMessage) returns (AddressPrKeyPairMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)generateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGenerateAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToGenerateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GenerateAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddressPrKeyPairMessage class]
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

/**
 * Please use GetTransactionsFromThis2 instead of this function.
 */
- (void)getTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsFromThisWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetTransactionsFromThis2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsFromThis"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionsFromThis2(AccountPaginated) returns (TransactionListExtention)

/**
 * Use this function instead of GetTransactionsFromThis.
 */
- (void)getTransactionsFromThis2WithRequest:(AccountPaginated *)request handler:(void(^)(TransactionListExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsFromThis2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetTransactionsFromThis.
 */
- (GRPCProtoCall *)RPCToGetTransactionsFromThis2WithRequest:(AccountPaginated *)request handler:(void(^)(TransactionListExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsFromThis2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionListExtention class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionsToThis(AccountPaginated) returns (TransactionList)

/**
 * Please use GetTransactionsToThis2 instead of this function.
 */
- (void)getTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsToThisWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Please use GetTransactionsToThis2 instead of this function.
 */
- (GRPCProtoCall *)RPCToGetTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsToThis"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionList class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactionsToThis2(AccountPaginated) returns (TransactionListExtention)

/**
 * Use this function instead of GetTransactionsToThis.
 */
- (void)getTransactionsToThis2WithRequest:(AccountPaginated *)request handler:(void(^)(TransactionListExtention *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsToThis2WithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use this function instead of GetTransactionsToThis.
 */
- (GRPCProtoCall *)RPCToGetTransactionsToThis2WithRequest:(AccountPaginated *)request handler:(void(^)(TransactionListExtention *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactionsToThis2"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionListExtention class]
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
