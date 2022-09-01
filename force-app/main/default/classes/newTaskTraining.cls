public class NewTaskTraining {
    static final String taskSubject = 'Fill GPA (marks) and mark all participants as Participated.';
    static final String taskStatus = 'Not Started';
    
    public static Task createTask(Training__c training) {
        Task task = new Task(Subject = taskSubject,
                             Status = taskStatus,
                             WhatId = training.Id,
                             OwnerId = training.Training_Course__r.OwnerId);
        return task;
    }
    
    public static void insertTaskList() {
        List<Task> taskList = new List<Task>();
        for(Training__c training :[SELECT Name, End_Date__c, Training_Course__r.OwnerId
                                  FROM Training__c
                                  WHERE End_Date__c = TODAY]) {                    
            taskList.add(NewTaskTraining.createTask(training));
        }
        insert taskList;
    }
}