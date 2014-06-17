public with sharing class UApp
{
    /*
     * Used to return a record type Id based on sObject and record type name passed in
     */
    public static String getRecordTypeId(String sObjectType, String recordTypeName)
    {
        if(sObjectType == null || sObjectType.trim().length() == 0)
        {
            return '';
        }        
        
        if(recordTypeName == null || recordTypeName.trim().length() == 0)
        {
            return '';
        }
        
        String recordTypeId = null;
        List<RecordType> recordTypes = [select SobjectType, Name, Id from RecordType where SObjectType = :sObjectType and Name = :recordTypeName limit 1];
        
        if(recordTypes.size() == 1)
        { 
            recordTypeId = recordTypes[0].Id;
        }
        
        return recordTypeId;
    }
    
    /*
     * Used to return a record type Id based on sObject and record type name passed in
     */
    public static String getRecordTypeName(String recordTypeId)
    {
        if(isValidRecordId(recordTypeId) == false)
        {
            return '';
        }        
        
        String recordTypeName = null;
        List<RecordType> recordTypes = [select Id, Name from RecordType where Id = :recordTypeId limit 1];
        
        if(recordTypes.size() == 1)
        { 
            recordTypeName = recordTypes[0].Name;
        }
        
        return recordTypeName;
    }
    
    public static Boolean isNullOrEmpty(String value)
    {
        if(value == null || value.trim().length() == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public static Boolean isValidList(List<SObject> records)
    {
        if(records != null && records.size() > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }      
    
    public static String getQueryStringParameter(PageReference page, String key)
    {
        if(page == null)
        {
            return null;
        }
        
        if(key == null || key.trim().length() == 0)
        {
            return null;
        }
        
        String returnValue = page.getParameters().get(key);
        
        return returnValue;
    }
    
    //Assumes the current page
    public static String getQueryStringValue(String key)
    {
        if(isNullOrEmpty(key) == true)
        {
            return null;            
        }
                
        return getQueryStringParameter(ApexPages.currentPage(), key);
    }     
    
    public static SelectOption getEmptySelectOption(String emptyText)
    {
        if(emptyText == null || emptyText.trim().length() == 0)
        {
            emptyText = 'None';
        }
        
        return new SelectOption('', '-- ' + emptyText + ' --');
    }            
    
    public static Boolean isValidRecordId(String idValue)
    {
        Boolean returnValue = false;
        
        if(idValue != null && (idValue.trim().length() == 15 || idValue.trim().length() == 18))
        {
            returnValue = true;
        }
        
        return returnValue;
    } 
        
    public static String getURL(String sObjectLink, String mode, Map<String, String> urlParams)
    {
        String url = '';
        Integer i = 0;
        List<String> charactersToEscape = new List<String>();
        
        charactersToEscape.add('&');
        
        if(isNullOrEmpty(sObjectLink) == true)
        {
            return url;
        }        
        
        if(isNullOrEmpty(mode) == true)
        {
            mode = '/o';
        }        
        
        if(urlParams == null | urlParams.size() == 0)
        {
            return url;
        }
        
        url += sObjectLink;
        url += mode;
        
        for(String key : urlParams.keySet())
        {
            string value = urlParams.get(key);
            
            if(value != null && value.trim().length() > 0)
            {
                if(i == (urlParams.size() - 1))
                {
                    url += key + '=' + StringFunctions.escape(urlParams.get(key), charactersToEscape);            
                }
                else
                {
                    url += key + '=' + StringFunctions.escape(urlParams.get(key), charactersToEscape) + '&';
                }
            }
            
            i++;
        }                              
                
        return url;
    }
    
    public static void printDmlMessagesToDebug(DmlException e)
    {       
        if(e == null)
        {
            return;
        }
        
        for (Integer i = 0; i < e.getNumDml(); i++) 
        {    
            System.debug(e.getDmlMessage(i)); 
        }
    }    
    
    public static void insertContactAccount(String firstName, String lastName)
    {
        Account contactAccount = getNewContactAccount(firstName, lastName);
        
        if(contactAccount == null)
        {
            return;
        }            
            
        try
        {
            insert contactAccount;
        }
        catch(DmlException e)
        {
            System.assert(1 == 0, e.getMessage());   
        }    
    }    
    
    public static Account getNewContactAccount(String firstName, String lastName)
    {
        if(isNullOrEmpty(lastName) == true)
        {
            return null;
        }
        
        Account contactAccount = new Account();        
                
        String contactAccountName = getContactAccountName(firstName, lastName);

        if(contactAccountName != null && contactAccountName.trim().length() > 0)
        {
            contactAccount.Name = contactAccountName;
        }
        
        return contactAccount;                    
    }
    
    public static String getContactAccountName(String firstName, String lastName)
    {
        String returnValue = null;
            
        if(isNullOrEmpty(lastName) == true)
        {
            return returnValue;
        }                
            
        if(firstName != null && firstName.trim().length() > 0)
        {
            returnValue = firstName + ' ' + lastName;
        }
        else
        {    
            returnValue = lastName;
        }
        
        return returnValue;                    
    }    
    
    public static List<String> setToList(Set<String> stringValues)
    {
        if(stringValues == null || stringValues.size() == 0)
        {
            return new List<String>();
        }
        
        List<String> values = new List<String>();
        
        values.addAll(stringValues);
        
        return values;
    }    
    
    public static ApexPages.Message getConfirmPageMessage(String msg)
    {
        return getPageMessage(ApexPages.Severity.CONFIRM, msg);
    }     
    
    public static ApexPages.Message getErrorPageMessage(String msg)
    {
        return getPageMessage(ApexPages.Severity.ERROR, msg);
    }   
    
    public static ApexPages.Message getFatalPageMessage(String msg)
    {
        return getPageMessage(ApexPages.Severity.FATAL, msg);
    }     
    
    public static ApexPages.Message getInfoPageMessage(String msg)
    {
        return getPageMessage(ApexPages.Severity.INFO, msg);
    }    
    
    public static ApexPages.Message getWarningPageMessage(String msg)
    {
        return getPageMessage(ApexPages.Severity.WARNING, msg);
    }       
    
    private static ApexPages.Message getPageMessage(ApexPages.Severity severity, String msg)
    {
        return new ApexPages.Message(severity, msg);
    }
    
    private static testmethod void testCode()
    {
        String id1 = getRecordTypeId('Account','Test');
        String rtName1 = getRecordTypeName([select Id from RecordType order by CreatedDate desc limit 1].Id);
        
        Boolean b1 = isNullOrEmpty(null);
        Boolean b2 = isNullOrEmpty('Test');
        
        Boolean b6 = isValidList(null);
        Boolean b7 = isValidList(new Contact[]{[select Id from Contact order by CreatedDate desc limit 1]});
        
        String s1 = getQueryStringParameter(null, null);
        String s2 = getQueryStringParameter(new PageReference('test?id=123'), null);
        String s3 = getQueryStringParameter(new PageReference('test?id=123'), 'id');
        
        String s4 = getQueryStringValue(null);
        String s5 = getQueryStringValue('id');
        
        SelectOption so1 = getEmptySelectOption(null);
        SelectOption so2 = getEmptySelectOption('Select a value');
                    
        Boolean b3 = isValidRecordId(null);
        Boolean b4 = isValidRecordId('123');
        Boolean b5 = isValidRecordId('123456789012345');        
        
        ApexPages.Message m1 = getConfirmPageMessage('Confirm');
        ApexPages.Message m2 = getErrorPageMessage('Error');
        ApexPages.Message m3 = getFatalPageMessage('Fatal');
        ApexPages.Message m4 = getInfoPageMessage('Info');
        ApexPages.Message m5 = getWarningPageMessage('Warning');        
    }
}