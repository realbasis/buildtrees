/*
 * SearchBean.java
 *
 * Created on March 1, 2007, 11:03 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.LinkedList;

/**
 * @author Lamine Ba
 */
public class SearchBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String[] names;
    
    private int namesSize;
        
    public SearchBean() {
        propertySupport = new PropertyChangeSupport(this);
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
    
    public void setNames(String[] value) {
        names = value;
    }
    
    public int getNamesSize() {
        return this.names.length;
    }
    
}
