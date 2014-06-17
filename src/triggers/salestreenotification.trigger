/*Trigger   : salestreenotification 
  Events    : After Update on Opportunity 
  Test Class : salestreenotification_Test
  Developer : Anil.B
  Date      : 21/5/2013  
  Comment   : To send email notifications to the opportunity owners superiors(reporting to)
  and their reporting to heads when a stage name is changed to Partial Application,Confirmed,
  Admissions Endorsed Confirmed.
 */

trigger salestreenotification on Opportunity (after update) { 
    
    map<Opportunity,String> stnmap=new map<Opportunity,String>();
    map<Id,String>Reporting2Ids =new map<ID,String>();     
    map<string,set<string>> owner_relmailids=new map<string,set<string>>();
    map<string,set<string>> sub_owners=new map<string,set<string>>();  
    Map<String,String>sub=new map<String,String>();    
    List<Opportunity> varopp=new List<Opportunity>();

    for(Opportunity op:trigger.new) {        
        if(Trigger.IsUpdate && op.Stagename!=Trigger.oldMap.get(op.Id).Stagename &&(op.StageName=='Value Proposition' ||  op.StageName=='Needs Analysis' || op.StageName=='Closed Won')){             
             stnmap.put(op,op.ownerid);
             owner_relmailids.put(op.ownerid,new set<string>());         
        }
    }
    //System.debug('**************************>>'+stnmap.size());   
    if(!stnmap.isEmpty()){
         Set<String> ids = new Set<String>();                
         ids.addall(stnmap.values());       
         varopp.addall(stnmap.keyset());
         
        for (Integer i = 0; i < 3; i++) {  
             if(!ids.IsEmpty()){          
                list <Sales_Tree__c> lstst= [select id,Subordinate__c,Subordinate__r.Email,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c where Subordinate__c IN : ids];
                ids.clear(); 
                       
                for (Sales_Tree__c s :lstst) { 
                    if(s.reporting_to__c!=null){
                       Reporting2Ids.put(s.reporting_to__c, s.reporting_to__r.Email);                    
                       sub.put(s.Subordinate__c,s.Reporting_To__r.Email);
                       
                       System.debug('---)))->'+ Reporting2Ids);
                       ids.add(s.reporting_to__c);
                       set<String> temp=sub_owners.containsKey(s.reporting_to__c)?sub_owners.get(s.reporting_to__c):new set<string>();
                           if(i!=0){
                                if(sub_owners.containsKey(s.Subordinate__c))
                                    temp.addAll(sub_owners.get(s.Subordinate__c));
                           }    
                           else{
                                temp.add(s.Subordinate__c);
                           }
                          // System.debug(temp+'%%%%%%'+temp.size());
                           sub_owners.put(s.reporting_to__c,temp);
                           for(string onrs:temp){
                                set<string> mids=owner_relmailids.containsKey(onrs)?owner_relmailids.get(onrs):new set<string>();                       
                                mids.add(s.Reporting_To__r.Email);
                                owner_relmailids.put(onrs,mids);                                         
                           }
                    }             
                }   
             }
        }
            System.debug(')))-->'+Reporting2Ids);
           // System.debug(')))-->'+owner_relmailids);    
    }    

    for(String oppOwnerId : owner_relmailids.keySet()){ 
        List<string>s =new List<String>();   
            //if (stnmap.containsKey(oppOwnerId)) {                 
                s.addAll( owner_relmailids.get(oppOwnerId));  
                System.debug('**************************>>'+s); 
            //}  
            
            If(!s.IsEmpty()) {      
                messaging.Singleemailmessage mail=new messaging.Singleemailmessage();            
                mail.setToAddresses(s);
                mail.setSenderDisplayName('Hult');
                for(integer i=0;i<varopp.size();i++){
                    if(varopp[i].ownerid==oppOwnerId){
                        mail.setSubject('Opportunity Stage changed to:'+varopp[i].Stagename);
                        mail.setPlainTextBody('The Application record '+varopp[i].Name+' stage name has been changed to:'+varopp[i].Stagename);
                        try{             
                            messaging.sendEmail(new messaging.Singleemailmessage[]{mail});               
                        }
                        catch(DMLException e){ 
                            system.debug('ERROR SENDING EMAIL:'+e); 
                        }
                    }
                }
                
            }
    
    
    }
}



/*********
Trigger   : salestreenotification 
  Events    : After Update on Opportunity 
  Test Class : salestreenotification_Test
  Developer : Anil.B
  Date      : 21/5/2013  
  Comment   : To send email notifications to the opportunity owners superiors(reporting to)
  and their reporting to heads when a stage name is changed to Partial Application,Confirmed,
  Admissions Endorsed Confirmed.
 

trigger salestreenotification on Opportunity (after update) { 
    
    map<string,String> stnmap=new map<string,String>();
    map<Id,String>Reporting2Ids =new map<ID,String>();     
    map<string,set<string>> owner_relmailids=new map<string,set<string>>();
    map<string,set<string>> sub_owners=new map<string,set<string>>();  
    Map<String,String>sub=new map<String,String>();    

    for(Opportunity op:trigger.new) {        
        if(Trigger.IsUpdate && op.Stagename!=Trigger.oldMap.get(op.Id).Stagename &&(op.StageName=='Value Proposition' ||  op.StageName=='Needs Analysis' || op.StageName=='Closed Won')){             
             stnmap.put(op.ownerid,op.id);
             owner_relmailids.put(op.ownerid,new set<string>());         
        }
    }
       
    if(!stnmap.isEmpty()){
         Set<String> ids = new Set<String>();                
         ids.addall(stnmap.keySet());       
         
        for (Integer i = 0; i < 3; i++) {  
             if(!ids.IsEmpty()){          
                list <Sales_Tree__c> lstst= [select id,Subordinate__c,Subordinate__r.Email,Reporting_To__c,Reporting_To__r.Email  from Sales_Tree__c where Subordinate__c IN : ids];
                ids.clear(); 
                       
                for (Sales_Tree__c s :lstst) { 
                    if(s.reporting_to__c!=null){
                       Reporting2Ids.put(s.reporting_to__c, s.reporting_to__r.Email);                    
                       sub.put(s.Subordinate__c,s.Reporting_To__r.Email);
                       
                       System.debug('---)))->'+ Reporting2Ids);
                       ids.add(s.reporting_to__c);
                       set<String> temp=sub_owners.containsKey(s.reporting_to__c)?sub_owners.get(s.reporting_to__c):new set<string>();
                           if(i!=0){
                                if(sub_owners.containsKey(s.Subordinate__c))
                                    temp.addAll(sub_owners.get(s.Subordinate__c));
                           }    
                           else{
                                temp.add(s.Subordinate__c);
                           }
                          // System.debug(temp+'%%%%%%'+temp.size());
                           sub_owners.put(s.reporting_to__c,temp);
                           for(string onrs:temp){
                                set<string> mids=owner_relmailids.containsKey(onrs)?owner_relmailids.get(onrs):new set<string>();                       
                                mids.add(s.Reporting_To__r.Email);
                                owner_relmailids.put(onrs,mids);                                         
                           }
                    }             
                }   
             }
        }
            System.debug(')))-->'+Reporting2Ids);
           // System.debug(')))-->'+owner_relmailids);    
    }    

    for(String oppOwnerId : Reporting2Ids.keySet()){ 
        List<string>s =new List<String>();   
            if (stnmap.containsKey(oppOwnerId)) {                 
                s.add( Reporting2Ids.get(oppOwnerId));  
                System.debug('**************************>>'+s); 
            }  
        
            If(!s.IsEmpty()) {      
                messaging.Singleemailmessage mail=new messaging.Singleemailmessage();            
                mail.setToAddresses(s);
                mail.setSenderDisplayName('Hult');
                mail.setSubject('Opportunity Stage changed to:'+Trigger.NewMap.get(stnmap.get(oppOwnerId)).Stagename);
                mail.setPlainTextBody('The Application record '+Trigger.NewMap.get(stnmap.get(oppOwnerId)).Name+' stage name was been changed to:'+Trigger.NewMap.get(stnmap.get(oppOwnerId)).Stagename);
                    try{             
                        messaging.sendEmail(new messaging.Singleemailmessage[]{mail});               
                    }
                    catch(DMLException e){ 
                        system.debug('ERROR SENDING EMAIL:'+e); 
                    }
            }
    
    
    }
}
************/