public class listofClosedActivities{
    

    public String actid{get;set;}
    public list<Task> Activities{get;set;}
    public list<Event> Events{get;set;}
    
     public listofClosedActivities(ApexPages.StandardsetController stdController) {
        actid=Apexpages.currentpage().getparameters().get('id');
        
        Activities=[SELECT Id,Subject FROM Task WHERE Who.id=: actid AND Status='Completed'];
        Events=[Select ID,Subject,ActivityDate From Event where Who.id=:actid And EndDateTime<:System.Now()];
    }
    
}