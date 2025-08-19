package com.limousine.autoemail;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;

public class AutoEmail  extends TimerTask {

	ClsConnection connobj=new  ClsConnection();
	ClsCommon com= new ClsCommon();
	
	@Override
	public void run() {
		//Connection conn = connobj.getMyConnection();
		String result="";

		//HttpServletRequest request=ServletActionContext.getRequest();
		//HttpSession session=request.getSession();
		try{
			process();
			System.out.println("Exit");
		}
		catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		finally{
		}

		result="success";
		
	}

	public String process() throws ParseException, SQLException{
		Connection conn = connobj.getMyConnection();
		try {
			System.out.println("TEst");	
		//	HttpServletRequest request=ServletActionContext.getRequest();
		//	HttpSession session=request.getSession();
		//    HttpServletResponse response = ServletActionContext.getResponse();
		    Statement stmt = conn.createStatement();
		    
		    DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
			java.util.Date date = new java.util.Date();
			String currdate=dateFormat.format(date);
			EmailProcess ep=new EmailProcess();
		    String ipath="";
			String company="";
		    String subject="Bookings of Limousine "+currdate+"";
		    String message= subject+" is attached ";
		    String fileName = "BookingManagement-"+currdate+".xlsx";
			String formcode="";
			String email="";
			String port="";
			String host="";
			String userName="";
			String password="";
			String query="";
			
			String getSender = "select mail,mailpass,smtpserver,smtphostport from my_user where user_id='super'";
			ResultSet rsgs = stmt.executeQuery(getSender);
			if(rsgs.next()) {
				port=rsgs.getString("smtphostport");
				host=rsgs.getString("smtpserver");
				userName=rsgs.getString("mail");
				password=rsgs.getString("mailpass");
			}
			
			
			
			ResultSet rse=stmt.executeQuery("select company,imgPath from my_comp");
			   while(rse.next()){
				   ipath=rse.getString("imgPath");
				   company=rse.getString("company");
			   }
			
			   
			 String strSql = "select dtype,loadcond,emails from  gl_prjemail where status=3 and dtype='LBK'";
			 ResultSet rs = stmt.executeQuery(strSql);
			 while(rs.next()){
				 formcode=rs.getString("dtype");
				 query=rs.getString("loadcond");
				 email=rs.getString("emails");
			 }
			 String filepath=ipath+ "/attachment/"+formcode+"/"+fileName;
			 File dir = new File(ipath+ "/attachment/"+formcode); 
		  	 dir.mkdirs();
			 excelGenerator(query,filepath);
			 File saveFile=new File(filepath);
			 ep.sendEmailwithpdf(host, port, userName,ClsEncrypt.getInstance().decrypt(password), email, subject, message, saveFile, "1");
			// ep.sendEmailwithpdfNoAuth(host, port, userName, email, subject, message, saveFile, "1");
			} catch(Exception e) {
				e.printStackTrace();
			}finally{
				conn.close();
			}

			return "success";
	}
	
	public void excelGenerator(String query,String path) throws SQLException {
		Connection conn = connobj.getMyConnection();
		boolean result=false;
		try {
			Statement stmt = conn.createStatement();
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			
			Workbook workbook = new XSSFWorkbook();
		    Sheet sheet = workbook.createSheet("Report");
		    writeHeader(sheet, rs);
		            writeData(sheet, rs);

		    FileOutputStream fileOut = new FileOutputStream(path); 
		     workbook.write(fileOut);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	}	
		private static void writeHeader(Sheet sheet, ResultSet rs) throws SQLException {
	        Row headerRow = sheet.createRow(0);
	        ResultSetMetaData metaData = rs.getMetaData();
	        CellStyle headerStyle = createHeaderStyle(sheet.getWorkbook());

	        for (int i = 1; i <= metaData.getColumnCount(); i++) {
	            Cell cell = headerRow.createCell(i - 1);
	            cell.setCellValue(metaData.getColumnName(i));
	            cell.setCellStyle(headerStyle);
	        }
	    }

	    private static void writeData(Sheet sheet, ResultSet rs) throws SQLException {
	        int rowNum = 1;
	        while (rs.next()) {
	            Row row = sheet.createRow(rowNum++);
	            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
	                row.createCell(i - 1).setCellValue(rs.getString(i));
	            }
	        }
	    }
	
	    private static CellStyle createHeaderStyle(Workbook workbook) {
	        CellStyle style = workbook.createCellStyle();
	        Font font = workbook.createFont();
	        font.setBold(true);
	        font.setFontHeightInPoints((short) 12);
	        style.setFont(font);
	        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	        return style;
	    }
}
