package com.dashboard.audit.applieddetails;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsAppliedDetailsAction extends ActionSupport{
    
	ClsAppliedDetailsDAO accountStatementDAO= new ClsAppliedDetailsDAO();
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	
	private Map<String, Object> param = null;
	
	
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        System.out.println("IN PRINT");
		try {
               
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
               
               int acno=Integer.parseInt(request.getParameter("acno"));
               String accname = request.getParameter("accname");
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String atype = request.getParameter("atype");
        	   String sqltest="",sqltest1="";
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
               if((!(sqlFromDate==null))&&(!(sqlToDate==null))){
					sqltest=sqltest+" and t1.date between '"+sqlFromDate+"' and '"+sqlToDate+"' ";
					sqltest1=sqltest1+" and t1.date between '"+sqlFromDate+"' and '"+sqlToDate+"' ";
				}
               
               if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sqltest=sqltest+" and t1.brhId="+branch+"";
					sqltest1=sqltest1+" and t.brhId="+branch+"";
	    		}
               
               if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AP")){
						sqltest=sqltest+" and t1.dramount > 0";
						sqltest1=sqltest1+" and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AR")){
						sqltest=sqltest+" and t1.dramount < 0";
						sqltest1=sqltest1+" and t1.dramount < 0";
					}
				}
               System.out.println("sqltest1"+sqltest1);
				String appliedsql="";
				joins=commonDAO.getFinanceVocTablesJoins(conn);
				
				casestatement=commonDAO.getFinanceVocTablesCase(conn);
        	   
				String reportFileName = commonDAO.getBIBPrintPath("APD");
				ResultSet resultSetAccountStatement=null;
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
				 String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/nsibheader.jpg");
  		        imgpathheader=imgpathheader.replace("\\", "\\\\");
  		     String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/nsibfooter.jpg");
  		     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
                
               
               appliedsql = "select * from (select @i:=@i+1 as srno,a.transno,a.transtype,a.date,a.description,a.tramt,a.applied,a.balance,a.tranid tranno from "
               			+ " (Select t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t1.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transtype,t1.curid currency,t1.rate,t1.description,"
		        		+ "if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- "
		        		+ "if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),' * ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),' * ','Doc Type : ' ,"
		        		+ "coalesce(t1.dtype),' * ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),' * ','Applied : ', coalesce(if(t1.out_amount<0,"
		        		+ "round((t1.out_amount*-1),2),round(t1.out_amount,2))),"
		        		+ "' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from "
		        		+ "my_jvtran t1  where t1.status=3 and t1.acno="+acno+"  "
		        		+ ""+sqltest+" group by t1.tranid) a"+joins+",(select @i:=0) r "
		        		+ " union all"
		        		+ " select '' srno,a.transno,a.transtype,a.date,a.description,a.tramt,a.applying,a.balance,a.tranid tranno from "
		        		+ " (select t.doc_no transno,t.dtype transtype,t.description description,t.date date,(t.dramount*t.id) tramt,"
		        		+ " d.amount applying,((t.dramount*t.id)-(t.out_amount*t.id)) balance,t.out_amount*t.id out_amount,d.tranid,"
		        		+ " t.acno,t.curId currency,t.brhid from my_jvtran t1 left join my_outd d on t1.tranid=d.tranid left join my_jvtran t on d.ap_trid=t.tranid "
		        		+ " left join gl_invm m on m.dtype=t.dtype and t.doc_no=m.doc_no where t.status=3 and t1.status=3 and t1.acno="+acno+" "+sqltest1+") a "+joins+" ) aa order by aa.tranno,srno desc ";
	       	 System.out.println("printquery=="+appliedsql);
               resultSetAccountStatement = stmtAccountStatement.executeQuery(appliedsql);
	       	
	       	 
	       	
	       	   
	       	  
	       		
			   param.put("imgheaderpath", imgpathheader);
	           param.put("imgfooter", imgpathfooter);
	           param.put("accountqry", appliedsql);
	           param.put("accno", acno+"");
	           param.put("bank", accname);
	           param.put("fromdate", fromDate);
	           param.put("todate", toDate);
		       
		       param.put("printby", session.getAttribute("USERNAME"));
	        	 
               JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/audit/applieddetails/AppliedDetailPrint.jrxml"));
     	       JasperReport jasperReport = JasperCompileManager.compileReport(design);
     	       generateReportPDF(response, param, jasperReport, conn);
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		conn.close();
         	}
      	
	 }
	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
		  bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		  resp.reset();
			resp.resetBuffer();
			
			resp.setContentType("application/pdf");
			resp.setContentLength(bytes.length);
			ServletOutputStream ouputStream = resp.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.close();
			ouputStream.flush();

}
	 
}