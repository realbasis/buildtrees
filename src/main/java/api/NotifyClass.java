/*
 * NotifyClass.java
 *
 * Created on March 11, 2010, 9:51 AM
 */

package api;

import utility.*;
import value.*;
import java.util.Calendar;
import java.util.Date;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;
import java.util.LinkedList;
import jakarta.mail.MessagingException;

/**
 *
 * @author  Lamine Ba
 */
public class NotifyClass {
    
    PeopleSql peopleSql;
    
    /** Creates a new instance of NotifyClass */
    public NotifyClass() {
        peopleSql = new PeopleSql();
    }
    
    public boolean run() {
        
        boolean success = true;
        
        ConnBean connBean = null;
        TreeLogicBean treeLogicBean = null;
        Calendar cal = null;
        SortedMap map = null;
        SortedMap maps[] = null;
        ArrayList values = null;
        String msg = null;
        int size = 0;

        treeLogicBean = new TreeLogicBean();

        connBean = new ConnBean();
        connBean.isStarted();
        
        // Get all accounts in Map
        TreeMap accountsMap = new TreeMap();
        maps = connBean.select("Select * From Accounts", new ArrayList());
        size = 0;
        if(maps != null)
            size = maps.length;
        for(int i=0; i<size; i++) {
            map = maps[i];
            Integer id = (Integer) map.get("AccountID");
            accountsMap.put(id, map);
        }
        
        // define now
        cal = Calendar.getInstance();
        Integer monthInt = new Integer(1+cal.get(Calendar.MONTH));
        Integer dayOfMonthInt = new Integer(cal.get(Calendar.DAY_OF_MONTH));
        
        // Get people with current birthdays
        values = new ArrayList();
        values.add("on");
        values.add(dayOfMonthInt);
        values.add(monthInt);
        msg = "Select * from Zpeople where GotBirthdate = ? And ";
        msg = msg + "DAYOFMONTH(Birthdate) = ? AND MONTH(Birthdate) = ?";
        maps = connBean.select(msg, values);
        size = 0;
        if(maps != null)
            size = maps.length;
        for(int i=0; i<size; i++) {                             // loop thru people
            LinkedList accountsList = new LinkedList();
            SortedMap accountMap = null;
            String notify = null;
            String accountName = null;
            
            String peopleName = (String) maps[i].get("Name");
            Integer accountID = (Integer) maps[i].get("AccountID");
            accountMap = (SortedMap) accountsMap.get(accountID);
            if(accountMap != null) {
                accountName = (String) accountMap.get("Name");
                notify = (String) accountMap.get("Notify");
                if(notify.equals("yes"))
                    accountsList.addLast(accountMap);
            }
            
            // get sharers
            SortedMap sharersMaps[] = null;
            treeLogicBean.createSharers(accountID);
            sharersMaps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
            int sizeSharers = 0;
            if(sharersMaps != null)
                sizeSharers = sharersMaps.length;
            for(int j=0; j<sizeSharers; j++) {
                accountID = (Integer) sharersMaps[j].get("AccountID");
                accountMap = (SortedMap) accountsMap.get(accountID);
                notify = (String) accountMap.get("Notify");
                if(notify.equals("yes"))
                    accountsList.addLast(accountMap);
            }
            
            // accountsList is ready.  Send email for birthdays
            String to[] = this.defineTo(accountsList);
            String bcc[] = new String[1];
            bcc[0] = "buildtrees@realbasis.com";
            String msgBody = "\nAccording to "+accountName+", today is the Birthday of "+peopleName+".\n\n";
            msgBody = msgBody+peopleSql.printFooter();
            String subject = "Birthday of "+peopleName;
            String from = "buildtrees@realbasis.com";
            try {
                peopleSql.postMail(to, bcc, subject, msgBody, from);
            } catch (MessagingException me) {}
        }
        
        // Get people for death anniversaries
        values = new ArrayList();
        values.add("on");
        values.add(dayOfMonthInt);
        values.add(monthInt);
        msg = "Select * from Zpeople where IsDeceased = ? And ";
        msg = msg + "DAYOFMONTH(Deceased) = ? AND MONTH(Deceased) = ?";
        maps = connBean.select(msg, values);
        size = 0;
        if(maps != null)
            size = maps.length;
        for(int i=0; i<size; i++) {                             // loop thru people
            LinkedList accountsList = new LinkedList();
            SortedMap accountMap = null;
            String notify = null;
            String accountName = null;
            
            String peopleName = (String) maps[i].get("Name");
            Integer accountID = (Integer) maps[i].get("AccountID");
            accountMap = (SortedMap) accountsMap.get(accountID);
            if(accountMap != null) {
                notify = (String) accountMap.get("Notify");
                accountsList.addLast(accountMap);
                if(notify.equals("yes"))
                    accountName = (String) accountMap.get("Name");
            }
            
            // get sharers
            SortedMap sharersMaps[] = null;
            treeLogicBean.createSharers(accountID);
            sharersMaps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
            int sizeSharers = 0;
            if(sharersMaps != null)
                sizeSharers = sharersMaps.length;
            for(int j=0; j<sizeSharers; j++) {
                accountID = (Integer) sharersMaps[j].get("AccountID");
                accountMap = (SortedMap) accountsMap.get(accountID);
                notify = (String) accountMap.get("Notify");
                if(notify.equals("yes"))
                    accountsList.addLast(accountMap);
            }
            
            // accountsList is ready.  Send email for death anniversaries
            String to[] = this.defineTo(accountsList);
            String bcc[] = new String[1];
            bcc[0] = "buildtrees@realbasis.com";
            String msgBody = "\nAccording to "+accountName+", today is the day we lost "+peopleName+".\n\n";
            msgBody = msgBody+peopleSql.printFooter();
            String subject = "Rest in peace "+peopleName;
            String from = "buildtrees@realbasis.com";
            try {
                peopleSql.postMail(to, bcc, subject, msgBody, from);
            } catch (MessagingException me) {}

        }

        
        // Get current events
        values = new ArrayList();
        values.add(cal.getTime());
        msg = "Select * from Zevents where AlarmDate = ?";
        maps = connBean.select(msg, values);
        size = 0;
        if(maps != null)
            size = maps.length;
        for(int i=0; i<size; i++) {                             // loop thru events
            LinkedList accountsList = new LinkedList();
            SortedMap accountMap = null;
            String accountName = null;
            
            Integer alarmDays = (Integer) maps[i].get("AlarmDays");
            String eventType = (String) maps[i].get("Type");
            String comment = (String) maps[i].get("Comment");
            Integer accountID = (Integer) maps[i].get("AccountID");
            accountMap = (SortedMap) accountsMap.get(accountID);
            if(accountMap != null) {
                accountName = (String) accountMap.get("Name");
                accountsList.addLast(accountMap);
            }
            
            // get sharers
            SortedMap sharersMaps[] = null;
            treeLogicBean.createSharers(accountID);
            sharersMaps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
            int sizeSharers = 0;
            if(sharersMaps != null)
                sizeSharers = sharersMaps.length;
            for(int j=0; j<sizeSharers; j++) {
                accountID = (Integer) sharersMaps[j].get("AccountID");
                accountMap = (SortedMap) accountsMap.get(accountID);
                accountsList.addLast(accountMap);
            }
            
            // accountsList is ready.  Send email for events
            String to[] = this.defineTo(accountsList);
            String bcc[] = new String[1];
            bcc[0] = "buildtrees@realbasis.com";
            String alarmDaysStrg = null;
            if(alarmDays.intValue() == 0)
                alarmDaysStrg = "";
            else if(alarmDays.intValue() == 1)
                alarmDaysStrg = "in 1 day";
            else
                alarmDaysStrg = "in "+alarmDays+" days";
            String msgBody = "\nAccording to "+accountName+",";
            msgBody = msgBody+"mark your calendar for this event: "+eventType+" "+comment+alarmDaysStrg+".\n\n";
            msgBody = msgBody+peopleSql.printFooter();
            String subject = "Event Reminder: "+eventType+" "+comment;
            String from = "buildtrees@realbasis.com";
            try {
                peopleSql.postMail(to, bcc, subject, msgBody, from);
            } catch (MessagingException me) {}

        }
        
        connBean.isClosed();
        
        // Send debug email to staff
        String dummyMsg = "Date email was sent: "+cal.getTime().toString();
        String dummyTo[] = new String[1];
        dummyTo[0] = "buildtrees@realbasis.com";
        try {
            peopleSql.postMail(dummyTo, null, "Debug email for staff", dummyMsg, "buildtrees@realbasis.com");
        } catch (MessagingException me) {}
        
        
        
        return success;
        
    }
    
    private String[] defineTo(LinkedList accountsList) {
	if(accountsList == null)
            return null;
        
        SortedMap map = null;
        int size = accountsList.size();
        String to[] = new String[size];
        
        for(int i=0; i<size; i++) {
            map = (SortedMap) accountsList.get(i);
            to[i] = (String) map.get("Email");
        }
        
        return to;
    }
    
    private String buildBirthdayMsg(LinkedList accountsList, SortedMap peopleMap) {
        String msg = null;
        
        
        msg = msg+peopleSql.printFooter();
        
        return msg;
    }
    
    private String buildDeceasedMsg(LinkedList accountsList, SortedMap peopleMap) {
        String msg = null;
        
        
        msg = msg+peopleSql.printFooter();
        
        return msg;
    }
    
    private String buildEventsMsg(LinkedList accountsList, SortedMap eventMap) {
        String msg = null;
        
        msg = msg+peopleSql.printFooter();
        
        return msg;
    }
    
}
