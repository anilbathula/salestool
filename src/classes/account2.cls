public class account2{   

    public string c{get;set;}
    public string a{get;set;}
    public id str{get;set;} 
    public list<Account> acc{get;set;}
    public Account n{get;set;}
    public list<contact> con{get;set;}
    public contact g{get;set;}
    

    public account2() { 
        n=new Account();   
        acc=new list<account>();  
        g=new Contact();
    }   
    
    public Void custSave(){    
         acc=[select id,name,description from Account where name=:a];
            for(Account n:acc){
                n.Name=a;
                n.description=c;
                upsert n;
                
                 
            }
            if(acc.isEmpty()){
                    Account newacct=new Account(Name=a,description=c);                     
                    acc.add(newAcct);
                        try {
                            upsert acc;
                        }catch (DmlException e) {
                            // Process exception here                         
                        }
            }
            
            
            }
           
    }