import { UserRole } from '@prisma/client';

export type IUser = {
  id: string;
  firstName: string;
  lastName: string;
  nationalId: string;
  phoneNumber: string;
  password: string;
  pin: string;
  role: UserRole;
};
