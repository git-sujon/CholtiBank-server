import httpStatus from 'http-status';
import ApiError from '../../../errors/ApiError';
import prisma from '../../../shared/prisma';
import bcrypt from 'bcrypt';
import config from '../../../config';
import {
  checkEmailExist,
  checkNationalIdExist,
  checkPhoneNumberExist,
  createDevicesInfo,
} from './user.utils';
import { User } from '@prisma/client';
import excludeFields from '../../../helpers/excludingfields';

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
    const keysToExclude: (keyof User)[] = ['password'];

    return excludeFields(user, keysToExclude);
  });
};

export const UserServices = {
  userSignUp,
};
