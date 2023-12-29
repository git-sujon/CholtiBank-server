import httpStatus from 'http-status';
import { Secret } from 'jsonwebtoken';
import ApiError from '../errors/ApiError';
import { jwtHelpers } from './jwtHelpers';
import config from '../config';
import prisma from '../shared/prisma';
import { TaskStatusEnum } from '@prisma/client';

const verifyDecodedUser = async (token: string | undefined) => {
  const verifyToken = jwtHelpers.verifyToken(
    token as string,
    config.jwt.secret as Secret
  );

  const decodedUserInfo = await prisma.user.findUnique({
    where: {
      id: verifyToken?.userId,
    },
  });

  if (!decodedUserInfo) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
  }
  return decodedUserInfo;
};

const financialTaskVerification = async (
  token: string | undefined,
  taskId: string,
  status:TaskStatusEnum
) => {
  const verifyToken = jwtHelpers.verifyToken(
    token as string,
    config.jwt.secret as Secret
  );
  const decodedUserInfo = await prisma.user.findUnique({
    where: {
      id: verifyToken?.userId,
    },
    include: {
      receiver: true,
    },
  });

  if (!decodedUserInfo || !decodedUserInfo.receiver) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
  }

  const financialTask = await prisma.financialTask.findUnique({
    where: {
      id: taskId,
      status,
    },
  });


  if (!financialTask ) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Something is wrong');
  }

  return {
    decodedUserInfo,
    financialTask,
  };
};





export const UserHelpers = {
  verifyDecodedUser,
  financialTaskVerification,
};
