package com.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
public class ClsChromeDriverAttach  extends ActionSupport{
	ClsConnection objconn=new ClsConnection();

	private File chromefile;
	private String chromefileFileName,chromefileFileContentType;

	

	public File getChromefile() {
		return chromefile;
	}

	public void setChromefile(File chromefile) {
		this.chromefile = chromefile;
	}

	public String getChromefileFileName() {
		return chromefileFileName;
	}

	public void setChromefileFileName(String chromefileFileName) {
		this.chromefileFileName = chromefileFileName;
	}

	public String getChromefileFileContentType() {
		return chromefileFileContentType;
	}

	public void setChromefileFileContentType(String chromefileFileContentType) {
		this.chromefileFileContentType = chromefileFileContentType;
	}
	
	public String execute() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
    	
    	String srno="";
    	Connection conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement();

    	String path ="";
    	try {  
    	Statement stmt1 = conn.createStatement();
		String strSql1 = "select chromedriverpath from my_comp where doc_no="+session.getAttribute("COMPANYID");

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("chromedriverpath");
		}
		path=path.split("chromedriver.exe")[0];
		System.out.println("Path:"+path);
		// ServletContext context = request.getServletContext();
    	File dir = new File(path);
   	 	dir.mkdirs();

   	 	
            File f = getChromefile();  
            FileInputStream inputStream = new FileInputStream(f);  
            FileOutputStream outputStream = new FileOutputStream(path+"chromedriver.exe",false);
            byte[] buf = new byte[3072];  
            int length = 0;  
            
            while ((length = inputStream.read(buf)) != -1) {
                outputStream.write(buf, 0, length);  
            }  

            inputStream.close();  
            outputStream.flush();  
            stmt.close();
            conn.close();
            if(outputStream!=null){
            	outputStream.close();
            }
        } catch (Exception e) {  
            e.printStackTrace();  
            conn.close();
        }
   	 	finally{
   	 		if(conn!=null){
   	 			conn.close();
   	 		}
   	 	}
		return SUCCESS;  
	}
	
}
