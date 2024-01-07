import { Request, Response } from 'express';
import catchAsync from '../../../shared/catchAsync';

import httpStatus from 'http-status';
import sendResponse from '../../../shared/sendResponse';
import { AdminServices } from './admin.services';


const createLoanOfficer = catchAsync(async (req: Request, res: Response) => {
  const authToken = req.headers.authorization;
  const payload = req.body;
  const result = await AdminServices.createLoanOfficer(authToken, payload);

  sendResponse(res, {
    statusCode: httpStatus.OK,
    success: true,
    message: 'Loan Officer created successfully',
    data: result,
  });
});


export const AdminController = {
  createLoanOfficer
};
