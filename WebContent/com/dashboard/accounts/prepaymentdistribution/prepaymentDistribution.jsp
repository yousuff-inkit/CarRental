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
    position: relative; /* Allows buttons to be absolutely positioned at the bottom */
    height: 100%; 
    box-sizing: border-box;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

/* User-Provided CSS Fix for Iframe Scrolling */
.sidebar-scroll-content {
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

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#documentSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Document Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#documentSearchWindow').jqxWindow('close');
		 
	     $('#prepaymentDistributionGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#prepaymentDistributionGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtdocumentno').dblclick(function(){
	    	 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
	    	 documentSearchContent('documentSearchGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
	     });
	});
	
	function documentSearchContent(url) {
	 	$('#documentSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#documentSearchWindow').jqxWindow('setContent', data);
		$('#documentSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function prepaymentDistributionSearchContent(url) {
	 	$('#prepaymentDistributionGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#prepaymentDistributionGridWindow').jqxWindow('setContent', data);
		$('#prepaymentDistributionGridWindow').jqxWindow('bringToFront');
	}); 
	}

	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getDocument(event){
        var x= event.keyCode;
        if(x==114){
        	var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
	    	 documentSearchContent('documentSearchGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
        }
        else{}
    }
	
	function funGenerate(){
		 var rows = $("#prepaymentDistributionGridID").jqxGrid('getrows');
		 var length=0;
		 
		 for(var j=0;j<rows.length;j++){
			 	var chk=rows[j].rowno;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
					length=length+1;
					break;
				}
		 }
		 
		 if(parseInt(length)==0){
			 $.messager.alert('Message','Distributing Details to be Entered.','warning');   
			 return false;
		 }
		 
		 $.messager.confirm('Confirm', 'Do you want to Distribute?', function(r){
	  	 		if (r){
	  	 		    $("#overlay, #PleaseWait").show();
	  	 		    var mode = $('#mode').val();
	  	 		 	var fromdate = $('#fromdate').val();
	  			 	var todate = $('#todate').val();
	  			 	var docno = $('#txtdocno').val();
	  	 		 	saveData(mode,fromdate,todate,docno);
	  	 		}
		 });
	}
	
	function saveGridData(docno,dtype,date,trno,tranid,acno,postacno,stdate,enddate,costtype,costcode,amount,brhid,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if(parseInt(items)>0 && $('#mode').val()=='E') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} 
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveGridData.jsp?docno="+docno+"&dtype="+dtype+"&date="+date+"&trno="+trno+"&tranid="+tranid+"&acno="+acno+"&postacno="+postacno+"&stdate="+stdate+"&enddate="+enddate+"&costtype="+costtype+"&costcode="+costcode+"&amount="+amount+"&brhid="+brhid+"&mode="+mode,true);
	x.send();
	}
	
	function saveData(mode,fromdate,todate,docno) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0) {
					$.messager.alert('Message', ' Distributed Successfully.', function(r){
					});
				}  else {
					$.messager.alert('Message', ' Failed', function(r){
					});
				}
				$('#mode').val('');
			    funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?mode="+mode+"&fromdate="+fromdate+"&todate="+todate+"&docno="+docno,true);
	x.send();
	}
	
	function funClearInfo(){
		 $('#cmbbranch').val('a');
 	 	 $('#fromdate').val(new Date());
 	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 document.getElementById("txtdocumentno").value="";document.getElementById("txtdocno").value="";document.getElementById("mode").value="";
		 $("#prepaymentDistributionGridID").jqxGrid('clear');
		 
		 if (document.getElementById("txtdocumentno").value == "") {
		        $('#txtdocumentno').attr('placeholder', 'Press F3 to Search'); 
		 }
	}

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var docno = $('#txtdocno').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#prepaymentDistributionDiv").load('prepaymentDistributionGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&docno='+docno+'&check=1');
	}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'PrepaymentDistributor', true);
		 } else {
			 $("#prepaymentDistributionGridID").jqxGrid('exportdata', 'xls', 'PrepaymentDistributor');
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
                                        <td class="label-cell">DocNo</td>
                                        <td>
                                            <input type="text" id="txtdocumentno" name="txtdocumentno" readonly placeholder="Press F3 to Search" onKeyDown="getDocument(event);" value='<s:property value="txtdocumentno"/>' />
                                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>

   <div class="sidebar-fixed-bottom">
                            <div class="button-group" style="margin: 0;">
                                <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                                <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funGenerate();">Generate</button>
                            </div>
                        </div>
                            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                          
                        </div>

                       

                    </div>

                </td>

                <td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important; height: 100%;">

                    <div style="display: flex; flex-direction: column; height: 100%; box-sizing: border-box;">
                        <div style="width: 100%; margin-bottom: 10px; flex-shrink: 0;">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div id="prepaymentDistributionDiv" style="flex: 1; overflow: auto; min-height: 0; background: #fff;">
                            <jsp:include page="prepaymentDistributionGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </td>
            </tr>
        </table>

        <div id="documentSearchWindow"><div></div><div></div></div>
        <div id="prepaymentDistributionGridWindow"><div></div><div></div></div> 
        <div id="costTypeSearchGridWindow"><div></div><div></div></div> 
        <div id="costCodeSearchWindow"><div></div><div></div></div>
        
    </div>
</div>

</body>
</html>