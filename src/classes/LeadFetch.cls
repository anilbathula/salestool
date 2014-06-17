public class LeadFetch{
   private Integer size =0;
   public List<Lead> leadList {get; set;}
   public List<Lead> leadListdisp {get; set;}
   
   public LeadFetch(){
       leadListdisp = new List<Lead>();
       leadListdisp = getLeads();
   }
   
   public List<Lead> getLeads(){
       leadList = new List<Lead>();
       leadList = [Select Id, Name, Company From Lead Limit 50  OFFSET :Size];
       return leadList; 
   }
   
   public void loadMore(){
       size = leadListdisp.size();
       leadList = getLeads();
       leadListdisp.addAll(leadList);
   }
   
}