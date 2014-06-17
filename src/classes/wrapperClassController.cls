public class wrapperClassController {

    //Our collection of the class/wrapper objects clead 
    public List<clead> contactList {get; set;}
    public list<lead> selectedleads{get;set;}

    //This method uses a simple SOQL query to return a List of leads
    public List<clead> getleads() {
        if(contactList == null) {
            contactList = new List<clead>();
            for(lead c : [select Id, Name, Email, Phone from lead limit 100]) {
                // As each contact is processed we create a new clead object and add it to the contactList
                contactList.add(new clead(c));
            }
        }
        return contactList;
    }


    public void processSelected() {

                
        List<lead> selectedleads = new List<lead>();

        //We will cycle through our list of cleads and will check to see if the selected property is set to true, if it is we add the lead to the selectedleads list
        for(clead cCon : getleads()) {
            if(cCon.selected == true) {
                selectedleads.add(cCon.con);
            }
        }
        delete selectedleads;   
    }


    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object lead and a Boolean value
    public class clead {
        public lead con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new clead object we pass a lead that is set to the con property. We also set the selected value to false
        public clead(lead c) {
            con = c;
            selected = false;
            
        }
    }
}