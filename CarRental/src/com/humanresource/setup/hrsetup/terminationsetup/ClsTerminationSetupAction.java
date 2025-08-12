package com.humanresource.setup.hrsetup.terminationsetup;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsTerminationSetupAction {
    
    ClsTerminationSetupDAO saveDAO = new ClsTerminationSetupDAO();
    
    private String mode;
    
    private String msg;
    
    private String deleted;
    
    private String formdetailcode;

    private String category;
    
    private String hidshowlabel;
    
    private int trid;
    
    private String newmode;
    
    private int algridlength;
    
    private int refno;
    
    private int catid;
    
    private int terminationid;
   
    private int leaveid;
    
    private String hidtype;
    
    private int resignationid;
    
    public int getLeaveid() {
		return leaveid;
	}

	public void setLeaveid(int leaveid) {
		this.leaveid = leaveid;
	}

	public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public String getFormdetailcode() {
        return formdetailcode;
    }

    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getHidshowlabel() {
        return hidshowlabel;
    }

    public void setHidshowlabel(String hidshowlabel) {
        this.hidshowlabel = hidshowlabel;
    }

    public int getAlgridlength() {
        return algridlength;
    }

    public void setAlgridlength(int algridlength) {
        this.algridlength = algridlength;
    }

    public int getRefno() {
        return refno;
    }

    public void setRefno(int refno) {
        this.refno = refno;
    }

    public int getCatid() {
        return catid;
    }

    public void setCatid(int catid) {
        this.catid = catid;
    }

    public int getTerminationid() {
        return terminationid;
    }

    public void setTerminationid(int terminationid) {
        this.terminationid = terminationid;
    }

    public int getResignationid() {
        return resignationid;
    }

    public void setResignationid(int resignationid) {
        this.resignationid = resignationid;
    }

    public String getNewmode() {
        return newmode;
    }

    public void setNewmode(String newMode) {
        this.newmode = newMode;
    }

    public int getTrid() {
        return trid;
    }

    public void setTrid(int string) {
        this.trid = string;
    }

    public String getHidtype() {
        return hidtype;
    }

    public void setHidtype(String hidtype) {
        this.hidtype = hidtype;
    }

    public String saveAction() throws SQLException {
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        String type = "";
        Map<String, String[]> requestParams = request.getParameterMap();
        System.out.println("Entered Save Action");
        ArrayList<String> terminationarray= new ArrayList<>();
        for(int i=0;i<1;i++){
            if (requestParams.get("terminationtest"+i) != null && requestParams.get("terminationtest"+i).length>0) {
                System.out.println("Entered Term");
                String temp3=requestParams.get("terminationtest"+i)[0];
                terminationarray.add(temp3);
                type="TER";
            }
        }
        
        ArrayList<String> leavearray= new ArrayList<>();
        for(int i=0;i<1;i++){
            if (requestParams.get("leavetest"+i) != null && requestParams.get("leavetest"+i).length>0) {
                System.out.println("Entered Leave");
                String temp3=requestParams.get("leavetest"+i)[0];
                leavearray.add(temp3);
                type="LEV";
            }
        }
        
        ArrayList<String> resignationarray= new ArrayList<>();
        for(int i=0;i<1;i++){
            if (requestParams.get("resignationtest"+i) != null && requestParams.get("resignationtest"+i).length>0) {
                String temp3=requestParams.get("resignationtest"+i)[0];
                System.out.println("Entered Resign");
                resignationarray.add(temp3);
                type="RES";
            }
        }
        
        ArrayList<String> conditionarray= new ArrayList<>();
        for(int i=0;i<getAlgridlength() ;i++){
            String temp4=requestParams.get("condtest"+i)[0];
            conditionarray.add(temp4);
        }
        
        System.out.println("Reached 162");
        int val=0;
        if(type.equalsIgnoreCase("TER"))
            val=saveDAO.insert(getRefno(),getCatid(),getMode(),getFormdetailcode(),session,request,terminationarray,conditionarray,type);
        else if (type.equalsIgnoreCase("RES"))
            val=saveDAO.insert(getRefno(),getCatid(),getMode(),getFormdetailcode(),session,request,resignationarray,conditionarray,type);
        else if (type.equalsIgnoreCase("LEV"))
        	 val=saveDAO.insert(getRefno(),getCatid(),getMode(),getFormdetailcode(),session,request,leavearray,conditionarray,type);
        if(val>0) {
            setRefno(getRefno());
            setCategory(getCategory());
            setCatid(getCatid());
            setTerminationid(val);
            setResignationid(val);
            System.out.println("HIDLABEL"+getHidshowlabel()+"    "+ val+"    "+type);
            setHidshowlabel(getHidshowlabel());
            setTrid(val);
            setHidtype(type);
            setNewmode("Saved");
            return "success";
        } else {
            setRefno(getRefno());
            setCategory(getCategory());
            setCatid(getCatid());
            setTrid(val);
            setTerminationid(val);
            setResignationid(val);
            setHidtype(type);
            System.out.println("HIDLABEL"+getHidshowlabel()+"    "+ val);
            setHidshowlabel(getHidshowlabel());
            
            setNewmode("notSaved");
            return "fail";
        }
        
    }
    
}
