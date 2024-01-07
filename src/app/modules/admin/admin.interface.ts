import { IUser } from "../user/user.interface";

export type ICreateLoanOfficer = IUser & {
    employeeId: string;
    department: string;
    hireDate: Date;
    gender: string;
    dateOfBirth: Date;
    maritalStatus: string;
    address: string;
    currentAddress: string;
    permanentAddress: string;
    nationality: string;
    email: string;
    fatherName: string;
    motherName: string;
  
  };