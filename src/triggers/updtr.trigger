trigger updtr on Opportunity (before update) {
    if(Trigger.isUpdate) {
for (opportunity chk: Trigger.new){ 
    if(chk.StageName!= null){
       // chk.start_date__c=chk.CloseDate-12;
      //  update chk;
    }
}

}
    
}