@isTest
private class CreateAccountFromRandomStringTest {
	@isTest
    static void TestCreateAccount() {
        String somestring = 'new account';
        String newAccount = CreateAccountFromRandomString.createAccount(somestring);
        List<Account> newAccounts = [SELECT Name
                                    FROM Account
                                    WHERE Name = :somestring];
        System.assertNotEquals(null, newAccount);
        System.assertNotEquals(0, newAccounts.size());
        System.assertEquals('new account', newAccounts[0].Name);
    }
}