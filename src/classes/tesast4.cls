public class tesast4{

      public static sObject createObject(String typeName) {
    
     Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
        if (targetType == null) {
            // throw an exception 
    
        }else if(targetType!=null){
            String s='select id ,Name from targetType';
            system.debug('asd::->'+s);
        } 
    
        return targetType.newSObject(); 
    }

}