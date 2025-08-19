package com.controlcentre.masters.vehiclemaster.vehtype;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehTypeDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getVehTypeData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select name,doc_no,date from gl_vehtype where status<>7";
			ResultSet rs=stmt.executeQuery(str);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getVehTypeDataDrid(String id, String chk) throws SQLException{
		JSONArray data=new JSONArray();
		if(!chk.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="SELECT rowno, coalesce(axle,'') name,tyre FROM gl_vehtyped d LEFT JOIN gl_vehtype m ON m.doc_no = d.rdocno WHERE d.rdocno="+id+" AND d.status<>7  ORDER BY sr_no ASC";
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public int insert(String name,java.sql.Date date, HttpSession session,String mode,String formdetailcode, ArrayList<String> deptarray) throws SQLException {
		Connection conn=null;
		try{
			//deptarray.forEach(e->System.out.println(e));
			conn=objconn.getMyConnection();
			int aaa=0;
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select * from gl_vehtype where status<>7 and name='"+name+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
			stmtAuth.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtAuth.setString(1,name);
			stmtAuth.setString(2,date.toString());
			stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
			stmtAuth.setString(4,session.getAttribute("USERID").toString());
			stmtAuth.setString(6,mode);
			stmtAuth.setString(7, formdetailcode);
			stmtAuth.executeQuery();
			aaa=stmtAuth.getInt("docNo");
			if (aaa > 0) {
				for (int i = 0; i < deptarray.size(); i++) {
					String[] cparray = ((String) deptarray.get(i)).split("::");
					int resultSettcl = 0;
					String tclsql = "";
					tclsql = "INSERT INTO gl_vehtyped(rdocno, sr_no, axle, tyre) values('" + aaa + "'," + "'"
							+ (i+1) + "'," + "'"
							+ (cparray[0].trim().equalsIgnoreCase("undefined") || cparray[0] == null
									|| cparray[0].trim().equalsIgnoreCase("")
									|| cparray[0].trim().equalsIgnoreCase("NaN") || cparray[0].isEmpty() ? "0"
											: cparray[0].trim())
							+ "'," + "'"
							+ (cparray[1].equalsIgnoreCase("undefined") || cparray[1] == null
									|| cparray[1].equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")
									|| cparray[1].isEmpty() ? "0" : cparray[1].trim())
							+ "')";

					System.out.println("==tclsql===+" + tclsql);

					resultSettcl = stmtTest.executeUpdate(tclsql);
					if (resultSettcl <= 0) {
						conn.close();
						return 0;
					}

				}
			}
			
			
			if (aaa > 0) {
				conn.commit();
				return aaa;
			}
		}
		catch(Exception e){	
			e.printStackTrace();	
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}
	
	public int edit(int docno, java.sql.Date date,String name,HttpSession session,String mode,String formdetailcode, ArrayList<String> deptarray, String deletedRows) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select * from gl_vehtype where status<>7 and name='"+name+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
			stmtAuth.setInt(5,docno);
			stmtAuth.setString(1,name);
			stmtAuth.setDate(2,date);
			stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
			stmtAuth.setString(4,session.getAttribute("USERID").toString());
			stmtAuth.setString(6,mode);
			stmtAuth.setString(7, formdetailcode);
			int aa = stmtAuth.executeUpdate();
			if (aa>0) {
				for (int i = 0; i < deptarray.size(); i++) {
					String[] cparray = ((String) deptarray.get(i)).split("::");
					int resultSettcl = 0;
					String tclsql = "";
					if(cparray[2].trim().equalsIgnoreCase("") || cparray[2].equalsIgnoreCase("undefined") ||  cparray[2].isEmpty() || cparray[2] == null) {
					String maxsrno = "SELECT MAX(COALESCE(sr_no,0))+1 srno FROM gl_vehtyped WHERE rdocno="+docno;
					int srno = 0;
					ResultSet rs = stmtTest.executeQuery(maxsrno);
					if (rs.next()) {
						srno = rs.getInt("srno");
					}
					
					tclsql = "INSERT INTO gl_vehtyped(rdocno, sr_no, axle, tyre) values('" + docno + "'," + "'"
							+ srno + "'," + "'"
							+ (cparray[0].trim().equalsIgnoreCase("undefined") || cparray[0] == null
									|| cparray[0].trim().equalsIgnoreCase("")
									|| cparray[0].trim().equalsIgnoreCase("NaN") || cparray[0].isEmpty() ? "0"
											: cparray[0].trim())
							+ "'," + "'"
							+ (cparray[1].equalsIgnoreCase("undefined") || cparray[1] == null
									|| cparray[1].equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")
									|| cparray[1].isEmpty() ? "0" : cparray[1].trim())
							+ "')";
					} else {
						tclsql = "update gl_vehtyped set axle='"+(cparray[0].trim().equalsIgnoreCase("undefined") || cparray[0] == null
								|| cparray[0].trim().equalsIgnoreCase("")
								|| cparray[0].trim().equalsIgnoreCase("NaN") || cparray[0].isEmpty() ? "0"
										: cparray[0].trim())+"', tyre='"+ (cparray[1].equalsIgnoreCase("undefined") || cparray[1] == null
										|| cparray[1].equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")
										|| cparray[1].isEmpty() ? "0" : cparray[1].trim())+"' where rowno='"+(cparray[2].equalsIgnoreCase("undefined") || cparray[2] == null
										|| cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")
										|| cparray[2].isEmpty() ? "0" : cparray[2].trim())+"' and rdocno="+docno;
					}
					System.out.println("==tclsql===+" + tclsql);

					resultSettcl = stmtTest.executeUpdate(tclsql);
					if (resultSettcl <= 0) {
						conn.close();
						return 0;
					}
					
					if(deletedRows.length()>0) {
						System.out.println("Entered");
						tclsql = "update gl_vehtyped set status=7 where rowno in ("+deletedRows.substring(0, deletedRows.length() - 1)+")";
						resultSettcl = stmtTest.executeUpdate(tclsql);
						if (resultSettcl <= 0) {
							conn.close();
							return 0;
						}
					}
					
					

				}
			}
			if (aa>0) {
				conn.commit();
				return aa;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}


public int delete(int docno, java.sql.Date date, String name,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);		
		Statement stmtTest=conn.createStatement ();
		String testsql2="select * from gl_vehtype b inner join gl_vehmodel m on m.vehtypeid=b.doc_no where b.name='"+name+"'";
		ResultSet resultSet2 = stmtTest.executeQuery (testsql2);
		if(resultSet2.next()){
			return -2;
		}
		CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
		stmtAuth.setInt(5,docno);
		stmtAuth.setString(1,name);
		stmtAuth.setDate(2,date);
		stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
		stmtAuth.setString(4,session.getAttribute("USERID").toString());
		stmtAuth.setString(6,mode);
		stmtAuth.setString(7, formdetailcode);
		int aa = stmtAuth.executeUpdate();
		if (aa>0) {
			conn.commit();
			return aa;
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	return 0;
}

}
