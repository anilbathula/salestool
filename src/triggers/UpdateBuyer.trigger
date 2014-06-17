trigger UpdateBuyer on Co_applicant__c (before insert,before update) {

    For(Co_applicant__c cp:Trigger.new){      
        If(cp.Contact__c!=Null){
            cp.Buyer__c=cp.contact__c;
        } 
    }
}