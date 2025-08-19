<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
	Connection conn=null;
	
	String mailmode=request.getParameter("mailmode")==null?"0":request.getParameter("mailmode");
	String bookarray[]=request.getParameterValues("bookarray[]");
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String htmltable="";
		String bookdocno="",brhid="";
		String cldocno="",mail="",clientname="",compname="",branchname="",branchaddress="",branchtel="",branchfax="";
		
		int isGroupbased=0;
		String isGroupbasedsql = "SELECT COALESCE(method,0) method FROM gl_config WHERE field_nme='groupbased'";
		ResultSet rsGroup = stmt.executeQuery(isGroupbasedsql);
		if(rsGroup.next()){
			isGroupbased=rsGroup.getInt("method");
		}
		
		String addhtmltable="";
		if(isGroupbased==1){
			addhtmltable="<th>Model</th>";
		} else {
			addhtmltable = "<th>Brand</th><th>Model</th>";
		}
		
		htmltable="<table><thead><tr><th>Sr.No</th><th>Booking No</th><th>Doc Name</th><th>Pickup Date</th><th>Pickup Time</th><th>Pickup Loc.</th><th>Drop Off Loc.</th>"+addhtmltable+"</tr></thead><tbody>";
		for(int i=0,srno=1;i<bookarray.length;i++,srno++){
			bookdocno=bookarray[i].split("::")[0];
			String jobname=bookarray[i].split("::")[1];
			String strsql="";
			if(jobname.contains("T")){
				//Transfer
				strsql="select m.brhid,coalesce(comp.company,'') compname,coalesce(br.branchname,'') branchname,coalesce(br.address,'') branchaddress,coalesce(br.tel,'') branchtel,coalesce(br.fax,'') branchfax,coalesce(ac.refname,'') clientname,coalesce(ac.mail1,'') mail,m.cldocno,CONCAT('',br.code,DATE_FORMAT(m.date,'%Y'),LPAD(m.doc_no, 6, '0')) bookvocno,tran.docname,date_format(tran.pickupdate,'%d.%m.%Y') pickupdate,tran.pickuptime,"+
				" pickloc.location pickuplocation,droploc.location dropofflocation,brd.brand_name brandname,model.vtype modelname,gp.gid groupname from"+
				" gl_limobooktransfer tran left join gl_cordinates pickloc on tran.pickuplocid=pickloc.doc_no"+
				" left join gl_cordinates droploc on tran.dropfflocid=droploc.doc_no"+
				" left join gl_vehbrand brd on tran.brandid=brd.doc_no"+
				" left join gl_vehmodel model on tran.modelid=model.doc_no"+
				" left join gl_vehgroup gp on tran.gid=gp.doc_no"+
				" left join gl_limobookm m on m.doc_no=tran.bookdocno"+
				" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM')"+
				" left join my_brch br on m.brhid=br.doc_no"+
				" left join my_comp comp on br.cmpid=comp.doc_no"+
				" where bookdocno="+bookdocno+" and docname='"+jobname+"'";
			}
			else if(jobname.contains("L")){
				strsql="select m.brhid,coalesce(comp.company,'') compname,coalesce(br.branchname,'') branchname,coalesce(br.address,'') branchaddress,coalesce(br.tel,'') branchtel,coalesce(br.fax,'') branchfax,coalesce(ac.refname,'') clientname,coalesce(ac.mail1,'') mail,m.cldocno,"+
				" CONCAT('',br.code,DATE_FORMAT(m.date,'%Y'),LPAD(m.doc_no, 6, '0')) bookvocno,hrs.docname,date_format(hrs.pickupdate,'%d.%m.%Y') pickupdate,hrs.pickuptime,"+
				" pickloc.location pickuplocation,'' dropofflocation,brd.brand_name brandname,model.vtype modelname,gp.gid groupname from"+
				" gl_limobookhours hrs left join gl_cordinates pickloc on hrs.pickuplocid=pickloc.doc_no"+
				" left join gl_vehbrand brd on hrs.brandid=brd.doc_no"+
				" left join gl_vehmodel model on hrs.modelid=model.doc_no"+
				" left join gl_vehgroup gp on hrs.gid=gp.doc_no"+
				" left join gl_limobookm m on m.doc_no=hrs.bookdocno"+
				" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM')"+
				" left join my_brch br on m.brhid=br.doc_no"+
				" left join my_comp comp on br.cmpid=comp.doc_no"+
				" where bookdocno="+bookdocno+" and docname='"+jobname+"'";
			}
			System.out.println(strsql);
			ResultSet rstran=stmt.executeQuery(strsql);
			
			while(rstran.next()){
				compname=rstran.getString("compname");
				branchname=rstran.getString("branchname");
				branchaddress=rstran.getString("branchaddress");
				branchtel=rstran.getString("branchtel");
				branchfax=rstran.getString("branchfax");
				brhid=rstran.getString("brhid");
				mail=rstran.getString("mail");
				cldocno=rstran.getString("cldocno");
				clientname=rstran.getString("clientname");
				htmltable+="<tr>";
				htmltable+="<td>"+srno+"</td>";
				htmltable+="<td>"+rstran.getString("bookvocno")+"</td>";
				htmltable+="<td>"+rstran.getString("docname")+"</td>";
				htmltable+="<td>"+rstran.getString("pickupdate")+"</td>";
				htmltable+="<td>"+rstran.getString("pickuptime")+"</td>";
				htmltable+="<td>"+rstran.getString("pickuplocation")+"</td>";
				htmltable+="<td>"+rstran.getString("dropofflocation")+"</td>";
				if(isGroupbased==1){
					htmltable+="<td>"+rstran.getString("groupname")+"</td>";
				}else {
					htmltable+="<td>"+rstran.getString("brandname")+"</td>";
					htmltable+="<td>"+rstran.getString("modelname")+"</td>";
				}
				htmltable+="</tr>";
			}
		}
		htmltable+="</tbody></table>";
		String msg="";
		msg="<html>"              
				  +" <body>"
				  +" <p>Dear Sir / Madam,</p><br/>"
				  +" <p>Please note that your booking is confirmed</p>" 
				  +" "+htmltable+""
				  +" <p>If you should have any questions or concerns, please dont hesitate to contact our office.</p>"  
				  +" <p>Yours Sincerely,</p>"
				  +" <p>Team Booking</p>" 
				  +" <h2>"+compname+"</h2>"
				  +" <p>"+branchname+","+branchaddress+"<br/>"
				  +" Tel: "+branchtel+", Fax: "+branchfax+"<br/>"        
				  +" <p>Please dont print e-mails unless you really need</p>"
				  +" </p>"
				  +" </body>"
				  +" </html>"; 
		objdata.put("message",msg);
		objdata.put("userid",session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString());
		objdata.put("brhid",brhid);
		objdata.put("bookdocno",bookdocno);
		objdata.put("cldocno",cldocno);
		objdata.put("mail",mail);
		objdata.put("clientname",clientname);
		System.out.println(objdata);
		response.getWriter().write(objdata+"");
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>