import express from 'express';
import { AdminController } from './admin.controller';
import auth from '../../middlewares/auth';
import { ENUM_USER_ROLE } from '../../../enums/user';

const route = express.Router();

route.post(
  '/create-loan-officer',
  auth(ENUM_USER_ROLE.USER),
  AdminController.createLoanOfficer,
);

export const AdminRoutes = route;
