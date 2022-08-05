public class generateCertificates {    
    @InvocableMethod(label='Generate certificates' description='Generate certificates for every participant of the training')
    public static void generatePdfs(List<Id> ids) {
        Id trainingId = ids[0];
        List<Participant__c> participants = [SELECT Id, Training__c, Contact_Name__r.Name
                                            FROM Participant__c
                                            WHERE Training__c = :trainingId];

        List<ContentVersion> listcv = new List<ContentVersion>();
        List<ContentDocumentLink> listcdl = new List<ContentDocumentLink>();
            
        for(Participant__c particip :participants) {
        	PageReference pageref = page.certificate;
        	pageref.getParameters().put('Id', particip.Id); 
        	pageref.setRedirect(true);
        	Blob bdata = pageref.getContent();
        
        	ContentVersion cv = new ContentVersion();
        	cv.ContentLocation = 'S';
        	cv.PathOnClient = particip.Contact_Name__r.Name + '.pdf';
        	cv.Title = particip.Contact_Name__r.Name + '.pdf';
        	cv.VersionData = bdata;
                
            listcv.add(cv);
        }
        insert listcv;
        
        for(ContentVersion cv :listcv) {                
        	Id conDocId = [SELECT ContentDocumentId
                      	FROM ContentVersion
                      	WHERE Id = :cv.Id].ContentDocumentId;
        
        	ContentDocumentLink cdl = new ContentDocumentLink();
        	cdl.ContentDocumentId = conDocId;
        	cdl.LinkedEntityId = trainingId;
        	cdl.ShareType = 'V';
        	cdl.Visibility = 'AllUsers'; 
                
            listcdl.add(cdl);
        }
        insert listcdl;
    }
}