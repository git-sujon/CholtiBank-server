/*
  Warnings:

  - A unique constraint covering the columns `[userId]` on the table `DeviceInfo` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId]` on the table `PersonalInfo` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[depositId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[withdrawalId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[transferId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId]` on the table `UserFinancialInfo` will be added. If there are existing duplicate values, this will fail.
  - Made the column `userId` on table `Transaction` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_userId_fkey";

-- AlterTable
ALTER TABLE "Transaction" ALTER COLUMN "userId" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "DeviceInfo_userId_key" ON "DeviceInfo"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PersonalInfo_userId_key" ON "PersonalInfo"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_userId_key" ON "Transaction"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_depositId_key" ON "Transaction"("depositId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_withdrawalId_key" ON "Transaction"("withdrawalId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_transferId_key" ON "Transaction"("transferId");

-- CreateIndex
CREATE UNIQUE INDEX "UserFinancialInfo_userId_key" ON "UserFinancialInfo"("userId");

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
