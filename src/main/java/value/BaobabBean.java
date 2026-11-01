/*
 * BaobabBean.java
 *
 * Created on January 18, 2011, 12:10 PM
 */

package value;

import java.beans.*;
import java.io.Serializable;

import java.util.TreeMap;
import java.util.SortedMap;
import java.util.LinkedList;

/**
 * @author tba
 */
public class BaobabBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer peopleID;
    
    private SortedMap accountsMaps[];
    
    private SortedMap peopleMaps[];
    
    private SortedMap peopleMap;
    
    private SortedMap linksMaps[];
    
    private SortedMap familyMap;
    
    int peopleSize;
    
    int linksSize;
    
    public BaobabBean() {
        propertySupport = new PropertyChangeSupport(this);
        peopleID = null;
        peopleSize = 0;
        linksSize = 0;
        peopleMaps = null;
        linksMaps = null;
        familyMap = null;
        accountsMaps = null;
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
    
    public SortedMap getPeopleMap() {
        this.peopleMap = (SortedMap) this.familyMap.get(this.peopleID);
        return peopleMap;
    }
    
    public SortedMap[] getAccountsMaps() {
        return accountsMaps;
    }
    
    public void setAccountsMaps(SortedMap value[]) {
        accountsMaps = value;
    }
    
    public SortedMap[] getPeopleMaps() {
        return peopleMaps;
    }
    
    public void setPeopleMaps(SortedMap value[]) {
        peopleMaps = value;
    }
    
    public int getPeopleSize() {
        return peopleSize;
    }
    
    public void setPeopleSize(int value) {
        peopleSize = value;
    }
    
    public SortedMap[] getLinksMaps() {
        return linksMaps;
    }
    
    public void setLinksMaps(SortedMap value[]) {
        linksMaps = value;
    }
    
    public int getLinksSize() {
        return linksSize;
    }
    
    public void setLinksSize(int value) {
        linksSize = value;
    }
    
    public SortedMap getFamilyMap() {
        return familyMap;
    }
    
    public void setFamilyMap(SortedMap value) {
        familyMap = value;
    }
    
    public Integer getPeopleID() {
        return peopleID;
    }
    
    public void setPeopleID(Integer value) {
        peopleID = value;
    }
    
}
