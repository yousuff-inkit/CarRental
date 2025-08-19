package com.operations.setup.questionnaire;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsquestionnaireDAO {
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	
	public int insert(java.sql.Date date,String txtquestion,int txtdocno,String txttype,int serviceid,int chkbx,ArrayList arr,HttpSession session,HttpServletRequest request,String mode,String formcode) throws SQLException{
		
		Connection conn=null;
		int docNo=0;
		int vocno=0;
		int tranid=0;
		try{

			String modifiedStringtxtquestion = txtquestion.replaceAll("[^a-zA-Z0-9/.+\\s+\\s-\\s:\\s*\\s@\\s\\&\\s%\\s(\\s)\\s;\\s_\\s,\\s#\\s]", " ").replaceAll("\\r?\\n|\\r", " ").replaceAll("\t"," "); // Replace all non-alphanumeric characters and spaces with ""

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL QuestionnaireDML(?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,modifiedStringtxtquestion);
			stmt.setInt(3, txtdocno);
			stmt.setString(4, mode);
			stmt.setString(5, formcode);
			stmt.setString(6, session.getAttribute("BRANCHID").toString());
			stmt.setString(7, session.getAttribute("USERID").toString());
			stmt.setInt(8, serviceid);
			stmt.setInt(9, chkbx);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			//vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< arr.size();i++){
					CallableStatement stmtPolicy=null;
					String[] arrdet=((String) arr.get(i)).split("::");
					if(!(arrdet[0].trim().equalsIgnoreCase("undefined")|| arrdet[0].trim().equalsIgnoreCase("NaN")||arrdet[0].trim().equalsIgnoreCase("")|| arrdet[0].isEmpty()))
					{
						stmtPolicy = conn.prepareCall("INSERT INTO in_Questionnaired(rdocno, srno, answer, points) VALUES(?,?,?,?)");
						stmtPolicy.setInt(1,docNo);
						stmtPolicy.setInt(2, i+1);
						stmtPolicy.setString(3,(arrdet[0].trim().equalsIgnoreCase("undefined") || arrdet[0].trim().equalsIgnoreCase("NaN")|| arrdet[0].trim().equalsIgnoreCase("")|| arrdet[0].isEmpty()?0:arrdet[0].trim()).toString());
						stmtPolicy.setString(4,(arrdet[1].trim().equalsIgnoreCase("undefined") || arrdet[1].trim().equalsIgnoreCase("NaN")|| arrdet[1].trim().equalsIgnoreCase("")|| arrdet[1].isEmpty()?0:arrdet[1].trim()).toString());
						//System.out.println("sql=="+stmtPolicy);
						int resultSet2 = stmtPolicy.executeUpdate();
						
						
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						
					}

				}

				
			}

		
		if (docNo > 0) {
			conn.commit();
			stmt.close();
			conn.close();
			return docNo; 
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return 0;
	}             
	public boolean edit(java.sql.Date date,int docno,String txtquestion,int txtdocno,String txttype,int serviceid,int chkbx,ArrayList arr,HttpSession session,HttpServletRequest request,String mode,String formcode) throws SQLException{
		Connection conn=null;
		try{   
			conn=conobj.getMyConnection();     
			conn.setAutoCommit(false);   
			
		
			Statement stmt = conn.createStatement();
			CallableStatement stmtQues = conn.prepareCall("{CALL QuestionnaireDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtQues.setInt(10, docno);
			stmtQues.setDate(1,date);   
			stmtQues.setString(2,txtquestion);
			stmtQues.setInt(3, txtdocno);
			stmtQues.setString(4, mode);
			stmtQues.setString(5, formcode);
			stmtQues.setString(6, session.getAttribute("BRANCHID").toString());
			stmtQues.setString(7, session.getAttribute("USERID").toString());
			stmtQues.setInt(8, serviceid);
			stmtQues.setInt(9, chkbx);
			int aaa=stmtQues.executeUpdate();
			
			docno=stmtQues.getInt("docNo");
			if(docno>0){  


				
					String str="delete from in_Questionnaired where rdocno='"+docno+"'";
					stmt.executeUpdate(str);
				for(int i=0;i< arr.size();i++){
				
					CallableStatement stmtPolicy=null;
					String[] arrdet=((String) arr.get(i)).split("::");
					if(!(arrdet[0].trim().equalsIgnoreCase("undefined")|| arrdet[0].trim().equalsIgnoreCase("NaN")||arrdet[0].trim().equalsIgnoreCase("")|| arrdet[0].isEmpty()))
					{       
						stmtPolicy = conn.prepareCall("INSERT INTO in_Questionnaired(rdocno, srno, answer, points) VALUES(?,?,?,?)");
						stmtPolicy.setInt(1,docno);
						stmtPolicy.setInt(2, i+1);
						stmtPolicy.setString(3,(arrdet[0].trim().equalsIgnoreCase("undefined") || arrdet[0].trim().equalsIgnoreCase("NaN")|| arrdet[0].trim().equalsIgnoreCase("")|| arrdet[0].isEmpty()?0:arrdet[0].trim()).toString());
						stmtPolicy.setString(4,(arrdet[1].trim().equalsIgnoreCase("undefined") || arrdet[1].trim().equalsIgnoreCase("NaN")|| arrdet[1].trim().equalsIgnoreCase("")|| arrdet[1].isEmpty()?0:arrdet[1].trim()).toString());
						int resultSet2 = stmtPolicy.executeUpdate();
						if(resultSet2<=0)
						{
							conn.close();
							return false;
						}
						
					}

				}

			}
			if(aaa<=0){  

				return false;

			}
			if (aaa > 0) {
				conn.commit();
				stmt.close();
				conn.close();
				return true;  
			}	
		}catch(Exception e){	
			e.printStackTrace();   
			conn.close();
			}
		finally{
			conn.close();
		}
		return false;
	}

public boolean delete(java.sql.Date date,int docno,String txtquestion,int txtdocno,String txttype,ArrayList arr,HttpSession session,HttpServletRequest request,String mode,String formcode) throws SQLException{
	Connection conn=null;   
	try{   
		conn=conobj.getMyConnection();  
		 Statement stmt =conn.createStatement(); 
	  
				String sql2="update in_Questionnairem set STATUS='7' where  doc_no='"+docno+"'";
				//System.out.println("sql2==delete=="+sql2);
				int val2 = stmt.executeUpdate(sql2);   
		     
		
		if (val2 > 0) {
			stmt.close();
			conn.close();
			return true; 
		}	
	}catch(Exception e){	
		e.printStackTrace();
		conn.close();
		}
	finally{
		conn.close();
	}
	return false;
	
					

}

public    JSONArray searchMaster(HttpSession session,String msdocno,String enqdate,String aa) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();
	Enumeration<String> Enumeration = session.getAttributeNames();
	int a=0;
	while(Enumeration.hasMoreElements()){
		if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
			a=1;
		}
	}
	if(a==0){
		return RESULTDATA;
	}

	//  System.out.println("8888888888"+clnames); 	
	String brid=session.getAttribute("BRANCHID").toString();



	java.sql.Date sqlStartDate=null;


	//enqdate.trim();
	if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
	{
		sqlStartDate = com.changeStringtoSqlDate(enqdate);
	}






	String sqltest="";
	if(!(msdocno.equalsIgnoreCase(""))){
		sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
	}
	
	if(!(sqlStartDate==null)){
		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	} 



	Connection conn = null;

	try {
		conn = conobj.getMyConnection();
		Statement stmtenq1 = conn.createStatement ();
		if(aa.equalsIgnoreCase("yes"))
		{
		String clssql= "select m.chkbx,m.doc_no,m.date, m.userid ,m.questionnaire "
				+ " from in_Questionnairem m  where m.status=3" +sqltest;
		//System.out.println("===master search====="+clssql);
		ResultSet resultSet = stmtenq1.executeQuery(clssql);
		RESULTDATA=com.convertToJSON(resultSet);
		}
	
		
		
		stmtenq1.close();
		conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;
}

	
	public JSONArray typeSearch(HttpSession session) throws SQLException{
		


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,name from in_questtype where status=3";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public  JSONArray indGridLoad(HttpSession session,String docno) throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
		 Connection conn=null;
			try {
				conn = conobj.getMyConnection();
			    Statement stmt =conn.createStatement();  
				String sql="";    
				sql="select  answer, points  from in_questionnaired where rdocno="+docno+"";
					//System.out.println("sql==="+sql);   
					ResultSet resultSet = stmt.executeQuery (sql);   
					RESULTDATA=com.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	public  JSONArray searchservice() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=conobj.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	// String sqldata="select doc_no,groupname from my_groupvals ";
            	String sqldata=" select 0 doc_no,'Client Info' groupname union all SELECT DOC_NO,NAME groupname FROM IN_SERVICETYPE WHERE STATUS=3";
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=com.convertToJSON(resultSet);
				
				stmtVeh1.close();
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
        return RESULTDATA;
    }
	public   ClsQuestionnaireBean getViewDetails(int docno) throws SQLException {
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
		ClsQuestionnaireBean bean = new ClsQuestionnaireBean();
		Connection conn = null;
		try {
			conn=conobj.getMyConnection();
			Statement stmtMove = conn.createStatement ();
			int i=0;
        	String strSql="";
        	strSql="select chkbx,s.doc_no serdocno,s.name groupname,m.doc_no,t.name type,d.answer,d.points,m.date,typeid,questionnaire "
        			+ " from in_questionnairem m left join in_questionnaired d on d.rdocno=m.doc_no "
        			+ " left join in_questtype t on t.doc_no=m.typeid left join IN_SERVICETYPE s on s.doc_no=m.servicetypeid "
        			+ " where m.doc_no="+docno+"";
        //	System.out.println("viewdetailsss"+strSql);
			ResultSet resultSet = stmtMove.executeQuery (strSql);
			while(resultSet.next()){
				//bean.setDate(resultSet.getString("date"));
				//bean.setTxtdocno(resultSet.getInt("typeid"));   
				bean.setTxtquestion(resultSet.getString("questionnaire"));
				bean.setChkcomagent(resultSet.getInt("chkbx"));
				bean.setServicedocno(resultSet.getInt("serdocno"));
				bean.setServicetype(resultSet.getString("groupname"));
				//bean.setTxttype(resultSet.getString("type"));     
				bean.setDocno(resultSet.getInt("doc_no"));
			}
			stmtMove.close();
			conn.close();
			
		}  
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
        return bean;
	}
}
