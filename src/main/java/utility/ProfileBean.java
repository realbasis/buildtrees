/*
 * Profile.java
 *
 * Created on August 8, 2008, 9:07 AM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import value.*;
import java.util.LinkedList;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;

/**
 * @author Lamine Ba
 */
public class ProfileBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private TreeBean treeBean;
    
    private PeopleBean peopleBean;
    
    private String errors;
    
    private boolean processed;
    
    public ProfileBean() {
        propertySupport = new PropertyChangeSupport(this);
        
        errors = null;
        treeBean = null;
        peopleBean = null;
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
    
    public PeopleBean getPeopleBean() {
        return peopleBean;
    }
    
    public void setPeopleBean(PeopleBean value) {
        peopleBean = value;
    }
    
    public TreeBean getTreeBean() {
        return treeBean;
    }
    
    public void setTreeBean(TreeBean value) {
        treeBean = value;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public boolean isProcessed() {
        boolean success = true;
        
        SortedMap map = (SortedMap) this.treeBean.getFambypeople().get(this.peopleBean.getPeopleID());
        this.treeBean.setIt(map);
        
        return success;
    }
    
}
