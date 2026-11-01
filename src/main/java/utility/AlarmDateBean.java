/*
 * AlarmDateBean.java
 *
 * Created on June 14, 2009, 8:38 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;

import java.util.Date;
import java.util.Calendar;

/**
 * @author Lamine Ba
 */
public class AlarmDateBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Date date;
    
    private Date newDate;
    
    private long days;
    
    private String errors;
    
    private boolean processed;
    
    public AlarmDateBean() {
        propertySupport = new PropertyChangeSupport(this);
        date = null;
        errors = null;
        days = 0;
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
    
    public void setDate(Date value) {
        date = value;
    }
    
    public void setDays(long value) {
        days = value;
    }
    
    public Date getNewDate() {
        return newDate;
    }
    
    public boolean isProcessed() {
        boolean success = true;
        
        Calendar now, eventDate, alarmDate;
        int day, month, year;
        long span;
        
        now = Calendar.getInstance();
        day = now.get(Calendar.DAY_OF_MONTH);
        month = now.get(Calendar.MONTH);
        year = now.get(Calendar.YEAR);
        now.clear();
        now.set(year, month, day);
        
        eventDate = Calendar.getInstance();
        eventDate.setTime(this.date);
        if(eventDate.before(now)) {
            errors = "invalid date";
            return false;
        }
        
        span = eventDate.getTimeInMillis() - (this.days)*3600*24*1000;
        alarmDate = Calendar.getInstance();
        alarmDate.setTimeInMillis(span);
        if(alarmDate.before(now)) {
            errors = "alarm is too soon";
            return false;
        }
        
        this.newDate = alarmDate.getTime();
        
        return success;
    }
    
    public String getErrors() {
        return errors;
    }
    
}
