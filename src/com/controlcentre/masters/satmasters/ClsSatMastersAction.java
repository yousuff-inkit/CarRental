package com.controlcentre.masters.satmasters;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsSatMastersAction {
    ClsCommon ClsCommon = new ClsCommon();
    ClsSatMasterDAO satMasterDAO = new ClsSatMasterDAO();
    ClsSatMasterBean bean;

    private String username;
    private String password;
    private String remarks;
    private String tcno;
    // private int captch;
    private int hidCaptcha;
    private int hidRta;

    private String sqno;
    private String timeperiod;
    private String mode;
    private String sitecheck;
    // private int rta;
    private String site;
    private int docno;
    private String msg;
    private String hidremrk;
    private String hidsite;
    private String deleted;
    private String formdetailcode;

    
    

    public String getFormdetailcode() {
        return formdetailcode;
    }

    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public String getHidsite() {
        return hidsite;
    }

    public void setHidsite(String hidsite) {
        this.hidsite = hidsite;
    }

    public String getHidremrk() {
        return hidremrk;
    }

    public void setHidremrk(String hidremrk) {
        this.hidremrk = hidremrk;
    }

    public int getHidRta() {
        return hidRta;
    }

    public void setHidRta(int hidRta) {
        this.hidRta = hidRta;
    }

    public int getHidCaptcha() {
        return hidCaptcha;
    }

    public void setHidCaptcha(int hidCaptcha) {
        this.hidCaptcha = hidCaptcha;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getDocno() {
        return docno;
    }

    public void setDocno(int docno) {
        this.docno = docno;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

//    public int getRta() {
//        return rta;
//    }
//
//
//
//
//    public void setRta(int rta) {
//        this.rta = rta;
//    }

    public String getSitecheck() {
        return sitecheck;
    }

    public void setSitecheck(String sitecheck) {
        this.sitecheck = sitecheck;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getTcno() {
        return tcno;
    }

    public void setTcno(String tcno) {
        this.tcno = tcno;
    }

    /*
     * public int getCaptch() {
     * return captch;
     * }
     */

    /*
     * public void setCaptch(int captch) {
     * this.captch = captch;
     * }
     */

    public String getSqno() {
        return sqno;
    }

    public void setSqno(String sqno) {
        this.sqno = sqno;
    }

    public String getTimeperiod() {
        return timeperiod;
    }

    public void setTimeperiod(String timeperiod) {
        this.timeperiod = timeperiod;
    }

    public String saveAction() throws SQLException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session = request.getSession();
        String mode = getMode();
        System.out.println("Frm code : "+getFormdetailcode());
        if (mode.equalsIgnoreCase("A")) {
            int val = satMasterDAO.insert(getUsername(), getPassword(), getRemarks(), getTcno(), getHidCaptcha(),
                    getSqno(), getTimeperiod(), getMode(), getSitecheck(), getHidRta(), getSite(),getFormdetailcode(),session);
            if (val > 0) {
                setDocno(val);
                setUsername(getUsername());
                
                setPassword(getPassword());
                setHidremrk(getRemarks());
                setTcno(getTcno());
//               setCaptch(getCaptch());
                setSqno(getSqno());
                setTimeperiod(getTimeperiod());
                setHidCaptcha(getHidCaptcha());
                setHidRta(getHidRta());
                setHidsite(getSite());
                setMsg("Successfully Saved");
                return "success";
            } else if (val == -2) {
                setDocno(val);
                setUsername(getUsername());
                
                setPassword(getPassword());
                setHidremrk(getRemarks());
                setTcno(getTcno());
//               setCaptch(getCaptch());
                setSqno(getSqno());
                setTimeperiod(getTimeperiod());
                setHidCaptcha(getHidCaptcha());
                setHidRta(getHidRta());
                setHidsite(getSite());
                setMsg("User already Exist");
                return "fail";
            } else {
                setDocno(val);
                setUsername(getUsername());
                System.out.println("SQ no action: " + getSqno());
                System.out.println("Time action: " + getTimeperiod());
                System.out.println("remarks action: " + getRemarks());
                System.out.println("remarks action: " + getRemarks());
                System.out.println("Site action: " + getSite());
                System.out.println("is captcha: " + getHidCaptcha());
                System.out.println("RTA : " + getHidRta());
                setPassword(getPassword());
                setHidremrk(getRemarks());
                setTcno(getTcno());
//               setCaptch(getCaptch());
                setSqno(getSqno());
                setTimeperiod(getTimeperiod());
                setHidCaptcha(getHidCaptcha());
                setHidRta(getHidRta());
                setHidsite(getSite());
                setMsg("Not Saved");
                return "fail";
            }

        } else if (mode.equalsIgnoreCase("E")) {


            int val = satMasterDAO.edit(getUsername(), getPassword(), getRemarks(), getTcno(), getHidCaptcha(),
                    getSqno(), getTimeperiod(), getMode(), getSitecheck(), getHidRta(), getSite(), getDocno(),getFormdetailcode(),session);

            setDocno(val);
            setUsername(getUsername());

            setPassword(getPassword());
            setHidremrk(getRemarks());
            setTcno(getTcno());
//            setCaptch(getCaptch());
            setSqno(getSqno());
            setTimeperiod(getTimeperiod());
            setHidCaptcha(getHidCaptcha());
            setHidRta(getHidRta());
            setHidsite(getSite());
            setMsg("Successfully Saved");
            return "success";
        }

        else if (mode.equalsIgnoreCase("D")) {
            boolean status = satMasterDAO.delete(getUsername(), getPassword(), getRemarks(), getTcno(),
                    getHidCaptcha(), getSqno(), getTimeperiod(), getMode(), getSitecheck(), getHidRta(), getSite(),
                    getDocno());
            if (status) {
                setUsername(getUsername());

                setPassword(getPassword());
                setHidremrk(getRemarks());
                setTcno(getTcno());
                setSqno(getSqno());
                setTimeperiod(getTimeperiod());
                setHidCaptcha(getHidCaptcha());
                setHidRta(getHidRta());
                setHidsite(getSite());
                //System.out.println("Boolean :"+status);

                setMsg("Successfully Deleted");
                setDeleted("DELETED");

                return "success";
            } else {
                setUsername(getUsername());
                setPassword(getPassword());
                setHidremrk(getRemarks());
                setTcno(getTcno());
//    setCaptch(getCaptch());
                setSqno(getSqno());
                setTimeperiod(getTimeperiod());
                setHidCaptcha(getHidCaptcha());
                setHidRta(getHidRta());
                setHidsite(getSite());
                setDeleted("DELETED");

                setMsg("Not Deleted");
                return "fail";
            }

        }
        else {
            setUsername(getUsername());
            setPassword(getPassword());
            setHidremrk(getRemarks());
            setTcno(getTcno());
//            setCaptch(getCaptch());
            setSqno(getSqno());
            setTimeperiod(getTimeperiod());
            setHidCaptcha(getHidCaptcha());
            setHidRta(getHidRta());
            setHidsite(getSite());
            setMsg("Not Saved");
            return "fail";
        }

    }

    public JSONArray searchDetails() {
        //System.out.println("On action");
        JSONArray cellarray = new JSONArray();
        JSONObject cellobj = null;
        try {
            List<ClsSatMasterBean> list = satMasterDAO.list();
            for (ClsSatMasterBean bean : list) {
                cellobj = new JSONObject();
                cellobj.put("DOC_NO", bean.getDocno());
                cellobj.put("username", bean.getUsername());
                cellobj.put("tcno", bean.getTcno());
                cellobj.put("time_period", bean.getTimeperiod());
                cellobj.put("Site", bean.getSite());
                cellobj.put("remarks", bean.getRemarks());
                cellobj.put("password", bean.getPassword());
                cellobj.put("iscaptcha", bean.getHidCaptcha());
                cellobj.put("rta", bean.getHidRta());
                cellobj.put("sqno", bean.getSqno());
                cellarray.add(cellobj);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cellarray;

    }

}
