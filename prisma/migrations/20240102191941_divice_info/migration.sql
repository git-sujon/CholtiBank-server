/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `accountBalance` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `accountNumber` on the `User` table. All the data in the column will be lost.
  - The `accountStatus` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[nationalId]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('user', 'admin', 'loan_officer', 'customer_service_representative');

-- CreateEnum
CREATE TYPE "AccountStatus" AS ENUM ('active', 'inActive');

-- DropIndex
DROP INDEX "User_accountNumber_key";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "accountBalance",
DROP COLUMN "accountNumber",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "passwordChangedAt" TIMESTAMP(3),
ADD COLUMN     "pinChangeAt" TIMESTAMP(3),
ADD COLUMN     "role" "UserRole" NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "nationalId" SET DATA TYPE TEXT,
DROP COLUMN "accountStatus",
ADD COLUMN     "accountStatus" "AccountStatus" NOT NULL DEFAULT 'active',
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropEnum
DROP TYPE "AccountStatusEnum";

-- CreateTable
CREATE TABLE "FinancialInfo" (
    "id" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "accountBalance" DOUBLE PRECISION NOT NULL DEFAULT 0.0,

    CONSTRAINT "FinancialInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DeviceInfo" (
    "id" TEXT NOT NULL,
    "devicesId" TEXT,
    "devicesModel" TEXT,
    "devicesType" TEXT,
    "devicesVendor" TEXT,
    "browserName" TEXT,
    "browserVersion" TEXT,
    "engineName" TEXT,
    "engineVersion" TEXT,
    "osName" TEXT,
    "osVersion" TEXT,
    "cpuArchitecture" TEXT,
    "agentClient" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "DeviceInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FinancialInfo_accountNumber_key" ON "FinancialInfo"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "User_nationalId_key" ON "User"("nationalId");

-- AddForeignKey
ALTER TABLE "FinancialInfo" ADD CONSTRAINT "FinancialInfo_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceInfo" ADD CONSTRAINT "DeviceInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
