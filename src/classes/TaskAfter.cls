public with sharing class TaskAfter {

   
public static void updateLastActivityCompletedDate(List<Task> tskList){ 
Set<ID> LdIDs = new Set<ID>();

for(Task tsk :tskList){
String wId = tsk.WhoId;
if(wId!=null && wId.startsWith('00Q') && !LdIDs.contains(tsk.WhoId) && tsk.IsClosed == TRUE){
LdIDs.add(tsk.WhoId);
}
}

List<Lead> LdList = [SELECT ID, description FROM LEAD WHERE ID in :LdIDs];
for(Lead ld :LDList){
ld.description = string.valueof(system.now());
}

update LdList;
}

}