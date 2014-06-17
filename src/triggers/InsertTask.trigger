trigger InsertTask on Lead (after update) {


List<Task>tks=new list<Task>();
list<String>ss=new List<String>();
list<Lead>lst=new list<lead>();
Set<id>ids=new set<id>();

  For(lead l:Trigger.New) {
      if(trigger.oldmap.get(l.Id).status!=trigger.newmap.get(l.Id).status && l.isconverted==false){
          ids.add(l.id);          
          ss.add(l.status);               
          lst.add(l);
          
      }
  }
  if(!ids.Isempty()){
  
   list<task>tps=[Select id from task where whoid=:trigger.newmap.keyset()];
   System.debug('}}}}}}->'+tps.size());
   List<task>tk=[Select id From Task Where whoid in:Ids and Subject in:ss];    
     if(tk.isEmpty()){
        for(lead ld:lst){
       
            Task t=new task();              
            t.description=ld.FirstName+''+Ld.LastName;
            t.Subject=ld.status;
            t.Status='In Progress';
            t.Priority='High';
            t.whoid=ld.id;                          
            System.debug('-->'+t.description);
            tks.add(t);       
        } insert tks;
             
       
     }   
   list<task>tp=[Select id from task where whoid=:trigger.newmap.keyset() and Status!='Completed'];
  System.debug('-->'+tp.size());
    if(!tks.IsEmpty()){
    lead ls=new lead();
          For(task t:tks){
                if(t.Whoid!=null){                
                      ls.id=t.whoid;
                          if(ls.Description==null){
                              ls.description=t.description;
                          }  
                         ls.numberofemployees=tp.size(); 
                                      
                }
          }
           update ls;
      }Else{
          System.debug('No task was inserted');
      }
      
       for(task t:tks){
          messaging.Singleemailmessage mail=new messaging.Singleemailmessage();   
           String[] toAddresses = new String[] { UserInfo.getUserEmail()};         
                mail.setTargetObjectId(t.whoid); 
                System.debug('--->'+t.whoid);
                mail.setCcAddresses(toAddresses);
                mail.setSenderDisplayName('Anil Dev Instance');                
                mail.setSubject('New Confirmation! ');
                mail.setPlainTextBody('Congratulations...  '+'\n'+'\n');
               
                
                    try{             
                         messaging.sendEmail(new messaging.Singleemailmessage[]{mail});               
                    }
                    catch(DMLException e){ 
                        system.debug('ERROR SENDING EMAIL:'+e); 
                    }          
     }  
  }
}































/*===================================
trigger InsertTask on Lead (after insert,after update) {

List<Task>tks=new list<Task>();
Integer i;
  //list<lead> ld=[select id,Name,status from lead where id in:trigger.Newmap.keyset()];   
  //System.debug('***'+ld);
 // Set<id>ids=new set<id>();
  
  For(lead l:Trigger.New) {
   List<task>tk=[Select id  From Task Where whoid=:l.Id and Subject=:l.Status]; 
    i=tk.size();
   System.Debug('----->'+tk.size());
        if(tk.isEmpty()){
              Task t=new task();
              t.Subject=l.status;
              t.Status='In Progress';
              t.Priority='High';
              t.whoid=l.id;
              string s='|'+l.name+'|';
              t.description=s;
              System.debug(+s+'-->'+t);
              tks.add(t);        
             // System.debug('@@@@@'+tks.size());          
        }     
  }insert tks;
 
  //list<task>l=[Select id From task where whoid=:trigger.newmap.keyset()];
  
if(!tks.IsEmpty()){
      For(task t:tks){
            if(t.Whoid!=null){         
                  lead ls=new lead();
                  ls.id=t.whoid;
                      if(ls.Description==null){
                          ls.description=t.description;
                      }  
                      ls.numberofemployees=i+1;            
                  update ls;
            }
      }
  }Else{
      System.debug('No task was inserted');
  }
  
}
*/