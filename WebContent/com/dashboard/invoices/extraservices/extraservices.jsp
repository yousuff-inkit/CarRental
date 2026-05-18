<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {

	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
				});	 
});

function funreload(event)
{
	 var branchval = document.getElementById("cmbbranch").value;
	 if(branchval.trim()=='a'){
		 $.messager.alert('Warning','Branch is Mandatory');
		 document.getElementById("cmbbranch").focus();
		 return false;
	 }
	 if($('#periodupto').jqxDateTimeInput('getDate')==null){
		 $.messager.alert('Warning','Upto Date is Mandatory');
		 $('#periodupto').jqxDateTimeInput('focus');
		 return false;
	 }
	 var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		$("#overlay, #PleaseWait").show();
		 $('#extraserviceinvdiv').load('extraServiceInvGrid.jsp?branch='+branchval+'&uptodate='+$('#periodupto').jqxDateTimeInput('val')+'&temp=1');	 
	 
	 
	
	}
	function funNotify(){
	
	 var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#periodupto').jqxDateTimeInput('focus');
				return false;
			}
			
		var z=0;
    	 var rows = $("#extraServiceInvGrid").jqxGrid('getrows');                    
  	
    	 if(rows.length>0 && (rows[0].doc_no=="undefined" || rows[0].doc_no==null || rows[0].doc_no=="")){
    		 return 0;
    	}
        var selectedrows=$("#extraServiceInvGrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return 0;
		}
		
                    $('#invgridlength').val(selectedrows.length);
    			    for (var i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
							
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
								
							newTextBox.val(rows[i].doc_no+"::"+rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].cldocno+"::"+rows[i].acno+"::"+rows[i].date);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
			}
    			    $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
    		 			if (r){
    	document.getElementById("mode").value='A';
    	$("#overlay, #PleaseWait").show();
		document.getElementById("frmExtraServiceInvoice").submit();
    		 			}
    			    });
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		
	}
	 function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(exservicedata, 'Extra Services', true);
		  }
		 else
		  {
			 $("#extraServiceInvGrid").jqxGrid('exportdata', 'xls', 'Extra Services');
		  }
		 
		
		
	}
</script>

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
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
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit {
    flex: 1;
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.sidebar-filters label.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

</head>
<body onload="getBranch();setValues();">
<form id="frmExtraServiceInvoice" action="saveExtraServiceInvoice">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

    <!-- LEFT SIDEBAR -->
    <div class="sidebar-filters" style="
        width:320px;
        min-width:320px;
    ">

        <!-- HEADER -->
        <div class="sidebar-fixed-top">

            <jsp:include page="../../heading.jsp"></jsp:include>

        </div>


        <!-- CONTENT -->
        <div class="sidebar-scroll-content">

            <div class="filter-card" style="
                padding:16px;
                border-radius:18px;
            ">

                <table class="filter-table">

                    <!-- PERIOD -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Period Upto</label>
                        </td>

                        <td>
                            <div id="periodupto"></div>
                        </td>

                    </tr>


                    <%-- CLIENT SECTION PRESERVED --%>
                    <%--
                    <tr>
                        <td>
                            <label class="branch">Client</label>
                        </td>

                        <td>
                            <input 
                                type="text"
                                name="client"
                                id="client"
                                onkeydown="getClient(event);"
                                readonly
                                value='<s:property value="client"/>'>
                        </td>
                    </tr>
                    --%>


                    <%-- GRID SECTION PRESERVED --%>
                    <%--
                    <tr>
                        <td colspan="2">

                            <div id="Readygrid">

                                <jsp:include page="invnoGrid.jsp"></jsp:include>

                            </div>

                        </td>
                    </tr>
                    --%>

                </table>


                <!-- BUTTON -->
                <div style="margin-top:18px;">

                    <input 
                        type="button"
                        name="btninvoicesave"
                        id="btninvoicesave"
                        class="btn-submit"
                        value="Generate"
                        onclick="funNotify();">

                </div>

            </div>

        </div>

    </div>



    <!-- RIGHT SIDE -->
    <div class="main-content-wrapper">

        <div class="scrollable-grid-area">

            <div id="extraserviceinvdiv" class="filter-card" style="
                padding:0;
                overflow:hidden;
            ">

                <jsp:include page="extraServiceInvGrid.jsp"></jsp:include>

            </div>

        </div>

    </div>

</div>



<!-- HIDDEN FIELDS -->
<%-- <input type="hidden" name="hidclient" id="hidclient" > --%>

<input 
    type="hidden"
    name="invgridlength"
    id="invgridlength"
    value='<s:property value="invgridlength"/>'>

<input 
    type="hidden"
    name="mode"
    id="mode"
    value='<s:property value="mode"/>'>

<input 
    type="hidden"
    name="msg"
    id="msg"
    value='<s:property value="msg"/>'>

</div>
</form>
</body>
</html>