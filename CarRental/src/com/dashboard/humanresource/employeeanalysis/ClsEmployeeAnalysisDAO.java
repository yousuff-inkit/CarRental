
package com.dashboard.humanresource.employeeanalysis;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 
public class ClsEmployeeAnalysisDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cmn=new ClsCommon();
	
	
	public JSONArray empload(String department, String category, String empId, int check,String employeebranchchk,String brhid) throws SQLException {
		//System.out.println("in");
		 JSONArray RESULTDATA=new JSONArray();

		 if(check==0){
			 return RESULTDATA;
		 }
		 
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 int isShowRta = 0; 
			 	 String showrtasql = "Select method from gl_config where field_nme='rtastatusshow'";
			 	 ResultSet rs = stmtEMP.executeQuery(showrtasql);
			 	 if(rs.next()) {
			 		isShowRta = rs.getInt("method");
			 	 }
			
			     String sqlAllowanceName = "",sqlAllowanceJoins = "",sqlDocumentsName = "",sqlDocumentsJoins = "", sqls="";
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     
			     analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: :: ");
			     analysiscolumnarray.add("Emp ID::empid::left::left:: ::5%:: :: :: :: ");
			     analysiscolumnarray.add("Name::name::left::left:: ::14%:: :: :: :: ");
			     analysiscolumnarray.add("Designation::designation::left::left:: ::12%:: :: :: :: ");
			     analysiscolumnarray.add("Department::department::left::left:: ::5%:: :: :: :: ");
			     analysiscolumnarray.add("Category::category::left::left:: ::8%:: :: :: :: ");
			     analysiscolumnarray.add("Date of Join::dtjoin::left::left:: ::5%::dd.MM.yyyy:: :: :: ");
			     analysiscolumnarray.add("Address::address::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Mobile::mobile::left::left:: ::6%:: :: :: :: ");
			     analysiscolumnarray.add("Email Id::email::left::left:: ::14%:: :: :: :: ");
			     analysiscolumnarray.add("DOB::dob::left::left:: ::5%::dd.MM.yyyy:: :: :: ");
			     analysiscolumnarray.add("Gender::gender::left::left:: ::3%:: :: :: :: ");
			     analysiscolumnarray.add("Bank Account::bankaccount::left::left:: ::11%:: :: :: :: ");
			     analysiscolumnarray.add("IFSC Code::ifsccode::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Est. Code::estcode::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Company::compname::left::left:: ::10%:: :: :: :: ");
			     analysiscolumnarray.add("Branch::branchname::left::left:: ::12%:: :: :: :: ");
			     analysiscolumnarray.add("Status::status::left::left:: ::6%:: :: :: :: ");
			     analysiscolumnarray.add("Basic Salary::basicsalary::right::right:: ::6%::d2:: :: :: ");
			     analysiscolumnarray.add("Empdocno::empdocno::left::left::true::4%:: :: :: :: ");
			     analysiscolumnarray.add("BranchId::branchid::left::left::true::3%:: :: :: :: ");
			     
			     String sql = "select desc1 from hr_setallowance where status=3 and doc_no>0";
				 ResultSet resultSet = stmtEMP.executeQuery(sql);
				 int i=1,totalallowance=0;
				 while(resultSet.next()) {
				 		sqlAllowanceName+=",coalesce(s"+i+".allowance"+i+",0) allowance"+i+"";
				 		sqlAllowanceJoins+=" left join (select rdocno,round(coalesce((addition-deduction),0),2) allowance"+i+" from hr_empsal where awlId="+i+" and refdtype='ALC') s"+i+" on m.doc_no=s"+i+".rdocno";
				 		analysiscolumnarray.add(""+resultSet.getString("desc1")+"::allowance"+i+"::right::right:: ::9%::d2:: :: :: ");
				 		totalallowance=totalallowance+1;
						i++;
				  }
					
				 String sql1 = "select desc1 from hr_setdoc where status=3";
				 ResultSet resultSet1 = stmtEMP.executeQuery(sql1);
				 int j=1,totaldocuments=0;
				 String sqltest1="";
				 while(resultSet1.next()) {
					    sqltest1+=" d"+j+".expdt"+j+" IS NOT NULL OR";
				 		sqlDocumentsName+=",d"+j+".docidnum"+j+",d"+j+".issdt"+j+",d"+j+".expdt"+j+",d"+j+".placeofiss"+j+"";
				 		sqlDocumentsJoins+=" left join (select rdocno,docidnum docidnum"+j+",issdt issdt"+j+",expdt expdt"+j+",placeofiss placeofiss"+j+" from hr_empdoc where docid="+j+") d"+j+" on m.doc_no=d"+j+".rdocno";
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" No::docidnum"+j+"::left::left:: ::8%:: :: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Issued Date::issdt"+j+"::left::left:: ::8%::dd.MM.yyyy:: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Expiry Date::expdt"+j+"::left::left:: ::9%::dd.MM.yyyy:: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Issued Place::placeofiss"+j+"::left::left:: ::10%:: :: :: :: ");
				 		totaldocuments=totaldocuments+1;
				 		j++;
				  }
				 String rtacolumns ="";
				 String rtatable ="";
				 if(isShowRta>0) {
					 analysiscolumnarray.add("RTA Status::rtastatus::left::left:: ::3%:: :: :: :: ");
					 rtacolumns = " coalesce(m.isrtaavail,0) isrtaavail,coalesce(m.rtastatusid,0) rtastatusid, coalesce(if(m.isrtaavail=1,rrn.status,rta.status),'') rtastatus,";
					 rtatable = "left join my_cmstatus rta on m.rtastatusid=rta.doc_no left join my_rtarenewal rrn on m.rtastatusid=rrn.doc_no ";
				 }
				 
			     if(!department.equalsIgnoreCase("")){
			    	 sqls+=" and m.dept_id="+department+"";
				 }
			     
			     if(!category.equalsIgnoreCase("")){
			    	 sqls+=" and m.pay_catid="+category+"";
				 }
			     
			     if(!empId.equalsIgnoreCase("")){
			    	 sqls+=" and m.doc_no="+empId+"";
				 }
			     if(employeebranchchk.equalsIgnoreCase("1")){    
		            	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0")) && !(brhid.equalsIgnoreCase("a"))){  
		            		sqls=sqls+" and m.brhid='"+brhid+"'";     
		            	}
		            } 
			     if(check==2){
			    	 sqls+=" AND ("+sqltest1.substring(0, sqltest1.length() - 2)+")";
				 }  
			     

		    	String sql3 = "select @i:=@i+1 id,a.* from ( select m.doc_no empdocno, m.codeno empid,m.name,des.desc1 designation,dep.desc1 department,cat.desc1 category,m.dtjoin,m.pmaddr address,"
		    			+ "if(m.active=1,'ACTIVE','TERMINATED') status,m.pmmob mobile,m.pmemail email,m.dob,m.gender,m.bnk_acc_no bankaccount,m.brhid branchid,mb.branchname,m.ifsccode,coalesce(m.est_code,'') estcode,"
		    			+ "coalesce(m.co_name,'') compname,"+rtacolumns+"s.basicsalary"+sqlAllowanceName+""+sqlDocumentsName+" from hr_empm m "
		    			+ "left join hr_setdept dep on m.dept_id=dep.doc_no "
		    			+ "left join hr_setdesig des on m.desc_id=des.doc_no "
		    			+ "left join hr_setpaycat cat on m.pay_catid=cat.doc_no "
		    			+ "left join my_brch mb on m.brhid=mb.doc_no "
		    			+ rtatable
		    			+ "left join (select rdocno,round(coalesce((addition-deduction),0),2) basicsalary "
		    			+ "from hr_empsal where awlId=0 and refdtype=0) s on m.doc_no=s.rdocno "+sqlAllowanceJoins+""+sqlDocumentsJoins+" where 1=1"+sqls+" order by CAST(CODENO  AS UNSIGNED) ) a,(SELECT @i:= 0) as i  ";
		    	 
		    	System.out.println("sql3============="+sql3);
					
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
	
					while(resultSet3.next()){
						ArrayList<String> temp=new ArrayList<String>();
						
						temp.add(resultSet3.getString("id"));
						temp.add(resultSet3.getString("empid"));
						temp.add(resultSet3.getString("name"));
						temp.add(resultSet3.getString("designation"));
						temp.add(resultSet3.getString("department"));
						temp.add(resultSet3.getString("category"));
						temp.add(resultSet3.getString("dtjoin"));
						temp.add(resultSet3.getString("address"));
						temp.add(resultSet3.getString("mobile"));
						temp.add(resultSet3.getString("email"));
						temp.add(resultSet3.getString("dob"));
						temp.add(resultSet3.getString("gender"));
						temp.add(resultSet3.getString("bankaccount"));
						temp.add(resultSet3.getString("ifsccode"));
						temp.add(resultSet3.getString("estcode"));
						temp.add(resultSet3.getString("compname"));
						temp.add(resultSet3.getString("branchname"));
						temp.add(resultSet3.getString("status"));
						temp.add(resultSet3.getString("basicsalary"));
						temp.add(resultSet3.getString("empdocno"));
						temp.add(resultSet3.getString("branchid"));

						for(int k=1;k<=totalallowance;k++){
							temp.add(resultSet3.getString("allowance"+k+""));
						}
						
						for(int l=1;l<=totaldocuments;l++){
							temp.add(resultSet3.getString("docidnum"+l+""));
							temp.add(resultSet3.getString("issdt"+l+""));
							temp.add(resultSet3.getString("expdt"+l+""));
							temp.add(resultSet3.getString("placeofiss"+l+""));
						}
						
						if(isShowRta>0) {
							temp.add(resultSet3.getString("rtastatus"));
							temp.add(resultSet3.getString("rtastatusid"));
							temp.add(resultSet3.getString("isrtaavail"));
						}
						
						analysisrowarray.add(temp);
					}
				 
				 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
				 
				 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray,totalallowance,totaldocuments,isShowRta);
	
				 JSONArray analysisarray=new JSONArray();
				 
				 analysisarray.addAll(COLUMNDATA);
				 analysisarray.addAll(ROWDATA);
				 RESULTDATA=analysisarray;
			 
			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("columngroup",analysisColumnArray[8]);
			}
			if(!(analysisColumnArray[9].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[9]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList,int totalallowance,int totaldocuments, int isShowRta) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("empid",analysisRowArray.get(1));
			obj.put("name",analysisRowArray.get(2));
			obj.put("designation",analysisRowArray.get(3));
			obj.put("department",analysisRowArray.get(4));
			obj.put("category",analysisRowArray.get(5));
			obj.put("dtjoin",analysisRowArray.get(6));
			obj.put("address",analysisRowArray.get(7));
			obj.put("mobile",analysisRowArray.get(8));
			obj.put("email",analysisRowArray.get(9));
			obj.put("dob",analysisRowArray.get(10));
			obj.put("gender",analysisRowArray.get(11));
			obj.put("bankaccount",analysisRowArray.get(12));
			obj.put("ifsccode",analysisRowArray.get(13));
			obj.put("estcode",analysisRowArray.get(14));
			obj.put("compname",analysisRowArray.get(15));
			obj.put("branchname",analysisRowArray.get(16));
			obj.put("status",analysisRowArray.get(17));
			obj.put("basicsalary",analysisRowArray.get(18));
			obj.put("empdocno",analysisRowArray.get(19));
			obj.put("branchid",analysisRowArray.get(20));
			
			int m=1,o=21;
			for(m=1,o=21;m<=totalallowance;m++,o++){
				obj.put("allowance"+m,analysisRowArray.get(o));
			}
			int tempp=0;
			for(int n=1,p=o;n<=totaldocuments;n++,p++){
				obj.put("docidnum"+n,analysisRowArray.get(p));
				obj.put("issdt"+n,analysisRowArray.get(p+1));
				obj.put("expdt"+n,analysisRowArray.get(p+2));
				obj.put("placeofiss"+n,analysisRowArray.get(p+3));
				p=(p+3);
				tempp=p+1;
			}
			if(isShowRta>0) {				
				obj.put("rtastatus",analysisRowArray.get(tempp++));
				obj.put("rtastatusid",analysisRowArray.get(tempp++));
				obj.put("isrtaavail",analysisRowArray.get(tempp));
				//System.out.println(analysisRowArray.get(tempp) +"   "+ analysisRowArray.get(tempp+1));
			}
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}

	public JSONArray loadleavelist(String empdocno, String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		 if(!id.equals("1")){
		    return RESULTDATA;
		 }
		Connection conn=null;
		Statement stmt=null;
			try {
			conn=ClsConnection.getMyConnection(); 
            stmt = conn.createStatement ();
            
            	   
		        String sql="";
		        String sqlIncludeAll="";
		        String sqlallcond="";
		        
		       
		        if(!(empdocno.equalsIgnoreCase("0")) && !(empdocno.equalsIgnoreCase(""))){
		        	sql=sql+" and r.empid='"+empdocno+"'";
			    }
		       
		        if(!(empdocno.equalsIgnoreCase("0")) && !(empdocno.equalsIgnoreCase(""))){
		        	sqlallcond=" and dates.empid='"+empdocno+"'";
			    }
		        
		        sqlIncludeAll =" UNION ALL SELECT  m.codeno employeeid,m.name employeename,ds.desc1 designation,dp.desc1 department,c.desc1 category, dates.date_value fromdate, dates.date_value todate, '' halfday, '' halfdaydate,SUBSTRING_INDEX(dates.leavetype,' ',1) LEAVES, dates.leavetype description,DATEDIFF(dates.date_value,dates.date_value)+1 noofdays FROM (SELECT \r\n" + 
		        		"    a.empid,\r\n" + 
		        		"    a.date_value,\r\n" + 
		        		"    COALESCE(hts.name, '') AS leavetype \r\n" + 
		        		"FROM \r\n" + 
		        		"    (SELECT \r\n" + 
		        		"         srno, empId, date1 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 1)) AS date_value\r\n" + 
		        		"     FROM hr_timesheet WHERE date1 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date2 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 2))\r\n" + 
		        		"     FROM hr_timesheet WHERE date2 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date3 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 3))\r\n" + 
		        		"     FROM hr_timesheet WHERE date3 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date4 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 4))\r\n" + 
		        		"     FROM hr_timesheet WHERE date4 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date5 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 5))\r\n" + 
		        		"     FROM hr_timesheet WHERE date5 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date6 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 6))\r\n" + 
		        		"     FROM hr_timesheet WHERE date6 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date7 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 7))\r\n" + 
		        		"     FROM hr_timesheet WHERE date7 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date8 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 8))\r\n" + 
		        		"     FROM hr_timesheet WHERE date8 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date9 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 9))\r\n" + 
		        		"     FROM hr_timesheet WHERE date9 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date10 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 10))\r\n" + 
		        		"     FROM hr_timesheet WHERE date10 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date11 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 11))\r\n" + 
		        		"     FROM hr_timesheet WHERE date11 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date12 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 12))\r\n" + 
		        		"     FROM hr_timesheet WHERE date12 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date13 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 13))\r\n" + 
		        		"     FROM hr_timesheet WHERE date13 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date14 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 14))\r\n" + 
		        		"     FROM hr_timesheet WHERE date14 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date15 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 15))\r\n" + 
		        		"     FROM hr_timesheet WHERE date15 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date16 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 16))\r\n" + 
		        		"     FROM hr_timesheet WHERE date16 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date17 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 17))\r\n" + 
		        		"     FROM hr_timesheet WHERE date17 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date18 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 18))\r\n" + 
		        		"     FROM hr_timesheet WHERE date18 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date19 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 19))\r\n" + 
		        		"     FROM hr_timesheet WHERE date19 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date20 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 20))\r\n" + 
		        		"     FROM hr_timesheet WHERE date20 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date21 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 21))\r\n" + 
		        		"     FROM hr_timesheet WHERE date21 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date22 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 22))\r\n" + 
		        		"     FROM hr_timesheet WHERE date22 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date23 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 23))\r\n" + 
		        		"     FROM hr_timesheet WHERE date23 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date24 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 24))\r\n" + 
		        		"     FROM hr_timesheet WHERE date24 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date25 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 25))\r\n" + 
		        		"     FROM hr_timesheet WHERE date25 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date26 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 26))\r\n" + 
		        		"     FROM hr_timesheet WHERE date26 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date27 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 27))\r\n" + 
		        		"     FROM hr_timesheet WHERE date27 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date28 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 28))\r\n" + 
		        		"     FROM hr_timesheet WHERE date28 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date29 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 29))\r\n" + 
		        		"     FROM hr_timesheet WHERE date29 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date30 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 30))\r\n" + 
		        		"     FROM hr_timesheet WHERE date30 > 0\r\n" + 
		        		"     UNION ALL\r\n" + 
		        		"     SELECT srno, empId, date31 AS leaveid, YEAR, MONTH,\r\n" + 
		        		"         DATE(CONCAT(YEAR, '-', MONTH, '-', 31))\r\n" + 
		        		"     FROM hr_timesheet WHERE date31 > 0\r\n" + 
		        		"    ) AS a\r\n" + 
		        		"LEFT JOIN hr_timesheetset hts ON hts.refno = a.leaveid AND hts.reftype IN ('L')\r\n" + 
		        		"LEFT JOIN (\r\n" + 
		        		"    SELECT DATE_ADD(hr.fromdate, INTERVAL n DAY) AS date_exclude\r\n" + 
		        		"    FROM (\r\n" + 
		        		"        SELECT a.N + b.N * 10 AS n\r\n" + 
		        		"        FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 \r\n" + 
		        		"              UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a\r\n" + 
		        		"        CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 \r\n" + 
		        		"                    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b\r\n" + 
		        		"        ORDER BY n\r\n" + 
		        		"    ) num\r\n" + 
		        		"    JOIN hr_leaverequest hr\r\n" + 
		        		"    WHERE DATE_ADD(hr.fromdate, INTERVAL n DAY) <= hr.todate \r\n" + 
		        		"      \r\n" + 
		        		") excluded_dates ON a.date_value = excluded_dates.date_exclude\r\n" + 
		        		"WHERE  excluded_dates.date_exclude IS NULL AND hts.name IS NOT NULL\r\n" + 
		        		"ORDER BY a.date_value ASC\r\n" + 
		        		") dates LEFT JOIN hr_empm m ON m.doc_no=dates.empid LEFT JOIN hr_setdesig ds ON ds.doc_no=m.desc_id LEFT JOIN hr_setdept dp ON dp.doc_no=m.dept_id LEFT JOIN hr_setpaycat c ON c.doc_no=m.pay_catid WHERE m.status=3 AND m.active=1"+sqlallcond;
		        
		        
            

			String salsql="select m.codeno employeeid,m.name employeename,ds.desc1 designation,dp.desc1 department,c.desc1 category,r.fromdate, r.todate, if(r.halfday=1,true,false) halfday, r.halfdaydate,SUBSTRING_INDEX(l.desc1,' ',1) leaves, r.description,r.noofdays from "
					+ "hr_leaverequest  r left join hr_empm m on r.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=r.desc_id left join hr_setdept dp on dp.doc_no=r.dept_id left join hr_setpaycat c on c.doc_no=r.pay_catid left join hr_setleave l on l.doc_no=r.leavetype "
					+ "where m.status=3 and m.active=1 and r.status=3 and r.confirm=1"+sql+sqlIncludeAll;
			//System.out.println(salsql);
			ResultSet resultSet = stmt.executeQuery(salsql);
			RESULTDATA=cmn.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			
             	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public JSONArray loaddoclist(String empdocno,String branch,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        Statement stmt=null;
        try {
			conn = ClsConnection.getMyConnection();
		    stmt = conn.createStatement();
			String sqltest = "";
			 
			 if(!(empdocno.equalsIgnoreCase("0")) && !(empdocno.equalsIgnoreCase(""))){
				 sqltest+=" and m.doc_no='"+empdocno+"'";
			    }   
			 
			
			 String sql = "select 'View' as view, 'Attach' as attach,CONVERT(coalesce(bb.fdate,''),CHAR(100)) followupdate,m.doc_no empdocno,m.codeNo empid,m.name empname,m.pmmob,m.brhid,d.docid,d.expdt expirydate,CONCAT(sd.desc1,' Expired') document,"
					+ "des.desc1 designation,dep.desc1 department,CONVERT(concat(' Emp. ID : ',coalesce(m.codeNo,' '), ' * ','Employee  : ',coalesce(m.name,' '),' * ','Mobile No. : ' ,coalesce(m.pmmob,' '),' * ','Document : ', "
					+ "coalesce(CONCAT(sd.desc1,' Expired'),' '),' * ','Expiry Date : ', DATE_FORMAT(coalesce(d.expdt,' '),'%d-%m-%Y')),CHAR(1000)) empinfo from hr_empm m "
					+ "left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_empdoc d on m.doc_no=d.rdocno left join hr_setdoc sd on sd.doc_no=d.docid "
					+ "left join (select max(doc_no) doc,empdocno,docid from hr_bcde group by empdocno,docid) a on a.empdocno=m.doc_no and a.docid=d.docid left join hr_bcde bb on a.doc=bb.doc_no where m.status=3 and m.active=1 "
					+ "and d.docid is not null"+sqltest+"";
			//System.out.println(sql);
			ResultSet resultSet = stmt.executeQuery(sql); 
			RESULTDATA=cmn.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
    return RESULTDATA;
}
	
	public JSONArray statusUpdateGridLoad(String check, String isRtaAvail) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	    
	    if(!check.equalsIgnoreCase("1")) {
	    	return RESULTDATA;
	    }
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmnt = conn.createStatement();
				String tableName="";
				if(isRtaAvail.equalsIgnoreCase("1")) {
					tableName = "my_rtarenewal";
				} else {
					tableName = "my_cmstatus";
				}
				String sqlLoad="SELECT doc_no docno,status,`desc` from "+tableName;
				System.out.println("Status Update - "+sqlLoad);
				ResultSet resultSet = stmnt.executeQuery (sqlLoad);
	            
				RESULTDATA=cmn.convertToJSON(resultSet);
				
				stmnt.close();
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