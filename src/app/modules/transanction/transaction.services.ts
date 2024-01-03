/* eslint-disable @typescript-eslint/ban-ts-comment */
import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import { jwtHelpers } from '../../../helpers/jwtHelpers';
import { Secret } from 'jsonwebtoken';
import config from '../../../config';
import prisma from '../../../shared/prisma';
import { ITransaction } from './transaction.interface';
import { TransactionTypeEnum } from '@prisma/client';

const depositMoney = async (
  token: string | undefined,
  payload: ITransaction,
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
    if (decodedUserInfo && decodedUserInfo.userFinancialInfo) {
      await tx.userFinancialInfo.update({
        where: {
          id: decodedUserInfo.userFinancialInfo?.id,
        },
        data: {
          accountBalance:
            decodedUserInfo.userFinancialInfo?.accountBalance + payload.amount,
        },
      });

      await prisma.transaction.create({
        data: {
          //@ts-expect-error
          userId: decodedUserInfo.id,
          //@ts-expect-error
          transactionType: TransactionTypeEnum.Deposit,
          ...payload,
        },
      });
    }
  });
};

export const TransactionServices = {
  depositMoney,
};
