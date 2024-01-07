/*
  Warnings:

  - Added the required column `userId` to the `DeviceInfo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `PersonalInfo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `UserFinancialInfo` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DeviceInfo" DROP CONSTRAINT "DeviceInfo_id_fkey";

-- DropForeignKey
ALTER TABLE "PersonalInfo" DROP CONSTRAINT "PersonalInfo_id_fkey";

-- DropForeignKey
ALTER TABLE "UserFinancialInfo" DROP CONSTRAINT "UserFinancialInfo_id_fkey";

-- AlterTable
ALTER TABLE "DeviceInfo" ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "PersonalInfo" ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "UserFinancialInfo" ADD COLUMN     "userId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "PersonalInfo" ADD CONSTRAINT "PersonalInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFinancialInfo" ADD CONSTRAINT "UserFinancialInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceInfo" ADD CONSTRAINT "DeviceInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
