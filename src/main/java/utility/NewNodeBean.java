/*
 * NewNodeBean.java
 *
 * Created on May 10, 2008, 4:07 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import value.*;
import sql.SQLCommandBean;
//import api.Linked;
import java.sql.Connection;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.servlet.jsp.jstl.sql.Result;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.LinkedList;
import java.util.Date;

/**
 * @author Lamine Ba
 */
public class NewNodeBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String relationship;
    
    private SortedMap root;
    
    private SortedMap implant;
    
    private SortedMap person;
    
    private Connection conn = null;
    
    private PeopleBean peopleBn;
    
    private TreeBean treeBean;
    
    private LinkedList linksTable;
    
    private boolean list;
    
    private boolean doUpdate;
    
    private String errors;
    
    private SortedMap fambypeople;
    
    private boolean nodeAdded;
    
    private boolean treeUpdated;
    
    private boolean branchUpdated;
    
    private boolean unlinked;
    
    public NewNodeBean() {
        propertySupport = new PropertyChangeSupport(this);
        person = null;
        root = null;
        implant = null;
        list = false;
        doUpdate = false;
        conn = null;
        treeBean = null;
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
    
    public void setRelationship(String value) {
        relationship = value;
    }
    
    public void setConn(Connection value) {
        this.conn = value;
    }
    
    public void setPerson(SortedMap value) {
        person = value;
    }
    
    public void setRoot(SortedMap value) {
        root = value;
    }
    
    public void setImplant(SortedMap value) {
        implant = value;
    }
    
    public SortedMap getImplant() {
        return implant;
    }
    
    public void setPeopleBn(PeopleBean value) {
        peopleBn = value;
    }
        
    public void setList(boolean value) {
        list = value;
    }
    
    public void setFambypeople(SortedMap value) {
        fambypeople = value;
    }
    
    public boolean getDoUpdate() {
        return doUpdate;
    }
    
    public String getErrors() {
        return errors;
    }
    
    private boolean isLinkAdded(Integer selfID, Integer elseID, String title) {
        boolean success = true;
        SQLCommandBean sqlCommandBean = new SQLCommandBean();
        
        try {
            conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(conn);
            
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO Zlinks ");
            sql.append("(Title, SelfID, ElseID, AccountID) ");
            sql.append("VALUES (?,?,?,?)");
            sqlCommandBean.setSqlValue(sql.toString());

            List values = new ArrayList();
            values.add(title);
            values.add(selfID);
            values.add(elseID);
            values.add(this.peopleBn.getAccountID());
            sqlCommandBean.setValues(values);
            
            int numRows = sqlCommandBean.executeUpdate();
            if (numRows != 1) {
                errors = new String("E31: Link not added");
                return false;
            }
            
        } catch (SQLException e2) {
            errors = new String("E32: addition of link");
            return false;
        }
        
        return success;
    }
    
    public boolean isNodeAdded() {
        boolean success = true;
        SQLCommandBean sqlCommandBean = new SQLCommandBean();

	StringBuffer sql;
        List values;
        Result result;
        SortedMap project[];
        Integer id = null;
        int numRows;
        
        try {
            conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(conn);
            
            sql = new StringBuffer();
            sql.append("INSERT INTO Zpeople ");
            sql.append("(Name, Email, GotBirthdate, Birthdate, IsDeceased, Deceased, ");
            sql.append("Gender, AccountID) ");
            sql.append("VALUES (?,?,?,?,?,?,?,?)");
            sqlCommandBean.setSqlValue(sql.toString());

            values = new ArrayList();
            values.add(peopleBn.getName());
            values.add(peopleBn.getEmail());
            values.add(peopleBn.getGotBirthdate());
            values.add(peopleBn.getBirthdate());
            values.add(peopleBn.getIsDeceased());
            values.add(peopleBn.getDeceased());
            values.add(peopleBn.getGender());
            values.add(peopleBn.getAccountID());
            sqlCommandBean.setValues(values);
            
            numRows = sqlCommandBean.executeUpdate();
            if (numRows != 1) {
                errors = new String("E21: Person not added");
                return false;
            }
            
        } catch (SQLException e21) {
            errors = new String("E21: addition of node");
            return false;
        }
        
        try {
                        
            /*** get people map just created ***/
            sql = new StringBuffer();
            sql.append("Select MAX(PeopleID) from Zpeople");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            if (result.getRowCount() != 1) {
                errors = new String("E22: Record not found");
                return false;
            }
            
            project = result.getRows();
            id = (Integer) project[0].get(project[0].firstKey());
            //id = (Integer) project[0].get("MAX(PeopleID)");
            
        } catch (SQLException e22) {
            errors = new String("E22: addition of node");
            return false;
        }
        
        try {
            /*** get people map just created ***/
            sql = new StringBuffer();
            sql.append("Select * from Zpeople Where PeopleID = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(id);
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            if (result.getRowCount() != 1) {
                errors = new String("E23: Record not found");
                return false;
            }
            
            project = result.getRows();
            this.person = project[0];
            
        } catch (SQLException e23) {
            errors = new String("E23: addition of node");
            return false;
        }
        
        return success;
    }
    
    private String reverseRel() {
        
        if(this.relationship.equals("Father") || this.relationship.equals("Mother")) {
            String gender = (String) root.get("Gender");
            if(gender.equals("Male"))
                return("Son");
            else if(gender.equals("Female"))
                return("Daughter");
            else {
                this.errors = new String("could not identify gender");
                return null;
            }
        }
        
        else if(this.relationship.equals("Brother") || this.relationship.equals("Sister")) {
            String gender = (String) root.get("Gender");
            if(gender.equals("Male"))
                return("Brother");
            else if(gender.equals("Female"))
                return("Sister");
            else {
                this.errors = new String("could not identify gender");
                return null;
            }
        }
            
        else if(this.relationship.equals("Son") || this.relationship.equals("Daughter")) {
            String gender = (String) root.get("Gender");
            if(gender.equals("Male"))
                return("Father");
            else if(gender.equals("Female"))
                return("Mother");
            else {
                this.errors = new String("could not identify gender");
                return null;
            }
        }
        
        else if(this.relationship.equals("Husband_Partner") || this.relationship.equals("Wife_Partner")) {
            String gender = (String) root.get("Gender");
            if(gender.equals("Male"))
                return("Husband_Partner");
            else if(gender.equals("Female"))
                return("Wife_Partner");
            else {
                this.errors = new String("could not identify gender");
                return null;
            }
        }
        
        else {
            this.errors = new String("could not identify relationship");
            return null;
        }
        
    }
    
    private boolean linkExists(Integer selfID, Integer elseID) {

        int size = 0;
        SortedMap map[];
        
        map = this.treeBean.getLinks();
        size = map.length;
        
        if(selfID.intValue() == elseID.intValue())
            return true;
        
        for(int i=0; i<size; i++) {
            Integer id0 = (Integer) map[i].get("SelfID");
            Integer id1 = (Integer) map[i].get("ElseID");
            if(id0.intValue() == selfID.intValue() && id1.intValue() == elseID.intValue()) {
                return true;
            }
        }
       
        return false;
        
    }
    
    private boolean mFather() {
        boolean success = true;
        int size = 0;
        SortedMap familiesMap = null;
        SortedMap peopleMap = null;

        SortedMap rootFamMap = null;
        SortedMap implantFamMap = null;
        
        // Get family from links
        familiesMap = this.treeBean.getFambytitle();
        peopleMap = this.treeBean.getFambypeople();
        
        // get Father ID of root
        Integer rootid = (Integer) this.root.get("PeopleID");
        rootFamMap = (SortedMap) familiesMap.get(rootid);
        Integer rootFatherID = (Integer) rootFamMap.get("Father");
        if(rootFatherID == null)
            return success;
        
        // get Father ID of implant
        Integer implantid = (Integer) this.person.get("PeopleID");
        implantFamMap = (SortedMap) familiesMap.get(implantid);
        Integer implantFatherID = (Integer) implantFamMap.get("Father");
        if(implantFatherID == null)
            return success;
        
        if(rootFatherID.intValue() != implantFatherID.intValue())
            return success;
        
        // Get father Map
        SortedMap fatherMap = null;
        Integer fatherID = rootFatherID;
        fatherMap = (SortedMap) familiesMap.get(fatherID);
        
        // Create children list
        LinkedList listChildren = new LinkedList();
        
        // Get sons
        LinkedList listSons = (LinkedList) fatherMap.get("Son");
        if(listSons == null)
            size = 0;
        else
            size = listSons.size();
        for(int i=0; i<size; i++) {
            listChildren.addLast((Integer) listSons.get(i));
        }
        
        LinkedList listDaughters = (LinkedList) fatherMap.get("Daughter");
        if(listDaughters == null)
            size = 0;
        else
            size = listDaughters.size();
        for(int i=0; i<size; i++) {
            listChildren.addLast((Integer) listDaughters.get(i));
        }
        
        size = listChildren.size();
        for(int i=0; i<size; i++) {
            Integer childID = (Integer) listChildren.get(i);
            for(int j=0; j<size; j++) {
                Integer child2ID = (Integer) listChildren.get(j);
                
                if(linkExists(childID, child2ID) == false) {
                    // add link as sibling
                    String gender = null;
                    
                    gender = (String) ((SortedMap) peopleMap.get(child2ID)).get("Gender");
                    if(gender.equals("Male")) {
                        success = this.updateLinksTable(childID, child2ID, "Brother");
                    }
                    else if(gender.equals("Female")) {
                        success = this.updateLinksTable(childID, child2ID, "Sister");
                    }
                    else {
                       this.errors = new String("Invalid Gender");
                        success = false;
                    }
                    
                    if(success == false)
                        return success;

                    // create reverse link
                    gender = (String) ((SortedMap) peopleMap.get(childID)).get("Gender");
                    if(gender.equals("Male")) {
                        success = this.updateLinksTable(child2ID, childID, "Brother");
                    }
                    else if(gender.equals("Female")) {
                        success = this.updateLinksTable(child2ID, childID, "Sister");
                    }
                    else {
                       this.errors = new String("Invalid Gender");
                        success = false;
                    }
                    
                    if(success == false)
                        return success;
                    
                }
            }
        }
        
        
        return success;
    }
    
    private boolean mMother() {
        boolean success = true;
        int size = 0;
        SortedMap familiesMap = null;
        SortedMap peopleMap = null;

        SortedMap rootFamMap = null;
        SortedMap implantFamMap = null;
        
        // Get family from links
        familiesMap = this.treeBean.getFambytitle();
        peopleMap = this.treeBean.getFambypeople();
        
        // get Father ID of root
        Integer rootid = (Integer) this.root.get("PeopleID");
        rootFamMap = (SortedMap) familiesMap.get(rootid);
        Integer rootMotherID = (Integer) rootFamMap.get("Mother");
        if(rootMotherID == null)
            return success;
        
        // get Father ID of implant
        Integer implantid = (Integer) this.person.get("PeopleID");
        implantFamMap = (SortedMap) familiesMap.get(implantid);
        Integer implantMotherID = (Integer) implantFamMap.get("Mother");
        if(implantMotherID == null)
            return success;
        
        if(rootMotherID.intValue() != implantMotherID.intValue())
            return success;
        
        // Get father Map
        SortedMap motherMap = null;
        Integer motherID = rootMotherID;
        motherMap = (SortedMap) familiesMap.get(motherID);
        
        // Create children list
        LinkedList listChildren = new LinkedList();
        
        // Get sons
        LinkedList listSons = (LinkedList) motherMap.get("Son");
        if(listSons == null)
            size = 0;
        else
            size = listSons.size();
        for(int i=0; i<size; i++) {
            listChildren.addLast((Integer) listSons.get(i));
        }
        
        LinkedList listDaughters = (LinkedList) motherMap.get("Daughter");
        if(listDaughters == null)
            size = 0;
        else
            size = listDaughters.size();
        for(int i=0; i<size; i++) {
            listChildren.addLast((Integer) listDaughters.get(i));
        }
        
        size = listChildren.size();
        for(int i=0; i<size; i++) {
            Integer childID = (Integer) listChildren.get(i);
            for(int j=0; j<size; j++) {
                Integer child2ID = (Integer) listChildren.get(j);
                
                if(linkExists(childID, child2ID) == false) {
                    // add link as sibling
                    String gender = null;
                    
                    gender = (String) ((SortedMap) peopleMap.get(child2ID)).get("Gender");
                    if(gender.equals("Male")) {
                        success = this.updateLinksTable(childID, child2ID, "Brother");
                    }
                    else if(gender.equals("Female")) {
                        success = this.updateLinksTable(childID, child2ID, "Sister");
                    }
                    else {
                       this.errors = new String("Invalid Gender");
                        success = false;
                    }
                    
                    if(success == false)
                        return success;

                    // create reverse link
                    gender = (String) ((SortedMap) peopleMap.get(childID)).get("Gender");
                    if(gender.equals("Male")) {
                        success = this.updateLinksTable(child2ID, childID, "Brother");
                    }
                    else if(gender.equals("Female")) {
                        success = this.updateLinksTable(child2ID, childID, "Sister");
                    }
                    else {
                       this.errors = new String("Invalid Gender");
                        success = false;
                    }
                    
                    if(success == false)
                        return success;
                    
                }
            }
        }
        
        
        return success;
    }
    
    private boolean updateLinksTable(Integer selfID, Integer elseID, String rel) {
        boolean success = true;
        TreeMap map = null;
        
        int size = 0;
        if(this.linksTable == null)
            return false;
        
        // check if link exists
        boolean flag = false;
        size = this.linksTable.size();
        for(int i=0; i<size; i++) {
            map = (TreeMap) this.linksTable.get(i);
            Integer id0 = (Integer) map.get("SelfID");
            Integer id1 = (Integer) map.get("ElseID");
            String title = (String) map.get("Title");
            if(id0.intValue() == selfID.intValue() && id1.intValue() == elseID.intValue() && rel.equals(title)) {
                flag = true;
            }
        }
        
        if(flag == false) {
            map = new TreeMap();
            map.put("SelfID", selfID);
            map.put("ElseID", elseID);
            map.put("Title", rel);
            this.linksTable.addLast(map);
        }
        
        return success;
    }
    
    public boolean isBranchUpdated() {
        boolean success = true;
        
        // open DB connection
        /*
        Linked linked = new Linked();
        success = linked.open();
        
        if(success == false)
            return success;
        
        conn = linked.conn;
        */
        if(conn == null) {
            errors = new String("no dB connection");
            return false;
        }
            
        /*** add new node in database ***/
        if(list == false)
            success = isNodeAdded();
        else {
            Integer id = this.peopleBn.getPeopleID();
            this.person = (SortedMap) this.fambypeople.get(id);
        }
        
        if(success == false)
            return success;
        
        /*** update tree links  ***/
        // create default links
        success = this.isLinkAdded((Integer) root.get("PeopleID"), 
            (Integer) person.get("PeopleID"), this.relationship);
        if(success == false)
            return success;
        
        // create reverse link
        success = this.isLinkAdded((Integer) person.get("PeopleID"), 
            (Integer) root.get("PeopleID"), this.reverseRel());
        if(success == false)
            return success;
        
        return success;
    }
    public boolean isTreeUpdated() {
        boolean success = true;
        
        // update complete tree for father's links - auto
        int size = 0;
        SortedMap fmap[] = null;
        
        this.linksTable = new LinkedList();
        
        /***
        fmap = this.treeBean.getFamily();
        size = fmap.length;
        for(int i=0; i<size; i++) {
            Integer zid = (Integer) fmap[i].get("PeopleID");
            success = mFather(zid);
            success = mMother(zid);
            if(success == false)
                return success;
            
        }
        ***/
        
        /*** update tree ***/
        success = mFather();
        success = mMother();
        
        // update database
        size = this.linksTable.size();
        // set flag doUpdate;
        if(size == 0) {
            this.doUpdate = false;
        }
        else {
            this.doUpdate = true;
            
            for(int i=0; i<size; i++) {
                SortedMap map = (SortedMap) linksTable.get(i);
                Integer id0 = (Integer) map.get("SelfID");
                Integer id1 = (Integer) map.get("ElseID");
                String ref = (String) map.get("Title");
                success = this.isLinkAdded(id0, id1, ref);
            }
        }
        
        return success;
    }
    
    /*
    public boolean isUnlinked() {
        boolean success = true;
        
        SQLCommandBean sqlCommandBean = new SQLCommandBean();

	StringBuffer sql;
        List values;
        Result result;
        SortedMap project[];
        Integer id = null;
        int numRows;
        
        try {
            conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(conn);
            
            sql = new StringBuffer();
            sql.append("Delete From Zlinks Where (SelfID = ? Or ElseID = ?)");
            sqlCommandBean.setSqlValue(sql.toString());

            values = new ArrayList();
            values.add(peopleBn.getPeopleID());
            values.add(peopleBn.getPeopleID());
            sqlCommandBean.setValues(values);
            
            numRows = sqlCommandBean.executeUpdate();
            if (numRows <= 0) {
                errors = new String("E1: NewNodeBean");
                return false;
            }
            
        } catch (SQLException e21) {
            errors = new String("E2: NewNodeBean");
            return false;
        }
        
        return success;
    }
    */
    
}
