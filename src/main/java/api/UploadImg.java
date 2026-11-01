/*
 * UploadImg.java
 *
 * Created on February 23, 2007, 1:36 PM
 */

package api;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 *
 * @author  Lamine Ba
 */
public class UploadImg {
    
    /** Creates a new instance of UploadImg */
    public UploadImg() {
    }
    
    public boolean update(Connection conn, int peopleID, String imageName, InputStream image, int imglength) {
        
        PreparedStatement ps = null;
        
        try {
            //conn = DriverManager.getConnection(jdbcURL, username, password);
            conn.setAutoCommit(false);
            
            String INSERT_PICTURE = new String("UPDATE People Set ImageName=?, Image=? Where PeopleID=?");
            ps = conn.prepareStatement(INSERT_PICTURE);
            ps.setString(1, imageName);
            ps.setBinaryStream(2, image, imglength);
            ps.setInt(3, peopleID);
            ps.executeUpdate();
            conn.commit();
           
        } catch (SQLException e1) {
            
        } catch (Exception e2) {
            
        } 
        return true;
    }
    
    public InputStream getImage(Connection conn, int peopleID)
    {
        PreparedStatement ps = null;
        InputStream is = null;
        ResultSet rs = null;
        
        try {
            //conn = DriverManager.getConnection(jdbcURL, username, password);
            conn.setAutoCommit(false);
            
            String GET_PICTURE = new String("Select ImageName, Image From People Where PeopleID=?");
            ps = conn.prepareStatement(GET_PICTURE);
            ps.setInt(1, peopleID);
            rs = ps.executeQuery();
            conn.commit();
            
            is = rs.getBinaryStream(0);
           
        } catch (SQLException e1) {
            
        } catch (Exception e2) {
            
        } 
        
        return is;
    }
}
