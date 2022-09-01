public class NewTaskTrainingSchedulable implements Schedulable {
	public void execute(SchedulableContext sc) { 
        NewTaskTraining.insertTaskList(); 
    }
}