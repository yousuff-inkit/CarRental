package com.controlcentre.masters.vehiclemaster.authority;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsAuthorityAction extends ActionSupport {
    ClsCommon ClsCommon = new ClsCommon();
    ClsAuthorityDAO authorityDAO = new ClsAuthorityDAO();
    ClsAuthorityBean bean;

    private int docno;
    private String authdatehidden;
    private String auth;
    private String authname;
    private String authdate;
    private String mode;
    private String deleted;
    private String msg;
    private String formdetail;
    private String formdetailcode;
    private String chkstatus;

    public String getChkstatus() {
        return chkstatus;
    }

    public void setChkstatus(String chkstatus) {
        this.chkstatus = chkstatus;
    }

    public String getFormdetail() {
        return formdetail;
    }

    public void setFormdetail(String formdetail) {
        this.formdetail = formdetail;
    }

    public String getFormdetailcode() {
        return formdetailcode;
    }

    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getAuthdatehidden() {
        return authdatehidden;
    }

    public void setAuthdatehidden(String authdatehidden) {
        this.authdatehidden = authdatehidden;
    }

    public int getDocno() {
        return docno;
    }

    public void setDocno(int docno) {
        this.docno = docno;
    }

    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public String getAuthname() {
        return authname;
    }

    public void setAuthname(String authname) {
        this.authname = authname;
    }

    public String getAuthdate() {
        return authdate;
    }

    public void setAuthdate(String authdate) {
        this.authdate = authdate;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public String saveAction() throws ParseException, SQLException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session = request.getSession();

        session.getAttribute("BRANCHID");

        String currentMode = getMode();

        // FIX 1: Ensure mode is not null to prevent NPE
        if (currentMode == null) {
            currentMode = "";
        }

        // FIX 2: Use getAuthdatehidden() because the JSP sends the date via the hidden field, not the div.
        java.sql.Date sqlStartDate = null;
        if (getAuthdatehidden() != null && !getAuthdatehidden().isEmpty()) {
            sqlStartDate = ClsCommon.changeStringtoSqlDate(getAuthdatehidden());
        }

        // FIX 3: "Yoda conditions" ("A".equalsIgnoreCase) prevent NPEs if currentMode happens to be null
        if ("A".equalsIgnoreCase(currentMode)) {
            int val = authorityDAO.insert(getAuth(), getAuthname(), sqlStartDate, session, getMode(), getFormdetailcode());
            if (val > 0.0) {
                setAuth(getAuth());
                setMode(getMode());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString()); // FIX 4: Null check before .toString()
                setDocno(val);
                setMsg("Successfully Saved");
                return "success";
            } else if (val == -1) {
                setAuth(getAuth());
                setMode(getMode());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setChkstatus("1");
                setMsg("Authority Already Exists");
                return "fail";
            } else {
                setAuth(getAuth());
                setMode(getMode());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setDocno(val);
                setMsg("Not Saved");
                return "fail";
            }
        } else if ("E".equalsIgnoreCase(currentMode)) {
            int Status = authorityDAO.edit(getDocno(), sqlStartDate, getAuth(), getAuthname(), session, getMode(), getFormdetailcode());
            if (Status > 0) {
                setAuth(getAuth());
                setDocno(getDocno());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setMode(getMode());
                setMsg("Updated Successfully");
                return "success";
            } else if (Status == -1) {
                setAuth(getAuth());
                setDocno(getDocno());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setMode(getMode());
                setChkstatus("2");
                setMsg("Authority Already Exists");
                return "fail";
            } else {
                setAuth(getAuth());
                setDocno(getDocno());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setMode(getMode());
                setMsg("Not Updated");
                return "fail";
            }
        } else if ("D".equalsIgnoreCase(currentMode)) {
            int Status = authorityDAO.delete(getDocno(), sqlStartDate, getAuth(), getAuthname(), session, getMode(), getFormdetailcode());
            if (Status > 0) {
                setDocno(getDocno());
                setAuth(getAuth());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setDeleted("DELETED");
                setMsg("Successfully Deleted");
                return "success";
            } else if (Status < 0) {
                setDocno(getDocno());
                setAuth(getAuth());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setMsg("References Present in Other Documents");
                return "fail";
            } else {
                setDocno(getDocno());
                setAuth(getAuth());
                setAuthname(getAuthname());
                if (sqlStartDate != null) setAuthdatehidden(sqlStartDate.toString());
                setMsg("Not Deleted");
                return "fail";
            }
        }
        return "fail";
    }

    public JSONArray searchDetails() {
        JSONArray cellarray = new JSONArray();
        JSONObject cellobj = null;
        try {
            List<ClsAuthorityBean> list = authorityDAO.list();
            for (ClsAuthorityBean bean : list) {
                cellobj = new JSONObject();
                cellobj.put("DOC_NO", bean.getDocno());
                cellobj.put("authname", bean.getAuthname());
                
                // Add a null check here as well to be safe
                if (bean.getAuthdate() != null) {
                    cellobj.put("date", bean.getAuthdate().toString());
                } else {
                    cellobj.put("date", "");
                }
                
                cellobj.put("authid", bean.getAuth());
                cellarray.add(cellobj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cellarray;
    }
}