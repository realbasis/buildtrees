/*
 * PeopleBean.java
 *
 * Created on May 10, 2008, 4:31 PM
 */

package value;

import java.beans.*;
import java.io.Serializable;
import java.util.Date;
import java.io.InputStream;
import java.util.SortedMap;
import java.sql.Blob;

/**
 * @author Lamine Ba
 */
public class PeopleBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer peopleID;
    
    private String name;
    
    private String email;
    
    private String title;
    
    private String gotBirthdate;
    
    private Date birthdate;
    
    private String isDeceased;
    
    private Date deceased;
    
    private String gender;
    
    private String imageName;
    
    private InputStream imageIn;
    
    private Blob image;
    
    private String father;
    
    private String mother;
    
    private String children;
    
    private Integer accountID;
    
    private SortedMap peopleMap;
    
    private Date creationDate;
    
    public PeopleBean() {
        propertySupport = new PropertyChangeSupport(this);
        gotBirthdate = new String("off");
        birthdate = null;
        isDeceased = new String("off");
        deceased = null;
        peopleID = null;
        accountID = null;
        imageName = new String("none");
        image = null;
        imageIn = null;
        title = null;
        father = null;
        mother = null;
        children = null;
        creationDate = null;
        peopleMap = null;
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
    
    public void setPeopleID(Integer value) {
        peopleID = value;
    }
    
    public Integer getPeopleID() {
        return peopleID;
    }
    
    public void setTitle(String value) {
        title = value;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setName(String value) {
        name = value;
    }
    
    public String getName() {
        return name;
    }
    
    public void setEmail(String value) {
        email = value;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getImageName() {
        return imageName;
    }
    
    public void setImageName(String value) {
        imageName = value;
    }
    
    public Blob getImage() {
        return image;
    }
    
    public void setImage(Blob value) {
        image = value;
    }
    
    public InputStream getImageIn() {
        return imageIn;
    }
    
    public void setImageIn(InputStream value) {
        imageIn = value;
    }
    
    public void setGotBirthdate(String value) {
        gotBirthdate = value;
    }
    
    public String getGotBirthdate() {
        return gotBirthdate;
    }
    
    public void setBirthdate(Date value) {
        birthdate = value;
    }
    
    public Date getBirthdate() {
        return birthdate;
    }
    
    public void setIsDeceased(String value) {
        isDeceased = value;
    }
    
    public String getIsDeceased() {
        return isDeceased;
    }
    
    public void setDeceased(Date value) {
        deceased = value;
    }
    
    public Date getDeceased() {
        return deceased;
    }
    
    public void setGender(String value) {
        gender = value;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setFather(String value) {
        father = value;
    }
    
    public String getFather() {
        return father;
    }
    
    public void setMother(String value) {
        mother = value;
    }
    
    public String getMother() {
        return mother;
    }
    
    public void setChildren(String value) {
        children = value;
    }
    
    public String getChildren() {
        return children;
    }
    
    public void setAccountID(Integer value) {
        accountID = value;
    }
    
    public Integer getAccountID() {
        return accountID;
    }
    
    public void setCreationDate(Date value) {
        creationDate = value;
    }
    
    public Date getCreationDate() {
        return creationDate;
    }

    public SortedMap getPeopleMap() {
        return peopleMap;
    }
    
    public void setPeopleMap(SortedMap value) {
        peopleMap = value;
    }

}
