import express from 'express';
import { UserRoutes } from '../modules/user/user.routes';
import { AuthRoutes } from '../modules/auth/auth.routes';
import { TransactionRoutes } from '../modules/transanction/transaction.routes';

const router = express.Router();

const moduleRoutes = [
  // ... routes
  {
    path: '/auth',
    route: AuthRoutes,
  },
  {
    path: '/users',
    route: UserRoutes,
  },
  {
    path: '/transactions',
    route: TransactionRoutes,
  },
];

moduleRoutes.forEach(route => router.use(route.path, route.route));
export default router;
