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
 
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#dateDue").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

});

function funExportBtn(){
	JSONToCSVCon(garagefolupexcel, 'Garage Followup Details', true);
	 }
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}


function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	
 
	  $("#duedatediv").load("mainGrid.jsp?barchval="+barchval);
		 $("#duedetailsgrid").jqxGrid('clear');
	
	}
	


function funchangeinfo()
{
	
	
	
  if($('#cmbinfo').val()==25)
	  {
	 
	 $('#dateDue').jqxDateTimeInput({ disabled: false});
	
		$('#dateDue').jqxDateTimeInput('focus'); 
	 
	  }
  else if($('#cmbinfo').val()==26)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: false});
 
	$('#dateDue').jqxDateTimeInput('focus'); 
  }
  else
	  {
	  
	  }
	 
	
	}
function disitems()
{
	
	 $('#dateDue').jqxDateTimeInput({ disabled: true});
	 
	 
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	

	
}
	function funupdate()
	{
		
		
		 if(document.getElementById("cmbinfo").value=="")
		 {
			 $.messager.alert('Message','Select Process ','warning');   
						 
			 return 0;
		 }
		
		 if($('#remarks').val()=="")
		 {
			 $.messager.alert('Message','Enter Remarks ','warning');   
			
			 
			
			 return 0;
		 }
		 
		 var remarkss = document.getElementById("remarks").value;
		 var nmax = remarkss.length;
			
			
	      if(nmax>99)
	   	   {
	   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
	   	
				return false; 
	   	   
	   	 
	   	 
	   	   } 
	      
	    var fleetno=document.getElementById("fleetno").value;
    	var grgid=document.getElementById("grgid").value;
	      
	       var rentaldocno = document.getElementById("rentaldoc").value;
		 var branchids = document.getElementById("branchids").value;
		 var remarks = document.getElementById("remarks").value;
		 var cmbinfo = document.getElementById("cmbinfo").value;
		 var exdate =  $('#dateDue').val();
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid);	
		     	}
			     });
		
		
		
	}
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
	     			
				var items=x.responseText;
				 document.getElementById("fleetno").value="";
				 document.getElementById("rentaldoc").value="";
				 document.getElementById("branchids").value="";
				 document.getElementById("remarks").value="";
				 document.getElementById("cmbinfo").value="";
				  document.getElementById("fleetno").value="";
	        	  document.getElementById("grgid").value="";
				  $('#dateDue').val(new Date());
				 
				
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			   
			     });
				 funreload(event); 
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				 
				
				}
			
		}
			
	x.open("GET","savemaint.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&fleetno="+fleetno+"&grgid="+grgid,true);

	x.send();
			
	}
	
</script>
</head>
<body onload="getBranch();getinfo();disitems();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Heading -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Content -->
    <div class="sidebar-scroll-content">

        <!-- Process Info -->
        <div class="filter-card">
            <table class="process-filter-table">

                <tr>
                    <td class="label-cell">Fleet No</td>
                    <td>
                        <input type="text" id="fleetno" name="fleetno" readonly
                               value='<s:property value="fleetno"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Process</td>
                    <td>
                        <select id="cmbinfo" name="cmbinfo"
                                onchange="funchangeinfo()">
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Date</td>
                    <td>
                        <div id="dateDue"></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Remarks</td>
                    <td>
                        <input type="text" id="remarks" name="remarks"
                               value='<s:property value="remarks"/>'>
                    </td>
                </tr>

            </table>

            <div class="process-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funupdate();">
                    Update
                </button>
            </div>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" id="branchids" name="branchids"
               value='<s:property value="branchids"/>'>
        <input type="hidden" id="rentaldoc" name="rentaldoc"
               value='<s:property value="rentaldoc"/>'>
        <input type="hidden" id="grgid" name="grgid"
               value='<s:property value="grgid"/>'>
        <input type="hidden" id="fleetno" name="fleetno"
               value='<s:property value="fleetno"/>'>

    </div>
</div>
</div>
</td>

<!-- ================= RIGHT CONTENT ================= -->
<td width="80%">
    <div id="duedatediv">
        <jsp:include page="mainGrid.jsp"></jsp:include>
    </div>

    <br>

    <div id="detaildiv">
        <jsp:include page="detailgrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>
</div>
</body>

