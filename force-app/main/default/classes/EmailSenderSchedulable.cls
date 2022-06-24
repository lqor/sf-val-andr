public class EmailSenderSchedulable implements Schedulable { 
    public void execute(SchedulableContext sc) { 
        beforeTwoDaysConfirm.schedulemails(); 
    } 
}

// code to execute in anonymous window:
// 1 --- initialize instance of the class, which implements schedulable interface
// 2 --- set cron expression of string type, which says to execute every day at midnight
// 3 --- call system.schedule method with three parameters: 
//       name of job, cron expression, instance of class with schedulable interface

// EmailSenderSchedulable ess = new EmailSenderSchedulable();
// String cronexp = '0 0 0 * * ?';
// System.schedule('Email Scheduler', cronexp, ess);