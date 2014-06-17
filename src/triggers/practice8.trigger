trigger practice8 on Payments__c (after delete, after insert, after update) {
 
 set<Id> Ids = new set<Id>();  
 if(trigger.isInsert || trigger.isUpdate){
    for(Payments__c p : trigger.new){
      Ids.add(p.Loan__c);
    }
  }
  
  if(trigger.isDelete){
    for(Payments__c p : trigger.old){
      Ids.add(p.Loan__c);
    }
  }
 
  map<Id,Double> smap = new map <Id,Double>();  
  for(AggregateResult q : [select Loan__c,sum(Payment_Amount__c)from Payments__c where Loan__c IN :Ids group by Loan__c]){
      smap.put((Id)q.get('Loan__c'),(Double)q.get('expr0'));      
  }

  List<Loan__c> ls = new List<Loan__c>(); 
  for(Loan__c a : [Select Id, Amount__c,Type__c from Loan__c where Type__c='Home Loan' AND Id IN :Ids]){
    Double PipelineSum = smap.get(a.Id);   
    a.Amount__c = PipelineSum;    
    ls.add(a);
  }
  update ls;
}