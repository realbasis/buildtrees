/*
 * AdminBean.java
 *
 * Created on April 10, 2010, 11:59 AM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import value.*;
import api.Formulas;
import java.util.LinkedList;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;

/**
 * @author tba
 */
public class AdminBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private SortedMap maps[];
    
    private SortedMap accounts[];
    
    private SortedMap people[];
    
    private SortedMap sharers[];
    
    private TreeMap stats[];
    
    private AccountsChart accountsChart;
    
    private PeopleChart peopleChart;
    
    private boolean processed;
    
    private boolean statsCreated;
    
    public AdminBean() {
        propertySupport = new PropertyChangeSupport(this);
        accounts = null;
        people = null;
        stats = null;
        maps = null;
        accountsChart = null;
        peopleChart = null;
        sharers = null;
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
    
    public void setAccounts(SortedMap value[]) {
        accounts = value;
    }
    
    public void setPeople(SortedMap value[]) {
        people = value;
    }
    
    public void setSharers(SortedMap value[]) {
        sharers = value;
    }
    
    public void setAccountsChart(AccountsChart value) {
        accountsChart = value;
    }
    
    public AccountsChart getAccountsChart() {
        return accountsChart;
    }
    
    public void setPeopleChart(PeopleChart value) {
        peopleChart = value;
    }
    
    public PeopleChart getPeopleChart() {
        return peopleChart;
    }

        
    public TreeMap[] getStats() {

        int sizeAccounts = 0;
        int sizePeople = 0;
        int sizeSharers = 0;
        
        if(people != null)
            sizePeople = people.length;
        
        if(accounts != null)
            sizeAccounts = accounts.length;
        
        if(sharers != null)
            sizeSharers = sharers.length;
        
        stats = new TreeMap[sizeAccounts];
        
        for(int i=0; i<sizeAccounts; i++) {
            stats[i] = (TreeMap) accounts[i];
            Integer aid = (Integer) accounts[i].get("AccountID");
            
            LinkedList pList = new LinkedList();
            for(int j=0; j<sizePeople; j++) {
                Integer aid2 = (Integer) people[j].get("AccountID");
                if(aid.intValue() == aid2.intValue()) {
                    pList.addLast(people[j]);
                }
            }
            stats[i].put("Count", (new Integer(pList.size())));
            stats[i].put("People", pList);
            
            LinkedList sList = new LinkedList();
            for(int j=0; j<sizeSharers; j++) {
                Integer aid3 = (Integer) sharers[j].get("MyAccountID");
                if(aid.intValue() == aid3.intValue()) {
                    sList.addLast(sharers[j]);
                }
            }
            stats[i].put("CountSharers", (new Integer(sList.size())));
            stats[i].put("Sharers", sList);
            
            
        }
        
        return stats;
    }
    
    public boolean isStatsCreated() {
        boolean success = true;
        
        this.accountsChart = new AccountsChart();
        success = this.accountsChart.createDataset(this.accounts);
        
        this.peopleChart = new PeopleChart();
        success = this.peopleChart.createDataset(this.people);
        
        return success;
    }
        
}
