#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "Api.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

#if defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) && GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  @class TronAccount;
  @class AccountCreateContract;
  @class AccountNetMessage;
  @class AccountPaginated;
  @class AccountUpdateContract;
  @class AddressPrKeyPairMessage;
  @class AssetIssueContract;
  @class AssetIssueList;
  @class Block;
  @class BlockLimit;
  @class BlockList;
  @class BlockReference;
  @class BytesMessage;
  @class DynamicProperties;
  @class EasyTransferMessage;
  @class EasyTransferResponse;
  @class EmptyMessage;
  @class FreezeBalanceContract;
  @class NodeList;
  @class NumberMessage;
  @class PaginatedMessage;
  @class ParticipateAssetIssueContract;
  @class Return;
  @class TronTransaction;
  @class TransactionInfo;
  @class TransactionList;
  @class TransactionSign;
  @class TransferAssetContract;
  @class TransferContract;
  @class UnfreezeAssetContract;
  @class UnfreezeBalanceContract;
  @class UpdateAssetContract;
  @class VoteWitnessContract;
  @class WithdrawBalanceContract;
  @class WitnessCreateContract;
  @class WitnessList;
  @class WitnessUpdateContract;
#else
  #import "core/Tron.pbobjc.h"
  #import "core/Contract.pbobjc.h"
  #import "google/api/Annotations.pbobjc.h"
#endif

@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol TronWallet <NSObject>

#pragma mark GetAccount(TronAccount) returns (TronAccount)

- (void)getAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransaction(TransferContract) returns (TronTransaction)

- (void)createTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateTransactionWithRequest:(TransferContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark BroadcastTransaction(TronTransaction) returns (Return)

- (void)broadcastTransactionWithRequest:(TronTransaction *)request handler:(void(^)(Return *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToBroadcastTransactionWithRequest:(TronTransaction *)request handler:(void(^)(Return *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateAccount(AccountUpdateContract) returns (TronTransaction)

- (void)updateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateAccountWithRequest:(AccountUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VoteWitnessAccount(VoteWitnessContract) returns (TronTransaction)

- (void)voteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToVoteWitnessAccountWithRequest:(VoteWitnessContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAssetIssue(AssetIssueContract) returns (TronTransaction)

- (void)createAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateAssetIssueWithRequest:(AssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateWitness(WitnessUpdateContract) returns (TronTransaction)

- (void)updateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateWitnessWithRequest:(WitnessUpdateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAccount(AccountCreateContract) returns (TronTransaction)

- (void)createAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateAccountWithRequest:(AccountCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateWitness(WitnessCreateContract) returns (TronTransaction)

- (void)createWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateWitnessWithRequest:(WitnessCreateContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TransferAsset(TransferAssetContract) returns (TronTransaction)

- (void)transferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTransferAssetWithRequest:(TransferAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ParticipateAssetIssue(ParticipateAssetIssueContract) returns (TronTransaction)

- (void)participateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToParticipateAssetIssueWithRequest:(ParticipateAssetIssueContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark FreezeBalance(FreezeBalanceContract) returns (TronTransaction)

- (void)freezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToFreezeBalanceWithRequest:(FreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnfreezeBalance(UnfreezeBalanceContract) returns (TronTransaction)

- (void)unfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUnfreezeBalanceWithRequest:(UnfreezeBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnfreezeAsset(UnfreezeAssetContract) returns (TronTransaction)

- (void)unfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUnfreezeAssetWithRequest:(UnfreezeAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark WithdrawBalance(WithdrawBalanceContract) returns (TronTransaction)

- (void)withdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToWithdrawBalanceWithRequest:(WithdrawBalanceContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateAsset(UpdateAssetContract) returns (TronTransaction)

- (void)updateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateAssetWithRequest:(UpdateAssetContract *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListNodes(EmptyMessage) returns (NodeList)

- (void)listNodesWithRequest:(EmptyMessage *)request handler:(void(^)(NodeList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToListNodesWithRequest:(EmptyMessage *)request handler:(void(^)(NodeList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAssetIssueByAccount(TronAccount) returns (AssetIssueList)

- (void)getAssetIssueByAccountWithRequest:(TronAccount *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAssetIssueByAccountWithRequest:(TronAccount *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccountNet(TronAccount) returns (AccountNetMessage)

- (void)getAccountNetWithRequest:(TronAccount *)request handler:(void(^)(AccountNetMessage *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountNetWithRequest:(TronAccount *)request handler:(void(^)(AccountNetMessage *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAssetIssueByName(BytesMessage) returns (AssetIssueContract)

- (void)getAssetIssueByNameWithRequest:(BytesMessage *)request handler:(void(^)(AssetIssueContract *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAssetIssueByNameWithRequest:(BytesMessage *)request handler:(void(^)(AssetIssueContract *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockById(BytesMessage) returns (Block)

- (void)getBlockByIdWithRequest:(BytesMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByIdWithRequest:(BytesMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockByLimitNext(BlockLimit) returns (BlockList)

- (void)getBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByLimitNextWithRequest:(BlockLimit *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockByLatestNum(NumberMessage) returns (BlockList)

- (void)getBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByLatestNumWithRequest:(NumberMessage *)request handler:(void(^)(BlockList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactionById(BytesMessage) returns (TronTransaction)

- (void)getTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListWitnesses(EmptyMessage) returns (WitnessList)

- (void)listWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToListWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAssetIssueList(EmptyMessage) returns (AssetIssueList)

- (void)getAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetPaginatedAssetIssueList(PaginatedMessage) returns (AssetIssueList)

- (void)getPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TotalTransaction(EmptyMessage) returns (NumberMessage)

- (void)totalTransactionWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTotalTransactionWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNextMaintenanceTime(EmptyMessage) returns (NumberMessage)

- (void)getNextMaintenanceTimeWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNextMaintenanceTimeWithRequest:(EmptyMessage *)request handler:(void(^)(NumberMessage *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactionSign(TransactionSign) returns (TronTransaction)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)getTransactionSignWithRequest:(TransactionSign *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToGetTransactionSignWithRequest:(TransactionSign *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAdresss(BytesMessage) returns (BytesMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)createAdresssWithRequest:(BytesMessage *)request handler:(void(^)(BytesMessage *_Nullable response, NSError *_Nullable error))handler;

/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToCreateAdresssWithRequest:(BytesMessage *)request handler:(void(^)(BytesMessage *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EasyTransfer(EasyTransferMessage) returns (EasyTransferResponse)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)easyTransferWithRequest:(EasyTransferMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToEasyTransferWithRequest:(EasyTransferMessage *)request handler:(void(^)(EasyTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GenerateAddress(EmptyMessage) returns (AddressPrKeyPairMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)generateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler;

/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToGenerateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler;


@end

@protocol WalletSolidity <NSObject>

#pragma mark GetAccount(TronAccount) returns (TronAccount)

- (void)getAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(TronAccount *)request handler:(void(^)(TronAccount *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListWitnesses(EmptyMessage) returns (WitnessList)

- (void)listWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToListWitnessesWithRequest:(EmptyMessage *)request handler:(void(^)(WitnessList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAssetIssueList(EmptyMessage) returns (AssetIssueList)

- (void)getAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAssetIssueListWithRequest:(EmptyMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetPaginatedAssetIssueList(PaginatedMessage) returns (AssetIssueList)

- (void)getPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetPaginatedAssetIssueListWithRequest:(PaginatedMessage *)request handler:(void(^)(AssetIssueList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactionById(BytesMessage) returns (TronTransaction)

- (void)getTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionByIdWithRequest:(BytesMessage *)request handler:(void(^)(TronTransaction *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactionInfoById(BytesMessage) returns (TransactionInfo)

- (void)getTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionInfoByIdWithRequest:(BytesMessage *)request handler:(void(^)(TransactionInfo *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GenerateAddress(EmptyMessage) returns (AddressPrKeyPairMessage)

/**
 * Warning: do not invoke this interface provided by others.
 */
- (void)generateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler;

/**
 * Warning: do not invoke this interface provided by others.
 */
- (GRPCProtoCall *)RPCToGenerateAddressWithRequest:(EmptyMessage *)request handler:(void(^)(AddressPrKeyPairMessage *_Nullable response, NSError *_Nullable error))handler;


@end

@protocol WalletExtension <NSObject>

#pragma mark GetTransactionsFromThis(AccountPaginated) returns (TransactionList)

- (void)getTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionsFromThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactionsToThis(AccountPaginated) returns (TransactionList)

- (void)getTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionsToThisWithRequest:(AccountPaginated *)request handler:(void(^)(TransactionList *_Nullable response, NSError *_Nullable error))handler;


@end

@protocol Database <NSObject>

#pragma mark getBlockReference(EmptyMessage) returns (BlockReference)

/**
 * for tapos
 */
- (void)getBlockReferenceWithRequest:(EmptyMessage *)request handler:(void(^)(BlockReference *_Nullable response, NSError *_Nullable error))handler;

/**
 * for tapos
 */
- (GRPCProtoCall *)RPCTogetBlockReferenceWithRequest:(EmptyMessage *)request handler:(void(^)(BlockReference *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetDynamicProperties(EmptyMessage) returns (DynamicProperties)

- (void)getDynamicPropertiesWithRequest:(EmptyMessage *)request handler:(void(^)(DynamicProperties *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetDynamicPropertiesWithRequest:(EmptyMessage *)request handler:(void(^)(DynamicProperties *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNowBlock(EmptyMessage) returns (Block)

- (void)getNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNowBlockWithRequest:(EmptyMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlockByNum(NumberMessage) returns (Block)

- (void)getBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlockByNumWithRequest:(NumberMessage *)request handler:(void(^)(Block *_Nullable response, NSError *_Nullable error))handler;


@end

@protocol Network <NSObject>

@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface TWallet : GRPCProtoService<TronWallet>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface WalletSolidity : GRPCProtoService<WalletSolidity>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface WalletExtension : GRPCProtoService<WalletExtension>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Database : GRPCProtoService<Database>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Network : GRPCProtoService<Network>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

