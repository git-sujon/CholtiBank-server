/*
  Warnings:

  - You are about to drop the column `address` on the `PersonalInfo` table. All the data in the column will be lost.
  - You are about to drop the column `phoneNumber` on the `PersonalInfo` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "PersonalInfo" DROP COLUMN "address",
DROP COLUMN "phoneNumber",
ADD COLUMN     "otherPhoneNumber" TEXT,
ADD COLUMN     "passportId" TEXT;
