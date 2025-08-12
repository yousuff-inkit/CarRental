package com.operations.vehicletransactions.vehicleinspection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.agreement.rentalagreement.ClsRentalAgreementDAO;

public class ClsVehicleInspectionDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsVehicleInspectionBean inspectionBean=new ClsVehicleInspectionBean();
	public  ClsVehicleInspectionBean getViewDetails(int docNo) throws SQLException{
		ClsVehicleInspectionBean inspectionBean = new ClsVehicleInspectionBean();
		Connection conn =null;
		try {
		conn= objconn.getMyConnection();
		
		Statement stmtmanual = conn.createStatement ();
		
      /*  String sql= ("select insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,insp.acdate,insp.coldate,insp.place,"
        		+ "insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp where insp.status<>7 and insp.doc_no="+docNo);
        */
		String sql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,"+
        		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
        		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
        		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
        		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
        		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
        		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
        		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
        		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.doc_no="+docNo;
		ResultSet resultSet = stmtmanual.executeQuery(sql);
					
		while (resultSet.next()) {
			inspectionBean.setDate(resultSet.getDate("date").toString());
			inspectionBean.setHidcmbtype(resultSet.getString("type"));
			inspectionBean.setHidcmbreftype(resultSet.getString("reftype"));
			inspectionBean.setRdocno(resultSet.getInt("refdocno"));
			inspectionBean.setDocno(docNo);
			inspectionBean.setAccdate(resultSet.getDate("acdate").toString());
			inspectionBean.setPrcs(resultSet.getString("polrep"));
			inspectionBean.setCollectdate(resultSet.getDate("coldate").toString());
			inspectionBean.setAccplace(resultSet.getString("place"));
			inspectionBean.setAccfines(resultSet.getString("fine"));
			inspectionBean.setHidcmbclaim(resultSet.getString("claim"));
			inspectionBean.setAmount(resultSet.getString("amount"));
			inspectionBean.setHidaccidents(resultSet.getString("accident"));
			inspectionBean.setAccremarks(resultSet.getString("remarks"));
			inspectionBean.setRfleet(resultSet.getString("rfleet"));
			inspectionBean.setHidcmbagmtbranch(resultSet.getString("agmtbranch"));
			inspectionBean.setRegno(resultSet.getString("reg_no"));
			inspectionBean.setClient(resultSet.getString("refname"));
		}
		stmtmanual.close();
		conn.close();
		}
		catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}

		return inspectionBean;
		}

	
	
	 public JSONArray mainSearch(String cmbtype,String cmbreftype,String fleetno,String refdocno,String searchdate,String docno,String branch,String regno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	 Connection conn=null;
	    	    	// String brnchid=session.getAttribute("BRANCHID").toString();
	    	//System.out.println("name"+sclname);
	   
     
				try {
					conn=objconn.getMyConnection();
	    	String sqltest="";
	    	java.sql.Date sqldate=null;
	    	if(!(searchdate.equalsIgnoreCase(""))){
	    		sqldate=objcommon.changeStringtoSqlDate(searchdate);	
	    	}
	    	
	    	if(!(cmbtype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.type like '%"+cmbtype+"%'";
	    	}
	    	if(!(cmbreftype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.reftype='"+cmbreftype+"'";
	    	}
	    	if(!(fleetno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.rfleet like '%"+fleetno+"%'";
	    	}
	    	
	    	if(!(refdocno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.refvoucherno like'%"+refdocno+"%'";
	    	}
	    	if(!(docno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.doc_no like '%"+docno+"%'";
	    	}
	    	 if(sqldate!=null){
	    		 sqltest=sqltest+" and insp.date='"+sqldate+"'";
	    	 }
	    	 if(!regno.equalsIgnoreCase("")){
	    		 sqltest=sqltest+" and veh.reg_no="+regno+"";
	    	 }
					Statement stmtsearch = conn.createStatement ();
			/*		String str1Sql="select insp.agmtbranch,veh.reg_no,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.refvoucherno,insp.amount,insp.accident,insp.polrep,insp.acdate,"+
					" insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh on insp.rfleet=veh.fleet_no where insp.status<>7 and insp.brhid="+branch+" "+sqltest+" group by insp.doc_no";
				*/
				
							 String sql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.refvoucherno,insp.amount,insp.accident,insp.polrep,"+
				        		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
				        		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
				        		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
				        		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
				        		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
				        		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
				        		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
				        		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.brhid="+branch+" "+sqltest+" group by insp.doc_no order by insp.doc_no";
					
					//					System.out.println("======="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery(sql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtsearch.close();
					conn.close();
					return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
				finally{
					conn.close();
				}
			//System.out.println(RESULTDATA);
			conn.close();
	        return RESULTDATA;
	    }
	 
	 
	 
	 
	public JSONArray getDoc(String reftype,String branch,String docno,String fleetno,String regno,String date,String mode,String type) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    if(!mode.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String table="";
			java.sql.Date sqldate=null;
			String sqltest="";
			String sqlbranch="";
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			
			if(!docno.equalsIgnoreCase("")){
				if(reftype.equalsIgnoreCase("RAG")){
					sqltest+=" and r.voc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("LAG")){
					sqltest+=" and l.voc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("RPL")){
					sqltest+=" and rep.doc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("NRM")){
					sqltest+=" and nrm.doc_no like '%"+docno+"%'";
				}
			}
			if(!fleetno.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				if(reftype.equalsIgnoreCase("RAG")){
					sqltest+=" and r.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("LAG")){
					sqltest+=" and l.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("RPL")){
					sqltest+=" and rep.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("NRM")){
					sqltest+=" and nrm.date='"+sqldate+"'";
				}
			}
			
			
			if(reftype.equalsIgnoreCase("RAG")){
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and r.brhid="+branch;
				}
				table="select ac.refname,r.fleet_no,r.doc_no,r.voc_no,r.date,'RAG' reftype,coalesce(r.insex,0.0) insurexcess,veh.reg_no  from"+
						" gl_ragmt r inner join gl_vehmaster veh on r.fleet_no=veh.fleet_no inner join my_acbook ac on (r.cldocno=ac.cldocno and ac.dtype='CRM')"+
						" where r.status=3 "+sqlbranch+sqltest;
			}
			if(reftype.equalsIgnoreCase("LAG")){
/*				table="select ac.refname,l.doc_no,l.voc_no,l.date,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,'LAG' reftype,veh.reg_no,coalesce(insurexcess,0.0)"+
						" insurexcess from gl_lagmt l left join gl_vehmaster veh on (l.perfleet=veh.fleet_no or l.tmpfleet=veh.fleet_no) left join my_acbook ac"+
						" on (l.cldocno=ac.cldocno and ac.dtype='CRM') where l.status=3 and l.brhid="+branch+sqltest;*/
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and l.brhid="+branch;
				}
				
				table="select mov.doc_no,mov.rdocno,mov.rdtype,ac.refname,l.doc_no,l.voc_no,l.date,mov.fleet_no,'LAG' reftype,veh.reg_no,coalesce(insurexcess,0.0) "+
				" insurexcess from gl_lagmt l left join gl_vmove mov on (mov.doc_no=(select max(doc_no) from gl_vmove where rdocno=l.doc_no and rdtype='LAG' group "+
				" by rdtype,rdocno)) left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no left join my_acbook ac on (l.cldocno=ac.cldocno and ac.dtype='CRM')  "+
				" where l.status=3 "+sqlbranch+sqltest+" group by mov.rdtype,mov.rdocno";
				
			}
			if(reftype.equalsIgnoreCase("RPL")){
				String sqlfleet="";
				if(type.equalsIgnoreCase("IN")){
					sqlfleet="rep.rfleetno";
				}
				else if(type.equalsIgnoreCase("OUT")){
					sqlfleet="rep.ofleetno";
				}
				else{
					sqlfleet="rep.rfleetno";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and rep.inbrhid="+branch;
				}
				
				table="select distinct rep.doc_no,rep.doc_no voc_no,rep.date,"+sqlfleet+" fleet_no,'RPL' reftype,veh.reg_no,ac.refname,"+
						" coalesce(if(rep.rtype='RAG',rag.insex,lag.insurexcess),0.0) insurexcess from gl_vehreplace rep left join gl_ragmt rag on"+
						" (rep.rdocno=rag.doc_no and rep.rtype='RAG') left join gl_lagmt lag on (rep.rdocno=lag.doc_no and rep.rtype='LAG') left join"+
						" gl_vehmaster veh on ("+sqlfleet+"=veh.fleet_no) left join my_acbook ac on (if(rep.rtype='RAG',rag.cldocno=ac.cldocno,lag.cldocno=ac.cldocno)"+
						" and ac.dtype='CRM') where rep.status=3 "+sqlbranch+sqltest;
			}
			if(reftype.equalsIgnoreCase("NRM")){
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and nrm.brhid="+branch;
				}
				
				table="select distinct nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,nrm.date,'NRM' reftype,0 insurexcess,veh.reg_no,sal.sal_name refname from gl_nrm nrm "+
						" left join gl_vehmaster veh  on  (nrm.fleet_no=veh.fleet_no) left join my_salesman sal on (if(nrm.movtype='ST',(nrm.staffid=sal.doc_no and "+
						" sal.sal_type='STF'), (nrm.drid=sal.doc_no and sal.sal_type='DRV'))) where nrm.status=3 "+sqlbranch+sqltest;
			}
			//System.out.println(table);
			ResultSet resultSet = stmtmanual.executeQuery(table);

			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    conn.close();
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getDamage() throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			
			Statement stmtmanual = conn.createStatement ();
			strSql="select type code1,name description1,doc_no docno1 from gl_damage";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public ClsVehicleInspectionBean   getUser(int doc) throws SQLException {
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
	  String strSql="",strSql1="",takedoc="";
	  int takedocn=0;
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			
			Statement stmtmanual = conn.createStatement ();
			strSql1="select coalesce(takehanddoc,'')takehanddoc from gl_vinspm where doc_no="+doc+"";
			//System.out.println("sql1===="+strSql1);
			ResultSet rs=stmtmanual.executeQuery (strSql1);
			while(rs.next()){
				takedoc=rs.getString("takehanddoc");
			}
			takedocn=Integer.parseInt(takedoc);
			if(takedocn>0){
			strSql="select coalesce(mu.user_name,'')user_name,coalesce(ak.interior,'')interior,coalesce(ak.back,'')back,coalesce(ak.front,'')front,coalesce(ak.leftk,'')leftk,coalesce(ak.rightk,'')rightk from an_takehand ak left join my_user mu on ak.userid=mu.doc_no where ak.doc_no="+takedoc+"";
			System.out.println("sql2===="+strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			while(resultSet.next()){
				bean.setUsername(resultSet.getString("user_name"));
				bean.setFront(resultSet.getString("front"));
				bean.setLeft(resultSet.getString("leftk"));
				bean.setRight(resultSet.getString("rightk"));
				bean.setBack(resultSet.getString("back"));
				bean.setInterior(resultSet.getString("interior"));
			}
			}
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	   
	}
	public ClsVehicleInspectionBean getSignature(int doc) throws SQLException {
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
	  String strSql="",strSql1="",sign="";
	  int takedocn=0;
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			
			Statement stmtmanual = conn.createStatement ();
			strSql1="select signature from an_signdetails where rdocno="+doc+"";
			//System.out.println("signature sql1===="+strSql1);
			ResultSet rs=stmtmanual.executeQuery (strSql1);
			while(rs.next()){
				sign=rs.getString("signature");
				bean.setSignature(sign);
			}
			
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	   
	}
	public   JSONArray getComplaint() throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
					
			Statement stmtmanual = conn.createStatement ();
			strSql="select compname,doc_no docno from gl_complaint where status<>7";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getNewDamage(String fleet,String docno,String formdetailcode) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String strSql="select  replace(inspd.path,'\\\\',';') path,dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,inspd.rowno srno,dmg.doc_no dmgid"+
					" from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on"+
					" inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet='"+fleet+"' and insp.doc_no='"+docno+"' group by inspd.rowno";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getNewMaintenance(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on "+
					"insp.doc_no=inspd.rdocno left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.rfleet='"+fleet+"' and insp.doc_no='"+docno+"'";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getExistDamage(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	  Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			//System.out.println("getdid"+docno);
			if(docno.equalsIgnoreCase("0")){
				strSql="select dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,dmg.doc_no dmgid,inspd.rowno from gl_vinspm insp left join"+
						" gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and"+
						"  insp.rfleet="+fleet+" and inspd.clstatus=0";
//				System.out.println("EXIST DAMAGE SQL"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			else{
				strSql="select dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,dmg.doc_no dmgid,inspd.rowno from gl_vinspm insp"+
						" left join gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0"+
						" and insp.rfleet="+fleet+" and insp.doc_no != "+docno+" and inspd.rdocno <= "+docno ;
//				System.out.println("EXIST DAMAGE SQL"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getExistComplaint(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
//			System.out.println("getcmpid"+docno);
			if(docno.equalsIgnoreCase("0")){
				strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno "+
						" left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.rfleet="+fleet+"  and inspd.clstatus=0";
//				System.out.println("getexistcomplaint"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			else{
				strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno "+
						" left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.date<inspd.cldate and insp.date<CURDATE() "
						+ "and insp.rfleet="+fleet;

//				System.out.println("getexistcomplaint"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getSearchData(HttpSession session) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			/*strSql="select insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,insp.acdate,"+
					" insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp where insp.status<>7 and insp.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
			*/
				strSql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,"+
		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public int insert(Date date, String cmbtype, String cmbreftype,int rdocno, Date accdate, String prcs, Date collectdate,String accplace,
			String accfines, String cmbclaim, String amount,String formdetailcode,String hidaccidents,String accremarks,HttpSession session,
			String mode,String rfleet,ArrayList<String> damagearray,ArrayList<String> maintenancearray,ArrayList<String> existdamagearray,
			String time,String refvoucherno,String branch,String agmtbranch) throws SQLException {
		// TODO Auto-generated method stub
//	System.out.println("ACC"+hidaccidents);
	Connection conn=null;
		try{
			int val;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			if(accfines.equalsIgnoreCase("")){
				accfines="0";
			}
			if(amount.equalsIgnoreCase("")){
				amount="0";
			}
			if(hidaccidents.equalsIgnoreCase("")){
				hidaccidents="0";
			}
			if(cmbclaim.equalsIgnoreCase("")){
				cmbclaim="0";
			}
			//accfines="round("+accfines+","+session.getAttribute("AMTDEC").toString()+")";
			//amount="round("+amount+","+session.getAttribute("AMTDEC").toString()+")";
			String tempround=session.getAttribute("AMTDEC").toString();
		CallableStatement stmtMovement = conn.prepareCall("{call vehInspectionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtMovement.registerOutParameter(16, java.sql.Types.INTEGER);
		stmtMovement.setDate(1,date);
		stmtMovement.setString(2,cmbtype);
		stmtMovement.setString(3,cmbreftype);
		stmtMovement.setInt(4, rdocno);
		stmtMovement.setString(5,amount);
		stmtMovement.setString(6,hidaccidents);
		stmtMovement.setString(7,prcs);
		stmtMovement.setDate(8,accdate);
		stmtMovement.setDate(9,collectdate);
		stmtMovement.setString(10,accplace);
		stmtMovement.setString(11,accfines);
		stmtMovement.setString(12,accremarks);
		stmtMovement.setString(13,cmbclaim);
		stmtMovement.setString(14,session.getAttribute("USERID").toString());
		stmtMovement.setString(15,branch);
		stmtMovement.setString(17, mode);
		stmtMovement.setString(18, formdetailcode);
		stmtMovement.setString(19, rfleet);
		stmtMovement.setString(20, tempround);
		stmtMovement.setString(21,time);
		stmtMovement.setString(22, refvoucherno);
		stmtMovement.setString(23, agmtbranch);
//		System.out.println(stmtMovement);
		stmtMovement.executeQuery();
		val=stmtMovement.getInt("docNo");
		//System.out.println("no====="+val);
		inspectionBean.setDocno(val);
		Statement stmtrcalc=conn.createStatement();
		String strrcalc="";
		String strinsurexcess="";
		if(cmbreftype.equalsIgnoreCase("RAG") && (Double.parseDouble(amount))>0){
			strrcalc="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
			""+rdocno+",'"+cmbreftype+"',10,"+amount+",1,0,0,null)";
			if(!accfines.equalsIgnoreCase("") && !accfines.equalsIgnoreCase("0")){
				strinsurexcess="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
						""+rdocno+",'"+cmbreftype+"',21,"+accfines+",1,0,0,null)";
			}
		}
		if(cmbreftype.equalsIgnoreCase("LAG") && (Double.parseDouble(amount))>0){
			strrcalc="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
					""+rdocno+",'"+cmbreftype+"',10,"+amount+",1,0,0,null)";
		
			if(!accfines.equalsIgnoreCase("") && !accfines.equalsIgnoreCase("0")){
				strinsurexcess="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
						""+rdocno+",'"+cmbreftype+"',21,"+accfines+",1,0,0,null)";
			}
		}
//		System.out.println("Check String: "+strrcalc);
		if(!(strrcalc.equalsIgnoreCase(""))){
			int rcalcval=stmtrcalc.executeUpdate(strrcalc);
			if(rcalcval<=0){
				if(!strinsurexcess.equalsIgnoreCase("")){
					int insurval=stmtrcalc.executeUpdate(strinsurexcess);
					if(insurval<=0){
						conn.close();
						return 0;
					}
				}
			}
		}
		
		if (val > 0) {
			for(int i=0;i< damagearray.size();i++){
				String[] damage=damagearray.get(i).split("::");
				if(!(damage[5].equalsIgnoreCase("undefined") || damage[5].isEmpty() || damage[5]==null)){
				String strdamage=" insert into gl_vinspd(rowno,rdocno,dmid,type,remarks,attach,dm,fleetno)values('"+(i+1)+"','"+val+"','"+(damage[5].equalsIgnoreCase("undefined") || damage[5].isEmpty()?0:damage[5])+"',"+
				"'"+(damage[2].equalsIgnoreCase("undefined") || damage[2].isEmpty()?0:damage[2])+"','"+(damage[3].equalsIgnoreCase("undefined") || damage[3].isEmpty()?0:damage[3])+"','"+(damage[4].equalsIgnoreCase("undefined") || damage[4].isEmpty()?0:damage[4])+"',0,'"+rfleet+"')";
				Statement stmt=conn.createStatement();
//				System.out.println("Damage SQL"+strdamage);
				int val1=stmt.executeUpdate(strdamage);
				
				if(val1<=0){
					conn.close();
					return 0;
				}
				}
			}
			/*for(int i=0;i< existdamagearray.size();i++){
				String[] existdamage=existdamagearray.get(i).split("::");
				if(!(existdamage[0].equalsIgnoreCase("undefined") || existdamage[0].isEmpty() || existdamage[0]==null)){
				String strdamage="update gl_vinspd set rdocno="+val+" where srno="+(existdamage[0].equalsIgnoreCase("undefined") || existdamage[0].isEmpty()?0:existdamage[0])+"";
				Statement stmt=conn.createStatement();
				System.out.println("Exist Damage SQL"+strdamage);
				int val5=stmt.executeUpdate(strdamage);
				
				if(val5<=0){
					return 0;
				}
				}
			}*/
			for(int i=0;i< maintenancearray.size();i++){
				String[] maintenance=maintenancearray.get(i).split("::");
				if(!(maintenance[2].equalsIgnoreCase("undefined") || maintenance[2].isEmpty() || maintenance[2]==null)){
				String strmaintenance="insert into gl_vinspd(rowno,rdocno,dmid,remarks,dm,fleetno)values('"+(i+1)+"','"+val+"','"+(maintenance[2].equalsIgnoreCase("undefined") || maintenance[2].isEmpty()?0:maintenance[2])+"',"+
				"'"+(maintenance[1].equalsIgnoreCase("undefined") || maintenance[1].isEmpty()?0:maintenance[1])+"',1,'"+rfleet+"')";
				Statement stmt=conn.createStatement();
//				System.out.println("MAINTENANCE SQL"+strmaintenance);
				int val1=stmt.executeUpdate(strmaintenance);
				if(val1<=0){
					conn.close();
					return 0;
				}
			}
			}
//			System.out.println("Success"+inspectionBean.getDocno());
			if(inspectionBean.getDocno()>0){
			conn.commit();
			stmtMovement.close();
			conn.close();
			return val;
			}
		}
		stmtMovement.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	return 0;
	}
		finally{
			conn.close();
		}
	
	return 0;
}
	public boolean delete(Date date, String cmbtype, String cmbreftype,
			int rdocno, Date accdate, String prcs, Date collectdate,
			String accplace, String accfines, String cmbclaim, String amount,
			String formdetailcode, String hidaccidents, String accremarks,
			HttpSession session, String mode, String rfleet, int docno,String time) throws SQLException {
		Connection conn=null;
	//	System.out.println(date+"::"+cmbtype+"::"+cmbreftype+"::"+rdocno+"::"+accdate+"::"+prcs+"::"+collectdate+"::"+accplace+"::"+accfines+"::"+cmbclaim+"::"+amount+"::"+formdetailcode+"::"+hidaccidents+"::"+accremarks+"::"+session+"::"+mode+"::"+rfleet+"::"+docno+"::"+time);
		
		try {
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			
			accfines=accfines==null || accfines.equalsIgnoreCase("")?"0":accfines;
			amount=amount==null || amount.equalsIgnoreCase("")?"0":amount;
			hidaccidents=hidaccidents==null || hidaccidents.equalsIgnoreCase("")?"0":hidaccidents;
			/*if(accfines.equalsIgnoreCase("")){
				accfines="0";
			}
			if(amount.equalsIgnoreCase("")){
				amount="0";
			}
			if(hidaccidents.equalsIgnoreCase("")){
				hidaccidents="0";
			}
			*/
		CallableStatement stmtMovement = conn.prepareCall("{call vehInspectionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtMovement.setInt(16, docno);
			stmtMovement.setDate(1,date);
			stmtMovement.setString(2,cmbtype);
			stmtMovement.setString(3,cmbreftype);
			stmtMovement.setInt(4, rdocno);
			stmtMovement.setString(5,amount);
			stmtMovement.setInt(6,1);
			stmtMovement.setString(7,prcs);
			stmtMovement.setDate(8,accdate);
			stmtMovement.setDate(9,collectdate);
			stmtMovement.setString(10,accplace);
			stmtMovement.setString(11,accfines);
			stmtMovement.setString(12,accremarks);
			stmtMovement.setString(13,cmbclaim);
			stmtMovement.setString(14,session.getAttribute("USERID").toString());
			stmtMovement.setString(15,null);
			stmtMovement.setString(17, mode);
			stmtMovement.setString(18, formdetailcode);
			stmtMovement.setString(19, rfleet);
			stmtMovement.setString(20, null);
			stmtMovement.setString(21,time);
			stmtMovement.setString(22, null);
			stmtMovement.setString(23, null);
//		System.out.println(stmtMovement);
		int val=stmtMovement.executeUpdate();
		if(val>0){
			conn.commit();
			stmtMovement.close();
			conn.close();
			return true;
		}
		stmtMovement.close();
		conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return false;
	}

	public   ClsVehicleInspectionBean getPrint(int docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement printstmt=conn.createStatement();
			
			
			String strSql="";
			   
			strSql=("select coalesce(fi.path,'')paths,coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
		    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
		    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
		    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%h-%Y') DATE,case when r.RTYPE='RAG' then 'Rental' else 'Lease' end rtype,case when r.RTYPE='RAG' then agmt.voc_no else lagmt.voc_no end agmtno,r.RDOCNO,r.RFLEETNO,"+
		    		  " DATE_FORMAT(r.RDATE,'%d-%h-%Y') RDATE,r.RTIME,cast(round(r.RKM,0) as decimal(10)) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
		    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%h-%Y') odate,r.OTIME,cast(round(r.OKM,0) as decimal(10)) okm,r.ofuel 'ofuel',"+
		    		  " case when r.DELSTATUS=0 then 'NO' else 'YES' end delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%h-%Y') DELDATE,cast(round(r.DELKM,0) as decimal(10)) delkm,"+
		    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%h-%Y') indate,r.INTIME,cast(round(r.INKM,0) as decimal(10)) inkm,r.INFUEL 'infuel',r.INLOC,"+
		    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%h-%Y') cldate,r.CLTIME,cast(round(r.CLKM,0) as decimal(10)) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
		    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
		    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
		    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
		    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
		    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
		    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
		    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
		    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
		    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
		    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
		    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
		    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
		    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
		    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' ) left join (select  path,vi.refvoucherno refdocno from my_fileattach fa inner join  gl_vinspm vi on (fa.doc_no=vi.doc_no and fa.dtype='VIP' and fa.descpt='check') ORDER BY fa.doc_no desc\r\n" + 
		    		  " limit 1)fi on (r.doc_no=fi.refdocno and r.rtype='RAG') or (r.doc_no=fi.refdocno and r.rtype='LAG') where r.doc_no="+docno+" ");
			
			 // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate
	           //System.out.println("==prinrqry=="+strSql);
		       ResultSet resultSet = printstmt.executeQuery(strSql); 
		       
		      ClsCommon common=new ClsCommon();
		       while(resultSet.next()){
		    	   
		    	   bean.setLbldrivenby(resultSet.getString("drivenby"));
		    	   bean.setLbldescription(resultSet.getString("description"));
		    	   bean.setLblcoldriver(resultSet.getString("coldriver"));
		    	   bean.setLbldeldriver(resultSet.getString("deldriver"));
		    	   bean.setBrwithcompany(" "+resultSet.getString("mainbrch"));
		    	   bean.setVrano(resultSet.getString("agmtno"));
		    	   bean.setMtime(resultSet.getString("RTIME"));
		    	   bean.setPfleetno(resultSet.getString("RFLEETNO"));
		    	   bean.setPfuel(common.checkFuelName(conn,resultSet.getString("RFUEL")));
		    	   bean.setPclient(resultSet.getString("refname"));
		    	   bean.setClientacno(resultSet.getString("acno"));
		    	   bean.setAgmt(" "+resultSet.getString("rtype"));
		    	   bean.setPdocno(" "+resultSet.getString("doc_no"));
		    	   bean.setPdate(resultSet.getString("date"));
		    	   bean.setPregno(resultSet.getString("reg_no"));
		    	   bean.setVradate(resultSet.getString("RDATE"));
		    	   System.out.println(resultSet.getDate("RDATE")+"=====RDATE====="+resultSet.getString("RDATE"));
		    	   bean.setDtimes(resultSet.getString("rtime"));
		    	   
		    	   bean.setPopened(resultSet.getString("openuser"));
		    	   bean.setReplaced(resultSet.getString("user_name"));
		    	   bean.setLbloutlocation(resultSet.getString("outloc"));
		    	   bean.setLblinlocation(resultSet.getString("inloc"));
		    	   
		    	   if(resultSet.getString("reptype").equalsIgnoreCase("collection")){
		    		   bean.setReptype("Collection");   
		    	   }
		    	   else{
		    		   bean.setReptype("At Branch");
		    	   }

		    	   bean.setPkm(resultSet.getString("rkm"));
		    	   bean.setPoutdate(resultSet.getString("rdate")); 
		    	   bean.setPdelivery(resultSet.getString("delstatus")); 
		    	   bean.setLblrlocation(resultSet.getString("loc_name"));
		    	   
		    // in
		    	   bean.setInbrwithcompany(resultSet.getString("inandcolbrch"));
		    	   bean.setInvehdate(resultSet.getString("indate"));
		    	   bean.setInvehtime(resultSet.getString("intime"));
		    	   bean.setInvehkm(resultSet.getString("inkm"));
		    	   bean.setInvehfuel(common.checkFuelName(conn,resultSet.getString("INFUEL")));
		    	   bean.setInvehreason(resultSet.getString("st_desc"));
		    	   bean.setLblinfleetname(resultSet.getString("infleetname"));
		    	   
	//new out
		    	   bean.setNewbrwithcompany(resultSet.getString("outanddelbrch"));
		    	   bean.setNewvehoutdate(resultSet.getString("odate"));
		    	   bean.setNewvehouttime(resultSet.getString("otime"));
		    	   bean.setNewvehfleet(resultSet.getString("ofleetno"));
		    	   bean.setNewvehregno(resultSet.getString("reg_no2"));
		    	   bean.setLbloutfleetname(resultSet.getString("outfleetname"));
		    	   
		    	   bean.setNewvehkm(resultSet.getString("okm"));
		    	   bean.setNewvehfuel(common.checkFuelName(conn, resultSet.getString("oFUEL")));
		 // del
		    	   bean.setDelbrwithcompany(resultSet.getString("outanddelbrch"));
		    	   bean.setDeldate(resultSet.getString("deldate"));
		    	   bean.setDeltime(resultSet.getString("deltime"));
		    	   bean.setDelfleet(resultSet.getString("ofleetno"));
		    	   bean.setDelregno(resultSet.getString("reg_no2"));
		    	   bean.setDelkm(resultSet.getString("delkm"));
		    	   bean.setDelfuel(common.checkFuelName(conn,resultSet.getString("delfuel")));
		    	   bean.setLbldelivery(resultSet.getString("delstatus1"));
		    	   bean.setLbldelfleetname(resultSet.getString("outfleetname"));
		  //col
		    	   bean.setColbrwithcompany(resultSet.getString("inandcolbrch"));
		    	   bean.setColdate(resultSet.getString("cldate"));
		    	   bean.setColtime(resultSet.getString("cltime"));
		    	   bean.setColfleet(resultSet.getString("rfleetno"));
		    	   bean.setColregno(resultSet.getString("reg_no"));
		    	   bean.setColkm(resultSet.getString("clkm"));
		    	   bean.setColfuel(common.checkFuelName(conn,resultSet.getString("clfuel"))); 
		    	   bean.setLblcollection(resultSet.getString("clstatus"));
		    	   bean.setLblcolfleetname(resultSet.getString("infleetname"));
		    	   
		    	   bean.setSigpath(resultSet.getString("paths"));
		    	   
		    	   
		       }
		       
			
			/*String strprintmaster="select coalesce(vp.CODE_NAME,'')platecode,drd.nation,date_format(drd.dob,'%d/%m/%Y')dob,drd.dlno,date_format(vme.dout,'%d/%m/%Y')dout,vme.tout,round(vme.kmout,2)kmout,"
					+ "coalesce(case when vme.fout='0.000' then '0/8' when vme.fout='0.125' then '1/8' when vme.fout='0.250' then '2/8' when vme.fout='0.375' then '3/8' when vme.fout='0.500' then '4/8' when vme.fout='0.625' then '5/8' when vme.fout='0.750' "
					+ "then '6/8' when vme.fout='0.875' then '7/8' when vme.fout='1.000' then '8/8' end,'') as fout,ac.cldocno as clientid,coalesce(ac.address,ac.address2)clntaddress,ac.mail1 clientmail,"
					+ "coalesce(ac.refname,'')docdetails,coalesce(ac.com_mob,ac.per_mob)clntmob, comp.company,comp.address,comp.tel,comp.fax,br.branchname,vm.flname fleetname,coalesce(vm.REG_NO,'') Regno, "
                    + "insp.doc_no,DATE_FORMAT(insp.date,'%d/%m/%Y') date,insp.time,insp.type,concat(case when insp.reftype='RAG' then 'Rental' when insp.reftype='LAG' then "
                    + "'Lease' when insp.reftype='RPL' then 'Replacement' when insp.reftype='NRM' then 'Non Revenue Movement' end,'-',case when insp.reftype='RAG' then agmt.voc_no when insp.reftype='LAG' then lagmt.voc_no when insp.reftype='NRM' then "
			        + "nrm.doc_no when insp.reftype='RPL' then rep.doc_no end) reftype,insp.refdocno,insp.rfleet,round(insp.amount,2) amount,insp.accident,DATE_FORMAT(insp.acdate,'%d/%m/%Y') acdate,insp.polrep,DATE_FORMAT(insp.coldate,'%d/%m/%Y') coldate,"
			        + "insp.place,round(insp.fine,2) fine,if(insp.claim=1,'Own','Third Party') claim,insp.remarks,case when insp.reftype='NRM' and nrm.drid<>0 then drv.sal_name when insp.reftype='NRM' and nrm.staffid<>0 then stf.sal_name else ac.refname end driver,"
			        + "coalesce(drv.mobile,stf.mobile) drivermob,case when insp.reftype='NRM' and nrm.drid<>0 then 'Driver' when insp.reftype='NRM' and nrm.staffid<>0 then 'Staff' else 'Client' end outby from gl_vinspm insp  left join gl_ragmt agmt on "
			        + "(insp.reftype='RAG' and insp.refdocno=agmt.doc_no) left join gl_lagmt lagmt on (insp.reftype='LAG' and insp.refdocno=lagmt.doc_no) left join gl_nrm nrm on "
			        + "(insp.reftype='NRM' and insp.refdocno=nrm.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no) "
			        + "left join gl_ragmt reprag on (insp.reftype='RPL' and rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on "
			        + "(insp.reftype='RPL' and rep.rtype='LAG' and rep.rdocno=replag.doc_no) left join my_acbook ac on ((case when insp.reftype='RAG' then agmt.cldocno when "
			        + "insp.reftype='LAG' then lagmt.cldocno when insp.reftype='RPL' and rep.rtype='RAG' then reprag.cldocno when insp.reftype='RPL' and rep.rtype='LAG' then "
			        + "replag.cldocno else 0 end)=ac.cldocno and ac.dtype='CRM') left join my_brch br on insp.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no "
			        + "left join gl_vehmaster vm on insp.rfleet=vm.fleet_no left join gl_vehplate vp on vm.PLTID=vp.DOC_NO left join gl_vmove vme on (insp.refdocno=vme.rdocno and insp.reftype=vme.rdtype) or (insp.reftype='RPL' and insp.refdocno=vme.repno) or (insp.reftype='NRM' "
			        + "and insp.refdocno=vme.rdocno and vme.rdtype='MOV') left join my_salesman drv on (nrm.drid=drv.doc_no and drv.sal_type='DRV') "
                    + "left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') left join gl_drdetails drd on (drv.sal_type='DRV' and drv.doc_no=drd.doc_no) or (stf.sal_type='STF' and stf.doc_no=drd.doc_no)    where insp.doc_no="+docno+" and insp.status=3 group by insp.doc_no";*/
		       String strprintmaster="select coalesce(a.CODE_NAME,'')platecode,a.nation,date_format(a.dob,'%d/%m/%Y')dob,a.dlno,date_format(a.dout,'%d/%m/%Y')dout,a.tout,round(a.kmout,2) as kmout,"
	                    + "coalesce(case when a.fout='0.000' then '0/8' when a.fout='0.125' then '1/8' when a.fout='0.250' then '2/8' when a.fout='0.375' then '3/8' when a.fout='0.500' then '4/8' when a.fout='0.625' then '5/8' when a.fout='0.750' then '6/8' when a.fout='0.875' then '7/8' when a.fout='1.000' then '8/8' end,'') as fout,"
	                    + "a.clientid,a.clntaddress,a.clientmail,a.docdetails,a.clntmob,a.company,a.address,a.tel,a.fax,a.branchname,a.fleetname,a.Regno,a.doc_no,DATE_FORMAT(a.date,'%d/%m/%Y') date,a.time,a.type,a.reftype,a.refdocno,a.rfleet,a.amount,a.accident,DATE_FORMAT(a.acdate,'%d/%m/%Y') acdate,a.polrep,DATE_FORMAT(a.coldate,'%d/%m/%Y') coldate,"
	                    + "a.place,a.fine,if(a.claim=1,'Own','Third Party') claim,a.remarks,a.driver,a.drivermob,a.outby from(select vp.CODE_NAME,drd.nation,drd.dob,drd.dlno,if(vme.status='IN',vme.din,vme.dout) dout,if(vme.status='IN',vme.tin,vme.tout) tout,if(vme.status='IN',vme.kmin,vme.kmout) kmout,if(vme.status='IN',vme.fin,vme.fout) fout,"
	                    + "ac.cldocno as clientid,coalesce(ac.address,ac.address2)clntaddress,ac.mail1 clientmail,coalesce(ac.refname,'')docdetails,coalesce(ac.com_mob,ac.per_mob)clntmob, comp.company,comp.address,comp.tel,comp.fax,br.branchname,vm.flname fleetname,coalesce(vm.REG_NO,'') Regno, insp.doc_no,insp.date,insp.time,insp.type,"
	                    + "concat(case when insp.reftype='RAG' then 'Rental' when insp.reftype='LAG' then 'Lease' when insp.reftype='RPL' then 'Replacement' when insp.reftype='NRM' then 'Non Revenue Movement' end,'-',case when insp.reftype='RAG' then agmt.voc_no when insp.reftype='LAG' then lagmt.voc_no when insp.reftype='NRM' then nrm.doc_no when insp.reftype='RPL' then rep.doc_no end) reftype,"
	                    + "insp.refdocno,insp.rfleet,round(insp.amount,2) amount,insp.accident,insp.acdate,insp.polrep,insp.coldate,insp.place,round(insp.fine,2) fine,insp.claim,insp.remarks,case when insp.reftype='NRM' and nrm.drid<>0 then drv.sal_name when insp.reftype='NRM' and nrm.staffid<>0 then stf.sal_name else ac.refname end driver,coalesce(drv.mobile,stf.mobile) drivermob,"
	                    + "case when insp.reftype='NRM' and nrm.drid<>0 then 'Driver' when insp.reftype='NRM' and nrm.staffid<>0 then 'Staff' else 'Client' end outby from gl_vinspm insp  left join gl_ragmt agmt on (insp.reftype='RAG' and insp.refdocno=agmt.doc_no) left join gl_lagmt lagmt on (insp.reftype='LAG' and insp.refdocno=lagmt.doc_no) "
	                    + "left join gl_nrm nrm on (insp.refdocno=nrm.doc_no) left join  gl_vehreplace rep on ( insp.refdocno=rep.doc_no) left join gl_ragmt reprag on (insp.reftype='REP' and rep.rtype='RAG' and rep.rdocno=reprag.doc_no)  left join gl_ragmt repragl on (insp.reftype='REP' and rep.rtype='LAG' and rep.rdocno=repragl.doc_no) left join gl_ragmt rplrag on (insp.reftype='RPL' and rep.rtype='RAG' and rep.rdocno=rplrag.doc_no)  left join gl_lagmt replag on (insp.reftype='RPL' and rep.rtype='LAG' and rep.rdocno=replag.doc_no) "
	                    + "left join my_acbook ac on ((case when insp.reftype='RAG' then agmt.cldocno when insp.reftype='REP' and rep.rtype='RAG' then reprag.cldocno when insp.reftype='REP' and rep.rtype='LAG' then repragl.cldocno when insp.reftype='LAG' then lagmt.cldocno when insp.reftype='RPL' and rep.rtype='RAG' then rplrag.cldocno when insp.reftype='RPL' and rep.rtype='LAG' then replag.cldocno else 0 end)=ac.cldocno and ac.dtype='CRM') left join my_brch br on insp.brhid=br.doc_no "
	                    + "left join my_comp comp on br.cmpid=comp.doc_no left join gl_vehmaster vm on insp.rfleet=vm.fleet_no left join gl_vehplate vp on vm.PLTID=vp.DOC_NO left join gl_vmove vme on (insp.refdocno=vme.rdocno and insp.reftype=vme.rdtype) or (insp.refdocno=vme.repno) or (insp.refdocno=vme.rdocno and vme.rdtype='MOV')"
	                    + "left join my_salesman drv on (nrm.drid=drv.doc_no) left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') left join gl_drdetails drd on ( drv.doc_no=drd.doc_no) or (stf.sal_type='STF' and stf.doc_no=drd.doc_no)where insp.doc_no="+docno+" and insp.status=3 group by insp.doc_no)a;";
		       
		       //System.out.println("mobileprintsql-------"+strprintmaster);
			ResultSet rsprintmaster=printstmt.executeQuery(strprintmaster);
			while(rsprintmaster.next()){
				bean.setLblcompname(rsprintmaster.getString("company"));
				bean.setLblcompaddress(rsprintmaster.getString("clntaddress"));
				bean.setLblcomptel(rsprintmaster.getString("tel"));
				bean.setLblcompfax(rsprintmaster.getString("fax"));
				bean.setLblbranch(rsprintmaster.getString("branchname"));
				bean.setLbldate(rsprintmaster.getString("date"));
				bean.setLbldocno(rsprintmaster.getString("doc_no"));
				bean.setLbltime(rsprintmaster.getString("time"));
				bean.setLbltype(rsprintmaster.getString("type"));
				bean.setLblreftype(rsprintmaster.getString("reftype"));
				bean.setLblrefdocno(rsprintmaster.getString("docdetails"));
				bean.setLblreffleetno(rsprintmaster.getString("rfleet"));
				bean.setLblamount(rsprintmaster.getString("amount")); 
				bean.setLblaccident(rsprintmaster.getString("accident"));
				bean.setLblaccdate(rsprintmaster.getString("acdate"));
				bean.setLblprcs(rsprintmaster.getString("polrep"));
				bean.setLblcoldate(rsprintmaster.getString("coldate"));
				bean.setLblplace(rsprintmaster.getString("place"));
				bean.setLblfines(rsprintmaster.getString("fine"));
				bean.setLblfleetname(rsprintmaster.getString("fleetname"));
				bean.setLblregno(rsprintmaster.getString("Regno"));
				bean.setClientmail(rsprintmaster.getString("clientmail"));
				bean.setLblclientid(rsprintmaster.getString("clientid"));
				bean.setLblclntmob(rsprintmaster.getString("clntmob"));
				bean.setLbldriver(rsprintmaster.getString("driver"));
                bean.setLbldrivermob(rsprintmaster.getString("drivermob"));
                bean.setLbldriverdob(rsprintmaster.getString("dob"));
                bean.setLbldriverdlno(rsprintmaster.getString("dlno"));
                bean.setLblpltcode(rsprintmaster.getString("platecode"));
                bean.setLbldout(rsprintmaster.getString("dout"));
                bean.setLbltout(rsprintmaster.getString("tout"));
                bean.setLblkmout(rsprintmaster.getString("kmout"));
                bean.setLblfout(rsprintmaster.getString("fout"));
                bean.setLbloutby(rsprintmaster.getString("outby"));
                
				
				if(bean.getLblaccident().equalsIgnoreCase("1")){
					bean.setLblclaim(rsprintmaster.getString("claim"));	
				}
				else{
					bean.setLblclaim(" ");
				}
				
				bean.setLblremarks(rsprintmaster.getString("remarks"));
				
			}
			printstmt.close();
			conn.close();
			return bean;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
		
	}
	public   ArrayList<String> getExistingDamagePrint(int docno,String fleetno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> existarray=new ArrayList<String>();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtexist=conn.createStatement();
			String strexist="select dmg.name description,dmg.type code,inspd.type,if(inspd.remarks='0','',inspd.remarks) remarks from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no !="+docno+" and inspd.rdocno <="+docno;
//			System.out.println("Existing Query:"+strexist);
			
			ResultSet rsexist=stmtexist.executeQuery(strexist);
			int i=1;
			while(rsexist.next()){
				String temp=i+"::"+rsexist.getString("code")+"::"+rsexist.getString("description")+"::"+rsexist.getString("type")+"::"+rsexist.getString("remarks");
				i++;
				existarray.add(temp);
			}
//			System.out.println("Existing Array:"+existarray);
			stmtexist.close();
			conn.close();
			return existarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}

	public   ArrayList<String> getNewDamagePrint(int docno,String fleetno) throws SQLException {
		
		// TODO Auto-generated method stub
		ArrayList<String> newarray=new ArrayList<String>();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select  dmg.name description,dmg.type code,inspd.type,if(inspd.remarks='0','',inspd.remarks) remarks from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no="+docno+" group by inspd.rowno";
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				String temp=i+"::"+rsexist.getString("code")+"::"+rsexist.getString("description")+"::"+rsexist.getString("type")+"::"+rsexist.getString("remarks");
				i++;
				newarray.add(temp);
			}
			
			stmtnew.close();
			conn.close();
			return newarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}



	public   ArrayList<String> getNewDamagePrintPics(int docno,
			String fleetno,String url) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(inspd.path,'') path from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no="+docno+" group by inspd.rowno";
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path").split("webapps")[1];
					
					//System.out.println(temp);
					i++;
					picarray.add(url+temp);
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}

	public   ArrayList<String> getAppInspectionPrintPics(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			
			/*String resultdocs = "";
			String ressql = "select max(I1.DOC_NO) att from gl_vinspm i left join gl_vinspm i1 on i.refdocno=i1.refdocno and i.reftype=i1.reftype and i1.type='IN' where i.doc_no="+docno+"";
			System.out.println("attachments doc sql========"+ressql); 
			ResultSet resrs = stmtnew.executeQuery(ressql);
			while(resrs.next()){
				resultdocs = resrs.getString("att");
			}*/
			String resultdocs = "";
			String ressql = "SELECT MAX(I1.DOC_NO) att FROM gl_vinspm i " +
			                    "LEFT JOIN gl_vinspm i1 ON i.refdocno = i1.refdocno AND i.reftype = i1.reftype AND i1.type = 'IN' " +
			                    "WHERE i.doc_no = '"+docno+"' and i.reftype in('REP', 'RPL')";
			    
			    System.out.println("attachments doc sql========" + ressql);
			    
			    ResultSet resrs = stmtnew.executeQuery(ressql);
			    while (resrs.next()) {
			        resultdocs = resrs.getString("att");
			    }
			 

			int signsrno=0;
			String strsignsrno="SELECT fileatchsrno signsrno FROM an_signdetails WHERE rdocno="+docno+"";
			ResultSet rssignsrno=stmtnew.executeQuery(strsignsrno);
			while(rssignsrno.next()){
				signsrno=rssignsrno.getInt("signsrno");
			}
			
			String inClause = docno+"";
			if (resultdocs != null && !resultdocs.trim().isEmpty()) {
			    inClause += ", " + resultdocs;
			}
			
			strnew="SELECT path FROM my_fileattach WHERE doc_no in(" + inClause + ") AND dtype='VIP' AND sr_no<>"+signsrno+"";
		    System.out.println("attachments sql========"+strnew);     
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	public   ArrayList<String> getInspectionPrintPicsLeft(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			if(type.equalsIgnoreCase("IN")){
			strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
	             + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
		         + "and fa.descpt in('leftpic') "
		         + "union all "
		         + "select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
	             + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where vs.type='OUT' and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
		         + "and fa.descpt in('lefthpic')";
			}
			if(type.equalsIgnoreCase("OUT")){
				strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
					 + "and fa.descpt in('lefthpic') ";	
				}
			System.out.println("printpicsleft========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ArrayList<String> getInspectionPrintPicsRight(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			if(type.equalsIgnoreCase("IN")){
				strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('rightpic') "
					 + "union all "
					 + "select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where vs.type='OUT' and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('righthpic')";	
			}
			if(type.equalsIgnoreCase("OUT")){
			strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
				 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
				 + "and fa.descpt in('righthpic')";
			}
			System.out.println("printpicsright========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ArrayList<String> getInspectionPrintPicsFront(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			if(type.equalsIgnoreCase("IN")){
				strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('frontpic') "
					 + "union all "
					 + "select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where vs.type='OUT' and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('fronthpic')";	
			}
			if(type.equalsIgnoreCase("OUT")){
			strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
				 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
				 + "and fa.descpt in('fronthpic')";
			}
			System.out.println("printpicsfront========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ArrayList<String> getInspectionPrintPicsBack(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			if(type.equalsIgnoreCase("IN")){
				strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('backpic') "
					 + "union all "
					 + "select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where vs.type='OUT' and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('backhpic')";	
			}
			if(type.equalsIgnoreCase("OUT")){
			strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
				 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
				 + "and fa.descpt in('backhpic')";
			}
			System.out.println("printpicsback========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ArrayList<String> getInspectionPrintPicsInterior(int docno, String url,String agmtno,String agmtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String type="",strnew="";
			String strtst="select type from gl_vinspm where doc_no="+docno+"";
			ResultSet rstst=stmtnew.executeQuery(strtst);
			while(rstst.next()){
				type=rstst.getString("type");
			}
			if(type.equalsIgnoreCase("IN")){
				strnew="select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('interiorpic') "
					 + "union all "
					 + "select coalesce(fa.path,'') path from gl_vinspm vs left join my_fileattach fa on fa.doc_no=vs.doc_no "
					 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where vs.type='OUT' and fa.dtype='VIP' and vs.reftype='"+agmtype+"' and vs.refdocno="+agmtno+" "
					 + "and fa.descpt in('interiorhpic')";	
			}
			if(type.equalsIgnoreCase("OUT")){
			strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
				 + "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
				 + "and fa.descpt in('interiorhpic')";
			}
			System.out.println("printpicsinterior========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	public   ArrayList<String> getInspectionPrintPicsID(int docno, String url) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
					+ "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
							+ "and fa.descpt in('frontidpic','backidpic','frontidhpic','backidhpic')";
			System.out.println("printpicsidpics========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ArrayList<String> getInspectionPrintPicsNew(int docno, String url) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(fa.path,'') path from my_fileattach fa left join gl_vinspm vs on vs.doc_no=fa.doc_no "
					+ "left join an_takehand at on at.doc_no=vs.takehanddoc left join an_signdetails sg on sg.rdocno=fa.doc_no where fa.doc_no="+docno+" and fa.dtype='VIP' "
							+ "and fa.descpt in('frontpic','leftpic','rightpic','backpic','interiorpic','fronthpic','lefthpic','righthpic','backhpic','interiorhpic')";
			System.out.println("printpics========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				//System.out.println("loop========1");
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path");
					
					//System.out.println(temp);
					i++;
					picarray.add(temp);
				}else{
					
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	public   ArrayList<String> getInspectionPrintPics(int docno, String url) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(f.path,'') path from my_fileattach f left join an_signdetails s on s.rdocno=f.doc_no and fileatchsrno=f.sr_no"
					+ " where f.doc_no="+docno+" and f.dtype='VIP' and s.rdocno is null ";
			System.out.println("strnew==="+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path").split("webapps")[1];
					
					//System.out.println(temp);
					i++;
					picarray.add(url+temp);
				}
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
	
	public   ClsVehicleInspectionBean getRepPrint(int docno,String rfleetno,String ofleetno) throws SQLException {
		ClsVehicleInspectionBean printbean = new ClsVehicleInspectionBean();
		 Connection conn = null; 
		 try {
			 conn = objconn.getMyConnection();
	       Statement stmtpaint = conn.createStatement();
	       String strSql="";
	   
	       strSql=("select coalesce(fi.path,'')paths,coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
		    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
		    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
		    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%m-%Y') DATE,case when r.RTYPE='RAG' then 'Rental' else 'Lease' end rtype,case when r.RTYPE='RAG' then agmt.voc_no else lagmt.voc_no end agmtno,r.RDOCNO,r.RFLEETNO,"+
		    		  " DATE_FORMAT(r.RDATE,'%d-%m-%Y') RDATE,r.RTIME,cast(round(r.RKM,0) as decimal(10)) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
		    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%m-%Y') odate,r.OTIME,cast(round(r.OKM,0) as decimal(10)) okm,r.ofuel 'ofuel',"+
		    		  " case when r.DELSTATUS=0 then 'NO' else 'YES' end delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%m-%Y') DELDATE,cast(round(r.DELKM,0) as decimal(10)) delkm,"+
		    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%m-%Y') indate,r.INTIME,cast(round(r.INKM,0) as decimal(10)) inkm,r.INFUEL 'infuel',r.INLOC,"+
		    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%m-%Y') cldate,r.CLTIME,cast(round(r.CLKM,0) as decimal(10)) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
		    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
		    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
		    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
		    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
		    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
		    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
		    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
		    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
		    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
		    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
		    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
		    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
		    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
		    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' ) left join (select  path,vi.refvoucherno refdocno from my_fileattach fa inner join  gl_vinspm vi on (fa.doc_no=vi.doc_no and fa.dtype='VIP' and fa.descpt='check') ORDER BY fa.doc_no desc\r\n" + 
		    		  " limit 1)fi on (r.doc_no=fi.refdocno and r.rtype='RAG') or (r.doc_no=fi.refdocno and r.rtype='LAG') where r.doc_no="+docno+" GROUP BY r.doc_no");
			       
	      // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate
//System.out.println("==prinrqry=="+strSql);
	       ResultSet resultSet = stmtpaint.executeQuery(strSql); 
	       
	      ClsCommon common=new ClsCommon();
	       while(resultSet.next()){
	    	   
	    	   printbean.setLbldrivenby(resultSet.getString("drivenby"));
	    	   printbean.setLbldescription(resultSet.getString("description"));
	    	   printbean.setLblcoldriver(resultSet.getString("coldriver"));
	    	   printbean.setLbldeldriver(resultSet.getString("deldriver"));
	    	   printbean.setBrwithcompany(" "+resultSet.getString("mainbrch"));
	    	   printbean.setVrano(resultSet.getString("agmtno"));
	    	   printbean.setMtime(resultSet.getString("RTIME"));
	    	   printbean.setPfleetno(resultSet.getString("RFLEETNO"));
	    	   printbean.setPfuel(common.checkFuelName(conn,resultSet.getString("RFUEL")));
	    	   printbean.setPclient(resultSet.getString("refname"));
	    	   printbean.setClientacno(resultSet.getString("acno"));
	    	   printbean.setAgmt(" "+resultSet.getString("rtype"));
	    	   printbean.setPdocno(" "+resultSet.getString("doc_no"));
	    	   printbean.setPdate(resultSet.getString("date"));
	    	   printbean.setPregno(resultSet.getString("reg_no"));
	    	   printbean.setVradate(resultSet.getString("RDATE"));
	    	   System.out.println("RDATE==="+resultSet.getString("RDATE"));
	    	   printbean.setDtimes(resultSet.getString("rtime"));
	    	   
	    	   printbean.setPopened(resultSet.getString("openuser"));
	    	   printbean.setReplaced(resultSet.getString("user_name"));
	    	   printbean.setLbloutlocation(resultSet.getString("outloc"));
	    	   printbean.setLblinlocation(resultSet.getString("inloc"));
	    	   
	    	   if(resultSet.getString("reptype").equalsIgnoreCase("collection")){
	    		   printbean.setReptype("Collection");   
	    	   }
	    	   else{
	    		   printbean.setReptype("At Branch");
	    	   }

	    	   printbean.setPkm(resultSet.getString("rkm"));
	    	   printbean.setPoutdate(resultSet.getString("rdate")); 
	    	   printbean.setPdelivery(resultSet.getString("delstatus")); 
	    	   printbean.setLblrlocation(resultSet.getString("loc_name"));
	    	   
	    // in
	    	   printbean.setInbrwithcompany(resultSet.getString("inandcolbrch"));
	    	   printbean.setInvehdate(resultSet.getString("indate"));
	    	   printbean.setInvehtime(resultSet.getString("intime"));
	    	   printbean.setInvehkm(resultSet.getString("inkm"));
	    	   printbean.setInvehfuel(common.checkFuelName(conn,resultSet.getString("INFUEL")));
	    	   printbean.setInvehreason(resultSet.getString("st_desc"));
	    	   printbean.setLblinfleetname(resultSet.getString("infleetname"));
	    	   
//new out
	    	   printbean.setNewbrwithcompany(resultSet.getString("outanddelbrch"));
	    	   printbean.setNewvehoutdate(resultSet.getString("odate"));
	    	   printbean.setNewvehouttime(resultSet.getString("otime"));
	    	   printbean.setNewvehfleet(resultSet.getString("ofleetno"));
	    	   printbean.setNewvehregno(resultSet.getString("reg_no2"));
	    	   printbean.setLbloutfleetname(resultSet.getString("outfleetname"));
	    	   
	    	   printbean.setNewvehkm(resultSet.getString("okm"));
	    	   printbean.setNewvehfuel(common.checkFuelName(conn, resultSet.getString("oFUEL")));
	 // del
	    	   printbean.setDelbrwithcompany(resultSet.getString("outanddelbrch"));
	    	   printbean.setDeldate(resultSet.getString("deldate"));
	    	   printbean.setDeltime(resultSet.getString("deltime"));
	    	   printbean.setDelfleet(resultSet.getString("ofleetno"));
	    	   printbean.setDelregno(resultSet.getString("reg_no2"));
	    	   printbean.setDelkm(resultSet.getString("delkm"));
	    	   printbean.setDelfuel(common.checkFuelName(conn,resultSet.getString("delfuel")));
	    	   printbean.setLbldelivery(resultSet.getString("delstatus1"));
	    	   printbean.setLbldelfleetname(resultSet.getString("outfleetname"));
	  //col
	    	   printbean.setColbrwithcompany(resultSet.getString("inandcolbrch"));
	    	   printbean.setColdate(resultSet.getString("cldate"));
	    	   printbean.setColtime(resultSet.getString("cltime"));
	    	   printbean.setColfleet(resultSet.getString("rfleetno"));
	    	   printbean.setColregno(resultSet.getString("reg_no"));
	    	   printbean.setColkm(resultSet.getString("clkm"));
	    	   printbean.setColfuel(common.checkFuelName(conn,resultSet.getString("clfuel"))); 
	    	   printbean.setLblcollection(resultSet.getString("clstatus"));
	    	   printbean.setLblcolfleetname(resultSet.getString("infleetname"));
	    	   
	    	   printbean.setSigpath(resultSet.getString("paths"));
	    	   
	    	   
	       }
	       
	       
	       stmtpaint.close();
	       
	      	       
	       Statement stmtimg=conn.createStatement();
	       
	       String sql1="select g.vehimgpath from gl_vehmaster v left join gl_vehgroup g on v.vgrpid=g.doc_no where fleet_no="+rfleetno+"";
	       
	       ResultSet rsimg=stmtimg.executeQuery(sql1);
	       
	       while(rsimg.next())
	       {
	    	   printbean.setLblinimg(rsimg.getString("vehimgpath"));
	       }
	       
         //Statement stmtimg2=conn.createStatement();
	       
	       String sql2="select g.vehimgpath from gl_vehmaster v left join gl_vehgroup g on v.vgrpid=g.doc_no where fleet_no="+ofleetno+"";
	       
	       ResultSet rsimg2=stmtimg.executeQuery(sql2);
	       
	       while(rsimg2.next())
	       {
	    	   printbean.setLbloutimg(rsimg2.getString("vehimgpath"));
	       }
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname from gl_vehreplace r  "
		    		+ " left join my_brch b on r.rbrhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

		    
	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		  
		    	   printbean.setRepbarnchval(resultsetcompany.getString("branchname"));
		    	   printbean.setRepcompanyname(resultsetcompany.getString("company"));
		    	  
		    	   printbean.setRepaddress(resultsetcompany.getString("address"));
		    	 
		    	   printbean.setRepmobileno(resultsetcompany.getString("tel"));
		    	  
		    	   printbean.setRepfax(resultsetcompany.getString("fax"));
		    	   printbean.setReplocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	      conn.close();
	      }
		 finally{
				conn.close();
			}
	      return printbean;
	     }
	
	public   ClsVehicleInspectionBean getRentalPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement();
			double totaldays = 0; // this for calculate total rate
			double net = 0, csmdmg = 0;
			String strSql = "";

			
			double cosmoscdw = 0.0, cosmocdw = 0.0, cosmopai = 0.0, cosmodelchg = 0.0, cosmorate = 0.0;
			String dmgtotalqry = "select coalesce(round(sum(d.total),2),0) as damagetotal from gl_invm m left join gl_invd d on m.doc_no=d.rdocno where rano="
					+ docno + " and chid=10";
			ResultSet rsdmg = stmtinvoice.executeQuery(dmgtotalqry);
			while (rsdmg.next()) {
				bean.setLblcosmodamagechg(rsdmg.getString("damagetotal"));
				csmdmg = rsdmg.getDouble("damagetotal");
			}

			String strindigo = "select coalesce(ra.sal_code,'') rentalagent,coalesce(dr.nation,'') nationality,coalesce(br.tel,'') indigobranchtel,coalesce(br.fax,'') indigobranchmobile,agmt.cldocno from gl_ragmt agmt left join my_brch br on "
					+ " agmt.brhid=br.doc_no left join gl_rdriver rdr on (agmt.doc_no=rdr.rdocno and rdr.status=3) left join gl_drdetails dr on rdr.drid=dr.dr_id "
					+ " left join my_salesman ra on (agmt.raid=ra.doc_no and ra.sal_type='RLA') where agmt.doc_no="
					+ docno;
			// System.out.println("Indigo"+strindigo);
			/*
			 * left join gl_drdetails d left join gl_rdriver rr " +
			 * " on rr.drid=d.dr_id where rr.rdocno="
			 * +docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="
			 * +docno+") " + " and (select max(srno) srno from gl_rdriver  where rdocno="
			 * +docno+") and  rr.status=3 where agmt.doc_no="+docno;
			 */
			int clientcount = 0;
			ResultSet rsindigo = stmtinvoice.executeQuery(strindigo);
//		   System.out.println("@@@@@@@@@============="+strindigo+"====nation===="+rsindigo.getString("nationality"));
			while (rsindigo.next()) {
				bean.setLblindigobranchmobile(rsindigo.getString("indigobranchmobile"));
				bean.setLblindigobranchtel(rsindigo.getString("indigobranchtel"));
				bean.setLblindigocldocno(rsindigo.getString("cldocno"));
				if (clientcount == 0) {
					bean.setLblindigonationality(rsindigo.getString("nationality"));
					clientcount = 1;
				}

				bean.setLblindigorentalagent(rsindigo.getString("rentalagent"));
			}

			String strrentserdue = "select lst_srv from gl_vehmaster where doc_no=" + docno + "";

			System.out.println("----suss---" + strrentserdue);
			ResultSet rarentserdue = stmtinvoice.executeQuery(strrentserdue);
			while (rarentserdue.next()) {
				bean.setRarentserdue(rarentserdue.getString("lst_srv"));
			}

			String strindigotarif = "select (select rentaltype  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=5) as rentaltype," + "(select round(cast(rate as decimal(9,2)),2) rate  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=5) as rate," + "(select if(round(cast(rate as decimal(9,2)),2)<0,0,round(cast(rate as decimal(9,2)),2)) rate  from gl_rtarif where  rdocno= " 
					+ ""+docno+" and rstatus=6) as discount,"
					+ "(select round(cast(rate as decimal(9,2)),2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as nettotal";

			ResultSet rsindigotarif = stmtinvoice.executeQuery(strindigotarif);
			while (rsindigotarif.next()) {
				if (rsindigotarif.getString("rentaltype").equalsIgnoreCase("Monthly")) {
					bean.setLblindigorenttype(rsindigotarif.getString("rentaltype") + "(30 Days)");
				} else {
					bean.setLblindigorenttype(rsindigotarif.getString("rentaltype"));
				}
				int tsttt=rsindigotarif.getInt("discount");
				if(tsttt<=0) {
				bean.setLblindigorate(rsindigotarif.getString("nettotal"));
				}
				else
				{
					bean.setLblindigorate(rsindigotarif.getString("rate"));
				}
				bean.setLblindigodiscount(rsindigotarif.getString("discount"));
				bean.setLblindigonettotal(rsindigotarif.getString("nettotal"));
				net = rsindigotarif.getDouble("nettotal");
			}

			String strrate = "select (select coalesce(rentaltype,'')rentaltype from gl_rtarif where  rstatus=5 and rdocno=" + docno
					+ ") rentaltype,"
					+ " (select round(rate+coalesce(pai,0),2) rate from gl_rtarif where rstatus=7 and rdocno=" + docno
					+ ") rate;";

			// System.out.println("---lllllllllly---------:"+strrate);
			Statement stmtrate = conn.createStatement();
			ResultSet raters = stmtrate.executeQuery(strrate);

			while (raters.next()) {
				bean.setLblrentaltype(raters.getString("rentaltype"));
				bean.setLblrentalrate(raters.getString("rate"));

			}
			stmtrate.close();

			// --------print-------//

			/*
			 * String
			 * strsalik="select amount,rtype,amount from gl_salik where (rtype='RM' or rtype='RA' or rtype='RD' or rtype='RF' or rtype='RW') and ra_no=1;"
			 * ; Statement stmtsalik=conn.createStatement(); ResultSet
			 * salikrs=stmtsalik.executeQuery(strsalik); salikrs.next();
			 * 
			 * 
			 * String
			 * strfine="select fine,rtype from gl_ragmt r left join gl_traffic t on r.doc_no=t.ra_no where (rtype='RM' or rtype='RA' or rtype='RD' or rtype='RF' or rtype='RW') and r.doc_no=5;"
			 * ; Statement stmtfine=conn.createStatement(); ResultSet
			 * finers=stmtfine.executeQuery(strsalik); finers.next();
			 */
			/*
			 * rate+=coalesce(pai,0)+coalesce(cdw,0)+coalesce(gps,0)+coalesce(babyseater,0)+
			 * coalesce(kmrest,0)+coalesce(exkmrte,0)+coalesce(chaufchg,0)+coalesce(cdw1,0)+
			 * coalesce(pai1,0)+coalesce(cooler,0)+coalesce(oinschg,0)+coalesce(exhrchg,0)+
			 * coalesce(chaufexchg,0)
			 */

			strSql = ("select  usr.user_name, d.visano, DATE_FORMAT(d.visa_exp, '%d-%m-%Y') AS visaexp,u.authname ,coalesce(ra.authority,'')authority,coalesce(FORMAT(r.date,'dd-MM-yyyy'),'') createdate,coalesce(r.desc1,'') agmtdesc,coalesce(ch.sal_name,'') chkoutby,usr.user_id,a.trnnumber,a.cldocno,v.ch_no,coalesce(r.desc1,'') description,coalesce(FORMAT(r.ddate,'dd-MM-yyyy'),'') ddate, dtime, ra.sal_name ragnt,sa.sal_name sagnt, sm.sal_name ,   round(coalesce(r.delchg,0),2) delchg,a.per_tel,case when a.ser_default=1 then case when g1.method=1 then round(g1.value,2) else 0 end else round(per_salikrate,2) end salikcharge, \r\n"
					+ "    case when a.ser_default=1 then round(g2.value,2) else round(per_trafficharge,2) end trafficcharge, \r\n"
					+ "     case when a.ser_default=1 then case when g1.method=1 then round(g1.value,2) else 0 end else round(per_salikrate,2) end saliktotal,concat(u.authid,' ',p.code_name,' ',v.reg_no) reg_noval,r.voc_no,cast(r.insex as decimal(10)) insex,case when r.clstatus=0 then 'Open' else 'Closed' end clstatus,a.per_tel,a.fax1, r.doc_no,round(coalesce(r.addrchg,0),2) addrchg,r.mrano,cast(round(r.okm,0) as decimal(9,2)) okm,"
					+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
					+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
					+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
					+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' WHEN r.ofuel is null THEN ''	END as 'ofuel' ,coalesce(FORMAT(r.odate,'dd-MM-yyyy'),'')odate,coalesce(r.otime,'')otime,coalesce(a.refname,'')refname,  "
					+ "a.address,a.address2,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',u.authid,' ',p.code_name) authregno,concat(v.reg_no,' ',u.authid,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,p.code_name,"
					+ "(select round(rate,2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as rate, (select  round(cast(cdw as decimal(9,2)),2)+round(cast(cdw1 as decimal(9,2)),2) "
					+ "  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as cdw , (select round(cast(gps as decimal(9,2)),2)+round(cast(babyseater as decimal(9,2)),2)+round(cast(cooler as decimal(9,2)),2) "
					+ "	 from gl_rtarif where  rdocno=" + docno + " and rstatus=7) as accessories, "
					+ " (select round(cast(cdw1 as decimal(9,2)),2)  from gl_rtarif where  rdocno=" + docno + " and rstatus=7) as scdw , "
					+ " (select round(cdw1,2)  from gl_rtarif where  rdocno=" + docno + " and rstatus=7) as vmd , "
					+ "  (select round(kmrest,0)  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as raextrakm, " + "(select round(cast(exkmrte as decimal(9,2)),2)  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=7) as raexxtakmchg," + "(select round(cast(pai as decimal(9,2)),2)  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=7) as pai," + "(select round(cast(chaufchg as decimal(9,2)),2)  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=7) as chaufchg," + "(select rentaltype  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=5) as rentaltypes, " + " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
					+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
					+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
					+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
					+ "	  THEN 'Level 8/8' WHEN rc.infuel is null THEN ''	 END as 'infuel',cast(round(coalesce(rc.inkm,0.0),1) as decimal(10)) inkm,coalesce(FORMAT(rc.indate,'dd-MM-yyyy'),'') indate,coalesce(rc.intime,'')intime,co.color,yo.yom , v.ch_no "
					+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
					+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
					+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
					+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n"
					+ "    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	 left join my_salesman ch on ch.doc_no=r.ochkid  	 "
					+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
					+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom  left join my_user usr on r.userid=usr.doc_no	   		"
					+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid   where r.doc_no="
					+ docno + " limit 1");

			//System.out.println("-----iu----" + strSql);

			ResultSet resultSet = stmtinvoice.executeQuery(strSql);

			while (resultSet.next()) {
				// bean.setLbmasterdate(resultSet.getString("date"));
				bean.setVisano(resultSet.getString("visano"));      
				bean.setVisaexp(resultSet.getString("visaexp"));
				bean.setVehauth(resultSet.getString("authname"));
				bean.setUserid(resultSet.getString("user_name"));
				// cldatails

				// getDuedate getSalagent getRaagent
				// classic address2
				bean.setLbldesc(resultSet.getString("agmtdesc"));
				bean.setCladdress2(resultSet.getString("address2"));
				// end
				bean.setCh_no(resultSet.getString("ch_no"));
				bean.setDuedate(resultSet.getString("ddate"));
				bean.setCreatedate(resultSet.getString("createdate"));
				// mm
				bean.setDuetime(resultSet.getString("dtime"));

				bean.setRaagent(resultSet.getString("ragnt"));
				bean.setSalagent(resultSet.getString("chkoutby"));

				bean.setSalikcharge(resultSet.getString("salikcharge"));
				bean.setTrafficcharge(resultSet.getString("trafficcharge"));
				bean.setTotalsalikandtraffic(resultSet.getString("saliktotal"));
				bean.setLblclientrn(resultSet.getString("trnnumber"));
				bean.setClname(resultSet.getString("refname"));
				bean.setCladdress(resultSet.getString("address"));
				bean.setClemail(resultSet.getString("mail1"));
				bean.setClmobno(resultSet.getString("per_mob"));
				bean.setLbluser(resultSet.getString("user_id"));
				// mm
				bean.setSalname(resultSet.getString("sal_name"));

				bean.setLdllandno(resultSet.getString("per_tel"));

				// upper

				bean.setMrano(resultSet.getString("mrano"));
				bean.setRentaldoc(resultSet.getString("voc_no"));
				bean.setLblauthority(resultSet.getString("authority"));

				// bean.setLbfueltype(resultSet.getString("fueltype"));
				// bean.setLbmodel(resultSet.getString("vtype"));

				// veh details

				bean.setRavehauthregno(resultSet.getString("authregno"));
				bean.setRavehname(resultSet.getString("flname"));
				bean.setRavehgroup(resultSet.getString("gname"));
				bean.setRavehmodel(resultSet.getString("vtype"));
				bean.setRavehregno(resultSet.getString("reg_no"));
				bean.setRadateout(resultSet.getString("odate"));
				bean.setRatimeout(resultSet.getString("otime"));
				bean.setRaklmout(resultSet.getString("okm"));
				bean.setRavehplate(resultSet.getString("code_name"));

				bean.setHidjqxDateOut(resultSet.getString("odate"));
				bean.setHidjqxTimeOut(resultSet.getString("otime"));
				bean.setRe_Km(resultSet.getString("okm"));
				bean.setRatariff_fuel(resultSet.getString("ofuel"));
				bean.setIndate(resultSet.getString("indate"));
				bean.setIntime(resultSet.getString("intime"));
				bean.setInkm(resultSet.getString("inkm"));
				bean.setInfuel(resultSet.getString("infuel"));

				bean.setLblrentaldesc(resultSet.getString("description"));
				// rental type

				// bean.setRadaily(resultSet.getString("daily"));
				// bean.setRaweakly(resultSet.getString("weekly"));
				// bean.setRamonthly(resultSet.getString("monthly"));
				bean.setTariff(resultSet.getString("rate"));
				bean.setRacdwscdw(resultSet.getString("cdw"));
				bean.setRaaccessory(resultSet.getString("accessories"));
				bean.setRaadditionalcge(resultSet.getString("addrchg"));

				bean.setRasupercdw(resultSet.getString("scdw"));
				bean.setRavmd(resultSet.getString("vmd"));

				// in details

				bean.setColdates(resultSet.getString("indate"));
				bean.setColtimes(resultSet.getString("intime"));
				bean.setColkmins(resultSet.getString("inkm"));
				bean.setColfuels(resultSet.getString("infuel"));

				// bean.setKmused(resultSet.getString("kmused"));
				// bean.setNoofdays(resultSet.getString("noofdays"));

				// bean.setPertel(resultSet.getString("per_tel"));
				// bean.setFaxno(resultSet.getString("fax1"));

				bean.setDeldetailss("Delivered");

				bean.setColdetails("Collected");

				// setIndetails,setColdetails

				bean.setRastatus(resultSet.getString("clstatus"));
				bean.setRafuelout(resultSet.getString("ofuel"));
				//

				bean.setRayom(resultSet.getString("yom"));
				bean.setRacolor(resultSet.getString("color"));

				// setRaextrakm,setRaexxtakmchg

				bean.setRaextrakm(resultSet.getString("raextrakm"));
				bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
				bean.setRarenttypes(resultSet.getString("rentaltypes"));

				// pai,chaufchg
				bean.setLblpai(resultSet.getString("pai"));
				bean.setLaldelcharge(resultSet.getString("delchg"));
				bean.setLblchafcharge(resultSet.getString("chaufchg"));
				double scdw = resultSet.getDouble("scdw");
				double pai = resultSet.getDouble("pai");
				double addchg = resultSet.getDouble("addrchg");
				double chfchg = resultSet.getDouble("chaufchg");
				double tot = net + scdw + pai + addchg + chfchg;
			System.out.println("scdw==" + scdw + "pai====" + pai + "addchg===" + addchg + "chfchg===" + chfchg
						+ "net===" + net + "Total===" + tot);
				if (tot > 0) {

					bean.setTotaltot(tot);
				}
				double extrakm = resultSet.getDouble("raextrakm");
				double extrakmchg = resultSet.getDouble("raexxtakmchg");
				double racdwscdw = resultSet.getDouble("cdw");
				double raaccessory = resultSet.getDouble("accessories");
				double raaddchg = resultSet.getDouble("addrchg");

				double tot2 = net + csmdmg + racdwscdw + raaccessory + raaddchg;
				if (tot2 > 0) {

					bean.setRentaltotals(tot2);
				}
				// getLblpai() , getLaldelcharge() getLblchafcharge()

				if (resultSet.getString("cdw").equalsIgnoreCase("0.00")) {
					bean.setExcessinsu(resultSet.getString("insex"));

				} else {

					bean.setExcessinsu("0.00");
				}

				// driven
				// setLblpertel setLblfaxno setLbldobdate setLblradlno setDrivravehregno
				bean.setLblclname(resultSet.getString("refname"));
				bean.setLblcladdress(resultSet.getString("address"));
				bean.setLblclemail(resultSet.getString("mail1"));
				bean.setLblclmobno(resultSet.getString("per_mob"));
				bean.setLblcldocno(resultSet.getString("cldocno"));

				bean.setDrivravehregno(resultSet.getString("reg_noval"));
				bean.setLblpertel(resultSet.getString("per_tel"));
				bean.setLblfaxno(resultSet.getString("fax1"));

				// setLbldobdate setLblradlno setLbcardno setLbexpcarddate

				// For getting total in cosmo print
				cosmoscdw = resultSet.getDouble("scdw");
				cosmocdw = resultSet.getDouble("cdw");
				cosmopai = resultSet.getDouble("pai");
				cosmodelchg = resultSet.getDouble("delchg");
				cosmorate = resultSet.getDouble("rate");

			}

			String strcosmo = "select  (select round(rate,2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as rate,"
					+ " round(coalesce(r.delchg,0),2) delchg,(select round(pai,2)  from gl_rtarif where  rdocno="
					+ docno + " and rstatus=7) as pai,"
					+ " (select  round(cdw,2)+round(cdw1,2) from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as cdw," + " (select round(cdw1,2)  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as scdw,round(rc.colchg,2) cosmocollectchg,"
					+ " (select round(gps,2) from gl_rtarif where  rdocno=" + docno + " and rstatus=7) as cosmogps,"
					+ " (select round(babyseater,2) from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=7) as cosmobabyseater," + " (select round(cooler,2) from gl_rtarif where  rdocno="
					+ docno + " and rstatus=7) as cosmocooler,"
					+ " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=1) cosmokmrestrictdaily,"
					+ " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=2) cosmokmrestrictweekly,"
					+ " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=3) cosmokmrestrictmonthly,"
					+ " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=1) cosmoexkmratedaily,"
					+ " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=2) cosmoexkmrateweekly,"
					+ " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=3) cosmoexkmratemonthly,"
					+ " (select coalesce(round(amount,2),'') from gl_rpyt where rdocno=" + docno
					+ " and payid=1) cosmoadvance,(select coalesce(round(amount,2),'') from gl_rpyt where rdocno="
					+ docno
					+ " and payid=2) cosmosecurity,case when pyt.mode='CARD' then pyt.card else '' end cosmocreditcard,case when pyt.mode='CARD' then pyt.cardno else '' end cosmocreditcardno,"
					+ " case when pyt.mode='CARD' then pyt.expdate else '' end cosmocreditcarddate,rc.infuel cosmofuelin,rc.inkm cosmokmin,checkin.sal_name cosmocheckin,checkout.sal_name "
					+ " cosmocheckout,v.fleet_no cosmofleetno,brd.brand_name cosmobrand,d.issfrm cosmoissuedat,coalesce(round(r.insex,2),'') insurexcess from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
					+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
					+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
					+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n"
					+ "    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	   			        "
					+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
					+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
					+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid left join gl_vehbrand brd on v.brdid=brd.doc_no "
					+ " left join my_salesman checkout on (r.ochkid=checkout.doc_no and checkout.sal_type='CHK') left join my_salesman checkin on "
					+ " (rc.chkinid=checkin.doc_no and checkin.sal_type='CHK') left join gl_rpyt pyt on (r.doc_no=pyt.rdocno) where r.doc_no="
					+ docno + " limit 1";
			//System.out.println("Cosmo Sql:" + strcosmo);
			Statement stmtcosmo = conn.createStatement();
			ResultSet rscosmo = stmtcosmo.executeQuery(strcosmo);
			while (rscosmo.next()) {
				// data for cosmo print

				bean.setLblcosmokmrestrictdaily(rscosmo.getString("cosmokmrestrictdaily"));
				bean.setLblcosmokmrestrictweekly(rscosmo.getString("cosmokmrestrictweekly"));
				bean.setLblcosmokmrestrictmonthly(rscosmo.getString("cosmokmrestrictmonthly"));
				bean.setLblcosmoexkmratedaily(rscosmo.getString("cosmoexkmratedaily"));
				bean.setLblcosmoexkmrateweekly(rscosmo.getString("cosmoexkmrateweekly"));
				bean.setLblcosmoexkmratemonthly(rscosmo.getString("cosmoexkmratemonthly"));
				bean.setLblcosmoadvance(rscosmo.getString("cosmoadvance"));
				bean.setLblcosmosecurity(rscosmo.getString("cosmosecurity"));
				System.out.println("Security: " + bean.getLblcosmosecurity());
				bean.setLblcosmocreditcardno(rscosmo.getString("cosmocreditcardno"));
				bean.setLblcosmocreditvaliddate(rscosmo.getString("cosmocreditcarddate"));
				bean.setCardtype(rscosmo.getString("cosmocreditcard"));
				bean.setLblcosmofuelin(objcommon.checkFuelName(conn, rscosmo.getString("cosmofuelin")));
				bean.setLblcosmokmin(rscosmo.getString("cosmokmin"));
				bean.setLblcosmocheckin(rscosmo.getString("cosmocheckin"));
				bean.setLblcosmocheckout(rscosmo.getString("cosmocheckout"));
				bean.setLblcosmofleetno(rscosmo.getString("cosmofleetno"));
				bean.setLblcosmofleetbrand(rscosmo.getString("cosmobrand"));
				bean.setLblcosmoissuedat(rscosmo.getString("cosmoissuedat"));
				bean.setLblcosmogps(rscosmo.getString("cosmogps"));
				bean.setLblcosmobabyseater(rscosmo.getString("cosmobabyseater"));
				bean.setLblcosmocollectchg(rscosmo.getString("cosmocollectchg"));
				bean.setLblcosmoexcessamt(rscosmo.getString("insurexcess"));
				bean.setLblcosmocooler(rscosmo.getString("cosmocooler"));
				System.out.println("====" + cosmoscdw + "---" + cosmocdw + "---" + cosmopai + "---" + cosmodelchg
						+ "---" + cosmorate + "---" + rscosmo.getDouble("cosmogps") + "---"
						+ rscosmo.getDouble("cosmobabyseater") + "---" + rscosmo.getDouble("cosmocollectchg"));
				double cosmototaltemp = cosmoscdw + cosmocdw + cosmopai + cosmodelchg + cosmorate
						+ rscosmo.getDouble("cosmogps") + rscosmo.getDouble("cosmobabyseater")
						+ rscosmo.getDouble("cosmocollectchg") + rscosmo.getDouble("cosmocooler");
				System.out.println("Total: " + cosmototaltemp);
				bean.setLblcosmototal(cosmototaltemp + "");
			}

			

			stmtinvoice.close();

			Statement stmtinvoice66 = conn.createStatement();
			Statement stmtcosmodriver = conn.createStatement();
			String strcosmodriver = "select  name,mobno,dlno,FORMAT(d.led,'dd-MM-yyyy') led,passport_no from gl_drdetails d left join gl_rdriver rr  "
					+ " on rr.drid=d.dr_id where rr.rdocno=" + docno
					+ " and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno=" + docno + ") "
					+ " and (select max(srno) srno from gl_rdriver  where rdocno=" + docno + ") and  rr.status=3 limit 2";
			//System.out.println("=======" + strcosmodriver);
			ResultSet rscosmodriver = stmtcosmodriver.executeQuery(strcosmodriver);
			int drivercount = 0;
			while (rscosmodriver.next()) {
				if (drivercount > 0) {
					bean.setLblcosmodrivername(rscosmodriver.getString("name"));
					bean.setLblcosmodrivermobile(rscosmodriver.getString("mobno"));
					bean.setLblcosmodriverlicense(rscosmodriver.getString("dlno"));
					bean.setLblcosmodrivervalidupto(rscosmodriver.getString("led"));
					bean.setLblcosmodriverpassport(rscosmodriver.getString("passport_no"));
				}
				drivercount++;
			}
			String maindr = " select coalesce(d.mobno,'') mobile,coalesce(d.ltype,'') licensetype,coalesce(visano,'') visano,FORMAT(d.visa_exp,'dd-MM-yyyy') visa_exp,format(date_add(date_add(d.visa_exp,interval -2 year),interval 1 day),'dd-MM-yyyy') visaissdate,coalesce(d.nation,'') nation,coalesce(issfrm,'') issuedby,coalesce(FORMAT(d.issdate,'dd-MM-yyyy'),'') issuedfrom,"
					+ " d.name drname,d.dlno,FORMAT(d.dob,'dd-MM-yyyy') dob,FORMAT(d.led,'dd-MM-yyyy') led,case when d.PASSPORT_NO='0' then '' else d.PASSPORT_NO end "
					+ " PASSPORT_NO,FORMAT(d.pass_exp,'dd-MM-yyyy') pass_exp,format(date_add(date_add(d.pass_exp,interval -10 year),interval 1 day),'dd-MM-yyy') dates from gl_drdetails d left join gl_rdriver rr  "
					+ " on rr.drid=d.dr_id where rr.rdocno=" + docno
					+ " and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno=" + docno + ") "
					+ " and (select max(srno) srno from gl_rdriver  where rdocno=" + docno
					+ ") and  rr.status=3 order by rr.srno limit 3";
			//System.out.println("---------maindr------" + maindr);

			ResultSet resultmain = stmtinvoice66.executeQuery(maindr);

			int i = 0;

			while (resultmain.next()) {
				if (i == 0) {
					// yessur
					bean.setDrivermobno(resultmain.getString("mobile"));
					// end yessure
					bean.setLblpassissdate(resultmain.getString("dates"));
					System.out.println("date" + resultmain.getString("dates"));
					bean.setRadrname(resultmain.getString("drname"));
					bean.setRadlno(resultmain.getString("dlno"));
					bean.setPassno(resultmain.getString("passport_no"));
					bean.setLicexpdate(resultmain.getString("led"));
					bean.setPassexpdate(resultmain.getString("pass_exp"));
					bean.setDobdate(resultmain.getString("dob"));
					bean.setLblnation(resultmain.getString("nation"));
					bean.setLblissby(resultmain.getString("licensetype"));
					bean.setLblpassissued(resultmain.getString("issuedby"));
					bean.setLblissfromdate(resultmain.getString("issuedfrom"));
					System.out.println("datesssssss" + resultmain.getString("issuedby"));
					bean.setLblidno(resultmain.getString("visano"));
					bean.setLblvisaexp(resultmain.getString("visa_exp"));
					bean.setLblvisaissdate(resultmain.getString("visaissdate"));
					// drin
					bean.setLbldobdate(resultmain.getString("dob"));
					bean.setLblradlno(resultmain.getString("dlno"));
					bean.setAdddrname1("None");
					bean.setLblindigoaddmobile(resultmain.getString("mobile"));
					bean.setRamobile(resultmain.getString("mobile"));
				}

				if (i == 1) {
					bean.setAdddrname1(resultmain.getString("drname"));
					bean.setAddlicno1(resultmain.getString("dlno"));
					bean.setLbladdpassno1(resultmain.getString("passport_no"));
					bean.setExpdate1(resultmain.getString("led"));
					bean.setLbladdpassexp1(resultmain.getString("pass_exp"));
					bean.setAdddob1(resultmain.getString("dob"));
					bean.setLbladdnation1(resultmain.getString("nation"));
					bean.setLbladdissby1(resultmain.getString("licensetype"));
					bean.setLbladdpassissued1(resultmain.getString("issuedby"));
					bean.setLbladdissfrom1(resultmain.getString("issuedfrom"));
					bean.setLbladdid1(resultmain.getString("visano"));
					bean.setLblindigoaddmobile(resultmain.getString("mobile"));
					bean.setLblindigoaddnationality(resultmain.getString("nation"));
					bean.setRamobile(resultmain.getString("mobile"));
				}

				if (i == 2) {

					bean.setAdddrname2(resultmain.getString("drname"));

					bean.setAddlicno2(resultmain.getString("dlno"));

					bean.setExpdate2(resultmain.getString("led"));

					bean.setAdddob2(resultmain.getString("dob"));
				}

				i = i + 1;

			}
			stmtinvoice66.close();

			/**
			 * Daily , weekly mpnthly rate as per agrement for confident rent a car
			 */

			String rate = " select (select round(rate,2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=1) daily," + " (select round(rate,2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=2) weekly," + " (select round(rate,2) rate  from gl_rtarif where  rdocno=" + docno
					+ " and rstatus=3) monthly;";
			stmtinvoice66 = conn.createStatement();
			ResultSet resultrate = stmtinvoice66.executeQuery(rate);
			while (resultrate.next()) {
				bean.setRadaily(resultrate.getString("daily"));
				bean.setRaweakly(resultrate.getString("weekly"));
				bean.setRamonthly(resultrate.getString("monthly"));
			}
			System.out.println(
					"===== " + bean.getRadaily() + "===== " + bean.getRaweakly() + "======= " + bean.getRamonthly());
			stmtinvoice66.close();
			

			Statement stmtinvoice51 = conn.createStatement();

			String sql011 = "select  case when aa.defaultcard=1 then aa.cardno else cardno end cardno,case when aa.defaultcard=1 then FORMAT(aa.exp_date,'dd-MM-yyyy') else FORMAT(exp_date,'dd-MM-yyyy') end exp_date,"
					+ " case when aa.defaultcard=1 then aa.defaultcard else defaultcard end defaultcard from "
					+ " (SELECT cardno,exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"
					+ docno + "' limit 1) "
					+ " and sr_no=(select sr_no from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"
					+ docno + "')and defaultcard=1)) aa "
					+ " union all (SELECT cardno,FORMAT(exp_date,'dd-MM-yyyy') exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"
					+ docno + "') and "
					+ "sr_no=(select min(sr_no) from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"
					+ docno + "') and defaultcard=0) )";

			// System.out.println("----sql011------"+sql011);

			ResultSet ress1 = stmtinvoice51.executeQuery(sql011);

			while (ress1.next()) {
				bean.setLbexpcarddate(ress1.getString("exp_date"));
				bean.setLbcardno(ress1.getString("cardno"));
				// setLbcardno setLbexpcarddate
			}

			stmtinvoice51.close();

			Statement stmtinvoice10 = conn.createStatement();
			

			String companysql = "select coalesce(c.tel2,'') tel2,coalesce(c.email,'') email,coalesce(c.web,'') web,c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,r.brhid from gl_ragmt r inner join my_brch b on  "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc, "
					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="
					+ docno + " ";

			//System.out.println("-----COMPANY-----" + companysql);

			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql);

			while (resultsetcompany.next()) {
				bean.setLblagmtbrhid(resultsetcompany.getString("brhid"));
				bean.setLbltel1(resultsetcompany.getString("tel"));
				bean.setLbltel2(resultsetcompany.getString("tel2"));
				bean.setLblcompmail(resultsetcompany.getString("email"));
				bean.setLblcompwebsite(resultsetcompany.getString("web"));
				bean.setBarnchval(resultsetcompany.getString("branchname"));
				bean.setCompanyname(resultsetcompany.getString("company"));

				bean.setAddress(resultsetcompany.getString("address"));

				bean.setMobileno(resultsetcompany.getString("tel"));

				bean.setFax(resultsetcompany.getString("fax"));
				bean.setLocation(resultsetcompany.getString("location"));

			}
			stmtinvoice10.close();

			Statement stmttatal = conn.createStatement();
			String totalsql = "select round(aa.inv-aa.total,2) balance,round(aa.total,2) total,round(aa.inv,2) inv\r\n"
					+ "from ((select coalesce(round(sum(case when dtype='CRV' then dramount else 0 end),2),0) total,\r\n"
					+ "coalesce(round(sum(case when dtype='INV' then dramount else 0 end),2),0) inv from my_jvtran where rtype='RAG' and rdocno="
					+ docno + " and id=1)) aa";
			//System.out.println("=======" + totalsql);
			ResultSet restotal = stmttatal.executeQuery(totalsql);

			while (restotal.next()) {

				bean.setTotalpaid((restotal.getDouble("total") == 0.0 ? "" : restotal.getDouble("total")) + "");

				bean.setInvamount((restotal.getDouble("inv") == 0.0 ? "" : restotal.getDouble("inv")) + "");
				bean.setBalance((restotal.getDouble("balance") == 0.0 ? "" : restotal.getDouble("balance")) + "");

			}
			stmttatal.close();

			Statement delstmt = conn.createStatement();
			String delsql = "select FORMAT(v.din,'dd-MM-yyyy') din, v.tin tin, cast(round(v.kmin,0) as decimal(10)) kmin,  "
					+ " CASE WHEN v.fin='0.000'   THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' "
					+ "  WHEN   v.fin='0.375' THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' "
					+ "    WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' "
					+ "        END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no and v.rdtype='RAG' and v.status='IN' "
					+ "           and v.trancode='DL'  and v.doc_no=(select min(doc_no) from gl_vmove where  rdtype='RAG' and status='IN'   "
					+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0 and exchng=0 )    where r.delstatus=1 and r.doc_no="
					+ docno + "  and v.repno=0 and v.custno=0 and v.exchng=0";

			//System.out.println("delsql-----------+++++----------" + delsql);
			ResultSet rsdel = delstmt.executeQuery(delsql);

			while (rsdel.next()) {

				bean.setOutdetails("Out :");
				bean.setDeldetailss("Delivered :");

				bean.setDeldates(rsdel.getString("din"));

				bean.setDeltimes(rsdel.getString("tin"));
				bean.setDelkmins(rsdel.getString("kmin"));
				bean.setDelfuels(rsdel.getString("fin"));

			}
			rsdel.close();

			Statement colstmt = conn.createStatement();
			String colsql = "select FORMAT(v.dout,'dd-MM-yyyy') din, v.tout tin, round(v.kmout,2) kmin, CASE WHEN v.fout='0.000' THEN 'Level 0/8' WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250' "
					+ "THEN 'Level 2/8' WHEN v.fout='0.375' THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN "
					+ "v.fout='0.625' THEN 'Level 5/8'  WHEN v.fout='0.750' THEN 'Level 6/8' WHEN v.fout='0.875' THEN "
					+ "'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8'  END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no "
					+ "and v.rdtype='RAG' and v.status='IN' and trancode='DL' inner join gl_ragmtclosem col on col.agmtno=r.doc_no "
					+ " where col.colstatus=1 and r.doc_no=" + docno
					+ "  and v.doc_no =(select max(doc_no) from gl_vmove where rdocno=" + docno + " "
					+ "and rdtype='RAG' and status='IN' and trancode='DL' and repno=0 and  custno=0 and exchng=0) ";

			ResultSet rscol = colstmt.executeQuery(colsql);

			while (rscol.next()) {

				bean.setIndetails("Collected :");

				bean.setColdetails("In :");

				bean.setInkm(rscol.getString("kmin"));
				bean.setInfuel(rscol.getString("fin"));
				bean.setIndate(rscol.getString("din"));
				bean.setIntime(rscol.getString("tin"));

			}
			rscol.close();

			Statement rstmt = conn.createStatement();
			String rstmtsql = "select case when cardno='0' then '' else cardno end cardno,coalesce(expdate,'') expdate,case when acode='0' then '' else acode end acode,round(cast(amount as decimal(9,2)),2) amount,card from gl_rpyt  where  payid=2 and  rdocno='"
					+ docno + "' ";
//System.out.println("paymrntmode===="+rstmtsql);
			ResultSet rsp = rstmt.executeQuery(rstmtsql);
			// setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),

			while (rsp.next()) {

				bean.setSecuritycardno(rsp.getString("cardno"));
				bean.setSecurityexpdate(rsp.getString("expdate"));
				bean.setSecuritypreauthno(rsp.getString("acode"));
				bean.setSecuritypreauthamt(rsp.getString("amount"));
				bean.setCardtype(rsp.getString("card"));

			}
			rsp.close();

			Statement rstmt2 = conn.createStatement();
			String rstmtsql2 = "select DATEDIFF(r.ddate,coalesce(mv.din,r.odate)) totaldays from gl_ragmt r left join "
					+ " gl_vmove mv on mv.rdocno=r.doc_no and mv.rdtype='RAG' and mv.trancode='DL' and mv.repno=0 and mv.custno=0  and mv.exchng=0 \r\n"
					+ " where r.doc_no='" + docno + "' ";
			// System.out.println("1========"+rstmtsql2);
			ResultSet rsp2 = rstmt2.executeQuery(rstmtsql2);
			// setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),

			while (rsp2.next()) {

				totaldays = rsp2.getDouble("totaldays");

				bean.setLblnofdays(String.valueOf(totaldays));

			}
			rsp2.close();

			double paidtotalamt = 0;
			Statement rstmt1 = conn.createStatement();
			String rstmtsql1 = "select amount from gl_rpyt  where payid=1 and rdocno='" + docno + "' ";
			
			ResultSet rsp1 = rstmt1.executeQuery(rstmtsql1);
			// setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),

			while (rsp1.next()) {

				paidtotalamt = (rsp1.getDouble("amount"));

			}
			rsp1.close();

			
			Statement rstmtnw = conn.createStatement();
			String rstmtsqlnw = "select card,round(cast(amount as decimal(9,2)),2)amount from gl_rpyt where payment='Advance' and rdocno='" + docno + "' ";
		
			ResultSet rspnw = rstmtnw.executeQuery(rstmtsqlnw);
			// setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),

			while (rspnw.next()) {

				bean.setSecuritypreauthamt(rspnw.getString("amount"));
				bean.setCardtype(rspnw.getString("card"));


			}
			rspnw.close();
			
			
			
			
			
			double tariftotal = 0, cdwtotal = 0, accsssorytotal = 0, deltotal = 0;

			double totalamt = 0;

			double balamount = 0;
			String rentaltype = bean.getRarenttypes();

			double divval = 1;
			if (rentaltype.equalsIgnoreCase("Monthly"))

			{

				if (totaldays <= 30) {
					totaldays = 1;
					divval = 1;

				} else {
					divval = 30;
				}

			} else if (rentaltype.equalsIgnoreCase("Weekly")) {

				if (totaldays <= 7) {
					totaldays = 1;
					divval = 1;
				} else {
					divval = 7;
				}

			} else {
				if (totaldays <= 0) {
					totaldays = 1;
					divval = 1;
				} else {
					divval = 1;
				}

			}

			// System.out.println("divval======"+divval);

			// System.out.println("-----totaldays--="+totaldays);
			DecimalFormat df = new DecimalFormat("0.00");
			tariftotal = (Double.parseDouble(bean.getTariff()) * totaldays) / divval;
			cdwtotal = (Double.parseDouble(bean.getRacdwscdw()) * totaldays) / divval;
			accsssorytotal = (Double.parseDouble(bean.getRaaccessory()) * totaldays) / divval;
			deltotal = (Double.parseDouble(bean.getLaldelcharge()) * totaldays) / divval;

			bean.setTarifftotal(df.format(tariftotal) + "");
			bean.setRacdwscdwtotal(df.format(cdwtotal) + "");
			bean.setRaaccessorytotal(df.format(accsssorytotal) + "");
			bean.setLaldelchargetotal(df.format(deltotal) + "");

			totalamt = tariftotal + cdwtotal + accsssorytotal + deltotal;

			balamount = totalamt - paidtotalamt;

			bean.setAdvtotalamont(df.format(totalamt) + "");
			bean.setAdvpaidamount(df.format(paidtotalamt) + "");
			bean.setAdvbalance(df.format(balamount) + "");

			
			String clsprintqry = "select coalesce(pm.doc_no,0) inspdoc,veh.reg_no,veh.flname model,yom.yom year,tarif.rdocno,tarif.gps,tarif.babyseater,tarif.cooler,agmt.pono,agmt.doc_no,agmt.desc1,rpt.cardno,rpt.amount from gl_ragmt agmt "
					+ "left join gl_vehmaster veh on veh.fleet_no=agmt.fleet_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and rstatus=7) "
					+ "left  join  (select  cardno,expdate,rdocno,amount from gl_rpyt rpt where rdocno=" + docno
					+ " limit 1 )  rpt on agmt.doc_no=rpt.rdocno left join gl_vinspm pm on agmt.doc_no=pm.refdocno where agmt.doc_no="
					+ docno + "";
			//System.out.println("clsprintqry==" + clsprintqry);
			Statement clprintstmt = conn.createStatement();
			ResultSet clprint = clprintstmt.executeQuery(clsprintqry);
			while (clprint.next()) {
				bean.setClsiclpo(clprint.getString("pono"));
				bean.setClcreditcard(clprint.getString("cardno"));
				bean.setCladvance(clprint.getString("amount"));
				bean.setCldesc(clprint.getString("desc1"));
				bean.setRayear(clprint.getString("year"));
				bean.setInspdoc(clprint.getString("inspdoc"));
				bean.setGpsprint(clprint.getString("gps"));
				bean.setBabyseaterprint(clprint.getString("babyseater"));

			}

			// Overriding for Carfare
			Statement stmt = conn.createStatement();
			ClsCommon objcommon = new ClsCommon();
			int delivery = 0, delstatus = 0;
			String stragmtdetails = "select delstatus,delivery,odate,otime,cast(round(okm,0) as decimal(10)) okm,ofuel from gl_ragmt where doc_no="
					+ docno;
			ResultSet rsagmtdetails = stmt.executeQuery(stragmtdetails);
			while (rsagmtdetails.next()) {
				bean.setOutdetails("Out :");
				bean.setRadateout(getStringDateFormat(rsagmtdetails.getDate("odate"), conn));
				bean.setRatimeout(rsagmtdetails.getString("otime"));
				bean.setRaklmout(rsagmtdetails.getString("okm"));
				bean.setRafuelout(objcommon.checkFuelName(conn, rsagmtdetails.getString("ofuel")));
				delivery = rsagmtdetails.getInt("delivery");
				delstatus = rsagmtdetails.getInt("delstatus");
			}
			if (delivery == 1 && delstatus == 1) {
				String strmov = "select coalesce(v.din,'')din, coalesce(v.tin,'')tin, cast(round(coalesce(v.kmin,''),0) as decimal(10)) kmin,coalesce(v.fin,'')fin from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no and v.rdtype='RAG' and v.status='IN' "
						+ " and v.trancode='DL'  and v.doc_no=(select min(doc_no) from gl_vmove where  rdtype='RAG' and status='IN'   "
						+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0 and exchng=0 )    where r.delstatus=1 and r.doc_no="
						+ docno + "  and v.repno=0 and v.custno=0 and v.exchng=0";
				ResultSet rsmov = stmt.executeQuery(strmov);
				while (rsmov.next()) {
					bean.setDeldetailss("Delivered :");
					bean.setDeldates(getStringDateFormat(rsmov.getDate("din"), conn));
					bean.setDeltimes(rsmov.getString("tin"));
					bean.setDelkmins(rsmov.getString("kmin"));
					bean.setDelfuels(objcommon.checkFuelName(conn, rsmov.getString("fin")));
				}
			}
			conn.close();
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();

		}
		return bean;
		}
	
	
	public   ClsVehicleInspectionBean getLeasePrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		Connection conn=null;
		 try {
	    	   conn = objconn.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       String strSql="";
	      
			 //Cosmo Print
	       
			
	      /* String strsqlcosmo="select  coalesce(grp.vehimgpath,'') vehimgpath,l.desc1,l.cldocno,l.po,round(coalesce(l.insurexcess,0),2) insurexcess,case when per_name=1 then l.per_value*12 else per_value end duration,FORMAT(dateadd(month,case when l.per_name=1 then l.per_value*12 else per_value end,dateadd(day,-1,l.outdate)),'dd-MM-yyyy') enddate,v.fleet_no,v.eng_no engine,v.ch_no chassis ,l.voc_no agmtno,FORMAT(l.outdate,'dd-MM-yyyy') outdate,a.refname clientname,a.address clientaddress,a.per_mob,a.per_tel, v.reg_no regno,co.color,"+
	       " FORMAT(l.duedate,'dd-MM-yyyy') duedate,yo.yom,brd.brand_name brand,mo.vtype model, (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as agreedrate from gl_lagmt l left join my_acbook a "+
	       " on a.cldocno=l.cldocno   and  a.dtype='CRM' left join gl_vehmaster  v on v.fleet_no=case when l.perfleet=0 then l.tmpfleet else l.perfleet end left join gl_vehmodel mo on "+
	       " mo.doc_no=v.vmodid  left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom  left join "+
	       " my_color co on co.doc_no=v.clrid  left join gl_vehbrand brd on v.brdid=brd.doc_no left join gl_vehgroup grp on v.vgrpid=grp.doc_no where l.doc_no="+docno+"";
	       System.out.println("strsqlcosmo===>"+strsqlcosmo);*/
	       String strsqlcosmo = "SELECT COALESCE(grp.vehimgpath,'') AS vehimgpath, l.desc1, l.cldocno, l.po, " +
	    		    "ROUND(COALESCE(l.insurexcess, 0), 2) AS insurexcess, " +
	    		    "CASE WHEN per_name = 1 THEN l.per_value * 12 ELSE per_value END AS duration, " +
	    		    "DATE_FORMAT(DATE_ADD(DATE_SUB(l.outdate, INTERVAL 1 DAY), INTERVAL " +
	    		    "CASE WHEN l.per_name = 1 THEN l.per_value * 12 ELSE l.per_value END MONTH), '%d-%m-%Y') AS enddate, " +
	    		    "v.fleet_no, v.eng_no AS engine, v.ch_no AS chassis, l.voc_no AS agmtno, " +
	    		    "DATE_FORMAT(l.outdate, '%d-%m-%Y') AS outdate, a.refname AS clientname, a.address AS clientaddress, " +
	    		    "a.per_mob, a.per_tel, v.reg_no AS regno, co.color, " +
	    		    "DATE_FORMAT(l.duedate, '%d-%m-%Y') AS duedate, yo.yom, brd.brand_name AS brand, mo.vtype AS model, " +
	    		    "(SELECT ROUND(rate, 2) FROM gl_ltarif WHERE rdocno = " + docno + ") AS agreedrate " +
	    		    "FROM gl_lagmt l " +
	    		    "LEFT JOIN my_acbook a ON a.cldocno = l.cldocno AND a.dtype = 'CRM' " +
	    		    "LEFT JOIN gl_vehmaster v ON v.fleet_no = CASE WHEN l.perfleet = 0 THEN l.tmpfleet ELSE l.perfleet END " +
	    		    "LEFT JOIN gl_vehmodel mo ON mo.doc_no = v.vmodid " +
	    		    "LEFT JOIN gl_vehplate p ON p.doc_no = v.pltid " +
	    		    "LEFT JOIN gl_ltarif t ON t.rdocno = l.doc_no " +
	    		    "LEFT JOIN gl_yom yo ON yo.doc_no = v.yom " +
	    		    "LEFT JOIN my_color co ON co.doc_no = v.clrid " +
	    		    "LEFT JOIN gl_vehbrand brd ON v.brdid = brd.doc_no " +
	    		    "LEFT JOIN gl_vehgroup grp ON v.vgrpid = grp.doc_no " +
	    		    "WHERE l.doc_no = " + docno;   
      //System.out.println("strsqlcosmo===>"+strsqlcosmo);
	       Statement stmtcosmo=conn.createStatement();
	       ResultSet rscosmo=stmtcosmo.executeQuery(strsqlcosmo);
	       int duration=0;
	       while(rscosmo.next()){
	    	   bean.setCldesc(rscosmo.getString("desc1"));
	    	   bean.setLblindigocldocno(rscosmo.getString("cldocno"));
	    	   bean.setClsiclpo(rscosmo.getString("po"));
//	    	   System.out.println("dao="+rscosmo.getString("enddate"));
	    	   
	    	   bean.setDuedate(rscosmo.getString("duedate"));
		       bean.setLblcosmoexcessamt(rscosmo.getString("insurexcess"));
				/*
				 * bean.setLblcosmoagmtno(rscosmo.getString("agmtno"));
				 * bean.setLblcosmoagreedrate(rscosmo.getString("agreedrate"));
				 * bean.setLblcosmoclientname(rscosmo.getString("clientname"));
				 * bean.setLblcosmoclientaddress(rscosmo.getString("clientaddress"));
				 * bean.setLblcosmoclientmobile(rscosmo.getString("per_mob"));
				 * bean.setLblcosmoclienttel(rscosmo.getString("per_tel"));
				 * bean.setLblcosmoregno(rscosmo.getString("regno"));
				 * bean.setLblcosmocolor(rscosmo.getString("color"));
				 * bean.setLblcosmoyom(rscosmo.getString("yom"));
				 * bean.setLblcosmobrand(rscosmo.getString("brand"));
				 * bean.setLblcosmomodel(rscosmo.getString("model"));
				 * bean.setLblcosmofleetno(rscosmo.getString("fleet_no"));
				 * bean.setLblcosmoengine(rscosmo.getString("engine"));
				 * bean.setLblcosmochassis(rscosmo.getString("chassis"));
				 * bean.setLblcosmostartdate(rscosmo.getString("outdate"));
				 * bean.setLblcosmoduration(rscosmo.getString("duration"));
				 * bean.setLblcosmoenddate(rscosmo.getString("enddate"));
				 * bean.setLblvehimagepath(rscosmo.getString("vehimgpath"));
				 */
	       }
	       String  strcosmoterm="select mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0 ";
	       ResultSet rscosmoterm=stmtcosmo.executeQuery(strcosmoterm);
	       int cosmoi=0;
	       while(rscosmoterm.next()){
				/*
				 * if(cosmoi==0){ bean.setLblcosmoterm1(rscosmoterm.getString("mnthfrm"));
				 * bean.setLblcosmoterm2(rscosmoterm.getString("mnthto"));
				 * bean.setLblcosmoamt1(rscosmoterm.getString("amt")); } if(cosmoi==1){
				 * bean.setLblcosmoterm3(rscosmoterm.getString("mnthfrm"));
				 * bean.setLblcosmoterm4(rscosmoterm.getString("mnthto"));
				 * bean.setLblcosmoamt2(rscosmoterm.getString("amt")); } if(cosmoi==2){
				 * bean.setLblcosmoterm5(rscosmoterm.getString("mnthfrm"));
				 * bean.setLblcosmoterm6(rscosmoterm.getString("mnthto"));
				 * bean.setLblcosmoamt3(rscosmoterm.getString("amt")); } if(cosmoi==3){
				 * bean.setLblcosmoterm7(rscosmoterm.getString("mnthfrm"));
				 * bean.setLblcosmoterm8(rscosmoterm.getString("mnthto"));
				 * bean.setLblcosmoamt4(rscosmoterm.getString("amt")); } if(cosmoi==4){
				 * bean.setLblcosmoterm9(rscosmoterm.getString("mnthfrm"));
				 * bean.setLblcosmoterm10(rscosmoterm.getString("mnthto"));
				 * bean.setLblcosmoamt5(rscosmoterm.getString("amt")); } cosmoi++;
				 */
	       }
	       double csmdmg=0;
	       String dmgtotalqry="select coalesce(round(sum(d.total),2),0) as damagetotal from gl_invm m left join gl_invd d on m.doc_no=d.rdocno where rano="+docno+" and chid=10";
//		   System.out.println("=====dmgtotalqry======"+dmgtotalqry);
	       ResultSet rsdmg=stmtinvoice.executeQuery(dmgtotalqry);
		   while(rsdmg.next()){
			   bean.setLblcosmodamagechg(rsdmg.getString("damagetotal"));
			   csmdmg=rsdmg.getDouble("damagetotal");
		   }
	       strSql=("select usr.user_name,d.visano, DATE_FORMAT(d.visa_exp, '%d-%m-%Y') AS visaexp,case when a.ser_default=1 then case when g1.method=1 then round(g1.value,2) else 0 end else round(per_salikrate,2) end salikcharge,  "
	       		+ "  case when a.ser_default=1 then 25 else round(per_trafficharge,2) end  trafficcharge,  round(l.insurexcess,2) insurexcess , "
	       		+ " l.voc_no,case when l.clstatus=0 then 'Open' else 'Closed' end clstatus, l.doc_no,round(l.addrchg,2) addrchg,l.outkm okm, "
	       		+ " CASE WHEN l.outfuel='0.000' THEN 'Level 0/8' WHEN l.outfuel='0.125' THEN 'Level 1/8' WHEN l.outfuel='0.250' "
	       		+ " THEN 'Level 2/8' WHEN l.outfuel='0.375' THEN 'Level 3/8' WHEN l.outfuel='0.500' THEN 'Level 4/8' WHEN "
	       		+ " l.outfuel='0.625' THEN 'Level 5/8'  WHEN l.outfuel='0.750' THEN 'Level 6/8' WHEN l.outfuel='0.875' THEN 'Level 7/8'  "
	       		+ " WHEN l.outfuel='1.000' THEN 'Level 8/8'  END as 'ofuel' ,FORMAT(l.outdate,'dd-MM-yyyy') odate,l.outtime otime,a.refname,  "
	       		+ " a.address,a.per_mob,a.per_tel,  sm.sal_name ,   a.mail1,br.branchname,concat(v.reg_no,' ',u.authid,' ',p.code_name) reg_no,concat(v.reg_no,' ',p.code_name,' ',u.authid) authregno,concat(v.flname,' ',case when l.perfleet=0 then '(Temp)' else '(Pr)' end) flname,g.gname,mo.vtype, "
	       		+ " (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as rate, (select  round(cdw,2)+round(cdw1,2) "
	       		+ " from gl_ltarif where rdocno="+docno+"  ) as cdw , (select  round(pai,2)+round(pai1,2) "
	       		+ " from gl_ltarif where rdocno="+docno+"  ) as pai,(select round(chaufchg,2)  from gl_ltarif where  rdocno="+docno+" ) as chaufchg , (select round(gps,2)+round(babyseater,2)+round(cooler,2)   from gl_ltarif where "
	       		+ " rdocno="+docno+"  ) as accessories,   (select round(kmrest,0)  from gl_ltarif where  rdocno="+docno+" ) "
	       		+ " as raextrakm, (select round(exkmrte,2)  from gl_ltarif where  rdocno="+docno+") as raexxtakmchg,  CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
	       		+ " WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250'  THEN 'Level 2/8' WHEN rc.infuel='0.375' "
	       		+ " THEN 'Level 3/8' WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
	       		+ " WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
	       		+ " THEN 'Level 8/8'   END as 'infuel',round(rc.inkm,2) inkm,FORMAT(rc.indate,'dd-MM-yyyy') "
	       		+ " indate,rc.intime,co.color,yo.yom    from gl_lagmt l left join my_acbook a on a.cldocno=l.cldocno "
	       		+ "  and  a.dtype='CRM' left join gl_drdetails d on   d.cldocno=a.cldocno  left join my_brch br      on br.branch=l.brhid left join gl_vehmaster  v on v.fleet_no=case when l.perfleet=0 then l.tmpfleet else l.perfleet end  "
	       		+ " left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_config g1 on g1.field_nme='saliksrv'  left join gl_config g2 on g2.field_nme='trafficsrvper'  left join gl_vehauth u on  v.authid=u.doc_no  "
	       		+ "  left join gl_vehmodel mo on mo.doc_no=v.vmodid "
	       		+ " left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no "
	       		+ " left join gl_lagmtclosem rc on rc.agmtno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom left join my_user usr on l.userid=usr.doc_no "
	       		+ " left join my_color co on co.doc_no=v.clrid   left join my_salm sm on sm.doc_no=l.salid     where l.doc_no="+docno+"");
		       
System.out.println("strSql============"+strSql);
	       
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	   // cldatails
	    	   
	    	   
	    	   bean.setSalikcharge(resultSet.getString("salikcharge"));
	    	   bean.setTrafficcharge(resultSet.getString("trafficcharge"));
	    	   
	    	   
	    	   if(resultSet.getString("cdw").equalsIgnoreCase("0.00"))
			   {
		        bean.setExcessinsu(resultSet.getString("insurexcess")); 
	 
			    }
				   else
				   {
					    
					   bean.setExcessinsu("0.00");   
				   }
	    	    bean.setUserid(resultSet.getString("user_name"));
				bean.setVisano(resultSet.getString("visano"));    	   
	    	    bean.setVisaexp(resultSet.getString("visaexp"));
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
	    	   // bean.setCltelno(resultSet.getString("per_tel"));
	    	    //upper
	    	  
	    	   /* bean.setMrano("1");*/
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    	  // veh details
	    	    
				bean.setRavehauthregno(resultSet.getString("authregno"));
	    	    bean.setRavehname(resultSet.getString("flname"));
	    	    bean.setRavehgroup(resultSet.getString("gname"));
	    	    bean.setRavehmodel(resultSet.getString("vtype"));
	    	    bean.setRavehregno(resultSet.getString("reg_no"));
	    	    bean.setRadateout(resultSet.getString("odate"));
	    	    bean.setRatimeout(resultSet.getString("otime"));
	    	    bean.setRaklmout(resultSet.getString("okm"));
	    	    
	    	    // rental type
	    	    
	    	 //   bean.setRadaily(resultSet.getString("daily"));
	    	   // bean.setRaweakly(resultSet.getString("weekly"));
	    	  //  bean.setRamonthly(resultSet.getString("monthly"));
	    	    bean.setTariff(resultSet.getString("rate"));
	    	    bean.setRacdwscdw(resultSet.getString("cdw"));
	    	    bean.setRaaccessory(resultSet.getString("accessories"));
	    	    bean.setRaadditionalcge(resultSet.getString("addrchg"));
	    	    bean.setLblpai(resultSet.getString("pai"));
	    	    bean.setLblchafcharge(resultSet.getString("chaufchg"));
		    	// in details
		    	    double net=resultSet.getDouble("rate");
		    	    double racdwscdw=resultSet.getDouble("cdw");
		    	    double raaccessory=resultSet.getDouble("accessories");
		    	    double raaddchg=resultSet.getDouble("addrchg");
		    	   // System.out.println("===totals===dmg=="+csmdmg+"=====cdw===="+racdwscdw+"=====accessory===="+raaccessory+"=====raaddchg===="+raaddchg+"=====finaltotal==="+net);
		    	    double tot2=net+csmdmg+racdwscdw+raaccessory+raaddchg;
		    	    
		    	    if(tot2>0){
		    	    	
		    	    	  bean.setRentaltotals(tot2);
		    	    }
	    	    // in details
	    	    if(resultSet.getString("clstatus").equalsIgnoreCase("Closed")){
	    	    	bean.setInkm(resultSet.getString("inkm"));
	  	    	    bean.setInfuel(resultSet.getString("infuel"));
	  	    	    bean.setIndate(resultSet.getString("indate"));
	  	    	    bean.setIntime(resultSet.getString("intime"));
	  	    	}
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	//
	    	    bean.setRayom(resultSet.getString("yom"));
	    	    bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	  //setRaextrakm,setRaexxtakmchg
	    	   
	    	    bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	    bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    	    /*	   bean.setRarenttypes("SS");*/
	    	   
	    	   
		//mm
				
		  bean.setSalname(resultSet.getString("sal_name"));
	    	 	   


	       }
	       
	       
	  
	       stmtinvoice.close();
	       

		 Statement delstmt = conn.createStatement ();
	      /* String  delsql="select convert(varchar,l.deldate,103) deldate,coalesce(l.deltime,'')deltime,round(coalesce(l.delkm,''),2) delkm,CASE WHEN l.delfuel='0.000' THEN 'Level 0/8' "
	       		+ "WHEN l.delfuel='0.125' THEN 'Level 1/8'"
	       		+ " WHEN l.delfuel='0.250' THEN 'Level 2/8' WHEN l.delfuel='0.375' THEN 'Level 3/8' WHEN l.delfuel='0.500' THEN 'Level 4/8' "
	       		+ "WHEN l.delfuel='0.625' THEN 'Level 5/8'  WHEN l.delfuel='0.750' THEN 'Level 6/8' WHEN l.delfuel='0.875' THEN 'Level 7/8' "
	       		+ "WHEN l.delfuel='1.000' THEN 'Level 8/8'  END as 'delfuel' from gl_lagmt l where  doc_no="+docno+" ";*/
		 String  delsql="select DATE_FORMAT(l.deldate, '%d/%m/%Y') AS deldate,coalesce(l.deltime,'')deltime,round(coalesce(l.delkm,''),2) delkm,CASE WHEN l.delfuel='0.000' THEN 'Level 0/8' "
		       		+ "WHEN l.delfuel='0.125' THEN 'Level 1/8'"
		       		+ " WHEN l.delfuel='0.250' THEN 'Level 2/8' WHEN l.delfuel='0.375' THEN 'Level 3/8' WHEN l.delfuel='0.500' THEN 'Level 4/8' "
		       		+ "WHEN l.delfuel='0.625' THEN 'Level 5/8'  WHEN l.delfuel='0.750' THEN 'Level 6/8' WHEN l.delfuel='0.875' THEN 'Level 7/8' "
		       		+ "WHEN l.delfuel='1.000' THEN 'Level 8/8'  END as 'delfuel' from gl_lagmt l where  doc_no="+docno+" ";
		     System.out.println(delstmt);
	         ResultSet rsdel = delstmt.executeQuery(delsql); 
	        
		       
		       while(rsdel.next()){
		    	   
		    	   bean.setOutdetails("Out :");
		    	   bean.setDeldetailss("Delivered :");
		     	   bean.setDeldates(rsdel.getString("deldate"));
		    	    bean.setDeltimes(rsdel.getString("deltime"));
		    	    bean.setDelkmins(rsdel.getString("delkm"));
		    	    bean.setDelfuels(rsdel.getString("delfuel")); 
		    	   
		    	   
		    	  
		    	   
		       } 
		  //    rsdel.close();
		      delstmt.close();
Statement crditcard = conn.createStatement();

String ssql="select p.card,p.cardno,p.expdate from gl_lagmt l left join gl_lpyt p on (l.doc_no=p.rdocno) where l.doc_no="+docno;
	       //System.out.println(ssql);
ResultSet rsdell = crditcard.executeQuery(ssql); 


while(rsdell.next()){
	   

	   bean.setCardtype(rsdell.getString("card"));
	 //   bean.setCosmocreditcardno(rsdell.getString("cardno"));
	    bean.setLblcosmocreditvaliddate(rsdell.getString("expdate"));
	     
	   
	   
	  
	   
} 
//  rsdel.close();
crditcard.close();
	      // setTermi1 setTermi2 setTermi3
	       
         Statement trmi = conn.createStatement();
	       
	     /*  String  trmisql="select top 5 mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0";*/
	       String  trmisql="SELECT  mnthfrm,mnthto,ROUND(amt, 2) AS amt,rdocno FROM gl_ltermcl WHERE rdocno = '"+docno+"' AND amt > 0 LIMIT 5";
	       System.out.println("trmisql===>"+trmisql);
	       ResultSet resulttermi = trmi.executeQuery(trmisql); 
	       
	       int j=0;
	       
	 	       while(resulttermi.next()){
	 	    	   if(j==0)
	 	    	   {
	 	    	  //  bean.setTermi1("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months   -  "+resulttermi.getString("amt"));
	 	    	    
	 	    	    
	 	    	   }
	 	    	   
	 	    	   if(j==1)
	 	    	   {
	 	    		   
	 	    		//bean.setTermi2("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months  -  "+resulttermi.getString("amt"));
	 	  	    	 
	 		    	   
	 	    		   
	 	    	   }
	 	    	   
	 	    	   
	 	    	   if(j==2)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		//bean.setTermi3("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	   if(j==3)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		//bean.setTermi4("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	 if(j==4)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		//bean.setTermi5("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	   j=j+1;
	 	    	   
	 	       }
	 	      trmi.close();
	 	        
	       
	       
	       
	       
	       
	       Statement stmtinvoice66 = conn.createStatement();
	       
	     /*  String  maindr=" select top 3 dr.nation,dr.mobno,dr.name drname,dr.dlno ,FORMAT(dr.dob,'dd-MM-yyyy') dob,FORMAT(dr.led,'dd-MM-yyyy') led, "
	       		+ " case when dr.PASSPORT_NO=null then '' else dr.PASSPORT_NO end passport_no,FORMAT(dr.pass_exp,'dd-MM-yyyy') pass_exp, "
	       		+ " rr.srno from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id and rr.status=3 where rr.rdocno="+docno+" "
	       		+ " and rr.srno between(select min(srno) srno from gl_ldriver  where rdocno="+docno+" and status=3) and (select max(srno) srno from gl_ldriver  where  rdocno="+docno+" and status=3)";*/
	       String  maindr=" select  dr.nation,dr.mobno,dr.name drname,dr.dlno ,FORMAT(dr.dob,'dd-MM-yyyy') dob,FORMAT(dr.led,'dd-MM-yyyy') led, "
		       		+ " case when dr.PASSPORT_NO=null then '' else dr.PASSPORT_NO end passport_no,FORMAT(dr.pass_exp,'dd-MM-yyyy') pass_exp, "
		       		+ " rr.srno from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id and rr.status=3 where rr.rdocno="+docno+" "
		       		+ " and rr.srno between(select min(srno) srno from gl_ldriver  where rdocno="+docno+" and status=3) and (select max(srno) srno from gl_ldriver  where  rdocno="+docno+" and status=3) LIMIT 3";
	       System.out.println("maindr===>"+maindr);
    ResultSet resultmain = stmtinvoice66.executeQuery(maindr); 
	       
    int i=0;
    
	       while(resultmain.next()){
	    	   if(i==0)
	    	   {
	    		   bean.setLblindigonationality(resultmain.getString("nation"));
	    		   bean.setDrivermobno(resultmain.getString("mobno"));
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	    
	    	   }
	    	   
	    	   if(i==1)
	    	   {
	    		   
	    		   bean.setAdddrname1(resultmain.getString("drname"));
	  	    	//  bean.setLblindigoaddnationality1(resultmain.getString("nation"));
	  	    	 bean.setLblindigoaddmobile(resultmain.getString("mobno"));
		    	   bean.setAddlicno1(resultmain.getString("dlno"));
		    	  
		    	   bean.setExpdate1(resultmain.getString("led"));
		    	
		    	   bean.setAdddob1(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   
	    	   if(i==2)
	    	   {
	    		   
	  	    	 
		    	   bean.setAdddrname2(resultmain.getString("drname"));
		    	  
		    	   bean.setAddlicno2(resultmain.getString("dlno"));
		    	 
		    	   bean.setExpdate2(resultmain.getString("led"));
		    	  
		    	   bean.setAdddob2(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   i=i+1;
	    	   
	       }
	       stmtinvoice66.close();
	        
	       
	       
	       
	  
	       
	       Statement stmtinvoice10 = conn.createStatement ();
	       
	       /*String companysql="select top 1 c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,r.brhid from gl_lagmt r inner join my_brch b on r.brhid=b.DOC_NO inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no where r.doc_no="+docno;*/
	       String companysql="select  c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,r.brhid from gl_lagmt r inner join my_brch b on r.brhid=b.DOC_NO inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no where r.doc_no='"+docno+"' group by r.doc_no";
	       ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   bean.setLblagmtbrhid(resultsetcompany.getString("brhid"));
		    	   bean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   bean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   bean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setFax(resultsetcompany.getString("fax"));
		    	   bean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
		       Statement stmttatal = conn.createStatement ();
			    String  totalsql="select round(aa.inv-aa.total,2) balance,round(aa.total,2) total,round(aa.inv,2) inv from ((select coalesce(round(sum(case when dtype='CRV' then dramount else 0 end),2),0) total,coalesce(round(sum(case when dtype='INV' then dramount else 0 end),2),0) inv from my_jvtran where rtype='LAG' and rdocno="+docno+"   and id=1))aa";
				
		         ResultSet restotal = stmttatal.executeQuery(totalsql); 
		        
			       
			       while(restotal.next()){
			 
			    	//   bean.setTotalpaids(restotal.getDouble("total")==0.0?"":restotal.getDouble("total")+"");
			    	   
			    	   bean.setInvamount(restotal.getDouble("inv")==0.0?"":restotal.getDouble("inv")+"");
			    	   bean.setBalance(restotal.getDouble("balance")==0.0?"":restotal.getDouble("balance")+"");
			    	   
			       } 
			       stmttatal.close();
			       
		
			     //Overriding for Carfare
					Statement stmt=conn.createStatement();
					ClsCommon objcommon=new ClsCommon();
					ClsRentalAgreementDAO ragmtdao=new ClsRentalAgreementDAO();
					int delivery=0,delstatus=0;
					String stragmtdetails="select delstatus,delivery,outdate odate,outtime otime,round(outkm,0) okm,outfuel ofuel from gl_lagmt where doc_no="+docno;
					ResultSet rsagmtdetails=stmt.executeQuery(stragmtdetails);
					while(rsagmtdetails.next()){
						bean.setOutdetails("Out :");
						if(rsagmtdetails.getDate("odate")!=null) {
							bean.setRadateout(ragmtdao.getStringDateFormat(rsagmtdetails.getDate("odate"),conn));
						}
						
						bean.setRatimeout(rsagmtdetails.getString("otime"));
						bean.setRaklmout(rsagmtdetails.getString("okm"));
						bean.setRafuelout(objcommon.checkFuelName(conn, rsagmtdetails.getString("ofuel")));
						delivery=rsagmtdetails.getInt("delivery");
						delstatus=rsagmtdetails.getInt("delstatus");
					}
					if(delivery==1 && delstatus==1){
						String  strmov="select v.din, v.tin, round(v.kmin,0) kmin,v.fin from gl_lagmt r inner join gl_vmove v on v.rdocno=r.doc_no and v.rdtype='LAG' and v.status='IN' "
					       		+ " and v.trancode='DL'  and v.doc_no=(select min(doc_no) from gl_vmove where  rdtype='LAG' and status='IN'   "
					       		+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0 and exchng=0 )    where r.delstatus=1 and r.doc_no="+docno+"  and v.repno=0 and v.custno=0 and v.exchng=0";
					    ResultSet rsmov=stmt.executeQuery(strmov);
					    while(rsmov.next()){
					    	bean.setDeldetailss("Delivered :");
					    	if(rsmov.getDate("din")!=null) {
					    		bean.setDeldates(ragmtdao.getStringDateFormat(rsmov.getDate("din"),conn));
					    	}
							
							bean.setDeltimes(rsmov.getString("tin"));
							bean.setDelkmins(rsmov.getString("kmin"));
							bean.setDelfuels(objcommon.checkFuelName(conn, rsmov.getString("fin")));
					    }
					}
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	       conn.close();
	      
	      }
	      return bean;
	}
	
	public String getStringDateFormat(java.sql.Date sqldate, Connection conn) throws SQLException {
		String date = "";
		try {
			Statement stmt = conn.createStatement();
			String str = "select format(cast('" + sqldate + "' as date),'dd.MM.yyyy') date";
			System.out.println(str);
			ResultSet rs = stmt.executeQuery(str);
			while (rs.next()) {
				date = rs.getString("date");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}
	
}
