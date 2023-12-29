import express from 'express';


const router = express.Router();

const moduleRoutes = [
  // ... routes
  {
    path: '/auth',
    route: AuthRoute,
  },
  
];

moduleRoutes.forEach(route => router.use(route.path, route.route));
export default router;
