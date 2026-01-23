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
        width: 330px; 
        flex: 0 0 330px;
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

    /* Cleaned Cards - Stripping legacy backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted green/blue backgrounds */
    .filter-card *, 
    fieldset, 
    legend, 
    .branch, 
    td, 
    tr, 
    label, 
    span {
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
        width: 85px;
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

    /* RHS Visibility & Scrollbar Kill */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 330px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        overflow-x: hidden !important; 
        padding: 20px;
    }

    /* Legacy Account Display Labels */
    #lblaccountno, #lblaccountname {
        color: #6000FC !important; /* Preserved specific brand color for these labels */
        display: block;
        padding: 5px 0;
    }

    /* Buttons Modernized */
    .myButtons {
        background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
        background-color: #768d87;
        border: 1px solid #566963;
        border-radius: 6px;
        cursor: pointer;
        color: #ffffff !important; 
        font-size: 13px;
        font-weight: 600;
        padding: 10px;
        width: 100%;
        margin-bottom: 8px;
        text-shadow: 0px -1px 0px #2b665e;
        display: block;
        text-align: center;
    }

    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important;
        border: none !important;
        padding: 12px !important;
        border-radius: 6px !important;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        width: 100%;
        display: block;
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     document.getElementById("rdcurrentageing").checked=true;
	     document.getElementById("lblaccountno").innerText="";
		 document.getElementById("lblaccountname").innerText="";
		 $('#btnRemoveApplying').attr('disabled',true);
	     $('#uptodate').jqxDateTimeInput({disabled: true});
	     $("#ageingDifferenceGridID").jqxGrid({ disabled: true});
	     
	});
	
	function radioClick(){
		 if(document.getElementById("rdageing").checked==true){
			 $('#uptodate').jqxDateTimeInput({disabled: false});
		 } else{
			 $('#uptodate').jqxDateTimeInput({disabled: true});
		 }	 
	 }
	
	function  funClearInfo(){
		
	    $('#uptodate').val(new Date());
		document.getElementById("cmbtype").value="AR";
		document.getElementById("rdcurrentageing").checked=true;
		document.getElementById("lblaccountno").innerText="";
		document.getElementById("lblaccountname").innerText="";
		$('#btnRemoveApplying').attr('disabled',true);
		$('#uptodate').jqxDateTimeInput({disabled: true});
		$("#ageingVerificationGridID").jqxGrid('clear');
		$("#ageingDifferenceGridID").jqxGrid('clear');
	    $("#ageingDifferenceGridID").jqxGrid({ disabled: true});
	    
	}
		
	function funreload(event){
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 
		 if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 var check = "1";
		 
		 document.getElementById("lblaccountno").innerText="";document.getElementById("lblaccountname").innerText="";$('#btnRemoveApplying').attr('disabled',true);
		 $("#ageingDifferenceGridID").jqxGrid('clear');$("#ageingDifferenceGridID").jqxGrid({ disabled: true});

		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdageing").checked==true){
		 	$("#ageingVerificationDiv").load("ageingVerificationGrid.jsp?rpttype=2&atype="+atype+'&uptodate='+uptodate+'&check='+check);
		 } else {
			$('#uptodate').jqxDateTimeInput({disabled: false});
			uptodate = $('#uptodate').val();
			$("#ageingVerificationDiv").load("ageingVerificationGrid.jsp?rpttype=1&atype="+atype+'&uptodate='+uptodate+'&check='+check);
			$('#uptodate').jqxDateTimeInput({disabled: true});
		 }
		 
	}
	
	function setValues(){
		 
		  if($('#hiduptodate').val()){
				 $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
			  }
		  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
			 funreload(event);
		 }
		  
		}
	
	function funNotify(){
		
		  var rows = $("#ageingDifferenceGridID").jqxGrid('getrows');                    
     	  if(rows.length==0){
     		 $.messager.alert('Warning','Nothing to Remove.');
     		 document.getElementById("lblaccountno").innerText="";document.getElementById("lblaccountname").innerText="";$('#btnRemoveApplying').attr('disabled',true);
   		     $("#ageingDifferenceGridID").jqxGrid('clear');$("#ageingDifferenceGridID").jqxGrid({ disabled: true});
     		 return false;
     	  }
     	  
		   $.messager.confirm('Confirm', 'Do you want to Remove?', function(r){
	  	 		if (r){
	  	 				
		    	/* Ageing Difference Grid Removing */
		    	 var rows = $("#ageingDifferenceGridID").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].tranid;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
						
					
						newTextBox.val(rows[i].tranid+"::"+rows[i].acno+"::"+rows[i].out_amount+"::"+rows[i].applied+"::"+rows[i].id+"::"+rows[i].brhid+"::"+rows[i].currency);
						newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
				 /* Ageing Difference Grid Removing Ends */
		 		 
				 $('#uptodate').jqxDateTimeInput({disabled: false});
				 $('#mode').val('A');$("#overlay, #PleaseWait").show();
				 document.getElementById("frmDashboardAgeingVerification").submit();
				 
	  	 		 }
	  	 		});	
	}
	
</script>
</head>
<body onload="setValues();">
<form id="frmDashboardAgeingVerification" action="saveDashboardAgeingVerification" method="post">
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
                        <td class="label-cell">Up To</td>
                        <td>
                            <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                            <input type="hidden" id="hiduptodate" name="hiduptodate" value='<s:property value="hiduptodate"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                <option value="AR" selected>AR</option>
                                <option value="AP">AP</option>
                            </select>
                            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <span class="branch" style="display:block; margin-bottom:8px; text-align:center; font-weight:bold;">Report Type</span>
                <table width="100%">
                    <tr>
                        <td width="50%" align="center">
                            <input type="radio" id="rdcurrentageing" name="rdo" onclick="radioClick();" value="rdcurrentageing">
                            <label for="rdcurrentageing" class="branch">Current</label>
                        </td>
                        <td width="50%" align="center">
                            <input type="radio" id="rdageing" name="rdo" onclick="radioClick();" value="rdageing">
                            <label for="rdageing" class="branch">Ageing</label>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px 5px;">
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                <button class="myButton" type="button" id="btnRemoveApplying" name="btnRemoveApplying" onclick="funNotify();">Remove</button>
            </div>

            <div class="filter-card">
                <i><b><label id="lblaccountno" name="lblaccountno"><s:property value="lblaccountno"/></label></b></i>
                <i><b><label id="lblaccountname" name="lblaccountname" style="height:70px;"><s:property value="lblaccountname"/></label></b></i>
            </div>

            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="gridlength" name="gridlength"/>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="ageingVerificationDiv">
                <jsp:include page="ageingVerificationGrid.jsp"></jsp:include>
            </div>
            <br/>
            <div id="ageingDifferenceDiv">
                <jsp:include page="ageingDifferenceGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</form> 
</body>
</html>