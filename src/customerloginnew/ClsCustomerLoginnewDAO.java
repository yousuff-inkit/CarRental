package customerloginnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsCustomerLoginnewDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	public boolean clientLogin(String clientusername, String clientpassword,   
			HttpSession session, HttpServletRequest request) throws SQLException {   
		// TODO Auto-generated method stub
		//System.out.println("in dao");
		Connection conn=null;
		try{
			int userid=0;
			String username="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			//System.out.println("===="+clientpassword);
			clientpassword=ClsEncrypt.getInstance().encrypt(clientpassword);
			//System.out.println("===="+clientpassword);
			String str="select * from my_user where user_id='"+clientusername+"' and pass='"+clientpassword+"' and status=3";
			//System.out.println("==user query=="+str);
			ResultSet rs=stmt.executeQuery(str);     
			while(rs.next()){
				userid=rs.getInt("doc_no");
				username=rs.getString("user_name");      
			}   
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){    
		    	session.setAttribute("CLDOCNO", userid);  
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",username);
		    	session.setAttribute("PORTALUSER",username);
				session.setAttribute("CLIENTNAME", username);    
				String strlog = "insert into gc_userlog (USER,WIN_USER,win_cmp,win_mac,ip,DATE_IN) values ('"+username+"','"+xuser+"','"+xcomp+"','"+mac+"','"+ip+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	

}
