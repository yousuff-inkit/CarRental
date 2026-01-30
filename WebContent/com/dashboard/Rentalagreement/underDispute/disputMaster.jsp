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
	
	 $("#disputeDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#duegridDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 
	 
	 $('#disputeDate').on('change', function (event) {
			
		   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#disputeDate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message','Date Cannot Be Less Than Due Date  ','warning');   
			 
		   return false;
		  }   
	 });
});


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
	
	 $("#duedetailsgrid").jqxGrid('clear');
	  $("#disputdiv").load("disputeGrid.jsp?barchval="+barchval);
	
	
	}
	

function funchangeinfo()
{
  if($('#cmbinfo').val()==4)
	  {
	 
	 document.getElementById("remarks").focus();
	 $('#disputeDate').jqxDateTimeInput({ disabled: false});
	 $('#caseno').attr("disabled",true);
	 $('#station').attr("disabled",true);
	 $('#value').attr("disabled",true);
	 $('#casenote').attr("disabled",true);
	 
	  }
  else if($('#cmbinfo').val()==5)
  {
	  document.getElementById("remarks").focus();
	  $('#disputeDate').jqxDateTimeInput({ disabled: false});
		 $('#caseno').attr("disabled",false);
		 $('#station').attr("disabled",false);
		 $('#value').attr("disabled",false);
		 $('#casenote').attr("disabled",false);
	
  }
  else if($('#cmbinfo').val()==6)
  {
	  document.getElementById("remarks").focus();
	  $('#disputeDate').jqxDateTimeInput({ disabled: true});
		 $('#caseno').attr("disabled",true);
		 $('#station').attr("disabled",true);
		 $('#value').attr("disabled",true);
		 $('#casenote').attr("disabled",true);

 
  }
	 
	
	}
	
function funExportBtn(){
	  // $("#disputgrid").jqxGrid('exportdata', 'xls', 'RAG-Under Dispute');
	   
	   
	   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datasssss, 'RAG-Under Dispute', true);
	    }
	   else
	    {
	    $("#disputgrid").jqxGrid('exportdata', 'xls', 'RAG-Under Dispute');
	    }
	   
	   
	 }
	
	
function disitems()
{
	
	 $('#disputeDate').jqxDateTimeInput({ disabled: true});
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	 $('#caseno').attr("readonly",true);
	 $('#station').attr("readonly",true);
	 $('#value').attr("readonly",true);
	 $('#casenote').attr("readonly",true);
	 
	 

	
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
		 
		 if($('#cmbinfo').val()==5)
		  {
			 if(document.getElementById("caseno").value=="")
			 {
				 $.messager.alert('Message','Enter Case NO ','warning');  
				 
				 
				 
				 return 0;
			 }
			 if(document.getElementById("station").value=="")
			 {
				 $.messager.alert('Message','Enter Station ','warning');  
				 
				 
				 
				 return 0;
			 }
			 if(document.getElementById("value").value=="")
			 {
				 $.messager.alert('Message','Enter Value ','warning');  
				 
				 
				 return 0;
			 }
			 if(document.getElementById("casenote").value=="")
			 {
				 $.messager.alert('Message','Enter Note ','warning');  
				
				 return 0;
			 }
			 
			 
			 var casenoteval = document.getElementById("casenote").value;
			 var nmax = casenoteval.length;
				
				
		      if(nmax>199)
		   	   {
		   	  $.messager.alert('Message','Note cannot contain more than 200 characters ','warning');   
		   	
					return false; 
		   	   
		   	 
		   	 
		   	   } 
			 
			 
		  }
		 
		 
		 if($('#cmbinfo').val()!=6)
		  {
			   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
				 
				  // out date
				 	 var agmtdate1=new Date($('#disputeDate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message',' Date Cannot Be Less Than Due Date ','warning');      
			  
		   return false;
		  }   
		  }

		 
		 var rentaldocno = document.getElementById("rentaldoc").value;
		 var branchids = document.getElementById("branchids").value;
		 var remarks = document.getElementById("remarks").value;
		 var cmbinfo = document.getElementById("cmbinfo").value;
		 var disputedate =  $('#disputeDate').val();

		 var caseno = document.getElementById("caseno").value;
		 var station = document.getElementById("station").value;
		 var value = document.getElementById("value").value;
		 var casenote = document.getElementById("casenote").value;
		var cldocno=document.getElementById("cldocno").value;

		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			       
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,disputedate,caseno,station,value,casenote,cldocno);	
		     	}
			     });
		
		

	}
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,disputedate,caseno,station,value,casenote,cldocno)
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
				 
				 document.getElementById("caseno").value="";
				 document.getElementById("station").value="";
				 document.getElementById("value").value="";
				 document.getElementById("casenote").value="";
				 document.getElementById("cldocno").value="";
				  $('#disputeDate').val(new Date());
	
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			 		 
			 		 
				     
			     });
				 funreload(event);
				
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				 
				
				}
			
		}
	
	x.open("GET","savedispute.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&disputedate="+disputedate+"&caseno="+caseno+"&station="+station+"&value="+value+"&casenote="+casenote+"&cldocno="+cldocno,true);

	x.send();
			
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	
        	 $.messager.alert('Message',' Enter Numbers Only ','warning');  
        	
            return false;
        	}
        
        return true;
    }    
</script>
</head>
<body onload="getBranch();getinfo();disitems();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%">

<div class="master-container">
<div class="sidebar-filters">

    <!-- ===== FIXED HEADING ===== -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- ===== SCROLLABLE CONTENT ===== -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
            <table class="filter-table">

                <tr>
                    <td class="label-cell">Fleet No</td>
                    <td>
                        <input type="text" id="fleetno" name="fleetno"
                               readonly
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
                    <td class="label-cell">Remarks</td>
                    <td>
                        <input type="text" id="remarks" name="remarks"
                               value='<s:property value="remarks"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Date</td>
                    <td>
                        <div id="disputeDate"
                             value='<s:property value="disputeDate"/>'></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Case No</td>
                    <td>
                        <input type="text" id="caseno" name="caseno"
                               value='<s:property value="caseno"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Station</td>
                    <td>
                        <input type="text" id="station" name="station"
                               value='<s:property value="station"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Value</td>
                    <td>
                        <input type="text" id="value" name="value"
                               onkeypress="return isNumber(event)"
                               value='<s:property value="value"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Note</td>
                    <td>
                        <input type="text" id="casenote" name="casenote"
                               value='<s:property value="casenote"/>'>
                    </td>
                </tr>

            </table>
        </div>

        <!-- ===== ACTION BUTTON ===== -->
        <button class="btn-submit" type="button"
                onclick="funupdate()">
            Update
        </button>

    </div>
</div>
</div>

<!-- ===== HIDDEN FIELDS (UNCHANGED) ===== -->
<input type="hidden" id="cldocno" name="cldocno"
       value='<s:property value="cldocno"/>'>
<input type="hidden" id="rentaldoc" name="rentaldoc"
       value='<s:property value="rentaldoc"/>'>
<input type="hidden" id="branchids" name="branchids"
       value='<s:property value="branchids"/>'>

<div hidden id="duegridDate"
     value='<s:property value="duegridDate"/>'></div>

</td>

<!-- ================= RIGHT PANEL (80%) ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="disputdiv">
                    <jsp:include page="disputeGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="disdetaildiv">
                    <jsp:include page="dispudetailgrid.jsp"></jsp:include>
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
