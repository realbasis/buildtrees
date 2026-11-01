/*
 * ResourceManagerListener.java
 *
 * Created on March 6, 2007, 8:21 PM
 */

package servlet;

import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContext;
import javax.servlet.http.*;
import utility.ConfigBean;

/**
 *
 * @author  Lamine Ba
 * @version
 */

public class ResourceManagerListener implements ServletContextListener {
    
    // Servlet lifecycle events work like Swing events.
    // Any listener interested in observing the servlet context lifecycle
    // should implement the ServletContextListener interface.
    
    // The ServletContextEvent class passed to those methods has only a getServletContext()
    // method that returns the context being initialized or destroyed.
    
    public void contextInitialized(ServletContextEvent e) {
        
        // Called when a Web application is first ready to process requests
        // (i.e. on Web server startup and when a context is added or reloaded).
        // Requests will not be handled until this method returns.
        
        // For example, here might be some database connections established
        // and added to the servlet context attributes.
        
        /*
        Connection con = // create connection
        e.getServletContext().setAttribute("con", con);
         */
        
        ServletContext application  = e.getServletContext();
        
        ConfigBean configBean = new ConfigBean();
        application.setAttribute("configBean", configBean);

    }
    
    public void contextDestroyed(ServletContextEvent e) {
        
        // Called when a Web application is about to be shut down
        // (i.e. on Web server shutdown or when a context is removed or reloaded).
        // Request handling will be stopped before this method is called.
        
        // For example, the database connections might be closed here.
        
        /*
        Connection con = (Connection) e.getServletContext().getAttribute("con");
        try { con.close(); } catch (SQLException ignored) { } // close connection
         */
        
        ServletContext application  = e.getServletContext();
        application.removeAttribute("configBean");

        // Deregister JDBC drivers loaded from WEB-INF/lib and stop MySQL's cleanup
        // thread, so redeploys do not leak the webapp class loader.
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        java.util.Enumeration<java.sql.Driver> drivers = java.sql.DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            java.sql.Driver d = drivers.nextElement();
            if (d.getClass().getClassLoader() == cl) {
                try {
                    java.sql.DriverManager.deregisterDriver(d);
                } catch (java.sql.SQLException ignored) {
                    // best effort
                }
            }
        }
        try {
            Class.forName("com.mysql.cj.jdbc.AbandonedConnectionCleanupThread", false, cl)
                 .getMethod("checkedShutdown").invoke(null);
        } catch (ReflectiveOperationException | LinkageError ignored) {
            // driver not present or different version
        }

    }
}
