/*
 * ConnBean.java
 *
 * Created on May 13, 2008, 12:13 AM
 */

package value;

import java.beans.*;
import java.io.Serializable;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import sql.SQLCommandBean;
import javax.servlet.jsp.jstl.sql.Result;
import java.sql.ResultSet;
import java.util.List;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.SortedMap;

/**
 * @author Lamine Ba
 */
public class ConnBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String nomDriver = appconfig.AppConfig.dbDriver();
    
    private String url = appconfig.AppConfig.dbUrl();
    
    private String user = appconfig.AppConfig.dbUser();
    
    private transient String passwd = appconfig.AppConfig.dbPassword();
    
    public Connection conn;
    
    private String errors;
    
    private boolean started;
    
    private boolean closed;
    
    private boolean selected;
    
    public ConnBean() {
        propertySupport = new PropertyChangeSupport(this);
        conn = null;
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
    
    public Connection getConn() {
        return conn;
    }
    
    public String getUrl() {
        return url;
    }
    
    public String getPasswd() {
        return passwd;
    }
    
    public String getUser() {
        return user;
    }
    
    public String getErrors() {
        return errors;
    }
    
    public boolean isStarted() {
        try {
            // pooled JNDI DataSource (jdbc/LinkedDB) or DriverManager fallback, see appconfig.Db
            conn = appconfig.Db.getConnection();
        }
        catch (SQLException ex2) {
            errors = "Connexion non effectuée: " + ex2;
            return false;
        }
        return true;
    }
    
    public boolean isClosed() {
        boolean success = true;
        
        try {
                if(conn == null || conn.isClosed() == true) {
                    errors = new String("dB already closed");
                    return false;
                }
                // The original code ran with autoCommit(false) and never committed
                // (fine on MyISAM). Commit here so InnoDB tables keep the changes.
                if(!conn.getAutoCommit()) {
                    conn.commit();
                    conn.setAutoCommit(true);   // hand a clean connection back to the pool
                }
                conn.close();
            }
            catch (SQLException e) {
                errors = new String("dB could not close");
                return false;
            } // Ignore
        
        return success;
    }
    
    public SortedMap[] select(String strg, ArrayList values) {
        
        /*** get family ***/
        SQLCommandBean sqlCommandBean = new SQLCommandBean();
        
        try {
            
            this.conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(this.conn);
            
            StringBuffer sql;
            Result result;
            int numRows;
            
            /*** update family map ***/
            sql = new StringBuffer();
            sql.append(strg);
            sqlCommandBean.setSqlValue(sql.toString());
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            if(result == null) {
                errors = new String("EAUTH1");
                return null;
            }

            return (result.getRows());
            
        } catch (SQLException e2) {
            // select query failed
            errors = new String("EAUTH2");
            return null;
        }
        
    }
    
    public LinkedList selectImg(String strg, ArrayList values) {
        
        /*** get family ***/
        SQLCommandBean sqlCommandBean = new SQLCommandBean();
        
        try {
            
            this.conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(this.conn);
            
            StringBuffer sql;
            LinkedList list = null;
            int numRows;
            
            /*** update family map ***/
            sql = new StringBuffer();
            sql.append(strg);
            sqlCommandBean.setSqlValue(sql.toString());
            sqlCommandBean.setValues(values);
            list = sqlCommandBean.executeImgQuery();
            if(list == null) {
                errors = new String("EAUTH1");
                return null;
            }

            return (list);
            
        } catch (SQLException e2) {
            // select query failed
            errors = new String("EAUTH2");
            return null;
        }
        
    }
    
    public boolean update(String strg, ArrayList values) {
        
        boolean success = true;
        
        /*** get family ***/
        SQLCommandBean sqlCommandBean = new SQLCommandBean();
        
        try {
            
            this.conn.setAutoCommit(false);
            
            sqlCommandBean.setConnection(conn);
            
            StringBuffer sql = new StringBuffer();
            sql.append(strg);
            sqlCommandBean.setSqlValue(sql.toString());
            sqlCommandBean.setValues(values);
            int numRows = sqlCommandBean.executeUpdate();
            if (numRows != 1) {
                // Company not updated
                errors = new String("EUPD1");
                return false;
            }
            
        } catch (SQLException e2) {
            // select query failed
            errors = new String("EUPD2");
            return false;
        }
        
        return success;
        
    }
    
}
