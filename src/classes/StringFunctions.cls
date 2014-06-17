public class StringFunctions 
{
    public static String getFormattedDateString(Date dateValue, String format)
    {
        if(dateValue == null)
        {
            return null;
        }       
        
        String year = String.valueOf(dateValue.year());
        String month = String.valueOf(dateValue.month());
        String day = String.valueOf(dateValue.day());
        String[] dateValues = new String[3];
            
        if(format.trim().equalsIgnoreCase('UK') == true)
        {   
            dateValues[0] = day;
            dateValues[1] = month;
            dateValues[2] = year;
        }
        else
        {
            dateValues[0] = month;
            dateValues[1] = day;
            dateValues[2] = year;
        }         
                   
        String stringDate = String.format('{0}/{1}/{2}', dateValues);
        
        return stringDate;
    }
    
    public static String stripCharacters(String value, List<String> charactersToRemove)
    {
        for(String character : charactersToRemove)
        {
            if(value.contains(character) == true)
            {
                value = value.replaceAll(character, '');
            }
        }
    
        return value;
    }
    
    public static String escape(String value, List<String> charactersToEscape)
    {
        for(String character : charactersToEscape)
        {
            if(value.contains(character) == true)
            {
                value = value.replaceAll(character, getEscapeCharacterValue(character));
            }
        }
    
        return value;
    }
    
    public static String escapeURL(String value)
    {       
        Map<String, String> escapeCharacters = getEscapeCharacterMap();    
                
        for(String key : escapeCharacters.keySet())
        {
            if(value.contains(key) == true)
            {
                value = value.replaceAll(key, escapeCharacters.get(key));
            }
        }
    
        return value;
    }   
    
    public static String getEscapeCharacterValue(String character)
    {       
        String returnValue = character;     
        Map<String, String> escapeCharacters = getEscapeCharacterMap();
        
        if(escapeCharacters.containsKey(character) == true)      
        {
            returnValue = escapeCharacters.get(character);          
        }
    
        return returnValue;
    }   
    
    public static Map<String, String> getEscapeCharacterMap()
    {               
        Map<String, String> escapeCharacters = new Map<String, String>(); //Character, Escape Value
        
        escapeCharacters.put('[','%5B');        
        escapeCharacters.put(']','%5D');
        escapeCharacters.put('`','%60');
        escapeCharacters.put(';','%3B');
        escapeCharacters.put('/','%2F');
        //escapeCharacters.put('?','%3F');
        escapeCharacters.put(':','%3A');
        escapeCharacters.put('@','%40');
        escapeCharacters.put('=','%3D');        
        escapeCharacters.put('&','%26');                        
        escapeCharacters.put('$','%24');
        escapeCharacters.put(' ','%20');
        escapeCharacters.put('<','%3C');
        escapeCharacters.put('>','%3E');
        escapeCharacters.put('#','%23');
        escapeCharacters.put('%','%25');
        escapeCharacters.put('{','%7B');
        escapeCharacters.put('}','%7D');
        escapeCharacters.put('|','%7C');
        escapeCharacters.put('\\','%5C');
        escapeCharacters.put('^','%5E');
        escapeCharacters.put('~','%7E');  
        
        return escapeCharacters;
    }
    
    public static String makeSplitableCSVString(String qualifier, String separaterCharacter, String splitCharacter, String data)
    {
        if(UApp.isNullOrEmpty(qualifier) == true)
        {
            qualifier = '';
        }
        
        if(UApp.isNullOrEmpty(separaterCharacter) == true)
        {
            separaterCharacter = ','; //Assume CSV
        }
        
        if(UApp.isNullOrEmpty(splitCharacter) == true)
        {
            splitCharacter = 'Â¦'; //Assume Broken Bar (Alt+0166)
        }
          
        if(UApp.isNullOrEmpty(data) == true)
        {
            return ''; //Send back an empty string
        }                
        
        String returnValue = '';
        String currentCharacter = '';
        Boolean startQuote = false;
        Boolean endQuote = false;
         
        for(Integer i = 0; i < data.trim().length(); i++)
        {
            currentCharacter = data.substring(i, i + 1);

            if(currentCharacter.equals(qualifier) == true)
            {
                if(startQuote == false)
                {
                    startQuote = true;
                    endQuote = false;                    
                }
                else
                {
                    startQuote = false;                
                    endQuote = true;
                }
            }
            else if(currentCharacter.equals(separaterCharacter) == true)
            {
                if(endQuote == true)
                {
                    currentCharacter = splitCharacter;
                }
            }
            else
            {
            
            }
            
            returnValue += currentCharacter;
        }            
         
        return returnValue;
    } 
            
    private static testMethod void testStringFunctions()
    {
        String url = StringFunctions.escape('adb&?def', new String[]{'&'});
        url = StringFunctions.escapeURL('adb&?def');
        String character = StringFunctions.getEscapeCharacterValue('&');
        Map<String, String> escapeCharacterMap = getEscapeCharacterMap();
        stripCharacters('ab-ba', new String[]{'-'});
        String formattedDateString = getFormattedDateString(Date.today(), 'US');        
    }
}