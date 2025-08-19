package com.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsCheckListAttach extends ActionSupport {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
    private String formdetailcode;
    
    
    public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	private String message = "";  
      
    public String getMessage() {  
        return message;  
    }  
  
    public void setMessage(String message) {  
        this.message = message;  
    }  
  
    public File getFile() {  
        return file;  
    }  
  
    public void setFile(File file) {  
        this.file = file;  
    }  
  
    public String getFileFileName() {  
        return fileFileName;  
    }  
  
    public void setFileFileName(String fileFileName) {  
        this.fileFileName = fileFileName;  
    }  
  
    public String getFileFileContentType() {  
        return fileFileContentType;  
    }  
  
    public void setFileFileContentType(String fileFileContentType) {  
        this.fileFileContentType = fileFileContentType;  
    }  
  
    @SuppressWarnings({ "deprecation", "resource" })  
    @Override  
    public String execute() throws Exception { 
    	System.out.println(" ======ATTACH ACTION====== ");
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
    	String code = request.getParameter("formdetailcode")==null?"":request.getParameter("formdetailcode").toString();
    	String doc = request.getParameter("doc")==null || request.getParameter("doc").trim().equals("")?"0":request.getParameter("doc").toString();
    	String srno = request.getParameter("srno")==null || request.getParameter("srno").trim().equals("")?"0":request.getParameter("srno").toString();
    	int cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equals("")?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());
    	int qotno=request.getParameter("quotno")==null || request.getParameter("quotno").trim().equals("")?0:Integer.parseInt(request.getParameter("quotno").trim().toString());
    	int brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
    	String attachdesc = request.getParameter("attachdesc")==null?"":request.getParameter("attachdesc").toString();
    	String fname = code+'-'+doc+'-'+srno;  
    	String fname2 = fname;

		String dirname =getFormdetailcode()==null?"Default":getFormdetailcode();
    	String path ="";
    	Connection conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement ();
		String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
		ResultSet rs = stmt.executeQuery(strSql);
		String path1="";
		while(rs.next ()) {
			path1=rs.getString("imgPath");
		}
		path=path1.replace("\\", "/");
		
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();
        try {  
            conn.setAutoCommit(false);
            File f = this.getFile();  
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 
    
            int dotindex=getFileFileName().lastIndexOf(".");
            String efile=getFileFileName().substring(dotindex+1);
            fname=fname+'.'+efile;
            FileInputStream inputStream = new FileInputStream(f);  
            
            FileOutputStream outputStream = new FileOutputStream(path + "/attachment/"+dirname+ "/"+ fname);
            byte[] buf = new byte[1024];  
            int length = 0,val=0;  
            while ((length = inputStream.read(buf)) != -1) {  
                outputStream.write(buf, 0, length);  
            }  
            Statement stmtupdate=conn.createStatement();
            String strupdate="update my_checklistdet set attach='"+fname+"',path='"+path + "/attachment/"+dirname+ "/"+ fname+"' where rowno="+srno ; 
            val=stmtupdate.executeUpdate(strupdate);
            int fileVal=0;

            if(val<=0){
            	return ERROR;
            }else {            	
            	 if(qotno>0) {
            		 if(brhid==0) {
            			 brhid = Integer.parseInt(session.getAttribute("BRANCHID").toString());   
            		 }

            		 int filesrno = 1; 
            		 
            		 System.out.println(attachdesc+"==<>=="+cldocno);   
            		 
            			 String selsql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no='"+qotno+"' and dtype='"+code+"'";
                		 ResultSet rs2 = stmtupdate.executeQuery(selsql);  
                		 if(rs2.next()) {
                			 filesrno = rs2.getInt("srno");
                		 }
                		 
                		 String strinsert="insert into my_fileattach(dtype,doc_no,brhid,sr_no,date,user,path, filename, descpt, ref_id)values('"+code+"',"+qotno+",'"+brhid+"',"+
    			                   " "+filesrno+",CURDATE(),'"+session.getAttribute("USERNAME").toString()+"','"+path + "/attachment/"+dirname+ "/"+ fname+"','"+fname+"','"+attachdesc+"',2)";
                		 fileVal = stmtupdate.executeUpdate(strinsert);  
                		 if(fileVal<=0) {
                             return ERROR;
                		 }
            	 }
            }
            if(val>0 && fileVal >0) {
                conn.commit();
            }
            inputStream.close();  
            outputStream.flush();  
            this.setMessage(path+fname);
            stmt.close();
            stmtupdate.close();
            conn.close();
        } catch (Exception e) {  
            e.printStackTrace();  
            message = "!!!!";
            conn.close();
        }  
        finally{
        	conn.close();
        }
        return SUCCESS;  
    }
}
