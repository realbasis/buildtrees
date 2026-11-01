/*
 * AuthorBean.java
 *
 * Created on March 10, 2010, 5:49 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.LinkedList;
import java.util.SortedMap;

/**
 * @author Lamine Ba
 */
public class AuthorBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private SortedMap maps[];
    
    private LinkedList list;
    
    private Integer id;
    
    private String name;
    
    public AuthorBean() {
        propertySupport = new PropertyChangeSupport(this);
        maps = null;
        list = null;
        name = null;
        id = null;
    }
    
    public String getSampleProperty() {
        return sampleProperty;
    }
    
    public void setSampleProperty(String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        propertySupport.firePropertyChange(PROP_SAMPLE_PROPERTY, oldValue, sampleProperty);
    }
    
    
    public void addPropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.addPropertyChangeListener(listener);
    }
    
    public void removePropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.removePropertyChangeListener(listener);
    }
    
    public void setMaps(SortedMap value[]) {
        maps = value;
    }
    
    public void setList(LinkedList value) {
        list = value;
    }
    
    public void setId(Integer value) {
        id = value;
    }
    
    public String getName() {
        SortedMap map = null;
        String value = null;
        int size = 0;
        if(list != null)
            size = list.size();
        
        for(int i=0; i<size; i++) {
            map = (SortedMap) list.get(i);
            Integer list_id = (Integer) map.get("AccountID");
            String list_name = (String) map.get("Title");
            if(list_id.intValue() == this.id.intValue() && list_name.equals("owner")) {
                value = (String) map.get("Name");
                break;
            }
        }
        
        return value;
    }
    
}
