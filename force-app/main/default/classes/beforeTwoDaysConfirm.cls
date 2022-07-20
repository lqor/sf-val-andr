public class beforeTwoDaysConfirm {
    public static void schedulemails() {
        // get todays date 
        Date todays = Date.today();
        
        // get array of trainings, which will take place in two days
        List<Training__c> trngs = [SELECT ID, Name, Start_Date__c
                                  FROM Training__c
                                  WHERE DAY_ONLY(Start_Date__c) = :todays + 2];
        
        // get array of participants of these trainings
        List<Participant__c> ptcps = [SELECT Contact_Name__c,
                                     Contact_Name__r.Email,
                                     Training__r.Name,
                                     Training__r.Start_Date__c 
                                     FROM Participant__c
                                     WHERE Training__c IN :trngs];
        
        // show in debug these arrays are not empty:                            
        // System.debug(trngs);
        // System.debug(ptcps);
        
        // initialize array of all mails
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();

        // get email template
        EmailTemplate emailTemp = [SELECT Id, Subject, Body
                                   FROM EmailTemplate 
                                   WHERE DeveloperNAme = 'Training_confirmation']; 
        
        // for every participant from array create personal mail 
        // and add it to array of all mails
        for(Participant__c participant :ptcps) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); // initialize mail
            mail.setTemplateID(emailTemp.id); // set id of email template we got previously
            mail.setTargetObjectId(participant.Contact_Name__r.id); // set contact, related to participant
            mail.setWhatId(participant.Training__r.id); // set training, related to participant
            mailList.add(mail); // add mail to array of all mails
        }
        
        // if array of all mails is not empty, send them all
        if(!mailList.isEmpty()) {
            Messaging.sendEmail(mailList);
        }
    }
}
