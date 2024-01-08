import { Request, Response } from 'express';
import catchAsync from '../../../shared/catchAsync';

import httpStatus from 'http-status';
import sendResponse from '../../../shared/sendResponse';
import { TransactionServices } from './transaction.services';

const depositMoney = catchAsync(async (req: Request, res: Response) => {
  const authToken = req.headers.authorization;
  const payload = req.body;
  const result = await TransactionServices.depositMoney(authToken, payload);

  sendResponse(res, {
    statusCode: httpStatus.OK,
    success: true,
    message: 'Money received successfully',
    data: result,
  });
});

const withdrawMoney = catchAsync(async (req: Request, res: Response) => {
  const authToken = req.headers.authorization;
  const payload = req.body;
  const result = await TransactionServices.withdrawMoney(authToken, payload);

  sendResponse(res, {
    statusCode: httpStatus.OK,
    success: true,
    message: 'Withdraw Money successfully',
    data: result,
  });
});

const transferMoney = catchAsync(async (req: Request, res: Response) => {
  const authToken = req.headers.authorization;
  const payload = req.body;
  const result = await TransactionServices.transferMoney(authToken, payload);

  sendResponse(res, {
    statusCode: httpStatus.OK,
    success: true,
    message: 'Transfer money successfully',
    data: result,
  });
});

export const TransactionController = {
  depositMoney,
  withdrawMoney,
  transferMoney
};
