/*
 * TasksServlet.java
 *
 * Created on July 19, 2007, 11:37 PM
 */

package servlet;

import java.io.*;
import java.net.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * @author  Lamine Ba
 * @version
 */
public class TasksServlet extends HttpServlet {
    
    private Timer timer;
    
    /** Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
        int initialDelay = 30000; // start after 30 seconds
        int period = 10000;        // repeat every 5 seconds
        
        timer = new Timer("buildtrees-tasks", true);
        TimerTask task = new TimerTask() {
            public void run() {
                // job code here
            }
        };
        timer.scheduleAtFixedRate(task, initialDelay, period);
        
    }
    
    /** Destroys the servlet.
     */
    public void destroy() {
        // stop the timer thread so redeploys do not leak it
        if (timer != null)
            timer.cancel();
    }
    
    /** Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        /* TODO output your page here
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet</title>");
        out.println("</head>");
        out.println("<body>");
         
        out.println("</body>");
        out.println("</html>");
         */
        out.close();
    }
    
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    
}
