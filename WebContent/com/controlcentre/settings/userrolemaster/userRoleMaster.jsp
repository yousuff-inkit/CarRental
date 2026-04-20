<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>

<script type="text/javascript">
      
		$(document).ready(function() {});
		
		function funReadOnly(){
			$('#btnclone').hide();
			$('#frmUserRoleMaster input').attr('readonly', true );
			$("#jqxUserRole").jqxGrid({ disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmUserRoleMaster input').attr('readonly', false );
			$('#docno').attr('readonly', true);
			$("#jqxUserRole").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "A") {
				$("#userRoleDiv").load("userRoleGrid.jsp");  
		    }
		    if ($("#mode").val() == "E") {
		    	$('#txtrolename').attr('readonly', true);  
		    }
		}
		
		function funSearchLoad(){
			 changeContent('rleMainSearch.jsp');  
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			document.getElementById("txtrolename").focus(); 	    		
		}
		
		function funNotify(){	
			
            if(document.getElementById("txtrolename").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Role";
        		document.getElementById("txtrolename").focus();
	        	return 0;
        	}
    		
			/* User Role Grid Saving */
  	 		var rows = $("#jqxUserRole").jqxGrid('getrows');
  			 var length=0;
  			 for(var i=0 ; i < rows.length ; i++){
  				var chk=rows[i].mno;
  				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  					newTextBox = $(document.createElement("input"))
  				    .attr("type", "dil")
  				    .attr("id", "test"+length)
  				    .attr("name", "test"+length)
  					.attr("hidden", "true");
  					length=length+1;
  					
  				newTextBox.val(rows[i].mno+"::"+rows[i].menu_name+":: "+rows[i].add1+":: "+rows[i].edit+":: "+rows[i].del+":: "+rows[i].print+":: "+rows[i].attach+":: "+rows[i].excel+":: "+rows[i].email+":: "+rows[i].costing+":: "+rows[i].terms+":: "+rows[i].view);
  				newTextBox.appendTo('form');
  				}
  			  }
  			$('#gridlength').val(length);
  			 /* User Role Grid Saving Ends*/ 
		    		
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			  var indexVal = document.getElementById("docno").value;
			  if(indexVal>0){
	          $("#userRoleDiv").load("userRoleGrid.jsp?roleid="+indexVal);
			  }
			  
			}
		  function funClone(){
				 $('#docno').val("");
				 $("#mode").val("A");
				 $("#msg").val("");
				 $("#txtrolename").val("");
				 //funRemoveReadOnly();
				 $("#btnSendmail").hide();
				 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
				 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
				 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
				 $("#btnSearch").hide(); $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
				 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
				 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
				 $('#frmUserRoleMaster input').attr('readonly', false );
					$('#docno').attr('readonly', true);
					$("#jqxUserRole").jqxGrid({ disabled: false}); 
					$('#fileexcelimport').attr('hidden', false );
					$('#btnsearch').attr('hidden', false );
					$('#btnEdit').attr('disabled', false );
					$("#jqxUserRole").jqxGrid('addrow', null, {});
			 }
		
  </script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
#validrate{
 color:red;
 }
 

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #222;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 12px;
    padding: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 160px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

table {
    border-collapse: separate;
    border-spacing: 0 8px; 
}

td {
    padding: 2px 5px;
    font-size: 12px;
    vertical-align: middle;
}

td[align="right"] {
    font-weight: bold;
    color: #444;
    white-space: nowrap;
    padding-right: 5px;
}

input[type="text"], 
select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 4px;
    padding: 2px 4px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    transition: all 0.2s;
}

input[type="text"]:focus, 
select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

input[readonly] {
    background-color: #f8f9fa;
    color: #666;
}

fieldset {
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    background: #fdfdfd;
    margin-bottom: 10px;
}

.myButton {
    height: 28px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    font-size: 11px;
    cursor: pointer;
    text-transform: uppercase;
    transition: 0.3s;
}
.myButton:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
}

.myButton:disabled {
    background: #ccc;
    cursor: not-allowed;
}

button.icon {
    background: transparent;
    border: 1px solid #e1e4e8;
    border-radius: 4px;
    cursor: pointer;
    padding: 3px;
    transition: background 0.2s;
}
button.icon:hover { background: #f0f3f5; }
button.icon img { width: 20px; height: 20px; }

#divMCPGrid {
    border: 1px solid #c5d3e0;
    border-radius: 6px;
    overflow: hidden;
    margin-top: 10px;
}

#errormsg, #validrate {
    color: #d93025;
    font-size: 11px;
    font-weight: bold;
    display: block;
    padding-top: 2px;
}

.jqx-datetimeinput {
    height: 24px !important;
}

legend {
    font-size: 14px;
    font-weight: bold;
    padding: 0 10px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    
    border-left: 3px solid #0b45a2;
    line-height: 1.2;
    margin-bottom: 5px;
}

.jqx-grid-header {
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}


.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; 
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}


.jqx-grid-cell-alt {
    background: #f1f3f5 !important; 
}


.jqx-grid-cell-hover {
    background: #dee2e6 !important; 
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; 
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}


.jqx-grid {
    border: 1px solid #adb5bd !important; /* Darker outer border */
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}


.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}


.jqx-grid-pager {
    background: #e9ecef !important; /* Darker pager background */
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}


.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; /* Steel grey thumb */
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; /* Deep grey on hover */
    border-radius: 4px !important;
}
</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleMaster" action="saveUserRoleMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset><legend>User Role Info</legend>
<table width="100%">
  <tr>
    <td width="3%" align="right">Role</td>
    <td width="23%"><input type="text" id="txtrolename" name="txtrolename" style="width:85%;" value='<s:property value="txtrolename"/>'/></td>
	<td width="4%" align="right">Email</td>
    <td width="26%"><input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" style="width:80%;" value='<s:property value="txtemail"/>'/></td>
   <td ><button class="myButton" type="button" id="btnclone" name="btnclone"  onclick="funClone();">Clone</button></td>
   <td width="6%" align="right">Doc No.</td>
    <td width="38%"><input type="text" id="docno" name="txtuserroledocno" style="width:30%;" value='<s:property value="txtuserroledocno"/>' tabindex="-1"/></td>
  </tr>
</table></fieldset><br/>

<div id="userRoleDiv"><jsp:include page="userRoleGrid.jsp"></jsp:include></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</form>

<div id="roleDetailsWindow">
	<div></div>
</div> 

</div>
</body>
</html>