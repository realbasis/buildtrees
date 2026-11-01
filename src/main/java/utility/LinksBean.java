/*
 * LinksBean.java
 *
 * Created on April 29, 2008, 9:33 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.SortedMap;
import java.util.LinkedList;
import java.util.Collection;

/**
 * @author Lamine Ba
 */
public class LinksBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String relationship;     // set in JSP
    
    private SortedMap fambypeople;  // set
    
    private SortedMap links[];      // set in JSP
    
    private Integer peopleID;
    
    private LinkedList people;
    
    private int peopleSize;
    
    private LinkedList men;
    
    private int menSize;
    
    private LinkedList women;
    
    private int womenSize;
    
    private LinkedList human;
    
    private String gender;
    
    private boolean builded;
    
    private boolean listed;
    
    public LinksBean() {
        propertySupport = new PropertyChangeSupport(this);
        relationship = null;
        fambypeople = null;
        links = null;
        peopleID = null;
        men = new LinkedList();
        menSize = 0;
        women = new LinkedList();
        womenSize = 0;
        people = new LinkedList();
        peopleSize = 0;
        gender = null;
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
    
    public void setFambypeople(SortedMap value) {
        fambypeople = value;
    }
    
    public void setLinks(SortedMap value[]) {
        links = value;
    }
    
    public void setPeopleID(Integer value) {
        peopleID = value;
    }
    
    public LinkedList getMen() {
        return men;
    }
    
    public int getMenSize() {
        menSize = men.size();
        return menSize;
    }
    
    public LinkedList getWomen() {
        return women;
    }
    
    public int getWomenSize() {
        womenSize = women.size();
        return womenSize;
    }
    
    public LinkedList getPeople() {
        return people;
    }
    
    public int getPeopleSize() {
        peopleSize = people.size();
        return peopleSize;
    }
    
    public LinkedList getHuman() {
        return human;
    }
    
    public String getGender() {
        return gender;
    }
    
    public boolean isBuilded() {
       boolean success = true;
       int size = 0;
       Integer selfID = null;
       SortedMap map = null;
       Object obj[] = null;
       
       /*** build my family based on peopleID ***/
       size = links.length;
       map = this.fambypeople;
       
       map.remove(peopleID);        // remove profile of interest
       for(int i=0; i<size; i++) {
           selfID = (Integer) links[i].get("SelfID");
           if( selfID.intValue() == this.peopleID.intValue() ) {
               Integer elseID = (Integer) links[i].get("ElseID");
               map.remove(elseID);
           }
       }
       
       size = map.size();
       obj = map.values().toArray();
       for(int i=0; i<size; i++) {
           people.addLast((SortedMap) obj[i]);
           String gender = (String) ((SortedMap) obj[i]).get("Gender");
           if(gender.equals("Male"))
               men.addLast((SortedMap) obj[i]);
           else if(gender.equals("Female"))
               women.addLast((SortedMap) obj[i]);
           else
               return false;
       }
              
       return success;
    }
    
    public boolean isListed() {
        boolean success = true;
        
        if(relationship.equals("Father")) {
            gender = new String("Male");
            if(men.size() > 0) {
                human = men;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Mother")) {
            gender = new String("Female");
            if(women.size() > 0) {
                human = women;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Husband_Partner")) {
            gender = new String("Male");
            if(men.size() > 0) {
                human = men;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Wife_Partner")) {
            gender = new String("Female");
            if(women.size() > 0) {
                human = women;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Son")) {
            gender = new String("Male");
            if(men.size() > 0) {
                human = men;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Daughter")) {
            gender = new String("Female");
            if(women.size() > 0) {
                human = women;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Brother")) {
            gender = new String("Male");
            if(men.size() > 0) {
                human = men;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Sister")) {
            gender = new String("Female");
            if(women.size() > 0) {
                human = women;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Boyfriend")) {
            gender = new String("Male");
            if(men.size() > 0) {
                human = men;
                return true;
            }
            else
                return false;
        }
        else if(relationship.equals("Girlfriend")) {
            gender = new String("Female");
            if(women.size() > 0) {
                human = women;
                return true;
            }
            else
                return false;
        }
        
        return success;
    }
    
}
