import { AccountStatus, UserRole } from "@prisma/client";

export type User = {
    id: string;
    firstName: string;
    lastName: string;
    nationalId: string;
    email: string;
    phoneNumber: string;
    password: string;
    role: UserRole;
    dateOfBirth: Date;
    profilePicture?: string | null;
    address?: string | null;
    accountStatus: AccountStatus;
    lastLogin?: Date | null;
    passwordChangedAt?: Date | null;
    pinChangeAt?: Date | null;
  };