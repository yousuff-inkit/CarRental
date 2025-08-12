package com.dashboard.invoices.invoicelistv2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsinvoicelistDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
    	
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	}
    	
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    		
    	}
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.status=3 "+sqltest+" group by doc_no");
				
			
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select  l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.status=3 "+sqltest+" group by doc_no");	
					
				
					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
 public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss,String cmbtariftype,String invstatuss) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        JSONArray ROWDATA=new JSONArray();
			JSONArray COLUMNDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     	}  
	      	
        	String sqltest="";
        	String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
	    	}
	    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
	    	}
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.rano='"+agmtNo+"'";
	    	}
	    	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"' )";
	    	}
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	    	if(!cmbtariftype.equalsIgnoreCase("")){
	    		if(cmbtariftype.equalsIgnoreCase("Daily")){
	    			sqltest+=" and rtarif.rentaltype='Daily'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Weekly")){
	    			sqltest+=" and rtarif.rentaltype='Weekly'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Monthly")){
	    			sqltest+=" and rtarif.rentaltype='Monthly'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Lease")){
	    			sqltest+=" and m.ratype='LAG'";
	    		}
	    	}
	    	if(!invstatuss.equalsIgnoreCase("")){
	    		if(invstatuss.equalsIgnoreCase("1")){
	    			sqltest+=" and m.status=3";
	    		}
	    		else if(invstatuss.equalsIgnoreCase("2")){
	    			sqltest+=" and m.status=7";
	    		}
	    	}
	    	Connection conn = null;
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
            		ResultSet re = stmtVeh.executeQuery(sql1);
            		
				int company=0;	
				int chk=1;
				
				if(re.next()) {
					company=re.getInt("method");
				}
				company=1;
				if(company==1) {
					chk=0;
					sqltest1=sqltest1+ " vat , ";
				} else {
					chk=1;
					sqltest+=" and m.status=3 ";		
				}
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(m.date),'/',m.voc_no)";
				}
				else{
					sqlvocno="m.voc_no";
				}
				String strshowfleet="select method from gl_config where field_nme='invListShowFleet'";
				int showfleet=0;
				ResultSet rsshowfleet=stmtindian.executeQuery(strshowfleet);
				while(rsshowfleet.next()){
					showfleet=rsshowfleet.getInt("method");
				}
				String showfleetcolumn="";
				if(showfleet==1){
					showfleetcolumn="coalesce(l.perfleet,r.ofleet) perfleet,";   
				}else {
					showfleetcolumn="'' perfleet,";
				}
	       
                ArrayList<String> columnarray= new ArrayList<String>();  
			     
                columnarray.add("Doc No::doc_no::cellclassname::7%:: :: :: :: ");
                columnarray.add("Branch::branch::cellclassname::9%:: :: :: :: ");
                columnarray.add("Date::date::cellclassname::6%::dd.MM.yyyy:: :: :: ");  
                columnarray.add("RA No::rano::cellclassname::5%:: :: :: :: ");
                columnarray.add("RA Type::ratype::cellclassname::6%:: :: :: :: ");
                columnarray.add("Tarif Type::tariftype::cellclassname::6%:: :: :: :: ");
                columnarray.add("Veh No::vehno::cellclassname::8%:: :: :: :: ");   
                columnarray.add("MRA NO::mrano::cellclassname::8%:: :: :: :: ");
                columnarray.add("Fleet No::perfleet::cellclassname::9%:: :: :: :: ");
                columnarray.add("From Date::fromdate::cellclassname::6%::dd.MM.yyyy:: :: :: ");   
                columnarray.add("To Date::todate::cellclassname::6%::dd.MM.yyyy:: :: :: ");
                columnarray.add("Account::acno::cellclassname::6%:: :: :: :: ");
                columnarray.add("Account Name::acname::cellclassname::14%:: :: :: :: ");
                columnarray.add("Show Fleet::showfleet::cellclassname::7%::d2::right::right:: ");
                columnarray.add("Salesman::sal_name::cellclassname::7%::d2::right::right:: ");   
                columnarray.add("Amount::amount::cellclassname::7%::d2::right::right :: ");
                columnarray.add("Del Amount::delamount::cellclassname::7%::d2::right::right:: ");
                columnarray.add("cldocno::cldocno::cellclassname::4%:: :: :: ::true");
                columnarray.add("Rental Sum::rent::cellclassname::7%::d2::right::right:: ");
                columnarray.add("Acc Sum::accchg::cellclassname::7%::d2::right::right:: ");
                columnarray.add("Salik Amt::salik::cellclassname::7%::d2::right::right:: ");
                columnarray.add("Traffic Amt::traffic::cellclassname::7%::d2::right::right:: ");
                columnarray.add("Insurance Charges::inschg::cellclassname::7%::d2::right::right:: ");
                columnarray.add("VAT::vat::cellclassname::7%::d2::right::right:: ");
                 	
				 
                String sqlselect="";
                int len=0,templen=0;
                String sql2 = "select description, idno from gl_invmode where status=1 and idno not in(1, 2, 8, 9, 14, 15, 17, 20)";
                ResultSet rs1 = stmtVeh.executeQuery(sql2); 
            	while(rs1.next()){
            		len++;
            		columnarray.add(rs1.getString("description")+"::amount_"+len+"::cellclassname::7%::d2::right::right:: ");
            		sqlselect+=" ROUND(SUM(IF(d.chid="+rs1.getString("idno")+",COALESCE(d.total,0),0)),2) amount_"+len+",";
            	}      
            	
            	String sql="select "+sqlselect+""+showfleet+" showfleet,concat(coalesce(a.authid,''),veh.reg_no,coalesce(p.code_name,'')) vehno,0 amount, 0 delamount,0 other,ROUND(SUM(IF(d.chid=1,COALESCE(d.total,0),0)),2) rent, ROUND(SUM(IF(d.chid=17,COALESCE(d.total,0),0)),2) inschg,"
						+ " ROUND(SUM(IF(d.chid=2,COALESCE(d.total,0),0)),2) accchg, ROUND(SUM(IF(d.chid=8,COALESCE(d.total,0),0)),2) salik, ROUND(SUM(IF(d.chid=14,COALESCE(d.total,0),0)),2) saliksrv,"
						+ " ROUND(SUM(IF(d.chid=9,COALESCE(d.total,0),0)),2) traffic, ROUND(SUM(IF(d.chid=15,COALESCE(d.total,0),0)),2) trafficsrv, ROUND(SUM(IF(d.chid=20,COALESCE(d.total,0),0)),2) vat, "
						+ "if(m.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,m.date,br.branchname branch,m.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname, h.account acno,m.ratype,"
						+ "if(m.ratype='RAG',r.voc_no, l.voc_no) rano,m.cldocno,ac.refname,"+showfleetcolumn+"m.fromdate,m.todate, ms.sal_name,if(m.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk"+
						" from gl_invm m left join gl_invd d on d.rdocno=m.doc_no  left join my_acbook ac on ac.doc_no=m.cldocno and  ac.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano and m.ratype='LAG' "
						+ "left join gl_ragmt r on (r.doc_no=m.rano and m.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=m.acno "
						+ "left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid LEFT JOIN gl_vehmaster veh ON if(m.ratype='RAG',r.fleet_no=veh.fleet_no,if(l.perfleet=0,l.tmpfleet=veh.fleet_no,l.perfleet=veh.fleet_no)) left join gl_vehauth a on (a.doc_no=veh.authid) left join gl_vehplate p on(p.doc_no=veh.pltid) "+
						" where m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" group by m.doc_no order by m.doc_no";                
				
				//System.out.println("Invoice List : "+sql);     
				ResultSet resultSet1 = stmtVeh.executeQuery(sql);     
				
				ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>(); 
				while(resultSet1.next()){
						ArrayList<String> temp=new ArrayList<String>();  

						temp.add(resultSet1.getString("doc_no"));
						temp.add(resultSet1.getString("branch"));
						temp.add(resultSet1.getString("date"));
						temp.add(resultSet1.getString("rano"));
						temp.add(resultSet1.getString("ratype"));
						temp.add(resultSet1.getString("tariftype"));
						temp.add(resultSet1.getString("vehno"));
						temp.add(resultSet1.getString("mrano"));
						temp.add(resultSet1.getString("perfleet"));
						temp.add(resultSet1.getString("fromdate"));
						temp.add(resultSet1.getString("todate"));
						temp.add(resultSet1.getString("acno"));
						temp.add(resultSet1.getString("acname"));
						temp.add(resultSet1.getString("showfleet"));
						temp.add(resultSet1.getString("sal_name"));
						temp.add(resultSet1.getString("amount"));
						temp.add(resultSet1.getString("delamount"));
						temp.add(resultSet1.getString("cldocno"));
						temp.add(resultSet1.getString("rent"));
						temp.add(resultSet1.getString("accchg"));
						temp.add(resultSet1.getString("salik"));
						temp.add(resultSet1.getString("traffic"));
						temp.add(resultSet1.getString("inschg"));
						temp.add(resultSet1.getString("vat"));
						templen = len;    
						for(int i=1;templen>0;i++,templen--) {         
							temp.add(resultSet1.getString("amount_"+i));   
						}
						rowarray.add(temp);
				 }
	            //System.out.println("rowarray===="+rowarray);  
	            //System.out.println("columnarray===="+columnarray);  
				COLUMNDATA=convertColumnArrayToJSON(columnarray);  
				ROWDATA=convertRowArrayToJSON(rowarray, len);   
				 
				 JSONArray detailsarray=new JSONArray();
				 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;    
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

 public  JSONArray convertColumnArrayToJSON(ArrayList<String> columnsList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] columnArray=columnsList.get(i).split("::");
			
			obj.put("text",columnArray[0]);
			obj.put("datafield",columnArray[1]);
			obj.put("cellclassname",columnArray[2]);
			if(!(columnArray[3].trim().equalsIgnoreCase(""))){
				obj.put("width",columnArray[3]);
		    }
			if(!(columnArray[4].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",columnArray[4]);
			}
			if(!(columnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("cellsalign",columnArray[5]);
		    }
			if(!(columnArray[6].trim().equalsIgnoreCase(""))){
				obj.put("align",columnArray[6]);
		    }
			if(!(columnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("hidden",columnArray[7]);
			}
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();   
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	}
	
	public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsList, int len) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		int templen=0;
		for (int i = 0; i < rowsList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> rowArray=rowsList.get(i);
			System.out.println("RowList : "+rowsList.get(i));
			
			obj.put("doc_no",rowArray.get(0));
			obj.put("branch",rowArray.get(1));
			obj.put("date",rowArray.get(2));
			obj.put("rano",rowArray.get(3));
			obj.put("ratype",rowArray.get(4));
			obj.put("tariftype",rowArray.get(5));
			obj.put("vehno",rowArray.get(6));
			obj.put("mrano",rowArray.get(7));
			obj.put("perfleet",rowArray.get(8));
			obj.put("fromdate",rowArray.get(9));
			obj.put("todate",rowArray.get(10));
			obj.put("acno",rowArray.get(11));
			obj.put("acname",rowArray.get(12));
			obj.put("showfleet",rowArray.get(13));
			obj.put("sal_name",rowArray.get(14));
			obj.put("amount",rowArray.get(15));
			obj.put("delamount",rowArray.get(16));
			obj.put("cldocno",rowArray.get(17));
			obj.put("rent",rowArray.get(18));
			obj.put("accchg",rowArray.get(19));
			obj.put("salik",rowArray.get(20));
			obj.put("traffic",rowArray.get(21));
			obj.put("inschg",rowArray.get(22));
			obj.put("vat",rowArray.get(23));
			templen=len;
			for(int j=24,k=1;templen>0;j++,k++,templen--) {              
				obj.put("amount_"+k,rowArray.get(j));     
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	 }
	
        public  JSONArray convertToJSON(ResultSet resultSet)
				throws Exception {
				JSONArray jsonArray = new JSONArray();
				
				while (resultSet.next()) {
				int total_rows = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < total_rows; i++) {
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
				}
				jsonArray.add(obj);
				}
				//System.out.println("ConvertTOJson:   "+jsonArray);
				return jsonArray;
	   }
}