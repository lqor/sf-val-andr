public class CertificateGenerator {
	static final String pdf = '.pdf';    
    @InvocableMethod(label='Generate certificates' description='Generate certificates for every participant of the training')
    public static void generatePdfs(List<Id> ids) {
        if(ids == null) {
            System.debug('List of IDs is empty.');
        }
        
        else {
            Id trainingId = ids[0];
            List<Participant__c> participants = [SELECT Id, Training__c, Contact_Name__r.Name
                                                FROM Participant__c
                                                WHERE Training__c = :trainingId];

            List<ContentVersion> listcv = new List<ContentVersion>();
                
            for(Participant__c participant :participants) {
                PageReference pageref = page.certificate;
                pageref.getParameters().put('Id', participant.Id); 
                pageref.setRedirect(true);
                
                Blob content;
				if(Test.isRunningTest()) {
    				content = Blob.valueOf('TestCertificate');
				} 
                else if(pageref == null) {
    				content = Blob.valueOf(''); 
				} 
                else {
    				content = pageref.getContent();
				}
            
                ContentVersion cv = new ContentVersion();
                cv.ContentLocation = 'S';
                cv.PathOnClient = participant.Contact_Name__r.Name + pdf;
                cv.Title = participant.Contact_Name__r.Name + pdf;
                cv.VersionData = content;
                cv.FirstPublishLocationId = trainingId;
                    
                listcv.add(cv);
            }
            insert listcv;
        }
    }
}