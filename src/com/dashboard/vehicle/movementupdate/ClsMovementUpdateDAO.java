package com.dashboard.vehicle.movementupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMovementUpdateDAO 


{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public boolean updateReplacement(int repno,Connection conn,String movdocno,String movstatus,String movtrancode) throws SQLException{
		try {
			Statement stmt=conn.createStatement();
			String strrepdet="select reptype,coalesce(delstatus,0) delstatus,coalesce(clstatus,0) collectstatus,coalesce(closestatus,0) closestatus from gl_vehreplace where status=3 and doc_no="+repno;
			String reptype="";
			int delstatus=0,collectstatus=0,closestatus=0;
			ResultSet rsrepdet=stmt.executeQuery(strrepdet);
			while(rsrepdet.next()) {
				reptype=rsrepdet.getString("reptype");
				delstatus=rsrepdet.getInt("delstatus");
				collectstatus=rsrepdet.getInt("collectstatus");
				closestatus=rsrepdet.getInt("closestatus");
			}
			int errorstatus=0;
			if(reptype.equalsIgnoreCase("atbranch")) {
				String strmov="select * from gl_vmove where repno="+repno+" order by doc_no";
				int rowcount=0;
				ResultSet rsmov=stmt.executeQuery(strmov);
				while(rsmov.next()) {
					String strupdaterep="";
					if(rowcount==0 && rsmov.getString("status").trim().equalsIgnoreCase("IN")) {
						//Updating In Details
						java.sql.Date sqlindate=rsmov.getDate("din");
						String intime=rsmov.getString("tin");
						String inkm=rsmov.getString("kmin");
						String infuel=rsmov.getString("fin");
						String inbranch=rsmov.getString("ibrhid");
						String inlocation=rsmov.getString("ilocid");
						strupdaterep="update gl_vehreplace set indate='"+sqlindate+"',intime='"+intime+"',inkm="+inkm+",infuel="+infuel+",inbrhid="+inbranch+",inloc="+inlocation+" where doc_no="+repno;
						int updaterep=conn.createStatement().executeUpdate(strupdaterep);
						if(updaterep<=0) {
							System.out.println("vmove Update Error on in details update");
							errorstatus=1;
							return false;
						}
					}
					else if(rowcount==1 && rsmov.getString("status").trim().equalsIgnoreCase("OUT")) {
						//Updating Out Details
						java.sql.Date sqloutdate=rsmov.getDate("dout");
						String outtime=rsmov.getString("tout");
						String outkm=rsmov.getString("kmout");
						String outfuel=rsmov.getString("fout");
						String outbranch=rsmov.getString("obrhid");
						String outlocation=rsmov.getString("olocid");
						strupdaterep="update gl_vehreplace set odate='"+sqloutdate+"',otime='"+outtime+"',okm="+outkm+",ofuel="+outfuel+",obrhid="+outbranch+",olocid="+outlocation+" where doc_no="+repno;
						int updaterep=conn.createStatement().executeUpdate(strupdaterep);
						if(updaterep<=0) {
							System.out.println("vmove Update Error on out details update");
							errorstatus=1;
							return false;
						}
					}
					rowcount++;
				}
			}
			else if(reptype.equalsIgnoreCase("collection")) {
				String strmov="select * from gl_vmove where repno="+repno+" order by doc_no";
				int rowcount=0;
				ResultSet rsmov=stmt.executeQuery(strmov);
				while(rsmov.next()) {
					String strupdaterep="";
					if(rowcount==0 && rsmov.getString("status").trim().equalsIgnoreCase("IN")) {
						//Updateing Collection Details
						if(collectstatus==1) {
							java.sql.Date sqloutdate=rsmov.getDate("dout");
							String outtime=rsmov.getString("tout");
							String outkm=rsmov.getString("kmout");
							String outfuel=rsmov.getString("fout");
							strupdaterep="update gl_vehreplace set cldate='"+sqloutdate+"',cltime='"+outtime+"',clkm="+outkm+",clfuel="+outfuel+" where doc_no="+repno;
							int updaterep=conn.createStatement().executeUpdate(strupdaterep);
							if(updaterep<=0) {
								System.out.println("vmove Update Error on collection details update");
								errorstatus=1;
								return false;
							}
						}
						if(closestatus==1) {
							java.sql.Date sqlindate=rsmov.getDate("din");
							String intime=rsmov.getString("tin");
							String inkm=rsmov.getString("kmin");
							String infuel=rsmov.getString("fin");
							String inbranch=rsmov.getString("ibrhid");
							String inlocation=rsmov.getString("ilocid");
							strupdaterep="update gl_vehreplace set indate='"+sqlindate+"',intime='"+intime+"',inkm="+inkm+",infuel="+infuel+",inbrhid="+inbranch+",inloc="+inlocation+" where doc_no="+repno;
							int updaterep=conn.createStatement().executeUpdate(strupdaterep);
							if(updaterep<=0) {
								System.out.println("vmove Update Error on in details update");
								errorstatus=1;
								return false;
							}
						}
					}
					else if(rowcount==1 && rsmov.getString("status").trim().equalsIgnoreCase("IN")) {
						java.sql.Date sqloutdate=rsmov.getDate("dout");
						String outtime=rsmov.getString("tout");
						String outkm=rsmov.getString("kmout");
						String outfuel=rsmov.getString("fout");
						String outbranch=rsmov.getString("obrhid");
						String outlocation=rsmov.getString("olocid");
						strupdaterep="update gl_vehreplace set odate='"+sqloutdate+"',otime='"+outtime+"',okm="+outkm+",ofuel="+outfuel+",obrhid="+outbranch+",olocid="+outlocation+" where doc_no="+repno;
						int updaterep=conn.createStatement().executeUpdate(strupdaterep);
						if(updaterep<=0) {
							System.out.println("vmove Update Error on out details update");
							errorstatus=1;
							return false;
						}
						
						if(delstatus==1) {
							java.sql.Date sqlindate=rsmov.getDate("din");
							String intime=rsmov.getString("tin");
							String inkm=rsmov.getString("kmin");
							String infuel=rsmov.getString("fin");
							strupdaterep="update gl_vehreplace set deldate='"+sqlindate+"',deltime='"+intime+"',delkm="+inkm+",delfuel="+infuel+" where doc_no="+repno;
							int updaterepdel=conn.createStatement().executeUpdate(strupdaterep);
							if(updaterepdel<=0) {
								System.out.println("vmove Update Error on in details update");
								errorstatus=1;
								return false;
							}
						}
					}
					rowcount++;
				}
			}
			if(errorstatus==0) {
				return true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			
		}
		return false;
	}
	public JSONArray searchmovement(String fleetno,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     
        
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
		        java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
			
			String sqldata=("select v.rdocno vmrdocno,convert(coalesce(v.fout,''),char(30)) hidfout,convert(coalesce(v.fin,''),char(30)) hidfin, "
					+ " v.doc_no,CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as "
					+ "  'rdocno' ,v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,  coalesce(vm.flname,'') flname  "
					+ "  ,coalesce(v.status,'') status, coalesce(s.st_desc,'') trancode,  "
					+ " convert(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout,  "
					+ "   CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125'  "
					+ "  THEN 'Level 1/8' WHEN v.fout='0.250'  THEN 'Level 2/8' WHEN v.fout='0.375'     THEN 'Level 3/8'  "
					+ "   WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8'   WHEN v.fout='0.750'  "
					+ "   THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8'  "
					+ "    END as 'Fout' ,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin, "
					+ "  CONVERT(coalesce(round(kmin),''),char(30)) kmin,    CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  "
					+ " WHEN v.fin='0.125'    THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375'   THEN 'Level 3/8'  "
					+ "  WHEN v.fin='0.500'    THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750' "
					+ "      THEN 'Level 6/8' WHEN v.fin='0.875'    THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8'  END as 'FIN'  "
					+ "  from gl_vmove v left join gl_status s    on(v.trancode=s.status) left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG'  "
					+ "    left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG'    left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no and vm.statu=3)  "
					+ " where  v.rdtype!='VEH' and  v.fleet_no='"+fleetno+"' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc "); 
			
			
			//System.out.println("---sqldata-----"+sqldata);

			
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	

}
