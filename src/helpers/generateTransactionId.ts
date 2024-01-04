export enum GenerateTransactionIDEnum {
  Deposit = 'DEP',
  Withdrawal = 'WIT',
  Transfer = 'TRA',
}

export const generateTransactionId = (transactionType: GenerateTransactionIDEnum) => {
  const currentDate = new Date();
  const year = currentDate.getFullYear().toString().slice(-2); // Extract last two digits of the year
  const month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // Add leading zero if needed
  const day = currentDate.getDate().toString().padStart(2, '0'); // Add leading zero if needed

  const randomDigits = Math.floor(Math.random() * 1000000)
    .toString()
    .padStart(6, '0'); // 6-digit random number

  const transactionId = `${year}${month}${day}${transactionType}${randomDigits}`;


  console.log("transactionId:", transactionId)

  return transactionId;
};


