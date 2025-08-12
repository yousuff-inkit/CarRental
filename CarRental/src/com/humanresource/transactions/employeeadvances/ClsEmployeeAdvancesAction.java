package com.humanresource.transactions.employeeadvances;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsEmployeeAdvancesAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsEmployeeAdvancesDAO employeeAdvancesDAO= new ClsEmployeeAdvancesDAO();
	ClsEmployeeAdvancesBean employeeAdvancesBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String deductionScheduleDate;
	private String hiddeductionScheduleDate;
	private String txtemployeerefno;
	private int txtdeductionscheduledocno;
	private String txtemployeedetails;
	private int txtemployeedocno;
	private double txtamount;
	private int txtinstnos;
	private double txtinstamt;
	private String startDate;
	private String hidstartDate;
	private String txtdescription;
	
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private double txtfromrate;
	private double txtfromamount;
	private double txtfrombaseamount;
	

	//Deduction Schedule Grid
	private int gridlength;
	
	
	//Print
		private String lblcompname;
		private String lblcompaddress;
		private String lblpobox;
		private String lblprintname;
		private String lblcomptel;
		private String lblcompfax;
		private String lblbranch;
		private String lbllocation;
		private String lblservicetax;
		private String lblpan;
		private String lblcstno;
		private int srno;
		private int amount;
		private String date;
	
	
		//for hide
		private int firstarray;
		private int secarray;
		private int txtheader;
		
		private String url;
		
		
		public int getTxtfromdocno() {
			return txtfromdocno;
		}

		public void setTxtfromdocno(int txtfromdocno) {
			this.txtfromdocno = txtfromdocno;
		}

		public String getTxtfromaccid() {
			return txtfromaccid;
		}

		public void setTxtfromaccid(String txtfromaccid) {
			this.txtfromaccid = txtfromaccid;
		}

		public String getTxtfromaccname() {
			return txtfromaccname;
		}

		public void setTxtfromaccname(String txtfromaccname) {
			this.txtfromaccname = txtfromaccname;
		}

		public String getCmbfromcurrency() {
			return cmbfromcurrency;
		}

		public void setCmbfromcurrency(String cmbfromcurrency) {
			this.cmbfromcurrency = cmbfromcurrency;
		}

		public double getTxtfromrate() {
			return txtfromrate;
		}

		public void setTxtfromrate(double txtfromrate) {
			this.txtfromrate = txtfromrate;
		}

		public double getTxtfromamount() {
			return txtfromamount;
		}

		public void setTxtfromamount(double txtfromamount) {
			this.txtfromamount = txtfromamount;
		}

		public double getTxtfrombaseamount() {
			return txtfrombaseamount;
		}

		public void setTxtfrombaseamount(double txtfrombaseamount) {
			this.txtfrombaseamount = txtfrombaseamount;
		}
		
	    public int getAmount() {
			return amount;
		}

		public void setAmount(int amount) {
			this.amount = amount;
		}

		public String getDate() {
			return date;
		}

		public void setDate(String date) {
			this.date = date;
		}

		public int getSrno() {
			return srno;
		}

		public void setSrno(int srno) {
			this.srno = srno;
		}

		public String getLblpan() {
			return lblpan;
		}

		public void setLblpan(String lblpan) {
			this.lblpan = lblpan;
		}

		public String getLblcstno() {
			return lblcstno;
		}

		public void setLblcstno(String lblcstno) {
			this.lblcstno = lblcstno;
		}

	public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
		}

	public String getLblcompname() {
			return lblcompname;
		}

		public void setLblcompname(String lblcompname) {
			this.lblcompname = lblcompname;
		}

		public String getLblcompaddress() {
			return lblcompaddress;
		}

		public void setLblcompaddress(String lblcompaddress) {
			this.lblcompaddress = lblcompaddress;
		}

		public String getLblpobox() {
			return lblpobox;
		}

		public void setLblpobox(String lblpobox) {
			this.lblpobox = lblpobox;
		}

		public String getLblprintname() {
			return lblprintname;
		}

		public void setLblprintname(String lblprintname) {
			this.lblprintname = lblprintname;
		}

		public String getLblcomptel() {
			return lblcomptel;
		}

		public void setLblcomptel(String lblcomptel) {
			this.lblcomptel = lblcomptel;
		}

		public String getLblcompfax() {
			return lblcompfax;
		}

		public void setLblcompfax(String lblcompfax) {
			this.lblcompfax = lblcompfax;
		}

		public String getLblbranch() {
			return lblbranch;
		}

		public void setLblbranch(String lblbranch) {
			this.lblbranch = lblbranch;
		}

		public String getLbllocation() {
			return lbllocation;
		}

		public void setLbllocation(String lbllocation) {
			this.lbllocation = lbllocation;
		}

		public String getLblservicetax() {
			return lblservicetax;
		}

		public void setLblservicetax(String lblservicetax) {
			this.lblservicetax = lblservicetax;
		}

		public int getFirstarray() {
			return firstarray;
		}

		public void setFirstarray(int firstarray) {
			this.firstarray = firstarray;
		}

		public int getSecarray() {
			return secarray;
		}

		public void setSecarray(int secarray) {
			this.secarray = secarray;
		}

		public int getTxtheader() {
			return txtheader;
		}

		public void setTxtheader(int txtheader) {
			this.txtheader = txtheader;
		}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDeductionScheduleDate() {
		return deductionScheduleDate;
	}

	public void setDeductionScheduleDate(String deductionScheduleDate) {
		this.deductionScheduleDate = deductionScheduleDate;
	}

	public String getHiddeductionScheduleDate() {
		return hiddeductionScheduleDate;
	}

	public void setHiddeductionScheduleDate(String hiddeductionScheduleDate) {
		this.hiddeductionScheduleDate = hiddeductionScheduleDate;
	}

	public String getTxtemployeerefno() {
		return txtemployeerefno;
	}

	public void setTxtemployeerefno(String txtemployeerefno) {
		this.txtemployeerefno = txtemployeerefno;
	}

	public int getTxtdeductionscheduledocno() {
		return txtdeductionscheduledocno;
	}

	public void setTxtdeductionscheduledocno(int txtdeductionscheduledocno) {
		this.txtdeductionscheduledocno = txtdeductionscheduledocno;
	}

	public String getTxtemployeedetails() {
		return txtemployeedetails;
	}

	public void setTxtemployeedetails(String txtemployeedetails) {
		this.txtemployeedetails = txtemployeedetails;
	}

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public int getTxtinstnos() {
		return txtinstnos;
	}

	public void setTxtinstnos(int txtinstnos) {
		this.txtinstnos = txtinstnos;
	}

	public double getTxtinstamt() {
		return txtinstamt;
	}

	public void setTxtinstamt(double txtinstamt) {
		this.txtinstamt = txtinstamt;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getHidstartDate() {
		return hidstartDate;
	}

	public void setHidstartDate(String hidstartDate) {
		this.hidstartDate = hidstartDate;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date deductionsScheduleDate;
	java.sql.Date startingDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsEmployeeAdvancesBean bean = new ClsEmployeeAdvancesBean();
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")){   
			deductionsScheduleDate = ClsCommon.changeStringtoSqlDate(getDeductionScheduleDate());
			startingDate = ClsCommon.changeStringtoSqlDate(getStartDate());
		}
		if(mode.equalsIgnoreCase("A")){
			
			
			 ClsEmployeeAdvancesAction clsEmployeeAdvancesAction = new ClsEmployeeAdvancesAction();
			/*Deduction Schedule Grid Saving*/
			 clsEmployeeAdvancesAction.setTxtfromdocno(getTxtfromdocno());
			 clsEmployeeAdvancesAction.setCmbfromcurrency(getCmbfromcurrency());
			 clsEmployeeAdvancesAction.setTxtfromrate(getTxtfromrate());
			 clsEmployeeAdvancesAction.setTxtfromamount(getTxtfromamount());
			 clsEmployeeAdvancesAction.setTxtdescription(getTxtdescription());
			 clsEmployeeAdvancesAction.setTxtfrombaseamount(getTxtfrombaseamount());
			 
			 
			ArrayList<String> deductionschedulearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				deductionschedulearray.add(temp);
			}
			/*Deduction Schedule Grid Saving Ends*/
			
			
						int val=employeeAdvancesDAO.insert(getFormdetailcode(),deductionsScheduleDate,getTxtemployeerefno(),getTxtemployeedocno(),getTxtamount(),getTxtinstnos(),startingDate,getTxtinstamt(),getTxtdescription(),deductionschedulearray,clsEmployeeAdvancesAction,session,request,mode);
						if(val>0.0){
							
							setTxtdeductionscheduledocno(val);
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setMsg("Not Saved");
							return "fail";
						}	
		} else if(mode.equalsIgnoreCase("E")){
			
			 ClsEmployeeAdvancesAction clsEmployeeAdvancesAction = new ClsEmployeeAdvancesAction();
				/*Deduction Schedule Grid Saving*/
			 
				 clsEmployeeAdvancesAction.setTxtfromdocno(getTxtfromdocno());
				 clsEmployeeAdvancesAction.setCmbfromcurrency(getCmbfromcurrency());
				 clsEmployeeAdvancesAction.setTxtfromrate(getTxtfromrate());
				 clsEmployeeAdvancesAction.setTxtfromamount(getTxtfromamount());
				 clsEmployeeAdvancesAction.setTxtdescription(getTxtdescription());
				 clsEmployeeAdvancesAction.setTxtfrombaseamount(getTxtfrombaseamount());
				

			/*Deduction Schedule Grid Saving*/
			ArrayList<String> deductionschedulearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				deductionschedulearray.add(temp);
			}
			/*Deduction Schedule Grid Saving Ends*/
			
			boolean Status=employeeAdvancesDAO.edit(getTxtdeductionscheduledocno(),getFormdetailcode(),deductionsScheduleDate,getTxtemployeerefno(),getTxtemployeedocno(),getTxtamount(),getTxtinstnos(),startingDate,getTxtinstamt(),getTxtdescription(),deductionschedulearray, clsEmployeeAdvancesAction,session,request,mode);
			if(Status){

				setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
			
	  } else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=employeeAdvancesDAO.delete(getTxtdeductionscheduledocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
		} else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			employeeAdvancesBean=employeeAdvancesDAO.getViewDetails(session,getTxtdeductionscheduledocno());
			
			setDeductionScheduleDate(employeeAdvancesBean.getDeductionScheduleDate());
			setTxtemployeerefno(employeeAdvancesBean.getTxtemployeerefno());
			setTxtemployeedetails(employeeAdvancesBean.getTxtemployeedetails());
			setTxtemployeedocno(employeeAdvancesBean.getTxtemployeedocno());
			setTxtamount(employeeAdvancesBean.getTxtamount());
			setTxtinstnos(employeeAdvancesBean.getTxtinstnos());
			setTxtinstamt(employeeAdvancesBean.getTxtinstamt());
			setStartDate(employeeAdvancesBean.getStartDate());
			setTxtdescription(employeeAdvancesBean.getTxtdescription());
			setFormdetailcode(employeeAdvancesBean.getFormdetailcode());
			setTxtfromdocno(employeeAdvancesBean.getTxtfromdocno());
			setTxtfromaccid(employeeAdvancesBean.getTxtfromaccid());
			setTxtfromaccname(employeeAdvancesBean.getTxtfromaccname());

			setCmbfromcurrency(employeeAdvancesBean.getCmbfromcurrency());
			setTxtfromrate(employeeAdvancesBean.getTxtfromrate());
			setTxtfromamount(employeeAdvancesBean.getTxtfromamount());
			setTxtdescription(employeeAdvancesBean.getTxtdescription());
			
			return "success";
		}
		return "fail";
	}
	
	/*public  JSONArray searchDetails(HttpSession session,String empname,String docNo,String date,String amount){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= ClsDeductionScheduleDAO.dscMainSearch(session, empname, docNo, date, amount);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}*/
	
	
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		employeeAdvancesBean= new ClsEmployeeAdvancesBean();    
		ArrayList<String> arraylist = employeeAdvancesDAO.getPrintdetails(docno,session);
		request.setAttribute("details",arraylist);
		employeeAdvancesBean=employeeAdvancesDAO.getPrint(request,docno,branch,header);
		
		setUrl(ClsCommon.getPrintPath("DSC"));   
		setLblcompname(employeeAdvancesBean.getLblcompname());
		setLblcompaddress(employeeAdvancesBean.getLblcompaddress());
		setLblpobox(employeeAdvancesBean.getLblpobox());
		setLblprintname(employeeAdvancesBean.getLblprintname());
		setLblcomptel(employeeAdvancesBean.getLblcomptel());
		setLblcompfax(employeeAdvancesBean.getLblcompfax());
		setLblbranch(employeeAdvancesBean.getLblbranch());
		setLbllocation(employeeAdvancesBean.getLbllocation());
		setTxtdeductionscheduledocno(employeeAdvancesBean.getTxtdeductionscheduledocno());
		setDeductionScheduleDate(employeeAdvancesBean.getDeductionScheduleDate());
		setTxtemployeerefno(employeeAdvancesBean.getTxtemployeerefno());
		setTxtemployeedetails(employeeAdvancesBean.getTxtemployeedetails());
		setTxtamount(employeeAdvancesBean.getTxtamount());
		setTxtinstnos(employeeAdvancesBean.getTxtinstnos());
		setStartDate(employeeAdvancesBean.getStartDate());
		setTxtdescription(employeeAdvancesBean.getTxtdescription());
		
		
		
		// for hide
		setFirstarray(employeeAdvancesBean.getFirstarray());
		setSecarray(employeeAdvancesBean.getSecarray());
		setTxtheader(employeeAdvancesBean.getTxtheader());
	
		return "print";
	}
	
	

	public void setData() {

    	    setTxtemployeerefno(getTxtemployeerefno());
    	    setTxtemployeedetails(getTxtemployeedetails());
    	    setTxtemployeedocno(getTxtemployeedocno());
    	    if(deductionsScheduleDate != null){
    	    setHiddeductionScheduleDate(deductionsScheduleDate.toString());
    	    }
    	    setTxtamount(getTxtamount());
    	    setTxtinstnos(getTxtinstnos());
    	    if(startingDate != null){
    	    setHidstartDate(startingDate.toString());
    	    }
    	    setTxtinstamt(getTxtinstamt());  
    	    setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
		}
}


