/*
  Warnings:

  - Added the required column `transferSource` to the `Transfer` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Transfer" ADD COLUMN     "transferSource" "TransferSourceEnum" NOT NULL;
