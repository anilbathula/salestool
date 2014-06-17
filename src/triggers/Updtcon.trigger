trigger Updtcon on comments__c (before insert) {
    Set<Id> sobjectSetOfIds = new Set<Id>();
    Comments__c cms;
    opportunity opp;

    /* updating Contact from Opportunity object comments related list*/
    for(Comments__c cs:trigger.New){
        cms=cs;
        if(cms.Opportunity2__c!=null && cms.Contact2__c==null ){
            sobjectSetOfIds.add(cms.Opportunity2__c);
        }
    }

    Map<Id,Opportunity>smap= new Map<Id, Opportunity>([Select id, Name, Borrower__c from Opportunity where Id in : sobjectSetOfIds]);

    for(Comments__c s: trigger.new){
        if(smap.containsKey(s.Opportunity2__c)){
            s.Contact2__c=smap.get(s.Opportunity2__c).Borrower__c;
        }
    }
    /* updating opportunity from contact object comments related list*/

     for(Comments__c cs:trigger.New){
        cms=cs;    
        if(cms.Opportunity2__c==null && cms.Contact2__c!=null ){
         //   List<Opportunity> opportunities = [select Id, Name from Opportunity where Borrower__r.Id  = :cms.Contact2__c];
             List<Opportunity> opportunities = [select Id, Name from Opportunity where Account.Id = :cms.Contact2__r.Account.id];
            for(Opportunity opportunity:opportunities){
                cs.Opportunity2__c = opportunity.id;
            }
        }
     }  
}