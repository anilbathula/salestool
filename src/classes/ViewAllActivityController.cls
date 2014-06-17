public with sharing class ViewAllActivityController
{
    private List<ActivityHistory> activityHistoryList;
    private String recordId;
    private String objectType;
    private ActivityHistorySummary summaryObject;
    
    public List<ActivityHistory> ActivityHistories
    {
        get
        {
            loadActivityHistoryObjects();
            
            return activityHistoryList;
        }
        
        set; 
    } 
    
    public ActivityHistorySummary Summary
    {
        get
        {            
            return summaryObject;
        }
        
        set; 
    }        
    
    public Boolean ShowContactDetail
    {
        get
        {
            if(UApp.isValidRecordId(summaryObject.ContactId) == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    } 
    
    public ViewAllActivityController()
    {
        this.recordId = UApp.getQueryStringValue('id');
        this.objectType = UApp.getQueryStringValue('object');        
        
        loadSummary();
    }
    
    private void loadSummary()
    {
        if(objectType.trim().equalsIgnoreCase('Account') == true)
        {
            loadAccountSummary();
        }
        else if(objectType.trim().equalsIgnoreCase('Contact') == true)
        {
            loadContactSummary();
        }
    }
    
    private void loadAccountSummary()
    {
        Account accountRecord = [select Id, Name from Account where Id = :recordId];
        
        this.summaryObject = new ActivityHistorySummary();

        summaryObject.AccountId = accountRecord.Id;        
        summaryObject.Account = accountRecord.Name;            
    }    
    
    private void loadContactSummary()
    {
        Contact contactRecord = [select Id, FirstName, LastName, Account.Id, Account.Name from Contact where Id = :recordId];
        
        this.summaryObject = new ActivityHistorySummary();

        summaryObject.AccountId = contactRecord.Account.Id;        
        summaryObject.Account = contactRecord.Account.Name;
        summaryObject.ContactId = contactRecord.Id;
        summaryObject.FirstName = contactRecord.FirstName;
        summaryObject.LastName = contactRecord.LastName;                
    }
    
    private void loadActivityHistoryObjects()
    {
        if(objectType.trim().equalsIgnoreCase('Account') == true)
        {
            loadAccountActivityHistoryObjects();
        }
        else if(objectType.trim().equalsIgnoreCase('Contact') == true)
        {
            loadContactActivityHistoryObjects();
        }
    }
    
    private void loadAccountActivityHistoryObjects()
    {
        if(activityHistoryList == null)
        {
            activityHistoryList = new List<ActivityHistory>();
        }
        
        String query = 'Select (Select Id, AccountId, WhoId, WhatId, Subject, IsTask, ActivityDate, OwnerId, Status, ActivityType, Description, CreatedDate, CreatedById, LastModifiedDate, Who.Name, Owner.Name From ActivityHistories ah order by ActivityDate DESC, LastModifiedDate DESC limit 500) From ' + objectType + ' where Id = :recordId';
        
        List<Account> records = Database.query(query);
        
        for(Account record : records)
        {
            for(ActivityHistory item : record.ActivityHistories)
            {
                activityHistoryList.add(item);          
            }
        }        
    }
    
    private void loadContactActivityHistoryObjects()
    {
        if(activityHistoryList == null)
        {
            activityHistoryList = new List<ActivityHistory>();
        }
        
        String query = 'Select (Select Id, AccountId, WhoId, WhatId, Subject, IsTask, ActivityDate, OwnerId, Status, ActivityType, Description, CreatedDate, CreatedById, LastModifiedDate, Who.Name, Owner.Name From ActivityHistories ah order by ActivityDate DESC, LastModifiedDate DESC limit 500) From ' + objectType + ' where Id = :recordId';
        
        List<Contact> records = Database.query(query);
        
        for(Contact record : records)
        {
            for(ActivityHistory item : record.ActivityHistories)
            {
                activityHistoryList.add(item);          
            }
        }        
    }
    
    public with sharing class ActivityHistorySummary
    {
        private String accountIdValue;  
        private String accountValue;    
        private String contactIdValue;  
        private String firstNameValue;
        private String lastNameValue; 
        
        public String AccountId
        {
            get
            {
                return accountIdValue;
            }
            
            set
            {
                this.accountIdValue = value;
            }
        }
        
        public String Account
        {
            get
            {
                return accountValue;
            }
            
            set
            {
                this.accountValue = value;
            }
        } 
        
        public String ContactId
        {
            get
            {
                return contactIdValue;
            }
            
            set
            {
                this.contactIdValue = value;
            }
        }
        
        public String FirstName
        {
            get
            {
                return firstNameValue;
            }
            
            set
            {
                this.firstNameValue = value;
            }
        } 
        
        public String LastName
        {
            get
            {
                return lastNameValue;
            }
            
            set
            {
                this.lastNameValue = value;
            }
        }                  
        
        public ActivityHistorySummary()
        {
        
        }    
    }
    
    private static testmethod void testCode()
    {        
        PageReference pageRef = new PageReference('/apex/ViewAllActivity');
        //Test.setCurrentPage(pageRef);        
        ApexPages.currentPage().getParameters().put('object', 'Contact');
        ApexPages.currentPage().getParameters().put('id', [select Id from Contact order by CreatedDate desc limit 1].Id);
            
        ViewAllActivityController avac = new ViewAllActivityController();
        
        List<ActivityHistory> list1 = avac.ActivityHistories;
        ActivityHistorySummary ahs1 = avac.Summary;
        Boolean b1 = avac.ShowContactDetail;       
    }
    
    private static testmethod void testCode2()
    {        
        PageReference pageRef = new PageReference('/apex/ViewAllActivity');
        //Test.setCurrentPage(pageRef);        
        ApexPages.currentPage().getParameters().put('object', 'Account');
        ApexPages.currentPage().getParameters().put('id', [select Id from Account order by CreatedDate desc limit 1].Id);
            
        ViewAllActivityController avac = new ViewAllActivityController();
        
        List<ActivityHistory> list1 = avac.ActivityHistories;
        ActivityHistorySummary ahs1 = avac.Summary;
        Boolean b1 = avac.ShowContactDetail;       
    }    
}