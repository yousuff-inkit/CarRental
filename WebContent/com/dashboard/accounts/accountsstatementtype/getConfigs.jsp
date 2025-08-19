<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql1 = "select method from gl_config where field_nme='ARProjectWise'";
		ResultSet rs1 = stmt.executeQuery(strSql1);
		int method1=0;
		while(rs1.next()) {
			method1=rs1.getInt("method");
		}   
		
		String strSql2 = "select method from gl_config where field_nme='raprint'";
		ResultSet rs2 = stmt.executeQuery(strSql2);
		int method2=0;
		while(rs2.next()) {
			method2=rs2.getInt("method");
		} 
		
		String strSql3 = "select method from gl_config where field_nme='AccountStatementCurrBalance'";
		ResultSet rs3 = stmt.executeQuery(strSql3);
		int method3=0;
		while(rs3.next()) {
			method3=rs3.getInt("method");   
		}
		String configSql="select method from gl_config where field_nme='acStmtAgmtDetails'";
		ResultSet configrs=stmt.executeQuery(configSql);
		int configMethod=0;
		while(configrs.next()){
			configMethod=configrs.getInt("method");
		}
		String configSqlAll="select method from gl_config where field_nme='accountstatementAll'";
		ResultSet configrsall=stmt.executeQuery(configSqlAll);
		int configMethodAll=0;
		while(configrsall.next()){
			configMethodAll=configrsall.getInt("method");
		}
                String configSqlXl="select method from gl_config where field_nme='accountstatementXl'";
		ResultSet configrsXl=stmt.executeQuery(configSqlXl);
		int configMethodXl=0;
		while(configrsXl.next()){
			configMethodXl=configrsXl.getInt("method");
		}
		System.out.println("method=="+method1+"####"+method2+"####"+method3+"####"+configMethod+"####"+configMethodAll+"####"+configMethodXl);
		response.getWriter().write(method1+"####"+method2+"####"+method3+"####"+configMethod+"####"+configMethodAll+"####"+configMethodXl);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  