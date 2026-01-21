<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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
html, body {
    height: 100%;
    margin: 0;
}

#mainBG {
    height: 100%;
}

.hidden-scrollbar {
    height: 100%;
    overflow-y: auto;   /* ✅ allow vertical scroll */
    overflow-x: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
.sidebar-fixed-top {
    min-height: 60px;   /* ensures visibility */
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
    background: #fff;
}
/* ===== PAGE-SPECIFIC FIX FOR HEADING VISIBILITY ===== */

/* allow vertical scroll for this page only */
#mainBG .hidden-scrollbar {
    overflow-y: auto !important;
    overflow-x: hidden;
}

/* ensure sidebar top is visible */
#mainBG .sidebar-fixed-top {
    position: sticky;
    top: 0;
    z-index: 20;
    background: #ffffff;
}

/* prevent table layout from clipping top content */
#mainBG table[width="100%"] {
    height: auto !important;
}
/* ===== ABSOLUTE REQUIRED FIX ===== */

/* give height reference */
.master-container {
    height: 100%;
}

/* sidebar must fill parent */
.sidebar-filters {
    height: 100%;
}

/* heading area must not collapse */
.sidebar-fixed-top {
    flex-shrink: 0;
    background: #ffffff;
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* scroll ONLY the content */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
}

/* IMPORTANT: allow page to show top content */
.hidden-scrollbar {
    overflow-y: visible !important;
}
/* ===== CRITICAL FIX: DO NOT TOUCH heading.jsp ===== */

/* remove clipping caused by parent containers */
#mainBG,
#mainBG .hidden-scrollbar,
#mainBG table,
#mainBG tr,
#mainBG td {
    overflow: visible !important;
}

/* give height reference for flex layout */
#mainBG .master-container {
    height: 100%;
}

/* sidebar must be a proper flex column */
#mainBG .sidebar-filters {
    display: flex;
    flex-direction: column;
    height: 100%;
}

/* heading area must be visible */
#mainBG .sidebar-fixed-top {
    flex-shrink: 0;
    display: block;
    min-height: 60px;
    background: #ffffff;
    padding: 12px 20px;
    border-bottom: 1px solid #e1e8ed;
}

/* scroll only filter section */
#mainBG .sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
}


</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    /* Partial Pie Chart Starts*/
	$("#cmbbranch").attr('hidden',true);
	funchange();
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
	  $("#hidediv").hide();
	  
		 $('#regwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Reg No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
		 $('#regwindow').jqxWindow('close');
		 $('#tagwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Tag No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
		 $('#tagwindow').jqxWindow('close');
		 $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	 $('#fleetwindow').jqxWindow('close');
	   	 $('#commonwindow1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	   	 $('#commonwindow1').jqxWindow('close');
	  	 $('#commonwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  	 $('#commonwindow').jqxWindow('close');
   
		 $('#regno').dblclick(function(){
		 	$('#regwindow').jqxWindow('open');
		 	ragnoContent('regnosearch.jsp?', $('#regwindow')); 
	     });
		 
		 $('#tagno').dblclick(function(){
		 	$('#tagwindow').jqxWindow('open');
		    tagnoContent('tagnosearch.jsp?', $('#tagwindow')); 
	    });
	    $('#fleet_no').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	        fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow')); 
       	});
       	
       	$('#typesearch').dblclick(function(){
		  	if(document.getElementById("trftype").value=="RAG"){
   				$('#commonwindow1').jqxWindow('open');
     			raSearchContent('ramasterSearch.jsp'); 
   			}
  	  		else if(document.getElementById("trftype").value=="LAG"){
	  			$('#commonwindow1').jqxWindow('open');
	     		raSearchContent('lamasterSearch.jsp'); 
	   		}
  			else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
	  			$('#commonwindow').jqxWindow('open');
	     		SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
	   		}
       });
   
});
function SearchContent(url) {
	$.get(url).done(function (data) {
		$('#commonwindow').jqxWindow('open');
		$('#commonwindow').jqxWindow('setContent', data);
	}); 
} 
function raSearchContent(url) {
	$.get(url).done(function (data) {
		$('#commonwindow1').jqxWindow('open');
		$('#commonwindow1').jqxWindow('setContent', data);
	}); 
} 
function getfleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
		fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow'));
	} 
	else{
	}
} 
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function ragnoContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#regwindow').jqxWindow('open');
		$('#regwindow').jqxWindow('setContent', data);

	}); 
	} 

function getregno(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#regwindow').jqxWindow('open');


	  ragnoContent('regnosearch.jsp?', $('#regwindow'));     }
	 else{
		 }
	 }

function tagnoContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#tagwindow').jqxWindow('open');
		$('#tagwindow').jqxWindow('setContent', data);

	}); 
	} 

function gettagno(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#tagwindow').jqxWindow('open');


	  tagnoContent('tagnosearch.jsp?', $('#tagwindow'));      }
	 else{
		 }
	 }

function funExportBtn(){
	
	JSONToCSVCon(exceldatas, 'Salik Unallocated', true);
	  
	 }



function funreload(event)
{     
	
	
	  var val ="2";
	  var uptodate=$("#uptodate").val();
	  var fromdate=$("#fromdate").val();
	  var hidchkdate=$("#hidchkdate").val();
	  
	  var regno=$("#regno").val();
	  var tagno=$("#tagno").val();
	  var saliktype=$('#cmbsaliktype').val();
	   $("#overlay, #PleaseWait").show();
	  $("#allodiv").load("allocatelistGrid.jsp?saliktype="+saliktype+"&chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno+'&fromdate='+fromdate+'&hidchkdate='+hidchkdate);
	
	
	}
	
	
	function hiddenbrh(){
		
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
		$('#gridlength').val(""); 
	}
	
	
	function funallocate()
	{
	

	    $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		
	     		$("#hidediv").show();
		/*    for(var i=0 ; i < rows.length ; i++){ */
		var saveval="10";

			 /*   ajaxcall(rows[i].fleet_no,rows[i].rdocno,rows[i].trancode,rows[i].trans,rows[i].tagno,saveval); */
			 
			   var regno=document.getElementById('regno').value;
			   var tagno=document.getElementById('tagno').value;
	
			   ajaxcall(saveval,regno,tagno);
	
		/*    }    */
	     	}
	    });
	}
	
/* 	function ajaxcall(fleet_no,rdocno,trancode,trans,tagno,saveval){ */
	
		function ajaxcall(saveval,regno,tagno){
			var saliktype=$('#cmbsaliktype').val();
			$('.salikallocatecount').show();
			const interval = setInterval(function() {
	     		// method to be executed;
	     		$.get('getAllocateCount.jsp',function(data){
	     			data=JSON.parse(data);
		     		$('.currentsalikallocated').text(data.currentcount);
	     		});	     		   
	     	}, 5000);
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				 	clearInterval(interval);
				 	$('.salikallocatecount').hide();
				    if(parseInt(itemval)=="10")
				    	{
				    	$.messager.alert('Message', 'Allocation Not Processed');
					   funreload(event);
					    
					     $("#hidediv").hide();
				    	}
				    else if(parseInt(itemval)=="11")
				    	{
				    	
				    	   $.messager.alert('Message', '  Record Successfully Allocated ');
				    	      var val ="10";
							  var uptodate=$("#uptodate").val();
							  var regno=$("#regno").val();
							  var tagno=$("#tagno").val();
							  var fromdate=$("#fromdate").val();
							  var hidchkdate=$("#hidchkdate").val();
							  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno+'&fromdate='+fromdate+'&hidchkdate='+hidchkdate);
					       $("#hidediv").hide();
		
				    	}
				    else
				    	{
				    	
				    	  $.messager.alert('Message', '  Not Allocated ');
					       funreload(event);
					       $("#hidediv").hide();
				    	
				    	}
				    
				    
				}
			else
				{
				
				}
		}
		x.open("GET","savedata.jsp?saliktype="+saliktype+"&saveval="+saveval+"&regno="+regno+"&tagno="+tagno+"&uptodate="+$('#uptodate').jqxDateTimeInput('val')+"&fromdate="+$('#fromdate').jqxDateTimeInput('val')+"&hidchkdate="+$("#hidchkdate").val());
	//	x.open("GET","savedata.jsp?fleet_no="+fleet_no+"&rdocno="+rdocno+"&trancode="+trancode+"&trans="+trans+"&tagno="+tagno+"&saveval="+saveval,true);
		x.send();
	}
		function  funcleardata()
		{
			
			document.getElementById("regno").value="";
			document.getElementById("tagno").value="";
			
			 if (document.getElementById("regno").value == "") {
					
				 
			        $('#regno').attr('placeholder', 'Press F3 TO Search'); 
			    }
			 if (document.getElementById("tagno").value == "") {
					
				 
			        $('#tagno').attr('placeholder', 'Press F3 TO Search'); 
			    }
		}
		
		function getAllocateBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim().split('####');
					var optionsbranch = "" ;
					var branchid  = items[0].split(",");
					var branchname = items[1].split(",");
					for (var i = 0; i < branchname.length; i++) {
						optionsbranch += '<option value="' + branchid[i].trim() + '">'
								+ branchname[i] + '</option>';
					}
					$("select#cmballocatebranch").html(optionsbranch);
				}
				else {
				}
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
			x.send();
		}
		
		function gettypessearch(event){
	 		var x= event.keyCode;
	 		if(x==114){
   	  			if(document.getElementById("trftype").value=="RAG"){
	   				$('#commonwindow1').jqxWindow('open');
      				raSearchContent('ramasterSearch.jsp'); 
	   			}
   	  			else if(document.getElementById("trftype").value=="LAG"){
   		  			$('#commonwindow1').jqxWindow('open');
   		     		raSearchContent('lamasterSearch.jsp'); 
		   		}
   	  			else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
   		  			$('#commonwindow').jqxWindow('open');
   		     		SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
		   		}
	 		}
	 		else{
		 	}
	 	}
	 	
	 	function cleardatas()
	{
		document.getElementById("typesearch").value="";
		document.getElementById("rentaldoc").value="";
		document.getElementById("leasedoc").value="";
		document.getElementById("drdoc").value="";
		document.getElementById("staffdoc").value="";
	
	}
	
	
	
	function funoneallocate(){
		if(document.getElementById("fleet_no").value==""){
			$.messager.alert('Message',' Search Fleet ','warning');    
	        return false;
		}
		if(document.getElementById("typesearch").value==""){
			$.messager.alert('Message','Convict Search  ','warning');    
	        return false;
		}
		$.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	    	if(r==false){
		        return false; 
		    }
		    else{
		    	doprocess();
		    }
     	});
	}
		
	function doprocess()
	{
		var salikarray=new Array();
		var selectedrows=$('#salikgrid').jqxGrid('selectedrowindexes');
		for(var i=0;i<selectedrows.length;i++){
			salikarray.push($('#salikgrid').jqxGrid('getcellvalue',selectedrows[i],'trans'));
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 var itemval=items.trim();
				 if(parseInt(itemval)=="10")
				 {
				   	$.messager.alert('Message', '  Record Successfully Allocated ');
				    var val="2";
					var uptodate=$("#uptodate").val();
					$("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
					$("#hidediv").hide();
					dis();
					funreload(event);
				 }
				 else
				 {
				 	$.messager.alert('Message', '  Not Allocated ');
					// funreload(event);
					$("#hidediv").hide();
				 }
			}
			else{
			}                                                                // trftype branchsss   rentaldoc leasedoc drdoc staffdoc
		}
		x.open("GET","saveonedata.jsp?salikarray="+salikarray+"&trftype="+document.getElementById("trftype").value
				+"&cmballocatebranch="+document.getElementById("cmballocatebranch").value+"&rentaldoc="+document.getElementById("rentaldoc").value
				+"&leasedoc="+document.getElementById("leasedoc").value+"&drdoc="+document.getElementById("drdoc").value
				+"&staffdoc="+document.getElementById("staffdoc").value+"&fleet_no="+document.getElementById("fleet_no").value);
	
		x.send();	
		
	}
	
	function dis()
		{
	
		
			
			document.getElementById("saliktag").value="";
			document.getElementById("fleet_no").value="";
			document.getElementById("typesearch").value="";
			 
		 
			 		
			document.getElementById("rentaldoc").value="";
			document.getElementById("leasedoc").value="";
			document.getElementById("drdoc").value="";
			document.getElementById("staffdoc").value="";
			
			
			 $('#ticketno').attr("disabled",true);
			 
			 $('#fleet_no').attr("disabled",true);
			 $('#trftype').attr("disabled",true);
			 $('#cmballocatebranch').attr("disabled",true);
			 $('#allocates').attr("disabled",true);
			 $('#typesearch').attr("disabled",true);
			 

			
			
		//	ticketno fleet_no trftype branchsss typesearch allocates  rentaldoc leasedoc drdoc staffdoc
		
		}
	function funchange(){
		if(document.getElementById('Chkfromdate').checked){
			$("#fromdate").jqxDateTimeInput({disabled: false}); 
			document.getElementById("hidchkdate").value="1";
		}else{
			$("#fromdate").jqxDateTimeInput({disabled: true}); 
			document.getElementById("hidchkdate").value="0";
		}
	}
</script>
</head>
<body onload="hiddenbrh();getAllocateBranch();dis();">
<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT SIDEBAR ===== -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADING (ALWAYS VISIBLE) -->
    <div class="sidebar-fixed-top">
        <jsp:include page="../../heading.jsp"></jsp:include>

        <div class="salikallocatecount" style="animation: blink 1s linear infinite;" hidden>
            <strong>Total Saliks Allocated:</strong>
            <span class="currentsalikallocated"></span>
        </div>
    </div>

    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content">

        <!-- FILTERS -->
        <div class="filter-card">
            <table class="filter-table">

                <tr>
                    <td class="label-cell">Reg No</td>
                    <td>
                        <input type="text" id="regno" readonly
                               onkeydown="getregno(event);"
                               placeholder="F3 to Search">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Tag No</td>
                    <td>
                        <input type="text" id="tagno" readonly
                               onkeydown="gettagno(event);"
                               placeholder="F3 to Search">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="cmbsaliktype">
                            <option value="">--Select--</option>
                            <option value="SAL">Salik</option>
                            <option value="PAR">Parking</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Up To</td>
                    <td><div id="uptodate"></div></td>
                </tr>

            </table>
        </div>

        <button class="btn-submit" type="button" onclick="funallocate()">Allocate</button>
        <button class="btn-submit" type="button" onclick="funcleardata()">Clear</button>

        <!-- MANUAL ALLOCATE -->
        <div class="filter-card">
            <strong>Manual Allocate</strong>

            <table class="filter-table">

                <tr>
                    <td class="label-cell">Salik Tag</td>
                    <td><input type="text" id="saliktag" readonly></td>
                </tr>

                <tr>
                    <td class="label-cell">Fleet No</td>
                    <td>
                        <input type="text" id="fleet_no" readonly
                               onkeydown="getfleet(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="trftype" onchange="cleardatas()">
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                            <option value="STF">Staff</option>
                            <option value="DRV">Driver</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Branch</td>
                    <td>
                        <select id="cmballocatebranch"></select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Convict</td>
                    <td>
                        <input type="text" id="typesearch" readonly
                               onkeydown="gettypessearch(event)">
                    </td>
                </tr>

            </table>

            <button class="btn-submit" type="button" onclick="funoneallocate()">
                Manual Allocate
            </button>
        </div>

    </div>
</div>
</div>

</td>

<!-- ===== RIGHT GRID ===== -->
<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="allodiv">
            <jsp:include page="allocatelistGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

</div>
</div>
</body>

</html>