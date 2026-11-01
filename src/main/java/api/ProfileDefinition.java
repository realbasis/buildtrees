/*
 * ProfileDefinition.java
 *
 * Created on March 6, 2010, 9:13 AM
 */

package api;
import value.TreeBean;
import java.util.TreeMap;
import java.util.LinkedList;

/**
 *
 * @author  Lamine Ba
 */
public class ProfileDefinition {
    
    /** Creates a new instance of ProfileDefinition */
    public ProfileDefinition() {
    }
    
    public LinkedList defineList(TreeBean treeBean, String relationship) {
        
        LinkedList list = null;
        TreeMap tMap = null;
        if(relationship.equals("Mother")) {
            tMap = treeBean.getMother();
            if(tMap != null) {
                list = new LinkedList();
                list.addLast(tMap);
            }
        }
        else if(relationship.equals("Father")) {
            tMap = treeBean.getFather();
            if(tMap != null) {
                list = new LinkedList();
                list.addLast(tMap);
            }
        }
        else if(relationship.equals("Me")) {
            tMap = treeBean.getMe();
            if(tMap != null) {
                list = new LinkedList();
                list.addLast(tMap);
            }
        }
        else if(relationship.equals("Partner")) {
            list = treeBean.getPartners();
        }
        else if(relationship.equals("Sibling")) {
            list = treeBean.getSiblings();
        }
        else if(relationship.equals("Child")) {
            list = treeBean.getChildren();
        }
        else if(relationship.equals("Friend")) {
            list = treeBean.getFriends();
        }
        
        return list;
        
    }
    
    public TreeMap defineTerms(String relationship) {
        
        TreeMap tMap = null;
        if(relationship.equals("Mother")) {
            tMap = new TreeMap();
            tMap.put("Title", "MOTHER");
            tMap.put("AddButton", "+Mother");
        }
        else if(relationship.equals("Father")) {
            tMap = new TreeMap();
            tMap.put("Title", "FATHER");
            tMap.put("AddButton", "+Father");
        }
        else if(relationship.equals("Me")) {

        }
        else if(relationship.equals("Partner")) {
            tMap = new TreeMap();
            tMap.put("Title", "PARTNER");
            tMap.put("AddButton", "+Partner");
        }
        else if(relationship.equals("Sibling")) {
            tMap = new TreeMap();
            tMap.put("Title", "SIBLING");
            tMap.put("AddButton", "+Sibling");
        }
        else if(relationship.equals("Child")) {
            tMap = new TreeMap();
            tMap.put("Title", "CHILD");
            tMap.put("AddButton", "+Child");
        }
        else if(relationship.equals("Friend")) {
            tMap = new TreeMap();
            tMap.put("Title", "FRIEND");
            tMap.put("AddButton", "+Friend");
        }
        return tMap;
    }
    
    public Integer defineLevel(String relationship) {
        
        int level = 0;
        if(relationship.equals("Mother")) {
            level = 1;
        }
        else if(relationship.equals("Father")) {
            level = 1;
        }
        else if(relationship.equals("Me")) {
            level = 2;
        }
        else if(relationship.equals("Partner")) {
            level = 3;
        }
        else if(relationship.equals("Sibling")) {
            level = 3;
        }
        else if(relationship.equals("Child")) {
            level = 3;
        }
        else if(relationship.equals("Friend")) {
            level = 3;
        }
        return new Integer(level);
    }
    
}
