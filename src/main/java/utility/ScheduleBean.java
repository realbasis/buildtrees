/*
 * ScheduleBean.java
 *
 * Created on August 12, 2007, 11:07 AM
 */

package utility;

import java.beans.*;
import java.io.Serializable;

import java.util.Timer;
import java.util.TimerTask;

import api.PeopleSql;
import api.NotifyClass;

/**
 * @author Lamine Ba
 */
public class ScheduleBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    static int SEC = 1000;
    
    static int MIN = 60*SEC;
    
    static int HOUR = 60*MIN;
    
    static int DAY = 24*HOUR;
    
    static int WEEK = 7*DAY;
    
    private int lapse;
    
    private int delay0;
    
    private boolean started;
    
    private Timer timer;
    
    private boolean canceled;
    
    private String status;
    
    public ScheduleBean() {
        propertySupport = new PropertyChangeSupport(this);
        timer = null;
        status = new String("stopped");
        delay0 = 1;
        lapse = 1440;
        
    }
    
    public boolean isStarted() {
        long initialDelay = delay0*MIN; // start after x seconds
        long period = lapse*MIN;        // repeat every x seconds
        this.timer = new Timer();
        
        TimerTask task = new TimerTask() {
            public boolean successSql;
            public boolean successRun;
            public void run() {
                /*** job code here ***/
                
                // Get people and links
                //PeopleSql peopleSql = new PeopleSql();
                NotifyClass notifyClass = new NotifyClass();
                successRun = notifyClass.run();
                
            }
        };
        
        timer.scheduleAtFixedRate(task, initialDelay, period);
        this.status = new String("running");
        
        return true;
    }
    
    public boolean isCanceled() {
        timer.cancel();
        this.status = new String("stopped");
        return true;
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
    
    public void setLapse(int value) {
        lapse = value;
    }
    
    public int getLapse() {
        return lapse;
    }
    
    public void setDelay0(int value) {
        delay0 = value;
    }
    
    public int getDelay0() {
        return delay0;
    }
    
    public Timer getTimer() {
        return timer;
    }
    
    public String getStatus() {
        return status;
    }
    
}
