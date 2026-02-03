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

<script type="text/javascript">
	$(document).ready(function () {
		$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM-yyyy"});
		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#extdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM-yyyy"});
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	    var uptodate = $('#uptodate').val();
	    $('#txtuptodate').val(uptodate);
	});
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function funreload(event){
		 $('#gridload').val("1");
		 var gridload = $('#gridload').val();
		 var branchval = $('#cmbbranch').val();
		 var rentaltype = $('#rentaltype').val();
		 var uptodate = $('#txtuptodate').val();
		 
		$('#cmbprocess').val('');$('#date').val(new Date());$('#extdate').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#txtremarks').val('');
		$('#txtexpirydate').val('');$('#txtagreementno').val('');$('#txtcardno').val('');$('#txtpytdocno').val('');$('#btnupdate').attr("disabled",true);
		$('#cmbprocess').attr("disabled",true);$("#extdate").prop("hidden", true);$("#date").prop("hidden", false);$('#date').jqxDateTimeInput({ disabled: true});
		$('#extdate').jqxDateTimeInput({ disabled: true});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#creditCardFollowUpDiv").load("creditCardFollowUpGrid.jsp?branchval="+branchval+'&rentaltype='+rentaltype+'&uptodate='+uptodate+'&gridload='+gridload+'&check=1');
	}
	
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var date =  $('#date').val();
		var extdate =  $('#extdate').val();
		var branchid = $('#txtbranch').val();
		var cldocno = $('#txtcldocno').val();
		var expirydate = $('#txtexpirydate').val();
		var remarks = $('#txtremarks').val();
		var rentaltype = $('#rentaltype').val();
		var agreementno = $('#txtagreementno').val();
		var cardno = $('#txtcardno').val();
		var pytdocno = $('#txtpytdocno').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }
	
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(process,date,extdate,branchid,cldocno,expirydate,remarks,rentaltype,agreementno,cardno,pytdocno);	
		     	}
		});
	}
	
	function saveGridData(process,date,extdate,branchid,cldocno,expirydate,remarks,rentaltype,agreementno,cardno,pytdocno){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				var process = $('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#extdate').val(new Date());
				var branchid = $('#txtbranch').val('');
				var cldocno = $('#txtcldocno').val('');
				var remarks = $('#txtremarks').val('');
				var expirydate = $('#txtexpirydate').val('');
				var agreementno = $('#txtagreementno').val('');
				var cardno = $('#txtcardno').val('');
				var pytdocno = $('#txtpytdocno').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				funreload(event); 
				disable();
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&extdate="+extdate+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&rentaltype="+rentaltype+"&agreementno="+agreementno+"&cardno="+cardno+"&pytdocno="+pytdocno,true);
	x.send();
			
	}
	
	function funExtendedDate(){
		var process=$('#cmbprocess').val();
        if(process==23){
       	 $("#extdate").prop("hidden", true); 
       	 $("#date").prop("hidden", false);
        }
        else{
       	 $("#date").prop("hidden", true);
       	 $("#extdate").prop("hidden", false);
        }
	 }

	function datechange(){
		var uptodate = $('#uptodate').val();
	    $('#txtuptodate').val(uptodate);
	  }
	  
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'CreditCardFollowUp', true);
		 } else {
			 $("#creditCardFollowUp").jqxGrid('exportdata', 'xls', 'CreditCardFollowUp');
		 }
	}
	
</script>
</head>
<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
    }

    .sidebar-filters {
        width: 350px; 
        flex: 0 0 350px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Card Styling */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 12px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        font-weight: 600;
        width: 100px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 7px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Grid Area & Scroll Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 350px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* FINALIZED BUTTONS (#2563eb) */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; 
        border: none !important;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 15px;
        text-align: center;
        display: block;
        width: 100%;
        margin-top: 5px;
        transition: background 0.2s;
    }

    .myButton:hover { 
        background-color: #1d4ed8 !important; 
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="getBranch();getProcess();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td>
                            <div id="uptodate" name="uptodate" onchange="datechange();" value='<s:property value="uptodate"/>'></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Process</td>
                        <td>
                            <select name="cmbprocess" id="cmbprocess" onchange="funExtendedDate();" value='<s:property value="cmbprocess"/>'></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td>
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                            <div hidden="true" id="extdate" name="extdate" value='<s:property value="extdate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td>
                            <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                        </td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px;">
                    <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
                </div>
            </div>

            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'/>
            <input type="hidden" id="txtexpirydate" name="txtexpirydate" value='<s:property value="txtexpirydate"/>'/> 
            <input type="hidden" id="txtcardno" name="txtcardno" value='<s:property value="txtcardno"/>'/>
            <input type="hidden" id="txtpytdocno" name="txtpytdocno" value='<s:property value="txtpytdocno"/>'/>
            <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
            <input type="hidden" id="gridload" name="gridload" value='<s:property value="gridload"/>'/>
            <input type="hidden" id="txtuptodate" name="txtuptodate" value='<s:property value="txtuptodate"/>'/>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="creditCardFollowUpDiv">
                <jsp:include page="creditCardFollowUpGrid.jsp"></jsp:include>
            </div>
            <div id="detailDiv">
                <jsp:include page="detailGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</body>
</html>