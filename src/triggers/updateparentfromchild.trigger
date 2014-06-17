trigger updateparentfromchild on Opportunity (after update) {
/*trigger unlockStudentInformation on Opportunity_Finance__c (after update) {

            Set<id> oppids=new Set<id>();
            Map<id,boolean> varmap=new Map<id,boolean>();
            List<Opportunity> opp=new List<Opportunity>();
    
    if(Trigger.isupdate){
                    
            for(Opportunity_Finance__c op:Trigger.New){
                if(op.Unlock_Student_Financial_Information__c !=null){                  
                    oppids.add(op.Opportunity__c);
                    varmap.put(op.Opportunity__c,op.Unlock_Student_Financial_Information__c);                
                }
            }            
                
    List<Opportunity> opps=[select id,name,Unlock_Student_Financial_Information__c from opportunity where Unlock_Student_Financial_Information__c=Null AND id in:oppids];
           if(!opps.isEmpty()){
                for(Opportunity o:opps){                 
                    o.Unlock_Student_Financial_Information__c=varmap.get(o.id);               
                    opp.add(o);
                    ////extra updation
                     Contact c=new contact();                      
                    c.id=o.contact__c;                                   
                    c.Unlock_Student_Financial_Information__c=o.Unlock_Student_Financial_Information__c;                    
                    cs.add(c);    ////        
                }update opp;   
                /Another way
              /   database.update(opp);  
                System.debug('--->'+opp);   
                database.update(cs);
                System.debug('--->'+cs);  /
          }  
    }                              
}*/

}