package com.dashboard.serviceandmaintenance.maintenancereport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMaintenanceReportDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray vehicleDetailsSearch(String id) throws SQLException {
	    JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    Connection conn=null;
	    try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery ("select m.fleet_no,m.flname,m.reg_no,au.authname,pl.code_name,g.gname,convert(concat(' Fleet : ',coalesce(m.FLEET_NO,''),'  ',coalesce(m.FLNAME,''),'  ',coalesce(REG_NO,''),' * ', 'Authority : ',au.authname,'  ', "
			+ " coalesce(pl.code_name,''),' * ', 'YOM : ',coalesce(y.YOM,''),'  * ', 'Color : ',coalesce(c.color,''), ' * ','Salik Tag : ',coalesce(m.SALIK_TAG,''),' * ',   'Exp ',' ','Reg : ',coalesce(DATE_FORMAT(m.REG_EXP ,'%d-%m-%Y'),''),' * ' , "
			+ "'Ins :' ,coalesce(DATE_FORMAT(m.INS_EXP ,'%d-%m-%Y'),''),' * ', 'Insured at : ' ,coalesce(i.inname,''),' * ',    'Last Service  ', 'Date : ',coalesce(DATE_FORMAT(m.SRVC_DTE ,'%d-%m-%Y'),''),' * ','KM :',coalesce(m.SRVC_KM,''),' * ' , "
			+ " 'Warranty ', 'Date :' ,coalesce(DATE_FORMAT(m.WAR ,'%d-%m-%Y'),''),' * ',   'KM :',coalesce(m.WAR_KM,''),' * ',   'Engine No : ' ,coalesce(m.ENG_NO,''),' * ','Chassis No : ',coalesce(m.CH_NO,'')),char(1000)) vehinfo  "
			+ " from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID   left join my_color c on(m.clrid=c.doc_no) left join gl_yom y on y.doc_no=m.yom   "
			+ "  left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl  on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3  order by  m.fleet_no");
			data=objcommon.convertToJSON(rs);
			stmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return data;
	}
	
	public JSONArray getSummaryData(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql11+=" and d.fleet_no="+fleetNo+"";
					sql1+=" and m.fleetno="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select b.fleet_no,b.reg_no,b.flname,b.authname,b.gname,b.code_name,sum(b.lbrcost) labourcost,sum(b.partscost) partscost,"+
						" sum(b.lbrcost)+sum(b.partscost) nettotal,b.yom,b.color from ("+
						" select a.*,v.reg_no,v.flname,au.authname,g.gname,pl.code_name,y.yom,c.color from (" + 
						" select m.date,m.fleetno fleet_no,UCASE(m.mtype) mtype,m.currkm servicekm,m.serduekm nextkm,d.type,d.repdesc description,d.labcost lbrcost,\r\n" + 
						" d.partcost partscost,d.total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
						" gl_garrage g on m.gargid=g.doc_no where m.status=3 "+sql+""+sql1+" UNION ALL\r\n" + 
						" \r\n" + 
						" select m.date,d.fleet_no,'SERVICE' mtype,d.currkm servicekm,d.nextduekm nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
						" if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
						" CHAR(100)) description,d.labourcost lbrcost,d.partcost partscost,(d.labourcost+d.partcost) total,m.remarks,g.name garage from\r\n" + 
						" gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where 1=1"+sql+""+sql11+" ) a\r\n" + 
						" left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehgroup g on g.doc_no=v.VGRPID   left join my_color c on"+
						" (v.clrid=c.doc_no) left join gl_yom  y on y.doc_no=v.yom left join gl_vehauth au on au.doc_no=v.authid  left join"+
						" gl_vehplate pl  on pl.doc_no=v.pltid) b group by b.fleet_no";
				System.out.println("===== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(sql);

				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getSummaryExcelData(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql11+=" and d.fleet_no="+fleetNo+"";
					sql1+=" and m.fleetno="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select b.fleet_no 'Fleet No',b.reg_no 'Reg No',b.flname 'Fleet Name',b.authname 'Authority',b.gname 'Group',b.code_name 'Plate Code',b.color 'Color',b.yom 'Yom',round(sum(b.lbrcost),2) 'Labour Cost',round(sum(b.partscost),2) 'Parts Cost',"+
						" round(sum(b.lbrcost)+sum(b.partscost),2) 'Total' from ("+
						" select a.*,v.reg_no,v.flname,au.authname,g.gname,pl.code_name,y.yom,c.color from (" + 
						" select m.date,m.fleetno fleet_no,UCASE(m.mtype) mtype,m.currkm servicekm,m.serduekm nextkm,d.type,d.repdesc description,d.labcost lbrcost,\r\n" + 
						" d.partcost partscost,d.total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
						" gl_garrage g on m.gargid=g.doc_no where m.status=3 "+sql+""+sql1+" UNION ALL\r\n" + 
						" \r\n" + 
						" select m.date,d.fleet_no,'SERVICE' mtype,d.currkm servicekm,d.nextduekm nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
						" if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
						" CHAR(100)) description,d.labourcost lbrcost,d.partcost partscost,(d.labourcost+d.partcost) total,m.remarks,g.name garage from\r\n" + 
						" gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where 1=1"+sql+""+sql11+" ) a\r\n" + 
						" left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehgroup g on g.doc_no=v.VGRPID   left join my_color c on"+
						" (v.clrid=c.doc_no) left join gl_yom  y on y.doc_no=v.yom left join gl_vehauth au on au.doc_no=v.authid  left join"+
						" gl_vehplate pl  on pl.doc_no=v.pltid) b group by b.fleet_no";
				System.out.println("===== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(sql);

				RESULTDATA=objcommon.convertToEXCEL(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray getDetailData(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql11+=" and d.fleet_no="+fleetNo+"";
					sql1+=" and m.fleetno="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select a.*,v.reg_no from (\r\n" + 
						"select m.voc_no vocno,m.date,m.fleetno fleet_no,UCASE(m.mtype) mtype,m.currkm servicekm,m.serduekm nextkm,d.type,d.repdesc description,d.labcost lbrcost,\r\n" + 
						"d.partcost partscost,d.total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
						"gl_garrage g on m.gargid=g.doc_no where m.status=3 "+sql+""+sql1+" UNION ALL\r\n" + 
						"\r\n" + 
						"select m.voc_no vocno,m.date,d.fleet_no,'SERVICE' mtype,d.currkm servicekm,d.nextduekm nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
						"if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
						"CHAR(100)) description,d.labourcost lbrcost,d.partcost partscost,(d.labourcost+d.partcost) total,m.remarks,g.name garage from\r\n" + 
						"gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where 1=1"+sql+""+sql11+" ) a\r\n" + 
						"left join gl_vehmaster v on a.fleet_no=v.fleet_no order by a.vocno";
				System.out.println("===== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(sql);

				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getDetailExcelData(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql11+=" and d.fleet_no="+fleetNo+"";
					sql1+=" and m.fleetno="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select a.fleet_no 'Fleet No',v.reg_no 'Reg No',date_format(a.date,'%d.%m.%Y') 'Date',a.mtype 'Type',round(a.servicekm,0) "+
				" 'Service KM',round(a.nextkm,0) 'Next Km',a.garage 'Garrage',a.type 'Type',a.description 'Description',a.remarks 'Remarks',"+
				" round(a.lbrcost,2) 'Labour Cost',round(a.partscost,2) 'Parts Cost',round(a.total,2) 'Total' from (\r\n" + 
						"select m.date,m.fleetno fleet_no,UCASE(m.mtype) mtype,m.currkm servicekm,m.serduekm nextkm,d.type,d.repdesc description,d.labcost lbrcost,\r\n" + 
						"d.partcost partscost,d.total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
						"gl_garrage g on m.gargid=g.doc_no where m.status=3 "+sql+""+sql1+" UNION ALL\r\n" + 
						"\r\n" + 
						"select m.date,d.fleet_no,'SERVICE' mtype,d.currkm servicekm,d.nextduekm nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
						"if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
						"CHAR(100)) description,d.labourcost lbrcost,d.partcost partscost,(d.labourcost+d.partcost) total,m.remarks,g.name garage from\r\n" + 
						"gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where 1=1"+sql+""+sql11+" ) a\r\n" + 
						"left join gl_vehmaster v on a.fleet_no=v.fleet_no";
				System.out.println("===== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
}
