import express from 'express';
import { UserRoute } from '../modules/user/user.routes';


const router = express.Router();

const moduleRoutes = [
  // ... routes
  {
    path: '/users',
    route: UserRoute,
  },
  
];

moduleRoutes.forEach(route => router.use(route.path, route.route));
export default router;
