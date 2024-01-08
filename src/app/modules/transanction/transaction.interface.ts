import {
  DepositSourceEnum,
  TransactionTypeEnum,
  TransferSourceEnum,
  WithdrawSourceEnum,
} from '@prisma/client';

// Deposit Type
export type IAddDeposit = {
  amount: number;
  depositSource: DepositSourceEnum;
  bankName?: string | null;
  bankAccountNo?: string | null;
  creditCardName?: string | null;
  creditCardNumber?: string | null;
  atmId?: string | null;
  agentId?: string | null;
  reference?: string;
};

// Withdrawal Type
export type IWithdrawalMoney = {
  amount: number;
  withdrawSource: WithdrawSourceEnum;
  atmId?: string | null;
  agentId?: string | null;
  reference?: string;
};

// Transaction Type
export type ITransaction = {
  transactionType: TransactionTypeEnum;
  reference?: string | null;
};

export type ITransferMoney = {
  amount: number;
  transferSource: TransferSourceEnum;
  bankName?: string;
  bankAccountNo?: string;
  receiverName?: string;
  receiverId?: string;
  reference?: string;
  receiverNID?: string;
  bankBranch?: string;
  cashByCodePIN?: string;
  creditCardName?: string;
  creditCardNumber?: string;
  atmId?: string;
  agentId?: string;
};
