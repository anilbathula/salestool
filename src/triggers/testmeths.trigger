trigger testmeths on Opportunity (before insert) 
{
  
    public void meth1(string x)
    {
        system.debug('value is '+x);
    }  
}
/*
trigger salestreenotification on Opportunity (after update) {            

    
    map<string,string> stnmap=new map<string,string>();    
    map<ID,String>rpids =new map<ID,String>();
    Map<Id,String>emls=new Map<Id,String>();
    list<Id>lstis=new list<id>();       


    for(Opportunity op:trigger.new) {        
        if(Trigger.IsUpdate && op.Stagename!=Trigger.oldMap.get(op.Id).Stagename &&(op.StageName=='Confirmed' ||  op.StageName=='Partial Application' || op.StageName=='Admissions Endorsed Confirmed')){             
             stnmap.put(op.ownerid,op.id);
        }
    }
    
   
    list <Sales_Tree__c> lstst= [select id,Subordinate__c,Subordinate__r.Email,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where   Subordinate__c IN : stnmap.keyset() OR Reporting_To__c IN :stnmap.keyset()];
        if(!lstst.isempty()){    
            for(Sales_Tree__c s:lstst){          
                emls.put(s.id,s.Reporting_To__r.Email);
                rpids.put(s.reporting_to__c,s.id);       
            }            
            System.debug('--->'+emls);      
        }
        
    
    list <Sales_Tree__c> lstst1= [select id,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where Subordinate__c IN :rpids.keyset()];
        if(!lstst1.isempty()){    
            for(Sales_Tree__c s:lstst1){       
                rpids.put(s.reporting_to__c,s.id);
                emls.put(s.id,s.Reporting_To__r.Email);
            }   
            System.debug('--->'+emls); 
        }
        
    System.debug('------@@@@@@@@@@@@----->'+lstst1);
    
    
   
    list <Sales_Tree__c> lstst2= [select id,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where Subordinate__c IN :rpids.keyset()];
        if(!lstst2.isempty()){  
            for(Sales_Tree__c s:lstst2){      
                rpids.put(s.reporting_to__c,s.id);
                emls.put(s.id,s.Reporting_To__r.Email);
            }          
            System.debug('--->'+emls); 
        }
    
    
    List<string>s =new List<String>();
    s=emls.values();
    
        System.debug('***********>>'+s); 
    
    
     messaging.Singleemailmessage mail=new messaging.Singleemailmessage();            
        mail.setToAddresses(s);
        mail.setSenderDisplayName('Hult');
        mail.setSubject('Test');
        mail.setPlainTextBody('This is test');
        try{ 
           // messaging.sendEmail(new messaging.Singleemailmessage[]{mail}); 
        }
        catch(DMLException e){ 
            system.debug('ERROR SENDING EMAIL:'+e); 
        } 
}

===============================================================
trigger salestreenotification on Opportunity (after update) {            

    list<String> lstemail=new list <String>();
    map<string,string> stnmap=new map<string,string>();
    set<string>sts=new set<String>();
    map<ID,String>rpids =new map<ID,String>();
    Map<Id,String>emls=new Map<Id,String>();
    list<Id>lstis=new list<id>();       


    for(Opportunity op:trigger.new) {        
        if(Trigger.IsUpdate && op.Stagename!=Trigger.oldMap.get(op.Id).Stagename &&(op.StageName=='Confirmed' ||  op.StageName=='Partial Application' || op.StageName=='Admissions Endorsed Confirmed')){             
             stnmap.put(op.ownerid,op.id);
        }
    }
    
    
list <Sales_Tree__c> lstst= [select id,Subordinate__c,Subordinate__r.Email,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where   Subordinate__c IN : stnmap.keyset() OR Reporting_To__c IN :stnmap.keyset()];


    system.debug('--------->'+lstst);    
    
    if(!lstst.isempty()){    
       for(Sales_Tree__c s:lstst){
           sts.add(s.Subordinate__r.Email);
           sts.add(s.Reporting_To__r.Email);
           emls.put(s.id,s.Reporting_To__r.Email);
           rpids.put(s.reporting_to__c,s.id);
       
        }   
        lstemail.addall(sts);  
        System.debug('--->'+emls);      
        
        system.debug('-------))))))-->'+lstemail); 
              
       
    }
    list <Sales_Tree__c> lstst1= [select id,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where Subordinate__c IN :rpids.keyset()];
    if(!lstst1.isempty()){    
       for(Sales_Tree__c s:lstst1){          
           sts.add(s.Reporting_To__r.Email);
           rpids.put(s.reporting_to__c,s.id);
           emls.put(s.id,s.Reporting_To__r.Email);
       
        }   
        lstemail.addall(sts); 
          System.debug('--->'+emls); 
        }
    
    System.debug('------@@@@@@@@@@@@----->'+lstst1);
    System.debug('------@@@@@@@@@@@@----->'+lstemail);
    
    list <Sales_Tree__c> lstst2= [select id,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c  where Subordinate__c IN :rpids.keyset()];
    if(!lstst2.isempty()){  
       
       for(Sales_Tree__c s:lstst2){          
           sts.add(s.Reporting_To__r.Email);
           rpids.put(s.reporting_to__c,s.id);
           emls.put(s.id,s.Reporting_To__r.Email);
          
       
        }   
        lstemail.addall(sts); 
          System.debug('--->'+emls); 
        }
    
    List<string>s =new List<String>();
    s=emls.values();
    System.debug('***********>>'+s);
    
    System.debug('------@@@@@@@@@@@@----->'+lstst1);
    System.debug('------@@@@@@@@@@@@----->'+lstemail);
    
    
    
    
    
     messaging.Singleemailmessage mail=new messaging.Singleemailmessage();            
        mail.setToAddresses(s);
        mail.setSenderDisplayName('Hult');
        mail.setSubject('Test');
        mail.setPlainTextBody('This is test');
        try{ 
           // messaging.sendEmail(new messaging.Singleemailmessage[]{mail}); 
        }
        catch(DMLException e){ 
            system.debug('ERROR SENDING EMAIL:'+e); 
        } 
}

*/