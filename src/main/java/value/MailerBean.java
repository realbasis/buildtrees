/*
 * MailerBean.java
 *
 * Created on August 19, 2008, 12:52 PM
 */

package value;

import java.beans.*;
import java.io.Serializable;

/**
 * @author Lamine Ba
 */
public class MailerBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String smtp;
    
    private Integer port;
    
    private String password;
	
	private String username;
    
    public MailerBean() {
        propertySupport = new PropertyChangeSupport(this);
        // SMTP settings now come from buildtrees.properties (see appconfig.AppConfig)
        smtp = appconfig.AppConfig.smtpHost();
        port = Integer.valueOf(appconfig.AppConfig.smtpPort());
        password = appconfig.AppConfig.smtpPassword();
        username = appconfig.AppConfig.smtpUser();
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
    
    public String getSmtp() {
        return smtp;
    }
    
    public Integer getPort() {
        return port;
    }
    
    public String getPassword() {
        return password;
    }
	
	public String getUsername() {
        return username;
    }
    
}
