package com.dashboard.salik.othersalik;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsOtherSalikAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsOtherSalikDAO salikDAO=new ClsOtherSalikDAO();
	
	private String mode;
	private int gridlength;
	private String salikarrays,msg,detail,detailname;
	
	
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getSalikarrays() {
		return salikarrays;
	}
	public void setSalikarrays(String salikarrays) {
		this.salikarrays = salikarrays;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String saveAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		if(mode.equalsIgnoreCase("D")){
			
			int val=salikDAO.delete(getSalikarrays(),session,request,mode);
			if(val>0.0){
				setDetail("Salik");
				setDetailname("Other Salik");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setDetail("Salik");
				setDetailname("Other Salik");
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}


	
}
