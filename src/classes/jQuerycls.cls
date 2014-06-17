public with sharing class jQuerycls {

    public List<Account> lst{get; set;}
    public jQuerycls(){
//This Query queries accounts as well as it's associated Contacts.
        lst = [Select id, name,(Select id, name from Contacts) from account];
    }
}