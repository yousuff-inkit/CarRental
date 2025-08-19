package com.operations.setup.questionnaire;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.setup.questionnaire.ClsquestionnaireDAO;

public class ClsQuestionnaireAction {
	ClsCommon com=new ClsCommon();
	ClsQuestionnaireBean bean=new ClsQuestionnaireBean();
	ClsquestionnaireDAO DAO=new ClsquestionnaireDAO();
	private int docno;
	private String date;
	private String txttype;
	private int servicedocno;
	private String servicetype;
	private int chkcomagent;
	private int txtdocno;
	private String txtquestion;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
	private String url;
	private int masterdoc_no;
	private int gridlen;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxttype() {
		return txttype;
	}
	public void setTxttype(String txttype) {
		this.txttype = txttype;
	}
	public int getTxtdocno() {
		return txtdocno;
	}
	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}
	public String getTxtquestion() {
		return txtquestion;
	}
	public void setTxtquestion(String txtquestion) {
		this.txtquestion = txtquestion;
	}
	
	
	public String getServicetype() {
		return servicetype;
	}
	public void setServicetype(String servicetype) {
		this.servicetype = servicetype;
	}
	public int getServicedocno() {
		return servicedocno;
	}
	public void setServicedocno(int servicedocno) {
		this.servicedocno = servicedocno;
	}
	public int getChkcomagent() {
		return chkcomagent;
	}
	public void setChkcomagent(int chkcomagent) {
		this.chkcomagent = chkcomagent;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getGridlen() {
		return gridlen;
	}
	public void setGridlen(int gridlen) {
		this.gridlen = gridlen;
	}
	
	
	public String saveAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		System.out.println("inside saveaction"+getMode());

		try{
	
			ArrayList<String> arr= new ArrayList<>();

			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")){
				
			for(int i=0;i<getGridlen();i++){
				String temp=requestParams.get("mate"+i)[0];		
				arr.add(temp);
			}
			}
			
			
			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.insert(date,getTxtquestion(),getTxtdocno(),getTxttype(),getServicedocno(),getChkcomagent(),arr,session,request,mode,getFormdetailcode());

				//int docno=Integer.parseInt(request.getAttribute("docNo").toString());

				if(val>0){
					setMasterdoc_no(val);  
					setDocno(val);  
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setServicedocno(getServicedocno());
					setServicetype(getServicetype());
					setChkcomagent(getChkcomagent());
					setTxttype(getTxttype());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{

					setDocno(val);
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setServicedocno(getServicedocno());
					setServicetype(getServicetype());
					setChkcomagent(getChkcomagent());
					setTxttype(getTxttype());
					setMsg("Not Saved");
					returns="fail";


				}

			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				boolean status=DAO.edit(date,getDocno(),getTxtquestion(),getTxtdocno(),getTxttype(),getServicedocno(),getChkcomagent(),arr,session,request,mode,getFormdetailcode());
  

				if(status){   
					//setMasterdoc_no(getDocno()+"");  
					setDocno(getDocno());
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setServicedocno(getServicedocno());
					setChkcomagent(getChkcomagent());
					setServicetype(getServicetype());
					setTxttype(getTxttype());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{

					setDocno(val);
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setServicedocno(getServicedocno());
					setServicetype(getServicetype());
					setChkcomagent(getChkcomagent());
					setTxttype(getTxttype());
					setMsg("Not Updated");
					returns="fail";


				}
			}

			if(mode.equalsIgnoreCase("D")){
System.out.println("in delete");
				java.sql.Date date=com.changeStringtoSqlDate(getDate());
							boolean	status=DAO.delete(date,getDocno(),getTxtquestion(),getTxtdocno(),getTxttype(),arr,session,request,mode,getFormdetailcode());


				if(status){  
					setDocno(getDocno());
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setTxttype(getTxttype());
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{

					setDocno(val);
					setDate(date+"");
					setMasterdoc_no(getMasterdoc_no());
					setTxtdocno(getTxtdocno());
					setTxtquestion(getTxtquestion());
					setTxttype(getTxttype());
					setMsg("Not Deleted");
					returns="fail";


				}

			}
	

			else if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(getDocno());	
				setDocno(getDocno());   
				//setTxtdocno(getTxtdocno());
				setTxtquestion(getTxtquestion());
				//setTxttype(getTxttype());
				setServicetype(getServicetype());
				setServicedocno(getServicedocno());
				setChkcomagent(getChkcomagent());
				returns="success";

			}
	

		}
			catch(Exception e){
			e.printStackTrace();
		}

		return returns;
	}

	
}
