public class newTaskTraining {
    public static void createTask() {
        Date today = Date.today();
        List<Training__c> endedTrains = [SELECT Name, End_Date__c, Training_Course__r.OwnerId
                                        FROM Training__c
                                        WHERE DAY_ONLY(End_Date__c) = :today];
        //System.debug(endedTrains);
        List<Task> taski = new List<Task>();
        for(Training__c train :endedTrains) {
            Task task = new Task(Subject = 'Fill GPA (marks) and mark all participants as Participated.',
                                Status = 'Not Started',
                                WhatId = train.Id,
                                OwnerId = train.Training_Course__r.OwnerId);
            taski.add(task);
        }
        insert taski;
    }
}