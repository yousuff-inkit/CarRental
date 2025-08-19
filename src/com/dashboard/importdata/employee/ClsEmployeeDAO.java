package com.dashboard.importdata.employee;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray employeeListGridLoading(String check) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 if(!check.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select * from im_employee";
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			    // System.out.println("sql3============="+sql3);
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }

	
	public JSONArray employeeListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 int status1=0;
			 	int stat=0;

			 String strins1="",strins2="",strins3="",strins4="",strins5="",strins6="",strins7="",strins8="",strins9="",str1="",str2="",str3="",str4="",str5="",strins51="",strins52="",strins53="",strins54="";  
			 str1="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
			 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
			 		+ "grplevel, gr_type, agroup, lApply, cmpid,OLDCODENO) "
			 		+ "select  if(e.brhid='',1,e.brhid) brhid, NAME,0 M_S,301 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1 doc_no, "
			 		+ "curdate() date,'HR' ATYPE,0,@doc_no:=@doc_no+1 account, "
			 		+ "'EMP' dtype,concat('.',1081,'.',@doc_no) alevel,1081 grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid,e.codeNo OLDCODENO from im_employee e left join my_head h on h.description=trim(e.name) and h.den=301 ,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where e.name!='' and h.doc_no is null";
			// System.out.println("str1============="+str1);
			 stmtEMP1.executeUpdate(str1);
			 
			 str2="insert into hr_setdesig( brhid, doc_no, desc1, remarks, date, status) "
			 		+ "select 1 brhid,@doc_no:=@doc_no+1,upper(desc_id) desc1 ,upper(desc_id) remarks ,curdate(),3 from "
			 		+ "(select distinct trim(desig) desc_id from im_employee e left join hr_setdesig  d on trim(d.desc1)=trim(e.desig) where desig!='' and d.doc_no is null) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from hr_setdesig)) b";
			// System.out.println("str2============="+str2);
			 stmtEMP1.executeUpdate(str2);
			 
			 str3="insert into hr_setdept( brhid, doc_no, desc1, remarks, date, status) "
			 		+ "select 1 brhid,@doc_no:=@doc_no+1,upper(desc_id) desc1 ,upper(desc_id) remarks ,curdate(),3 from "
			 		+ "(select distinct trim(dept) desc_id from im_employee e left join hr_setdept  d on trim(d.desc1)=trim(e.dept) where dept!='' and d.doc_no is null  ) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from hr_setdept))b";
			 //System.out.println("str3============="+str3);
			 stmtEMP1.executeUpdate(str3);

			 str4="insert into hr_setpaycat( brhid, doc_no, desc1, remarks, date,timesheet, status) "
			 		+ "select 1 brhid,@doc_no:=@doc_no+1,upper(desc_id) desc1 ,upper(desc_id) remarks ,curdate(),0,3 from "
			 		+ "(select distinct trim(pay_cat) desc_id from im_employee e left join hr_setpaycat  d on trim(d.desc1)=trim(e.pay_cat) where pay_cat!='' and d.doc_no is null  ) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from hr_setpaycat))b";
			 //System.out.println("str4============="+str4);
			 stmtEMP1.executeUpdate(str4);

			 str5="insert into my_natm (nation) (select distinct trim(e.nation) from im_employee e left join my_natm n on trim(n.nation)=trim(e.nation) where e.nation!='' and n.doc_no is null)";
			 //System.out.println("str5============="+str5);
			 stmtEMP1.executeUpdate(str5); 
			 
			 
			 conn.setAutoCommit(false);

			 String sql3 = "insert into hr_empm(brhid,date, codeNo, name,  dtjoin, acno, acc_curid, pmaddr, praddr, pmmob, prmob, pmemail, premail, "
		    			+ " city, state, pincode, nationality, religion, nairport, pob,  dob, dtype, nationId, cmpId, mstatus, Gender, status, fatherName, "
		    			+ "  motherName, bloodGroup, age, grpNo, spouseName, others, curId, active, calendar,est_code,  "
		    			+ " curbrhid,  catId,  agent_id,desc_id, dept_id, pay_catid, "
		    			+ "    costperhour,salary_paid, travels, terminal_benefits, "
		    			+ "     empuserlink,emp_id,co_name) "
		    			+ "select if(a.brhid='' ,1,a.brhid) brhid,curdate() date,a.codeno codeNo,a.name name,if(a.dtjoin='null',null, dtjoin) dtjoin,h.doc_no acno,1 acc_curid, "
		    			+ " pmaddr, praddr, pmmob, prmob, pmemail, premail, city,state, pincode, nationality, religion,a.nearest nairport,a.pob,if(dob='null',null,dob) dob, "
		    			+ " 'EMP' dtype,n.doc_no nation,1 cmp, mstatus,if(gender='MALE','M','F') Gender,3 status, fatherName, "
		    			+ " motherName, bloodGroup, if(age='',0,age) age,0 grpNo, spouseName,a.id others,1 curr,1 active,0 calendar,est_code,  "
		    			+ " 0 curbrhid,0 category,if(agent='WPS','1','2') agent, "
		    			+ "  d.doc_no desig,dt.doc_no dept,pt.doc_no pay_catid, "
		    			+ "'0.0000' costperhour,if(dtjoin='null',null,DATE_ADD(dtjoin,INTERVAL -1 DAY) )salary_paid, if(travels='',0.00,travels) travels, if(dtjoin='null',null,DATE_ADD(dtjoin,INTERVAL -1 DAY) )terminal_benefits,  "
		    			+ " 0 empuserlink,employee_id ,cmp from im_employee a   "
		    			+ "left join my_head h on h.OLDCODENO=a.codeNo and trim(h.description)=trim(a.name) and h.den=301 "
		    			+ " left join my_natm n on trim(n.nation)=trim(a.nationality) "
		    			+ " left join hr_setdept dt on trim(dt.desc1)=trim(a.dept) "
		    			+ " left join hr_setpaycat pt on trim(pt.desc1)=trim(a.pay_cat) "
		    			+ " left join hr_setdesig d on trim(a.desig)=trim(d.desc1)  ";
		    	//System.out.println("sql3============="+sql3);
 stat=stmtEMP.executeUpdate(sql3);				 
if (stat!=0)
{

	 strins1="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
			+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='VISA') DOCID,doc_idno_visa ,if(VISSUEDATE='null',null,VISSUEDATE) VISSUEDATE,if(VEXPDATE='null',null,VEXPDATE) VEXPDATE,VPLACEOFISSUE,'','VISA' "
			+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_visa is not null ";
	 System.out.println("strins1============="+strins1);
	 stmtEMP.executeUpdate(strins1);

 strins2="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
		+ " "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='PASSPORT') DOCID,DOC_IDNO_PASSPORT,if(PISSUEDATE='null',null,PISSUEDATE) PISSUEDATE,if(PEXPDATE='null',null,PEXPDATE) PEXPDATE,PPLACEOFISSUE,'','PASSPORT' "
		+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where DOC_IDNO_PASSPORT is not null ";
 System.out.println("strins2============="+strins2);
 stmtEMP.executeUpdate(strins2);

 strins3="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
		+ " "
		+ " SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='EMIRATES') DOCID,doc_idno_EMIRATESid,if(EISSUEDATE='null',null,EISSUEDATE) EISSUEDATE,if(EEXPDATE='null',null,EEXPDATE) EEXPDATE,EPLACEOFISSUE,'','EMIRATES' "
		+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_EMIRATESid is not null ";
 System.out.println("strins3============="+strins3);
 stmtEMP.executeUpdate(strins3);

 strins4="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
		+ " "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='LABOUR') DOCID,doc_idno_labourcard,if(LISSUEDATE='null',null,LISSUEDATE) LISSUEDATE,if(LEXPDATE='null',null,LEXPDATE) LEXPDATE,LPLACEOFISSUE,'','LABOUR CARD' "
		+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_labourcard is not null ";
 System.out.println("strins4============="+strins4);
 stmtEMP.executeUpdate(strins4);

 
 strins8="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
			+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='MEDICAL') DOCID,doc_idno_medicalcard,if(MISSUEDATE='null',null,MISSUEDATE) MISSUEDATE,if(MEXPIRYDATE='null',null,MEXPIRYDATE) MEXPIRYDATE,MPLACEOFISSUE,'','MEDICAL CARD' "
			+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_MEDICALCARD is not null ";
	 System.out.println("strins8============="+strins8);
	 stmtEMP.executeUpdate(strins8);

	 
	 strins9="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
				+ " "
				+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='LICENCE') DOCID,doc_idno_LICENSE,if(LIISSUEDATE='null',null,LIISSUEDATE) LIISSUEDATE,if(LIEXPDATE='null',null,LIEXPDATE) LIEXPDATE,LIPLACEOFISSUE,'','LICENCE' "
				+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_license is not null ";
		 System.out.println("strins9============="+strins9);
		 stmtEMP.executeUpdate(strins9);

 
 strins5="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
		+ "SELECT M.DOC_NO RDOCNO,0 a,0 b,E.BASIC_SALARY FROM  im_employee  E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=0 where em.rdocno is null order by m.doc_no ";
 System.out.println("strins5============="+strins5);
 stmtEMP.executeUpdate(strins5);

strins51="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='HRA') a,'ALC' b,E.HRA FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='HRA') where em.rdocno is null and e.hra!='' order by m.doc_no  ";
System.out.println("strins51============="+strins51);
stmtEMP.executeUpdate(strins51);

strins52="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='TA') a,'ALC' b,E.TA FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='TA') where em.rdocno is null and e.TA!='' order by m.doc_no   ";
System.out.println("strins52============="+strins52);
stmtEMP.executeUpdate(strins52);

strins53="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='OT') a,'ALC' b,E.OTHERS FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='OT') where em.rdocno is null and e.OTHERS!='' order by m.doc_no ";
System.out.println("strins53============="+strins53);
stmtEMP.executeUpdate(strins53);

strins54="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
		+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='CAR ALLOWANCE') a,'ALC' b,E.CARALLOWANCE FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='CAR ALLOWANCE') where em.rdocno is null and e.CARALLOWANCE!='' order by m.doc_no  ";
System.out.println("strins54============="+strins54);
stmtEMP.executeUpdate(strins54);

strins6="insert into hr_incrm ( doc_no, date, dtype, month, year, empId, upto, deptId, catId, desigId, RefDocNo, status, brhid, revised, revdeptId, revcatId, "
		+ "revdesigId, userId, cmpId, onHold, remarks) "
		+ "select @doc_no:=@doc_no+1, coalesce(dtjoin,curdate()) dtjoin,'EMP' dtype , month(dtjoin), year(dtjoin),doc_no,dtjoin,  dept_id, pay_catid, desc_id, "
		+ "1 RefDocNo,3 status, if(brhid='',1,brhid) brhid,0 revised,0 revdeptId,0 revcatId,0 revdesigId,1 userId,1 cmpId,0 onHold,'EMPLOYEE MASTER' remarks from hr_empm ,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from hr_incrm)) m   ";
 System.out.println("strins6============="+strins6);
 stmtEMP.executeUpdate(strins6);

 strins7="insert into hr_incrd (sr_no,  rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded,  "
		+ "remarks)  "
		+ "select coalesce(s.awlId,0) awlId,i.doc_no,s.awlId,s.refdtype,s.addition, s.deduction,s.statutorydeduction,s.addition,0.0000 revded,  "
		+ "0.0000 revstatded,0 remarks from hr_empsal s  "
		+ "left join hr_incrm i on i.empid=s.rdocno "; 
 System.out.println("strins7============="+strins7);
 stmtEMP.executeUpdate(strins7);


conn.commit();
System.out.println("Committ****");


}
stmtEMP.close();
stmtEMP1.close();

			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
	
	public JSONArray accountGrid() throws SQLException {  
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select UPPER(emp.name) description  from im_employee emp left join my_head seg on UPPER(emp.name)=UPPER(seg.description) where seg.doc_no is  null  and emp.name!='')a group by description";  
		    	 //System.out.println("acc============="+sql3);   
		    	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
  }
	
	public JSONArray designationGrid() throws SQLException {   
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select UPPER(emp.desig) desc1  from im_employee emp left join hr_setdesig seg on UPPER(emp.desig)=UPPER(seg.desc1) and seg.status=3  where seg.doc_no is  null  and emp.desig!='')a group by desc1";  
		    	 //System.out.println("dat============="+sql3);   
		    	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
 }
	
	public JSONArray nationGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(emp.nationality) nationality  from im_employee emp left join my_natm nat on UPPER(emp.nationality)=UPPER(nat.nation)  where  nat.doc_no is null and emp.nationality!='')a group by nationality;"; 
			 	 //System.out.println("nation============="+sql3); 
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();  
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
  }
	
	public JSONArray departmentGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(emp.dept) department  from im_employee emp left join hr_setdept nat on UPPER(emp.dept)=UPPER(nat.desc1)  where  nat.doc_no is null and emp.dept!='')a group by department;"; 
			 	 System.out.println("department============="+sql3); 
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();  
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
 }
	
	public JSONArray payrollGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(emp.pay_cat) paycat  from im_employee emp left join hr_setpaycat nat on UPPER(emp.pay_cat)=UPPER(nat.desc1)  where  nat.doc_no is null and emp.pay_cat!='')a group by paycat;"; 
			 	 System.out.println("department============="+sql3); 
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();  
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}
}
