public class RandomStringCallout {
    @AuraEnabled
    public static String getCallout() {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://www.random.org/strings/?num=1&len=10&digits=on&upperalpha=on&loweralpha=on&format=plain');
		request.setMethod('GET');
		HttpResponse response = http.send(request);
        return response.getBody();
    }
}