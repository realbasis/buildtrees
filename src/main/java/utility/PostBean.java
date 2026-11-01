/*
 * PostBean.java
 *
 * Created on July 1, 2007, 1:44 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.LinkedList;
import java.util.Date;
import java.util.Calendar;
import java.util.ArrayList;
import value.*;

/**
 * @author Lamine Ba
 */
public class PostBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Integer aid;
    
    private SortedMap birthdateMap[];
    
    private SortedMap deceasedMap[];
    
    private SortedMap postsMap[];
    
    private LinkedList listAnniv;
    
    private LinkedList listEvents;
    
    private int listSize;
    
    private ConnBean connBean;
    
    private TreeBean treeBean;
    
    private boolean processed;
    
    private boolean  builded;
    
    private String errors;
    
    public PostBean() {
        propertySupport = new PropertyChangeSupport(this);
        connBean = null;
        treeBean = null;
        birthdateMap = null;
        deceasedMap = null;
            
        listAnniv = new LinkedList();
        listEvents = new LinkedList();
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
    
    public void setBirthdateMap(SortedMap value[]) {
        birthdateMap = value;
    }
    
    public void setDeceasedMap(SortedMap value[]) {
        deceasedMap = value;
    }
    
    public void setPostsMap(SortedMap value[]) {
        postsMap = value;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public TreeBean getTreeBean() {
        return treeBean;
    }
    
    public void setTreeBean(TreeBean value) {
        treeBean = value;
    }
    
    public Integer getAid() {
        return aid;
    }
    
    public void setAid(Integer value) {
        aid = value;
    }
    
    public boolean isBuilded() {
        boolean success = true;
        
        SortedMap eventsMap[];
        String query = null;
        ArrayList values = null;
        SortedMap maps[] = null;
        SortedMap map = null;
        TreeMap zMap = null;
        int size = 0;
        LinkedList familyList = null;
        Integer accountID = null;
        AuthorBean authorBean = null;
        
        
        authorBean = new AuthorBean();
        authorBean.setList(this.treeBean.getFamilyAll());
        
        this.listAnniv = new LinkedList();
        this.listEvents = new LinkedList();
        
        familyList = treeBean.getFamilyAll();
        if(familyList != null)
            size = familyList.size();
        
        for(int i=0; i<size; i++) {
            map = (SortedMap) familyList.get(i);
            
            // check if there is birthday
            String gotBirthdate = (String) map.get("GotBirthdate");
            if(gotBirthdate.equals("on")) {
                zMap = new TreeMap();
                zMap.put("PeopleID", map.get("PeopleID"));
                zMap.put("Date", map.get("Birthdate"));
                zMap.put("Type", "Birthday");
                zMap.put("Name", map.get("Name"));
                zMap.put("Email", map.get("Email"));
                
                accountID = (Integer) map.get("AccountID");
                if(accountID.intValue() == this.aid.intValue())
                    zMap.put("Author", "me");
                else {
                    authorBean.setId(accountID);
                    zMap.put("Author", authorBean.getName());
                }
                    
                
                this.insertInList(zMap);
            }
            
            map = (SortedMap) familyList.get(i);
            String isDeceased = (String) map.get("IsDeceased");
            if(isDeceased.equals("on")) {
                zMap = new TreeMap();
                zMap.put("PeopleID", map.get("PeopleID"));
                zMap.put("Date", map.get("Deceased"));
                zMap.put("Type", "Death");
                zMap.put("Name", map.get("Name"));
                zMap.put("Email", map.get("Email"));
                
                accountID = (Integer) map.get("AccountID");
                if(accountID.intValue() == this.aid.intValue())
                    zMap.put("Author", "me");
                else {
                    authorBean.setId(accountID);
                    zMap.put("Author", authorBean.getName());
                }
                
                this.insertInList(zMap);
            }
        }
            
        // Get all customized family events
        eventsMap = this.treeBean.getEventsMap();
        if(eventsMap == null)               // not loaded yet in this session
            eventsMap = new SortedMap[0];
        
        // get today
        Calendar calToday = Calendar.getInstance();
        int dateToday, monthToday, yearToday;
        dateToday = calToday.get(Calendar.DATE);
        monthToday = calToday.get(Calendar.MONTH);
        yearToday = calToday.get(Calendar.YEAR);
        calToday.clear();
        calToday.set(yearToday, monthToday, dateToday);
        
        Calendar calAlarm = Calendar.getInstance();
        size = eventsMap.length;
        for(int i=0; i<size; i++) {
            
            calAlarm.setTime((Date) eventsMap[i].get("AlarmDate"));
            if(calAlarm.after(calToday)) {
                accountID = (Integer) eventsMap[i].get("AccountID");
                if(accountID.intValue() == this.aid.intValue())
                    eventsMap[i].put("Author", "me");
                else {
                    authorBean.setId(accountID);
                    eventsMap[i].put("Author", authorBean.getName());
                }
                eventsMap[i].put("Rang", "no");
                this.insertInList2(eventsMap[i]);
            }
            
        }
        
        return success;
    }
    
    public boolean isProcessed() {

        boolean success = true;
        SortedMap eventsMap[];
        String query = null;
        ArrayList values = null;
        SortedMap map[] = null;
        TreeMap zMap = null;
        int size = 0;
        
        this.listAnniv = new LinkedList();
        this.listEvents = new LinkedList();
        
        this.connBean = new ConnBean();
        success = this.connBean.isStarted();
        if(!success) {
            this.errors = this.connBean.getErrors();
            return false;
        }
        
        // Get all birthdays
        values = new ArrayList();
        values.add(aid);
        values.add("on");
        query = "Select * From Zpeople Where AccountID = ? And GotBirthdate = ? Order By Birthdate";
        this.birthdateMap = this.connBean.select(query, values);
        if(this.birthdateMap == null) {
            this.errors = this.connBean.getErrors();
            return false;
        }
        size = this.birthdateMap.length;
        for(int i=0; i<size; i++) {
            zMap = new TreeMap();
            zMap.put("PeopleID", birthdateMap[i].get("PeopleID"));
            zMap.put("Date", birthdateMap[i].get("Birthdate"));
            zMap.put("Author", "me");
            zMap.put("Type", "Birthday");
            zMap.put("Name", birthdateMap[i].get("Name"));
            zMap.put("Email", birthdateMap[i].get("Email"));
            this.insertInList(zMap);
        }
        
        // Get all deceased anniversaries
        values = new ArrayList();
        values.add(aid);
        values.add("on");
        query = "Select * From Zpeople Where AccountID = ? And IsDeceased = ? Order By Deceased";
        this.deceasedMap = this.connBean.select(query, values);
        if(this.deceasedMap == null) {
            this.errors = this.connBean.getErrors();
            return false;
        }
        size = this.deceasedMap.length;
        for(int i=0; i<size; i++) {
            zMap = new TreeMap();
            zMap.put("PeopleID", this.deceasedMap[i].get("PeopleID"));
            zMap.put("Date", this.deceasedMap[i].get("Deceased"));
            zMap.put("Author", "me");
            zMap.put("Type", "Death");
            zMap.put("Name", this.deceasedMap[i].get("Name"));
            zMap.put("Email", this.deceasedMap[i].get("Email"));
            this.insertInList(zMap);
        }
        
        // Get all customized family events
        values = new ArrayList();
        values.add(aid);
        query = "Select * From Zevents Where AccountID = ? Order By AlarmDate";
        eventsMap = this.connBean.select(query, values);
        if(eventsMap == null) {
            this.errors = this.connBean.getErrors();
            return false;
        }
        
        // get today
        Calendar calToday = Calendar.getInstance();
        int dateToday, monthToday, yearToday;
        dateToday = calToday.get(Calendar.DATE);
        monthToday = calToday.get(Calendar.MONTH);
        yearToday = calToday.get(Calendar.YEAR);
        calToday.clear();
        calToday.set(yearToday, monthToday, dateToday);
        
        Calendar calAlarm = Calendar.getInstance();
        size = eventsMap.length;
        for(int i=0; i<size; i++) {
            calAlarm.setTime((Date) eventsMap[i].get("AlarmDate"));
            if(calAlarm.after(calToday)) {
                eventsMap[i].put("Author", "me");
                eventsMap[i].put("Rang", "no");
                this.insertInList2(eventsMap[i]);
            }
        }
        
        // Get other Accounts
        //values = new ArrayList();
        //values.add(aid);
        //query = "Select Distinct OtherID From Zlinks Where AccountID = ? And OtherID > 0";
        //map = this.connBean.select(query, values);
        //if(map == null) {
          //  this.errors = this.connBean.getErrors();
          //  return false;
        //}
        
        //size = map.length;
        //for(int k=0; k<size; k++) {
            // Get accountID
            //values = new ArrayList();
            //values.add((Integer) map[k].get("OtherID"));
            //query = "Select * From Zpeople Where PeopleID = ?";
            //SortedMap jMap[] = null;
            //jMap = this.connBean.select(query, values);
            //if(jMap == null) {
              //  this.errors = this.connBean.getErrors();
              //  return false;
            //}
            //if(jMap.length != 1) {
              //  this.errors = "u98";
              //  return false;
            //}
            //Integer jAccountID = (Integer) jMap[0].get("AccountID");
            //String jAuthor = (String) jMap[0].get("Name");
            //int osize = 0;
            
            // Get all birthdays
            //values = new ArrayList();
            //values.add(jAccountID);
            //values.add("on");
            //query = "Select * From Zpeople Where AccountID = ? And GotBirthdate = ? Order By Birthdate";
            //SortedMap otherBirthMaps[] = null;
            //otherBirthMaps = this.connBean.select(query, values);
            //if(otherBirthMaps == null) {
              //  this.errors = this.connBean.getErrors();
               // return false;
          //  }
        
          SortedMap otherBirthMaps[] = null;
          SortedMap sharers[] = this.treeBean.getSharers();
          SortedMap fambypeople = this.treeBean.getFambypeople();
          SortedMap oneMap = null;
          TreeMap authorsMap = null;
          String gotBirthdate = null;
          String deceased = null;
          int osize = 0;
          int authorSize = 0;
          Integer IntId = null;
          
          // Build authorsMap
          authorSize = sharers.length;
          authorsMap = new TreeMap();
          for(int l=0; l<authorSize; l++) {
              IntId = new Integer(((Long) sharers[l].get("AccountID")).intValue());
              authorsMap.put(IntId, sharers[l].get("Name"));
          }
            
          otherBirthMaps = this.treeBean.getFamilyOtro();
          osize = otherBirthMaps.length;
            for(int l=0; l<osize; l++) {
                oneMap = otherBirthMaps[l];
                gotBirthdate = (String) oneMap.get("GotBirthdate");
                if(gotBirthdate.equals("on") == true) {   
                    zMap = new TreeMap();
                    zMap.put("PeopleID", oneMap.get("PeopleID"));
                    zMap.put("Date", oneMap.get("Birthdate"));
                    zMap.put("Author", (String) authorsMap.get(oneMap.get("AccountID")));
                    zMap.put("Type", "Birthday");
                    zMap.put("Name", oneMap.get("Name"));
                    zMap.put("Email", oneMap.get("Email"));
                    this.insertInList(zMap);
                }
                
                deceased = (String) oneMap.get("IsDeceased");
                if(deceased.equals("on") == true) {
                    zMap = new TreeMap();
                    zMap.put("PeopleID", oneMap.get("PeopleID"));
                    zMap.put("Date", oneMap.get("Deceased"));
                    zMap.put("Author", authorsMap.get(oneMap.get("AccountID")));
                    zMap.put("Type", "Death");
                    zMap.put("Name", oneMap.get("Name"));
                    zMap.put("Email", oneMap.get("Email"));
                    this.insertInList(zMap);
                }
        
            // Get all deceased anniversaries
            //values = new ArrayList();
            //values.add(jAccountID);
            //values.add("on");
            //query = "Select * From Zpeople Where AccountID = ? And IsDeceased = ? Order By Deceased";
            //SortedMap otherDeceasedMaps[] = null;
            //otherDeceasedMaps = this.connBean.select(query, values);
            //if(otherDeceasedMaps == null) {
              //  this.errors = this.connBean.getErrors();
                //return false;
            //}
            //osize = otherDeceasedMaps.length;
            //for(int l=0; l<osize; l++) {
              //  zMap = new TreeMap();
              //  zMap.put("PeopleID", otherDeceasedMaps[l].get("PeopleID"));
              //  zMap.put("Date", otherDeceasedMaps[l].get("Deceased"));
              //  zMap.put("Author", jAuthor);
              //  zMap.put("Type", "Death");
              //  zMap.put("Name", otherDeceasedMaps[l].get("Name"));
              //  zMap.put("Email", otherDeceasedMaps[l].get("Email"));
              //  this.insertInList(zMap);
            //}
            
            // Get all customized family events
/*
            values = new ArrayList();
            values.add(jAccountID);
            query = "Select * From Zevents Where AccountID = ? Order By AlarmDate";
            eventsMap = this.connBean.select(query, values);
            if(eventsMap == null) {
                this.errors = this.connBean.getErrors();
                return false;
            }
        
            size = eventsMap.length;
            for(int i=0; i<size; i++) {
                eventsMap[i].put("Author", jAuthor);
                eventsMap[i].put("Rang", "no");
                this.insertInList2(eventsMap[i]);
            }
*/            
        }
        
        // update treeBean
        //this.treeBean.setEvents(this.list);
        
        success = this.connBean.isClosed();
        if(!success) {
            this.errors = this.connBean.getErrors();
        }
        
        return success;
    }
    
    private boolean insertInList2(SortedMap value) {
        /* Map [EventID] [EventDate] [AlarmDays] [AlarmDate] [Type] [Comment] */
        
        boolean success = true;
        int size;
        int year, month, date;
        Date alarmDate, eventDate;
        Date alarmDateItem;
        SortedMap map;
        
        size = this.listEvents.size();
        if(size == 0) {
            this.listEvents.addLast(value);
            return true;
        }
        
        Calendar alarmCal = Calendar.getInstance();
        alarmDate = (Date) value.get("AlarmDate");
        alarmCal.setTime(alarmDate);
        
        boolean inlist = false;
        for(int i=0; i<size; i++) {
            map = (SortedMap) this.listEvents.get(i);
            alarmDateItem = (Date) map.get("AlarmDate");
            if(alarmDate.before(alarmDateItem)) {
                this.listEvents.add(i, value);
                inlist = true;
                break;
            }
        }
        if(!inlist) {
            this.listEvents.addLast(value);
        }
        
        return success;
    }
    
    private boolean insertInList(SortedMap value) {
        /* Map [PeopleID] [Date] [Days] [Name] [Type] [Author] */
        
        boolean success = true;
        int year = 0;
        int doy = 0;
        int doyRef = 0;
        
        Calendar now = Calendar.getInstance();
        now.set(Calendar.HOUR_OF_DAY, 0);
        now.set(Calendar.MINUTE, 0);
        now.set(Calendar.SECOND, 0);
        year = now.get(Calendar.YEAR);
        doy = now.get(Calendar.DAY_OF_YEAR);
        
        Calendar cal = Calendar.getInstance();
        Date date = (Date) value.get("Date");
        cal.setTime(date);
        
        Calendar calRef = Calendar.getInstance();
        calRef.setTime(date);
        calRef.set(Calendar.YEAR, year);
        doyRef = calRef.get(Calendar.DAY_OF_YEAR);
        
        int days = 0;
        int age = -1;
        
        //if(calRef.before(now)) {
        if(doyRef < doy) {
            // increase a year
            year++;
            calRef.set(Calendar.YEAR, year);
            days = calRef.get(Calendar.DAY_OF_YEAR) + (now.getActualMaximum(Calendar.DAY_OF_YEAR) - now.get(Calendar.DAY_OF_YEAR));
            age = calRef.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
        }
        else {
            days = calRef.get(Calendar.DAY_OF_YEAR) - now.get(Calendar.DAY_OF_YEAR);
            age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
        }
        value.put("Days", new Integer(days));
        value.put("Age", new Integer(age));
        
        // insert in list in order
        this.listSize = listAnniv.size();
        SortedMap lMap;
        boolean inserted = false;
        for(int h=0; h<listSize; h++) {
                
            lMap = (SortedMap) listAnniv.get(h);
            Integer lDays = (Integer) lMap.get("Days");
            if(days < lDays.intValue()) {
                listAnniv.add(h, value);
                inserted = true;
                break;
            }

        }
        
        if(!inserted)
            listAnniv.addLast(value);
        
        return success;
    }
    
    public LinkedList getListAnniv() {
        return listAnniv;
    }
    
    public LinkedList getListEvents() {
        return this.listEvents;
    }
    
    public LinkedList getList2() {
        // Get events for the next two weeks
        Calendar now = Calendar.getInstance();
        now.set(Calendar.HOUR_OF_DAY, 0);
        now.set(Calendar.MINUTE, 0);
        now.set(Calendar.SECOND, 0);
        Calendar hier = now;
        hier.add(Calendar.DAY_OF_YEAR, -1);
        Calendar cal = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        Calendar nextYear = Calendar.getInstance();
        
        listAnniv = new LinkedList();
        int size;
        String type;
        String firstName;
        String lastName;
        String email;
        Integer peopleID;
        SortedMap map;
        SortedMap map2;
        int age = 0;
        int days = 0;
        
        
        // case birthdates
        size = birthdateMap.length;
        for(int i=0; i<size; i++) {
            type = new String("Birthdate");
            if( ((String) birthdateMap[i].get("IsDeceased")).equalsIgnoreCase("on") == true )
                type = new String("Birthdate2");
            
            firstName = (String) birthdateMap[i].get("FirstName");
            lastName = (String) birthdateMap[i].get("LastName");
            peopleID = (Integer)birthdateMap[i].get("PeopleID");
            email = (String) birthdateMap[i].get("Email");
            
            Date birthdate = (Date) birthdateMap[i].get("Birthdate");
            cal.setTime(birthdate);
            age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
            cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
            
            if(cal.before(hier)) {
                cal.add(Calendar.YEAR, 1);
                age++;
                days = 1000;
            }
            else
                days = cal.get(Calendar.DAY_OF_YEAR) - now.get(Calendar.DAY_OF_YEAR) - 1;
            
            
            
            map = new TreeMap();
            map.put("DateRef", cal.getTime());
            map.put("DateStamp", birthdate);
            map.put("Type", type);
            map.put("FirstName", firstName);
            map.put("LastName", lastName);
            map.put("Email", email);
            map.put("PeopleID", peopleID);
            map.put("Msg", "");
            map.put("Age", new Integer(age));
            map.put("Days", new Integer(days));
            
            this.listSize = listAnniv.size();
            
            for(int k=0; k<listSize; k++) {
                
                map2 = (SortedMap) listAnniv.get(k);
                Date dateRef = (Date) map2.get("DateRef");
                cal2.setTime(dateRef);

                if(cal.before(cal2)) {
                    listAnniv.add(k, map);
                    break;
                }
 
                if(k == (listSize-1)) {
                    if(cal.before(cal2) == false)
                        listAnniv.addLast(map);
                }
            }

            if(listSize == 0)
                listAnniv.addFirst(map);

        }
        
        // case deceased
        size = deceasedMap.length;
        for(int j=0; j<size; j++) {
            type = new String("Deceased");
            firstName = (String) deceasedMap[j].get("FirstName");
            lastName = (String) deceasedMap[j].get("LastName");
            peopleID = (Integer) deceasedMap[j].get("PeopleID");
            
            Date deceased = (Date) deceasedMap[j].get("Deceased");
            cal.setTime(deceased);
            age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
            cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
            if(cal.before(hier)) {
                cal.add(Calendar.YEAR, 1);
                age++;
            }
            else
                days = cal.get(Calendar.DAY_OF_YEAR) - now.get(Calendar.DAY_OF_YEAR) - 1;
            
            map = new TreeMap();
            map.put("DateRef", cal.getTime());
            map.put("DateStamp", deceased);
            map.put("Type", type);
            map.put("FirstName", firstName);
            map.put("LastName", lastName);
            map.put("PeopleID", peopleID);
            map.put("Msg", "");
            map.put("Age", new Integer(age));
            map.put("Days", new Integer(days));
            
            this.listSize = listAnniv.size();
            
            for(int l=0; l<listSize; l++) {
                
                map2 = (SortedMap) listAnniv.get(l);
                Date dateRef = (Date) map2.get("DateRef");
                cal2.setTime(dateRef);

                if(cal.before(cal2)) {
                    listAnniv.add(l, map);
                    break;
                }
 
                if(l == (listSize-1)) {
                    if(cal.before(cal2) == false)
                        listAnniv.addLast(map);
                }
            }
            
            if(listSize == 0)
                listAnniv.addFirst(map);
                
        }
        
        return listAnniv;
    }
    
    public int getListSize() {
        if(listAnniv != null)
            return this.listAnniv.size();
        else
            return 0;
    }
}
