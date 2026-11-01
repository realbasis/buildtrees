/*
 * Connection.java
 *
 * Created on May 11, 2008, 7:32 PM
 */

package api;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author  Lamine Ba
 */
public class Linked {
    
    public Connection conn = null;
    
    public String errors;
    
    /** Creates a new instance of Connection */
    public Linked() {
    }
    
    public boolean open() {
        
        boolean success = true;

        try {
            conn = appconfig.Db.getConnection();
        }
        catch (SQLException ex2) {
            errors = "Connexion non effectuée: " + ex2;
            return false;
        }
        
        return success;
     }
    
    public boolean close() {
        boolean success = true;
        
        try {
                if(!conn.getAutoCommit()) {
                    conn.commit();
                    conn.setAutoCommit(true);   // hand a clean connection back to the pool
                }
                conn.close();
            }
            catch (SQLException e) {
                return false;
            } // Ignore
        
        return success;

    }
    
}
