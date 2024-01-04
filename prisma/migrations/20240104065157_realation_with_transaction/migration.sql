-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("transactionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdrawal" ADD CONSTRAINT "Withdrawal_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("transactionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transfer" ADD CONSTRAINT "Transfer_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("transactionId") ON DELETE RESTRICT ON UPDATE CASCADE;
