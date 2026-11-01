/*
 * EventsSchedBean.java
 *
 * Created on April 4, 2009, 7:26 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Calendar;

/**
 * @author Lamine Ba
 */
public class EventsSchedBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String dateRef;
    
    private int dayRef;
    
    private int monthRef;
    
    private int yearRef;
    
    private String errors;
    
    private boolean scheduled;
    
    public EventsSchedBean() {
        propertySupport = new PropertyChangeSupport(this);
        dayRef = -1;
        monthRef = -1;
        yearRef = -1;
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
    
    public boolean isScheduled() {
        boolean schedule = true;
        int day = 0;
        int month = 0;
        int year = 0;
        
        Calendar cal = Calendar.getInstance();
        day = cal.get(Calendar.DAY_OF_MONTH);
        month = cal.get(Calendar.MONTH);
        year = cal.get(Calendar.YEAR);
        
        if(dayRef == day && monthRef == month && yearRef == year) {
            // case script already executed.  no need to schedule it
            errors = null;
            return (!schedule);
        }
        
        // case when date does not match! then execute script
        dayRef = day;
        monthRef = month;
        yearRef = year;
        
        return schedule;
        
        
    }
    
    public String getErrors() {
        return errors;
    }
    
}
