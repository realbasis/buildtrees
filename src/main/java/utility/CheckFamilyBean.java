/*
 * CheckFamilyBean.java
 *
 * Created on February 26, 2007, 1:42 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.LinkedList;

/**
 * @author Lamine Ba
 */
public class CheckFamilyBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private SortedMap familyMap[];
    
    private SortedMap subfamilyMap[];
    
    private Integer peopleID;
    
    private Integer familyID;
    
    private LinkedList list;
    
    private LinkedList list2;
    
    private LinkedList list3;
    
    private int list0Size;
    
    private int list2Size;
    
    private int list3Size;
    
    private LinkedList myList;
    
    private String type;
    
    private String title;
    
    private String p1p2Title;
    
    private String gender;
    
    public CheckFamilyBean() {
        propertySupport = new PropertyChangeSupport(this);
        this.myList = new LinkedList();
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
    
    public void setFamilyMap(SortedMap value[]) {
        familyMap = value;
    }
    
    public void setSubfamilyMap(SortedMap value[]) {
        subfamilyMap = value;
        
        int size = subfamilyMap.length;
        boolean isFound;
        Integer id;
        
        for(int i=0;i<size;i++) {
            id = (Integer) subfamilyMap[i].get("FamilyID");
            isFound = this.checkFamily(id);
            if(isFound == false)
                this.addFamily(id);
        }
    }
    
    public void setPeopleID(Integer value) {
        peopleID = value;
    }
    
    public void setFamilyID(Integer value) {
        familyID = value;
    }
    
    public void setP1p2Title(String value) {
        p1p2Title = value;
    }
    
    public void setGender(String value) {
        gender = value;
    }
    
    public LinkedList getList() {
        list = new LinkedList();
        int familysize = 0;
        int subfamilysize = 0;
        
        familysize = familyMap.length;
        subfamilysize = subfamilyMap.length;
        
        for(int i=0;i<familysize;i++)
        {
            boolean exists = false;
            for(int j=0;j<subfamilysize;j++)
            {
                int id = ((Integer) familyMap[i].get("PeopleID")).intValue();
                int subid = ((Integer) subfamilyMap[j].get("FamilyID")).intValue();
                
                if(id == subid)
                    exists = true;
                
            }
            if(!exists)
                list.addFirst(familyMap[i]);
        }
        return list;
    }
    
    public LinkedList getList2() {
        list2 = new LinkedList();
        int familysize = 0;
        int subfamilysize = 0;
        boolean exists;
        TreeMap map;
        
        /* Create my family list */
        
        familysize = familyMap.length;
        subfamilysize = subfamilyMap.length;
        
        /* check NFM relatives and add to POI as neeeded */
        for(int i=0;i<familysize;i++)
        {
            exists = false;
            for(int j=0;j<subfamilysize;j++)
            {
                int id = ((Integer) familyMap[i].get("FamilyID")).intValue();
                int subid = ((Integer) subfamilyMap[j].get("FamilyID")).intValue();
                
                if(id == subid)
                    exists = true;
            }
            
            if(!exists)
            {
                /* Add NFM relative to POI branch */
                map = new TreeMap();
                boolean success = matrixTitle(
                    "test", 
                    (String) familyMap[i].get("Type"), 
                    (String) familyMap[i].get("Title"));
                if(success) {
                    map = new TreeMap();
                    map.put("Type", type);
                    map.put("Title", title);
                    map.put("PeopleID", peopleID);
                    map.put("FamilyID", familyMap[i].get("FamilyID"));
                    map.put("FirstName", familyMap[i].get("FirstName"));
                    map.put("LastName", familyMap[i].get("LastName"));
                    list2.addFirst(map);
                }
            }
        }
        
        /*** Reverse order ***/
        for(int j=0;j<subfamilysize;j++)
        {
            exists = false;
            for(int i=0;i<familysize;i++)
            {
                int id = ((Integer) familyMap[i].get("FamilyID")).intValue();
                int subid = ((Integer) subfamilyMap[j].get("FamilyID")).intValue();
                
                if(id == subid)
                    exists = true;
            }
            
            if(!exists)
            {
                /* Add NFM relative to POI branch */
                boolean success = matrixTitle(
                    "test", 
                    (String) subfamilyMap[j].get("Type"), 
                    (String) subfamilyMap[j].get("Title"));
                if(success) {
                    map = new TreeMap();
                    map.put("Type", type);
                    map.put("Title", title);
                    map.put("PeopleID", familyID);
                    map.put("FamilyID", subfamilyMap[j].get("FamilyID"));
                    map.put("FirstName", subfamilyMap[j].get("FirstName"));
                    map.put("LastName", subfamilyMap[j].get("LastName"));
                    list2.addFirst(map);
                }
            }
        }
        
        return list2;
    }
    
    public LinkedList getList3() {
        
        list3 = new LinkedList();
        int familysize = familyMap.length;
        boolean exists;
        TreeMap map;
        Integer id;
        
        
        /* check NFM relatives and add to POI as neeeded */
        for(int i=0;i<familysize;i++)
        {
            id = (Integer) familyMap[i].get("FamilyID");
            exists = this.checkFamily(id);
            
            if(exists == false)
            {
                boolean success;
                /* Find p1p2 title */
                String p1p2Title = this.findTitle((Integer)familyMap[i].get("PeopleID"));
                
                /* Add NFM relative to POI branch */
                map = new TreeMap();
                success = matrixTitle(
                    p1p2Title, 
                    (String) familyMap[i].get("Type"), 
                    (String) familyMap[i].get("Title"));
                if(success) {
                    map = new TreeMap();
                    map.put("Type", type);
                    map.put("Title", title);
                    map.put("PeopleID", peopleID);
                    map.put("FamilyID", id);
                    map.put("FirstName", familyMap[i].get("FirstName"));
                    map.put("LastName", familyMap[i].get("LastName"));
                    map.put("Display", "No");
                    list3.addFirst(map);
                
                    /* Build opposite link */
                    transpose( type, title );
                    map = new TreeMap();
                    map.put("Type", type);
                    map.put("Title", title);
                    map.put("PeopleID", id);
                    map.put("FamilyID", peopleID);
                    map.put("FirstName", familyMap[i].get("FirstName"));
                    map.put("LastName", familyMap[i].get("LastName"));
                    map.put("Display", "Yes");
                    list3.addFirst(map);
                    
                    /* Update my list */
                    this.addFamily(id);
                }
            }
        }
        
        return list3;
    }
    
    public int getList0Size() {
        int listSize = 0;
        list0Size = list.size();
        return list0Size;
    }
    
    public int getList2Size() {
        int list2Size = 0;
        list2Size = list2.size();
        return list2Size;
    }
    
    public int getList3Size() {
        int list3Size = 0;
        list3Size = list3.size();
        return (list3Size/2);
    }
    
    private boolean matrixTitle(String p1p2Title, String ref_type, String ref_title) {
        boolean success = true;
        type = null;
        title = null;
        
        if(p1p2Title.compareTo("Father") == 0) {
            if(ref_title.compareTo("Wife") == 0) {
                type = new String("parent");
                title = new String("Mother");
            }
            if(ref_title.compareTo("Son") == 0) {
                type = new String("sibling");
                title = new String("Brother");
            }
            if(ref_title.compareTo("Daughter") == 0) {
                type = new String("sibling");
                title = new String("Sister");
            }
        }
        else if(p1p2Title.compareTo("Mother") == 0) {
            if(ref_title.compareTo("Husband") == 0) {
                type = new String("parent");
                title = new String("Father");
            }
            if(ref_title.compareTo("Son") == 0) {
                type = new String("sibling");
                title = new String("Brother");
            }
            if(ref_title.compareTo("Daughter") == 0) {
                type = new String("sibling");
                title = new String("Sister");
            }
        }
        else if(p1p2Title.compareTo("Wife") == 0) {
            if(ref_title.compareTo("Son") == 0) {
                type = new String("child");
                title = new String("Son");
            }
            if(ref_title.compareTo("Daughter") == 0) {
                type = new String("child");
                title = new String("Daughter");
            }
        }
        else if(p1p2Title.compareTo("Husband") == 0) {
            if(ref_title.compareTo("Son") == 0) {
                type = new String("child");
                title = new String("Son");
            }
            if(ref_title.compareTo("Daughter") == 0) {
                type = new String("child");
                title = new String("Daughter");
            }
        }
        else if(p1p2Title.compareTo("Son") == 0) {
            if(ref_title.compareTo("Brother") == 0) {
                type = new String("child");
                title = new String("Son");
            }
            if(ref_title.compareTo("Sister") == 0) {
                type = new String("child");
                title = new String("Daughter");
            }
            if(ref_title.compareTo("Mother") == 0) {
                type = new String("spouse");
                title = new String("Wife");
            }
            if(ref_title.compareTo("Father") == 0) {
                type = new String("spouse");
                title = new String("Husband");
            }
        }
        else if(p1p2Title.compareTo("Daughter") == 0) {
            if(ref_title.compareTo("Brother") == 0) {
                type = new String("child");
                title = new String("Son");
            }
            if(ref_title.compareTo("Sister") == 0) {
                type = new String("child");
                title = new String("Daughter");
            }
            if(ref_title.compareTo("Mother") == 0) {
                type = new String("spouse");
                title = new String("Wife");
            }
            if(ref_title.compareTo("Father") == 0) {
                type = new String("spouse");
                title = new String("Husband");
            }
        }
        else if(p1p2Title.compareTo("Sister") == 0) {
            if(ref_title.compareTo("Brother") == 0) {
                type = new String("sibling");
                title = new String("Brother");
            }
            if(ref_title.compareTo("Sister") == 0) {
                type = new String("sibling");
                title = new String("Sister");
            }
            if(ref_title.compareTo("Mother") == 0) {
                type = new String("parent");
                title = new String("Mother");
            }
            if(ref_title.compareTo("Father") == 0) {
                type = new String("parent");
                title = new String("Father");
            }
        }
        else if(p1p2Title.compareTo("Brother") == 0) {
            if(ref_title.compareTo("Brother") == 0) {
                type = new String("sibling");
                title = new String("Brother");
            }
            if(ref_title.compareTo("Sister") == 0) {
                type = new String("sibling");
                title = new String("Sister");
            }
            if(ref_title.compareTo("Mother") == 0) {
                type = new String("parent");
                title = new String("Mother");
            }
            if(ref_title.compareTo("Father") == 0) {
                type = new String("parent");
                title = new String("Father");
            }
        }
        
        if(type == null || title == null)
            success = false;
        
        return success;
    }
    
    private void transpose(String ref_type, String ref_title) {
        boolean success = true;
        
        this.type =  null;
        this.title = null;
        
        if(ref_type.compareTo("parent") == 0) {
            if(gender.compareTo("Male") == 0) {
                this.type = new String("child");
                this.title = new String("Son");
            }
            if(gender.compareTo("Female") == 0) {
                this.type = new String("child");
                this.title = new String("Daughter");
            }
        }
        if(ref_type.compareTo("sibling") == 0) {
            if(gender.compareTo("Male") == 0) {
                this.type = new String("sibling");
                this.title = new String("Brother");
            }
            if(gender.compareTo("Female") == 0) {
                this.type = new String("sibling");
                this.title = new String("Sister");
            }
        }
        if(ref_type.compareTo("child") == 0) {
            if(gender.compareTo("Male") == 0) {
                this.type = new String("parent");
                this.title = new String("Father");
            }
            if(gender.compareTo("Female") == 0) {
                this.type = new String("parent");
                this.title = new String("Mother");
            }
        }
        if(ref_title.compareTo("Girlfriend") == 0) {
            this.type = new String("other");
            this.title = new String("Boyfriend");
        }
        if(ref_title.compareTo("Boyfriend") == 0) {
            this.type = new String("other");
            this.title = new String("Girlfriend");
        }
        if(ref_title.compareTo("Friend") == 0) {
            this.type = new String("other");
            this.title = new String("Friend");
        }
        if(ref_title.compareTo("Other") == 0) {
            this.type = new String("other");
            this.title = new String("Other");
        }
        if(ref_title.compareTo("Husband") == 0) {
            this.type = new String("spouse");
            this.title = new String("Wife");
        }
        if(ref_title.compareTo("Wife") == 0) {
            this.type = new String("spouse");
            this.title = new String("Husband");
        }
        
        if(this.type == null && this.title == null)
            success = false;
        
    }
    
    private boolean checkFamily(Integer value) {
        boolean isFound = false;
        int size = this.myList.size();
        for(int i=0; i<size; i++) {
            Integer id = (Integer) this.myList.get(i);
            if(id.intValue() == value.intValue())
                isFound = true;
        }
        return isFound;
    }
    
    private void addFamily(Integer value) {
        this.myList.addLast(value);
    }
    
    private String findTitle(Integer value) {
        String title = null;
        int size = this.subfamilyMap.length;
        
        for(int i=0;i<size;i++) {
            Integer id = (Integer) subfamilyMap[i].get("FamilyID");
            if(value.intValue() == id.intValue()) {
                title = (String) subfamilyMap[i].get("Title");
                return title;
            }
        }
        return title;
    }
        
}
