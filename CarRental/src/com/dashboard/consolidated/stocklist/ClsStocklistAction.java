package com.dashboard.consolidated.stocklist;
  
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
public class ClsStocklistAction extends ActionSupport{
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsStocklistDAO stocklistDAO= new ClsStocklistDAO();
	ClsStocklistBean stocklistBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcashtotal;
	private String lblcardtotal;
	private String lblchequetotal;
	private String lblappliedtotal;
	private String lblbalancetotal;
	private String lblnetbalance,lblprid,lbldepartment;
	private String url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblprid() {
		return lblprid;
	}
	public void setLblprid(String lblprid) {
		this.lblprid = lblprid;
	}
	public String getLbldepartment() {
		return lbldepartment;
	}
	public void setLbldepartment(String lbldepartment) {
		this.lbldepartment = lbldepartment;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblcashtotal() {
		return lblcashtotal;
	}
	public void setLblcashtotal(String lblcashtotal) {
		this.lblcashtotal = lblcashtotal;
	}
	public String getLblcardtotal() {
		return lblcardtotal;
	}
	public void setLblcardtotal(String lblcardtotal) {
		this.lblcardtotal = lblcardtotal;
	}
	public String getLblchequetotal() {
		return lblchequetotal;
	}
	public void setLblchequetotal(String lblchequetotal) {
		this.lblchequetotal = lblchequetotal;
	}
	public String getLblappliedtotal() {
		return lblappliedtotal;
	}
	public void setLblappliedtotal(String lblappliedtotal) {
		this.lblappliedtotal = lblappliedtotal;
	}
	public String getLblbalancetotal() {
		return lblbalancetotal;
	}
	public void setLblbalancetotal(String lblbalancetotal) {
		this.lblbalancetotal = lblbalancetotal;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		System.out.println("===IN PRINT===");
		/*String barchval = request.getParameter("barchval");
		String statusselect = request.getParameter("statusselect");
		String psrno = request.getParameter("psrno");
		String load = request.getParameter("load");
		String locid = request.getParameter("locid");*/
		//hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+
		//"&hidproduct="+hidproduct+"&barchval="+branchid+"&hidept="+hidept+"&locid="+locid+"&zeroqty="+zeroqty
		String barchval = request.getParameter("barchval");
		String hidbrand = request.getParameter("hidbrand");
		String hidtype = request.getParameter("hidtype");
		String hidcat = request.getParameter("hidcat");
		String hidsubcat = request.getParameter("hidsubcat");
		String hidproduct = request.getParameter("hidproduct");
		String hidept = request.getParameter("hidept");
		String locid = request.getParameter("locid");
		String zeroqty = request.getParameter("zeroqty");
		
		String todate = request.getParameter("todate");
		String expupto = request.getParameter("expupto");
		
		
		
		stocklistBean=stocklistDAO.getPrint(request,barchval,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,hidept,zeroqty);
		setLblcompname(stocklistBean.getLblcompname());
		setLblcompaddress(stocklistBean.getLblcompaddress());
		setLblprintname(stocklistBean.getLblprintname());
		setLblprintname1(stocklistBean.getLblprintname1());
		setLblcomptel(stocklistBean.getLblcomptel());
		setLblcompfax(stocklistBean.getLblcompfax());
		setLblbranch(stocklistBean.getLblbranch());
		setLbllocation(stocklistBean.getLbllocation());
		setLblservicetax(stocklistBean.getLblservicetax());
		setLblpan(stocklistBean.getLblpan());
		setLblcstno(stocklistBean.getLblcstno());
		setLblcashtotal(stocklistBean.getLblcashtotal());
		setLblcardtotal(stocklistBean.getLblcardtotal());
		setLblchequetotal(stocklistBean.getLblchequetotal());
		setLblappliedtotal(stocklistBean.getLblappliedtotal());
		setLblbalancetotal(stocklistBean.getLblbalancetotal());
		setLblnetbalance(stocklistBean.getLblnetbalance());
		setLbldepartment(stocklistBean.getLbldepartment());
		setLblprid(stocklistBean.getLblprid());
		
		String reportFileName = commonDAO.getBIBPrintPath("BSL");
		System.out.println("===IN PRINT==="+reportFileName);
		if(reportFileName.contains(".jrxml")==true)  
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
			 try {
				 param = new HashMap();
			
		      	 conn = connDAO.getMyConnection();
             	 Statement stmtPC = conn.createStatement();
                 
             	
                 String sqltest="",sqltest1="";
                 
                 String sqltest2="";
                 java.sql.Date sqltodate = null;
                 
                 if(expupto.equalsIgnoreCase("1"))
                 {
               	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
               	{
               		sqltodate=commonDAO.changeStringtoSqlDate(todate);
               		 sqltest2=sqltest2+ " and i.exp_date<='"+sqltodate+"' " ;
               		
               	}
               	else{
               
               	}
                 }
                 
                 
     	        
     	    	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
     	    		sqltest+=" and i.brhid='"+barchval+"'";
     	    		sqltest1+=" and i.brhid='"+barchval+"'";
     	 		}
     	    	
     	    	if(!((locid.equalsIgnoreCase("a")) || (locid.equalsIgnoreCase("NA")) || (locid.equalsIgnoreCase("")))){
     	    		sqltest+=" and i.locid='"+locid+"'";
     	    		sqltest1+=" and i.locid='"+locid+"'";
     	 		}
     	    	String sqltest3="";
     	        String sqljoin="";
     	        if(zeroqty.equalsIgnoreCase("1")){
     	        	sqljoin="left";
     	        }
     	        else{
     	        	sqljoin="inner";
     	        }
     	    	

     			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and bd.doc_no in ("+hidbrand+")";
     			}

     			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and pt.doc_no in ("+hidtype+")";
     			}

     			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and cat.doc_no in ("+hidcat+")";
     			}
     			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and sc.doc_no in ("+hidsubcat+")";
     			}

     			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and m.doc_no in ("+hidproduct+")";
     			}
     			 
     			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
     				sqltest3+=" and d.doc_no in ("+hidept+")";
     			}
     	    	System.out.println("12345678"+locid);
     	    	
     	    	 String sqlStock ="";
     	    	String dbListQuery = "SELECT distinct dbname, compname FROM alintercomp.my_intrcomp m";
		        ResultSet dbResultSet = stmtPC.executeQuery(dbListQuery);
		        String unionstr="";
		        int rowCount = 0;
		        while (dbResultSet.next()) {
		            String dbname = dbResultSet.getString("dbname"); 
                    sqlStock +="select @i:=@i+1 srno,b.* from(select concat(d.department) department,coalesce(round(i.qty,0),'') qty ,m.productname,"
                		 + "round(fixingprice,2) price, coalesce(DATE_FORMAT(exp_date, '%m/%y'),'') expry, convert(concat (round(coalesce(f1.qty,''),0),'+',"
                		 + "(round(coalesce (f1.foc,''),0) )),char(100)) 'foc1' ,convert(concat (round(coalesce(f2.qty,''),0),'+',"
                		 + " round(coalesce (f2.foc,''),0)),char(100)) foc2, convert(concat (round(coalesce(f3.qty,''),0),'+',"
                		 + " round(coalesce(f3.foc,''),0)) ,char(100))foc3   from "+dbname+".my_main m "+sqljoin+" join (select i.brhid,i.locid, sum(i.op_qty-i.out_qty) qty,"
                		 + " i.prdid from "+dbname+".my_prddin i where i.op_qty-i.out_qty>0  "+sqltest+"  "+sqltest2+" group by psrno )  i on m.doc_no=i.prdId "+sqljoin+" join (select i.brhid,i.locid, "
                		 + " sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from "+dbname+".my_prddin i where i.op_qty-i.out_qty>0  "+sqltest+" "+sqltest2+" group by psrno )  e on "
                		 + " m.doc_no=e.prdId  left join "+dbname+".my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid) left join  "+dbname+".my_brand bd on m.brandid=bd.doc_no "
                		 + " left join  "+dbname+".my_prodfocfixing f1 on f1.psrno=m.psrno and f1.sr_no=1 left join  "+dbname+".my_prodfocfixing f2 on f2.psrno=m.psrno and f2.sr_no=2 "
                		 + " left join  "+dbname+".my_prodfocfixing f3 on f3.psrno=m.psrno and f3.sr_no=3  left join "+dbname+".my_dept d on d.doc_no=m.deptid left join "+dbname+".my_catm cat on(m.catid=cat.doc_no) "
						+ "left join "+dbname+".my_scatm sc on(m.scatid=sc.doc_no) left join "+dbname+".my_ptype pt on(m.typeid=pt.doc_no) where 1=1 "+sqltest+" "+sqltest3
                		 + " order by d.department ,m.productname ) b,(select @i:=0) as i";
                    
                    rowCount++;
                    if (dbResultSet.isLast()) {
                        break;
                    }

                    unionstr = " union all ";
                    sqlStock += unionstr;
		        }
  //System.out.println("12345"+sqlStock);
                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	param.put("stocksql", sqlStock);
		         param.put("imgpath", imgpath);
		         param.put("compname", stocklistBean.getLblcompname());
		         param.put("compaddress", stocklistBean.getLblcompaddress());
		         param.put("comptel", stocklistBean.getLblcomptel());
		         param.put("compfax", stocklistBean.getLblcompfax());
		         param.put("compbranch", stocklistBean.getLblbranch());
		         param.put("location", stocklistBean.getLbllocation());
		         param.put("printname", stocklistBean.getLblprintname());
		         param.put("subprintname", stocklistBean.getLblprintname1()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		       
		        System.out.println("reportFileName==="+reportFileName);
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
         	 
         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                           generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
  
                     e.printStackTrace();
  
                 }
	            	 
	           finally{
				conn.close();
			}	   	 
		}

		return "print";
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
