package com.humanresource.setup.hrsetup.bankdetails;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsBankdetailsAction {
    
    
    ClsCommon ClsCommon=new ClsCommon();

    ClsBankdetailsDAO saveDAO= new ClsBankdetailsDAO();
    
    private String  bankdate,brchname,ifsccode,remarks,mode,msg,deleted,datehidden,formdetailcode ;
    private int docno;
    
    public String getBankdate() {
        return bankdate;
    }

    public void setBankdate(String bankdate) {
        this.bankdate = bankdate;
    }

    public String getBrchname() {
        return brchname;
    }

    public void setBrchname(String brchname) {
        this.brchname = brchname;
    }

    public String getIfsccode() {
        return ifsccode;
    }

    public void setIfsccode(String ifsccode) {
        this.ifsccode = ifsccode;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
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

    public String getDatehidden() {
        return datehidden;
    }

    public void setDatehidden(String datehidden) {
        this.datehidden = datehidden;
    }

    public String getFormdetailcode() {
        return formdetailcode;
    }

    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }

    public int getDocno() {
        return docno;
    }

    public void setDocno(int docno) {
        this.docno = docno;
    }

    public String saveAction() throws SQLException {
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
      
        //System.out.println("INSIDE INSERT");
        
        if(getMode().equalsIgnoreCase("A")) {
     
            java.sql.Date formdate=    ClsCommon.changeStringtoSqlDate(getBankdate());
            
            int val=saveDAO.insert(formdate,getBrchname(),getIfsccode(),getRemarks(),getMode(),getFormdetailcode(),session,request);
    
            if(val>0) {
                
                setDocno(val);
                setDatehidden(formdate.toString());
                setBrchname(getBrchname());
                setIfsccode(getIfsccode());
                setRemarks(getRemarks());
                   
                setMsg("Successfully Saved");
                return "success";
              } else {
                
               setDatehidden(formdate.toString());
               setBrchname(getBrchname());
               setIfsccode(getIfsccode());
               setRemarks(getRemarks());
               
               setMsg("Not Saved");
                return "fail";
           }
       }
         else if(getMode().equalsIgnoreCase("E")) {
            
            java.sql.Date formdate= ClsCommon.changeStringtoSqlDate(getBankdate());
     
            int val=saveDAO.Update(getDocno(),formdate,getBrchname(),getIfsccode(),getRemarks(),getMode(),getFormdetailcode(),session,request);
            
            if(val>0) {
                
                setDocno(val);
                setDatehidden(formdate.toString());
                setBrchname(getBrchname());
                setIfsccode(getIfsccode());
                setRemarks(getRemarks());
                   
                 setMsg("Updated Successfully");
                 return "success";
          }  else {
                setDocno(val);
                setDatehidden(formdate.toString());
                setBrchname(getBrchname());
                setIfsccode(getIfsccode());
                setRemarks(getRemarks());
                   
                 setMsg("Not Updated");
                 return "fail";
            }
        }
        
        else if(getMode().equalsIgnoreCase("D")) {
     
            java.sql.Date formdate= ClsCommon.changeStringtoSqlDate(getBankdate());
     
            int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request);
            
            if(val>0) {
                
                setDocno(val);
                setDatehidden(formdate.toString());
                setBrchname(getBrchname());
                setIfsccode(getIfsccode());
                setRemarks(getRemarks());
                setDeleted("DELETED");
                 setMsg("Successfully Deleted");
                 return "success";
                
            } else {
                setDocno(val);
                setDatehidden(formdate.toString());
                setBrchname(getBrchname());
                setIfsccode(getIfsccode());
                setRemarks(getRemarks());
               
                 setMsg("Not Deleted");
                 return "fail";
            }
            
        }
        return "fail";
      }
        
    }

