/*
 * ConfigBean.java
 *
 * Created on March 6, 2007, 8:26 PM
 */

package utility;

import java.beans.*;
import java.io.Serializable;

/**
 * @author Lamine Ba
 */
public class ConfigBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String hostname;
    
    private String smtpServer;
    
    private String hostpath;
    
    private String serverEmail;
        
    public ConfigBean() {
        propertySupport = new PropertyChangeSupport(this);
        
        /*** SMTP server / host (configurable, see appconfig.AppConfig) ***/
        smtpServer = appconfig.AppConfig.get("mail.smtp.host", "none");
        hostpath = appconfig.AppConfig.get("app.hostpath", "http://localhost");
        hostname = appconfig.AppConfig.get("app.hostname", "localhost");
        
        serverEmail = appconfig.AppConfig.mailFrom();

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
    
    public String getHostname() {
        return hostname;
    }
    
    public String getSnmpServer() {
        return smtpServer;
    }
    
    public String getHostpath() {
        return hostpath;
    }
    
    public String getServerEmail() {
        return serverEmail;
    }
    
}
