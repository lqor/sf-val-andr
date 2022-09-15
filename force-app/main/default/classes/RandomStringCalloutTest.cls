@isTest
private class RandomStringCalloutTest {
	@isTest
    static void testGetCallout() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('somestring');
        Test.setMock(HttpCalloutMock.class, mock);
        String result = RandomStringCallout.getCallout();
        
        System.assertNotEquals(null, result);
        System.assertEquals('random string', result);
    }
}