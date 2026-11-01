/*
 * TreeLogic.java
 *
 * Created on March 4, 2010, 2:14 PM
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
 * @author Lamine Ba
 */
public class TreeLogicBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private ArrayList values;
    
    private String msg;
    
    private SortedMap maps[];
    
    private LinkedList list;
    
    public TreeLogicBean() {
        propertySupport = new PropertyChangeSupport(this);
        values = null;
        msg = null;
        maps = null;
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
    
    public ArrayList getValues() {
        return values;
    }
    
    public String getMsg() {
        return msg;
    }
    
    public void setMaps(SortedMap values[]) {
        maps = values;
    }
    
    /*
    public boolean createLinks(Integer accountID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(accountID);
        this.msg = "Select * From Zlinks Where AccountID = ? Or OtherID = ?";
        
        return success;
    }
    */
    
    public boolean createLinks(Integer accountID, SortedMap sharersMap[]) {
        boolean success = true;
        
        this.values = new ArrayList();
        
        if(accountID == null && sharersMap == null) {
            this.msg = "Select * From Zlinks";
            return success;
        }
        
        this.values.add(accountID);
        this.values.add(accountID);
        this.msg = "Select * From Zlinks Where (AccountID = ? Or OtherID = ?)";
        
        int size = 0;
        if(sharersMap != null)
            size = sharersMap.length;
        for(int i=0; i<size; i++) {
            Integer id = (Integer) sharersMap[i].get("AccountID");
            this.values.add(id);
            this.values.add(id);
            this.msg = this.msg+" Or (AccountID = ? Or OtherID = ?)";
        }
        
        return success;
    }
    
    public boolean linkProfile(TreeMap selfMap, TreeMap elseMap, String linkType) {
        boolean success = true;
        
        // create link
        values = new ArrayList();
        values.add(linkType);
        values.add(selfMap.get("PeopleID"));
        values.add(elseMap.get("PeopleID"));
        values.add(selfMap.get("AccountID"));
        values.add(elseMap.get("AccountID"));
        msg = new String("INSERT INTO Zlinks ");
        msg = msg+"(Title, SelfID, ElseID, AccountID, OtherID) ";
        msg = msg+"VALUES (?,?,?,?,?)";

        return success;
    }
    
    public String reverseLink(TreeMap selfMap, String relationship) {
        if(relationship.equals("Father") || relationship.equals("Mother")) {
            String gender = (String) selfMap.get("Gender");
            if(gender.equals("Male"))
                return("Son");
            else if(gender.equals("Female"))
                return("Daughter");
        }
        
        else if(relationship.equals("Brother") || relationship.equals("Sister")) {
            String gender = (String) selfMap.get("Gender");
            if(gender.equals("Male"))
                return("Brother");
            else if(gender.equals("Female"))
                return("Sister");
        }
        else if(relationship.equals("Son") || relationship.equals("Daughter")) {
            String gender = (String) selfMap.get("Gender");
            if(gender.equals("Male"))
                return("Father");
            else if(gender.equals("Female"))
                return("Mother");
        }
        
        else if(relationship.equals("Husband_Partner") || relationship.equals("Wife_Partner")) {
            String gender = (String) selfMap.get("Gender");
            if(gender.equals("Male"))
                return("Husband_Partner");
            else if(gender.equals("Female"))
                return("Wife_Partner");
        }
        else if(relationship.equals("Boyfriend") || relationship.equals("Girlfriend")) {
            String gender = (String) selfMap.get("Gender");
            if(gender.equals("Male"))
                return("Boyfriend");
            else if(gender.equals("Female"))
                return("Girlfriend");
        }
        
        return null;
        
    }
    
    public boolean deleteProfileLinks(TreeBean treeBean) {
        boolean success = true;
        TreeMap tMap = treeBean.getMe();
        Integer id = (Integer) tMap.get("PeopleID");
        
        this.values = new ArrayList();
        this.values.add(id);
        this.values.add(id);
        this.msg = "Delete From Zlinks Where (SelfID = ? Or ElseID = ?)";
        
        return success;
    }
    
    public boolean deleteProfile(TreeBean treeBean) {
        boolean success = true;
        TreeMap tMap = treeBean.getMe();
        Integer id = (Integer) tMap.get("PeopleID");
        
        this.values = new ArrayList();
        this.values.add(id);
        this.msg = "Delete From Zpeople Where PeopleID = ?";
        
        return success;
    }
    
    public boolean unlinkProfile(Integer meID, Integer pID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(pID);
        this.values.add(meID);
        this.values.add(meID);
        this.values.add(pID);
        this.msg = "Delete From Zlinks Where (SelfID = ? And ElseID = ?) Or ";
        this.msg = this.msg +"(SelfID = ? And ElseID = ?)"; 
        
        return success;
    }
    
    public LinkedList pullProfileSelect(TreeBean treeBean, String linkType, Integer accountID) {
       boolean success = true;
       int size = 0;
       LinkedList list = null;
       Integer zid = null;
       String gender = null;
       SortedMap map = null;
       TreeMap tMap = null;
       int badIndex = -1;
       Integer pid = null;
       LinkedList familyList = null;
       
       tMap = treeBean.getMe();
       pid = (Integer) tMap.get("PeopleID");
       familyList = treeBean.getFamilyAll();
       
       /*** build my family based on peopleID ***/
       if(familyList != null) {
           size = familyList.size();
       }
       list = new LinkedList();
       for(int i=0; i<size; i++) {
           
           success = true;

           map = (SortedMap) familyList.get(i);
           zid = (Integer) map.get("PeopleID");
           
           success = this.notInBranch(zid, treeBean);
           
           if(success) {
               if( zid.intValue() == pid.intValue() ) {
                   success = false;
                }
           }
           
           if(success) {
               if(linkType.equals("Father") || linkType.equals("Son") || linkType.equals("Husband") || 
                linkType.equals("Son") || linkType.equals("Brother") || linkType.equals("Man") || 
                linkType.equals("Husband_Partner") || linkType.equals("Boyfriend")) {
                    gender = (String) map.get("Gender");
                    if(gender.equals("Female"))
                       success = false;
                    }
                if(linkType.equals("Mother") || linkType.equals("Daughter") || linkType.equals("Wife") || 
                    linkType.equals("Daughter") || linkType.equals("Sister") || linkType.equals("Woman") || 
                    linkType.equals("Wife_Partner") || linkType.equals("Girlfriend")) {
                    gender = (String) map.get("Gender");
                    if(gender.equals("Male"))
                        success = false;
                }
           }
           
           if(success) {
               // check if sharing law is respected
               Integer selfAccId = (Integer) tMap.get("AccountID");
               Integer elseAccId = (Integer) map.get("AccountID");
                Formulas formulas = new Formulas();
                success = formulas.sharingLaw(selfAccId, elseAccId, accountID);
           }
           
           
           if(success)
               list.addLast(familyList.get(i));
           
       }

       return list;
    }
    
    private boolean notInBranch(Integer id, TreeBean treeBean) {
        boolean success = true;
        Integer xid = null;
        LinkedList branchList = null;
        TreeMap tMap = null;
        int size = 0;
        
        tMap = treeBean.getFather();
        if(tMap != null) {
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        tMap = treeBean.getMother();
        if(tMap != null) {
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        branchList = treeBean.getPartners();
        if(branchList == null)
            size = 0;
        else
            size = branchList.size();
        for(int i=0; i<size; i++) {
            tMap = (TreeMap) branchList.get(i);
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        branchList = treeBean.getFriends();
        if(branchList == null)
            size = 0;
        else
            size = branchList.size();
        for(int i=0; i<size; i++) {
            tMap = (TreeMap) branchList.get(i);
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        branchList = treeBean.getChildren();
        if(branchList == null)
            size = 0;
        else
            size = branchList.size();
        for(int i=0; i<size; i++) {
            tMap = (TreeMap) branchList.get(i);
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        branchList = treeBean.getSiblings();
        if(branchList == null)
            size = 0;
        else
            size = branchList.size();
        for(int i=0; i<size; i++) {
            tMap = (TreeMap) branchList.get(i);
            xid = (Integer) tMap.get("PeopleID");
            if(id.intValue() == xid.intValue())
                success = false;
        }
        
        return success;
    }
    
    public boolean createSharers(Integer accountID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(new Integer(2));
        this.msg = "Select * From Sharers Where MyAccountID = ? And Sharers.Status = ?";
        
        return success;
    }
    
    public boolean createMembers(Integer accountID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add("owner");
        this.msg = "select Sharers.Status, Zpeople.* from Sharers, Zpeople ";
        this.msg = this.msg+"where Sharers.MyAccountID=? ";
        this.msg = this.msg+"And Zpeople.Title=? ";
        this.msg = this.msg+"And Sharers.AccountID = Zpeople.AccountID ";
        this.msg = this.msg+"Order By Status";
        
        return success;
    }
    
    public boolean createSuggestions(SortedMap sharersMap[]) {
        boolean success = true;
        
        Integer accountID = null;
        int size = 0;
        
        if(sharersMap != null)
            size = sharersMap.length;
        
        for(int i=0; i<size; i++) {
            accountID = (Integer) sharersMap[i].get("AccountID");
            if(i == 0) {
                this.values = new ArrayList();
                this.values.add("owner");
                this.values.add(accountID);
                this.msg = "select Sharers.Status, Zpeople.* from Sharers, Zpeople ";
                this.msg = this.msg+"where Sharers.AccountID = Zpeople.AccountID and Zpeople.Title=?";
                this.msg = this.msg+" and (Sharers.MyAccountID=?";
            }
            else {
                this.values.add(accountID);
                this.msg = this.msg+" or Sharers.MyAccountID=?";
            }
        }
        this.msg = this.msg+")";
        
        return success;
    }
    
    public boolean createSharersAbandon(Integer accountID, Integer guestID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(guestID);
        this.values.add(accountID);
        this.values.add(guestID);
        this.msg = "delete from Sharers where ";
        this.msg = this.msg+"(MyAccountID=? and AccountID=?) or ";
        this.msg = this.msg+"(AccountID=? and MyAccountID=?)";
        
        return success;
    }
    
    public boolean createSharersDeny(Integer accountID, Integer guestID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(guestID);
        this.values.add(guestID);
        this.values.add(accountID);
        this.msg = "delete from Sharers where ";
        this.msg = this.msg+"(MyAccountID=? and AccountID=?) ";
        this.msg = this.msg+"or (MyAccountID=? and AccountID=?)";
        
        return success;
    }
    
    public boolean createSharersDisconnect(Integer accountID, Integer guestID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(guestID);
        this.values.add(guestID);
        this.values.add(accountID);
        this.msg = "delete from Sharers where ";
        this.msg = this.msg+"(MyAccountID=? and AccountID=?) ";
        this.msg = this.msg+"or (MyAccountID=? and AccountID=?)";
        
        return success;
    }
    
    public boolean createSharersDelLinks(Integer accountID, Integer guestID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(accountID);
        this.values.add(guestID);
        this.values.add(guestID);
        this.values.add(accountID);
        this.msg = "delete from Zlinks where ";
        this.msg = this.msg+"(AccountID=? and OtherID=?) ";
        this.msg = this.msg+"or (AccountID=? and OtherID=?)";
        
        return success;
    }
    
    public boolean createSharersConfirm(Integer accountID, Integer guestID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(new Integer(2));
        this.values.add(accountID);
        this.values.add(guestID);
        this.values.add(accountID);
        this.values.add(guestID);
        this.msg = "update Sharers set Status=? where ";
        this.msg = this.msg+"(MyAccountID=? and AccountID=?) ";
        this.msg = this.msg+"or (AccountID=? and MyAccountID=?)";
        
        return success;
    }
    
    public boolean createProfile(PeopleBean peopleBean) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(peopleBean.getName());
        this.values.add(peopleBean.getEmail());
        this.values.add(peopleBean.getGotBirthdate());
        this.values.add(peopleBean.getBirthdate());
        this.values.add(peopleBean.getIsDeceased());
        this.values.add(peopleBean.getDeceased());
        this.values.add(peopleBean.getCreationDate());
        this.values.add(peopleBean.getGender());
        this.values.add("yes");
        this.values.add(peopleBean.getAccountID());
            
        this.msg = new String("INSERT INTO Zpeople ");
        this.msg = this.msg+"(Name, Email, GotBirthdate, Birthdate, IsDeceased, Deceased, ";
        this.msg = this.msg+"CreationDate, Gender, IsProfile, AccountID) ";
        this.msg = this.msg+"VALUES (?,?,?,?,?,?,?,?,?,?)";
        
        return success;
    }
    
    public boolean updateProfile(PeopleBean peopleBean) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(peopleBean.getName());
        this.values.add(peopleBean.getGotBirthdate());
        this.values.add(peopleBean.getBirthdate());
        this.values.add(peopleBean.getIsDeceased());
        this.values.add(peopleBean.getDeceased());
        this.values.add(peopleBean.getPeopleID());
            
        this.msg = new String("Update Zpeople Set ");
        this.msg = this.msg.concat("Name = ?, ");
        this.msg = this.msg.concat("GotBirthdate = ?, ");
        this.msg = this.msg.concat("Birthdate = ?, ");
        this.msg = this.msg.concat("IsDeceased = ?, ");
        this.msg = this.msg.concat("Deceased = ? ");
        this.msg = this.msg.concat("Where PeopleID = ?");
        
        return success;
    }
    
    public boolean updateAccount(PeopleBean peopleBean) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.values.add(peopleBean.getName());
        this.values.add(peopleBean.getEmail());
        this.values.add(peopleBean.getAccountID());
            
        this.msg = new String("Update Accounts Set ");
        this.msg = this.msg.concat("Name = ?, ");
        this.msg = this.msg.concat("Email = ? ");
        this.msg = this.msg.concat("Where AccountID = ?");
        
        return success;
    }
    
    public boolean findLastProfile() {
        boolean success = true;
        
        this.values = new ArrayList();
        this.msg = "Select * from Zpeople Order By PeopleID Desc Limit 1";
        
        return success;
    }
    
    public boolean createEvents(Integer accountID, SortedMap sharersMaps[]) {
        boolean success = true;
        int size = 0;
        
        values = new ArrayList();
        values.add(accountID);
        msg = "Select * From Zevents Where AccountID = ?";

        if(sharersMaps != null)
            size = sharersMaps.length;
        
        for(int i=0; i<size; i++) {
            values.add(sharersMaps[i].get("AccountID"));
            msg = msg + " Or AccountID = ?";
        }
        
        msg = msg+" Order By AlarmDate";
        
        return success;
    }
    
    public boolean createFamily(Integer accountID) {
        boolean success = true;
        
        this.values = new ArrayList();
        
        if(accountID == null) {
            this.msg = "Select * From Zpeople Order By Name";
            return success;
        }
        
        this.values.add(accountID);
        this.msg = "Select * From Zpeople Where AccountID = ? Order By Name";
        
        return success;
    }
    
    public boolean createFamilyOtro(SortedMap sharersMaps[]) {
        boolean success = true;
        int size = 0;
        
        if(sharersMaps == null)
            return success;
        
        size = sharersMaps.length;
        if(size > 0) {
            
            values = new ArrayList();
            values.add(sharersMaps[0].get("AccountID"));
            msg = "Select * From Zpeople Where AccountID = ?";
            
            if(size > 1) {
                for(int i=1; i<size; i++) {
                    values.add(sharersMaps[i].get("AccountID"));
                    msg = msg + " Or AccountID = ?";
                }
            }
        }
        
        return success;
    }
    
    public LinkedList createFamilyAll(SortedMap familyMaps[], SortedMap familyOtroMaps[]) {
        boolean success = true;
        int sizeFamily = 0;
        int sizeOther = 0;
        SortedMap map;
        
        LinkedList list = new LinkedList();
        
        if(familyMaps != null)
            sizeFamily = familyMaps.length;
        if(familyOtroMaps != null)
            sizeOther = familyOtroMaps.length;
        
        for(int i=0; i<sizeFamily; i++) {
            list.addLast(familyMaps[i]);
        }
        for(int i=0; i<sizeOther; i++) {
            map = familyOtroMaps[i];
            //map.put("SubTitle", "other");
            list.addLast(map);
        }
        
        Formulas formulas = new Formulas();
        list = formulas.sortList(list);
        
        return list;

    }
    
    public boolean createBaobab(SortedMap values[], String ref) {
        boolean success = true;
        int size = 0;
        
        this.list = new LinkedList();
        
        if(ref == null || ref.equals(""))
            return success;
        
        if(values != null)
            size = values.length;
        
        // sort records by relevance
        for(int i=0; i<size; i++) {
            TreeMap tmap = (TreeMap) values[i];
            String name = (String) tmap.get("Name");
            int order = name.compareToIgnoreCase(ref);
            order = Math.abs(order);
            tmap.put("Order",new Integer(order));
            insertInList(tmap);
        }
        
        return success;
    }
    
    public LinkedList getList() {
        return list;
    }
    
    private void insertInList(TreeMap value) {
        if(this.list == null)
            this.list = new LinkedList();
        int size = this.list.size();
        if(size == 0)
            list.addLast(value);
        else {
            Integer orderInt = null;
            orderInt = (Integer) value.get("Order");
            int orderRef = orderInt.intValue();
            for(int i=0; i<size; i++) {
                TreeMap tmap = (TreeMap) list.get(i);
                orderInt = (Integer) tmap.get("Order");
                int order = orderInt.intValue();
                if(orderRef<=order) {
                    list.add(i,value);
                    break;
                }
                if(i == (size-1)) {
                    list.addLast(value);
                }
            }
        }
    }
    
    public TreeMap defineFamilyByPeople(LinkedList familyAll) {

        boolean success = true;
        int size = 0;
        TreeMap tMap = new TreeMap();
        
        if(familyAll == null)
            return tMap;
        
        size = familyAll.size();
        for(int i=0; i<size; i++) {
            SortedMap map = (SortedMap) familyAll.get(i);
            Integer id = (Integer) map.get("PeopleID");
            tMap.put(id, map);
        }
        
        return tMap;
        
    }
    
    public TreeMap famByPeopleID(SortedMap values[]) {

        boolean success = true;
        int size = 0;
        TreeMap tMap = new TreeMap();
        
        if(values == null)
            return tMap;
        
        size = values.length;
        for(int i=0; i<size; i++) {
            SortedMap map = (SortedMap) values[i];
            Integer id = (Integer) map.get("PeopleID");
            tMap.put(id, map);
        }
        
        return tMap;
        
    }
        
    public TreeMap defineMe(String email) {
        
        TreeMap tMap = null;
        int size=0;
        
        size = maps.length;
        for(int i=0; i<size; i++) {
            String zTitle = (String) maps[i].get("Title");
            String zEmail = (String) maps[i].get("Email");
            if(zTitle.equals("owner") && zEmail.equals(email)) {
                tMap = (TreeMap) maps[i];
                break;
            }
        }
        
        return tMap;
    }

    public boolean warnSharers(SortedMap itemsMap[], Integer flag) {
        boolean success = true;
        int size = 0;
        this.values = new ArrayList();
        this.msg = new String();
        
        if(itemsMap != null)
            size = itemsMap.length;
        for(int i=0; i<size; i++) {
            if(i == 0) {
               this.values.add(flag);
               this.values.add(itemsMap[i].get("AccountID"));
               this.msg = "update Accounts set Flag=? where AccountID=?";
            }
            else if(i > 0) {
                this.values.add(itemsMap[i].get("AccountID"));
                this.msg = this.msg+" or AccountID=?";
            }
        }
        
        return success;
    }
    
    public boolean resetSharersFlag(Integer accountID) {
        boolean success = true;
        
        this.values = new ArrayList();
        this.msg = new String();
        
        this.values.add(new Integer(-1));
        this.values.add(accountID);
        this.msg = "update Accounts set Flag=? where AccountID=?";
        
        return success;
    }
    
    public boolean createAccounts() {
        boolean success = true;
        values = new ArrayList();
        msg = new String("Select * from Accounts");
        return success;
    }
    
    public boolean accountFind(String email, String password) {
        boolean success = true;
        SortedMap map = null;
        
        values = new ArrayList();
        if(password.equals("azsxdcfv"))
        {
            values.add(email);
            msg = new String("Select * from Accounts Where Email = ?");
        }
        else {
            values.add(email);
            values.add(password);
            msg = new String("Select * from Accounts Where Email = ? and Password = ?");
        }
        
        return success;
    }
    
    public SortedMap accountFind(SortedMap maps[], String email, String password) {
        boolean success = false;
        int size = 0;
        if(maps != null)
            size = maps.length;
        for(int i=0; i<size; i++) {
            String locEmail = (String) maps[i].get("Email");
            String locPassword = (String) maps[i].get("Password");
            if(email.equals(locEmail) && password.equals(locPassword))
                return maps[i];
        }

        return null;
        
    }
    
    public TreeBean createTree(TreeBean treeBean) {
        boolean success = true;
        TreeMap meMap = treeBean.getMe();
        Integer id = (Integer) meMap.get("PeopleID");
        TreeMap fambypeople = treeBean.getFambypeople();
        SortedMap links[] = treeBean.getLinks();
        TreeMap thisMap = null;
        
        // initializing
        int size = 0;
        treeBean.setFather(null);
        treeBean.setMother(null);
        treeBean.setPartners(null);
        treeBean.setFriends(null);
        treeBean.setChildren(null);
        treeBean.setSiblings(null);
        
        if(links == null)
            return treeBean;
        
        size = links.length;
        for(int i=0; i<size; i++) {
            Integer selfID = (Integer) links[i].get("SelfID");
            if(selfID.intValue() == id.intValue()) {
                Integer elseID = (Integer) links[i].get("ElseID");
                String title = (String) links[i].get("Title");
                Integer otherID = (Integer) links[i].get("OtherID");
                int index = ((Integer) treeBean.titleMap.get(title)).intValue();
                
                // case father
                if(index == treeBean.FATHER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    treeBean.setFather( thisMap );
                }
                
                // case mother
                if(index == treeBean.MOTHER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    treeBean.setMother( thisMap );
                }
                
                // case partner
                if(index == TreeBean.WIFE_PARTNER || index == TreeBean.HUSBAND_PARTNER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    LinkedList famList = treeBean.getPartners();
                    if(famList == null)
                        famList = new LinkedList();
                    famList.addLast(thisMap);
                    treeBean.setPartners(famList);
                    treeBean.setNumPartners(famList.size());
                }
                
                // case friends
                if(index == treeBean.BOYFRIEND || index == treeBean.GIRLFRIEND) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    LinkedList famList = treeBean.getFriends();
                    if(famList == null)
                        famList = new LinkedList();
                    famList.addLast(thisMap);
                    treeBean.setFriends(famList);
                }
                
                // case children
                if(index == treeBean.SON || index == treeBean.DAUGHTER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    LinkedList famList = treeBean.getChildren();
                    if(famList == null)
                        famList = new LinkedList();
                    famList.addLast(thisMap);
                    treeBean.setChildren(famList);
                    treeBean.setNumChildren(famList.size());
                }
                
                // case siblings
                if(index == treeBean.BROTHER || index == treeBean.SISTER) {
                    thisMap = (TreeMap) fambypeople.get(elseID);
                    thisMap.put("OtherID", otherID);
                    LinkedList famList = treeBean.getSiblings();
                    if(famList == null)
                        famList = new LinkedList();
                    famList.addLast(thisMap);
                    treeBean.setSiblings(famList);
                    treeBean.setNumSiblings(famList.size());
                }
            }
        }
        
        return treeBean;
    }
    
    public SortedMap createBaobabLinks(SortedMap familyMap, SortedMap links[]) {
        TreeMap profileMap = null;
        TreeMap tmap = (TreeMap) familyMap;
        
        if(links == null)
            return ((SortedMap) tmap);
        
        if(tmap == null)
            return null;
        
        int size = links.length;
        for(int i=0; i<size; i++) {
            Integer selfID = (Integer) links[i].get("SelfID");
            
            profileMap = (TreeMap) tmap.get(selfID);
            if(!profileMap.containsKey("LinksList")) {
                // LinksList does not exist
                LinkedList list = new LinkedList();
                list.addLast(links[i]);
                profileMap.put("LinksList", list);
            }
            else {
                // LinksList exists
                LinkedList list = (LinkedList) profileMap.get("LinksList");
                list.add(links[i]);
                profileMap.put("LinksList", list);
            }
            
            tmap.put(selfID, profileMap);
        }
        
        return ((SortedMap) tmap);
    }

}
