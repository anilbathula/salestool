public with sharing class LogACallControllerExtension {

    public Task task {get; set;}

    public LogACallControllerExtension(ApexPages.StandardController controller) {
            this.task = (Task)controller.getRecord();
            this.task.whatId = ApexPages.currentPage().getParameters().get('what_id');    
            this.task.subject = 'Service Call';    // or      this.task.subject = ApexPages.currentPage().getParameters().get('tsk5');
            this.task.type = 'Call';
            this.task.status = 'Completed';
            this.task.activitydate = Date.today();
    }
}