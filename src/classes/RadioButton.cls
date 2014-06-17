public class RadioButton {

    public PageReference Search() {
        return null;
    }

  string yes=null;
  string no=null;
    
    
    public list<SelectOption> getItems(){
        List<selectOption> options=new List<selectOption>();
        options.add(new SelectOption('Yes','Yes')); 
         options.add(new SelectOption('no','no'));       
        return options;
    }
          
    public PageReference test() {
        return null;
    }
   public String getYes(){     
        return Yes;
   }
   public String getNo(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('US','US'));
        return No;
   }
   public void setYes(String yes){this.Yes='india';}
   
   
    
    
}