package com.finance.transactions.hrjournalvouchers;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJournalVouchersDAO {
	
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsJournalVouchersBean journalVouchersBean = new ClsJournalVouchersBean();
	
	
	
	public JSONArray journalVoucherGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
          	return RESULTDATA;
          }
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
        		a=1;
        	}
        }
        if(a==0){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtJVT = conn.createStatement();
			
				
				
				int amtdec=2;
				String sqlDecimal="select cvalue value from my_system where codeno='amtdec';";
			   // System.out.println("sqlDecimal:"+sqlDecimal);

				ResultSet rsDecimal=stmtJVT.executeQuery(sqlDecimal);
				if(rsDecimal.next())
				{
					amtdec=rsDecimal.getInt("value");
				}
				int curdec=2;
				String cursqlDecimal="select cvalue value from my_system where codeno='curdec';";
			 //   System.out.println("cursqlDecimal:"+cursqlDecimal);

				ResultSet currsDecimal=stmtJVT.executeQuery(cursqlDecimal);
				if(currsDecimal.next())
				{
					curdec=currsDecimal.getInt("value");
				}
			   
				
				
				
				
				String sql="SELECT j.acno docno,cr.code curr,j.rate rates,j.description,j.curId currencyid,round(j.rate,"+curdec+") rate,if(j.dramount>0,round(j.dramount*j.id,"+amtdec+"),0)debit ,"
						+ "if(j.dramount<0,round(j.dramount*j.id,"+amtdec+"),0) credit,round(j.ldramount*j.id,"+amtdec+") baseamount,j.ref_row sr_no,j.costtype,j.costcode,c.costgroup,t.atype type,"
						+ "t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype FROM my_jvtran j left join my_costunit c on j.costtype=c.costtype left join "
						+ "my_head t on j.acno=t.doc_no left join my_curr cr on cr.doc_no=j.curId WHERE j.status<>7 and j.dtype='JVT' and j.brhId='"+branch+"' and j.doc_no='"+docNo+"'";
				ResultSet resultSet = stmtJVT.executeQuery (sql);
//System.out.println("main query========="+sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtJVT.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray journalVoucherGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))){
		      	return RESULTDATA;
		    }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtJVT = conn.createStatement();
		
			        String sqltest="";
			        String sql="";
			        java.sql.Date sqlDate=null;
			        
			        date.trim();
			           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
			           {
			        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
			           }
			        
			        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
			        }
			        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
			        }
			        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and c.code like '%"+currency+"%'";
				    }
			        
			        
			        int amtdec=2;
					String sqlDecimal="select cvalue value from my_system where codeno='amtdec';";
				   // System.out.println("sqlDecimal:"+sqlDecimal);

					ResultSet rsDecimal=stmtJVT.executeQuery(sqlDecimal);
					if(rsDecimal.next())
					{
						amtdec=rsDecimal.getInt("value");
					}
					int curdec=2;
					String cursqlDecimal="select cvalue value from my_system where codeno='curdec';";
				 //   System.out.println("cursqlDecimal:"+cursqlDecimal);

					ResultSet currsDecimal=stmtJVT.executeQuery(cursqlDecimal);
					if(currsDecimal.next())
					{
						curdec=currsDecimal.getInt("value");
					}
				   
			        
			        
		        	sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,cb.type,round(cb.rate,"+curdec+") c_rate from my_head t left join my_curr c "
					   + "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
					   + "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
					   + "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        	//System.out.println(sql);
			       ResultSet resultSet = stmtJVT.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			       stmtJVT.close();
				   conn.close();
		     }catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     }finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
	public JSONArray jvtMainSearch(HttpSession session,String docNo,String dates,String descriptions,String refNo,String amounts,String check) throws SQLException {
	   	   
		   JSONArray RESULTDATA=new JSONArray();
		   
		   if(!(check.equalsIgnoreCase("1"))){
		      	return RESULTDATA;
		   }
		   
		   Connection conn = null;
	   	    
	   	   Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	      return RESULTDATA;
	   	     }
	    	    	
	        String branch=session.getAttribute("BRANCHID").toString();

	        java.sql.Date sqlStartDate=null;
	    	
			try {
					conn = connDAO.getMyConnection();
					Statement stmtJVT = conn.createStatement();
            
					dates.trim();
			    	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			    	{
			    	sqlStartDate = commonDAO.changeStringtoSqlDate(dates);
			    	}
			    	
			    	String sqltest="";
			    	
			    	if(!(docNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
			    	}
			    	 if(!(sqlStartDate==null)){
				    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
				    } 
			    	if(!(descriptions.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.description like '%"+descriptions+"%'";
			    	}
			    	if(!(refNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.refNo like '%"+refNo+"%'";
			    	}
			    	if(!(amounts.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.drtot like '%"+amounts+"%'";
			    	}
			    	
			    	String strSqlss = "select method,description from gl_config where field_nme='jvtRefid'";
					ResultSet rs3 = stmtJVT.executeQuery(strSqlss);
					//System.out.println("CONFIG VAL-----"+strSqlss);
					int method=0;
					String description="";
					while(rs3.next()) {
						method=rs3.getInt("method");
						description=rs3.getString("description");
					} 
					
					 String[] words=description.split("####");
						//System.out.println(words[0]+"=="+words[1]);
						
						
						if(method==1) {
						
							sqltest=sqltest+" and m.refid in("+words[1]+")";
							
						}
						
						
			    	
			    	
			    	
					String sql5 = "SELECT m.doc_no,m.date,m.description,m.refno,m.drtot,m.tr_no,j.costtype,if(d.menu_name is null,' ',if(m.refid=1,' ',concat('AUTO POSTED : ',d.menu_name))) menu_name FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_jvidentifyingid d on m.refid=d.jvid "
							+ "where m.dtype='JVT' and m.status<>7  and m.brhId="+branch+"" +sqltest+" group by m.tr_no";
					//System.out.println("mainsearch-------"+sql5);
					ResultSet resultSet = stmtJVT.executeQuery(sql5);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
						
					stmtJVT.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }

			return RESULTDATA;
	    }
	
	public ClsJournalVouchersBean getViewDetails(String branch,int docNo) throws SQLException {
		
		ClsJournalVouchersBean journalVouchersBean = new ClsJournalVouchersBean();
		
		Connection conn = null;
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtJVT = conn.createStatement();
		
			
			
			String strSqlss = "select method,description from gl_config where field_nme='jvtRefid'";
			ResultSet rs3 = stmtJVT.executeQuery(strSqlss);
			//System.out.println("CONFIG VAL-----"+strSqlss);
			int method=0;
			String description="";
			while(rs3.next()) {
				method=rs3.getInt("method");
				description=rs3.getString("description");
			} 
			
			 String[] words=description.split("####");
				System.out.println(words[0]+"=="+words[1]);
				
				String sqltest="";
				if(method==1) {
				
					sqltest=sqltest+" and m.refid in("+words[1]+")";
					
				}
				
			ResultSet resultSet = stmtJVT.executeQuery ("SELECT m.doc_no,m.date,m.description,m.refno,m.drtot,m.crtot,m.tr_no,if(d.menu_name is null,' ',if(m.refid=1,' ',concat('AUTO POSTED : ',d.menu_name))) menu_name, m.status "  
					+ "FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_jvidentifyingid d on m.refid=d.jvid where m.dtype='JVT' and m.status<>7  and m.brhId="+branch+" and m.doc_no="+docNo+" "+sqltest+" group by doc_no");
		
			while (resultSet.next()) {
				journalVouchersBean.setTxtjournalvouchersdocno(docNo);
				journalVouchersBean.setJqxJournalVouchersDate(resultSet.getDate("date").toString());
				journalVouchersBean.setTxtrefno(resultSet.getString("refno"));
				journalVouchersBean.setTxtdescription(resultSet.getString("description"));
				journalVouchersBean.setTxttrno(resultSet.getInt("tr_no"));
				journalVouchersBean.setTxtdrtotal(resultSet.getDouble("drtot"));
				journalVouchersBean.setTxtcrtotal(resultSet.getDouble("crtot"));
				journalVouchersBean.setMaindate(resultSet.getDate("date").toString());
				journalVouchersBean.setLblformposted(resultSet.getString("menu_name"));
				journalVouchersBean.setStatus(resultSet.getInt("status"));
		    }
		  stmtJVT.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return journalVouchersBean;
		}

	public ClsJournalVouchersBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsJournalVouchersBean bean = new ClsJournalVouchersBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtJVT = conn.createStatement();
			
			String headersql="select m.status,if((m.status<3 or m.status=4),1,0) wtrmrk,if(m.dtype='JVT','Journal Voucher','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_jvma m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='JVT' "
					+ " and m.brhid="+branch+" and m.doc_no="+docNo+"";

				ResultSet resultSetHead = stmtJVT.executeQuery(headersql);
				
				while(resultSetHead.next()){
					
					bean.setStatus(resultSetHead.getInt("status"));
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
					bean.setWatermark(resultSetHead.getString("wtrmrk"));
				}
			
			String sqls="select m.doc_no,coalesce(u3.user_name,'') approved,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.description,m.refNo,format(round(m.drtot,2),2) netAmount,u.user_name,coalesce(u2.user_name, u1.user_name)  verifiedappr from my_jvma m left join "
				+ "my_user u on m.userid=u.doc_no left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprLEVEL=1  and m.brhid=ext.brhid) left join my_exdet ext0 on (m.doc_no=ext0.doc_no and m.dtype=ext0.dtype and ext0.apprLEVEL=0  and m.brhid=ext0.brhid) left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprLEVEL=2  and m.brhid=ext1.brhid) left join my_exdet ext2 on (m.doc_no=ext2.doc_no and m.dtype=ext2.dtype   and ext2.apprLEVEL=3  and m.brhid=ext2.brhid) left join my_user u1 on ext.userid=u1.doc_no left join my_user u2 on ext1.userid=u2.doc_no left join my_user u3 on ext2.userid=u3.doc_no where m.dtype='JVT'  and m.brhid="+branch+" and m.doc_no="+docNo+"";
	
			ResultSet resultSets = stmtJVT.executeQuery(sqls);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSets.next()){
				
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLblrefno(resultSets.getString("refNo"));
				bean.setLbldescription(resultSets.getString("description"));

				bean.setLblnetamount(resultSets.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("netAmount").replace(",", "")));
				
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
				bean.setApproved(resultSets.getString("approved"));
				bean.setVerified(resultSets.getString("verifiedappr"));
			}
			
			bean.setTxtheader(header);

			String sql1 = "";
		
			
			
			int amtdec=2;
			String sqlDecimal="select cvalue value from my_system where codeno='amtdec';";
		    //System.out.println("sqlDecimal:"+sqlDecimal);

			ResultSet rsDecimal=stmtJVT.executeQuery(sqlDecimal);
			if(rsDecimal.next())
			{
				amtdec=rsDecimal.getInt("value");
			}
			int curdec=2;
			String cursqlDecimal="select cvalue value from my_system where codeno='curdec';";
		   // System.out.println("cursqlDecimal:"+cursqlDecimal);

			ResultSet currsDecimal=stmtJVT.executeQuery(cursqlDecimal);
			if(currsDecimal.next())
			{
				curdec=currsDecimal.getInt("value");
			}
		   
			
			
			sql1="SELECT t.account,t.description accountname,j.description,c.code currency,if(j.dramount>0,round((j.dramount*1),"+amtdec+"),'  ') debit,if(j.dramount<0,round((j.dramount*-1),"+amtdec+"),'  ') credit, "
			  + "CONVERT(if(j.costtype=0,' ',coalesce(co.costgroup,' ')),CHAR(100)) costtype,CONVERT(if(j.costcode=0,' ',coalesce(j.costcode,' ')),CHAR(100)) costcode FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no "
			  + "left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_costunit co on j.costtype=co.costtype WHERE m.dtype='JVT'  and m.brhid="+branch+" "
			  + "and m.doc_no="+docNo+" ";
			
			/*order by j.dramount desc*/
//			System.out.println("jvt print query======"+sql1);
			
			ResultSet resultSet1 = stmtJVT.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				
				if(commonDAO.getPrintPath("JVT").contains("journalVoucherCostTypePrint.jsp")==true) {
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("costtype")+"::"+resultSet1.getString("costcode")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				} else {
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				}
				printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql22 = "";
			
			sql22="SELECT t.account,t.atype acctype,t.description accountname,j.description,c.code currency,if(j.dramount>0,round((j.dramount*1),"+amtdec+"),'  ') debit,if(j.dramount<0,round((j.dramount*-1),"+amtdec+"),'  ') credit, "
			  + "CONVERT(if(j.costtype=0,' ',coalesce(co.costgroup,' ')),CHAR(100)) costtype,CONVERT(if(j.costcode=0,' ',coalesce(j.costcode,' ')),CHAR(100)) costcode FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no "
			  + "left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_costunit co on j.costtype=co.costtype WHERE m.dtype='JVT'   and m.brhid="+branch+" "
			  + "and m.doc_no="+docNo+" ";
			/*order by j.dramount desc*/
//			System.out.println("jvt print query======"+sql22);
			
			ResultSet resultSet22 = stmtJVT.executeQuery(sql22);
			
			ArrayList<String> printarraynew= new ArrayList<String>();
			
			while(resultSet22.next()){
				bean.setFirstarray(1); 
				String temp="";
				
				if(commonDAO.getPrintPath("JVT").contains("journalVoucherCostTypePrint.jsp")==true) {
					temp=resultSet22.getString("account")+"::"+resultSet22.getString("acctype")+"::"+resultSet22.getString("accountname")+"::"+resultSet22.getString("description")+"::"+resultSet22.getString("currency")+"::"+resultSet22.getString("costtype")+"::"+resultSet22.getString("costcode")+"::"+resultSet22.getString("debit")+"::"+resultSet22.getString("credit");
				} else {
					temp=resultSet22.getString("account")+"::"+resultSet22.getString("acctype")+"::"+resultSet22.getString("accountname")+"::"+resultSet22.getString("description")+"::"+resultSet22.getString("currency")+"::"+resultSet22.getString("debit")+"::"+resultSet22.getString("credit");
				}
				printarraynew.add(temp);
			}

			request.setAttribute("printingarraynew", printarraynew);
			
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_jvma m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='JVT'  and m.brhid="+branch+" and m.doc_no="+docNo+"";
			ResultSet resultSet2 = stmtJVT.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtJVT.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}


}
