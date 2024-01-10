-- AlterTable
ALTER TABLE "UserFinancialInfo" ADD COLUMN     "totalRecharge" DOUBLE PRECISION DEFAULT 0.0,
ADD COLUMN     "totalTransfer" DOUBLE PRECISION DEFAULT 0.0;
