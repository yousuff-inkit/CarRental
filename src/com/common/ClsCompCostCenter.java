package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;

public class ClsCompCostCenter {
	ClsConnection ClsConnection=new ClsConnection();

	public  JSONArray costCodeSearch(String type) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	  
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
			
				String sql1="select db1,db2 from my_comp";
				
				ResultSet rs = stmtVehclr.executeQuery(sql1);
				
				String db1="";
				String db2="";
				while(rs.next()) {
					db1=rs.getString("db1");
					db2=rs.getString("db2");
			  	}
	        	/* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno,'"+db1+"' db from "+db1+".my_ccentre c1 left join "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0"
	        				+ "union all select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno,'"+db2+"' db from "+db2+".my_ccentre c1 left join "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0 ";
	        		System.out.println("1---------"+sql);
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* AMC & SJOB */
	        	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
	        	{
	        		String dtype="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		String sql="select m.doc_no tr_no,cast(concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) as char(100)) code,cast(concat(if(sd.name is null,'' ,concat(sd.name,' ')),a.refname) as char(100)) name,'"+db1+"' db  from "+db1+".cm_srvcontrm m left join "+db1+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
	        				+ " left join "+db1+".cm_subdivm s on m.tr_no=s.jobdocno left join "+db1+".cm_subdivision sd on sd.doc_no=s.rdocno where m.status=3 and a.status=3 and m.dtype='"+dtype+"'  union all(select m.doc_no tr_no,cast(concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) as char(100)) code,"
	        						+ "cast(concat(if(sd.name is null,'' ,concat(sd.name,' ')),a.refname) as char(100)) name,'"+db2+"' db  from "+db2+".cm_srvcontrm m left join "+db2+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
	        						+ " left join "+db2+".cm_subdivm s on m.tr_no=s.jobdocno left join "+db2+".cm_subdivision sd on sd.doc_no=s.rdocno where m.status=3 and a.status=3 and m.dtype='"+dtype+"') order by tr_no,code";
	        		System.out.println("3,4---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,'"+db1+"' db from "+db1+".cm_cuscallm m left join "+db1+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'"
	        				+ " union all(select m.doc_no,m.doc_no code,a.refname name,'"+db2+"' db from "+db2+".cm_cuscallm m left join "+db2+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG')";
	        		System.out.println("5---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Fleet */
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		String sql="select doc_no,fleet_no code,flname name,reg_no,'"+db1+"' db from "+db1+".gl_vehmaster where cost=0 "
	        				+ " union all (select doc_no,fleet_no code,flname name,reg_no,'"+db2+"' db from "+db2+".gl_vehmaster where cost=0)";
	        		System.out.println("6---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* IJCE */
	        	else if(type.equalsIgnoreCase("7"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project,'"+db1+"' db from "+db1+".is_jobmaster m left join "+db1+".my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join "+db1+".is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE' "
	        				+ "union all (select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project,'"+db2+"' db from "+db2+".is_jobmaster m left join "+db2+".my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join "+db2+".is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE')";
	        		System.out.println("7---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
				/* Contract */
	        	else if(type.equalsIgnoreCase("8"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name,'"+db1+"' db from "+db1+".hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3 "
	        				+ " union all (select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name,'"+db2+"' db from "+db2+".hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3)";
	        		System.out.println("8---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
				
				/* Job Card */
	        	else if(type.equalsIgnoreCase("9"))
	        	{
	        		String sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site,'"+db1+"' db from "+db1+".ws_jobcard M left join "+db1+".ws_estm e on M.refno=e.doc_no and reftype='est' left join "+db1+".ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  "+db1+".my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3) union all select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site,'"+db2+"' db from "+db2+".ws_jobcard M left join "+db2+".ws_estm e on M.refno=e.doc_no and reftype='est' left join "+db2+".ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  "+db2+".my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1";
	        		System.out.println("9---------"+sql);

	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	public  JSONArray costTypeSearch() throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
				
               
				
				String sql="select costtype,costgroup from my_costunit where status=1 ";
        		System.out.println("costypesql---------"+sql);

				ResultSet resultSet = stmtVehclr.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
}
