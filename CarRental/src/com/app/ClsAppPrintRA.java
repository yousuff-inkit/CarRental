package com.app;

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

public class ClsAppPrintRA extends ActionSupport {


	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	private String url;
	private Map<String, Object> param = null;
	private String lbltel1,lbltel2, duedate, salagent ,raagent, salname,duetime,createdate,rentaldoc,lblcladdress ;
	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}

	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getRentaldoc() {
		return rentaldoc;
	}
	public void setRentaldoc(String rentaldoc) {
		this.rentaldoc = rentaldoc;
	}
	public String getLblcladdress() {
		return lblcladdress;
	}
	public void setLblcladdress(String lblcladdress) {
		this.lblcladdress = lblcladdress;
	}
	
	public String printAction() throws ParseException, SQLException,Exception{
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();	
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			
			int docno=Integer.parseInt(request.getParameter("docno")==null?"0":request.getParameter("docno").toString());
			setUrl(objcommon.getPrintPath("RAG"));
			
			if(getUrl().contains(".jrxml")==true){
				param = new HashMap();
				String reportFileName = "com/operations/agreement/rentalagreement/rentalAgreementCreateWorld.jrxml";
				String arabicimage=request.getSession().getServletContext().getRealPath("/icons/arabic.jpg");
				arabicimage=arabicimage.replace("\\", "\\\\"); 
				param.put("arabic",arabicimage);
				 Statement stmt=conn.createStatement();
				String lblnation="";
				 String sql1="SELECT COALESCE(ra.sal_code,'') rentalagent,COALESCE(dr.nation,'') nationality,COALESCE(br.tel,'') indigobranchtel,COALESCE(br.fax,'') indigobranchmobile,agmt.cldocno FROM gl_ragmt agmt LEFT JOIN my_brch br ON  agmt.brhid=br.doc_no LEFT JOIN gl_rdriver rdr ON (agmt.doc_no=rdr.rdocno AND rdr.status=3) LEFT JOIN gl_drdetails dr ON rdr.drid=dr.dr_id  LEFT JOIN my_salesman ra ON (agmt.raid=ra.doc_no AND ra.sal_type='RLA') WHERE agmt.doc_no="+docno;
				ResultSet rs1=stmt.executeQuery(sql1);
	    		while(rs1.next()){
	    			lblnation=rs1.getString("nationality");
					//drate=rs2.getDouble("drate");
					}
	    		String nettotal="";
				String sql2="SELECT (SELECT rentaltype  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=5) AS rentaltype,(SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=5) AS rate,(SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=6) AS discount,(SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS nettotal";
				ResultSet rs2=stmt.executeQuery(sql2);
				while(rs2.next()){
	    			nettotal=rs2.getString("nettotal");
					//drate=rs2.getDouble("drate");
					}
				String raexxtakmchg="",raextrakm="",chaufchg="",addrchg="",delchg="",rentaltypes="",sal_name="",Createdate="";
				String sql3="SELECT u.authname ,COALESCE(ra.authority,'')authority,COALESCE(DATE_FORMAT(r.date,'%d-%m-%Y'),'') createdate,COALESCE(r.desc1,'') agmtdesc,COALESCE(ch.sal_name,'') chkoutby,usr.user_id,a.trnnumber,a.cldocno,v.ch_no,COALESCE(r.desc1,'') description,COALESCE(DATE_FORMAT(r.ddate,'%d-%m-%Y'),'') ddate, dtime, ra.sal_name ragnt,sa.sal_name sagnt, sm.sal_name ,   ROUND(COALESCE(r.delchg,0),2) delchg,a.per_tel,IF(a.ser_default=1,IF(g1.method=1,ROUND(g1.value,2),0),ROUND(per_salikrate,2)) salikcharge, IF(a.ser_default=1,ROUND(g2.value,2),ROUND(per_trafficharge,2)) trafficcharge, 4+IF(a.ser_default=1,IF(g1.method=1,ROUND(g1.value,2),0),ROUND(per_salikrate,2)) saliktotal,CONCAT(u.authid,' ',p.code_name,' ',v.reg_no) reg_noval,r.voc_no,ROUND(r.insex,2) insex,IF(r.clstatus=0,'Open','Closed') clstatus,a.per_tel,a.fax1, r.doc_no,ROUND(COALESCE(r.addrchg,0),2) addrchg,r.mrano,COALESCE(ROUND(r.okm),'') okm, CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' WHEN r.ofuel IS NULL THEN ''	END AS 'ofuel' ,COALESCE(DATE_FORMAT(r.odate,'%d-%m-%Y'),'')odate,COALESCE(r.otime,'')otime,COALESCE(a.refname,'')refname,  a.address,a.address2,a.per_mob,a.mail1,v.fueltype,br.branchname,CONCAT(v.reg_no,' ',u.authid,' ',p.code_name) authregno,CONCAT(v.reg_no,' - ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,p.code_name,(SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS rate, (SELECT  ROUND(cdw,2)+ROUND(cdw1,2)   FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS cdw , (SELECT ROUND(gps,2)+ROUND(babyseater,2)+ROUND(cooler,2) 	 FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS accessories,  (SELECT ROUND(cdw1,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS scdw ,  (SELECT ROUND(cdw1,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS vmd ,   (SELECT ROUND(kmrest,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS raextrakm, (SELECT ROUND(exkmrte,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS raexxtakmchg,(SELECT ROUND(pai,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS pai,(SELECT ROUND(chaufchg,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS chaufchg,(SELECT rentaltype  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=5) AS rentaltypes,  CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' 	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' 	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' 	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' 	  THEN 'Level 8/8' WHEN rc.infuel IS NULL THEN ''	 END AS 'infuel',COALESCE(ROUND(rc.inkm),'') inkm,COALESCE(DATE_FORMAT(rc.indate,'%d-%m-%Y'),'') indate,COALESCE(rc.intime,'')intime,co.color,yo.yom , v.ch_no 	  FROM gl_ragmt r LEFT JOIN my_acbook a ON a.cldocno=r.cldocno  AND  a.dtype='CRM' LEFT JOIN gl_drdetails d ON 	  d.cldocno=a.cldocno  LEFT JOIN my_brch br ON br.branch=r.brhid LEFT JOIN gl_vehmaster  v ON v.fleet_no=r.fleet_no 	   	  LEFT JOIN gl_vehgroup g ON g.doc_no=v.vgrpid LEFT JOIN  my_salesman sa ON sa.doc_no=r.said AND sa.sal_type='SLA'  LEFT JOIN  my_salesman ra ON ra.doc_no=r.raid AND  ra.sal_type='RLA'  LEFT JOIN gl_config g1 ON g1.field_nme='saliksrv' LEFT JOIN gl_config g2 ON g2.field_nme='trafficsrv'    LEFT JOIN gl_vehmodel mo ON mo.doc_no=v.vmodid  LEFT JOIN gl_vehauth u ON u.doc_no=v.authid	 LEFT JOIN my_salesman ch ON ch.doc_no=r.ochkid  	 LEFT JOIN gl_vehplate p ON p.doc_no=v.pltid LEFT JOIN gl_rtarif t ON t.rdocno=r.doc_no  	   			 LEFT JOIN gl_ragmtclosem rc ON rc.agmtno=r.doc_no LEFT JOIN gl_yom yo ON yo.doc_no=v.yom  LEFT JOIN my_user usr ON r.userid=usr.doc_no	   		 LEFT JOIN my_color co ON co.doc_no=v.clrid  LEFT JOIN my_salm sm ON sm.doc_no=r.salid   WHERE r.doc_no="+docno+" GROUP BY r.doc_no";
				ResultSet rs3=stmt.executeQuery(sql3);				
				while(rs3.next()){
					raexxtakmchg=rs3.getString("raexxtakmchg");
					raextrakm=rs3.getString("raextrakm");
					chaufchg=rs3.getString("chaufchg");
					addrchg=rs3.getString("addrchg");
					delchg=rs3.getString("delchg");
					rentaltypes=rs3.getString("rentaltypes");
					sal_name=rs3.getString("sal_name");
					Createdate=rs3.getString("Createdate");									//drate=rs2.getDouble("drate");
									}
				String cosmokmrestrictdaily="";
				String sql4="SELECT (SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS rate, ROUND(COALESCE(r.delchg,0),2) delchg,(SELECT ROUND(pai,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS pai, (SELECT  ROUND(cdw,2)+ROUND(cdw1,2) FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS cdw, (SELECT ROUND(cdw1,2)  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS scdw,ROUND(rc.colchg,2) cosmocollectchg, (SELECT ROUND(gps,2) FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS cosmogps, (SELECT ROUND(babyseater,2) FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS cosmobabyseater, (SELECT ROUND(cooler,2) FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=7) AS cosmocooler, (SELECT ROUND(kmrest,2) kmrest  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=1) cosmokmrestrictdaily, (SELECT ROUND(kmrest,2) kmrest  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=2) cosmokmrestrictweekly, (SELECT ROUND(kmrest,2) kmrest  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=3) cosmokmrestrictmonthly, (SELECT ROUND(exkmrte,2) exkmrte  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=1) cosmoexkmratedaily, (SELECT ROUND(exkmrte,2) exkmrte  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=2) cosmoexkmrateweekly, (SELECT ROUND(exkmrte,2) exkmrte  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=3) cosmoexkmratemonthly, (SELECT COALESCE(ROUND(amount,2),'') FROM gl_rpyt WHERE rdocno="+docno+" AND payid=1) cosmoadvance,(SELECT COALESCE(ROUND(amount,2),'') FROM gl_rpyt WHERE rdocno="+docno+" AND payid=2) cosmosecurity,IF(pyt.mode='CARD',pyt.card,'') cosmocreditcard,IF(pyt.mode='CARD',pyt.cardno,'') cosmocreditcardno, IF(pyt.mode='CARD',pyt.expdate,'') cosmocreditcarddate,rc.infuel cosmofuelin,rc.inkm cosmokmin,checkin.sal_name cosmocheckin,checkout.sal_name  cosmocheckout,v.fleet_no cosmofleetno,brd.brand_name cosmobrand,d.issfrm cosmoissuedat,COALESCE(ROUND(r.insex,2),'') insurexcess FROM gl_ragmt r LEFT JOIN my_acbook a ON a.cldocno=r.cldocno  AND  a.dtype='CRM' LEFT JOIN gl_drdetails d ON 	  d.cldocno=a.cldocno  LEFT JOIN my_brch br ON br.branch=r.brhid LEFT JOIN gl_vehmaster  v ON v.fleet_no=r.fleet_no 	   	  LEFT JOIN gl_vehgroup g ON g.doc_no=v.vgrpid LEFT JOIN  my_salesman sa ON sa.doc_no=r.said AND sa.sal_type='SLA'  LEFT JOIN  my_salesman ra ON ra.doc_no=r.raid AND  ra.sal_type='RLA'  LEFT JOIN gl_config g1 ON g1.field_nme='saliksrv' LEFT JOIN gl_config g2 ON g2.field_nme='trafficsrv'    LEFT JOIN gl_vehmodel mo ON mo.doc_no=v.vmodid  LEFT JOIN gl_vehauth u ON u.doc_no=v.authid	   			        LEFT JOIN gl_vehplate p ON p.doc_no=v.pltid LEFT JOIN gl_rtarif t ON t.rdocno=r.doc_no  	   			 LEFT JOIN gl_ragmtclosem rc ON rc.agmtno=r.doc_no LEFT JOIN gl_yom yo ON yo.doc_no=v.yom LEFT JOIN my_color co ON co.doc_no=v.clrid  LEFT JOIN my_salm sm ON sm.doc_no=r.salid LEFT JOIN gl_vehbrand brd ON v.brdid=brd.doc_no  LEFT JOIN my_salesman checkout ON (r.ochkid=checkout.doc_no AND checkout.sal_type='CHK') LEFT JOIN my_salesman checkin ON  (rc.chkinid=checkin.doc_no AND checkin.sal_type='CHK') LEFT JOIN gl_rpyt pyt ON (r.doc_no=pyt.rdocno) WHERE r.doc_no="+docno+" GROUP BY r.doc_no";
				ResultSet rs4=stmt.executeQuery(sql4);
				while(rs4.next()){
	    			cosmokmrestrictdaily=rs4.getString("cosmokmrestrictdaily");
					//drate=rs2.getDouble("drate");
					}
				  String passno="",radlno="",expdate="";  
				String sql5="SELECT NAME,mobno,dlno,DATE_FORMAT(d.led,'%d-%m-%Y') led,passport_no FROM gl_drdetails d LEFT JOIN gl_rdriver rr   ON rr.drid=d.dr_id WHERE rr.rdocno="+docno+" AND rr.srno BETWEEN(SELECT MIN(srno) srno FROM gl_rdriver  WHERE rdocno="+docno+")  AND (SELECT MAX(srno) srno FROM gl_rdriver  WHERE rdocno="+docno+") AND  rr.status=3  LIMIT 2";
				ResultSet rs5=stmt.executeQuery(sql5);
				while(rs5.next()){
					passno=rs5.getString("passport_no");
					radlno=rs5.getString("dlno");
					expdate=rs5.getString("led");
					}
				String licexpdate="",radrname="",dob="",nation="";
				String sql6=" SELECT COALESCE(d.mobno,'') mobile,COALESCE(d.ltype,'') licensetype,COALESCE(visano) visano,DATE_FORMAT(d.visa_exp,'%d-%m-%Y') visa_exp,DATE_FORMAT(DATE_ADD(DATE_SUB(d.visa_exp,INTERVAL 2 YEAR),INTERVAL 1 DAY),'%d-%m-%Y') visaissdate,COALESCE(d.nation,'') nation,COALESCE(issfrm,'') issuedby,COALESCE(DATE_FORMAT(d.issdate,'%d-%m-%Y'),'') issuedfrom, d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') led,IF(d.PASSPORT_NO='0','',d.PASSPORT_NO)  PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp,DATE_FORMAT(DATE_ADD(DATE_SUB(d.pass_exp,INTERVAL 10 YEAR),INTERVAL 1 DAY),'%d-%m-%Y') dates FROM gl_drdetails d LEFT JOIN gl_rdriver rr   ON rr.drid=d.dr_id WHERE rr.rdocno="+docno+" AND rr.srno BETWEEN(SELECT MIN(srno) srno FROM gl_rdriver  WHERE rdocno="+docno+")  AND (SELECT MAX(srno) srno FROM gl_rdriver  WHERE rdocno="+docno+") AND  rr.status=3 ORDER BY rr.srno LIMIT 3 ";
				ResultSet rs6=stmt.executeQuery(sql6);
				while(rs6.next()){
					dob=rs6.getString("dob");
	    			licexpdate=rs6.getString("led");
	    			radrname=rs6.getString("drname");
	    			nation=rs6.getString("nation");
	    			//drate=rs2.getDouble("drate");
	    			
					}   	
				String sql7="   SELECT (SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=1) daily, (SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=2) weekly, (SELECT ROUND(rate,2) rate  FROM gl_rtarif WHERE  rdocno="+docno+" AND rstatus=3) monthly";
				ResultSet rs7=stmt.executeQuery(sql7);
				while(rs7.next()){
	    			//prate=rs2.getDouble("prate");
					//drate=rs2.getDouble("drate");
					}
				String location="";
				String sql8="SELECT COALESCE(c.tel2,'') tel2,COALESCE(c.email,'') email,COALESCE(c.web,'') web,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno FROM gl_ragmt r INNER JOIN my_brch b ON  r.brhid=b.doc_no INNER JOIN my_comp c ON b.cmpid=c.doc_no INNER JOIN my_locm l ON l.brhid=b.doc_no INNER JOIN (SELECT MIN(lo.loc) loc,lo.loc_name,  lo.brhid FROM my_locm lo GROUP BY brhid) AS lc ON(lc.loc=l.loc AND lc.brhid=b.doc_no) WHERE r.doc_no="+docno+" ";
				ResultSet rs8=stmt.executeQuery(sql8);
				while(rs8.next()){
					location=rs8.getString("location");
					//drate=rs2.getDouble("drate");
					}
				String sql9="SELECT COALESCE(pm.doc_no,0) inspdoc,veh.reg_no,veh.flname model,yom.yom YEAR,tarif.rdocno,tarif.gps,tarif.babyseater,tarif.cooler,agmt.pono,agmt.doc_no,agmt.desc1,rpt.cardno,rpt.amount FROM gl_ragmt agmt LEFT JOIN gl_vehmaster veh ON veh.fleet_no=agmt.fleet_no LEFT JOIN gl_yom yom ON veh.yom=yom.doc_no LEFT JOIN gl_rtarif tarif ON (agmt.doc_no=tarif.rdocno AND rstatus=7) LEFT  JOIN  (SELECT cardno,expdate,rdocno,amount FROM gl_rpyt rpt GROUP BY rdocno )  rpt ON agmt.doc_no=rpt.rdocno LEFT JOIN gl_vinspm pm ON agmt.doc_no=pm.refdocno WHERE agmt.doc_no="+docno+"";
				ResultSet rs9=stmt.executeQuery(sql9);
				while(rs9.next()){
	    			//prate=rs2.getDouble("prate");
					//drate=rs2.getDouble("drate");
				
				}
				String selcartarif="",Selcaracc="",Selcarvmd="",selcarpai="",Selcarcdw1="",Selcarcdw="";
                String sql10="select (select round(rate,2)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcartarif,(select round(cdw,2)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcarcdw,(select round(cdw1,2)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcarcdw1,(select round(pai,2)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcarpai,(select round(cooler,2)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcarvmd,(select round(gps,2)+round(babyseater)  from gl_rtarif where  rdocno=24560 and rstatus=7) as selcaracc";
				ResultSet rs10=stmt.executeQuery(sql10);
				while(rs10.next()){
					selcartarif=rs10.getString("selcartarif");
					Selcaracc=rs10.getString("Selcaracc");
					Selcarvmd=rs10.getString("Selcarvmd");
					selcarpai=rs10.getString("selcarpai");
					Selcarcdw1=rs10.getString("Selcarcdw1");
					Selcarcdw=rs10.getString("Selcarcdw");
					//drate=rs10.getDouble("drate");
				
				}
                param.put("passportno", passno);
                param.put("expdate", expdate);
     		    param.put("dname", radrname);
     		    param.put("salesman", sal_name);
     		    param.put("dlicenseno",radlno);
     		     param.put("nationality", nation);
     		     param.put("tariff", nettotal);
     		      param.put("location", location);
     		    param.put("dob", dob);
     		    param.put("restrictkm",raexxtakmchg);
     		    param.put("raextrakm",raextrakm);
     		   param.put("chauffer",chaufchg);
     		   param.put("addriverchrges",addrchg);
     		   param.put("accessories", Selcaracc);
     		  param.put("vmd",Selcarvmd);
     		 param.put("pai", selcarpai);
     		param.put("cdw", Selcarcdw1);
     		param.put("supercdw",Selcarcdw);
     		param.put("renttype", rentaltypes);
     		param.put("date",Createdate);
     		  param.put("voc_no", docno);
     		     /* param.put("adddrname1", adddrname1);
     		   param.put("adddrname2", adddrname2);
     		   param.put("addlicno1", addlicno1);
     		   param.put("addlicno2", addlicno2);
     		   param.put("expdate1", expdate1);
     		   param.put("expdate2", expdate2);
     		   param.put("adddob1", adddob1);
     		   param.put("adddob2", adddob2);	
             
     		    */
				
				JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));	      	     	 
	            JasperReport jasperReport = JasperCompileManager.compileReport(design);
                generateReportPDF(response, param, jasperReport, conn);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
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
