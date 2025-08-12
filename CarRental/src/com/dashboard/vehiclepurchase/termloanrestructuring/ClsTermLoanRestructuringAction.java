package com.dashboard.vehiclepurchase.termloanrestructuring;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsTermLoanRestructuringAction extends ActionSupport{
	ClsTermLoanRestructuringDAO DAO=new ClsTermLoanRestructuringDAO();
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon(); 
	private String hidbalanceloanacno,deleteucrdocno,hidpurchasedocno,vendor,cmbbranch;
	private String mode,detail,detailname,currentdate,hidvehicle,postingdate;
	private String msg;
	private int gridlength;
	private int dltgridlength;
	private double hidprincipalsum,total;
	
	
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
	
	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getDltgridlength() {
		return dltgridlength;
	}

	public void setDltgridlength(int dltgridlength) {
		this.dltgridlength = dltgridlength;
	}

	public String getHidbalanceloanacno() {
		return hidbalanceloanacno;
	}

	public void setHidbalanceloanacno(String hidbalanceloanacno) {
		this.hidbalanceloanacno = hidbalanceloanacno;
	}
	
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}

	public double getHidprincipalsum() {
		return hidprincipalsum;
	}

	public void setHidprincipalsum(double hidprincipalsum) {
		this.hidprincipalsum = hidprincipalsum;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getDeleteucrdocno() {
		return deleteucrdocno;
	}

	public void setDeleteucrdocno(String deleteucrdocno) {
		this.deleteucrdocno = deleteucrdocno;
	}

	public String getHidpurchasedocno() {
		return hidpurchasedocno;
	}

	public void setHidpurchasedocno(String hidpurchasedocno) {
		this.hidpurchasedocno = hidpurchasedocno;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getCurrentdate() {
		return currentdate;
	}

	public void setCurrentdate(String currentdate) {
		this.currentdate = currentdate;
	}

	public String getHidvehicle() {
		return hidvehicle;
	}

	public void setHidvehicle(String hidvehicle) {
		this.hidvehicle = hidvehicle;
	}

	public String getPostingdate() {
		return postingdate;
	}

	public void setPostingdate(String postingdate) {
		this.postingdate = postingdate;
	}
	
	public String saveAction() throws ParseException, SQLException{   
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String str="";
		System.out.println("mortgage grid length====="+getGridlength());  
		System.out.println("delete grid length====="+getDltgridlength());
        if(mode.equalsIgnoreCase("A")){      
			ArrayList<String> mortgagearray= new ArrayList<>(); 
			ArrayList<String> deletearray= new ArrayList<>(); 
			for(int i=0;i<getGridlength();i++){     
				String temp=requestParams.get("test"+i)[0];            
				mortgagearray.add(temp);
			} 
			for(int j=0;j<getDltgridlength();j++){     
				String temp1=requestParams.get("dtest"+j)[0];            
				deletearray.add(temp1);
			}
			System.out.println("mortgagearray========="+mortgagearray);
			System.out.println("deletearray========="+deletearray);
			/*String purchasestrarray,String deletestrarray,String deleteucrdocno,String purchasedocno,String currentdate,String vendor,double principalsum,double totalloanamount,String balanceloanacno,String branch,String vehicleremove,String postingdate,HttpSession session,HttpServletRequest request*/
			int val=DAO.gridsave(mortgagearray,deletearray,getDeleteucrdocno(),getHidpurchasedocno(),getCurrentdate(),getVendor(),getHidprincipalsum(),getTotal(),getHidbalanceloanacno(),getCmbbranch(),getHidvehicle(),getPostingdate(),session,request);   
			System.out.println("getDeleteucrdocno ===="+getDeleteucrdocno());
			System.out.println("getHidpurchasedocno ===="+getHidpurchasedocno());
			System.out.println("getCurrentdate ===="+getCurrentdate());
			System.out.println("getVendor ===="+getVendor());
			System.out.println("getHidprincipalsum ===="+getHidprincipalsum());
			System.out.println("getTotal ===="+getTotal());
			System.out.println("getHidbalanceacno ===="+getHidbalanceloanacno());
			System.out.println("getCmbbranch ===="+getCmbbranch());
			System.out.println("getHidvehicle ===="+getHidvehicle());
			System.out.println("getPostingdate ===="+getPostingdate());  
			if(val==0){ 
				setDetail("Purchase");
			    setDetailname("Term Loan Restructuring");
				//setHidcmbtaxtype(getCmbtaxtype());     
				setMsg("Successfully Restructured");            
				return "success";
			}
			else{   
				setDetail("Purchase");
			    setDetailname("Term Loan Restructuring");      
				//setHidcmbtaxtype(getCmbtaxtype()); 
			    setMsg("Not Restructured");  
				return "fail";
			}	
        }
    return "fail";
    }
}