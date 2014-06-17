trigger UpdatestageName on Opportunity (after update) {

           
            Map<id,String> varmap=new Map<id,String>();
            Map<String,String> varmap1=new Map<String,String>();           
            List<Loan__c> lst=new List<Loan__c>();
            list<Contact>cs=new list<Contact>();
           
    
    if(Trigger.isupdate){                    
            for(Opportunity op:Trigger.New){
                if(Trigger.oldMap.get(op.Id).Stagename!=Trigger.NewMap.get(op.Id).Stagename&&op.StageName=='Closed Won'){                  
                     
                    varmap.put(op.Borrower__c,op.StageName);                
                }
            }   
                     
         if(!varmap.isEmpty()){            
            List<Contact> opps=[select id,name,Loan_Name__c,Description,(select id,Name,Description__c From Loans__r) from Contact where id IN:varmap.keyset()];
               if(!opps.isEmpty()){ 
                    For(Contact opp:opps){                      
                        opp.Description=varmap.get(opp.id);                       
                        varmap1.put(opp.loan_name__c,opp.Description); 
                        cs.add(opp);               
                    
                        for(loan__c l:opp.loans__r) {
                            if(opp.Loan_Name__c==l.Name){
                                l.Description__c=varmap1.get(l.Name);
                                lst.add(l);
                            }
                        }
                    }
                    update cs;
                    update lst;                             
              
              }  
         }   
    }                           
}