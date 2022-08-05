public class newTaskTrainingSchedulable implements Schedulable {
	public void execute(SchedulableContext sc) { 
        newTaskTraining.createTask(); 
    }
}

// newTaskTrainingSchedulable ess = new newTaskTrainingSchedulable();
// String cronexp = '0 59 23 * * ?';
// System.schedule('Create Tasks for Trainings Scheduler', cronexp, ess);