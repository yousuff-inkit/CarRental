<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
/* ===== FIX LEFT PANEL SCROLL ISSUE ===== */

/* Allow page to calculate height correctly */
html, body {
    height: 100%;
}

/* Main container must not block scrolling */
#mainBG {
    height: 100%;
}

/* Left sidebar container */
.scrollable-left {
    max-height: calc(100vh - 90px); /* adjust if header height differs */
    overflow-y: auto;
    overflow-x: hidden;
    padding-right: 6px; /* avoids scrollbar overlap */
}

/* Smooth scrollbar (optional but nice) */
.scrollable-left::-webkit-scrollbar {
    width: 6px;
}

.scrollable-left::-webkit-scrollbar-thumb {
    background-color: #cbd5e1;
    border-radius: 4px;
}

.scrollable-left::-webkit-scrollbar-track {
    background: transparent;
}


</style>
<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Users Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#userDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtusername').dblclick(function(){
			  userDetailsSearchContent('userDetailsSearch.jsp');
		 });
		 
	     document.getElementById("rdlinking").checked=true;
	     $('#btnlinking').attr("disabled",true);
	     $('#btnremovelinking').attr("disabled",true);
	     
	});

	function userDetailsSearchContent(url) {
	    $('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getUserDetails(event){
        var x= event.keyCode;
        if(x==114){
        	userDetailsSearchContent('userDetailsSearch.jsp');
        }
        else{}
        }
	
	function funreload(event){
		 $('#txtsalesmanid').val('');$('#txtsalesmaninfo').val(' ');     
		 $('#btnlinking').attr("disabled",true);
	     $('#btnremovelinking').attr("disabled",true);
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdlinking").checked==true){
		 	$("#rentalUserLinkDiv").load("rentalUserLinkGrid.jsp?rpttype=1&check=1");
		 } else if(document.getElementById("rddelete").checked==true){
		 	$("#rentalUserLinkDiv").load("rentalUserLinkGrid.jsp?rpttype=2&check=1");
		 }
	}
	
	function funLinking(event){
		var userdocno = $('#txtuserdocno').val();
		var salesmanid = $('#txtsalesmanid').val();
		var rpttype="0";
		if(document.getElementById("rdlinking").checked==true){
			rpttype="1";
		}
		
		if(userdocno==''){
			 $.messager.alert('Message','Choose a User.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to link Salesman with User?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(salesmanid,userdocno,rpttype);	
		     	}
		 });
	}
	
	function funRemoveLinking(event){
		var userdocno = $('#txtuserdocno').val();
		var salesmanid = $('#txtsalesmanid').val();
		var rpttype="0";
		if(document.getElementById("rddelete").checked==true){
			rpttype="2";
		}
			
		    $.messager.confirm('Message', 'Do you want to remove link ?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		removeGridData(salesmanid,userdocno,rpttype);	
		     	}
		 });
	}
	
	function saveGridData(salesmanid,userdocno,rpttype) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				$.messager.alert('Message', '  Record Successfully Linked ', function(r){
			  });
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
	x.send();
	}
	
	function removeGridData(salesmanid,userdocno,rpttype) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				$.messager.alert('Message', '  Record Successfully Removed ', function(r){
			  });
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
	x.send();
	}
	
	function funExportBtn(){
		 JSONToCSVCon(data, 'SalesUserLink', true);
	 }
	
	function  funClearInfo() {
		    $('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=true;
			document.getElementById("rddelete").checked=false;
			$("#rentalUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
	}
	
	function funClearRadioInfo() {
		
		if(document.getElementById("rdlinking").checked==true){
			$('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=true;
			document.getElementById("rddelete").checked=false;
			$("#rentalUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
		} else if(document.getElementById("rddelete").checked==true){
			$('#txtsalesmanid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtsalesmaninfo').val(' ');
			$('#btnlinking').attr("disabled",true);
			$('#btnremovelinking').attr("disabled",true);
			document.getElementById("rdlinking").checked=false;
			document.getElementById("rddelete").checked=true;
			$("#rentalUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
		}
	}

	
</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100vh;">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%" height="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top" style="height:100%;">

<div class="master-container" style="height:100%;">
<div class="sidebar-filters" style="height:100%;display:flex;flex-direction:column;">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE BODY -->
    <div class="sidebar-scroll-content"
         style="flex:1;overflow-y:auto;padding-bottom:20px;">

        <!-- FILTERS -->
        <div class="filter-card">
        <table class="filter-table" width="100%">

            <tr>
                <td colspan="2" align="center" style="padding:8px 0;">
                    <input type="radio" id="rdlinking" name="rdo"
                           onchange="funClearRadioInfo();">
                    <label class="branch" for="rdlinking">Linking</label>
                    &nbsp;&nbsp;
                    <input type="radio" id="rddelete" name="rdo"
                           onchange="funClearRadioInfo();">
                    <label class="branch" for="rddelete">Remove Linking</label>
                </td>
            </tr>

            <tr>
                <td class="label-cell">User</td>
                <td>
                    <input type="text"
                           id="txtusername"
                           name="txtusername"
                           placeholder="Press F3 to Search"
                           readonly
                           style="width:100%;box-sizing:border-box;"
                           onkeydown="getUserDetails(event);"
                           value='<s:property value="txtusername"/>'>
                    <input type="hidden"
                           id="txtuserdocno"
                           name="txtuserdocno"
                           value='<s:property value="txtuserdocno"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <textarea id="txtsalesmaninfo"
                              readonly
                              style="
                                width:100%;
                                height:90px;
                                resize:none;
                                font:10px Tahoma;
                                box-sizing:border-box;
                              ">
<s:property value="txtsalesmaninfo"/>
                    </textarea>
                </td>
            </tr>

        </table>
        </div>

        <!-- ACTION BUTTONS -->
        <div class="filter-card" style="text-align:center;">
            <button type="button" class="btn-submit"
                    onclick="funLinking(event);">
                Linking
            </button>

            &nbsp;&nbsp;

            <button type="button" class="btn-submit"
                    onclick="funRemoveLinking(event);">
                Remove Linking
            </button>
        </div>

        <!-- CLEAR BUTTON (KEPT ✅) -->
        <div class="filter-card" style="text-align:center;">
            <button type="button" class="btn-submit"
                    onclick="funClearInfo();">
                Clear
            </button>
        </div>

        <input type="hidden"
               id="txtsalesmanid"
               name="txtsalesmanid"
               value='<s:property value="txtsalesmanid"/>'>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top" style="height:100%;">

<table width="100%" height="100%">
<tr>
    <td style="vertical-align:top;">
        <div id="rentalUserLinkDiv" style="height:100%;">
            <jsp:include page="rentalUserLinkGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- POPUP -->
<div id="userDetailsWindow">
    <div></div>
</div>

</div>
</body>



</html>