trigger Taskowneremail on Task (after update) { 

Set<Id> sobjectSetOfIds = new Set<Id>();
    for(Task tk:trigger.New){          
      /*  if(tk.Whatid!=null && (tk.Subject.Contains('General question'))||(tk.Subject.Contains('One to one consultation')) ||(tk.Subject.Contains('Student Application Support Request'))){
            sobjectSetOfIds.add(tk.whatid);           
        }    */
        if(tk.Whatid!=null ||tk.whoid!=null&&tk.status=='Completed'){
            sobjectSetOfIds.add(tk.id);  
        }
    }

 if(Trigger.isupdate){
     if(!sobjectSetOfIds.IsEmpty()){
    // Profile p = [SELECT Id FROM Profile WHERE Name='test'];
          //Opportunity opp=[Select id,Name,StageName,Owner.Name,Borrower__r.Name,Borrower__c,Borrower__r.EMail,Borrower__r.Phone from Opportunity where Id in : sobjectSetOfIds];
            for(Task t:trigger.new)      {                
                 
                     try{ 
                       
                        messaging.Singleemailmessage mail=new messaging.Singleemailmessage();       
                        String Subject='A candidate has a query for you';
                        String emailBody = 'Dear ' + 'gudmrng '+ ',\n\n' +'';
                                       /* 'Your Applicant :'+'-'+Opp.Borrower__r.Name+' with Stage'+'-'+ opp.StageName+' has requested a subject through hult.edu .' + '\n' +
                                        'Question from the applicant :'+ t.Description + '\n' +
                                        'Email :'+opp.Borrower__r.EMail+ '\n' +
                                        'Phone:'+Opp.Borrower__r.Phone+' \n'+
                                        'https://ap1.salesforce.com/'+opp.Borrower__c+'\n\n\n'+
                                        'Thanks'+'\n'+
                                        'HULT'+''; */
                        
                        
                     
                        mail.setSenderDisplayName('Hult');     
                        mail.setSubject(subject);
                        mail.setPlainTextBody(emailBody);   
                        mail.setToAddresses(new list<String>{'anil.bathula@hult.edu','franktoanil@gmail.com'}); 
                       // mail.setWhatId(opp.Owner.id);
                        mail.saveAsActivity = false;                       
                       
                       
                       
                        try{ 
                            messaging.sendEmail(new messaging.Singleemailmessage[]{mail}); 
                        }catch(DMLException e){ 
                            system.debug('ERROR SENDING FIRST EMAIL:'+e.getDMLMessage(0)); 
                        } 
                
                
                    }catch(Exception Ex){     
                      trigger.new[0].addError('Errors occured: '+Ex);     
                      system.debug(Ex); 
                    } 
                

          }                      
     }
    
}      
}