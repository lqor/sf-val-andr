public class CreateAccountFromRandomString {
    @AuraEnabled
    public static String createAccount(String random) {
        Account newAccount = new Account(Name = random);
        insert newAccount;
        return newAccount.Id;
    }
}