trigger loan on Loan__c (after update) {

  Map<Id,Id> loanOldBrokerMap = new Map<Id,Id>();
  List<Loan__c> loanList=new List<Loan__c>();
  Map<Id,Id> OldBrokerToNewBrokerMap=new Map<Id,Id>();
  
    for(Loan__c l: trigger.New){
        if(Trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(l.Id).Borrower__c!=l.Borrower__c)){
             loanOldBrokerMap.put(l.Id, trigger.oldMap.get(l.Id).Borrower__c);
             loanList.add(l);
             OldBrokerToNewBrokerMap.put(trigger.oldMap.get(l.Id).Borrower__c,l.Borrower__c);
        }
    } 
    if(loanList.size()>0){
        List<Opportunity> opptyList=[select Id,Borrower__c from Opportunity where Borrower__c IN :  loanOldBrokerMap.values() ] ;
        for(Opportunity oppty: opptyList){
            oppty.Borrower__c =OldBrokerToNewBrokerMap.get(oppty.Borrower__c);
        } 
        update opptyList;
    }
}