trigger practice9 on Payments__c (after delete, after insert, after update) {
 
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
 
  map<Id,Double> sum = new map <Id,Double>(); 
  map<Id,Double> count = new map <Id,Double>();
  map<Id,Double> max = new map <Id,Double>();
  map<Id,Double> min = new map <Id,Double>();
  
  for(AggregateResult q : [select  Loan__c,Sum(Payment_Amount__c),Max(Payment_Amount__c),min(Payment_Amount__c),count(Payment_Amount__c),sum(Amount1__c)from Payments__c where Active__c=True AND Loan__c IN :Ids group by Loan__c]){
        sum.put((Id)q.get('Loan__c'),(Double)q.get('expr0')); 
        max.put((Id)q.get('Loan__c'),(Double)q.get('expr1'));
        min.put((Id)q.get('Loan__c'),(Double)q.get('expr2'));
        count.put((Id)q.get('Loan__c'),(Double)q.get('expr3'));
      //smap1.put((Id)q.get('Loan__c'),(Double)q.get('expr1')); 
     
  }
 

  List<Loan__c> ls = new List<Loan__c>(); 
  
  for(Loan__c a : [Select Id, Amount__c,Type__c from Loan__c where (Type__c='Car Loan' OR Type__c='Home Loan') AND Id IN :Ids]){
   
    Double PipelineSum = sum.get(a.Id);   
   // double pipeline1=smap1.get(a.id);
    //System.debug('===>'+pipeline1);
    a.Amount__c = PipelineSum;    
    a.description__c=string.valueof(count.get(a.id));
    ls.add(a);
  }
  update ls;
}