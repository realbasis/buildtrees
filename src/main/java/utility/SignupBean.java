/*
 * SignupBean.java
 *
 * Created on July 25, 2008, 3:35 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import value.*;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;

/**
 * @author Lamine Ba
 */
public class SignupBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private TreeBean treeBean;
    
    private ConnBean connBean;
    
    private AccountBean accountBean;
    
    private boolean processed;
    
    private String errors;
    
    public SignupBean() {
        propertySupport = new PropertyChangeSupport(this);
        
        treeBean = null;
        connBean = new ConnBean();
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
    
    public void setTreeBean(TreeBean value) {
        treeBean = value;
    }
    
    public TreeBean getTreeBean() {
        return treeBean;
    }
    
    public void setConnBean(ConnBean value) {
        connBean = value;
    }
    
    public ConnBean getConnBean() {
        return connBean;
    }
    
    public void setAccountBean(AccountBean value) {
        accountBean = value;
    }
    
    public AccountBean getAccountBean() {
        return accountBean;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public boolean isProcessed() {
        boolean success = true;
        
        
        
        return success;
    }
    
}
