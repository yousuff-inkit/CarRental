package com.connection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ClsConnection {
	Statement stmt=null;
	
	public Connection getMyConnection()
	{
		Connection conn = null;
		try {
			Context initCtx = new InitialContext();
			DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
			conn = ds.getConnection();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
	}
	public String execute ()
	{
		try{
				Connection conn = getMyConnection();
				Statement stmt = conn.createStatement();
				String strSql = "select * from my_menu limit 5";
				ResultSet rs = stmt.executeQuery (strSql);
				while (rs.next ()) {
				//System.out.println (rs.getString ("MENU_NAME"));
				}
				conn.close ();
				stmt.close ();
		}
		catch(Exception e){
				e.printStackTrace();
		}
		return "success";
	}

}
