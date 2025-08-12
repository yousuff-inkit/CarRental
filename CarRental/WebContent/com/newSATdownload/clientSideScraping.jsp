<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.util.zip.ZipEntry"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.zip.ZipInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String chromeversion=request.getParameter("chromeversion")==null?"":request.getParameter("chromeversion");
int errorstatus=0;
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	
	Process process = Runtime.getRuntime().exec("reg query HKEY_CURRENT_USER\\Software\\Google\\Chrome\\BLBeacon /v version");
    InputStream inputStream = process.getInputStream();
    Scanner scanner = new Scanner(inputStream);
    while (scanner.hasNextLine()) {
        String line = scanner.nextLine();
        if (line.contains("REG_SZ")) {
        	chromeversion = line.split("\\s+")[line.split("\\s+").length - 1];
        }
    }
    scanner.close();
    
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String imgpath="",timesrno="";
	
	ResultSet rsgetimgpath=stmt.executeQuery("select chromedriverpath,REPLACE(REPLACE(REPLACE(NOW(),' ',''),'-',''),':','') timesrno from my_comp");
	while(rsgetimgpath.next()){
		imgpath=rsgetimgpath.getString("chromedriverpath");
		timesrno=rsgetimgpath.getString("timesrno");
	}
	int chromeindex=chromeversion.lastIndexOf(".");
	String chromedriverversion="";
	if(chromeindex>0){
		chromedriverversion=chromeversion.substring(0, chromeindex);
	}
	File oldchromefile=new File(imgpath);
	String strchromeurl="http://gatewayerp.fortiddns.com:8880/SATDownloader/api/getChromeDriver?chromeversion="+chromeversion;
	File oldchromefolder=new File(oldchromefile.getParent()+File.separator+"chromedriver");
	if(oldchromefolder.exists()){
		if(oldchromefolder.isDirectory()){
			File[] files=oldchromefolder.listFiles();
			if(files!=null){
				for(File file:files){
					file.delete();
				}
			}
		}
		oldchromefolder.delete();
		System.out.println("Old Chrome Folder Deleted");
	}
	else{
		System.out.println("Old Chrome Folder Not Deleted");
	}
	
	
	if(oldchromefile.exists() && oldchromefile.isFile()){
		String parentdir=oldchromefile.getParent();
		File renamedfile=new File(parentdir+File.separator+"chromedriver"+timesrno+".exe");
		if(oldchromefile.renameTo(renamedfile)){
			System.out.println("Old Chrome File Renamed Successfully");
		}
		else{
			throw new Exception("Failed to rename existing chromedriver");
		}
	}
	else{
		System.out.println("Old Chrome File not found");
	}
	
	String chromedir=new File(imgpath).getParent();
	File chromezipfile=new File(chromedir+File.separator+"chromedriver.zip");
	InputStream in = null;
    FileOutputStream outstream = null;
    try {
        URL url = new URL(strchromeurl);
        URLConnection connection = url.openConnection();
        in = new BufferedInputStream(connection.getInputStream());
        outstream = new FileOutputStream(chromezipfile);
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = in.read(buffer)) != -1) {
            outstream.write(buffer, 0, bytesRead);
        }
    } finally {
        if (in != null) {
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (outstream != null) {
            try {
                outstream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
	
	//Uploading zipfile to the path
	/*URL chromeurl=new URL(strchromeurl);
	URLConnection chromeconn=chromeurl.openConnection();
	InputStream chromeinput = chromeconn.getInputStream();
	File chromezipfile=new File(chromedir+File.separator+"chromedriver.zip");
	
	try (FileOutputStream outputStream = new FileOutputStream(chromezipfile)) {
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = chromeinput.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    }
	chromeinput.close();
	*/
	//Extracting downloaded zipfile
	
		//Creating specified Path
		byte[] buffer=new byte[1024];
		
		ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(chromezipfile));
	    ZipEntry zipEntry = zipInputStream.getNextEntry();
	    while (zipEntry != null) {
	        String fileName = zipEntry.getName();
	        File newFile = new File(chromedir + File.separator + fileName);
	        if (zipEntry.isDirectory()) {
	            newFile.mkdirs();
	        } else {
	            new File(newFile.getParent()).mkdirs();
	            FileOutputStream fos = new FileOutputStream(newFile);
	            BufferedOutputStream bos = new BufferedOutputStream(fos, buffer.length);
	            int len;
	            while ((len = zipInputStream.read(buffer)) > 0) {
	                bos.write(buffer, 0, len);
	            }
	            bos.close();
	            fos.close();
	        }
	        zipEntry = zipInputStream.getNextEntry();
	    }
	    zipInputStream.closeEntry();
	    zipInputStream.close();
		
	    String[] filepaths={chromedir+File.separator+"chromedriver-win32"+File.separator+"chromedriver.exe",chromedir+File.separator+"chromedriver"+File.separator+"chromedriver.exe"};
		
	    File extractedchrome=null;//new File(chromedir+File.separator+"chromedriver"+File.separator+"chromedriver.exe");
		File extractedfolder=null;//new File(chromedir+File.separator+"chromedriver");
		//System.out.println("Extracted Chrome:"+extractedchrome.exists());
		for(String filepath:filepaths){
			extractedchrome=new File(filepath);
			if(extractedchrome.exists() && extractedchrome.isFile()){
				extractedfolder=new File(extractedchrome.getParent());
				break;
			}
		}
		if(extractedchrome.exists()){
			File newchrome=new File(chromedir,"chromedriver.exe");
			FileInputStream fis = new FileInputStream(extractedchrome);
	        FileOutputStream fos = new FileOutputStream(newchrome);
	        buffer = new byte[1024];
	        int length;
	        while ((length = fis.read(buffer)) > 0) {
	            fos.write(buffer, 0, length);
	        }
	        fis.close();
	        fos.close();
		}
		else{
			//throw new Exception("cannot find chromedriver in chromedriver-win32 folder");
		}
		
		//Deleting Zip folder for future downloading easiness
		if(chromezipfile.exists()){
			chromezipfile.delete();
			System.out.println("Zip File Deleted");
		}
		else{
			System.out.println("Zip File Not Deleted");
		}
		System.out.println(extractedfolder.getAbsolutePath());
		if(extractedfolder.exists()){
			if(extractedfolder.isDirectory()){
				File[] files=extractedfolder.listFiles();
				if(files!=null){
					for(File file:files){
						file.delete();
					}
				}
			}
			extractedfolder.delete();
			System.out.println("Extracted Folder Deleted");
		}
		else{
			System.out.println("Extracted Folder Not Deleted");
		}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>