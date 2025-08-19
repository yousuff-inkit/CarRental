package com.dashboard.operations.riderpayroll;

import java.io.ByteArrayOutputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.view.JasperViewer;

@SuppressWarnings("serial")
public class ClsRiderPayrollAction extends ActionSupport {
	
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();

	public String printAction() throws ParseException, SQLException{
		 HttpServletRequest request=ServletActionContext.getRequest();
		 HttpSession session=request.getSession();
		 HttpServletResponse response = ServletActionContext.getResponse();	
		 ClsRiderPayrollDAO dao = new ClsRiderPayrollDAO();
		 String docnos=request.getParameter("docnos");
		 String printPathDtype="RPR";
		 String [] docnolist = docnos.substring(0, docnos.length()-1).split(",");
		 String month = request.getParameter("month") ;
		 String year = request.getParameter("year") ;
		 String branch = request.getParameter("branch") ;
		 
		 //System.out.println(month+" - "+year+" - "+branch);
		 try {
	       	   String reportFileName = commonDAO.getBIBPrintPath(printPathDtype);
			 
	       	   
	            // Compile the JRXML file
	            String reportSource = request.getSession().getServletContext().getRealPath(reportFileName);

	            JasperReport jasperReport = JasperCompileManager.compileReport(reportSource);

	            // Create a single JasperPrint object to merge all pages
	            JasperPrint mergedReport = new JasperPrint();

	            String imgpath=request.getSession().getServletContext().getRealPath("/icons/riderpayrollprintheader.jpg");
	            imgpath=imgpath.replace("\\", "\\\\");
	            // Generate multiple pages with different data
	            for (int i = 0; i < docnolist.length; i++) { // Change '5' to any number of pages you need
	                // Set dynamic parameters for each page
	            	HashMap<String, Object> parameters = dao.getPrintParameters(docnolist[i],branch,month,year);
	            	parameters.put("imgpal",imgpath);
	                // Fill the report with the new data set
	                JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JREmptyDataSource());

	                // Merge pages into the final report
	                if (mergedReport.getPages().isEmpty()) {
	                    mergedReport = jasperPrint; // First page, use it as base
	                } else {
	                    mergedReport.getPages().addAll(jasperPrint.getPages()); // Append pages
	                }
	            }

	            
	            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
	            JRPdfExporter exporter = new JRPdfExporter();
	            exporter.setExporterInput(new SimpleExporterInput(mergedReport));
	            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(byteArrayOutputStream));

	            exporter.exportReport();

	            byte[] pdfBytes = byteArrayOutputStream.toByteArray();

	            // Send PDF as response
	            response.reset();
	            response.setContentType("application/pdf");
	            response.setContentLength(pdfBytes.length);

	            ServletOutputStream outputStream = response.getOutputStream();
	            outputStream.write(pdfBytes, 0, pdfBytes.length);
	            outputStream.flush();
	            outputStream.close();


	        } catch (Exception e) {
	            e.printStackTrace();
	            addActionError("Error generating PDF: " + e.getMessage());
	            return ERROR;
	        }
	        return "print";

	}
	
}
