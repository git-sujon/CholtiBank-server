import express from 'express';
import { UserRoute } from '../modules/user/user.routes';
import { AuthRoute } from '../modules/auth/auth.routes';

const router = express.Router();

const moduleRoutes = [
  // ... routes
  {
    path: '/auth',
    route: AuthRoute,
  },
  {
    path: '/users',
    route: UserRoute,
  },
];

moduleRoutes.forEach(route => router.use(route.path, route.route));
export default router;
