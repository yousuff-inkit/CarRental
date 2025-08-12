<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.ClsCommon"%>  
<%@page import="java.sql.*"%>     
<%
        String rowno=request.getParameter("rowno")==null?"":request.getParameter("rowno");    
        String bkdocno=request.getParameter("bookdocno")==null?"0":request.getParameter("bookdocno");  
        String jobname=request.getParameter("jobname")==null?"0":request.getParameter("jobname");  
        String detdocno=request.getParameter("detaildocno")==null?"0":request.getParameter("detaildocno");  
        String brch=request.getParameter("brch")==null?"0":request.getParameter("brch");
		String typess=request.getParameter("type")==null?"":request.getParameter("type");       
		String date=request.getParameter("date")==null?"":request.getParameter("date");
		String process=request.getParameter("cmbprocess")==null?"0":request.getParameter("cmbprocess");          
		String data = request.getParameter("data")==null?"-":request.getParameter("data");
		String transferbranch=request.getParameter("cmbtransferbranch")==null?"0":request.getParameter("cmbtransferbranch");
		
	    String mode="A",dtype="BMG";                 
	    
	    System.out.println(rowno+" - "+ bkdocno+" - "+detdocno+" - "+typess+" - "+date+" - "+data);
	    
		ClsConnection  ClsConnection=new ClsConnection();            
		ClsCommon objcommon=new ClsCommon();
    	Connection conn=null;
		int temp=1,val=1,docno=0,vocno=0;           
		String msg="";
		String doc="";
		int errorstatus=0;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		    String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
		    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
		    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
			Statement stmtassign=conn.createStatement();  
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);                
			}
			if(brch.equalsIgnoreCase("a")){  
				brch="0";                            
			}
			JSONArray jsonArray = JSONArray.fromObject(data);
			int countconfirm=0;
			 for (int i = 0; i < jsonArray.size(); i++) {
		            JSONObject jsonObject = jsonArray.getJSONObject(i);
		            String drvid = jsonObject.getString("drvid");
		            String fleetn = jsonObject.getString("fleetno");
		            String additionid = jsonObject.getString("addition");
		            int addCount=0;
		            if(countconfirm<=0){
		            	String getCount = "Select count(*) counts from gl_multivehassign where bookingno="+bkdocno+" and jobname='"+jobname+"'";
			            ResultSet rsgetCount=stmtassign.executeQuery(getCount);
			            if(rsgetCount.next()){
			            	addCount = rsgetCount.getInt("counts");
			            }
		            } 
		            
		            if(addCount<=0 && countconfirm<=0){
		            	countconfirm=1;
		            	CallableStatement stmtJob =conn.prepareCall("{call limoJobAssignDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtJob.registerOutParameter(14, java.sql.Types.INTEGER);     
						stmtJob.registerOutParameter(15, java.sql.Types.INTEGER);
						stmtJob.setDate(1, sqldate);
						stmtJob.setInt(2, bkdocno==null || bkdocno.equalsIgnoreCase("")?0:Integer.parseInt(bkdocno));
						stmtJob.setInt(3, detdocno==null || detdocno.equalsIgnoreCase("")?0:Integer.parseInt(detdocno));
						stmtJob.setString(4, process);    
						stmtJob.setString(5, drvid==null || drvid.equalsIgnoreCase("")?"0":drvid);
						stmtJob.setString(6, fleetn==null || fleetn.equalsIgnoreCase("")?"0":fleetn);
						stmtJob.setString(7, transferbranch==null || transferbranch.equalsIgnoreCase("")?"0":transferbranch);
						stmtJob.setString(8, "0");
						stmtJob.setString(9, mode);
						stmtJob.setString(10, dtype);   
						stmtJob.setString(11, brch);
						stmtJob.setString(12, session.getAttribute("USERID").toString());
						stmtJob.setString(13, session.getAttribute("COMPANYID").toString());
						stmtJob.executeQuery();    
						docno=stmtJob.getInt("docNo");
						vocno=stmtJob.getInt("voc");
						if(docno<=0){
							temp=0;
						} else {
							String strassignupdate="";
							String strbranchtran="";
							if(typess.equalsIgnoreCase("Transfer")){
								strassignupdate="update gl_limobooktransfer set assignstatus=1,masterstatus=3,assignedfleet="+fleetn+",assigneddriver="+drvid+" where doc_no="+detdocno;
							}
							else if(typess.equalsIgnoreCase("Limo")){
								strassignupdate="update gl_limobookhours set assignstatus=1,masterstatus=3,assignedfleet="+fleetn+",assigneddriver="+drvid+" where doc_no="+detdocno;
							}
							int assignval=stmtassign.executeUpdate(strassignupdate);
							if(assignval<=0){
								val=0;                            
							}
							else{
								
							}
							String strgetfleet="select veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model from gl_vehmaster veh left join "+
							" gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where veh.statu=3 and "+
							" veh.fleet_no="+fleetn;
							ResultSet rsgetfleet=stmtassign.executeQuery(strgetfleet);
							String fleetname="",brand="",model="";
							while(rsgetfleet.next()){
								fleetname=rsgetfleet.getString("flname");
								brand=rsgetfleet.getString("brand");
								model=rsgetfleet.getString("model");
							}
							String strgetdriver="select sal_name from my_salesman where sal_type='DRV' and status=3 and doc_no="+drvid;
							ResultSet rsgetdriver=stmtassign.executeQuery(strgetdriver);
							String drivername="";
							while(rsgetdriver.next()){
								drivername=rsgetdriver.getString("sal_name");
							}
							String strsqlss="";
								
							strsqlss="update gl_limomanagement set bstatus=2,fname='"+fleetname+"',fno='"+fleetn+"',brand='"+brand+"',model='"+model+"',drivername='"+drivername+"' where rowno='"+rowno+"'";
									
							System.out.println("ASSIGN STATUS=="+strsqlss);
							stmtassign.executeUpdate(strsqlss);  
								
							String strgetdetail="select docno,job from gl_limomanagement where rowno='"+rowno+"'";
							int bookingdocno=0;
							String jobnames="";
							ResultSet rs=stmtassign.executeQuery(strgetdetail);
							while(rs.next()){
								bookingdocno=rs.getInt("docno");
								jobnames=rs.getString("job");
							}
							
							int maxadd=0;
							String maxadditionno = "SELECT COALESCE(MAX(addition),0)+1 maxaddition FROM gl_multivehassign WHERE bookingno="+bkdocno+" AND jobname='"+jobname+"'";
							ResultSet rsmaxadditionno=stmtassign.executeQuery(maxadditionno);
							if(rsmaxadditionno.next()){
								maxadd = rsmaxadditionno.getInt("maxaddition");
							}
							
							String insertmultiveh ="";
							if(additionid.equalsIgnoreCase("")){
								insertmultiveh = "INSERT INTO gl_multivehassign (bookingno,jobname,bookingstatus,drvid,vehname,fleetno,addition,DATE) VALUES ("+bkdocno+",'"+jobname+"',2,"+drvid+",'"+fleetname+"','"+fleetn+"','"+maxadd+"',NOW())";
							} else {
								insertmultiveh = "update gl_multivehassign set drvid='"+drvid+"', fleetno="+fleetn+" where addition="+additionid+" and bookingno="+bkdocno+" and jobname="+jobname+"'";
							}
							int resimv = stmtassign.executeUpdate(insertmultiveh);
							if(resimv<=0){
								errorstatus=1;
							}
							
							String systemnote="Job Assignment of "+bookingdocno+" - "+jobname+" by "+username;
							String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,systemremarks)values("+
							""+bookingdocno+",'"+jobname+"',"+brhid+","+userid+",now(),'"+systemnote+"')";
							int insertlog=stmtassign.executeUpdate(strinsertlog);
							if(insertlog<=0){
								errorstatus=1;
							}
						}
		            } else {
		            	
		            	String strgetfleet="select veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model from gl_vehmaster veh left join "+
								" gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where veh.statu=3 and "+
								" veh.fleet_no="+fleetn;
						ResultSet rsgetfleet=stmtassign.executeQuery(strgetfleet);
						String fleetname="",brand="",model="";
								while(rsgetfleet.next()){
									fleetname=rsgetfleet.getString("flname");
									brand=rsgetfleet.getString("brand");
									model=rsgetfleet.getString("model");
								}
						int maxadd=0;
						String maxadditionno = "SELECT COALESCE(MAX(addition),0)+1 maxaddition FROM gl_multivehassign WHERE bookingno="+bkdocno+" AND jobname='"+jobname+"'";
						ResultSet rsmaxadditionno=stmtassign.executeQuery(maxadditionno);
						if(rsmaxadditionno.next()){
							maxadd = rsmaxadditionno.getInt("maxaddition");
						}
						String insertmultiveh ="";
						if(additionid.equalsIgnoreCase("")){
							insertmultiveh = "INSERT INTO gl_multivehassign (bookingno,jobname,bookingstatus,drvid,vehname,fleetno,addition,DATE) VALUES ("+bkdocno+",'"+jobname+"',2,"+drvid+",'"+fleetname+"','"+fleetn+"','"+maxadd+"',NOW())";
						} else {
							insertmultiveh = "update gl_multivehassign set drvid='"+drvid+"', fleetno="+fleetn+" where addition="+additionid+" and bookingno="+bkdocno+" and jobname='"+jobname+"'";
						}
						int resimv = stmtassign.executeUpdate(insertmultiveh);
						if(resimv<=0){
							errorstatus=1;
						}
		            }
		           
		        }
			 
			if(errorstatus==0){
				conn.commit();
			}
			  response.getWriter().print(val);
	 		  conn.close();
			}catch(Exception e){      
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
%>