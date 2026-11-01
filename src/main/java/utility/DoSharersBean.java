/*
 * DoSharersBean.java
 *
 * Created on February 12, 2010, 8:41 PM
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
public class DoSharersBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private SharersBean sharersBean;
    
    private ArrayList items;
    
    private String msg;
    
    private String errors;
    
    private boolean invited;
    
    public DoSharersBean() {
        propertySupport = new PropertyChangeSupport(this);
        sharersBean = null;
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
    
    public SharersBean getSharersBean() {
        return sharersBean;
    }
    
    public void setSharersBean(SharersBean value) {
        sharersBean = value;
    }
    
    public ArrayList getItems() {
        return items;
    }
    
    public String getMsg() {
        return msg;
    }
        
    public boolean isInvited() {
        boolean success = true;
        
        SortedMap map[] = null;
        ArrayList values = null;
        String sqlMsg = null;
        ConnBean connBean = null;
        
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success)
            return false;
        
        values = new ArrayList();
        values.add(this.sharersBean.getMyAccountID());
        values.add(this.sharersBean.getAccountID());
        values.add(this.sharersBean.getStatus());
        
        // 1st pair
        sqlMsg = new String("INSERT INTO Sharers (MyAccountID, AccountID, Status) Values (?,?,?)");
        success = connBean.update(sqlMsg, values);
        if(!success) {
            connBean.isClosed();
            return false;
        }
        
        // reverse pair
        sqlMsg = new String("INSERT INTO Sharers (AccountID, MyAccountID, Status) Values (?,?,?)");
        success = connBean.update(sqlMsg, values);
        if(!success) {
            connBean.isClosed();
            return false;
        }
        
        success = connBean.isClosed();
        return success;
    }
    
}
