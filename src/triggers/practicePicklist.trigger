trigger practicePicklist  on Finance__c (before insert,before update) {

    set<id> sids=new set<id>();    
    Opportunity opp;
   
    for(Finance__c fs:trigger.new){
        if(fs.Opportunity__c!=null ){
            sids.add(fs.Opportunity__c);
        }     
    }
    if(!sids.isEmpty()){
      opp= [select id,name,Parent_stage__c from opportunity where id in:sids];      
        for(Finance__c d:trigger.new){
            if(opp.Parent_Stage__c=='1' && (d.sub_stage__c!='1'&& d.sub_stage__c!='1a')){
                 d.addError('Parent record value is one select 1 or 1a');  
            }else if(opp.Parent_Stage__c=='2' && (d.sub_stage__c!='2'&& d.sub_stage__c!='2a')){
                d.addError('Parent record value is two select 2 or 2a');
            }else if(opp.Parent_Stage__c=='3' && (d.sub_stage__c!='3'&& d.sub_stage__c!='3a')){
                d.addError('Parent record value is three select 3 or 3a');
            }  
       }
    }
}