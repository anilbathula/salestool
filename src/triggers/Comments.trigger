trigger Comments on Lead (after update,after insert) {
   Lead ld;
    List<Comments__c> Com = new List<Comments__c>();
    for(Lead l: Trigger.New){
        ld=l;
    }
    if(ld.isConverted == true){    //ld.Status=='Followup(FWP)'              
        for (Comments__c comTemp : [Select id,Contact2__c,Opportunity2__c from 
            Comments__c where Lead__c=:ld.id]){
            comTemp.Opportunity2__c = ld.ConvertedOpportunityId;
            if(ld.lastname!=null){
                comTemp.Contact2__c=ld.ConvertedContactId;
            }
            Com.add(comTemp);
        }
    }
    if(Com !=null) update Com;
}