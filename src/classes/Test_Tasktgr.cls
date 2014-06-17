@isTest 
private class Test_Tasktgr {
    static testMethod void method_TaskAfter() {
        Lead l=new lead();
        l.firstname='eerr';
        l.lastname='ertf';
        l.company='tedt';
        insert l;
        
       
        task t=new Task();
        t.Subject='Sample Task';
        t.Status='Closed';
        t.whoid=l.id;
        Insert t;
    }
}