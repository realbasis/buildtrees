/*
 * GetImgServlet.java
 *
 * Created on February 15, 2011, 12:10 PM
 */

package servlet;

import java.io.*;
import java.net.*;

import javax.servlet.*;
import javax.servlet.http.*;

import value.*;
import utility.*;
import java.sql.*;
import java.util.*;
import javax.servlet.jsp.jstl.sql.Result;

/**
 *
 * @author  tba
 * @version
 */
public class GetImgServlet extends HttpServlet {
    
    /** Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
    }
    
    /** Destroys the servlet.
     */
    public void destroy() {
        
    }
    
    /** Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        // initialize variables
        HttpSession session = request.getSession();
        TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
        SortedMap peopleMap = (SortedMap) treeBean.getPeopleMap();
        Blob imageBlob = (Blob) peopleMap.get("Image");
        InputStream in = null;
        response.setContentType("image/jpeg");
        ServletOutputStream outBytes = response.getOutputStream();
        
        try {
            imageBlob = (Blob) peopleMap.get("Image");
            if(imageBlob != null) {
                in = imageBlob.getBinaryStream();
                int length = (int) imageBlob.length();
                int bufferSize = 300000;
                byte[] buffer = new byte[bufferSize];
                while ((length = in.read(buffer)) != -1) {
                    outBytes.write(buffer, 0, length);
                }
                in.close();
                outBytes.flush();
            }
        } catch (SQLException sqle) {}
        
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
        return "Servlet handles display of image";
    }
    
}
