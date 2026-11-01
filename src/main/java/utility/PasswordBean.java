/*
 * PasswordBean.java
 *
 * Created on July 23, 2008, 11:23 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import value.*;
import java.util.SortedMap;
import java.util.ArrayList;

/**
 * @author Lamine Ba
 */
public class PasswordBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer accountID;
    
    private String cpass;
    
    private String pass1;
    
    private String pass2;
    
    private String errors;
    
    private boolean processed;
    
    public PasswordBean() {
        propertySupport = new PropertyChangeSupport(this);
        cpass = null;
        pass1 = null;
        pass2 = null;
        accountID = null;
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
    
    public void setCpass(String value) {
        cpass = value;
    }
    
    public void setPass1(String value) {
        pass1 = value;
    }
    
    public void setPass2(String value) {
        pass2 = value;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public boolean isProcessed() {
        boolean success = true;
        
        SortedMap map[] = null;
        ArrayList values = null;
        
        ConnBean connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            errors = "technical error, try again";
            return false;
        }
        
        values = new ArrayList();
        values.add(this.accountID);
        values.add(this.cpass);
        map = connBean.select("Select * From Accounts Where AccountID = ? And Password = ?", values);
        if(map == null) {
            errors = "invalid current password";
            return false;
        }
        if(map.length != 1) {
            errors = "invalid current password";
            return false;
        }
        
        if(pass1.length() < 6) {
            errors = "password must at least 6 letters long!";
            return false;
        }
        
        if(this.pass1.equals(this.pass2) == false) {
            errors = "Please confirm password!";
            return false;
        }
        
        values = new ArrayList();
        values.add(this.pass1);
        values.add(this.accountID);
        success = connBean.update("Update Accounts Set Password = ? Where AccountID = ?", values);
        if(!success) {
            errors = "technical error, try again";
            return false;
        }
        else
            errors = "password has been changed!";
        success = connBean.isClosed();
        return success;
    }
    
}
