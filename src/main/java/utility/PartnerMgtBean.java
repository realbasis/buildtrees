/*
 * PartnerMgtBean.java
 *
 * Created on August 14, 2008, 6:14 AM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.SortedMap;
import java.util.LinkedList;
import value.*;

/**
 * @author Lamine Ba
 */
public class PartnerMgtBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private TreeBean treeBean;
    
    private int size;
    
    public PartnerMgtBean() {
        propertySupport = new PropertyChangeSupport(this);
        size = 0;
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
    
    public TreeBean getTreeBean() {
        return treeBean;
    }
    
    public void setTreeBean(TreeBean value) {
        treeBean = value;
    }
    
    public int getSize() {
        return(this.treeBean.getPartners().size());
    }
    
}
