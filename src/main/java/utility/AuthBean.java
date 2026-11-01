/*
 * AuthBean.java
 *
 * Created on June 29, 2008, 8:52 AM
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
public class AuthBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private TreeBean treeBean;
    
    private ConnBean connBean;
    
    private AccountBean accountBean;
    
    private String userOwner;
    
    private String passwordOwner;
    
    private String errors;
    
    private boolean authed;
    
    public AuthBean() {
        propertySupport = new PropertyChangeSupport(this);
        
        treeBean = null;
        connBean = new ConnBean();
        userOwner = "tba";
        // admin (owner) password for admin.jsp, now configurable: admin.password in buildtrees.properties.
        // No built-in default: admin login is disabled until it is set.
        passwordOwner = appconfig.AppConfig.get("admin.password", "\u0000disabled\u0000");
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
    
    public boolean isAuthed() {
        boolean success = true;
        SortedMap map[] = null;
        ArrayList values = null;
        ArrayList valuesLks = null;
        String sqlStrg = null;
        String sqlStrg2 = null;
        String sqlLksStrg = null;
        int size = 0;
        
        success = this.connBean.isStarted();
        if(!success)
            return false;
        
        values = new ArrayList();
        values.add(this.accountBean.getEmail());
        values.add(this.accountBean.getPassword());
        map = this.connBean.select("Select * from Accounts Where Email = ? and Password = ?", values);
        
        if(map == null) {
            errors = "Login failed!";
            return false;
        }
        
        if(map.length != 1) {
            errors = "Login failed!";
            return false;
        }
        
        Integer accountID = (Integer) map[0].get("AccountID");
        this.accountBean.setAccountID(accountID);
        
        String notifyMe = (String) map[0].get("Notify");
        this.accountBean.setNotify(notifyMe);
        
        /***********************/
        
        /*** get array of map of family members under account ***/
        values = new ArrayList();
        values.add(this.accountBean.getAccountID());
        map = this.connBean.select("Select * From Zpeople Where AccountID = ? Order By Name", values);
        this.treeBean.setFamily(map);
        
        // get map of owner
        size = map.length;
        for(int i=0; i<size; i++) {
            String zTitle = (String) map[i].get("Title");
            String zEmail = (String) map[i].get("Email");
            if(zTitle.equals("owner") && zEmail.equals(this.accountBean.getEmail())) {
                Integer Id = (Integer) map[i].get("PeopleID");
                this.treeBean.setPeopleID(Id);
                this.treeBean.setMe((TreeMap) map[i]);
                break;
            }
        }
        
        /*** get array of other famillies sharing space ***/
        values = new ArrayList();
        values.add(this.accountBean.getAccountID());
        values.add(new Integer(2));
        String sqlMsg = "Select Sharers.*, Accounts.Name, Accounts.Email ";
        sqlMsg = sqlMsg + "From Sharers, Accounts Where ";
        sqlMsg = sqlMsg + "Sharers.AccountID = Accounts.AccountID ";
        sqlMsg = sqlMsg + "And MyAccountID = ? ";
        sqlMsg = sqlMsg + "And Sharers.Status = ?";
        map = this.connBean.select(sqlMsg, values);
        this.treeBean.setSharers(map);
        
        // get links from default family
        valuesLks = new ArrayList();
        valuesLks.add(this.accountBean.getAccountID());
        sqlLksStrg = "Select * From Zlinks Where AccountID = ?";
        
        // Obtain list of profiles from your account and member accounts
        int sharersCount = 0;
        if(map != null) {
            sharersCount = map.length;
            values = new ArrayList();
        }
        if(sharersCount == 1) {
            values.add(map[0].get("AccountID"));
            sqlStrg = "Select * From Zpeople Where AccountID = ?";
            
            valuesLks.add(map[0].get("AccountID"));
            sqlLksStrg = sqlLksStrg+" Or AccountID = ?";
        }
        else if(sharersCount > 1) {
            for(int j=0; j<sharersCount; j++) {
                values.add(map[j].get("AccountID"));
                
                valuesLks.add(map[j].get("AccountID"));
                
                if(j==0) {
                    sqlStrg = "Select * From Zpeople Where AccountID = ?";
                    sqlLksStrg = sqlLksStrg+" Or AccountID = ?";
                }
                else {
                    sqlStrg = sqlStrg+" Or AccountID = ?";
                    sqlLksStrg = sqlLksStrg+" Or AccountID = ?";
                }
            }
        }
        
        if(sharersCount > 0) {
            sqlStrg = sqlStrg+" Order By Name";
            map = this.connBean.select(sqlStrg, values);
            // add elements to map family.
            this.treeBean.setFamilyOtro(map);
        }
        
        /*** get array of map of family relationships under account ***/
        map = this.connBean.select(sqlLksStrg, valuesLks);
        this.treeBean.setLinks(map);
        
        /*** build tree maps ***/
        BuildTreeBean btBean = new BuildTreeBean();
        btBean.setTreeBean(this.treeBean);
        
        // organize sharers
        
        // recreate tree
        btBean.isBuilded();
        this.treeBean = btBean.getTreeBean();
        
        success = this.connBean.isClosed();
        
        return success;
    }
    
    public String getPasswordOwner() {
        return passwordOwner;
    }
    
}
