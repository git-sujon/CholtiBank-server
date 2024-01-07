/* eslint-disable @typescript-eslint/ban-ts-comment */
import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import { jwtHelpers } from '../../../helpers/jwtHelpers';
import { Secret } from 'jsonwebtoken';
import config from '../../../config';
import prisma from '../../../shared/prisma';
import { TransactionTypeEnum } from '@prisma/client';
import {
  GenerateTransactionIDEnum,
  generateTransactionId,
} from '../../../helpers/generateTransactionId';
import { IAddDeposit, IWithdrawalMoney } from './transaction.interface';

const depositMoney = async (
  token: string | undefined,
  payload: IAddDeposit,
) => {
  if (!token) {
    throw new ApiError(httpStatus.UNAUTHORIZED, 'Unauthorized access');
  }
  const verifyToken = jwtHelpers.verifyToken(
    token as string,
    config.jwt.secret as Secret,
  );

  const decodedUserInfo = await prisma.user.findUnique({
    where: {
      id: verifyToken?.userId,
    },
    include: {
      userFinancialInfo: true,
    },
  });

  if (!decodedUserInfo) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
  }

  if (payload?.amount < 0) {
    throw new ApiError(httpStatus.NOT_ACCEPTABLE, "Amount can't be Negative");
  }

  let transactionInfo = null;

  await prisma.$transaction(async tx => {
    if (decodedUserInfo && decodedUserInfo.userFinancialInfo) {
      await tx.userFinancialInfo.update({
        where: {
          id: decodedUserInfo.userFinancialInfo.id,
        },
        data: {
          accountBalance:
            decodedUserInfo.userFinancialInfo?.accountBalance + payload.amount,
        },
      });

      const deposit = await tx.deposit.create({
        data: {
          transactionId: generateTransactionId(
            GenerateTransactionIDEnum.Deposit,
          ),
          ...payload,
        },
      });

      transactionInfo = await prisma.transaction.create({
        data: {
          userId: decodedUserInfo.id,
          transactionId: deposit.transactionId,
          transactionType: TransactionTypeEnum.Deposit,
          reference: payload?.reference,
        },
        include: {
          deposit: true,
        },
      });
    }
  });
  return transactionInfo;
};

const withdrawMoney = async (
  token: string | undefined,
  payload: IWithdrawalMoney,
) => {
  if (!token) {
    throw new ApiError(httpStatus.UNAUTHORIZED, 'Unauthorized access');
  }
  const verifyToken = jwtHelpers.verifyToken(
    token as string,
    config.jwt.secret as Secret,
  );

  const decodedUserInfo = await prisma.user.findUnique({
    where: {
      id: verifyToken?.userId,
    },
    include: {
      userFinancialInfo: true,
    },
  });

  if (!decodedUserInfo) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
  }

  if (payload?.amount < 0) {
    throw new ApiError(httpStatus.NOT_ACCEPTABLE, "Amount can't be Negative");
  }

  await prisma.$transaction(async tx => {
    if (
      decodedUserInfo &&
      decodedUserInfo.userFinancialInfo &&
      decodedUserInfo.userFinancialInfo.id
    ) {
      await tx.userFinancialInfo.update({
        where: {
          id: decodedUserInfo.userFinancialInfo?.id,
        },
        data: {
          accountBalance:
            decodedUserInfo.userFinancialInfo?.accountBalance - payload.amount,
        },
      });

      const withdraw = await tx.withdrawal.create({
        data: {
          transactionId: generateTransactionId(
            GenerateTransactionIDEnum.Withdrawal,
          ),
          ...payload,
        },
      });

      await prisma.transaction.create({
        data: {
          userId: decodedUserInfo.id,
          transactionId: withdraw.transactionId,
          transactionType: TransactionTypeEnum.Withdrawal,
          reference: payload.reference,
        },
      });
    }
  });
};

export const TransactionServices = {
  depositMoney,
  withdrawMoney,
};
