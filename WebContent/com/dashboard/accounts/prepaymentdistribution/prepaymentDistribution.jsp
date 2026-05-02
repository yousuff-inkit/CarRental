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

.btn-submit,
.myButtons,
.myButton {
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
.myButton:hover {
    background-color: #1d4ed8 !important;
}
.button-row {
    display: flex;
    gap: 6px;
}

.button-row .myButton {
    flex: 1;
    width: 50%;
    margin: 0 !important;
    height: 24px;
}
</style>

<script type="text/javascript">

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
	  	 			
	  	 			/* var gridarray=new Array();
	  	 		 	for(var i=0;i<rows.length;i++){
		  	 		 	var chk=rows[i].rowno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
							
							var tranid = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "tranid");
							var trno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "trno");
			     		 	var acno = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "acno");
			     		 	var postacno = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "postacno");
			     		 	var stdate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "stdate");
			     		 	var enddate = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "enddate");
			     		    var costtype = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "costtype");
			     		    var costcode = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "costcode");
			     		    var amount = $('#prepaymentDistributionGridID').jqxGrid('getcellvalue', i, "dramount");
			     		    var brhid = $('#prepaymentDistributionGridID').jqxGrid('getcelltext', i, "brhid");
				     		 	
							gridarray.push(tranid+":: "+acno+":: "+postacno+":: "+stdate+":: "+enddate+":: "+costtype+":: "+costcode+":: "+amount+":: "+brhid+":: "+trno);
							
						}
	  	 		 	}*/
	  	 		 	
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
                        <td class="label-cell">DocNo</td>
                        <td>
                            <input type="text" id="txtdocumentno" name="txtdocumentno" readonly placeholder="Press F3 to Search" onKeyDown="getDocument(event);" value='<s:property value="txtdocumentno"/>' />
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

<div class="filter-card">
    <div class="button-row">
        <input type="button"
               class="myButton"
               name="clear"
               id="clear"
               value="Clear"
               onclick="funClearInfo();">

        <button class="myButton"
                type="button"
                id="btnGenerate"
                name="btnGenerate"
                onclick="funGenerate();">
            Generate
        </button>
    </div>
</div>

            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="prepaymentDistributionDiv">
                <jsp:include page="prepaymentDistributionGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<div id="documentSearchWindow">
	<div></div><div></div>
</div>

<div id="prepaymentDistributionGridWindow">
	<div></div><div></div>
</div> 

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div>

</body>
</html>