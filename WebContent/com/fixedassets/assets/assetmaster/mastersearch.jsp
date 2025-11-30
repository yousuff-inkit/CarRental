 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>
<style>
/* ------------------- PAGE ------------------- */
body {
    background: #f3f7ff;
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
}

/* ------------------- MAIN WRAPPER ------------------- */
#search {
    background: #ffffff;
    width: 98%;
    margin: 10px auto;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0, 0, 255, 0.08);
    border: 1px solid #e4ebff;
}

/* ------------------- INPUT + LABEL ALIGNMENT ------------------- */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px 12px; /* EXACT GAP AS SCREENSHOT */
}

#search td {
    font-size: 12px;
    color: #444;
    font-weight: 600;
}

/* ------------------- INPUT BOX STYLE ------------------- */
#search input[type="text"] {
    width: 100%;
    height: 32px;
    padding-left: 10px;
    border: 1px solid #d4dff7;
    border-radius: 8px;
    background: #f9fbff;
    font-size: 12px;
    transition: all 0.2s;
}

#search input[type="text"]:focus {
    border-color: #4a8dff;
    box-shadow: 0 0 5px rgba(74, 141, 255, 0.3);
    outline: none;
}

/* ------------------- SEARCH BUTTON ------------------- */
.myButton {
    background: linear-gradient(180deg, #4a90ff, #2a6dff);
    padding: 8px 20px;
    border-radius: 6px;
    border: none;
    font-size: 12px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    box-shadow: 0 3px 8px rgba(0, 0, 255, 0.2);
}

.myButton:hover {
    background: linear-gradient(180deg, #2a6dff, #4a90ff);
}

/* ------------------- RESULT BOX ------------------- */
#srefreshdiv {
    background: #ffffff;
    margin-top: 10px;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #e4ebff;
    box-shadow: inset 0 0 10px rgba(0, 0, 255, 0.05);
}

/* smooth fade */
#srefreshdiv {
    animation: fadeIn 0.2s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(3px); }
    to { opacity: 1; transform: translateY(0); }
}
/* ------------------- INPUT BOX STYLE (SMALLER) ------------------- */
#search input[type="text"] {
    width: 100%;
    height: 26px;          /* reduced height */
    padding-left: 8px;     /* slightly smaller padding */
    border: 1px solid #d4dff7;
    border-radius: 6px;    /* slightly smaller radius */
    background: #f9fbff;
    font-size: 11px;       /* slightly smaller text */
    transition: all 0.2s;
}

#search input[type="text"]:focus {
    border-color: #4a8dff;
    box-shadow: 0 0 5px rgba(74, 141, 255, 0.3);
    outline: none;
}

/* ------------------- SEARCH BUTTON (BIGGER) ------------------- */
.myButton {
    background: linear-gradient(180deg, #4a90ff, #2a6dff);
    padding: 12px 28px;   /* increased for bigger look */
    border-radius: 8px;   /* slightly bigger */
    border: none;
    font-size: 14px;      /* bigger font */
    font-weight: bold;
    color: white;
    cursor: pointer;
    box-shadow: 0 3px 8px rgba(0, 0, 255, 0.2);
}

.myButton:hover {
    background: linear-gradient(180deg, #2a6dff, #4a90ff);
}
.myButton {
    background: linear-gradient(180deg, #4a90ff, #2a6dff);
    padding: 12px 28px;
    border-radius: 8px;
    border: none;
    font-size: 14px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    box-shadow: 0 3px 8px rgba(0, 0, 255, 0.2);
    transition: all 0.25s ease;   /* smooth animation */
}

/* PREMIUM HOVER EFFECT */
.myButton:hover {
    background: linear-gradient(180deg, #2a6dff, #1a54e8); /* richer blue */
    transform: translateY(-2px); /* slight lift */
    box-shadow: 0 6px 14px rgba(0, 0, 255, 0.25); /* glowing effect */
}

/* Pressed effect */
.myButton:active {
    transform: scale(0.97);
}

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		
 	
 		var sclnames=document.getElementById("assetnamess").value;
 		var gp=document.getElementById("assetgroupss").value;
 		
 		var sdocno=document.getElementById("sdocno").value;
 		var assetid=document.getElementById("assetidss").value;

 		

 		var assetgroup = gp.replace(/ /g, "%20");
 		var assetname = sclnames.replace(/ /g, "%20");
 		var chk="yes";
		getdata(assetname,assetid,sdocno,assetgroup,chk);
		
		

	}
	 function getdata(assetname,assetid,sdocno,assetgroup,chk){



		
		 $("#srefreshdiv").load('submasterSearch.jsp?assetname='+assetname+'&assetid='+assetid+'&sdocno='+sdocno+'&assetgroup='+assetgroup+'&chk='+chk);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script> 
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="100%" >
  <tr>
 
     <td align="left" width="8%">Doc NO</td>
    <td align="left" width="10%" width=><input type="text" name="sdocno" id="sdocno" value='<s:property value="sdocno"/>'>

    <td align="right">Asset Id</td>
    
    <td align="left" width="20%"><input type="text" name="assetidss" id="assetidss" style="width:96.5%;" value='<s:property value="assetidss"/>'></td>
    <td align="right">Asset Name</td>
    <td align="left" colspan="3"><input type="text" id="assetnamess" name="assetnamess" style="width:96.5%;"  value='<s:property value="assetnamess"/>'></td>
    
    
  </tr>
  </table>
  </td>
  </tr>
  <tr>
  <td>

 <table width="100%">
   <tr>
    <td align="right"  width="8%">Asset Group</td>
    <td align="left" width="53%"><input type="text" name="assetgroupss" id="assetgroupss"  style="width:89.5%;" value='<s:property value="assetgroupss"/>'></td>
   <td colspan="2" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
    <tr>
    </table>
  

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="submasterSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>