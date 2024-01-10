-- AlterTable
ALTER TABLE "UserFinancialInfo" ADD COLUMN     "totalDeposit" DOUBLE PRECISION DEFAULT 0.0,
ADD COLUMN     "totalWithdraw" DOUBLE PRECISION DEFAULT 0.0;
