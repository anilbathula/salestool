trigger practice9a on Loan__c (before Update) {
Set<Id> parentIds = new Set<Id>();
 
 if (Trigger.isUpdate) {               
        for (Loan__c a :trigger.new) { 
            if(a.Type__c=='Education Loan'){                                     
                       a.amount__c=0;
              
            }
            else if(a.Type__c=='Car Loan'||a.Type__c=='Home Loan'){
            map<Id,Double> smap = new map <Id,Double>();  
            for(AggregateResult q : [select Loan__c,sum(Payment_Amount__c) from Payments__c where Loan__c IN :trigger.newmap.keyset()  group by Loan__c]){
            system.debug('Asd-->'+q);
            smap.put((Id)q.get('Loan__c'),(Double)q.get('expr0'));      
            }
            Double PipelineSum = smap.get(a.Id);   
            a.Amount__c = PipelineSum;                    
            
            }
        }        
     
 }

}