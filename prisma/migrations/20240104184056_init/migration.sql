/*
  Warnings:

  - You are about to drop the column `userFinancialInfoId` on the `Deposit` table. All the data in the column will be lost.
  - You are about to drop the column `userFinancialInfoId` on the `Transfer` table. All the data in the column will be lost.
  - You are about to drop the column `userFinancialInfoId` on the `Withdrawal` table. All the data in the column will be lost.
  - Added the required column `userId` to the `Deposit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Transfer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Withdrawal` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Deposit" DROP CONSTRAINT "Deposit_userFinancialInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Transfer" DROP CONSTRAINT "Transfer_userFinancialInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Withdrawal" DROP CONSTRAINT "Withdrawal_userFinancialInfoId_fkey";

-- AlterTable
ALTER TABLE "Deposit" DROP COLUMN "userFinancialInfoId",
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Transfer" DROP COLUMN "userFinancialInfoId",
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Withdrawal" DROP COLUMN "userFinancialInfoId",
ADD COLUMN     "userId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdrawal" ADD CONSTRAINT "Withdrawal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transfer" ADD CONSTRAINT "Transfer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
