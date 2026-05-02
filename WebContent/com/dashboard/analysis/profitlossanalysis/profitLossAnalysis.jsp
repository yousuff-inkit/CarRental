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
      .master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

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
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
}

input[type="text"],
select {
    width: 100%;
    height: 24px;
    padding: 0 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

select option {
    font-size: 13px;
}

.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px;
    padding: 0 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    box-sizing: border-box;
}

.btn-submit:hover,
.myButtons:hover,
.myButton:hover,
input[type="button"]:hover,
button:hover {
    background-color: #1d4ed8 !important;
}

select {
    width: 100%;
    height: 24px;
    padding: 0 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px !important;
    font-family: 'Segoe UI', Tahoma, sans-serif !important;
    line-height: 24px;
    box-sizing: border-box;
}

select option {
    font-size: 13px !important;
    font-family: 'Segoe UI', Tahoma, sans-serif !important;
}
</style>
<script type="text/javascript">
    
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
			/*  $("#analysisDiv").excelexportjs({  
		       		containerid: "analysisDiv", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "analysisGrid", 
		       		columns: getColumns("analysisGrid") , 
		       		worksheetName:"Profit and loss Analysis"
		       		}); */  

	 }
	
</script>
</head>
<body onload="getBranch();">
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

            <div style="padding: 0 5px;">
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="analysisDiv">
                <jsp:include page="profitLossAnalysisGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
		</div>
	</div> 
</body>
</html>