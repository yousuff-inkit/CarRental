
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.NewSatDownload.SATdownloadActionCosmo"%>
<%@page import="com.NewSatDownload.SATdownloadAction"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno").toString();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
String result="";
String docs="";
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String username="",site="",tagno="";
	String strgetusername="select web.*,base.tagno from ("+
	" select * from gl_salik where regno=(select reg_no from gl_vehmaster where fleet_no="+fleetno+") group by tagno) base left join gl_webid web on base.salik_user=web.username";
	ResultSet rsgetusername=stmt.executeQuery(strgetusername);
	while(rsgetusername.next()){
		username=rsgetusername.getString("username");
		site=rsgetusername.getString("site");
		tagno=rsgetusername.getString("tagno");
	}
	if(username.trim().equalsIgnoreCase("")){
		strgetusername="select * from gl_webid where remarks='Salik' and site='DXB'";
		ResultSet rsgetfirstuser=stmt.executeQuery(strgetusername);
		while(rsgetfirstuser.next()){
			username=rsgetfirstuser.getString("username");
			site=rsgetfirstuser.getString("site");
		}
		String strgettagno="select salik_tag tagno from gl_vehmaster where fleet_no="+fleetno;
		ResultSet rsgettagno=stmt.executeQuery(strgettagno);
		while(rsgettagno.next()){
			tagno=rsgettagno.getString("tagno");
		}
	}
	conn.close();
	SATdownloadActionCosmo satdao=new SATdownloadActionCosmo();
	result=satdao.process("1",username,"salik",site,fleetno,request,session);
	docs=request.getAttribute("xdocs").toString();
	if(docs!=null && !docs.trim().equalsIgnoreCase("0") && !docs.trim().equalsIgnoreCase("")){
		//Allocating downloaded items
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		//Getting Config for blocking Replacement Vehicles in Salik
        int blockreplaced=0;
        String strconfig="select method from gl_config where field_nme='blockSalikReplace'";
        ResultSet rsconfig=stmt.executeQuery(strconfig);
        while(rsconfig.next()){
        	blockreplaced=rsconfig.getInt("method");
        }
        String replacedfleets="(",sqlexcludefleets="";
        if(blockreplaced==1){
        	int i=0;
        	String strgetreplacedfleet="select coalesce(rfleetno,'') rfleetno,coalesce(ofleetno,'') ofleetno from gl_vehreplace where closestatus=0 and status=3";
        	ResultSet rsgetreplacedfleet=stmt.executeQuery(strgetreplacedfleet);
        	while(rsgetreplacedfleet.next()){
        		if(i==0){
            		if(!rsgetreplacedfleet.getString("rfleetno").equalsIgnoreCase("")){
            			replacedfleets+=rsgetreplacedfleet.getString("rfleetno");
            		}
        		}
        		else{
        			if(!rsgetreplacedfleet.getString("rfleetno").equalsIgnoreCase("")){
            			replacedfleets+=","+rsgetreplacedfleet.getString("rfleetno");
            		}
        		}
        		if(!rsgetreplacedfleet.getString("ofleetno").equalsIgnoreCase("")){
        			replacedfleets+=","+rsgetreplacedfleet.getString("ofleetno");
        		}
        		i++;
        	}
        	replacedfleets+=")";
        	if(i>0){
        		sqlexcludefleets+=" and v1.fleet_no not in "+replacedfleets+"";
        	}
        }
        
        //Getting Downloaded Count
        String strgetcount="select count(*) itemcount from gl_salik where doc_no in ("+docs+")";
        ResultSet rsgetcount=stmt.executeQuery(strgetcount);
        while(rsgetcount.next()){
        	result=rsgetcount.getString("itemcount");
        }
        String sqlup="update gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno "+
 				" set reason='Fleet Not Recognize' where  s.tagno="+tagno+" and isallocated=0 and s.status in (0,3)  and veh.fleet_no is null ";
 		int nofleet=stmt.executeUpdate(sqlup);
 		if(nofleet<0){
 			errorstatus=1;
 		}
 		String sqlup1=" update  gl_salik s left join gl_vehmaster v1 on v1.salik_tag=s.tagno "
        		+" left join gl_vmove v  on v.fleet_no=v1.fleet_no  and v.rdtype!='vsc' and s.salik_date between cast(concat(v.dout,' ',v.tout) as datetime) and coalesce(cast(concat(din,' ',tin) as datetime),now()) "
        		+" set isallocated=IF(V.EMP_ID IS NULL,0,1),reason=IF(V.EMP_ID IS NULL,'','Allocated') ,ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
        		+" where s.tagno="+tagno+" and s.isallocated=0 and s.status in (0,3)  and v1.fleet_no is not null "+sqlexcludefleets;
    	System.out.println("==== sqlup1 === "+sqlup1);
        int allocate=stmt.executeUpdate(sqlup1);
    	if(allocate<0){
    		errorstatus=1;
    	}
    	if(errorstatus==0){
    		conn.commit();
    	}
		conn.close();
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(conn.isClosed()==false){
		conn.close();
	}
}
response.getWriter().write(result+"::"+docs);
%>