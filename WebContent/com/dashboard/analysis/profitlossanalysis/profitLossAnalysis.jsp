<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
    box-sizing: border-box;
}
/* Force layout tables to white */
.master-layout-table, .master-layout-table > tbody > tr, .master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}
/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, table td:hover, table th:hover, tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.sidebar-filters {
    width: 330px;
    background: #ffffff !important;
    height: 100%; 
    box-sizing: border-box;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

/* Inline Flow CSS - Buttons naturally follow the inputs */
.sidebar-scroll-content {
    height: 100%;
    overflow-y: auto;
    padding: 15px 20px !important;
    box-sizing: border-box;
}

.sidebar-fixed-bottom {
    margin-top: 15px;
    padding: 0;
    background: transparent;
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}
/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}
.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}
.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
}
/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select, .filter-table input[type="text"], .filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff !important;
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
input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}
/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}
.btn-submit, .myButton, .myButtons {
    flex: 1;
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
    text-align: center;
    transition: background 0.2s;
    width: 100%;
    margin-top: 0;
}
.btn-submit:hover, .myButton:hover, .myButtons:hover { background: #1d4ed8 !important; }
.btn-submit:disabled, .myButton:disabled, .myButtons:disabled { background: #9ca3af !important; cursor: not-allowed; }
</style>

<script type="text/javascript">
    // Native Branch Dropdown Injection
    function getBranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim().split('####');
                if (items.length > 1) {
                    var brchIdItems = items[0].split(",");
                    var brchItems = items[1].split(",");
                    var optionsbrch = '<option value="">--Select--</option>';
                    for (var i = 0; i < brchItems.length; i++) {
                        optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                    }
                    $("select#cmbbranch").html(optionsbrch);
                }
            }
        }
        x.open("GET", "getBranch.jsp", true);
        x.send();
    }

	var selectedBox = null;
	
	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#cmbchoose').val('4');$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
 		 
	     $("#overlay, #PleaseWait").show();
	});
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getGridColumnCalculation(fromdate,todate,frequencytype,noofdays){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			      var frequencyType=items[0];
		          var difference=items[1];
		          var columns=items[2];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else{
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		     		  $("#analysisDiv").load("profitLossAnalysisGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&frequencytype='+frequencytype+'&noofdays='+noofdays+'&check='+check);
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate+"&frequencytype="+frequencytype+"&noofdays="+noofdays, true);
		x.send();
}
	
	function noOfDays(){
		if($('#cmbchoose').val()==1){
			$('#txtnoofdays').attr('readonly', false );$('#txtnoofdays').val('0');			
		}else{
			$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
		}
	}
	
	 function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var frequencytype = $('#cmbchoose').val();
		 var noofdays = $('#txtnoofdays').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
        }
		 
		 getGridColumnCalculation(fromdate,todate,frequencytype,noofdays);
		 
		}
	 
	 function  funClearInfo(){
	        $('#cmbbranch').val('a');
			$('#fromdate').val(new Date());
			var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
		    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		     
			$('#todate').val(new Date());
			$('#cmbchoose').val('4');
			$('#txtnoofdays').val('');
			$('#txtnoofdays').attr('readonly', true );
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'ProfitAndLossAnalysis', true);
		 } else {
			 $("#analysisGrid").jqxTreeGrid('exportData', 'xls');
		 }
	 }
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background" style="height: 100%; overflow: hidden; box-sizing: border-box;"> 
    <div class='hidden-scrollbar' style="height: 100%; box-sizing: border-box;">
        
        <table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important; table-layout: fixed; height: 100%;">
            <tr style="height: 100%;">
                
                <td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed; height: 100%;">
                    
                    <div class="sidebar-filters">
                        
                        <div class="sidebar-scroll-content">
                            
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Period</td>
                                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select id="cmbchoose" name="cmbchoose" onchange="noOfDays();" value='<s:property value="cmbchoose"/>'>
                                                <option value="2">Monthly</option>
                                                <option value="3">Quarterly</option>
                                                <option value="4">Yearly</option>
                                                <option value="5">Branchwise</option>
                                            </select>
                                            <input type="hidden" id="txtnoofdays" name="txtnoofdays" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnoofdays"/>'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="sidebar-fixed-bottom">
                                <div class="button-group" style="margin: 0;">
                                    <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                                </div>
                            </div>

                        </div>
                    </div>

                </td>

                <td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important; height: 100%;">

                    <div style="display: flex; flex-direction: column; height: 100%; box-sizing: border-box;">
                        <div style="width: 100%; margin-bottom: 10px; flex-shrink: 0;">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div id="analysisDiv" style="flex: 1; overflow: auto; min-height: 0; background: #fff;">
                            <jsp:include page="profitLossAnalysisGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </td>
            </tr>
        </table>
        
    </div>
</div>

</body>
</html>