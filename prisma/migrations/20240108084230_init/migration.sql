/*
  Warnings:

  - You are about to drop the column `mobileOparators` on the `MobileRecharge` table. All the data in the column will be lost.
  - Added the required column `mobileOperators` to the `MobileRecharge` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "MobileRecharge" DROP COLUMN "mobileOparators",
ADD COLUMN     "mobileOperators" "MobileOperatorEnum" NOT NULL;
