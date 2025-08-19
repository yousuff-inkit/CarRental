package com.operations.clientrelations.nationality;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsNationalityAction extends ActionSupport{

	ClsNationalityDAO nationalityDAO= new ClsNationalityDAO();
	ClsNationalityBean nationalitybean;
	
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String msg;
	private String txtname;
	private int docno;
	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getTxtname() {
		return txtname;
	}

	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsNationalityBean nationalitybean = new ClsNationalityBean();
		
		if(mode.equalsIgnoreCase("A")){
			int val=nationalityDAO.insert(getFormdetailcode(),getDocno(),getTxtname(),session,getMode());  
			if(val>0.0){
				setTxtname(getTxtname());
				setMode(getMode());
//				System.out.println(val);
				setDocno(val);
				setMsg("Successfully Saved");
				
				return "success";
				
			}
			 else if(val==-1)
			   {
				 setTxtname(getTxtname());
				 setMode(getMode());
				setChkstatus("1");
				setMsg("Name Already Exists");
			    return "fail";
			   }
			else{
				setTxtname(getTxtname());
				setMode(getMode());
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=nationalityDAO.edit(getFormdetailcode(),getDocno(),getTxtname().trim(),session,mode);    
			if(Status>0){
				//System.out.println("docno1------"+getDocno());	
				setTxtname(getTxtname());
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setTxtname(getTxtname());
				setDocno(getDocno());
				setChkstatus("2");
				setMode(getMode());
			    setMsg("Name Already Exists");
			    return "fail";
			}
			else{
				setTxtname(getTxtname());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Updated");
				return "fail";
			}
		}
		return "fail";
	}

	public JSONArray searchDetails(String check){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsNationalityBean> list= nationalityDAO.list(check);  
			  for(ClsNationalityBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getDocno());
			  cellobj.put("name", bean.getTxtname());
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
}
