import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import prisma from '../../../shared/prisma';
import bcrypt from 'bcrypt';
import config from '../../../config';
import { checkEmailExist, checkNationalIdExist, checkPhoneNumberExist, createDevicesInfo } from './auth.utils';
import { jwtHelpers } from '../../../helpers/jwtHelpers';
import { IUserLogin } from './auth.interface';


const userSignUp = async (payload: any) => {
  checkEmailExist(payload.email);
  checkPhoneNumberExist(payload.phoneNumber);
  checkNationalIdExist(payload.nationalId);

  return prisma.$transaction(async tx => {
    // Hash the password and pin asynchronously
    const hashPassword = await bcrypt.hash(
      payload.password,
      Number(config.bycrypt_salt_rounds),
    );

    payload.password = hashPassword;

    const user = await tx.user.create({
      data: {
        ...payload,
      },
    });

    await createDevicesInfo(tx, user.id);

    const userId = user.id;
    const role = user.role;

    const accessToken = jwtHelpers.createToken(
      { userId, role },
      config.jwt.secret as string,
      config.jwt.expires_in as string,
    );

    return accessToken;
  });
};

const loginUser = async (payload: IUserLogin) => {
  const isUserExist = await prisma.user.findUnique({
    where: {
      phoneNumber: payload.phoneNumber,
    },
  });

  if (!isUserExist) {
    throw new ApiError(httpStatus.NOT_FOUND, 'User or Password Not Matching');
  }

  const isPasswordMatch = await bcrypt.compare(
    payload.password,
    isUserExist.password,
  );

  if (!isPasswordMatch) {
    throw new ApiError(
      httpStatus.UNAUTHORIZED,
      'User or Password Not Matching',
    );
  }

  const userId = isUserExist.id;
  const role = isUserExist.role;

  const accessToken = jwtHelpers.createToken(
    { userId, role },
    config.jwt.secret as string,
    config.jwt.expires_in as string,
  );

  return accessToken;
};

export const AuthServices = {
  userSignUp,
  loginUser,
};
