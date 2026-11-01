/*
 * SharersBean.java
 *
 * Created on February 12, 2010, 8:36 PM
 */

package value;

import java.beans.*;
import java.io.Serializable;

/**
 * @author Lamine Ba
 */
public class SharersBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer accountID;
    
    private Integer myAccountID;
    
    private Integer status;
    
    public SharersBean() {
        propertySupport = new PropertyChangeSupport(this);
        accountID = null;
        myAccountID = null;
        status = null;
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
    
    public Integer getStatus() {
        return status;
    }
    
    public void setStatus(Integer value) {
        status = value;
    }
    
    public Integer getAccountID() {
        return accountID;
    }
    
    public void setAccountID(Integer value) {
        accountID = value;
    }
    
    public Integer getMyAccountID() {
        return myAccountID;
    }
    
    public void setMyAccountID(Integer value) {
        myAccountID = value;
    }
    
}
