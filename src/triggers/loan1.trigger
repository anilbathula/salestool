trigger loan1 on opportunity (after update) {

  Map<Id,Id> loanOldBrokerMap = new Map<Id,Id>();
  List<Opportunity> loanList=new List<Opportunity>();
  Map<Id,Id> OldBrokerToNewBrokerMap=new Map<Id,Id>();
    for(Opportunity l: trigger.New){
        if(Trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(l.Id).Borrower__c!=l.Borrower__c)){
         loanOldBrokerMap.put(l.Id, trigger.oldMap.get(l.Id).Borrower__c);
         loanList.add(l);
         OldBrokerToNewBrokerMap.put(trigger.oldMap.get(l.Id).Borrower__c,l.Borrower__c);
        }
    }
    
    if(loanList.size()>0){
        List<Loan__c> opptyList=[select Id,Borrower__c from Loan__c where Borrower__c IN :  loanOldBrokerMap.values() ] ;
        for(Loan__c oppty: opptyList){
            oppty.Borrower__c =OldBrokerToNewBrokerMap.get(oppty.Borrower__c);
        } 
        update opptyList;
    }
}