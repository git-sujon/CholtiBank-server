/* eslint-disable @typescript-eslint/ban-ts-comment */
import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import { jwtHelpers } from '../../../helpers/jwtHelpers';
import { Secret } from 'jsonwebtoken';
import config from '../../../config';
import prisma from '../../../shared/prisma';
import { generateEmployeeId } from '../../../helpers/generateEmployeeId';
import { ICreateLoanOfficer } from './admin.interface';

const createLoanOfficer = async (
  token: string | undefined,
  payload: ICreateLoanOfficer,
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
  });

  if (!decodedUserInfo) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
  }

  const employeeId = generateEmployeeId('EMP_LO');

  await prisma.$transaction(async tx => {
    const userInfo = await tx.user.create({
      data: {
        role: 'loan_officer',
        firstName: payload.firstName,
        lastName: payload.lastName,
        nationalId: payload.nationalId,
        phoneNumber: payload.phoneNumber,
        password: payload.password,
        pin: payload.pin,
      },
    });
    await tx.personalInfo.create({
      data:{
        userId: userInfo.id,
        gender:payload.gender,
        dateOfBirth:payload.dateOfBirth,
        maritalStatus:payload.maritalStatus,
        currentAddress:payload.currentAddress,
        permanentAddress:payload.permanentAddress,
        nationality:payload.nationality,
        email:payload.email,
      }
    })

    await tx.loanOfficer.create({
      data: {
        userId: userInfo.id,
        department: payload.department,
        hireDate: payload.hireDate,
        employeeId: employeeId,
      },
    });
  });
};

const getAllUsers = (token: string | undefined) => {

}


export const AdminServices = {
  createLoanOfficer,
  getAllUsers
};
