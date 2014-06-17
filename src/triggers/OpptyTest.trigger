trigger OpptyTest on Opportunity (before insert, before update) {


  Opportunity[] opptys = [SELECT Id, (SELECT Id, Name, ContentType FROM Attachments)  FROM Opportunity where id IN :Trigger.newMap.keySet()];
  for(Opportunity o : opptys){
            Attachment[] attc = o.Attachments;
            System.debug('attc.size() : ' + attc.size());
            if(attc.size()>0){
             System.debug('Need to set Syllabus Attached to true for Opportunity Id: ' + o.id);
             System.debug('just testing this: ' + Trigger.newMap.get(o.Id).Id);
             
                Trigger.newMap.get(o.Id).Attachment_linked__c = true;
              
            }
            else if(attc.size()==0){
             Trigger.newMap.get(o.Id).Attachment_linked__c = false;
                
            }                  
    }

}