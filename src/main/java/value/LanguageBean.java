/*
 * LanguageBean.java
 *
 * Created on January 29, 2009, 9:56 PM
 */

package value;

import java.beans.*;
import java.io.Serializable;
import java.util.LinkedList;
import java.util.TreeMap;

/**
 * @author Lamine Ba
 */
public class LanguageBean extends Object implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String language;  // EN, FR, Pulaar, Woolof
    
    private String home;
    
    private String contactUs;
    
    private String contactusFrag;
    
    private String signupFrag;
    
    private String login;
    
    private String email;
    
    private String password;
    
    private String forgotPassword;
    
    private String signup;
    
    private String index;
    
    private String forgotPasswordFrag;
    
    private String settingsFrag;
    
    private String settingsHeadFrag;
    
    private String eventsHeadFrag;
    
    private String eventsMainFrag;
    
    private String familyAnniv;
    
    private String familyEvents;
    
    private String zmainEventsFrag;
    
    private String zmainHeadFrag;
    
    private String zmainHelpFrag;
    
    //private String zmainTreeFrag;
    
    private String zmainFatherBut;
    
    private String zmainFatherTitle;
    
    private String zmainMotherBut;
    
    private String zmainMotherTitle;
    
    private String zmainPartnerBut;
    
    private String zmainPartnerTitle;
    
    private String zmainSonBut;
    
    private String zmainSonTitle;
    
    private String zmainDaughterBut;
    
    private String zmainDaughterTitle;
    
    private String zmainBrotherBut;
    
    private String zmainBrotherTitle;
    
    private String zmainSisterBut;
    
    private String zmainSisterTitle;
    
    private String zmainManBut;
    
    private String zmainManTitle;
    
    private String zmainWomanBut;
    
    private String zmainWomanTitle;
    
    private String zmainBornOn;
    
    private String zmainPassedOn;
    
    private String zmainFather;
    
    private String zmainMother;
    
    private String zmainPartner;
    
    private String zmainWife;
    
    private String zmainHusband;
    
    private String zmainChild;
    
    private String zmainSibling;
    
    private String zmainBrother;
    
    private String zmainSister;
    
    private String zmainFriend;
    
    private String zmainFriends;
    
    private String zmainAddFather;
    
    private String zmainAddMother;
    
    private String zmainAddPartner;
    
    private String zmainAddWife;
    
    private String zmainAddHusband;
    
    private String zmainAddMan;
    
    private String zmainAddWoman;
    
    private String zmainAddSon;
    
    private String zmainAddDaughter;
    
    private String zmainAddBrother;
    
    private String zmainAddSister;
    
    private String znewprofileFrag;
    
    private String znewprofileMainFrag;
    
    private String zprofileHeadFrag;
    
    private String zprofileMainFrag;
    
    private String alerts;
    
    private LinkedList list;
    
    private LinkedList gapList;
    
    public LanguageBean() {
        propertySupport = new PropertyChangeSupport(this);
        language = "ENGLISH";
        
        ///LinkedList tuple;
        TreeMap map;
        list = new LinkedList();
        
        map = new TreeMap();
        map.put("Cle0", "EN");
        map.put("Cle1", "ENGLISH");
        this.list.addLast(map);
        
        map = new TreeMap();
        map.put("Cle0", "FR");
        map.put("Cle1", "FRANCAIS");
        this.list.addLast(map);
        
        map = new TreeMap();
        map.put("Cle0", "Pulaar");
        map.put("Cle1", "FULBE");
        /*** temp comment this.list.addLast(map); */
        
        /*
        map = new TreeMap();
        map.put("Cle0", "Woloof");
        map.put("Cle1", "WOLOOF");
        this.list.addLast(map);
        */
        
        gapList = new LinkedList();
        for(int i=0; i<366; i++) {
            gapList.addLast(new Integer(i));
        }
        
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
    
    public void setLanguage(String value) {
        language = value;
    }
    
    public String getLanguage() {
        return language;
    }
    
    public LinkedList getList() {
        return list;
    }
    
    public String getHome() {
        if(language.equals("EN"))
            return "Home";
        else if(language.equals("FR"))
            return "Accueil";
        else if(language.equals("Woolof"))
            return "Keur";
        else if(language.equals("Pulaar"))
            return "Werdé";
        
        return "Home";
    }
    
    public String getContactUs() {
        if(language.equals("EN"))
            return "Contact Us";
        else if(language.equals("FR"))
            return "Contactez Nous";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Nondé mène";
        
        return "Contact Us";
    }
    
    public String getLogin() {
        if(language.equals("EN"))
            return "Login";
        else if(language.equals("FR"))
            return "S'enregistrer";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Ouditougol";
        
        return "Login";
    }
    
    public String getForgotPassword() {
        if(language.equals("EN"))
            return "Forgot password?";
        else if(language.equals("FR"))
            return "Mot de passe oublié?";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Haal fédjè yédjitado?";
        
        return "Forgot password";
    }
    
    public String getSignup() {
        if(language.equals("EN"))
            return "Signup here";
        else if(language.equals("FR"))
            return "S'inscrire?";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Windaghol";
        
        return "Sign up";
    }
    
    public String getEmail() {
        if(language.equals("FR"))
            return "email";
        else if(language.equals("Woolof"))
            return "email";
        else if(language.equals("Pulaar"))
            return "email";
        
        return "email";
    }
    
    public String getPassword() {
        if(language.equals("FR"))
            return "mot de passe";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Haal Fédjè";
        
        return "password";
    }
    
    public String getIndex() {
        if(language.equals("FR"))
            return "indexFragFr.jsp";
        else if(language.equals("Woolof"))
            return "indexFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "indexFragPu.jsp";
        
        return "indexFragEn.jsp";
    }
    
    public String getContactusFrag() {
        if(language.equals("FR"))
            return "contactusFragFr.jsp";
        else if(language.equals("Woolof"))
            return "contactusFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "contactusFragPu.jsp";
        
        return "contactusFragEn.jsp";
    }
    
    public String getSignupFrag() {
        if(language.equals("FR"))
            return "signupFragFr.jsp";
        else if(language.equals("Woolof"))
            return "signupFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "signupFragPu.jsp";
        
        return "signupFragEn.jsp";
    }
    
    public String getForgotPasswordFrag() {
        if(language.equals("FR"))
            return "forgotPasswordFragFr.jsp";
        else if(language.equals("Woolof"))
            return "forgotPasswordFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "forgotPasswordFragPu.jsp";
        
        return "forgotPasswordFragEn.jsp";
    }
    
    public String getSettingsFrag() {
        if(language.equals("FR"))
            return "settingsFragFr.jsp";
        else if(language.equals("Woolof"))
            return "settingsFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "settingsFragPu.jsp";
        
        return "settingsFragEn.jsp";
    }
    
    public String getSettingsHeadFrag() {
        if(language.equals("FR"))
            return "settingsHeadFragFr.jsp";
        else if(language.equals("Woolof"))
            return "settingsHeadFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "settingsHeadFragPu.jsp";
        
        return "settingsHeadFragEn.jsp";
    }
    
    public String getZmainEventsFrag() {
        if(language.equals("FR"))
            return "zmainEventsFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zmainEventsFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zmainEventsFragPu.jsp";
        
        return "zmainEventsFragEn.jsp";
    }
    
    public String getZmainHeadFrag() {
        if(language.equals("FR"))
            return "zmainHeadFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zmainHeadFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zmainHeadFragPu.jsp";
        
        return "zmainHeadFragEn.jsp";
    }
    
    public String getZmainHelpFrag() {
        if(language.equals("FR"))
            return "zmainHelpFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zmainHelpFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zmainHelpFragPu.jsp";
        
        return "zmainHelpFragEn.jsp";
    }
    
    public String getFamilyEvents() {
        if(language.equals("FR"))
            return "Evènements familiaux";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Hadiou mèygourè";
        
        return "Family Events";
    }
    
    public String getFamilyAnniv() {
        if(language.equals("FR"))
            return "Anniversaires familiaux";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Anniversaires familiaux";
        
        return "Family Anniversaries";
    }
    
    public String getZmainTreeFrag() {
        if(language.equals("FR"))
            return "zmainTreeFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zmainTreeFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zmainTreeFragPu.jsp";
        
        return "zmainTreeFragEn.jsp";
    }
    
    public String getZmainFatherBut() {
        if(language.equals("FR"))
            return "Ajouter Père";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "bèydougol Baba";
        
        return "+Father";
    }
    
    public String getZmainFatherTitle() {
        if(language.equals("FR"))
            return "* PERE *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Baba ou Babin";
        
        return "* FATHER *";
    }
    
    public String getZmainMotherBut() {
        if(language.equals("FR"))
            return "Ajouter Mère";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol nèné";
        
        return "+Mother";
    }
    
    public String getZmainMotherTitle() {
        if(language.equals("FR"))
            return "* MERE *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "nèné";
        
        return "* MOTHER *";
    }
    
    public String getZmainPartnerBut() {
        if(language.equals("FR"))
            return "Femme/Partenaire";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Débbo/Ndiatigui";
        
        return "Wife/Partner";
    }
    
    public String getZmainPartnerTitle() {
        if(language.equals("FR"))
            return "* PARTNERAIRE *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Ndiatigui";
        
        return "* PARTNER *";
    }
    
    public String getZmainSonBut() {
        if(language.equals("FR"))
            return "Ajouter Fils";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol Gorco, Worbè";
        
        return "+Son";
    }
    
    public String getZmainSonTitle() {
        if(language.equals("FR"))
            return "* FILS *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Gorco, Worbè";
        
        return "* SON *";
    }
    
    public String getZmainDaughterBut() {
        if(language.equals("FR"))
            return "Ajouter Fille";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol Djiwo";
        
        return "+Daughter";
    }
    
    public String getZmainDaughterTitle() {
        if(language.equals("FR"))
            return "* FILLE *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Djiwo";
        
        return "* DAUGHTER *";
    }
    
    public String getZmainBrotherBut() {
        if(language.equals("FR"))
            return "Ajouter Frère";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol Coto";
        
        return "+Brother";
    }
    
    public String getZmainBrotherTitle() {
        if(language.equals("FR"))
            return "* FRERE *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "coto";
        
        return "* BROTHER *";
    }
    
    public String getZmainSisterBut() {
        if(language.equals("FR"))
            return "Ajouter Soeur";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol Diadia";
        
        return "+Sister";
    }
    
    public String getZmainSisterTitle() {
        if(language.equals("FR"))
            return "* SOEUR *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Diadia";
        
        return "* SISTER *";
    }
    
    public String getZmainManBut() {
        if(language.equals("FR"))
            return "Ajouter Ami";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol welldi";
        
        return "+Man";
    }
    
    public String getZmainManTitle() {
        if(language.equals("FR"))
            return "* AMI *";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Welldidio";
        
        return "* FRIEND *";
    }
    
    public String getZmainWomanBut() {
        if(language.equals("FR"))
            return "Ajouter Amie";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Bèydougol Welldi";
        
        return "+Woman";
    }
    
    public String getZmainBornOn() {
        if(language.equals("FR"))
            return "Né";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Djibina";
        
        return "Born";
    }
    
    public String getZmainPassedOn() {
        if(language.equals("FR"))
            return "Décédé";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Maiye";
        
        return "Passed";
    }
    
    public String getZmainFather() {
        if(language.equals("FR"))
            return "PERE";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Babin";
        
        return "FATHER";
    }
    
    public String getZmainMother() {
        if(language.equals("FR"))
            return "MERE";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Nèné";
        
        return "MOTHER";
    }
    
    public String getZmainPartner() {
        if(language.equals("FR"))
            return "PARTENAIRE";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Ndiatigui";
        
        return "PARTNER";
    }
    
    public String getZmainWife() {
        if(language.equals("FR"))
            return "EPOUSE";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "BENGOU";
        
        return "WIFE";
    }
    
    public String getZmainHusband() {
        if(language.equals("FR"))
            return "EPOUX";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "MODI";
        
        return "HUSBAND";
    }
    
    public String getZmainChild() {
        if(language.equals("FR"))
            return "ENFANT";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
           return "Biddo";
        
        return "CHILD";
    }
    
    public String getZmainSibling() {
        if(language.equals("FR"))
            return "FRERE/SOEUR";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Coto/Diadia";
        
        return "SIBLING";
    }
    
    public String getZmainBrother() {
        if(language.equals("FR"))
            return "FRERE";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Coto";
        
        return "BROTHER";
    }
    
    public String getZmainSister() {
        if(language.equals("FR"))
            return "SOEUR";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Diadia";
        
        return "SISTER";
    }
    
    public String getZmainFriend() {
        if(language.equals("FR"))
            return "AMI";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Welldidio";
        
        return "FRIEND";
    }
    
    public String getZmainFriends() {
        if(language.equals("FR"))
            return "A M I S";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "welldibé";
        
        return "F R I E N D S";
    }
    
    public String getZmainAddFather() {
        if(language.equals("FR"))
            return "Insérer Père";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
           return "Waddougol Babin";
        
        return "+Father";
    }
    
    public String getZmainAddMother() {
        if(language.equals("FR"))
            return "Insérer Mère";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Nèné";
        
        return "+Mother";
    }
    
    public String getZmainAddPartner() {
        if(language.equals("FR"))
            return "Insérer Partenaire";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
           return "Wadougol Ndiatigui";
        
        return "+Partner";
    }
    
    public String getZmainAddWife() {
        if(language.equals("FR"))
            return "Insérer Epouse";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol bengou";
        
        return "+Wife";
    }
    
    public String getZmainAddHusband() {
        if(language.equals("FR"))
            return "Insérer Epoux";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Modi";
        
        return "+Husband";
    }
    
    public String getZmainAddMan() {
        if(language.equals("FR"))
            return "Insérer Ami";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Welldidio ";
        
        return "+Man";
    }
    
    public String getZmainAddWoman() {
        if(language.equals("FR"))
            return "Insérer Amie";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Welldidio";
        
        return "+Woman";
    }
    
    public String getZmainAddSon() {
        if(language.equals("FR"))
            return "Insérer Fils";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Worbè";
        
        return "+Son";
    }
    
    public String getZmainAddDaughter() {
        if(language.equals("FR"))
            return "Insérer Fille";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Djiwo";
        
        return "+Daughter";
    }
    
    public String getZmainAddBrother() {
        if(language.equals("FR"))
            return "Insérer Frère";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
            return "Wadougol Coto";
        
        return "+Brother";
    }
    
    public String getZmainAddSister() {
        if(language.equals("FR"))
            return "Insérer Soeur";
        else if(language.equals("Woolof"))
            return "";
        else if(language.equals("Pulaar"))
           return "Wadougol Diadia";
        
        return "+Sister";
    }
    
    public String getZnewprofileFrag() {
        if(language.equals("FR"))
            return "znewprofileFragFr.jsp";
        else if(language.equals("Woolof"))
            return "znewprofileFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "znewprofileFragPu.jsp";
        
        return "znewprofileFragEn.jsp";
    }
    
    public String getZnewprofileMainFrag() {
        if(language.equals("FR"))
            return "znewprofileMainFragFr.jsp";
        else if(language.equals("Woolof"))
            return "znewprofileMainFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "znewprofileMainFragPu.jsp";
        
        return "znewprofileMainFragEn.jsp";
    }
    
    public String getZprofileHeadFrag() {
        if(language.equals("FR"))
            return "zprofileHeadFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zprofileHeadFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zprofileHeadFragPu.jsp";
        
        return "zprofileHeadFragEn.jsp";
    }
    
    public String getZprofileMainFrag() {
        if(language.equals("FR"))
            return "zprofileMainFragFr.jsp";
        else if(language.equals("Woolof"))
            return "zprofileMainFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "zprofileMainFragPu.jsp";
        
        return "zprofileMainFragEn.jsp";
    }
    
    public String getEventsHeadFrag() {
        if(language.equals("FR"))
            return "eventsHeadFragFr.jsp";
        else if(language.equals("Woolof"))
            return "eventsHeadFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "eventsHeadFragPu.jsp";
        
        return "eventsHeadFragEn.jsp";
    }
    
    public String getEventsMainFrag() {
        if(language.equals("FR"))
            return "eventsMainFragFr.jsp";
        else if(language.equals("Woolof"))
            return "eventsMainFragWo.jsp";
        else if(language.equals("Pulaar"))
            return "eventsMainFragPu.jsp";
        
        return "eventsMainFragEn.jsp";
    }
    
    public String getAlerts() {
        if(language.equals("FR"))
            return "ALARMES";
        else if(language.equals("Woolof"))
            return "ALARMES";
        else if(language.equals("Pulaar"))
            return "Alarmes";
        
        return "ALARMS";
    }
    
    public LinkedList getGapList() {
        return gapList;
    }

}
