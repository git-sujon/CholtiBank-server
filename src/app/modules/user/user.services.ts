import { Secret } from "jsonwebtoken";
import config from "../../../config";
import { jwtHelpers } from "../../../helpers/jwtHelpers";
import httpStatus from "http-status";
import ApiError from "../../../errors/ApiError";
import prisma from "../../../shared/prisma";
import { User } from "@prisma/client";
import excludeFields from "../../../helpers/excludingfields";

const getMyProfile = async (token: string | undefined) => {
    if (!token) {
      throw new ApiError(httpStatus.UNAUTHORIZED, 'Unauthorized access');
    }
    const verifyToken = jwtHelpers.verifyToken(
      token as string,
      config.jwt.secret as Secret
    );
  
    const includeRelations: Record<string, true> = {};
    includeRelations['devices'] = true;
    includeRelations['personalInfo'] = true;
    includeRelations['customerAccounts'] = true;
  
    const decodedUserInfo = await prisma.user.findUnique({
      where: {
        id: verifyToken?.userId,
      },
      include: includeRelations,
    });
  
    if (!decodedUserInfo) {
      throw new ApiError(httpStatus.NOT_FOUND, 'User Not Exist');
    }
  
    const keysToExclude: (keyof User)[] = ['password', 'pin'];
    const updatedResult = excludeFields(decodedUserInfo, keysToExclude);
  
    return updatedResult;
  };
  
  const updateMyProfile = async (
    token: string | undefined,
    payload: Partial<User>
  ): Promise<Partial<User | undefined>> => {
  
    if (!token) {
      throw new ApiError(httpStatus.UNAUTHORIZED, 'Unauthorized access');
    }
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
      throw new ApiError(httpStatus.NOT_FOUND, 'User Not Exist');
    }
  
    const result = await prisma.user.update({
      where: {
        id: decodedUserInfo.id,
      },
      data: payload,
    });
  
    const keysToExclude: (keyof User)[] = ['password', 'pin'];
    const updatedResult = excludeFields(result, keysToExclude);
    return updatedResult;
  };


  const addMoneyToMoneyAccount = async (token: string | undefined, amount: number) => {
    if (!token) {
      throw new ApiError(httpStatus.UNAUTHORIZED, 'Unauthorized access');
    }
    const verifyToken = jwtHelpers.verifyToken(
      token as string,
      config.jwt.secret as Secret
    );
  
    const decodedUserInfo = await prisma.user.findUnique({
      where: {
        id: verifyToken?.userId,
      },
      include:{
        customerAccounts:true
      }
    });
  
    if (!decodedUserInfo) {
      throw new ApiError(httpStatus.NOT_FOUND, 'Unauthorized');
    }
   
  
    if (amount < 0) {
      throw new ApiError(httpStatus.NOT_ACCEPTABLE, "Amount can't be Negative");
    }
  
    await prisma.$transaction(async tx => {
      await tx.financialInfo.update({
        where: {
          id: decodedUserInfo.customerAccounts?.accountBalance,
        },
        data: {
          virtualMoneyBalance:
            (decodedUserInfo.controller?.virtualMoneyBalance ?? 0) + amount,
          totalDeposit: (decodedUserInfo.controller?.totalDeposit ?? 0) + amount,
        },
      });
  
      if (controllerId) {
        await tx.virtualMoney.create({
          data: {
            amount: amount,
            moneyTransferDirection: MoneyTransferDirection.controller_deposit,
            controllerId: controllerId,
          },
        });
      }
    });
  };

export const UserServices = {
    getMyProfile,
    updateMyProfile,
    addMoneyToMoneyAccount
};
