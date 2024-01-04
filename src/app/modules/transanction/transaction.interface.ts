import {
  DepositSourceEnum,
  TransactionTypeEnum,
  WithdrawSourceEnum,
} from '@prisma/client';

// Deposit Type
export type IDeposit = {
  transactionId: string;
  amount: number;
  depositSource: DepositSourceEnum;
  bankName?: string | null;
  bankAccountNo?: string | null;
  creditCardName?: string | null;
  creditCardNumber?: string | null;
  atmId?: string | null;
  agentId?: string | null;
  userFinancialInfoId: string;
};

// Withdrawal Type
export type IWithdrawal = {
  transactionId: string;
  amount: number;
  withdrawSource: WithdrawSourceEnum;
  atmId?: string | null;
  agentId?: string | null;
  userFinancialInfoId: string;
};

// Transaction Type
export type ITransaction = {
  transactionId: string;
  transactionType: TransactionTypeEnum;
  reference?: string | null;
  userFinancialInfoId: string;
};
