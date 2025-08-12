package com.dashboard.importdata.productmaster;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProductmasterDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray promasterGridLoading() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			     
			     
		    	String sql3 = "select psrno psrno, code procode, name proname, dept dept, category category, subcategory subcategory, unit unit, type protype, brand brand, barcode barcode, unitprice unitprice, star star, quantity quantity, priceval value from im_product";
		    	System.out.println("sql3============="+sql3);
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

	
	public JSONArray ProductListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 int status1=0;
			 	int stat,stat1=0;
				
			 String str1="",str2="",str3="",str4="",str5="",str6=""; 
			 
			 str1="insert into my_catm(Category, DATE,  status, CAT)\r\n"
			 		+ "select distinct a.category, now(), 3, a.category from im_product a left join my_catm m on upper(replace(m.category,' ','')) = upper(replace(a.category,' ','')) where a.category is not null and m.doc_no is null";
			 System.out.println("str1============="+str1);

			 
			/* str2="insert into my_scatm(SubCategory, DATE,  catid,status,scat)\r\n"
				 		+ "select distinct if(p.subcategory='' or p.subcategory is null,if(cc.category='' or cc.category is null,'General',concat(cc.category,' ','General')),p.subcategory) subcategory , now(),cc.doc_no,3,if(p.subcategory='' or p.subcategory is null,if(cc.category='' or cc.category is null,'General',concat(cc.category,' ','General')),p.subcategory) subcategory from im_product p left join my_catm cc on p.category=cc.category left join my_scatm c on upper(replace(c.subcategory,' ','')) = upper(replace(if(p.subcategory='' or p.subcategory is null,if(cc.category='' or cc.category is null,'General',concat(cc.category,' ','General')),p.subcategory),' ',''))  where p.subcategory is not null  and c.doc_no is null group by subcategory";     
			 System.out.println("str2============="+str2);*/
			 str2="insert into my_scatm(SubCategory, DATE,  catid,status,scat)\r\n"
				 		+ "select distinct if(p.subcategory='' or p.subcategory is null,'General',p.subcategory) subcategory , now(),cc.doc_no,3,if(p.subcategory='' or p.subcategory is null,'General',p.subcategory) subcategory from im_product p left join my_catm cc on p.category=cc.category left join my_scatm c on upper(replace(c.subcategory,' ','')) = upper(replace(if(p.subcategory='' or p.subcategory is null,'General',p.subcategory),' ','')) and c.catid=cc.doc_no where p.subcategory is not null  and c.doc_no is null";     
			 System.out.println("str2============="+str2);

			 str3="insert into my_dept(department, DATE,  status,dept)\r\n"
			 		+ "select distinct a.dept ,now(),3,a.dept from im_product a  left join my_dept c on upper(replace(c.department,' ','')) = upper(replace(a.dept,' ','')) where a.dept is not null and c.doc_no is null";
			 System.out.println("str3============="+str3);

			 str4="INSERT INTO MY_BRAND( BRAND, brandName, date, userId, status)\r\n"
			 		+ "SELECT  distinct a.brand,a.brand,now(),1,3 from im_product a left join my_brand c on upper(replace(c.brand,' ','')) = upper(replace(a.brand,' ','')) where a.brand is not null and c.doc_no is null";
			 System.out.println("str4============="+str4);

			 str5="INSERT INTO MY_PTYPE( PRODUCTTYPE, date, status, PTYPE)\r\n"
			 		+ "SELECT  distinct a.type,now(),3,a.type from im_product a left join my_ptype c on upper(replace(c.PRODUCTTYPE,' ','')) = upper(replace(a.type,' ','')) where a.type is not null and c.doc_no is null";
			 System.out.println("str5============="+str5);
			
			 str6="insert into my_unitm(UNIT, UNIT_DESC, status)\r\n"
			 		+ "select distinct a.unit,a.unit,3 from im_product a left join my_unitm c on upper(replace(c.UNIT,' ','')) = upper(replace(a.unit,' ','')) where a.unit is not null and c.doc_no is null";

				 System.out.println("str5============="+str5);
				
				 
			int val1,val2,val3,val4,val5,val6=0;	
				 
			val1= stmtEMP1.executeUpdate(str1);
		    val2= stmtEMP1.executeUpdate(str2);
			val3=stmtEMP1.executeUpdate(str3);
			val4= stmtEMP1.executeUpdate(str4);
			val5= stmtEMP1.executeUpdate(str5);   	
			val6= stmtEMP1.executeUpdate(str6);
			
			/*
			 * conn.setAutoCommit(false); if(val1>0 || val2>0 || val3>0 || val4>0 || val5>0
			 * || val6>0) { conn.commit(); }
			 */
			 
			  conn.setAutoCommit(false);



			  String sql3 = "INSERT INTO  my_main(psrno, part_no, ProductName, deptId, catId, scatid, MUNIT, is_sub, date, entrydate, TYPEID, specId,  brandId,stdprice,doc_no, withTax, batchType, tax, dtype, VAT, CST, preVAT, preCST, fms, altpsrno,status,barcode,COMP_BRCH,fixingprice)select @psrno:=@psrno+1,@psrno code, name, dept, category, subcategory, unit, 0, curdate(), now(), type, specid, brand,stdprice, @psrno doc_no,0,0,0,'prd',0,0,0,0,0,0,3,barcode,'c',fixingprice from(select code, name, d.doc_no dept, c.doc_no category, s.doc_no  subcategory , u.doc_no unit,p.doc_no type,0 specid, b.doc_no brand, @psrno doc_no,m.barcode,coalesce(if(m.unitprice='',0,m.unitprice),0)stdprice ,coalesce(if(m.unitprice='',0,m.unitprice),0)fixingprice\r\n"
				 		+ "from im_product M left join my_main mm on  upper(replace(mm.productname,' ','')) = upper(replace(m.name,' ','')) \r\n"
				 		+ "left join my_dept d on upper(replace(d.department,' ','')) = upper(replace(m.dept,' ',''))\r\n"
				 		+ "left JOIN my_CATM C ON upper(replace(c.category,' ','')) = upper(replace(m.category,' ',''))\r\n"
				 		+ "left JOIN my_UNITM U ON upper(replace(u.UNIT,' ','')) = upper(replace(m.unit,' ',''))\r\n"
				 		+ "left JOIN my_brand b on  upper(replace(b.brand,' ','')) = upper(replace(m.brand,' ',''))\r\n"
				 		+ "LEFT JOIN MY_PTYPE P ON upper(replace(p.PRODUCTTYPE,' ','')) = upper(replace(m.type,' ',''))\r\n"
				 		+ "left join my_scatm s on upper(replace(s.subcategory,' ','')) = upper(replace(if(m.subcategory='' or m.subcategory is null,'General',m.subcategory),' ','')) and s.catid=c.doc_no where mm.doc_no is null)a,(select @psrno:=(select coalesce(max(psrno),0) psrno from my_main)) b";
			    System.out.println("sql3============="+sql3);
                  stat=stmtEMP.executeUpdate(sql3);				 
if (stat>0) {
	 conn.commit();
}

       conn.setAutoCommit(false);

       String sql4="insert into my_desc(psrno, op_stock, brhid, cmpid, op_cost, PRICE1, PRICE2, PRICE3, minStock, maxStock, last_price, bin,discontinued, reorderlevel, reorderqty)\r\n"
		+ "select psrno,0,1,1,0,0,0,0,0,0,0,0,0,0,0 from my_main order by psrno";
System.out.println("sql4============="+sql4);

       String sql5="insert into my_prodattrib( MPSRNO, fmstype, spec1, barcode)\r\n"
       		+ "select  psrno,0,psrno,barcode from my_main";
       System.out.println("sql5============="+sql5);
    
       int val11,val12=0;	
       
       val11=stmtEMP.executeUpdate(sql4);	

       val12=stmtEMP.executeUpdate(sql5);	

       if ((val11>0)&&(val12 >0)) {
    	   conn.commit();
    	   }



     conn.setAutoCommit(false);

            String sql7="insert into my_unit(PSRNO, UNIT, FR, wt, VOLUME, SR_NO,  thk, leng, width)\r\n"
		               + "select a.psrno,a.munit,1,0,0,0,0,0,0 from my_main a left join my_unit m on upper(replace(m.unit,' ','')) = upper(replace(a.munit,' ','')) where a.munit is not null and m.doc_no is null group by a.munit";
            System.out.println("sql7====="+sql7);
        	 int val111;
            val111=stmtEMP.executeUpdate(sql7);	
     if (val111>0) {
    	 conn.commit();
    	 }
        
     conn.setAutoCommit(false);

     int tranno=0;
     String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
     System.out.println("trsql====="+trsql);
		ResultSet tass = stmtEMP.executeQuery (trsql);
		
		if (tass.next()) {
			tranno=tass.getInt("trno");		
	     }

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
		System.out.println("trnosql====="+trnosql);
		int dd=stmtEMP.executeUpdate(trnosql);
		
		
		String sql8="insert into my_prddin(psrno, tr_no, date, dtype,  fr, unitid, specno, op_qty, out_qty,\r\n"
				+ "rsv_qty,del_qty, foc, foc_out, prdid, locid, brhid, sr_no, cost_price, unit_price, pstatus )\r\n"
				+ "select m.psrno,'"+tranno+"' tr_no,(select date_sub(accyr_f, interval 1 day) from my_year),'OPN',1, m.munit,m.psrno,coalesce(if(p.quantity='' or p.quantity is null,0,p.quantity),0),0,0,0,0,0,m.psrno,1,1,1 id,\r\n"
				+ "coalesce(if(p.unitprice='',0,p.unitprice),0),coalesce(if(p.unitprice='',0,p.unitprice),0),0 from im_product p left join my_main m on upper(replace(m.productname,' ','')) = upper(replace(p.name,' ',''))left join my_prddin mm on mm.psrno=m.psrno  where p.quantity!=0  group by p.doc_no";
		System.out.println("sql8====="+sql8);
		int val01=0;
		val01=stmtEMP.executeUpdate(sql8);
		
		String sql9="insert into my_prdopening( date, userid, brhid, cmpid, opstockid, closestockid, trno )select now(),1,1,1,stockid,stockid, mm.tr_no from my_prddin mm left join my_prdopening p on p.trno=mm.tr_no where mm.op_qty!=0 and p.doc_no is null";
		System.out.println("sql9====="+sql9);
		int val011=0;
		val011=stmtEMP.executeUpdate(sql9);
		
  if ((val01>0) &&(dd>0)&&(val011>0)) {
 	 conn.commit();
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
	
	
	
}
