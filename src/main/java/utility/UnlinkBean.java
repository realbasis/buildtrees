/*
 * UnlinkBean.java
 *
 * Created on July 12, 2008, 5:24 PM
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
public class UnlinkBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private ConnBean connBean;
    
    private PeopleBean peopleBean;
    
    private TreeBean treeBean;
    
    private ArrayList values;
    
    private String msg;
    
    private String errors;
    
    private boolean processed;
    
    public UnlinkBean() {
        propertySupport = new PropertyChangeSupport(this);
        peopleBean = null;
        treeBean = null;
        connBean = null;
        errors = null;
        msg = null;
        values = null;
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
    
    public ConnBean getConnBean() {
        return connBean;
    }
    
    public void setConnBean(ConnBean value) {
        connBean = value;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public ArrayList getValues() {
        return values;
    }
    
    public String getMsg() {
        return msg;
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
    
    public boolean isProcessed() {
        boolean success = true;
        
        ArrayList values = null;
	String query = null;
        SortedMap map[] = null;
        String sqlMsg = null;
        
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // get me
        SortedMap me = this.treeBean.getMe();
        Integer meID = (Integer) me.get("PeopleID");
        
if(false) {
    
        // check if bridge exists
        values = new ArrayList();
        values.add(meID);
        values.add(this.peopleBean.getPeopleID());
        query = "SELECT * FROM Zlinks Where SelfID = ? And ElseID = ? And OtherID > 0";
        map = connBean.select(query, values);
        if(map == null) {
            this.errors = "unlink1";
            return false;   // error
        }
            
        if(map.length == 1) {
            // there is a bridge
            SortedMap bridgeMap = map[0];

            // check if other corresponding bridges exist
            values = new ArrayList();
            values.add((Integer) bridgeMap.get("AccountID"));
            values.add((Integer) bridgeMap.get("ElseID"));
            values.add((Integer) bridgeMap.get("OtherID"));
            values.add((Integer) bridgeMap.get("SelfID"));
            query = "SELECT * FROM Zlinks Where ";
            query = query + "AccountID = ? And ElseID = ? And OtherID = ? And SelfID != ?";
            map = connBean.select(query, values);
            if(map == null) {
                this.errors = "unlink3";
                return false;   // error
            }
            
            if(map.length == 0) {
                // delete bridges to owner
                // define ownerMap 
                SortedMap ownerMap = this.treeBean.getOwner();
                values = new ArrayList();
                values.add(new Integer(-1));
                values.add((Integer) ownerMap.get("PeopleID"));
                values.add((Integer) ownerMap.get("AccountID"));
                query = "Update Zlinks Set OtherID = ? Where ";
                query = query + "OtherID = ? And AccountID != ?";
                success = connBean.update(query,values);
            }
        }
}
        // delete links
        values = new ArrayList();
        values.add(this.peopleBean.getPeopleID());
        values.add(meID);
        values.add(meID);
        values.add(this.peopleBean.getPeopleID());
        sqlMsg = "Delete From Zlinks Where (SelfID = ? And ElseID = ?) Or ";
        sqlMsg = sqlMsg +"(SelfID = ? And ElseID = ?)"; 
        connBean.update(sqlMsg, values);

/***
        this.restartTree();
        map = connBean.select("Select * From Zpeople Where AccountID = ? Order By Name", values);
        this.treeBean.setFamily(map);
        map = connBean.select("Select * From Zlinks Where AccountID = ?", values);
        this.treeBean.setLinks(map);
****/        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        this.treeBean = btrBean.getTreeBean();
        
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }

        return success;
    }
    
    private void restartTree() {

        //peopleID = -1;
        this.treeBean.setFather(null);
        this.treeBean.setMother(null);
        
        this.treeBean.setSiblings(new LinkedList());
        this.treeBean.setChildren(new LinkedList());
        this.treeBean.setPartners(new LinkedList());
        this.treeBean.setFriends(new LinkedList());
        
        this.treeBean.setNumSiblings(0);
        this.treeBean.setNumPartners(0);
        this.treeBean.setNumChildren(0);
        
        this.treeBean.setFamily(null);
        this.treeBean.setLinks(null);
        this.treeBean.setFambypeople(new TreeMap());
        this.treeBean.setFambytitle(new TreeMap());
        
    }
    
}
