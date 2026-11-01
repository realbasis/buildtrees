/*
 * SaveNodeBean.java
 *
 * Created on July 12, 2008, 8:41 PM
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
public class NodeBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private ConnBean connBean;
    
    private PeopleBean peopleBean;
    
    private TreeBean treeBean;
    
    private ArrayList values;
    
    private String msg;
    
    private String errors;
    
    private boolean deleted;
    
    private boolean imgDeleted;
    
    private boolean saved;
    
    private boolean added;
    
    private boolean branchUpdated;
    
    private boolean emailChecked;
    
    private boolean bridgeChecked;
    
    private boolean profileChecked;
    
    private boolean sharersChanged;
    
    public NodeBean() {
        propertySupport = new PropertyChangeSupport(this);
        peopleBean = null;
        treeBean = null;
        connBean = null;
        errors = null;
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
    
    public ArrayList getValues() {
        return values;
    }
    
    public String getMsg() {
        return msg;
    }
    
    public boolean isDeleted() {
        boolean success = true;
        
        ArrayList values = null;
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // get me and delete links associated
        SortedMap me = this.treeBean.getMe();
        Integer meID = (Integer) me.get("PeopleID");
        
        values = new ArrayList();
        values.add(meID);
        values.add(meID);
        connBean.update("Delete From Zlinks Where (SelfID = ? Or ElseID = ?)", values);
        
        // Delete node
        values = new ArrayList();
        values.add(meID);
        connBean.update("Delete From Zpeople Where PeopleID = ?", values);
        
        // Set me as owner
        this.treeBean.setMe((TreeMap) this.treeBean.getOwner());
        
        // recreate tree
        this.restartTree();
        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
        
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }

        
        return success;
    }
    
    public boolean isImgDeleted() {
        boolean success = true;
        
        ArrayList values = null;
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // Delete image
        TreeMap me = null;
        me = this.treeBean.getMe();
        Integer meID = (Integer) me.get("PeopleID");
        
        Integer itID = (Integer) this.treeBean.getIt().get("PeopleID");
        values = new ArrayList();
        values.add("none");
        values.add(null);
        values.add(itID);
        String query = new String("Update Zpeople Set ");
        query = query.concat("ImageName = ?, ");
        query = query.concat("Image = ? ");
        query = query.concat("Where PeopleID = ?");
        success = connBean.update(query, values);
        
        // recreate tree
        this.restartTree();

        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
        
        // get new me
        SortedMap pMap = this.treeBean.getFambypeople();
        me = (TreeMap) pMap.get(meID);
        // get new it
        SortedMap it = this.treeBean.getIt();
        it.put("Image", null);
        it.put("ImageName", "none");
        
        // set me and it
        this.treeBean.setMe(me);
        this.treeBean.setIt(it);
        
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }
        
        return success;
    }
    
    public boolean isImgSaved() {
        boolean success = true;
        
        ArrayList values = null;
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // Update image
        TreeMap me = null;
        Integer meID = (Integer) this.treeBean.getMe().get("PeopleID");
        Integer peopleID = (Integer) this.treeBean.getIt().get("PeopleID");
        
        // update tree
        values = new ArrayList();
        values.add(this.peopleBean.getImageName());
        values.add(this.peopleBean.getImage());
        values.add(peopleID);
        String query = new String("UPDATE Zpeople Set ImageName=?, Image=? Where PeopleID=?");
        success = connBean.update(query, values);
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // recreate tree
        this.restartTree();
        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
        
        // get new me
        SortedMap pMap = this.treeBean.getFambypeople();
        me = (TreeMap) pMap.get(meID);
        // get new it
        SortedMap it = this.treeBean.getIt();
        it.put("Image", this.peopleBean.getImage());
        it.put("ImageName", this.peopleBean.getImageName());
        
        // set me and it
        this.treeBean.setMe(me);
        this.treeBean.setIt(it);
        
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }

        
        return success;
    }
    
    public boolean isAdded() {

        boolean success = true;
        ArrayList values = null;
        String query = null;
        
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success)
            return false;
        
        // get selfID
        Integer selfID = (Integer) ((TreeMap) this.treeBean.getMe()).get("PeopleID");
        
        
        String isProfile = new String();
        isProfile="no";

        //  new node in database?
        Integer elseID = this.getPeopleBean().getPeopleID();
        SortedMap gMap[] = null;
        
        if(elseID.intValue() == -1) {
            // record new person in tree
            values = new ArrayList();
            values.add(this.getPeopleBean().getName());
            values.add(this.getPeopleBean().getEmail());
            values.add(this.getPeopleBean().getGotBirthdate());
            values.add(this.getPeopleBean().getBirthdate());
            values.add(this.getPeopleBean().getIsDeceased());
            values.add(this.getPeopleBean().getDeceased());
            values.add(this.getPeopleBean().getGender());
            values.add(isProfile);
            values.add(this.getPeopleBean().getAccountID());
            
            query = new String("INSERT INTO Zpeople ");
            query = query+"(Name, Email, GotBirthdate, Birthdate, IsDeceased, Deceased, ";
            query = query+"Gender, IsProfile, AccountID) ";
            query = query+"VALUES (?,?,?,?,?,?,?,?,?)";
            
            success = connBean.update(query, values);
            if(!success) {
                connBean.isClosed();
                return false;
            }
            
            // get elseID
            gMap = connBean.select("Select * from Zpeople Order By PeopleID Desc Limit 1", new ArrayList());
            if(gMap == null) {
                connBean.isClosed();
                return false;
            }
            elseID = (Integer) gMap[0].get(gMap[0].firstKey());
            this.peopleBean.setPeopleID(elseID);
                        
        }
        
        //SortedMap pMap = this.treeBean.getFambypeople();
        this.treeBean.setMe((TreeMap) gMap[0]);
        
        // recreate tree
        this.restartTree();
        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        //success = btrBean.isResetted();
        //btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
            
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }
        
        return success;
    
    }
    public boolean isSaved() {
        boolean success = true;
        
        ArrayList values = null;
        String query = null;
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // check email is unique
        success = this.isEmailChecked();
        if(!success)
            return success;

        String isProfile = new String();
        if(this.isProfileChecked() == false)
            isProfile="no";
        else
            isProfile="yes";
        
        // get me map
        TreeMap me = null;
        Integer meID = (Integer) this.treeBean.getMe().get("PeopleID");
        Integer peopleID = (Integer) this.treeBean.getIt().get("PeopleID");
        
        // update tree
        values = new ArrayList();
        values.add(this.peopleBean.getName());
        //values.add(this.peopleBean.getEmail());
        values.add(this.peopleBean.getGotBirthdate());
        values.add(this.peopleBean.getBirthdate());
        values.add(this.peopleBean.getIsDeceased());
        values.add(this.peopleBean.getDeceased());
        values.add(isProfile);
        values.add(peopleID);
        query = new String("Update Zpeople Set ");
        query = query.concat("Name = ?, ");
        //query = query.concat("Email = ?, ");
        query = query.concat("GotBirthdate = ?, ");
        query = query.concat("Birthdate = ?, ");
        query = query.concat("IsDeceased = ?, ");
        query = query.concat("Deceased = ?, ");
        query = query.concat("IsProfile = ? ");
        query = query.concat("Where PeopleID = ?");
        success = connBean.update(query, values);
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        if(this.peopleBean.getTitle().equals("owner")) {
            // update account name
            values = new ArrayList();
            values.add(this.peopleBean.getName());
            values.add(this.peopleBean.getAccountID());
            query = new String("Update Accounts Set ");
            query = query.concat("Name = ? Where AccountID = ?");
            success = connBean.update(query, values);
            if(!success) {
                this.errors = connBean.getErrors();
                return false;
            }
        }
        
        
        // recreate tree
        this.restartTree();
        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
        
        // get me
        SortedMap pMap = this.treeBean.getFambypeople();
        me = (TreeMap) pMap.get(meID);
        this.treeBean.setMe(me);
        
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }

        
        return success;
    }
    
    public boolean isSharersChanged() {
        boolean success = true;
        SortedMap map[] = null;
        ArrayList values = null;
        ArrayList valuesLks = null;
        String sqlStrg = null;
        String sqlStrg2 = null;
        String sqlLksStrg = null;
        int size = 0;
        
        this.connBean = new ConnBean();
        
        success = this.connBean.isStarted();
        if(!success)
            return false;
        
        /*** get array of map of family members under account ***/
        values = new ArrayList();
        values.add(this.peopleBean.getAccountID());
        map = this.connBean.select("Select * From Zpeople Where AccountID = ? Order By Name", values);
        this.treeBean.setFamily(map);
        
        // get map of owner
        size = map.length;
        for(int i=0; i<size; i++) {
            String zTitle = (String) map[i].get("Title");
            String zEmail = (String) map[i].get("Email");
            if(zTitle.equals("owner") && zEmail.equals(this.peopleBean.getEmail())) {
                Integer Id = (Integer) map[i].get("PeopleID");
                this.treeBean.setPeopleID(Id);
                this.treeBean.setMe((TreeMap) map[i]);
                break;
            }
        }
        
        /*** get array of other famillies sharing space ***/
        values = new ArrayList();
        values.add(this.peopleBean.getAccountID());
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
        valuesLks.add(this.peopleBean.getAccountID());
        sqlLksStrg = "Select * From Zlinks Where AccountID = ?";
        
        // Obtain list of profiles from your account and member accounts
        int sharersCount = 0;
        if(map != null) {
            sharersCount = map.length;
            values = new ArrayList();
        }
        
        if(sharersCount == 0) {
            values.add(new Integer(-1));
            sqlStrg = "Select * From Zpeople Where AccountID = ?";
        }
        else if(sharersCount == 1) {
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
        
        if(sharersCount >= 0) {
            sqlStrg = sqlStrg+" Order By Name";
            map = this.connBean.select(sqlStrg, values);
            // add elements to map family.
            this.treeBean.setFamilyOtro(map);
        }
        
        /*** get array of map of family relationships under account ***/
        map = this.connBean.select(sqlLksStrg, valuesLks);
        this.treeBean.setLinks(map);
        
        success = this.connBean.isClosed();
        
        /*** build tree maps ***/
        BuildTreeBean btBean = new BuildTreeBean();
        btBean.setTreeBean(this.treeBean);
        btBean.isBuilded();
        this.treeBean = btBean.getTreeBean();
        
        return success;
    }
    
    private void restartTree() {

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
        
        // get me map
        TreeMap me = null;
        me = this.treeBean.getMe();
        SortedMap map[] = null;
        
        ArrayList values = null;
        values = new ArrayList();
        values.add((Integer) me.get("AccountID"));
        map = connBean.select("Select * From Zpeople Where AccountID = ? Order By Name", values);
        this.treeBean.setFamily(map);
        
        values = new ArrayList();
        values.add((Integer) me.get("AccountID"));
        map = connBean.select("Select * From Zlinks Where AccountID = ?", values);
        this.treeBean.setLinks(map);
    }
    
    public boolean isBranchUpdated() {
        boolean success = true;
        ArrayList values = null;
        String query = null;
        
        connBean = new ConnBean();
        success = connBean.isStarted();
        if(!success)
            return false;
        
        // get selfID
        Integer selfID = (Integer) ((TreeMap) this.treeBean.getMe()).get("PeopleID");
        
        success = this.isEmailChecked();
        if(!success)
            return success;
        
        String isProfile = new String();
        if(this.isProfileChecked() == false)
            isProfile="no";
        else
            isProfile="yes";

        //  new node in database?
        Integer elseID = this.getPeopleBean().getPeopleID();
        if(elseID.intValue() == -1) {
            // record new person in tree
            values = new ArrayList();
            values.add(this.getPeopleBean().getName());
            values.add(this.getPeopleBean().getEmail());
            values.add(this.getPeopleBean().getGotBirthdate());
            values.add(this.getPeopleBean().getBirthdate());
            values.add(this.getPeopleBean().getIsDeceased());
            values.add(this.getPeopleBean().getDeceased());
            values.add(this.getPeopleBean().getGender());
            values.add(isProfile);
            values.add(this.getPeopleBean().getAccountID());
            
            query = new String("INSERT INTO Zpeople ");
            query = query+"(Name, Email, GotBirthdate, Birthdate, IsDeceased, Deceased, ";
            query = query+"Gender, IsProfile, AccountID) ";
            query = query+"VALUES (?,?,?,?,?,?,?,?,?)";
            
            success = connBean.update(query, values);
            if(!success) {
                connBean.isClosed();
                return false;
            }
            
            // get elseID
            SortedMap gMap[] = null;
            gMap = connBean.select("Select MAX(PeopleID) from Zpeople", new ArrayList());
            if(gMap == null || gMap.length>1) {
                connBean.isClosed();
                return false;
            }
            elseID = (Integer) gMap[0].get(gMap[0].firstKey());
            this.peopleBean.setPeopleID(elseID);
                        
        }
        
        // create links
        values = new ArrayList();
        values.add(this.treeBean.getParam1());
        values.add(selfID);
        values.add(elseID);
        values.add(this.peopleBean.getAccountID());
        query = new String("INSERT INTO Zlinks ");
        query = query+"(Title, SelfID, ElseID, AccountID) ";
        query = query+"VALUES (?,?,?,?)";
        success = connBean.update(query, values);
        
        // Reverse link
        String relationship = reverseRel(this.treeBean.getParam1());
        values = new ArrayList();
        values.add(relationship);
        values.add(elseID);
        values.add(selfID);
        values.add(this.peopleBean.getAccountID());
        query = new String("INSERT INTO Zlinks ");
        query = query+"(Title, SelfID, ElseID, AccountID) ";
        query = query+"VALUES (?,?,?,?)";
        success = connBean.update(query, values);
        
        // check for virtual bridges in both directions
        success = this.isBridgeChecked(selfID, elseID);
        success = this.isBridgeChecked(elseID, selfID);
        
        // recreate tree
        this.restartTree();
        
        // build trees
        BuildTreeBean btrBean = new BuildTreeBean();
        btrBean.setTreeBean(this.treeBean);
        success = btrBean.isBuilded();
        
        if(!success) {
            this.errors = btrBean.getErrors();
            return false;
        }
        
        // get reference to tree
        this.treeBean = btrBean.getTreeBean();
        
        SortedMap pMap = this.treeBean.getFambypeople();
        this.treeBean.setMe((TreeMap) pMap.get(selfID));
            
        success = connBean.isClosed();
        if(!success) {
            this.errors = connBean.getErrors();
        }
        
        return success;
    }
    
    private String reverseRel(String relationship) {
        TreeMap root = this.treeBean.getMe();
        
        if(relationship.equals("Father") || relationship.equals("Mother")) {
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
        
        else if(relationship.equals("Brother") || relationship.equals("Sister")) {
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
            
        else if(relationship.equals("Son") || relationship.equals("Daughter")) {
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
        
        else if(relationship.equals("Husband_Partner") || relationship.equals("Wife_Partner")) {
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
        
        else if(relationship.equals("Boyfriend") || relationship.equals("Girlfriend")) {
            String gender = (String) root.get("Gender");
            if(gender.equals("Male"))
                return("Boyfriend");
            else if(gender.equals("Female"))
                return("Girlfriend");
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
    
    public boolean isEmailChecked() {
        boolean success = true;
        ArrayList values = null;

        String email = this.peopleBean.getEmail();
        
        // case profile has no email
        if(email.equals("none")) {
            return success = true;
        }
        // check email is unique
        if(email.length() > 0) {
            values = new ArrayList();
            values.add(email);
            values.add(this.peopleBean.getAccountID());
            SortedMap emailMap[] = null;
            emailMap = connBean.select("Select * From Zpeople Where Email = ? And AccountID = ?", values);
            if(emailMap != null) {
                if(emailMap.length > 0) {
                    String emailIt = (String) this.treeBean.getIt().get("Email");
                    if(emailIt.equals(email) && emailMap.length == 1) {
                        // emails exists but will be modified
                    }
                    else {
                        this.errors = "change email, it already exists in this tree";
                        return false;
                    }
                }
            }
        }
        
        return success;
    }
    
    public boolean isProfileChecked() {
        boolean success = false;
        ArrayList values = null;

        // check email exists for other accounts
        String email = this.peopleBean.getEmail();
        
        if(email.length() > 0) {
            values = new ArrayList();
            values.add(email);
            values.add(this.peopleBean.getAccountID());
            SortedMap emailMap[] = null;
            emailMap = connBean.select("Select * From Accounts Where Email = ? And AccountID != ?", values);
            if(emailMap != null) {
                if(emailMap.length > 0) {
                    // case email exists - then, update record of person
                    
                    success = true;
                    return success;
                    
                }
            }
        }
        
        return success;
    }
    
    public boolean isBridgeChecked(Integer selfID, Integer elseID) {
        boolean success = true;
        SortedMap map[] = null;
        ArrayList values = null;
        String query = null;
        
        // Define parameters
        
        // Define ownerX
        SortedMap ownerX = this.treeBean.getOwner();
        
        // Define meX
        values = new ArrayList();
        values.add(selfID);
        map = connBean.select("Select * From Zpeople Where PeopleID = ?", values);
        if(map == null || map.length != 1) {
            this.errors = "out1";
            return false;
        }
        // Define meX
        SortedMap meX = map[0];
        
        values = new ArrayList();
        values.add(elseID);
        map = connBean.select("Select * From Zpeople Where PeopleID = ?", values);
        if(map == null || map.length != 1) {
            this.errors = "out1";
            return false;
        }   
        // Define youX
        SortedMap youX = map[0];
        
        // case email is null
        String emailX = (String) youX.get("Email");
        if(emailX == null || emailX.equals("")) {
            this.errors = "out2";
            return true;
        }
        
        // check if bridge to youX exists
        values = new ArrayList();
        values.add((Integer) youX.get("AccountID"));
        values.add((Integer) youX.get("PeopleID"));
        map = connBean.select("Select * From Zlinks Where AccountID = ? And ElseID = ? And OtherID > 0", values);
        if(map == null) {
            this.errors = "out3";
            return false;       // error
        }
            
        if(map.length > 0) {
            // bridge already exists, update link
            values = new ArrayList();
            values.add((Integer) map[0].get("OtherID"));
            values.add((Integer) meX.get("PeopleID"));
            values.add((Integer) youX.get("PeopleID"));
            values.add((Integer) meX.get("AccountID"));
            query = new String("Update Zlinks Set ");
            query = query + "OtherID = ? ";
            query = query + "Where SelfID = ? And ElseID = ? And AccountID = ?";
            success = connBean.update(query, values);
            if(!success) {
                this.errors = connBean.getErrors();
                this.errors = "out4";
                return false;
            }
            this.errors = "out5";
            return true;
        }
        
        // check if email of youX belongs to other account owner
        values = new ArrayList();
        values.add((String) youX.get("Email"));
        values.add((Integer) youX.get("AccountID"));
        values.add("owner");
        map = connBean.select("Select * From Zpeople Where Email = ? And AccountID != ? And Title = ?", values);
        if(map == null || map.length != 1) {
            this.errors = "out6";
            return true;       // no link
        }
            
        // Define ownerA
        SortedMap ownerA = map[0];
        
        // Check if youA exists
        values = new ArrayList();
        values.add((String) ownerX.get("Email"));
        values.add((Integer) ownerA.get("AccountID"));
        map = connBean.select("Select * From Zpeople Where Email = ? And AccountID = ?", values);
        if(map == null || map.length != 1) {
            this.errors = "out7";
            return true;       // no link
        }
        // Define youA
        SortedMap youA = map[0];
        
        // verify that account ownerA has links to youA: define meAs
        values = new ArrayList();
        values.add((Integer) youA.get("AccountID"));
        values.add((Integer) youA.get("PeopleID"));
        query = "Select Zpeople.* From Zlinks, Zpeople Where ";
        query = query + "Zlinks.SelfID = Zpeople.PeopleID And ";
        query = query + "Zlinks.AccountID = ? And Zlinks.ElseID = ?";
        map = connBean.select(query, values);
        if(map == null) {
            this.errors = "out8";
            return false;       // error
        }
            
        if(map.length == 0) {
            this.errors = "out9";
            return true;        // no corresponding links
        }
            
        SortedMap meA[] = null;
        meA = map;
        
        // Update links to create bridge
        
        // update links meX --> youX
        values = new ArrayList();
        values.add((Integer) ownerA.get("PeopleID"));
        values.add((Integer) meX.get("PeopleID"));
        values.add((Integer) youX.get("PeopleID"));
        values.add((Integer) meX.get("AccountID"));
        query = new String("Update Zlinks Set ");
        query = query + "OtherID = ? ";
        query = query + "Where SelfID = ? And ElseID = ? And AccountID = ?";
        success = connBean.update(query, values);
        if(!success) {
            this.errors = connBean.getErrors();
            return false;
        }
        
        // update links meA* --> youA
        int sizeMeA = 0;
        sizeMeA = meA.length;
        for(int k=0; k<sizeMeA; k++) {
            values = new ArrayList();
            values.add((Integer) ownerX.get("PeopleID"));
            values.add((Integer) youA.get("PeopleID"));
            values.add((Integer) meA[k].get("PeopleID"));
            values.add((Integer) ownerA.get("AccountID"));
            query = new String("Update Zlinks Set ");
            query = query + "OtherID = ? ";
            query = query + "Where ElseID = ? And SelfID = ? And AccountID = ?";
            success = connBean.update(query, values);
            if(!success) {
                this.errors = connBean.getErrors();
                return false;
            }
        }
        this.errors = "out11";
        return success;
    }
    
}
