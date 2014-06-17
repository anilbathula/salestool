public class CallManagementController {
    public string state { get; set; }
    public string response { get; set; }
    
  public CallManagementController() {
  state='start';
  }

  /* return TwiML */
  public void kookooResponse() {
  String resp;
      if(state.equals('start'))
      {
    String dialNumber;
    String name;
    String fromPhone = ApexPages.currentPage().getParameters().get('cid');
    if (fromPhone!=null) {
      // remove the country prefix for Phone field search
      if (fromPhone.startsWith('+1'))
        fromPhone = fromPhone.substring(2);
        
      fromPhone= fromPhone.length() <= 10 ? fromPhone : fromPhone.substring(fromPhone.length() - 10);
      // search Lead and Contact phone number fields
      List<List<SObject>> results = [FIND :fromPhone IN Phone FIELDS
          RETURNING Contact(FirstName, LastName,Owner.Phone), Lead(FirstName, LastName,Owner.Phone)
          LIMIT 1];
    
      // extract the owner phone if there’s a match
      if (!results[0].isEmpty()) {
        Contact r = (Contact)results[0][0];
        name = r.firstName + ' ' + r.lastName;
        if (r.owner!=null && r.owner.phone!=null)
          dialNumber = r.owner.phone;
      } else if (!results[1].isEmpty()) {
        Lead r = (Lead)results[1][0];
        name = r.firstName + ' ' + r.lastName;
        if (r.owner!=null && r.owner.phone!=null)
          dialNumber = r.owner.phone;
      }
      else {
        Lead l = new Lead(FirstName='Lead', LastName=fromPhone, Email='example@example.com', Company='test',Phone=fromPhone);
         try{
         insert l;
       }catch(Exception e){
         System.debug('System exception ' + e);
       }
        response = '<response><playtext>Hello new lead</playtext><hangup/></response>';
        return;
       }
    }
    state='dial';
    if(dialNumber != null)
    {
        dialNumber = dialNumber.replaceAll('\\D','');
        response='<response><playtext>Hello '+name+'.Please wait while we connect.</playtext><dial>'+dialNumber+'</dial></response>';
    }
    else
    {
        response='<response><playtext>Welcome back. Sorry, you have not yet been assigned an agent. Please try again</playtext><hangup/></response>';
    }
    }
  }
}