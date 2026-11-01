/*
 * Formulas.java
 *
 * Created on March 4, 2010, 4:23 PM
 */

package api;
import java.util.LinkedList;
import java.util.SortedMap;

/**
 *
 * @author  Lamine Ba
 */
public class Formulas {
    
    /** Creates a new instance of Formulas */
    public Formulas() {
    }
    
    public LinkedList sortList( LinkedList  x ) {
        int i, j;
        SortedMap temp, mapX, mapY;
        String valueX, valueY;

        for ( i = 0;  i < (x.size()-1);  i++ )
            {
                for ( j = i + 1;  j < x.size();  j++ )
                { 
                        mapX = (SortedMap) x.get(i);
                        valueX = (String) mapX.get("Name");
                        mapY = (SortedMap) x.get(j);
                        valueY = (String) mapY.get("Name");
                         if ( valueX.compareToIgnoreCase( valueY ) > 0 )
                          {                                             // ascending sort
                                      temp = mapX;
                                      mapX = mapY;    // swapping
                                      mapY = temp;
                                      
                                      x.set(i, mapX);
                                      x.set(j,mapY);
                           }
                   }
             }
            
        return x;
    }
    
    public boolean sharingLaw(Integer selfAccId, Integer elseAccId, Integer accountId) {
        boolean success = true;
        
        if(selfAccId.intValue() != accountId.intValue()) {
            if(elseAccId.intValue() != accountId.intValue()) {
                success = false;
            }
        }
        
        return success;
    }
    
}
