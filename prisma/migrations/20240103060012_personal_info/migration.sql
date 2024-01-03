/*
  Warnings:

  - You are about to drop the column `userId` on the `DeviceInfo` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `dateOfBirth` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `profilePicture` on the `User` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `FinancialInfo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pin` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DeviceInfo" DROP CONSTRAINT "DeviceInfo_userId_fkey";

-- DropIndex
DROP INDEX "User_email_key";

-- AlterTable
ALTER TABLE "DeviceInfo" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "FinancialInfo" ADD COLUMN     "accountOpeningDate" TIMESTAMP(3),
ADD COLUMN     "accountType" TEXT NOT NULL DEFAULT 'current',
ADD COLUMN     "creditLimit" DOUBLE PRECISION,
ADD COLUMN     "creditScore" INTEGER,
ADD COLUMN     "currency" TEXT NOT NULL DEFAULT 'BDT',
ADD COLUMN     "interestRate" DOUBLE PRECISION,
ADD COLUMN     "investmentPortfolio" TEXT,
ADD COLUMN     "lastUpdatedDate" TIMESTAMP(3),
ADD COLUMN     "overdraftLimit" DOUBLE PRECISION,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "withdrawalLimit" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "address",
DROP COLUMN "dateOfBirth",
DROP COLUMN "email",
DROP COLUMN "profilePicture",
ADD COLUMN     "pin" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "PersonalInfo" (
    "id" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3),
    "profilePicture" TEXT,
    "gender" TEXT,
    "nationality" TEXT,
    "address" TEXT,
    "phoneNumber" TEXT,
    "email" TEXT,
    "fatherName" TEXT,
    "motherName" TEXT,
    "currentAddress" TEXT,
    "permanentAddress" TEXT,
    "maritalStatus" TEXT,
    "occupation" TEXT,

    CONSTRAINT "PersonalInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "financialId" TEXT NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PersonalInfo" ADD CONSTRAINT "PersonalInfo_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_financialId_fkey" FOREIGN KEY ("financialId") REFERENCES "FinancialInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceInfo" ADD CONSTRAINT "DeviceInfo_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
