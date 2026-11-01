/*
 * SpamBean.java
 *
 * Created on March 13, 2008, 4:09 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;
import java.util.Random;

/**
 * @author Lamine Ba
 */
public class SpamBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private Random random;
    
    private int spam1;
    
    private int spam2;
    
    private int spam;
   
    
    public SpamBean() {
        propertySupport = new PropertyChangeSupport(this);
        random = new Random();
        this.spam1 = random.nextInt(11);
        this.spam2 = random.nextInt(11);
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
    
    public void setSpam1(int value) {
        spam1 = value;
    }
    
    public void setSpam2(int value) {
        spam2 = value;
    }
    
    public int getSpam() {
        return spam;
    }
    
    public int getSpam1() {
        return spam1;
    }
    
    public int getSpam2() {
        return spam2;
    }
    
}
