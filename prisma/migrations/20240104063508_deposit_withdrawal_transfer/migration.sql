/*
  Warnings:

  - The primary key for the `Transaction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `agentId` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `amount` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `atmId` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `bankAccountNo` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `bankName` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `creditCardName` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `creditCardNumber` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `dipositSource` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `receiverId` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Transaction` table. All the data in the column will be lost.
  - You are about to drop the column `withdrawSource` on the `Transaction` table. All the data in the column will be lost.
  - The primary key for the `UserFinancialInfo` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `UserFinancialInfo` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[transactionId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userFinancialInfoId` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TransferSourceEnum" AS ENUM ('Cholti_to_Cholti', 'Cash_by_code', 'BKash', 'Nagad', 'Prepaid_Card', 'Binimoy');

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserFinancialInfo" DROP CONSTRAINT "UserFinancialInfo_id_fkey";

-- AlterTable
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_pkey",
DROP COLUMN "agentId",
DROP COLUMN "amount",
DROP COLUMN "atmId",
DROP COLUMN "bankAccountNo",
DROP COLUMN "bankName",
DROP COLUMN "creditCardName",
DROP COLUMN "creditCardNumber",
DROP COLUMN "dipositSource",
DROP COLUMN "id",
DROP COLUMN "receiverId",
DROP COLUMN "userId",
DROP COLUMN "withdrawSource",
ADD COLUMN     "userFinancialInfoId" TEXT NOT NULL,
ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY ("transactionId");

-- AlterTable
ALTER TABLE "UserFinancialInfo" DROP CONSTRAINT "UserFinancialInfo_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "UserFinancialInfo_pkey" PRIMARY KEY ("accountNumber");

-- CreateTable
CREATE TABLE "Deposit" (
    "transactionId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "depositSource" "DepositSourceEnum" NOT NULL,
    "bankName" TEXT,
    "bankAccountNo" TEXT,
    "creditCardName" TEXT,
    "creditCardNumber" TEXT,
    "atmId" TEXT,
    "agentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userFinancialInfoId" TEXT NOT NULL,

    CONSTRAINT "Deposit_pkey" PRIMARY KEY ("transactionId")
);

-- CreateTable
CREATE TABLE "Withdrawal" (
    "transactionId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "withdrawSource" "WithdrawSourceEnum" NOT NULL,
    "atmId" TEXT,
    "agentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userFinancialInfoId" TEXT NOT NULL,

    CONSTRAINT "Withdrawal_pkey" PRIMARY KEY ("transactionId")
);

-- CreateTable
CREATE TABLE "Transfer" (
    "transactionId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "userFinancialInfoId" TEXT NOT NULL,
    "bankName" TEXT,
    "bankAccountNo" TEXT,
    "receiverName" TEXT,
    "receiverId" TEXT,
    "reference" TEXT,
    "receiverNID" TEXT,
    "cashByCodePIN" TEXT,
    "creditCardName" TEXT,
    "creditCardNumber" TEXT,
    "atmId" TEXT,
    "agentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Transfer_pkey" PRIMARY KEY ("transactionId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Deposit_transactionId_key" ON "Deposit"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Withdrawal_transactionId_key" ON "Withdrawal"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Transfer_transactionId_key" ON "Transfer"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_transactionId_key" ON "Transaction"("transactionId");

-- AddForeignKey
ALTER TABLE "UserFinancialInfo" ADD CONSTRAINT "UserFinancialInfo_accountNumber_fkey" FOREIGN KEY ("accountNumber") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("accountNumber") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdrawal" ADD CONSTRAINT "Withdrawal_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("accountNumber") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transfer" ADD CONSTRAINT "Transfer_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("accountNumber") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("accountNumber") ON DELETE RESTRICT ON UPDATE CASCADE;
