trigger updte_desc on Unit__c (after insert,after update,after delete) {

    Set<id>ids=new Set<id>();
    Set<id>oids=new Set<id>();
    Map<String,Unit__c> varmap=new Map<String,Unit__c>();
     
       if(Trigger.isInsert||Trigger.isUpdate) {  
            for(Unit__c u:trigger.new){
               if( u.unit_owner__c!=null){
                   ids.add(u.unit_owner__c);
                   varmap.put(u.Unit_Owner__c,u);
               }
            }
       }
   
   
   String str,str1,str2; 
   if(Trigger.isUpdate) {   
        for(Unit__c u:trigger.old){
           if(Trigger.oldMap.get(u.id).unit_owner__c!=Trigger.newMap.get(u.id).unit_owner__c){
               oids.add(u.unit_owner__c);     
                str=u.Name;          
           }
        }
   }
   
   
    
   if(Trigger.isdelete) {   
        for(Unit__c u:trigger.old){
           if(u.unit_owner__c!=null){
               oids.add(u.unit_owner__c);     
                str=u.Name;       
                System.debug('----'+str);   
           }
        }
   }
   
   
   if(!oids.IsEmpty()){
       List<Contact> updtcon=new List<Contact>();
        List<Contact> conlst=[Select Id,name,Description From Contact where Id In:oids ];
        for(Contact c:conlst){
            if(c.Description.contains(str)){
                system.debug('-----------'+str);
                   String strs =c.Description;  
                   if(strs.contains(','+str)){                
                       c.Description=strs.remove(','+str);
                   }else if(strs.contains(str+',')){
                        c.Description=strs.remove(str+',');
                   }else{
                       c.Description=strs.remove(str);                       
                   }
            }
             updtcon.add(c);
        }
        
        update updtcon;
   }
   
  if(!ids.IsEmpty()){
       List<Contact> updtcon=new List<Contact>();
        List<Contact> conlst=[Select Id,name,Description From Contact where Id In:ids ];
        for(Contact c:conlst){
            String Description='';
            for(Unit__c u:varmap.values()){
                    if(varmap.containsKey(u.Unit_Owner__c)){
                        if(Description==null ||Description==''){
                            Description=u.Name;
                        }
                        else{
                            Description+=','+u.Name;
                        }
                   }
           }
           if(c.Description==null||c.Description==''){
                c.Description=Description;
            }
            else{
                c.Description+=','+Description;
            }
            updtcon.add(c);
        }
        update updtcon;
   }
}