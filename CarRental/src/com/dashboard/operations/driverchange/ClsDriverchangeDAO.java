package com.dashboard.operations.driverchange;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDriverchangeDAO {
	
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray drvupgrid(String brnchval,String type,String uptodate) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn=null;
        java.sql.Date sqluptodate = null;
     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
     	{
     		sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
     		
     	}
     	else{
     
     	}
     	String branchid="";
     	if(!(brnchval.equalsIgnoreCase("a") || brnchval.equalsIgnoreCase("")  || brnchval.equalsIgnoreCase("0") || brnchval.equalsIgnoreCase("NA")  )) {
     		branchid= "where a.brhid='"+brnchval+"' ";
     	}
     	
     		
     		
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				String sql="";
				if(type.equalsIgnoreCase("1")){
						
					sql="select a.sal_name drname,a.voc_no,a.doc_no,a.date drvdate,a.chktype type,a.drid,a.reg_no,a.refname clname,a.cldocno,a.flname,a.fleet_no,a.brhid  from (\r\n" + 
							"select lag.brhid brhid,'LAG' chktype,veh.fleet_no,convert(lag.voc_no,char(100)) voc_no, lag.doc_no,lag.date,lag.cldocno,lag.drid,sal.sal_name,veh.reg_no,veh.flname,ac.refname from gl_lagmt lag  left join gl_vehmaster veh on  (if(lag.perfleet=0,lag.tmpfleet,lag.perfleet)=veh.fleet_no) left join my_acbook ac on (lag.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salesman sal on (sal.doc_no=lag.drid and sal.sal_type='DRV') left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  where lag.status=3 and lag.clstatus=0 and lag.delstatus=0 and lag.delivery=1 and lag.vehupdate=1 and lag.date<='"+sqluptodate+"' \r\n" + 
							"union all select cus.refbrhid brhid,'VCU' chktype,cus.fleet_no,convert(cus.doc_no,char(100)) voc_no,cus.doc_no,cus.date, cus.cldocno,'' drid,'' sal_name,veh.reg_no,veh.flname,ac.refname from gl_vehcustody cus left join gl_lagmt lag on (lag.doc_no=cus.rdocno and cus.rtype='LAG') left join gl_vehmaster veh on cus.fleet_no=veh.fleet_no left join my_acbook ac on (cus.cldocno=ac.cldocno and ac.dtype='CRM')  left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where cus.status=3 and lag.status=3 and cus.rtype='LAG' and cus.delivery=1 and cus.delstatus is null and cus.date<='"+sqluptodate+"' \r\n" + 
							"union all select r.brhid brhid,'RAG' chktype,r.fleet_no,r.voc_no, r.doc_no,r.date,r.cldocno,convert(r.drid,char(20)) drid,s.sal_name,v.reg_no,v.flname,a.refname from gl_ragmt r  left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' 	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid 	 where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and r.status=3 and r.date<='"+sqluptodate+"'	\r\n" + 
							"union all 	 select c.refbrhid brhid,'VCU' chktype,c.fleet_no,coalesce(c.doc_no,0) voc_no,c.doc_no,c.date,c.cldocno,'' drid,'' sal_name,veh.reg_no,veh.flname,a.refname from gl_vehcustody c left join gl_ragmt ra on ra.doc_no=c.rdocno and c.rtype='RAG'  	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='RAG' and c.delivery=1 and c.delstatus is null and c.date<='"+sqluptodate+"'\r\n" + 
							") a  "+branchid+" ";
				
					}else if(type.equalsIgnoreCase("2")){
						
						sql="select a.* from (select pick.brhid brhid, pick.date drvdate,pick.doc_no as 'voc_no',pick.doc_no doc_no,ac.refname clname,pick.cldocno cldocno,pick.fleet_no,veh.flname,veh.reg_no,pick.agmttype type,pick.drid drid,s.sal_name drname\r\n" + 
							 		"from gl_vehpickup pick left join gl_ragmt ragmt on (pick.agmttype='RAG' and pick.agmtno=ragmt.doc_no) left join gl_lagmt lagmt on (pick.agmttype='LAG' and pick.agmtno=lagmt.doc_no) left join  gl_ragmtclosem rc on rc.agmtno=pick.agmtno and rc.status=3 left join my_acbook ac on (pick.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on pick.fleet_no=veh.fleet_no left join my_salesman s on s.doc_no=pick.drid and s.sal_type='DRV' where pick.status=3 and pick.date <='"+sqluptodate+"'  and rc.agmtno is null )a  "+branchid+"  ";
					
						
					}else if(type.equalsIgnoreCase("3")){

                          sql="select a.* from (select rep.rbrhid brhid,if(rep.rtype='RAG',rag.cldocno,lag.cldocno) cldocno,ac.refname clname,sal.sal_name drname,case when rep.rtype='RAG' then rag.voc_no when rep.rtype='LAG' then lag.voc_no else rep.doc_no end as 'voc_no' , \r\n" + 
								"rep.DELDRVID drid,rep.date drvdate,rep.rtype type,rep.rfleetno fleet_no,inveh.reg_no,rep.doc_no doc_no,rep.REPTYPE,coalesce(inveh.flname,'') flname from gl_vehreplace rep \r\n" + 
								"left join gl_ragmt rag on (rep.rtype='RAG' and rep.rdocno=rag.doc_no)\r\n" + 
								" left join gl_lagmt lag on (rep.rtype='LAG' and rep.rdocno=lag.doc_no) \r\n" + 
								" left join  gl_vehmaster inveh on (rep.rfleetno=inveh.fleet_no) \r\n" + 
								" left join my_salesman sal on (sal.doc_no=rep.DELDRVID and sal.sal_type='DRV')\r\n" + 
								" LEFT JOIN MY_ACBOOK AC ON (CASE WHEN REP.RTYPE='RAG' THEN RAG.CLDOCNO ELSE LAG.CLDOCNO END=AC.CLDOCNO AND AC.DTYPE='CRM')\r\n" + 
								" where rep.status=3 and rep.clstatus=0 and rep.reptype='Collection' AND REP.CANCELSTATUS=0 and rep.date<='"+sqluptodate+"')a "+branchid+" ";
					
					}else if(type.equalsIgnoreCase("4")){
						
						 sql="select a.* from (select n.brhid brhid,n.date drvdate,SAL.SAL_NAME drname ,V.EMP_ID,n.drid,n.doc_no,n.doc_no voc_no ,n.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) type,  coalesce(vm.flname,'') flname from gl_nrm n left join gl_vmove v on v.rdocno=n.doc_no  left join gl_vehmaster vm on (vm.fleet_no=n.fleet_no and vm.statu=3) left join my_salesman sal on (sal.doc_no=N.drid and sal.sal_type='DRV')  where  V.rdtype='MOV' AND N.CLSTATUS=0 and  n.DATE <='"+sqluptodate+"' group by  n.doc_no  order by n.doc_no desc )a "+branchid+" ";
					}else {
						
						sql="select a.sal_name drname,a.voc_no,a.doc_no,a.date drvdate,a.chktype type,a.drid,a.reg_no,a.refname clname,a.cldocno,a.flname,a.fleet_no,a.brhid  from (\r\n" + 
								"select lag.brhid brhid,'LAG' chktype,veh.fleet_no,convert(lag.voc_no,char(100)) voc_no, lag.doc_no,lag.date,lag.cldocno,lag.drid,sal.sal_name,veh.reg_no,veh.flname,ac.refname from gl_lagmt lag  left join gl_vehmaster veh on  (if(lag.perfleet=0,lag.tmpfleet,lag.perfleet)=veh.fleet_no) left join my_acbook ac on (lag.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salesman sal on (sal.doc_no=lag.drid and sal.sal_type='DRV') left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  where lag.status=3 and lag.clstatus=0 and lag.delstatus=0 and lag.delivery=1 and lag.vehupdate=1 and lag.date<='"+sqluptodate+"' \r\n" + 
								"union all select cus.refbrhid brhid,'VCU' chktype,cus.fleet_no,convert(cus.doc_no,char(100)) voc_no,cus.doc_no,cus.date, cus.cldocno,'' drid,'' sal_name,veh.reg_no,veh.flname,ac.refname from gl_vehcustody cus left join gl_lagmt lag on (lag.doc_no=cus.rdocno and cus.rtype='LAG') left join gl_vehmaster veh on cus.fleet_no=veh.fleet_no left join my_acbook ac on (cus.cldocno=ac.cldocno and ac.dtype='CRM')  left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where cus.status=3 and lag.status=3 and cus.rtype='LAG' and cus.delivery=1 and cus.delstatus is null and cus.date<='"+sqluptodate+"' \r\n" + 
								"union all select r.brhid brhid,'RAG' chktype,r.fleet_no,r.voc_no, r.doc_no,r.date,r.cldocno,convert(r.drid,char(20)) drid,s.sal_name,v.reg_no,v.flname,a.refname from gl_ragmt r  left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' 	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid 	 where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and r.status=3 and r.date<='"+sqluptodate+"'	\r\n" + 
								"union all 	 select c.refbrhid brhid,'VCU' chktype,c.fleet_no,coalesce(c.doc_no,0) voc_no,c.doc_no,c.date,c.cldocno,'' drid,'' sal_name,veh.reg_no,veh.flname,a.refname from gl_vehcustody c left join gl_ragmt ra on ra.doc_no=c.rdocno and c.rtype='RAG'  	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='RAG' and c.delivery=1 and c.delstatus is null and c.date<='"+sqluptodate+"'\r\n" + 
								") a  "+branchid+" ";
					}
				//System.out.println("--grid load--"+sql);
					
        		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
					
        	conn.close();
        }
		catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}


	
	public JSONArray getdriverdetails() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn=null;
     	
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				String sqldrv="select doc_no ,sal_name from my_salesman where status=3 and sal_type='DRV'";
				
				//System.out.println("--driver search--"+sqldrv);
					
        		ResultSet resultSet = stmtVeh.executeQuery(sqldrv);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
					
        	conn.close();
        }
		catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}


	public JSONArray getAgmtno(String client,String mobile,String rentalno,String fleetno,String regno,String mrano,String agmttype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(agmttype.equalsIgnoreCase("")){
			return RESULTDATA;
		}
		Connection conn=null;
		
		try{
			conn=ClsConnection.getMyConnection();
			String sqltest="";
			String strsql="";
			
			if(agmttype.equalsIgnoreCase("RAG")){
				if(!(client.equalsIgnoreCase("") || client.equalsIgnoreCase("0") )){
		    		sqltest=sqltest+" and a.RefName like '%"+client+"%'";
		    	}
		    	if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and a.per_mob like '%"+mobile+"%'";
		    	}
		    	if(!(rentalno.equalsIgnoreCase("") || rentalno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and r.voc_no like '%"+rentalno+"%'";
		    	}
		    	if(!(fleetno.equalsIgnoreCase("") || fleetno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and r.fleet_no like '%"+fleetno+"%'";
		    	}
		    	if(!(regno.equalsIgnoreCase("") || regno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
		    	}
		    	if(!(mrano.equalsIgnoreCase("") || mrano.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and r.mrano like '%"+mrano+"%'";
		    	}
		    	
		    	strsql="select r.doc_no,r.voc_no,r.fleet_no,r.cldocno, "
						+ " r.mrano,v.reg_no,a.RefName,a.per_mob from gl_ragmt r  "
						+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'  "
						+ " where r.status=3 and r.clstatus=0 and r.delivery=0 "  +sqltest+""; 
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				if(!(client.equalsIgnoreCase("") || client.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and a.RefName like '%"+client+"%'";
		    	}
		    	if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and a.per_mob like '%"+mobile+"%'";
		    	}
		    	if(!(rentalno.equalsIgnoreCase("") || rentalno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and r.voc_no like '%"+rentalno+"%'";
		    	}
		    	if(!(fleetno.equalsIgnoreCase("") || fleetno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and coalesce(r.tmpfleet,r.perfleet) like '%"+fleetno+"%'";
		    	}
		    	if(!(regno.equalsIgnoreCase("") || regno.equalsIgnoreCase("0"))){
		    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
		    	}
		    	strsql="select r.doc_no,r.voc_no,if(r.perfleet<>0,r.perfleet,r.tmpfleet) fleet_no,r.cldocno, v.reg_no,a.RefName,a.per_mob from gl_lagmt r"+
		    			" left join gl_vehmaster v on v.fleet_no=if(r.perfleet<>0,r.perfleet,r.tmpfleet) left join my_acbook a on a.cldocno= r.cldocno and"+
		    			" a.dtype='CRM' where r.status=3 and r.clstatus=0 and r.delivery=0 "+sqltest;
			}
			Statement stmt=conn.createStatement();
			ResultSet resultSet = stmt.executeQuery (strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
            


            

}
