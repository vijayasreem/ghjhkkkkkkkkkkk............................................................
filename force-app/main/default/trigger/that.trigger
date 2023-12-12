
trigger TransactionTrigger on Transaction__c (before insert) {
    public static void handleTransactions(List<Transaction__c> transactions) {
        // Map to store daily credit spent and transaction count per user
        Map<Id, Decimal> dailyCreditSpent = new Map<Id, Decimal>();
        Map<Id, Integer> transactionCount = new Map<Id, Integer>();
        
        for (Transaction__c transaction : transactions) {
            // Check if the credit amount exceeds the daily limit
            if (transaction.Credit_Amount__c > 50000) {
                transaction.addError('Your daily credit limit is exceeded.');
                return;
            }
            
            // Get the user ID for the transaction
            Id userId = transaction.User__c;
            
            // Check if the user has exceeded the transaction limit
            if (transactionCount.containsKey(userId) && transactionCount.get(userId) >= 3) {
                transaction.addError('Transaction limit exceeded. You cannot perform more than 3 transactions in a day.');
                return;
            }
            
            // Update the daily credit spent and transaction count
            if (!dailyCreditSpent.containsKey(userId)) {
                dailyCreditSpent.put(userId, 0);
            }
            dailyCreditSpent.put(userId, dailyCreditSpent.get(userId) + transaction.Credit_Amount__c);
            
            if (!transactionCount.containsKey(userId)) {
                transactionCount.put(userId, 0);
            }
            transactionCount.put(userId, transactionCount.get(userId) + 1);
        }
        
        // Process the transactions and update the daily credit spent and transaction count
        // You can add your own logic here
        
        // Confirm the successful completion of the transaction
        // You can add your own logic here
    }
}
