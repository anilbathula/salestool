trigger Lead_Campaign_Mid_Market on CampaignMember(before insert,before update,after insert, after update) {
 set<id>ids=new set<id>();
 List<Lead> ldlist= new List<Lead>();
 
 
    for(CampaignMember cmpmember: Trigger.new){
        if(cmpmember.LeadId !=null){
        system.debug(cmpmember.campaignid+'---->'+cmpmember.campaign.type);
           if( cmpmember.campaign.type=='Advertisement'){
           
            ids.add(cmpmember.LeadId);     
           
            }       
        }      
    }
    
  if(!ids.IsEmpty()){
      List<lead> ld=[select id,name,description,Active__c from lead where id=:ids];
       System.debug('++++'+ld.size());
      for(lead l:ld){
          l.description='Mid Market';
          l.Active__c=true;
          System.debug('++++'+l.description);
      ldlist.add(l);
      }
  
  }
    
    
    if(ldlist !=null && ldlist.size()>0){
        update ldlist;
    }
}