trigger upcom on Finance__c (after insert) {

Set<Id> sobjectSetOfIds = new Set<Id>();
List<Finance__c> flist = new List<Finance__c>(); 
 for(Finance__c fs:trigger.new) {
    if(fs.Opportunity__c!=null) 
     sobjectSetOfIds.add(fs.Opportunity__c);    
       flist.add(fs); 
 } 
 list<Comments__c> comlist = [select id,opportunity2__c,Finance__c from Comments__c where opportunity2__c in :sobjectSetOfIds]; 
 list<Comments__c> updatedcomlist = new list<Comments__c>(); 
 for(Finance__c fss :flist) { 
    for(Comments__c cm: comlist) {     
            cm.finance__c=fss.id;         
            updatedcomlist.add(cm); 
        } 
    }
    system.debug(updatedcomlist.size()+'Comments to insert is -----------------------------------'+updatedcomlist);
    upsert updatedcomlist;
}




















/*
=========================
junk code
=========================


trigger upcom on Finance__c (after insert,after update) {

Set<Id> sobjectSetOfIds = new Set<Id>();
List<Finance__c> flist = new List<Finance__c>(); 
 for(Finance__c fs:trigger.new) {
    if(fs.Opportunity__c!=null) 
     sobjectSetOfIds.add(fs.Opportunity__c);    
       flist.add(fs); 
 } 
 list<Comments__c> comlist = [select id,opportunity__c,Contact__c,Finance__c from Comments__c where opportunity__c in :sobjectSetOfIds]; 
 list<Comments__c> updatedcomlist = new list<Comments__c>(); 
 for(Finance__c fss :flist) { 
    for(Comments__c cm: comlist) {     
            cm.finance__c=fss.id;         
            updatedcomlist.add(cm); 
        } 
    }
    upsert updatedcomlist;
}
*/