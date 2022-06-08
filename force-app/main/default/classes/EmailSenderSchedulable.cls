public with sharing class EmailSenderSchedulable implements Schedulable { 
    public void execute(SchedulableContext schedulableContext) { 
        System.debug('Hello world!'); 
    } 
}