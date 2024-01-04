/* eslint-disable @typescript-eslint/ban-ts-comment */
import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import { jwtHelpers } from '../../../helpers/jwtHelpers';
import { Secret } from 'jsonwebtoken';
import config from '../../../config';
import prisma from '../../../shared/prisma';
import { IDeposit } from './transaction.interface';
import { TransactionTypeEnum } from '@prisma/client';
import {
  GenerateTransactionIDEnum,
  generateTransactionId,
} from '../../../helpers/generateTransactionId';

const depositMoney = async (token: string | undefined, payload: IDeposit) => {
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
  generateTransactionId(GenerateTransactionIDEnum.Deposit);
  // await prisma.$transaction(async tx => {
  //   if (decodedUserInfo && decodedUserInfo.userFinancialInfo) {
  //     await tx.userFinancialInfo.update({
  //       where: {
  //         accountNumber: decodedUserInfo.userFinancialInfo?.accountNumber,
  //       },
  //       data: {
  //         accountBalance:
  //           decodedUserInfo.userFinancialInfo?.accountBalance + payload.amount,
  //       },
  //     });

  //     const createDeposit = await tx.deposit.create({
  //       data: payload,
  //     });

  //     await prisma.transaction.create({
  //       data: {
  //         transactionId: createDeposit.transactionId,
  //         transactionType: TransactionTypeEnum.Deposit,
  //         ...payload,
  //       },
  //     });
  //   }
  // });
};

export const TransactionServices = {
  depositMoney,
};
