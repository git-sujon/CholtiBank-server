/*
  Warnings:

  - You are about to drop the column `description` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `financialId` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the `FinancialInfo` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `transectionId` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "DepositSourceEnum" AS ENUM ('bank_transfer', 'credit_card', 'atm', 'agent');

-- CreateEnum
CREATE TYPE "WithdrawSourceEnum" AS ENUM ('agent', 'atm');

-- CreateEnum
CREATE TYPE "TransactionTypeEnum" AS ENUM ('Deposit', 'Withdrawal', 'Transfer');

-- DropForeignKey
ALTER TABLE "FinancialInfo" DROP CONSTRAINT "FinancialInfo_id_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_financialId_fkey";

-- AlterTable
ALTER TABLE "Transaction" DROP COLUMN "description",
DROP COLUMN "financialId",
ADD COLUMN     "agentId" TEXT,
ADD COLUMN     "atmId" TEXT,
ADD COLUMN     "bankAccountNo" TEXT,
ADD COLUMN     "bankName" TEXT,
ADD COLUMN     "creditCardName" TEXT,
ADD COLUMN     "creditCardNumber" TEXT,
ADD COLUMN     "dipositSource" "DepositSourceEnum",
ADD COLUMN     "receiverId" TEXT,
ADD COLUMN     "reference" TEXT,
ADD COLUMN     "transectionId" TEXT NOT NULL,
ADD COLUMN     "type" "TransactionTypeEnum" NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL,
ADD COLUMN     "withdrawSource" "WithdrawSourceEnum";

-- DropTable
DROP TABLE "FinancialInfo";

-- CreateTable
CREATE TABLE "UserFinancialInfo" (
    "id" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "accountBalance" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "accountType" TEXT NOT NULL DEFAULT 'current',
    "currency" TEXT NOT NULL DEFAULT 'BDT',
    "interestRate" DOUBLE PRECISION,
    "creditLimit" DOUBLE PRECISION,
    "overdraftLimit" DOUBLE PRECISION,
    "withdrawalLimit" DOUBLE PRECISION,
    "investmentPortfolio" TEXT,
    "creditScore" INTEGER,
    "accountOpeningDate" TIMESTAMP(3),
    "lastUpdatedDate" TIMESTAMP(3),
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserFinancialInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserFinancialInfo_accountNumber_key" ON "UserFinancialInfo"("accountNumber");

-- AddForeignKey
ALTER TABLE "UserFinancialInfo" ADD CONSTRAINT "UserFinancialInfo_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
