/*
  Warnings:

  - The primary key for the `Deposit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Transaction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Transfer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `UserFinancialInfo` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Withdrawal` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The required column `id` was added to the `Deposit` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `Transaction` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `Transfer` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `UserFinancialInfo` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `Withdrawal` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "Deposit" DROP CONSTRAINT "Deposit_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "Deposit" DROP CONSTRAINT "Deposit_userFinancialInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_userFinancialInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Transfer" DROP CONSTRAINT "Transfer_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "Transfer" DROP CONSTRAINT "Transfer_userFinancialInfoId_fkey";

-- DropForeignKey
ALTER TABLE "UserFinancialInfo" DROP CONSTRAINT "UserFinancialInfo_accountNumber_fkey";

-- DropForeignKey
ALTER TABLE "Withdrawal" DROP CONSTRAINT "Withdrawal_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "Withdrawal" DROP CONSTRAINT "Withdrawal_userFinancialInfoId_fkey";

-- AlterTable
ALTER TABLE "Deposit" DROP CONSTRAINT "Deposit_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Deposit_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Transfer" DROP CONSTRAINT "Transfer_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Transfer_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UserFinancialInfo" DROP CONSTRAINT "UserFinancialInfo_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "UserFinancialInfo_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Withdrawal" DROP CONSTRAINT "Withdrawal_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Withdrawal_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "UserFinancialInfo" ADD CONSTRAINT "UserFinancialInfo_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_id_fkey" FOREIGN KEY ("id") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdrawal" ADD CONSTRAINT "Withdrawal_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdrawal" ADD CONSTRAINT "Withdrawal_id_fkey" FOREIGN KEY ("id") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transfer" ADD CONSTRAINT "Transfer_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transfer" ADD CONSTRAINT "Transfer_id_fkey" FOREIGN KEY ("id") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userFinancialInfoId_fkey" FOREIGN KEY ("userFinancialInfoId") REFERENCES "UserFinancialInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
