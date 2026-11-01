/*
 * PeopleSql.java
 *
 * Created on August 12, 2007, 11:40 AM
 */

package api;

import java.io.IOException;
import java.io.PrintWriter;
import javax.naming.Context;
import javax.naming.InitialContext;

import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.servlet.jsp.jstl.sql.Result;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import sql.SQLCommandBean;

import java.util.ArrayList;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.Properties;
import java.util.Date;
import java.util.Calendar;
import java.util.LinkedList;

import java.text.SimpleDateFormat;
import java.util.regex.PatternSyntaxException;

import jakarta.mail.MessagingException;

/**
 *
 * @author  Lamine Ba
 */
public class PeopleSql {
    
    public SortedMap accountsRs[];
    
    public SortedMap otherAccountsRs[];
    
    public SortedMap peopleRs[];
    
    public SortedMap eventsRs[];
    
    public SortedMap linksRs[];
    
    public TreeMap keychain;
    
    private LinkedList toList;
    
    private LinkedList msgList;
    
    private TreeMap mapMsg;
    
    private String host = appconfig.AppConfig.smtpHost();
    
    private String user = appconfig.AppConfig.smtpUser();
    
    private String from = appconfig.AppConfig.mailFrom();
    
    private int port = appconfig.AppConfig.smtpPort();
    
    private int numEmails = 0;
    
    private String password = appconfig.AppConfig.smtpPassword();
    
    private String accountName = new String();
    
    int numEmailsSent = 0;
    
    private Connection conn;
    
    private SQLCommandBean sqlCommandBean;
    
    /** Creates a new instance of PeopleSql */
    public PeopleSql() {
        
        accountsRs = null;
        otherAccountsRs = null;
        peopleRs = null;
        linksRs = null;
        sqlCommandBean = null;
        conn = null;
        toList = null;
        keychain = null;
        msgList = null;
    }
    
    private boolean createConn() {
        
        try {
            
            sqlCommandBean = new SQLCommandBean();
            
            conn = appconfig.Db.getConnection();
            sqlCommandBean.setConnection(conn);
        }
        catch (SQLException e2) {
            return false;
        }
        
        return true;
    }
    
    private boolean closeConn() {
        
        try {
                if(!conn.getAutoCommit()) {
                    conn.commit();
                    conn.setAutoCommit(true);   // hand a clean connection back to the pool
                }
                conn.close();
                sqlCommandBean = null;
                conn = null;
        }
        catch (SQLException e) {
            return false;
        } // Ignore
        
        return true;
    }
    
    private boolean StatusConn() {
        if(conn == null)
            return false;
        return true;
    }
    
    private boolean getAccounts() {
        
        SortedMap ans[] = null;
        ArrayList values = null;
        
        this.accountsRs = null;
        
        boolean success = false;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;

            // case people
            sql = new StringBuffer();
            sql.append("SELECT * FROM Accounts Where Notify = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add("yes");
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.accountsRs = result.getRows();
                        
            success = true;
            
        } 
        catch (SQLException e2) {}
        return success;
    }
    
    private boolean getOtherAccounts(Integer AccountID) {
        
        SortedMap ans[] = null;
        ArrayList values = null;
        
        this.otherAccountsRs = null;
        
        boolean success = false;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;

            // case people
            sql = new StringBuffer();
            sql.append("SELECT Zlinks.LinkID, Zpeople.AccountID FROM `Zlinks`, Zpeople ");
            sql.append("Where Zlinks.AccountID = ? And Zlinks.OtherID > 0 ");
            sql.append("And Zpeople.PeopleID = Zlinks.OtherID");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(AccountID);
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.otherAccountsRs = result.getRows();
                        
            success = true;
            
        } 
        catch (SQLException e2) {}
        return success;
    }
    
    private boolean getPeople(Integer AccountID) {
        
        SortedMap ans[] = null;
        ArrayList values = null;
        
        this.peopleRs = null;
        
        boolean success = false;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;

            // case people
            sql = new StringBuffer();
            sql.append("SELECT * FROM Zpeople Where ");
            sql.append("(AccountID = ? And (GotBirthdate = 'on' Or IsDeceased = 'on'))");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(AccountID);
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.peopleRs = result.getRows();
            
            // case links
            /*** temp
            sql = new StringBuffer();
            sql.append("SELECT * FROM Links");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.linksRs = result.getRows();
            ***/
            
            success = true;
            
        } 
        catch (SQLException e2) {}
        return success;
    }
    
    private boolean getEvents(Integer AccountID) {
        
        SortedMap ans[] = null;
        ArrayList values = null;
        
        this.eventsRs = null;
        
        boolean success = false;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;

            // case people
            sql = new StringBuffer();
            sql.append("SELECT * FROM Zevents Where AccountID = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(AccountID);
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.eventsRs = result.getRows();
            
            // case links
            /*** temp
            sql = new StringBuffer();
            sql.append("SELECT * FROM Links");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            this.linksRs = result.getRows();
            ***/
            
            success = true;
            return success;
            
        } 
        catch (SQLException e2) {}
        return success;
    }
    
    private String[] getGuests(Integer tid) {
	
        String recipients[] = null;
        SortedMap ans1[] = null;
        SortedMap ans2[] = null;
        SortedMap ans[] = null;
        ArrayList values = null;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;
            
            // case account owner
            sql = new StringBuffer();
            sql.append("Select Accounts.Email, Accounts.Name From Trees, Accounts ");
            sql.append("Where  Trees.TreeID = ? And Trees.AccountID = Accounts.AccountID ");
            sql.append("And Accounts.Notify = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(tid);
            values.add("yes");
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            ans1 = result.getRows();

            // case guests
            sql = new StringBuffer();
            sql.append("SELECT Accounts.Email FROM Viewers, Accounts ");
            sql.append("Where Viewers.TreeID = ? And Viewers.Status = ? ");
            sql.append("And Accounts.AccountID = Viewers.AccountIDg And Accounts.Notify = ? ");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(tid);
            values.add("Accepted");
            values.add("yes");
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            ans2 = result.getRows();
            
            int size1 = ans1.length;
            int size2 = ans2.length;
            recipients = new String[(size1 + size2)];
            
            // collect account owner info
            for(int i=0; i<size1; i++) {
                recipients[i] = (String) ans1[i].get("Email");
                this.accountName = (String) ans1[i].get("Name");
            }
            
            // collect guest info
            for(int j=0; j<size2; j++) {
                recipients[size1+j] = (String) ans2[j].get("Email");
            }
            
            return recipients;
            
        } 
        catch (SQLException e2) {}
            return null;
    }
    
    private String[] getFamily(Integer tid) {
	
        String recipients[] = null;
        SortedMap ans1[] = null;
        SortedMap ans2[] = null;
        SortedMap ans[] = null;
        ArrayList values = null;
        
        try {
            
            // variables;
            StringBuffer sql = null;
            Result result = null;
            
            // case account owner
            sql = new StringBuffer();
            sql.append("Select Links.*, People.* From Links, People ");
            sql.append("Where People.PeopleID = Links.LinkID ");
            sql.append("And Links.PeopleID = ?");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(tid);
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            ans1 = result.getRows();

            // case guests
            sql = new StringBuffer();
            sql.append("SELECT Accounts.Email FROM Viewers, Accounts ");
            sql.append("Where Viewers.TreeID = ? And Viewers.Status = ? ");
            sql.append("And Accounts.AccountID = Viewers.AccountIDg And Accounts.Notify = ? ");
            sqlCommandBean.setSqlValue(sql.toString());
            values = new ArrayList();
            values.add(tid);
            values.add("Accepted");
            values.add("yes");
            sqlCommandBean.setValues(values);
            result = sqlCommandBean.executeQuery();
            ans2 = result.getRows();
            
            int size1 = ans1.length;
            int size2 = ans2.length;
            recipients = new String[(size1 + size2)];
            
            // collect account owner info
            for(int i=0; i<size1; i++) {
                recipients[i] = (String) ans1[i].get("Email");
                this.accountName = (String) ans1[i].get("Name");
            }
            
            // collect guest info
            for(int j=0; j<size2; j++) {
                recipients[size1+j] = (String) ans2[j].get("Email");
            }
            
            return recipients;
            
        } 
        catch (SQLException e2) {}
            return null;
    }
    
    public void postMail
        (String recipients[ ], String bcc[], String subject, String message , String from)
            throws MessagingException
    {
        boolean debug = false;

        // Create email to send (Jakarta Mail, settings from buildtrees.properties)
        try {
            appconfig.Mailer.send(from, recipients, null, bcc, subject, message);
        }
        catch(MessagingException me) {
            java.util.logging.Logger.getLogger(PeopleSql.class.getName())
                .log(java.util.logging.Level.WARNING, "Could not send mail: " + subject, me);
        }
    }
    
    private boolean createPrints(String msg, Integer id) {
        boolean success = true;
        
        Calendar cal = null;
        String note = null;
        Integer spanInt = null;
        int doyRef = 0;
        int doy = 0;
        
        int dayRef = 0;
        int monthRef = 0;
        int yearRef = 0;
        
        int dayX = 0;
        int monthX = 0;
        int yearX = 0;
        
        SortedMap mapPeople, mapEvent;
        int numPeople, numEvents;
        Date eventDate;
        int count = 0;
        
        // Get message
        note = (String) this.mapMsg.get("Note");
        
        // Get today's date
        cal = Calendar.getInstance();
        doyRef = cal.get(Calendar.DAY_OF_YEAR);
        
        dayRef = cal.get(Calendar.DAY_OF_MONTH);
        monthRef = cal.get(Calendar.MONTH);
        yearRef = cal.get(Calendar.YEAR);
        
        // get events from each account
        success = this.getEvents(id);
        numEvents = this.eventsRs.length;
        
        for(int k=0; k<numEvents; k++) {
            eventDate = (Date) (this.eventsRs[k]).get("AlarmDate");
            //spanInt = (Integer) (this.eventsRs[k]).get("AlarmDays");
            cal.setTime(eventDate);
            doy = cal.get(Calendar.DAY_OF_YEAR);
            dayX = cal.get(Calendar.DAY_OF_MONTH);
            monthX = cal.get(Calendar.MONTH);
            yearX = cal.get(Calendar.YEAR);
            
            if(dayX == dayRef && monthX == monthRef) {
                
                /*** create note for email ***/
                //spanInt = (Integer) (this.eventsRs[k]).get("AlarmDays");
                String eventMsg = ((String) (this.eventsRs[k]).get("Type"))+" "+((String) (this.eventsRs[k]).get("Comment"));
                //note = note+msg+"Reminder for the event  ["+eventMsg+"] occuring in"+spanInt+" day";
                note = note+msg+"Reminder for the event ["+eventMsg+"] occuring in "+(this.eventsRs[k]).get("AlarmDays")+" days\n\n";
                count++;
            }
        }
        
        // get people in each account
        success = this.getPeople(id);
        numPeople = this.peopleRs.length;
        
            for(int j=0; j<numPeople; j++) {
                mapPeople = this.peopleRs[j];
                if( ((String) mapPeople.get("GotBirthdate")).equals("on") ) {
                    
                    // case birthdate is today
                    cal.setTime((Date) mapPeople.get("Birthdate"));
                    doy = cal.get(Calendar.DAY_OF_YEAR);
                    dayX = cal.get(Calendar.DAY_OF_MONTH);
                    monthX = cal.get(Calendar.MONTH);
                    yearX = cal.get(Calendar.YEAR);
                    
                    if(dayX == dayRef && monthX == monthRef) {
                            
                            // add birthdate to email list
                            String pName = (String) mapPeople.get("Name");
                            String pEmail = (String)mapPeople.get("Email");
                            int age = yearRef - yearX;
                            
                            note = note+msg+"It is the Birthday of "+pName+" who turns "+age+" years old.\n";
                            if(pEmail == null || pEmail.equals(""))
                                note = note+"\n";
                            else
                                note = note+"The email address of "+pName+" is "+pEmail+".\n\n";
                            count++;
                            
                    }
                }
                
                if( ((String) mapPeople.get("IsDeceased")).equals("on") ) {
                    
                    // case birthdate is today
                    cal.setTime((Date) mapPeople.get("Deceased"));
                    doy = cal.get(Calendar.DAY_OF_YEAR);
                    dayX = cal.get(Calendar.DAY_OF_MONTH);
                    monthX = cal.get(Calendar.MONTH);
                    yearX = cal.get(Calendar.YEAR);
                    
                    if(dayX == dayRef && monthX == monthRef) {
                            
                            // add death date to email list
                            String pName = (String) mapPeople.get("Name");
                            int age = yearRef - yearX;

                            note = note+msg+age+" years ago, on this day, "+pName+" passed away."+"\n\n";
                            count++;
                    }
                }
                
            }
        
        if(count > 0)
            this.mapMsg.put("Note", note);
        
        return success;
        
    }
    
    private LinkedList uniqueZid() {
        LinkedList list= new LinkedList();
        int numOtherAccounts = 0;
        
        if(this.otherAccountsRs == null)
            return null;
        
        numOtherAccounts = this.otherAccountsRs.length;
        for(int i=0; i<numOtherAccounts; i++) {
           Integer value = (Integer) ((SortedMap) this.otherAccountsRs[i]).get("AccountID");
           
           int listSize = 0;
           listSize = list.size();
           if(listSize == 0)
               list.addLast(value);
           else {
               boolean exists =false;
               for(int j=0; j<listSize; j++) {
                   int listItem = ((Integer) list.get(j)).intValue();
                   if(listItem == value.intValue())
                       exists = true;
               }
               
               if(!exists)
                   list.addLast(value);
           }
        }
        
        return list;
    }
    
    
    public boolean run() {
        // get events than email to recipients
        boolean success = true;
        
        SortedMap map = null;
        LinkedList list = new LinkedList();
        Integer zid = null;
        Integer jid = null;
        
        String msg, subject, email, name;
        
        int numAccounts = 0;
        int numOtherPeople = 0;
        
        // initialize msgList
        msgList = new LinkedList();
        
        // create connection + get people data structure
        success = this.createConn();
        
        success = this.getAccounts();
        if(this.accountsRs != null)
            numAccounts = this.accountsRs.length;
        
        // create keychain
        keychain = new TreeMap();
        for(int i=0; i<numAccounts; i++) {
            map = this.accountsRs[i];
            zid = (Integer) map.get("AccountID");
            keychain.put(zid, map);
        }
        
        for(int i=0; i<numAccounts; i++) {
            
            map = this.accountsRs[i];
            
            zid = (Integer) map.get("AccountID");
            name = (String) map.get("Name");
            email = (String) map.get("Email");
            
            this.mapMsg = new TreeMap();
            this.mapMsg.put("AccountID", zid);
            this.mapMsg.put("Name", name);
            this.mapMsg.put("Email", email);
            this.mapMsg.put("Note", "");
            
            // Print anniveraries for people in tree
            success = this.createPrints("", zid);
            
            // get bridge accounts.
            success = this.getOtherAccounts(zid);
            list = this.uniqueZid();
            
            if(list != null) {
                int listSize = list.size();
                for(int j=0; j<listSize; j++) {
                    jid = (Integer) list.get(j);
                    TreeMap jMap = (TreeMap) keychain.get(jid);
                    name = (String) jMap.get("Name");
                    success = this.createPrints("According to "+name+": ", jid);
                }
            }
            
            if(((String) this.mapMsg.get("Note")).equals("") == false)
                this.msgList.addLast(mapMsg);
                        
        }
       
        // close database connection
        success = this.closeConn();
        
        // Send emails
        success = this.sendPrints();
        success = this.sendAdminEmail();
        
        return success;
    }
    
    private boolean sendPrints() {
        boolean sent = true;
        String recipients[], to[], bcc[];
        String msg;
        SortedMap map = null;
        int size = 0;
        
        String subject = new String("BuildTrees Family Events");
        bcc = this.checkTo("support@realbasis.com");
        
        if(this.msgList == null)
            return sent;
        
        this.numEmailsSent = 0;
        
        size = msgList.size();
        for(int i=0; i<size; i++) {
            
            map = (SortedMap) msgList.get(i);
            to = this.checkTo((String) map.get("Email"));
            
            msg = "My Family Events\n\n";
            msg = msg + ((String) map.get("Note"));
            msg = msg + this.printFooter();
            
            try {
                postMail(to, bcc, subject, msg , this.from);
                (this.numEmailsSent)++;
//                this.wait(1000);
            }
            catch (MessagingException me) {
                sent = false;
            }
            //catch (InterruptedException ie) {
              //  sent = false;
            //}
        }
        
        return sent;
    }
    
    private boolean sendAdminEmail() {
        boolean sent = true;
        String recipients[], to[];
        String msg;
        SortedMap map = null;
        int size = 0;
        
        if(this.msgList != null)
            size = msgList.size();
        
        Calendar current = Calendar.getInstance();
        
        String subject = new String("Diagnosis of BuildTrees Family Events");
        
        msg = "\n";
        msg = msg+"Date: "+
            current.get(Calendar.HOUR_OF_DAY)+":"+current.get(Calendar.MINUTE)+" "+
            current.get(Calendar.MONTH)+"/"+current.get(Calendar.DAY_OF_MONTH)+"/"+current.get(Calendar.YEAR);
        msg = msg+"\n\n";
        msg = msg+"Number of msg to send: "+size;
        msg = msg+"\n\n";
        msg = msg+"Number of emails sent: "+this.numEmailsSent;
        msg = msg+"\n\n";
        
        msg = msg + this.printFooter();
        
        
        to = this.checkTo("support@realbasis.com");
        try {
            postMail(to, null, subject, msg , this.from);
//            this.wait(1000);
        }
        catch (MessagingException me) {
            sent = false;
        }
        //catch (InterruptedException ie) {
          //  sent = false;
        //}

        return sent;
    }
    
    public boolean run2() {
        // get events than email to recipients
        boolean success = true;
        
        SortedMap map = null;
        LinkedList list = new LinkedList();
        String recipients[], to[];
        String msg, subject;
        
        // create connection + get people data structure
        success = this.createConn();
        success = this.getAccounts();
        // success = this.getPeople();
        
        int taille = this.accountsRs.length;
        for(int i=0; i<taille; i++) {
            map = this.accountsRs[i];
            
            // handle birthdays
            String gotBirthdate = (String) map.get("GotBirthdate");
            String treeName = (String) map.get("TreeName");
            String firstName, lastName, email;
            String age[];
            
            if(gotBirthdate.equals("on")) {
                Date birthdate = (Date) map.get("Birthdate");
                age = current(birthdate);
                if(age != null) {
                    
                    // re-initialize variables
                    firstName = (String) map.get("FirstName");
                    lastName = (String) map.get("LastName");
                    email = (String) map.get("Email");
                    
                    // check get all guests + account owner
                    recipients = getGuests((Integer) map.get("TreeID"));
                
                    // Send email to list
                    subject = new String("Happy birthday to "+firstName+" "+lastName);
                    
                    msg = "\n";
                    msg = msg+new String("We wish a happy birthday to "+((String) map.get("FirstName"))
                        +" "+((String) map.get("LastName")));
                    msg = msg+" who turns "+age[2]+" on "+age[0]+" "+age[1]+".\n";
                    msg = msg+"\n";
                    msg = msg+"About "+firstName+" "+lastName+":\n";
                    msg = msg+printSignature(treeName, recipients[0], email);
                    //msg = msg+printDebug(recipients);
                    msg = msg+printFooter();
                    
                    try {
                        postMail(recipients, null, subject, msg , this.from);
                    }
                    catch (MessagingException me) {
                        success = false;
                    }
                }
            }
            
            
            // handle deceased
            String isDeceased = (String) map.get("IsDeceased");
            if(isDeceased.equals("on")) {
                Date deceased = (Date) map.get("Deceased");
                age = current(deceased);
                if(age != null) {
                    
                    // re-initialize variables
                    firstName = (String) map.get("FirstName");
                    lastName = (String) map.get("LastName");
                    email = (String) map.get("Email");
                    String agef[] = formatDate(deceased);
                    
                    // check relatives
                    recipients = getGuests((Integer) map.get("TreeID"));
                
                    // Send email to list
                    subject = new String("In memory of "+((String) map.get("FirstName"))+" "+((String) map.get("LastName")));
                    
                    msg = "\n";
                    msg = msg+new String("We commemorate "+((String) map.get("FirstName"))+" "+((String) map.get("LastName")));
                    msg = msg+" who departed us on "+agef[0]+" "+agef[1]+" "+agef[2]+".\n";
                    msg = msg+printSignature(treeName, recipients[0], email);
                    //msg = msg+printDebug(recipients);
                    msg = msg+printFooter();
                    
                    try {
                        postMail(recipients, null, subject, msg , this.from);
                    }
                    catch (MessagingException me) {
                        success = false;
                    }

                }
            }
            
        }
       
        // close database connection
        success = this.closeConn();
        return success;
    }
    
    private String[] formatDate(Date value) {
        String result[] = null;
        SimpleDateFormat sdf = new SimpleDateFormat("MMM:dd:yyyy");
        if(value != null)
            result = sdf.format(value).split(":");
        return result;
    }
    
    private String[] current(Date value) {
        Date now = new Date();
        Calendar cal = null;
        
        SimpleDateFormat sdf = new SimpleDateFormat("MM:dd:yyyy");
        SimpleDateFormat sdf2 = new SimpleDateFormat("MMM:dd:yyyy");
        String nowS[] = null;
        String valueS[] = null;
        String age[] = null;
        int span = 0;
        boolean success = false;
        
        try {
            // case now
            nowS = sdf.format(now).split(":");
            valueS = sdf.format(value).split(":");
            
            if(nowS[0].equals(valueS[0]) && nowS[1].equals(valueS[1]))
                success = true;
            
            // case 2 days ago
            if(success == false) {
                cal.setTime(value);
                cal.add(Calendar.DAY_OF_YEAR,-2);
                valueS = sdf.format(cal.getTime()).split(":");
                if(nowS[0].equals(valueS[0]) && nowS[1].equals(valueS[1]))
                    success = true;
            }
            
            // case a week ago
            if(success == false) {
                cal.setTime(value);
                cal.add(Calendar.DAY_OF_YEAR,-5);
                valueS = sdf.format(cal.getTime()).split(":");
                if(nowS[0].equals(valueS[0]) && nowS[1].equals(valueS[1]))
                    success = true;
            }
            
            if(success) {
               // calculate span of years
                age = sdf2.format(value).split(":");
                span = (new Integer(nowS[2])).intValue() - (new Integer(valueS[2])).intValue();
                age[2] = (new Integer(span)).toString();
                return age;
            }
        }
        catch (PatternSyntaxException pse) {}
            
        return null;
    }
    
    private String[] checkLinks(Integer pid, Integer tid) {
	String recipients[] = null;
        LinkedList list = new LinkedList();
        SortedMap map = null;
        int rsPid = 0;
        int rsTid = 0;
        
        int size = this.peopleRs.length;
        for(int i=0; i<size; i++) {
            
            map = this.peopleRs[i];
            rsPid = ((Integer) map.get("PeopleID")).intValue();
            rsTid = ((Integer) map.get("TreeID")).intValue();
            
            // case same family
            if(pid.intValue() != rsPid && tid.intValue() == rsTid) {
                list.addLast((String) map.get("Email"));
            }
        }
        
        int taille = list.size();
        recipients = new String[taille];
        for(int i=0; i<taille; i++) {
            recipients[i] = (String) list.get(i);
        }
        
        return recipients;
    }
    
    private String[] checkTo(String email) {
	String to[] = new String[1];
        to[0] = email;
        
        return to;
    }
    
    public String printFooter() {
        String msg;
        
        msg = "Go to www.buildtrees.com for more details.\n\n";
        msg = msg+"\n";
        msg = msg+"* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n";
        msg = msg+"BuildTrees values your privacy.  We will not share your\n";
        msg = msg+"email with third parties.  If you do not wish to\n";
        msg = msg+"receive email notifications of family events, simply\n";
        msg = msg+"login to your account and disable the email notification\n";
        msg = msg+"feature under Settings.  Thank you.\n";
        msg = msg+"* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n";
        
        return msg;
    }
    
    public String printSignature(String familyName, String email, String partyEmail) {
        String msg;
        
        msg = "\n";
        if(partyEmail != null)
            if(partyEmail.length() > 0)
                msg = msg+"Email: "+partyEmail+".\n";
        msg = msg+"Belongs to family tree "+familyName+"\n";
        msg = msg+"Family tree was started by "+this.accountName+", "+email+".\n";
        
        return msg;
    }
    
    private String printDebug(String value[]) {
        String msg;
        
        msg = "\n";
        for(int k=0;k<value.length; k++) {
            msg = msg+value[k]+"\t";
        }
        
        return msg;
    }
    
    public int getNumEmails() {
        return numEmails;
    }
    
}
