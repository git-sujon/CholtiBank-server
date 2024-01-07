import express from 'express';
import { AdminController } from './admin.controller';
import auth from '../../middlewares/auth';
import { ENUM_USER_ROLE } from '../../../enums/user';

const route = express.Router();

route.post(
  '/create-employees',
  auth(ENUM_USER_ROLE.USER),
  AdminController.createEmployees,
);

route.get('/get-all-users', auth(ENUM_USER_ROLE.USER), AdminController.getAllUsers)

export const AdminRoutes = route;
