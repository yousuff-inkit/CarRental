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
	String saveval=request.getParameter("saveval");
	String tagno = request.getParameter("tagno")==null?"0":request.getParameter("tagno");
	String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
	 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String hidchkdate = request.getParameter("hidchkdate")==null?"0":request.getParameter("hidchkdate").trim();
	 String uptodate=request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
	 String saliktype=request.getParameter("saliktype")==null?"":request.getParameter("saliktype");
	Date uptosqldate=ClsCommon.changeStringtoSqlDate(uptodate); 
	Date fromsqldate=ClsCommon.changeStringtoSqlDate(fromdate); 
	String branchid = session.getAttribute("BRANCHID")==null || session.getAttribute("BRANCHID").equals("")?"1":"1";

		String sqltest="",sqltest1="";
		if(hidchkdate.equalsIgnoreCase("1")) {
     		sqltest=sqltest+" and s.sal_date>='"+fromsqldate+"' ";
     		sqltest1=sqltest1+" and s.sal_date>='"+fromsqldate+"' ";
     	}
		
		if(!(tagno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.tagno='"+tagno+"'";
		}
		if(!(regno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.regno='"+regno+"' ";
		}
		if(!(saliktype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.type='"+saliktype+"' ";
		}
	 		String upsql=null;

	 		int val=0;
 			Connection conn = null;

			ArrayList<String> rowValues= new ArrayList<String>();
	
	 try{
		 	conn = ClsConnection.getMyConnection();
		 	Statement stmt = conn.createStatement ();
		 	
 			/* String sql=" select s.tagno,min(s.salik_date) salik_date,s.trans,veh.fleet_no from gl_salik s "
 			 +" left join gl_vehmaster veh on veh.salik_tag=s.tagno "
 			+" where  s.isallocated=0 and s.status in (0,3)  and veh.fleet_no is not null "+sqltest+" group by regno ";  
			ResultSet rs = stmt.executeQuery(sql);
		     while(rs.next()) 
		     	{
		    	 rowValues.add(rs.getString("fleet_no")+" :: "+rs.getString("tagno")+" :: "+rs.getTimestamp("salik_date")+" :: "+rs.getString("trans"));
				} 
		     
			for(int i=0;i<rowValues.size();i++)
				{
		
		 			String[] subarray=rowValues.get(i).split("::");	
					 saveval="11";
					 
					 String sqlup1=" update  gl_vmove v left join gl_vehmaster v1 on v.fleet_no=v1.fleet_no "
						+" left join gl_salik s on v1.salik_tag=s.tagno and s.salik_date between v.dout and coalesce(v.din,now()) "
						+"  set isallocated=1,reason='Allocated',ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no   "
						+"   where v1.statu=3 and v.fleet_no='"+subarray[0].trim()+"' and s.salik_date is not null and s.isallocated=0 and s.status in (0,3) ";
				 	stmt.executeUpdate(sqlup1);
				 	
	            }// for close */
	            
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
	            	saveval="11";
	            	session.setAttribute("SALIKALLOCATECOUNT",0);
	            	String strsalikallocatecount=session.getAttribute("SALIKALLOCATECOUNT")==null || session.getAttribute("SALIKALLOCATECOUNT")=="" || session.getAttribute("SALIKALLOCATECOUNT")=="undefined"?"0":session.getAttribute("SALIKALLOCATECOUNT").toString();
	            	int salikallocatecount=Integer.parseInt(strsalikallocatecount);
	            	//Getting Reg No for Unallocated
	            	ArrayList<String> regnoarray=new ArrayList();
	            	String strgetregno="select regno,cust_plate from gl_salik s where s.sal_date<='"+uptosqldate+"' "+sqltest+" and s.isallocated=0 and s.status in (0,3) group by regno,cust_plate";
	            			ResultSet rsgetregno=stmt.executeQuery(strgetregno);
	            	while(rsgetregno.next()){
	            		regnoarray.add(rsgetregno.getString("regno")+"::"+rsgetregno.getString("cust_plate"));
	            	}
	            	for(int i=0;i<regnoarray.size();i++){
						String localregno=regnoarray.get(i).split("::")[0];
						String localplate=regnoarray.get(i).split("::")[1];
	            		String strlocalplate="";
	            		if(localplate==null || localplate.equalsIgnoreCase("null")){
	            			strlocalplate=" and s.cust_plate is null";
	            		}
	            		else{
	            			strlocalplate=" and s.cust_plate='"+localplate+"'";
	            		}
						/*String sqlup1=" update  gl_salik s INNER join gl_vehmaster v1 on v1.salik_tag=s.tagno and v1.statu=3"
			            		+" INNER join gl_vmove v  on v.fleet_no=v1.fleet_no  and v.rdtype!='vsc' and s.salik_date between cast(concat(v.dout,' ',v.tout) as datetime) and coalesce(cast(concat(din,' ',tin) as datetime),now()) "
			            		+" set isallocated=IF(V.EMP_ID IS NULL,0,1),reason=IF(V.EMP_ID IS NULL,'','Allocated') ,ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
			            		+" where s.sal_date<='"+uptosqldate+"' and s.isallocated=0 and s.status in (0,3) and s.regno='"+localregno+"' "+strlocalplate+" and v1.fleet_no is not null   "+sqltest+" "+sqlexcludefleets;
			        */
			        
			        // datetime error coming so added time_format for tout,tin 
			        
			        String sqlup1=" update  gl_salik s INNER join gl_vehmaster v1 on v1.salik_tag=s.tagno and v1.statu=3"
		            		+" INNER join gl_vmove v  on v.fleet_no=v1.fleet_no  and v.rdtype!='vsc' and s.salik_date between  cast(concat(v.dout,' ',TIME_FORMAT(v.tout,'%H:%i:%s')) as datetime) and coalesce(cast(concat(din,' ',if(tin is null,'',TIME_FORMAT(tin,'%H:%i:%s'))) as datetime),now()) "
		            		+" set isallocated=IF(V.EMP_ID IS NULL,0,1),reason=IF(V.EMP_ID IS NULL,'','Allocated') ,ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
		            		+" where s.sal_date<='"+uptosqldate+"' and s.isallocated=0 and s.status in (0,3) and s.regno='"+localregno+"' "+strlocalplate+" and v1.fleet_no is not null   "+sqltest+" "+sqlexcludefleets;
		        						
			        
			        // System.out.println("==== sqlup1 === "+sqlup1);
			        	int update=stmt.executeUpdate(sqlup1);
			        	
			        	if(update>0){
			        		salikallocatecount+=update;
			        		// System.out.println("Salik Allocated:"+salikallocatecount);
			        		session.setAttribute("SALIKALLOCATECOUNT",salikallocatecount+"");
			        	}
			        	
	            	}
	            
	 	String sqlup="update gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno "+
				 				" set reason='Fleet Not Recognize' where  s.sal_date<='"+uptosqldate+"' and isallocated=0 and s.status in (0,3)  and veh.fleet_no is null "+sqltest1+"";
	 	// System.out.println("==== sqlup=== "+sqlup);
	 	stmt.executeUpdate(sqlup);
	 	
	 	String sqlup5="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values (0,'"+branchid+"','BTRFA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	  int data= stmt.executeUpdate(sqlup5); 
				 	
	       			stmt.close();
 	         		conn.close();					
		 			response.getWriter().print(saveval);
	 
 			}
	 	catch(Exception e)
	 		{
				e.printStackTrace();
				conn.close();
				response.getWriter().print("12");
			}
	 finally{conn.close();}

	 	
	 	
	 	
		%>
