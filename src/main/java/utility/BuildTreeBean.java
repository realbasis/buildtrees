/*
 * BuildTreeBean.java
 *
 * Created on April 20, 2008, 3:14 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.LinkedList;
import java.util.TreeMap;
import java.util.SortedMap;
import java.util.Date;
import java.sql.Connection;
import sql.SQLCommandBean;
import javax.servlet.jsp.jstl.sql.Result;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import value.*;

/**
 * @author Lamine Ba
 */
public class BuildTreeBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private TreeBean treeBean;
    
    private PeopleBean peopleBean;
    
    private ConnBean connBean;
    
    private String errors;
    
    private String relationship;
    
    private String out;
    
    private boolean builded;
    
    private boolean profileChanged;
    
    private boolean bridged;
    
    private boolean restarted;
    
    private boolean ownerSelected;
    
    public BuildTreeBean() {
        propertySupport = new PropertyChangeSupport(this);
        errors = null;
        relationship = null;
        peopleBean = null;
        out = null;
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
    
    public String getErrors() {
        return errors;
    }
    
    public String getRelationship() {
        return relationship;
    }
    
    public void setRelationship(String value) {
        relationship = value;
    }
    
    public void setPeopleBean(PeopleBean value) {
        peopleBean = value;
    }
    
    public PeopleBean getPeopleBean() {
        return peopleBean;
    }
    
    public String getOut() {
        return out;
    }

    public boolean isProfileChanged() {
        boolean success = true;
        
        success = isResetted();
        
        TreeMap fambypeople = this.treeBean.getFambypeople();
        TreeMap tMap = null;
        tMap = (TreeMap) fambypeople.get(this.treeBean.getPeopleID());
        if(tMap == null)
            tMap = null;
        
        this.treeBean.setMe( tMap );
        
        success = isBuilded();
        
        return success;
    }
    
    public boolean isBridged() {
        boolean success = true;
        ArrayList values = null;
        
        success = isResetted();
        
        int accountID = this.peopleBean.getAccountID().intValue();
        TreeMap fambypeople = this.treeBean.getFambypeople();
        
        // get map
        this.connBean = new ConnBean();
        success = connBean.isStarted();
        values = new ArrayList();
        values.add(this.peopleBean.getPeopleID());
        SortedMap map[] = null;
        map = connBean.select("Select * From Zpeople Where PeopleID = ?", values);
        if(map == null || map.length != 1)
            return false;
        TreeMap tMap = (TreeMap) map[0];
        
        this.out = new String("/zotree.jsp");
        int accountID2 = ((Integer) tMap.get("AccountID")).intValue();
        if(accountID == accountID2) {
            this.out = new String("/zmain.jsp");    
        }
        
        this.treeBean.setMe( tMap );
        
        values = null;
        values = new ArrayList();
        values.add((Integer) tMap.get("AccountID"));
        map = connBean.select("Select * From Zpeople Where AccountID = ? Order By Name", values);
        this.treeBean.setFamily(map);
        
        values = new ArrayList();
        values.add((Integer) tMap.get("AccountID"));
        map = connBean.select("Select * From Zlinks Where AccountID = ?", values);
        this.treeBean.setLinks(map);
        
        success = connBean.isClosed();
        
        success = isBuilded();
        
        return success;
    }

    public boolean isResetted() {
        boolean success = true;     // reset all parameters
        
        this.treeBean.setMe(new TreeMap());
        this.treeBean.setFather(null);
        this.treeBean.setMother(null);
        
        this.treeBean.setSiblings(new LinkedList());
        this.treeBean.setChildren(new LinkedList());
        this.treeBean.setPartners(new LinkedList());
        this.treeBean.setFriends(new LinkedList());
        
        this.treeBean.setNumSiblings(0);
        this.treeBean.setNumPartners(0);
        this.treeBean.setNumChildren(0);
        
        return success;
    }
    
    public boolean isBuilded() {
        boolean success = true;
        
        // create maps of people profiles keyed by people ID - fambypeople and 
        // create maps of people links keyed by people ID - fambytitle
        success = buildFambypeople();
        
        /*** create family lists ***/
        success = famListCreated();
        
        /*** combine default family and other families ***/
        success = combineFamilies();
        
        return success;
    }
    
    private boolean combineFamilies() {
        boolean success = true;
        
        SortedMap zFamily[] = null;
        SortedMap zFamilyOther[] = null;
        SortedMap zFamilyAll[] = null;
        int sizeFamily = 0;
        int sizeOther = 0;
        LinkedList list = null;
        
        
        zFamily = this.treeBean.getFamily();
        zFamilyOther = this.treeBean.getFamilyOtro();
        
        list = new LinkedList();
        
        if(zFamily != null)
            sizeFamily = zFamily.length;
        if(zFamilyOther != null)
            sizeOther = zFamilyOther.length;
        
        for(int i=0; i<sizeFamily; i++) {
            list.addLast(zFamily[i]);
        }
        for(int i=0; i<sizeOther; i++) {
            zFamilyOther[i].put("Title", "other");
            list.addLast(zFamilyOther[i]);
        }
        
        //zFamilyAll = (SortedMap[]) list.toArray();
        // order list by name
        list = sortList(list);
        this.treeBean.setFamilyAll(list);
        
        return success;
    }
    
    public LinkedList sortList( LinkedList  x )
      {
            int i, j;
            SortedMap temp, mapX, mapY;
            String valueX, valueY;

            for ( i = 0;  i < (x.size()-1);  i++ )
            {
                for ( j = i + 1;  j < x.size();  j++ )
                { 
                        mapX = (SortedMap) x.get(i);
                        valueX = (String) mapX.get("Name");
                        mapY = (SortedMap) x.get(j);
                        valueY = (String) mapY.get("Name");
                         if ( valueX.compareToIgnoreCase( valueY ) > 0 )
                          {                                             // ascending sort
                                      temp = mapX;
                                      mapX = mapY;    // swapping
                                      mapY = temp;
                                      
                                      x.set(i, mapX);
                                      x.set(j,mapY);
                           }
                   }
             }
            
            return x;
      } 
    
    private boolean buildFambypeople() {
        boolean success = true;
        int size = 0;
        int size2 = 0;
        SortedMap xMap[] = null;
        TreeMap fambypeople = new TreeMap();
        TreeMap fambytitle = new TreeMap();
        
        // build fambytitle
        SortedMap[] zMaps = this.treeBean.getLinks();
        size2 = zMaps.length;
        
        xMap = this.treeBean.getFamily();
        if(xMap != null)
            size = xMap.length;
        for(int i=0; i<size; i++) {
            Integer id = (Integer) xMap[i].get("PeopleID");
            
            // build fambypeople
            fambypeople.put(id, xMap[i]);
            
            // add map of owner
            String titleStrg = (String) xMap[i].get("Title");
            if(titleStrg.equals("owner"))
                this.treeBean.setOwner(xMap[i]);
            
            TreeMap map = new TreeMap();
            for(int j=0; j<size2; j++) {
                Integer selfID = (Integer) zMaps[j].get("SelfID");
                if(id.intValue() == selfID.intValue()) {
                    Integer elseID = (Integer) zMaps[j].get("ElseID");
                    String title = (String) zMaps[j].get("Title");
                    if(title.equals("Father") || title.equals("Mother")) {
                        // no need to create a list
                        map.put(title, elseID);
                    }
                    else {
                        // check if title already exists
                        if(map.get(title) == null) {
                            LinkedList list = new LinkedList();
                            list.addLast(elseID);
                            map.put(title, list);
                        }
                        else {
                            LinkedList list = (LinkedList) map.get(title);
                            list.addLast(elseID);
                            map.put(title, list);
                        }
                    }
                    
                }
            }
            
            fambytitle.put(id, map);
        }
        
        // Do the same thing with familyOtro
        xMap = this.treeBean.getFamilyOtro();
        if(xMap == null)
            size = 0;
        else
            size = xMap.length;
        for(int i=0; i<size; i++) {
            Integer id = (Integer) xMap[i].get("PeopleID");
            
            // build fambypeople
            fambypeople.put(id, xMap[i]);
            
            TreeMap map = new TreeMap();
            for(int j=0; j<size2; j++) {
                Integer selfID = (Integer) zMaps[j].get("SelfID");
                if(id.intValue() == selfID.intValue()) {
                    Integer elseID = (Integer) zMaps[j].get("ElseID");
                    String title = (String) zMaps[j].get("Title");
                    if(title.equals("Father") || title.equals("Mother")) {
                        // no need to create a list
                        map.put(title, elseID);
                    }
                    else {
                        // check if title already exists
                        if(map.get(title) == null) {
                            LinkedList list = new LinkedList();
                            list.addLast(elseID);
                            map.put(title, list);
                        }
                        else {
                            LinkedList list = (LinkedList) map.get(title);
                            list.addLast(elseID);
                            map.put(title, list);
                        }
                    }
                    
                }
            }
            
            fambytitle.put(id, map);
        }
        
        this.treeBean.setFambypeople(fambypeople);
        this.treeBean.setFambytitle(fambytitle);
        
        return success;
    }
    
    // procedure for tree on display
    public boolean famListCreated() {
        boolean success = true;
        int size = 0;
        SortedMap map = null;
        
        // get fam by people
        TreeMap fambypeople = this.treeBean.getFambypeople();
        
        // process links
        SortedMap[] zMaps = this.treeBean.getLinks();
        if(zMaps != null)
            size = zMaps.length;
        for(int i=0; i<size; i++) {
            int selfID = ((Integer) zMaps[i].get("SelfID")).intValue();
            int otherID = ((Integer) zMaps[i].get("OtherID")).intValue();
            String title = (String) zMaps[i].get("Title");
            
            TreeMap meMap = this.treeBean.getMe();
            int xpeopleID = ((Integer) meMap.get("PeopleID")).intValue();
            TreeMap thisMap = null;
            
            if(selfID == xpeopleID) {
                // classify map FATHER * MOTHER ...
                Integer elseID = (Integer) zMaps[i].get("ElseID");
                int index = ((Integer) this.treeBean.titleMap.get(title)).intValue();
                if(index == TreeBean.FATHER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    this.treeBean.setFather( thisMap );
                }
                else if(index == TreeBean.MOTHER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    this.treeBean.setMother( thisMap );
                }
                else if(index == TreeBean.BROTHER || index == TreeBean.SISTER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    
                    LinkedList siblings = this.treeBean.getSiblings();
                    //*** siblings.addLast( thisMap );
                    siblings = this.addInOrder(siblings, thisMap);
                    this.treeBean.setSiblings(siblings);
                }
                else if(index == TreeBean.SON || index == TreeBean.DAUGHTER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    
                    LinkedList children = this.treeBean.getChildren();
                    //*** children.addLast( thisMap );
                    children = this.addInOrder(children, thisMap);
                    this.treeBean.setChildren(children);
                }
                else if(index == TreeBean.WIFE_PARTNER || index == TreeBean.HUSBAND_PARTNER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    
                    LinkedList partners = this.treeBean.getPartners();
                    partners.addLast( thisMap );
                    this.treeBean.setPartners(partners);
                }
                else if(index == TreeBean.GIRLFRIEND || index == TreeBean.BOYFRIEND) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    if(otherID > 0)
                        thisMap.put("OtherID", new Integer(otherID));
                    
                    LinkedList friends = this.treeBean.getFriends();
                    friends.addLast( thisMap );
                    this.treeBean.setFriends(friends);
                }
                
            }
        }
        
        return success;
    }
    
    private LinkedList addInOrder(LinkedList list, TreeMap map) {
        int size = 0;
        boolean insertion = false;
        
        Date bday = (Date) map.get("Birthdate");
        size = list.size();
        if(size == 0) {
            list.addLast(map);
            insertion = true;
        }
        
        for(int i=0; i<size; i++){
            Date refday = (Date) ((TreeMap) list.get(i)).get("Birthdate");
            if(bday.before(refday) == true) {
                list.add(i, map);
                insertion = true;
                break;
            }
        }
        
        if(insertion == false)
            list.addLast(map);
        
        return list;
    }
    
    /*
    public boolean isRestarted() {
        boolean success = true;
        
        errors = null;
        //peopleID = -1;
        father = null;
        mother = null;
        
        siblings = new LinkedList();
        children = new LinkedList();
        partners = new LinkedList();
        
        numSiblings = 0;
        numPartners = 0;
        numChildren = 0;
        
        family = null;
        links = null;
        fambypeople = new TreeMap();
        fambytitle = new TreeMap();
        
        // get family
        SQLCommandBean sqlCommandBean = new SQLCommandBean();
        
        try {
            
            this.connBn.conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(this.connBn.conn);
            
            StringBuffer sql;
            List values;
            Result result;
            int numRows;
            
            // update family map
            sql = new StringBuffer();
            sql.append("Select * From Zpeople Where AccountID = ? Order By Name");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(((Integer) this.me.get("AccountID")));
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            
            this.family = result.getRows();
            
            // update links map
            // get people map just created
            sql = new StringBuffer();
            sql.append("Select * From Zlinks Where AccountID = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(((Integer) this.me.get("AccountID")));
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
                        
            this.links = result.getRows();
            
        } catch (SQLException e2) {
            errors = new String("E03: addition of node failed");
            return false;
        }
        
        success = this.isBuilded();
        
        return success;
    }
     */
    
    public boolean isOwnerSelected() {
        boolean success = true;
        int size = 0;
        SortedMap map[] = this.treeBean.getFamily();
        size = map.length;
        
        for(int i=0; i<size; i++) {
            String title = (String) map[i].get("Title");
            if(title.equals("owner")) {
                this.treeBean.setMe((TreeMap) map[i]);
                return success;
            }
        }
        
        return false;
    }

}
