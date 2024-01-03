import express from 'express';
import auth from '../../middlewares/auth';
import { ENUM_USER_ROLE } from '../../../enums/user';
import { TransactionController } from './transaction.controller';

const route = express.Router();

route.post(
  '/deposit-money',
  auth(ENUM_USER_ROLE.USER),
  TransactionController.depositMoney,
);

export const TransactionRoutes = route;
