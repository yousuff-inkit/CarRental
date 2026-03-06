
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen"
	rel="stylesheet" type="text/css" />

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
</style>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
						$("body")
								.prepend(
										'<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
						$("body")
								.prepend(
										"<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
						$('#accountSearchwindow').jqxWindow({
							width : '50%',
							height : '62%',
							maxHeight : '75%',
							maxWidth : '50%',
							title : 'Client Search',
							position : {
								x : 150,
								y : 60
							},
							keyboardCloseKey : 27
						});
						$('#accountSearchwindow').jqxWindow('close');
						$('#account').dblclick(function() {
							$('#accountSearchwindow').jqxWindow('open');
							accountSearchContent('driverSearch.jsp');
						});
						
						$('#branchlabel').hide();
						$('#branchdiv').hide();
					});

	function funExportBtn() {
		$("#userdriverdiv").excelexportjs({
			containerid : "userdriverdiv",
			datatype : 'json',
			dataset : null,
			gridId : "userlist",
			columns : getColumns("userlist"),
			worksheetName : "User Driver Link" 
		});
	}

	function getaccountdetails(event) {
		var x = event.keyCode;

		if (x == 114) {
			$('#accountSearchwindow').jqxWindow('open');

			accountSearchContent('driverSearch.jsp');
		} else {
		}

	}
	function accountSearchContent(url) {

		$.get(url).done(function(data) {

			$('#accountSearchwindow').jqxWindow('setContent', data);

		});
	}
	function funreload(event) {

		var acno = $("#acno").val();
		var check = 1;
		var rx = 0;
		
		$("#overlay, #PleaseWait").show();
		$("#userdriverdiv").load(
				"userDetailsGrid.jsp?cldoc=" + acno + '&check=' + check
						+ '&rx=' + rx);


	}
	function funUpdate() {
        var acno = $("#acno").val();
       
		var rows1 = $("#userlist").jqxGrid('getrows');
		var len=0;
		var userid= $("#userid").val();
		if(userid== '' || userid == null ){
			$.messager.alert("Message","Please Select User");
			return false;
		}
		
if(acno== '' || acno == null ){
	$.messager.alert("Message","Please Select Driver");
	return false;
		}
			var x=new XMLHttpRequest();
		    x.onreadystatechange=function()
		    {
		         
		    	if (x.readyState == 4 && x.status == 200)
		        {
		        	var msg=x.responseText.trim();
		            if(msg=="1")
		            {
		            	funreload();
		              	funClear();
		               	$.messager.alert("Message","Updated Successfully");
		            }
		            else
		            {
		                    
		            	$.messager.alert("Message","Not Updated");
		            }
		    }
		    }
		    x.open("GET", "savedata.jsp?driverid="+acno+'&userid='+userid, true);
		    x.send();
}
	function funClear() {
		$('#account').val('');
		$("#acno").val('');
		$("#userid").val('');
		//$("#userlist").jqxGrid('clear');
		$("#account").attr('placeholder', 'Press F3 to Search');
		document.getElementById("account").setAttribute("placeholder",
				"Press F3 to Search");

	}
	
	
	
	
	
	function sessionSet() {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
		  }
		}
			
	x.open("GET","setSession.jsp",true);
	x.send();
	}
	
	
</script>
</head>
<body onload="getBranch();">
<form id="frmClientAlias" action="clienalias" method="post" autocomplete="off">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">Driver</td>
        <td>
            <input type="text"
                   id="account"
                   name="account"
                   class="master-input"
                   readonly
                   placeholder="Press F3 To Search"
                   value='<s:property value="account"/>'
                   onkeydown="getaccountdetails(event);">
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <input type="hidden"
                   id="txtproductname"
                   name="txtproductname"
                   value='<s:property value="txtproductname"/>'>
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="btn-submit"
                    id="clear"
                    onclick="funClear();">
                Clear
            </button>

            <button type="button"
                    class="btn-submit"
                    id="update"
                    onclick="funUpdate();">
                Update
            </button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="summs" style="min-height: 200px;"></div>
        </td>
    </tr>

</table>
</fieldset>

<input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>

</td>

<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="userdriverdiv">
            <jsp:include page="userDetailsGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

<input type="hidden" id="cldoc" name="cldoc">
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="cagridlength" name="cagridlength">
<input type="hidden" id="rx1" name="rx1" value='<s:property value="rx1"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="userid" name="userid" value='<s:property value="userid"/>'>

</div>

<div id="accountSearchwindow">
    <div></div>
</div>

</div>
</form>
</body>

</html>