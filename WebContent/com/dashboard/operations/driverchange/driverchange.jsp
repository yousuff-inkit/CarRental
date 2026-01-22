<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
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


</style>

<script type="text/javascript">

$(document).ready(function () {
	$(".ptypehide").hide();
	$("#drvuptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   $('#dridwindow').jqxWindow({ width: '40%', height: '40%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#dridwindow').jqxWindow('close');
	   $('#deldridwindow').jqxWindow({ width: '40%', height: '40%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#deldridwindow').jqxWindow('close');
	   $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');

	   $('#drnames').dblclick(function(){
			
			 $('#dridwindow').jqxWindow('open');
				$('#dridwindow').jqxWindow('focus');
				 drSearchContent('getdriverDetails.jsp');
			}); 
	   
	   $('#dlvdrvs').dblclick(function(){
			
			 $('#deldridwindow').jqxWindow('open');
				$('#deldridwindow').jqxWindow('focus');
				 deldrSearchContent('getdeldriverDetails.jsp');
			}); 
	   
	   $('#docnoos').dblclick(function(){
			 if(document.getElementById("agmttype").value==""){
				 $.messager.alert('warning','Please Select Agreement Type');
					document.getElementById("agmttype").focus();
				 return false;
			 }
			
			 $('#agmtnowindow').jqxWindow('open');
				$('#agmtnowindow').jqxWindow('focus');
				 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
			}); 
	   $("#type").change(function() {
		 if($("#type").val()==4 || $("#type").val()==3){
			 $(".ptypehide").show();
		 } else {
		 	$("#processtype").val("");
			$(".ptypehide").hide();
		 }
	   });
	     
	
   });
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var type=$("#type").val();
	 var uptodate=$("#drvuptodate").val();
	 $("#overlay, #PleaseWait").show();
	  $("#drvupdiv").load("driverupdateGrid.jsp?barchval="+barchval+"&type="+type+"&uptodate="+uptodate); 
	
	
	}
	

function funExportBtn(){
	var type=$("#type").val();
	
	
		$("#drvupdiv").excelexportjs({
			containerid: "drvupdiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "drvupdategrid", 
			columns: getColumns("drvupdategrid") ,   
			worksheetName:"Driver Change - "+type
			});
		
	}
	
	
function funupdate()
{
	
	var rows=$("#drvupdategrid").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 //alert(rows)
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}  
	var brch=document.getElementById("hidbrhid").value;	
	var doc_no=document.getElementById("doc_no").value;	
	var voc_no=document.getElementById("voc_no").value;
	var fleet_no=document.getElementById("fleet_no").value;
	var cldocno=document.getElementById("cldocno").value;
	var hidtype=document.getElementById("hidtype").value;
	var drid=document.getElementById("drid").value;
	var type=document.getElementById("type").value;
	var drvid=document.getElementById("drvid").value;
	var agmtno=document.getElementById("agmtno").value;
	if(drvid==''){
		$.messager.confirm('Message', 'Please Select a Driver !');
		return 0;
	}
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch);
     	}
	     });
	
}
function savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch)
{
	let processtype=$("#processtype").val();
var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
	{

	 	var items= x.responseText;
	
		document.getElementById("doc_no").value="";
		document.getElementById("hidbrhid").value="";
	    document.getElementById("fleet_no").value="";
		document.getElementById("voc_no").value="";
		document.getElementById("hidtype").value="";
		document.getElementById("cldocno").value="";
		document.getElementById("drid").value="";
		document.getElementById("drvid").value="";
		document.getElementById("drids").value="";
		document.getElementById("drnames").value="";
		document.getElementById("drnames").placeholder = "Press F3 to Search";
		document.getElementById("agmtno").value="";
		
	 	funreload(event);
	 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
}
}
 x.open("GET","saveData.jsp?processtype="+processtype+"&doc_no="+doc_no+"&voc_no="+voc_no+"&hidtype="+hidtype+"&fleet_no="+fleet_no+"&cldocno="+cldocno+"&drid="+drid+"&type="+type+"&drvid="+drvid+"&agmtno="+agmtno+"&brch="+brch,true);
x.send();

}



function fundelupdate()
{
	
	var agmtype=document.getElementById("agmttype").value;	
	var drvid=document.getElementById("dlvdrv").value;	
	var agmdocno=document.getElementById("docnos").value;	
	var orgdrvid=document.getElementById("dlvdrvs").value;	
	var orgagmdocno=document.getElementById("docnoos").value;	
	
	if(orgagmdocno==''){
		$.messager.confirm('Message', 'Please Select a Docno !');
		return 0;
	}
	if(orgdrvid==''){
		$.messager.confirm('Message', 'Please Select a Driver !');
		return 0;
	}
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delchkdata(agmtype,drvid,agmdocno);
     	}
	     });
	
}

 
 function delchkdata(agmtype, drvid, agmdocno) {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function () {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.split("####");
	            let messages = [];
	            if (parseInt(items[0]) === 1) {
	                messages.push("Already Invoiced.");
	            }
	            if (parseInt(items[1]) === 1) {
	                messages.push("Replacement Already Done.");
	            }
	            if (parseInt(items[2]) === 1) {
	                messages.push("Custody Already Done.");
	            }

	            if (messages.length > 0) {
	                $.messager.alert('Message', messages.join('<br>'));
	            }  else {
	                delsavedata(agmtype, drvid, agmdocno);
	            }
	        }
	    };
	    x.open("GET", "delcheckData.jsp?agmtype=" + agmtype + "&drvid=" + drvid + "&agmdocno=" + agmdocno, true);
	    x.send();
	}

function delsavedata(agmtype,drvid,agmdocno)
{
var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
	{

	 	var items= x.responseText;
	 	document.getElementById("dlvdrv").value="";
		document.getElementById("docnos").value="";
	    document.getElementById("dlvdrvs").value="";
		document.getElementById("docnoos").value="";
		$('#dlvdrvs').attr('placeholder','Press F3 to Search');	
		$('#docnoos').attr('placeholder','Press F3 to Search');	
		
		
			
	 	funreload(event);
	 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
}
}
 x.open("GET","delsaveData.jsp?agmtype="+agmtype+"&drvid="+drvid+"&agmdocno="+agmdocno,true);
x.send();

}


function getDrid(event){
	var x= event.keyCode;
	if(x==114){
		
		  $('#dridwindow').jqxWindow('open');
			$('#dridwindow').jqxWindow('focus');
			 drSearchContent('getdriverDetails.jsp');
			 
	}
 	 

}

function getdelDrid(event){
	var x= event.keyCode;
	if(x==114){
		
		  $('#deldridwindow').jqxWindow('open');
			$('#deldridwindow').jqxWindow('focus');
			 deldrSearchContent('getdeldriverDetails.jsp');
			 
	}
 	 

}

function drSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#dridwindow').jqxWindow('setContent', data);

}); 
}

function deldrSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#deldridwindow').jqxWindow('setContent', data);

}); 
}


function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		if(document.getElementById("agmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
				document.getElementById("agmttype").focus();
			 return false;
		 }
		
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
			 
	}
 	 

}

function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}


 </script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Upto Date</td>
                <td>
                    <div id="drvuptodate" name="drvuptodate"
                         value='<s:property value="drvuptodate"/>'></div>
                    <input type="hidden" id="hiddrvuptodate" name="hiddrvuptodate"
                           value='<s:property value="hiddrvuptodate"/>'/>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="type" name="type" style="width:100%;"
                            value='<s:property value="type"/>'>
                        <option value="1">Delivery</option>
                        <option value="2">Collection</option>
                        <option value="3">Replacement</option>
                        <option value="4">Movement</option>
                    </select>
                </td>
            </tr>

            <!-- HIDDEN FIELDS -->
            <tr><td colspan="2">
                <input type="hidden" id="doc_no" name="doc_no" value='<s:property value="doc_no"/>'>
                <input type="hidden" id="voc_no" name="voc_no" value='<s:property value="voc_no"/>'>
                <input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>'>
                <input type="hidden" id="fleet_no" name="fleet_no" value='<s:property value="fleet_no"/>'>
                <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" id="drid" name="drid" value='<s:property value="drid"/>'>
                <input type="hidden" id="drvid" name="drvid" value='<s:property value="drvid"/>'>
                <input type="hidden" id="deldrvid" name="deldrvid" value='<s:property value="deldrvid"/>'>
                <input type="hidden" id="agmtno" name="agmtno" value='<s:property value="agmtno"/>'>
                <input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'>
            </td></tr>

            <tr class="ptypehide">
                <td class="label-cell">Process Type</td>
                <td>
                    <select id="processtype" name="processtype" style="width:100%;"
                            value='<s:property value="processtype"/>'>
                        <option value="1">Delivery</option>
                        <option value="2">Collection</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Driver</td>
                <td>
                    <input type="hidden" id="drids" name="drids">
                    <input type="text" id="drnames" name="drnames"
                           placeholder="Press F3 to Search"
                           onkeydown="getDrid(event);">
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <button type="button"
                            id="driverUpdate"
                            class="myButton"
                            onclick="funupdate();">
                        Update
                    </button>
                </td>
            </tr>

        </table>
        </div>

        <!-- DELIVERY DETAILS -->
        <div class="filter-card">
        <fieldset>
            <legend>Delivery Details</legend>

            <table class="filter-table">

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="agmttype" name="agmttype" style="width:100%;"
                                value='<s:property value="agmttype"/>'>
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Doc No</td>
                    <td>
                        <input type="hidden" id="docnos" name="docnos">
                        <input type="text" id="docnoos" name="docnoos"
                               placeholder="Press F3 to Search"
                               onkeydown="getAgmtno(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Driver</td>
                    <td>
                        <input type="hidden" id="dlvdrv" name="dlvdrv">
                        <input type="text" id="dlvdrvs" name="dlvdrvs"
                               placeholder="Press F3 to Search"
                               onkeydown="getdelDrid(event);">
                    </td>
                </tr>

                <tr>
                    <td colspan="2" align="center">
                        <button type="button"
                                id="deldriverUpdate"
                                class="myButton"
                                onclick="fundelupdate();">
                            Update
                        </button>
                    </td>
                </tr>

            </table>
        </fieldset>
        </div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="drvupdiv">
            <jsp:include page="driverupdateGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="dridwindow"><div></div></div>
<div id="deldridwindow"><div></div></div>
<div id="agmtnowindow"><div></div></div>

</div>
</body>

  
  