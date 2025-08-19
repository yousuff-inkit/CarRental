package com.dashboard.invoices.limoinvoicelist;

import java.io.IOException;
import java.sql.Connection;
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

public class ClslimoinvoicelistAction {
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
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
    //    java.sql.Date sqlUpToDate = null;
	    
	    String docno=request.getParameter("docno");
	    String[] docarray = docno.split(",");
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtlimoinvoicelist =conn.createStatement();
	        param = new HashMap();
	     
	        
	       /* String Sql="select format(sum(inv.mastertotal),2)total,if(ac.tax=1,format(inv.mastervat,2),0.0) vatamt,if(ac.tax=1,format(inv.masternettotal,2),format(inv.mastertotal,2))grandtotal,"
					 + "coalesce(ac.trnnumber,'')trnno,coalesce(inv.invoicenote,'')invnote,coalesce(inv.limolpono,'') lpono,coalesce(inv.limoevent,'') eventno,cur.code currencycode,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,u.user_name,coalesce(ac.address,'') address,coalesce(ac.per_mob,'') "+
			           " mobileno,coalesce(ac.mail1) mail,concat('Address :',coalesce(ac.address,''),', Mobile :',coalesce(ac.per_mob,''),', Mail :',"+
			           " coalesce(ac.mail1)) clientdetails,comp.company,comp.address ,comp.tel,comp.fax,br.branchname,inv.voc_no vocno,inv.cldocno ,"+
			           " date_format(inv.date,'%d-%m-%Y') date,date_format(inv.fromdate,'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,"+
			           " ac.refname from gl_limoinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
			           " inv.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join my_curr cur on inv.curid=cur.doc_no left join my_user u on u.doc_no=inv.userid where inv.doc_no in ("+docno+")";        
	        
	        System.out.println("SQLLL"+Sql);
	        ResultSet rs=stmtlimoinvoicelist.executeQuery(Sql);
	        
	        String invo="";String clientname="";String date="";String mob="";String clienttrn="";String total="";
	        String vatamt="";String grandtotal="";String clientaddress="";
	        
	        while(rs.next()){
	        	
	        	clientaddress=(rs.getString("clientdetails"));
	        	clientname=(rs.getString("refname"));
	        	date=(rs.getString("date"));
	        	invo=(rs.getString("vocno"));
	        	mob=(rs.getString("mobileno"));
	        	clienttrn=(rs.getString("trnno"));
	        	total=(rs.getString("total"));
	        	vatamt=(rs.getString("vatamt"));
	        	grandtotal=(rs.getString("grandtotal"));
	        }
	        */
	            
	        for (int i = 0; i < docarray.length; i++) {
				 param.put("p"+i,docarray[i]);   
				  
			 }  
			
	       /* param.put("date", date);
 		   param.put("invno", invo);
 		   param.put("clientname", clientname);
 		   param.put("clienttrn", clienttrn);
 		   param.put("total", total);
 		   param.put("taxamt", vatamt);
 		   param.put("clientaddress", clientaddress);
 		   param.put("tel", mob);
 		   param.put("grandtotal", grandtotal);
			*/
		//	String reportFileName = commonDAO.getBIBPrintPath("LIL");
		//	System.out.println("report file name "+reportFileName);
			 /*    String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
             imgpath=imgpath.replace("\\", "\\\\");
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");*/
            
        
          
	       
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getBIBPrintPath("LIL")));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            stmtlimoinvoicelist.close();
            
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
	   
	    ouputStream.flush();
	    ouputStream.close();
	   
	         
	}
	
	
	
}
