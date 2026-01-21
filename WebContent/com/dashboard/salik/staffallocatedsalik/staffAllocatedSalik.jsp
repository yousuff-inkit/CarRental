<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
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

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 $('#txtempname').dblclick(function(){
			  var branchval = document.getElementById("cmbbranch").value; 
			  var emptype = $('#emptype').val();  
			  
			  if(emptype==''){
				 $.messager.alert('Message','Choose an Employee Type.','warning');
				 return 0;
			  }
			 
			  employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype); 
			});
     	$("#btnExcel").click(function() {
 		
     		 if(parseInt(window.parent.chkexportdata.value)=="1")
			  {
			  	JSONToCSVCon(data1, 'Staff-Allocated-Salik', true);
			  }
			 else
			  {
				$("#jqxstaffAllocatedSalik").jqxGrid('exportdata', 'xls', 'Staff-Allocated-Salik');
			  }
     		
 		});            


			});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	var emptype = $('#emptype').val();
  		  
  		    if(emptype==''){
  				 $.messager.alert('Message','Choose an Employee Type.','warning');
  				 return 0;
  			 }
        	var branchval = document.getElementById("cmbbranch").value; 
  		    employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype);
        }
        else{}
        }
		
	function empchange(){
		$('#txtempid').val('');$('#txtempname').val('');
		
		if (document.getElementById("txtempname").value == "") {
	        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
	    }
	}

	function  funClearData(){
		 $('#emptype').val('');$('#txtempname').val('');$('#txtempid').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());$('#date').val(new Date());
		
		 $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtempname").value == "") {
		        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function datechange(){
	    var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
		return 0;	
		}
    }
	
	function funreload(event){
		var brhid = $('#cmbbranch').val();
		if(brhid=="" || brhid=="a"){
			$.messager.alert('Message','Please select branch','warning');
			return 0;
		}
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var emptype = $('#emptype').val();
		 var empname = $('#txtempid').val();
		 var saliktype=$('#cmbsaliktype').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#staffAllocatedDiv").load("staffAllocatedSalikGrid.jsp?saliktype="+saliktype+"&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&emptype='+emptype+'&empname='+empname);
	}
	
	 function funUpdate(event){
		
		var selectedrows=$('#jqxstaffAllocatedSalik').jqxGrid('getselectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Message','Please select valid documents','warning');
			return 0;
		}
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		var saveerror=0;
		for(let i = 0; i < selectedrows.length; i++) {
			var savestatus=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', selectedrows[i], "savestatus");
			if(savestatus=="1"){
				$.messager.alert('Message','Already Posted Documents Present','warning');
				saveerror=1;
				return 0;
			}
		}
		
		if(saveerror==1){
			return false;
		}
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			if(r){
				multipleSave(selectedrows);
			}
			else{
				return false;
			}
		
		 });
	}
	
	async function multipleSave(selectedrows){
		var errorstatus=0;
		$("#overlay, #PleaseWait").show();
		var docarray=new Array(); 
		for(let i = 0; i < selectedrows.length; i++) {
			var rowindex1=selectedrows[i];
			var salikaccount = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "salikacc");
			var expenseaccount = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "expacc");
			var rano = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "st_desc");
			var fleetno = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "fleetno");
			var platecode = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "platecode");
			var amount = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "totalamount");
			var mainbranch =$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "mainbranch");
			if(mainbranch==null || mainbranch=="0" || mainbranch=="" || mainbranch=="undefined" || typeof(mainbranch)=="undefined"){
				mainbranch=$('#cmbbranch').val();
			}
			var docno = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "doc_no");
			var srno = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "sr_no");
			var amountcount = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "amountcount");
			var empid = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "emp_id");
			var tagno = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "tagno");
			var salikauhcount=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "auhsalikcount");
			var salikdxbcount=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "dxbsalikcount");
			var salikauhamt=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "auhsalikamt");
			var salikdxbamt=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "dxbsalikamt");
			
			var salikparkcount=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "salikparkcount");
			var salikparkamt=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "salikparkamt");
			var salikregno=$('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "regno");
			var postdate = $('#date').val();
			var saliktype=$('#cmbsaliktype').val();
			const response = await fetch("saveData.jsp?saliktype="+saliktype+"&salikparkcount="+salikparkcount+"&salikparkamt="+salikparkamt+"&salikaccount="+salikaccount+"&expenseaccount="+expenseaccount+"&rano="+rano+"&fleetno="+fleetno+"&amount="+amount+"&mainbranch="+mainbranch+"&docno="+docno+"&srno="+srno+"&amountcount="+amountcount+"&empid="+empid+"&tagno="+tagno+"&postdate="+postdate+"&salikauhcount="+salikauhcount+"&salikauhamt="+salikauhamt+"&salikdxbamt="+salikdxbamt+"&salikdxbcount="+salikdxbcount+"&salikregno="+salikregno+"&platecode="+platecode);
		    const data = await response.json();
		    if(data.errorstatus=="0"){
		    	$('#jqxstaffAllocatedSalik').jqxGrid('setcellvalue',rowindex1,'savestatus','1');
        		$('#jqxstaffAllocatedSalik').jqxGrid('refresh');	
        		docarray.push(data.docno);
		    }
		    else{
		    	errorstatus=1;
		    	return false;
		    }
			
		}
		$("#overlay, #PleaseWait").hide();
		 
		if(errorstatus==1){
			$.messager.alert('Message','Not Updated','warning');
			return 0;
		}
		else{
			if(docarray.length==1){
				$.messager.alert('Message','Successfully Created JVT '+docarray[0],'message');
			}
			else if(docarray.length>1){
				$.messager.alert('Message','Successfully Created JVT '+docarray[0]+' to '+docarray[(docarray.length)-1],'message');
			}
		}
	}
	function saveGridData(salikaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,tagno,postdate){
		$("#overlay, #PleaseWait").show();
		var rowindex=$('#gridrowindex').val();

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0].trim();
				var jvno = items[1].trim();
				$("#overlay, #PleaseWait").hide();
				if(val=="0" && jvno=="0"){
					$.messager.alert('Warning','Please select valid document', function(r){
					});
				}
				else{
					$.messager.alert('Message', '  Tag No: '+$('#txttagno').val()+' of Fleet No: '+$('#txtfleetno').val()+' is Passed as Journal Voucher No.: '+items[1]+'', function(r){
					});	
				}
				var salikaccount = $('#txtsalikaccount').val('');
				var expenseaccount = $('#txtexpenseaccount').val('');
				var rano = $('#txtrano').val('');
				var fleetno = $('#txtfleetno').val('');
				var amount = $('#txtamount').val('');
				var mainbranch = $('#txtmainbranch').val('');
				var docno = $('#txtdocno').val('');
				var srno = $('#txtsrno').val('');
				var amountcount = $('#txtamountcount').val('');
				var empid = $('#txtemployeeid').val('');
				var tagno = $('#txttagno').val('');
				var vehinfo = $('#vehinfo').val('');
				$('#date').val(new Date());
				
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?salikaccount="+salikaccount+"&expenseaccount="+expenseaccount+"&rano="+rano+"&fleetno="+fleetno+"&amount="+amount+"&mainbranch="+mainbranch+"&docno="+docno+"&srno="+srno+"&amountcount="+amountcount+"&empid="+empid+"&tagno="+tagno+"&postdate="+postdate+"&salikauhcount="+salikauhcount+"&salikauhamt="+salikauhamt+"&salikdxbamt="+salikdxbamt+"&salikdxbcount="+salikdxbcount,true);
	x.send();
	}
		
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT SIDE ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED – WILL APPEAR) -->
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

    <tr>
        <td class="label-cell">Type</td>
        <td>
            <select id="emptype" name="emptype"
                    onchange="empchange();"
                    class="master-input"
                    value='<s:property value="emptype"/>'>
                <option value="">--Select--</option>
                <option value="STF">Staff</option>
                <option value="DRV">Driver</option>
            </select>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Salik Type</td>
        <td>
            <select id="cmbsaliktype" name="cmbsaliktype"
                    class="master-input"
                    value='<s:property value="cmbsaliktype"/>'>
                <option value="">--Select--</option>
                <option value="SAL">Salik</option>
                <option value="PAR">Parking</option>
            </select>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Employee</td>
        <td>
            <input type="text"
                   id="txtempname"
                   name="txtempname"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   onkeydown="getEmployee(event);"
                   value='<s:property value="txtempname"/>'>
            <input type="hidden"
                   id="txtempid"
                   name="txtempid"
                   value='<s:property value="txtempid"/>'>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td colspan="2" align="center">
            <textarea id="vehinfo"
                      name="vehinfo"
                      class="master-textarea"
                      readonly><s:property value="vehinfo"/></textarea>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td class="label-cell">Posting</td>
        <td>
            <div id="date" name="date"
                 onchange="datechange();"
                 value='<s:property value="date"/>'></div>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="btn-submit"
                    onclick="funClearData();">Clear</button>

            <button type="button"
                    class="btn-submit"
                    id="btnupdate"
                    onclick="funUpdate(event);">Update</button>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <!-- HIDDEN FIELDS (UNCHANGED) -->
    <tr><td colspan="2">
        <input type="hidden" id="txtsalikaccount" name="txtsalikaccount" value='<s:property value="txtsalikaccount"/>'>
        <input type="hidden" id="txtexpenseaccount" name="txtexpenseaccount" value='<s:property value="txtexpenseaccount"/>'>
        <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'>
        <input type="hidden" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>'>
        <input type="hidden" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>'>
        <input type="hidden" id="txtamountcount" name="txtamountcount" value='<s:property value="txtamountcount"/>'>
        <input type="hidden" id="txtmainbranch" name="txtmainbranch" value='<s:property value="txtmainbranch"/>'>
        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'>
        <input type="hidden" id="txtsrno" name="txtsrno" value='<s:property value="txtsrno"/>'>
        <input type="hidden" id="txttagno" name="txttagno" value='<s:property value="txttagno"/>'>
        <input type="hidden" id="txtemployeeid" name="txtemployeeid" value='<s:property value="txtemployeeid"/>'>
    </td></tr>

</table>
</fieldset>

</td>

<!-- ===== RIGHT GRID ===== -->
<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="staffAllocatedDiv">
            <jsp:include page="staffAllocatedSalikGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

</div>

<div id="employeeDetailsWindow">
    <div></div><div></div>
</div>

</div> 
</body>

</html>