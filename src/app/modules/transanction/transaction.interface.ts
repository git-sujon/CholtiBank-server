import { DepositSourceEnum, TransactionTypeEnum, WithdrawSourceEnum } from "@prisma/client";

export type ITransaction = {
    id: string;
    amount: number;
    transactionId: string;
    transactionType: TransactionTypeEnum;
    depositSource?: DepositSourceEnum;
    withdrawSource?: WithdrawSourceEnum;
    bankName?: string;
    bankAccountNo?: string;
    creditCardName?: string;
    creditCardNumber?: string;
    atmId?: string;
    agentId?: string;
    receiverId?: string;
    reference?: string;
    createdAt: Date;
  };
  