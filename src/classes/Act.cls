Public class Act{
  
    public string accid{get;set;}    
    public Opportunity op{get;set;}
    public Task t{get;set;}
   
    
    public Act(ApexPages.StandardsetController stdController) {
        accid=Apexpages.currentpage().getparameters().get('Id');
        system.debug(accid);
        t=[select id,Whatid from Task where whatid=:accid];
             
      
    }
    public PageReference save() {       
        PageReference pageRef = new PageReference('/00T/e?title=Call&who_id=0019000000CI47Y&what_id=00690000007dBhZ&followup=1&tsk5=Call&tsk3_lkid=Contact&tsk3=+op.Borrower__c+&retURL=%2F00690000007dBhZ');
        pageRef.setredirect(true);
        return pageref;       
    }
    
    }