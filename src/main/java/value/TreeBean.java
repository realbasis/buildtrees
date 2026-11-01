/*
 * TreeBean.java
 *
 * Created on June 29, 2008, 8:42 AM
 */

package value;

import java.beans.*;
import java.io.Serializable;

import java.util.TreeMap;
import java.util.SortedMap;
import java.util.LinkedList;

/**
 * @author Lamine Ba
 */
public class TreeBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    public static int FATHER = 1;
    
    public static int MOTHER = 2;
    
    public static int SIBLINGS = 3;
    
    public static int BROTHER = 31;
    
    public static int SISTER = 32;
    
    public static int CHILDREN = 4;
    
    public static int SON = 41;
    
    public static int DAUGHTER = 42;
    
    public static int PARTNERS = 5;
    
    public static int WIFE_PARTNER = 51;
    
    public static int HUSBAND_PARTNER = 52;
    
    public static int BOYFRIEND = 66;
    
    public static int GIRLFRIEND = 67;
    
    public TreeMap titleMap;
    
    private SortedMap owner;
    
    private SortedMap it;
    
    private TreeMap me; // set in JSP
    
    private Integer peopleID;   // set in JSP
    
    private TreeMap father;
    
    private TreeMap mother;
    
    private LinkedList siblings;
    
    private int numSiblings;
    
    private LinkedList children;
    
    private int numChildren;
    
    private LinkedList partners;
    
    private int numPartners;
    
    private LinkedList friends;
    
    private SortedMap family[];     // set in JSP
    
    private SortedMap familyOtro[];
    
    private SortedMap sharers[];
    
    private LinkedList suggestions;
    
    private SortedMap members[];
    
    private LinkedList familyAll;
    
    private SortedMap links[];      // set in JSP
    
    private TreeMap fambypeople;
    
    private TreeMap fambytitle;
    
    private LinkedList events;
    
    private SortedMap eventsMap[];
    
    private String param1;
    
    private String param2;
    
    private LinkedList list;
    
    private String theText;
    
    private PeopleBean peopleBean;
    
    private String errors;
    
    private SortedMap peopleMap;
    
    public TreeBean() {
        propertySupport = new PropertyChangeSupport(this);

        errors = null;
        param1 = null;
        param2 = null;
        theText = null;
        peopleBean = null;
        peopleMap = null;
        
        list = null;
        owner = null;
        me = new TreeMap();
        peopleID = new Integer(-1);
        father = null;
        mother = null;
        
        siblings = new LinkedList();
        children = new LinkedList();
        partners = new LinkedList();
        friends = new LinkedList();
        
        numSiblings = 0;
        numPartners = 0;
        numChildren = 0;
        
        family = null;
        familyOtro = null;
        sharers = null;
        familyAll = null;
        links = null;
        fambypeople = new TreeMap();
        fambytitle = new TreeMap();
        
        titleMap = new TreeMap();
        titleMap.put("Father", new Integer(FATHER));
        titleMap.put("Mother", new Integer(MOTHER));
        titleMap.put("Siblings", new Integer(SIBLINGS));
        titleMap.put("Brother", new Integer(BROTHER));
        titleMap.put("Sister", new Integer(SISTER));
        titleMap.put("Children", new Integer(CHILDREN));
        titleMap.put("Son", new Integer(SON));
        titleMap.put("Daughter", new Integer(DAUGHTER));
        titleMap.put("Partner", new Integer(PARTNERS));
        titleMap.put("Wife_Partner", new Integer(WIFE_PARTNER));
        titleMap.put("Husband_Partner", new Integer(HUSBAND_PARTNER));
        titleMap.put("Boyfriend", new Integer(BOYFRIEND));
        titleMap.put("Girlfriend", new Integer(GIRLFRIEND));
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
    
    public String getErrors() {
        return errors;
    }
    
    public String getTheText() {
        return theText;
    }
    
    public void setTheText(String value) {
        theText = value;
    }
    
    public LinkedList getList() {
        return list;
    }
    
    public void setList(LinkedList value) {
        list = value;
    }
    
    public void setParam1(String value) {
        param1 = value;
    }
    
    public String getParam1() {
        return param1;
    }
    
    public void setParam2(String value) {
        param2 = value;
    }
    
    public String getParam2() {
        return param2;
    }
    
    public SortedMap getIt() {
        return it;
    }
    
    public void setIt(SortedMap value) {
        it = value;
    }
    
    public SortedMap getOwner() {
        return owner;
    }
    
    public void setOwner(SortedMap value) {
        owner = value;
    }
    
    public TreeMap getMe() {
        return me;
    }
    
    public Integer getPeopleID() {
        return peopleID;
    }
    
    public void setPeopleID(Integer value) {
        peopleID = value;
    }
    
    public void setMe(TreeMap value) {
        me = value;
    }
    
    public TreeMap getFather() {
        return father;
    }
    
    public void setFather(TreeMap value) {
        father = value;
    }
    
    public TreeMap getMother() {
        return mother;
    }
    
    public void setMother(TreeMap value) {
        mother = value;
    }
    
    public LinkedList getSiblings() {
        return siblings;
    }
    
    public void setSiblings(LinkedList value) {
        siblings = value;
    }
    
    public LinkedList getChildren() {
        return children;
    }
    
    public void setChildren(LinkedList value) {
        children = value;
    }
    
    public LinkedList getPartners() {
        return partners;
    }
    
    public void setPartners(LinkedList value) {
        partners = value;
    }
    
    public LinkedList getFriends() {
        return friends;
    }
    
    public void setFriends(LinkedList value) {
        friends = value;
    }
    
    public int getNumSiblings() {
        return numSiblings;
    }
    
    public void setNumSiblings(int value) {
        numSiblings = value;
    }
    
    public int getNumChildren() {
        return numChildren;
    }
    
    public void setNumChildren(int value) {
        numChildren = value;
    }
    
    public int getNumPartners() {
        return numPartners;
    }
    
    public void setNumPartners(int value) {
        numPartners = value;
    }
    
    public void setFamily(SortedMap value[]) {
        family = value;
    }
    
    public SortedMap[] getFamily() {
        return family;
    }
    
    public void setEventsMap(SortedMap value[]) {
        eventsMap = value;
    }
    
    public SortedMap[] getEventsMap() {
        return eventsMap;
    }
    
    public void setSharers(SortedMap value[]) {
        sharers = value;
    }
    
    public SortedMap[] getSharers() {
        return sharers;
    }
    
    public void setMembers(SortedMap value[]) {
        members = value;
    }
    
    public SortedMap[] getMembers() {
        return members;
    }
    
    public void setSuggestions(LinkedList list) {
        suggestions = list;
    }
    
    public LinkedList getSuggestions() {
        return suggestions;
    }
    
    public void setFamilyAll(LinkedList value) {
        familyAll = value;
    }
    
    public LinkedList getFamilyAll() {
        return familyAll;
    }
    
    public void setFamilyOtro(SortedMap value[]) {
        familyOtro = value;
    }
    
    public SortedMap[] getFamilyOtro() {
        return familyOtro;
    }
    
    public void setLinks(SortedMap value[]) {
        links = value;
    }
    
    public SortedMap[] getLinks() {
        return links;
    }
    
    public TreeMap getFambypeople() {
        return fambypeople;
    }
    
    public void setFambypeople(TreeMap value) {
        fambypeople = value;
    }
    
    public TreeMap getFambytitle() {
        return fambytitle;
    }
    
    public void setFambytitle(TreeMap value) {
        fambytitle = value;
    }
    
    public LinkedList getEvents() {
        return events;
    }
    
    public void setEvents(LinkedList value) {
        events = value;
    }
    
    public PeopleBean getPeopleBean() {
        return peopleBean;
    }
    
    public void setPeopleBean(PeopleBean value) {
        peopleBean = value;
    }
    
    public SortedMap getPeopleMap() {
        return peopleMap;
    }
    
    public void setPeopleMap(SortedMap value) {
        peopleMap = value;
    }
    
    
    
}
