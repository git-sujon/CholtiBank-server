/*
  Warnings:

  - You are about to drop the column `userId` on the `Deposit` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Transfer` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Withdrawal` table. All the data in the column will be lost.
  - Added the required column `userId` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Deposit" DROP CONSTRAINT "Deposit_userId_fkey";

-- DropForeignKey
ALTER TABLE "Transfer" DROP CONSTRAINT "Transfer_userId_fkey";

-- DropForeignKey
ALTER TABLE "Withdrawal" DROP CONSTRAINT "Withdrawal_userId_fkey";

-- AlterTable
ALTER TABLE "Deposit" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "Transaction" ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Transfer" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "Withdrawal" DROP COLUMN "userId";

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
