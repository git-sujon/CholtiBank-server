/*
  Warnings:

  - A unique constraint covering the columns `[mobileRechargeId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "SimTypeEnum" AS ENUM ('Prepaid', 'Postpaid');

-- CreateEnum
CREATE TYPE "MobileOperatorEnum" AS ENUM ('Grameenphone', 'Robi', 'Banglalink', 'Airtel', 'Teletalk');

-- AlterTable
ALTER TABLE "Transaction" ADD COLUMN     "mobileRechargeId" TEXT;

-- CreateTable
CREATE TABLE "MobileRecharge" (
    "id" TEXT NOT NULL,
    "transactionId" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "mobileOparators" "MobileOperatorEnum" NOT NULL,
    "simType" "SimTypeEnum" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MobileRecharge_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "MobileRecharge_transactionId_key" ON "MobileRecharge"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_mobileRechargeId_key" ON "Transaction"("mobileRechargeId");

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_mobileRechargeId_fkey" FOREIGN KEY ("mobileRechargeId") REFERENCES "MobileRecharge"("id") ON DELETE SET NULL ON UPDATE CASCADE;
