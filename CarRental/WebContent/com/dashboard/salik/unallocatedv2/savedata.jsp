 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	String allocatearray[]=request.getParameterValues("allocatearray[]");
	System.out.println("Checking TRANS:"+allocatearray[0]);
	Connection conn=null;
	JSONObject objdata=new JSONObject();
	int errorstatus=0;
	try{
		conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement ();
	 	
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
		int notupdatecount=0;
		int updatecount=0;
        for(int i=0;i<allocatearray.length;i++){
        	String trans=allocatearray[i];
        	String strallocate="update gl_salik s left join gl_vehmaster v1 on v1.salik_tag=s.tagno "
       		+" left join gl_vmove v  on v.fleet_no=v1.fleet_no  and v.rdtype!='vsc' and s.salik_date between cast(concat(v.dout,' ',v.tout) as datetime) and coalesce(cast(concat(din,' ',tin) as datetime),now()) "
       		+" set isallocated=IF(V.EMP_ID IS NULL,0,1),reason=IF(V.EMP_ID IS NULL,'','Allocated') ,ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
       		+" where s.trans='"+trans+"' and s.isallocated=0 and s.status in (0,3)  and v1.fleet_no is not null "+sqlexcludefleets;
   			System.out.println(strallocate);
        	int allocate=stmt.executeUpdate(strallocate);
   			if(allocate<=0){
   				notupdatecount++;
   				System.out.println("Not Updated");
   			}
   			else{
   				updatecount++;
   			}
   			String sqlup="update gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno "+
	 				" set reason='Fleet Not Recognize' where  s.trans='"+trans+"' and isallocated=0 and s.status in (0,3)  and veh.fleet_no is null ";
   			int sqlupdate=stmt.executeUpdate(sqlup);
        }
        objdata.put("updatecount",updatecount);
        objdata.put("notupdatecount",notupdatecount);
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close();
	}
	objdata.put("errorstatus",errorstatus);
	response.getWriter().write(objdata+"");
	
%>
