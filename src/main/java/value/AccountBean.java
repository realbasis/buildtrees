/*
 * AccountsBean.java
 *
 * Created on June 30, 2008, 6:03 AM
 */

package value;

import java.beans.*;
import java.io.Serializable;

/**
 * @author Lamine Ba
 */
public class AccountBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer accountID;
    
    private String name;
    
    private String email;
    
    private String password;
    
    private String notify;
    
    public AccountBean() {
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
    
    public void setAccountID(Integer value) {
        accountID = value;
    }
    
    public Integer getAccountID() {
        return accountID;
    }
    
    public void setName(String value) {
        name = value;
    }
    
    public String getName() {
        return name;
    }
    
    public void setEmail(String value) {
        email = value;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setPassword(String value) {
        password = value;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getNotify() {
        return notify;
    }
    
    public void setNotify(String value) {
        notify = value;
    }
    
}
