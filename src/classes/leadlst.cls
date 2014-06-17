public class leadlst{
    Public list<lead> ld{get;set;}
    public lead ls{get;set;}
    public id str{get;set;}
    

    public leadlst(ApexPages.StandardController Controller){
        ls=(Lead)Controller.getRecord();
        str=ApexPages.currentpage().getparameters().get('id');
        ld.add(ls);
        loaddata();
    }
    public void loaddata(){
        ld=[select id,Name,Phone from lead];
    
    }
    
        
    


}