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

.inner-fieldset {
    border: none !important;
    padding: 8px 0;
    margin: 0;
}

.inner-fieldset legend {
    padding: 0 6px;
    font-weight: 600;
}

.filter-table tr td {
    padding-top: 4px;
    padding-bottom: 4px;
}

.filter-table div[id$="date"] {
    margin-bottom: 6px;
}

.inner-fieldset {
    border: none !important;
    background: transparent !important;
    padding: 6px 0 0 0;
    margin: 6px 0;
}

.inner-fieldset legend {
    padding: 0;
    margin-bottom: 4px;
    font-weight: 600;
}

.inner-fieldset table tr,
.inner-fieldset table td {
    background: transparent !important;
}

.inner-fieldset label {
    margin-left: 4px;
}

td[width="20%"] fieldset {
    max-height: calc(100vh - 120px); 
    overflow-y: auto;
    overflow-x: hidden;
}

td[width="20%"] fieldset::-webkit-scrollbar {
    width: 6px;
}

td[width="20%"] fieldset::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 6px;
}

td[width="20%"] fieldset::-webkit-scrollbar-track {
    background: transparent;
}


/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#assetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Asset Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#assetDetailsWindow').jqxWindow('close');
	     
		 $('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#groupDetailsWindow').jqxWindow('close');
	     
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		  $('#txtasset').dblclick(function(){
			  assetSearchContent('assetSearchGrid.jsp?check=1');
		  });
		  
		  $('#txtgroup').dblclick(function(){
			  groupSearchContent('groupSearchGrid.jsp?check=1');
		  });
			
	     document.getElementById("rdall").checked=true;
	     
	});
	
	function funExportBtn(){
		$("#assetDiv").excelexportjs({
			containerid: "assetDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "fixedAssetRegisterGrid", 
			columns: getColumns("fixedAssetRegisterGrid") ,   
			worksheetName:"FixedAssetRegister"
			});
	} 
	
	
	function assetSearchContent(url) {
	    $('#assetDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#assetDetailsWindow').jqxWindow('setContent', data);
		$('#assetDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupDetailsWindow').jqxWindow('setContent', data);
		$('#groupDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAsset(event){
        var x= event.keyCode;
        if(x==114){
        	assetSearchContent('assetSearchGrid.jsp?check=1');
        }
        else{}
        }
	
	function getGroup(event){
        var x= event.keyCode;
        if(x==114){
        	groupSearchContent('groupSearchGrid.jsp?check=1');
        }
        else{}
        }

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var assetno = $('#txtasset').val();
		 var group = $('#txtgroupno').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		 	
		 }else if(document.getElementById("rdsold").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
			 
		 }else{
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("txtasset").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		
		document.getElementById("rdall").checked=true;
		
		 if (document.getElementById("txtgroup").value == "") {
		        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtasset").value == "") {
		        $('#txtasset').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		}
	function  funPrint()
	 {
		var branchval = document.getElementById("cmbbranch").value;
		var rpttype=0;
		if(document.getElementById("rdall").checked==true){
			rpttype=1;
		}
		else if(document.getElementById("rdsold").checked==true){
			rpttype=2;
		}
		else{
			rpttype=3;
		}
		
		 var assetno = $('#txtasset').val();
		 var group = $('#txtgroupno').val();	
		 	    if ($("#cldocno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("fixedAssetRegister.jsp");
			        var win= window.open(reurl[0]+"printfixedassetregister?rpttype="+rpttype+"&branchval="+branchval+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val()+"&assetno="+assetno+"&group="+group,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Please Select a Client.','warning');
					return;
				}
     }
	  

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

   
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td class="label-cell">From</td>
        <td><div id="fromdate" name="fromdate"
                 value='<s:property value="fromdate"/>'></div></td>
    </tr>

    <tr>
        <td class="label-cell">To</td>
        <td><div id="todate" name="todate"
                 value='<s:property value="todate"/>'></div></td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td class="label-cell">Asset</td>
        <td>
            <input type="text"
                   id="txtasset"
                   name="txtasset"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtasset"/>'
                   onkeydown="getAsset(event);">
        </td>
    </tr>

    <tr>
        <td class="label-cell">Group</td>
        <td>
            <input type="text"
                   id="txtgroup"
                   name="txtgroup"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtgroup"/>'
                   onkeydown="getGroup(event);">
            <input type="hidden"
                   id="txtgroupno"
                   name="txtgroupno"
                   value='<s:property value="txtgroupno"/>'>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>


    <tr>
        <td colspan="2">
            <fieldset class="inner-fieldset">
                <legend><label class="branch"><b>Report Type</b></label></legend>

                <table width="100%">
                    <tr>
                        <td align="center">
                            <input type="radio" id="rdall" name="rdo" value="rdall">
                            <label for="rdall" class="branch">All</label>
                        </td>
                        <td align="center">
                            <input type="radio" id="rdsold" name="rdo" value="rdsold">
                            <label for="rdsold" class="branch">Sold</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="radio" id="rdadditions" name="rdo" value="rdadditions">
                            <label for="rdadditions" class="branch">Additions</label>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td align="center">
            <button type="button"
                    class="btn-submit"
                    onclick="funClearInfo();">Clear</button>
        </td>
        <td align="center">
            <button type="button"
                    class="btn-submit"
                    onclick="funPrint();">Print</button>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

</table>
</fieldset>

</td>

<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="assetDiv">
            <jsp:include page="fixedAssetRegisterGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

</div>

<div id="assetDetailsWindow"><div></div><div></div></div>
<div id="groupDetailsWindow"><div></div><div></div></div>

</div>
</body>

</html>