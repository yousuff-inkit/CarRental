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
 
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#userwindow').jqxWindow({ width: '25%', height: '68%',  maxHeight: '68%' ,maxWidth: '25%' , title: 'Username Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#userwindow').jqxWindow('close');
		 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdticketdate").checked=true;
	     document.getElementById("rdsalik").checked=true;
	     fundisable();
	     $('#username').dblclick(function(evt){
		    	var satcategory="";
				if (document.getElementById('rdsalik').checked==true) {
					satcategory="Salik";
				} else if (document.getElementById('rdtraffic').checked==true) {
					satcategory="Traffic";
				}
				var saliksource=$('#cmbsaliksource').val();
				$('#userwindow').jqxWindow('open');
				$('#userwindow').jqxWindow('focus');
				usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1'); 
		    });
		
	});
	
	function usernameSearchContent(url) {
		$.get(url).done(function (data) {
			$('#userwindow').jqxWindow('setContent', data);
		}); 
	}
	function getDailyCount(fromdate,todate,satcateg) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
		               items= x.responseText;
		        	   document.getElementById("searchdetails").value=items;
		    } else {}
		}
		x.open("GET",'getDailyCount.jsp?fromdate='+fromdate+'&todate='+todate+'&satcateg='+satcateg,true);
		x.send();
	}

	function funreload(event){
		 
  		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
	 	 
	   	 if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   	   return false;
	     }
	   	 
	   	if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
			   $.messager.alert('Message','Select Salik / Traffic','warning');
			   return false;
		} else {
		
			 var barchval = document.getElementById("cmbbranch").value;
		     var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 var check=1;
	         var satcateg="";
	         var datefilter="";
	         var saliksource=$('#cmbsaliksource').val();
	         var username=$('#username').val();
	         if (document.getElementById('rdticketdate').checked) {
	        	 datefilter="1";
	         } else if (document.getElementById('rddownloaddate').checked) {
	        	 datefilter="2";
	         }
	   			  
	         
	         if (document.getElementById('rdticketdate').checked) {
	        	 datefilter="1";
	         } else if (document.getElementById('rddownloaddate').checked) {
	        	 datefilter="2";
	         }
	         
			 if (document.getElementById('rdsalik').checked) {
				satcateg="salik";
		 		$("#overlay, #PleaseWait").show();
		  		$("#satSalikDiv").load("satSalikGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=salik&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&username="+username);
		  
			} else if (document.getElementById('rdtraffic').checked) {
				satcateg="traffic";
		 		$("#overlay, #PleaseWait").show();
		  		$("#satTrafficDiv").load("satTrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=traffic&datefilter="+datefilter+"&check="+check+"&username="+username);
		  
			}
	 
	 		$("#satCountDiv").load("satCountGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg+"&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&userName="+username);
	 		//getDailyCount(fromdate,todate,satcateg);
		 
			}
	   	
		}

		function clearUserName(){
			$('#username').val('');
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	if (document.getElementById('rdsalik').checked) {
			 	/* JSONToCSVCon(salikdailyexceldata, 'Salik Daily List', true); */
			 	$("#satSalikDiv").excelexportjs({
					 containerid: "satSalikDiv",
					 datatype: 'json',
					 dataset: null,
					 gridId: "jqxloaddataGrid",
					 columns: getColumns("jqxloaddataGrid") ,
					 worksheetName:"Salik Daily List"
					 });
		    } 
		  	if (document.getElementById('rdtraffic').checked) {
				/* JSONToCSVCon(trafficdailyexceldata, 'Traffic Daily List', true); */
				$("#satTrafficDiv").excelexportjs({
					 containerid: "satTrafficDiv",
					 datatype: 'json',
					 dataset: null,
					 gridId: "jqxloadtrafficdataGrid",
					 columns: getColumns("jqxloadtrafficdataGrid") ,
					 worksheetName:"Traffic Daily List"
					 });
			}
		 }
	 }
		
	function fundisable(){
		if (document.getElementById('rdsalik').checked) {
			  $('#satSalikDiv').show();$('#satTrafficDiv').hide();
		} else if (document.getElementById('rdtraffic').checked) {
			  $('#satSalikDiv').hide();$('#satTrafficDiv').show();
		}
	}
	function funGetUsername(evt){
		var x= event.keyCode;
		if(x==114){
			var satcategory="";
			if (document.getElementById('rdsalik').checked) {
				satcategory="Salik";
			} else if (document.getElementById('rdtraffic').checked) {
				satcategory="Traffic";
			}
			var saliksource=$('#cmbsaliksource').val();
			$('#userwindow').jqxWindow('open');
			$('#userwindow').jqxWindow('focus');
			usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1');
		}
		else{
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

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <jsp:include page="../../heading.jsp"></jsp:include>

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

    <tr>
        <td class="label-cell">Salik Source</td>
        <td>
            <select id="cmbsaliksource" name="cmbsaliksource" class="master-input">
                <option value="">All</option>
                <option value="AUH">AUH</option>
                <option value="DXB">DXB</option>
            </select>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div class="filter-card" style="margin-top:10px;">

                <div style="font-weight:600;color:#1a3a5f;margin-bottom:6px;">
                    Report Type
                </div>

                <table width="100%">
                    <tr>
                        <td>
                            <input type="radio" id="rdticketdate"
                                   name="rddatefilter"
                                   value="rdticketdate">
                            <label for="rdticketdate" class="branch">
                                Ticket Date
                            </label>
                        </td>
                        <td>
                            <input type="radio" id="rddownloaddate"
                                   name="rddatefilter"
                                   value="rddownloaddate">
                            <label for="rddownloaddate" class="branch">
                                Download Date
                            </label>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input type="radio" id="rdsalik"
                                   name="rdcategory"
                                   value="rdsalik"
                                   onchange="fundisable();">
                            <label for="rdsalik" class="branch">
                                Salik
                            </label>
                        </td>
                        <td>
                            <input type="radio" id="rdtraffic"
                                   name="rdcategory"
                                   value="rdtraffic"
                                   onchange="fundisable();">
                            <label for="rdtraffic" class="branch">
                                Traffic
                            </label>
                        </td>
                    </tr>
                </table>

            </div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">User</td>
        <td>
            <div style="display:flex;gap:6px;align-items:center;">
                <input type="text"
                       id="username"
                       name="username"
                       class="master-input"
                       onkeydown="funGetUsername(event);">
                <button type="button"
                        onclick="clearUserName()"
                        class="btn-clear">œ</button>
            </div>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="satCountDiv">
                <jsp:include page="satCountGrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <textarea id="searchdetails"
                      name="searchdetails"
                      class="master-textarea"
                      hidden
                      readonly></textarea>
        </td>
    </tr>

</table>
</fieldset>

</td>

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="satSalikDiv">
            <jsp:include page="satSalikGrid.jsp"></jsp:include>
        </div>

        <div id="satTrafficDiv">
            <jsp:include page="satTrafficGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>
</tr>
</table>

<div id="userwindow"><div></div></div>

</div>
</div>
</body>

</html>