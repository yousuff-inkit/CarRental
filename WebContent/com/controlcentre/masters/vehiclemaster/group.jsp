<%@page import="com.controlcentre.masters.vehiclemaster.group.ClsGroupAction" %>
<% ClsGroupAction cga =new ClsGroupAction();%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
#validrate{
    color:red;
}
#validrate1{
    color:red;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}
#mainBG {
    background: #fff;
    border-radius: 16px;
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		 var data= '<%=cga.searchDetails() %>';
		 
		    document.getElementById("formdet").innerText="Group(GRP)";
			document.getElementById("formdetail").value="Group";
			document.getElementById("formdetailcode").value="GRP";
			window.parent.formCode.value="GRP";
			window.parent.formName.value="Group";
	            var num = 0; 
	            var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	     						{name : 'gid', type: 'String'  },
	                          	{name : 'gname', type: 'String'  },
	                          	{name : 'date',type:'date'},
	                          	{name : 'utype',type:'number'},
	                          	{name : 'level',type:'number'}
	                          	
	                          	
	                 ],
	                 localdata: data,
	                
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    alert(error);    
		                    }
			            }		
	            );
	        
	            $("#jqxGroupSearch1").jqxGrid(
	                    {
	                    	width: '70%',
	                        height: 315,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        //pagermode: 'default',
	                        sortable: true,
	                       // pageable: true,
	                        altrows:true,
	                        //Add row method
	                        columns: [
										{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
										{ text: 'Group Name', datafield: 'gname', width: '60%' },
										{text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'}
	        					     ]
	                       });
	            $('#jqxGroupSearch1').on('rowdoubleclick', function (event) 
	            		{ 
			            	var rowindex1=event.args.rowindex;
			                document.getElementById("docno").value= $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
			                document.getElementById("group").value=$('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "gid");
			                document.getElementById("name").value=$('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "gname");
			                document.getElementById("level").value=$('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "level");
			                $("#groupdate").jqxDateTimeInput('val',$("#jqxGroupSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
			                $('#utype').val($("#jqxGroupSearch1").jqxGrid('getcellvalue', rowindex1, "utype")) ;
			       //	$('#groupdate').jqxDateTimeInput({ disabled: false}); 

	            		 });
		$("#groupdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	});
	  function funSearchLoad(){
			changeContent('groupSearch.jsp', $('#window')); 
		 }
	function funReadOnly() {
		$('#frmGroup input').attr('readonly', true);
		$('#frmGroup select').attr('disabled', true);
		 $('#groupdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmGroup input').attr('readonly', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		$('#frmGroup select').attr('disabled', false);
		 $('#groupdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
	}
	function setValues() {
		$('#utype').val($('#utypehidden').val()) ;
		//alert(document.getElementById("utype").value);
		//alert(document.getElementById("utypehidden").value);
		if($('#groupdatehidden').val()){
			$("#groupdate").jqxDateTimeInput('val', $('#groupdatehidden').val());	
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

	}
	function funFocus(){
		document.getElementById("group").focus();
	}
	 $(function(){
	        $('#frmGroup').validate({
	                 rules: {
	                 group:{
	                	 required:true,
	                	 maxlength:10
	                 },
	                 name:{
	                	 maxlength:40
	                 },
	                 utype:{
	                	 required:true
	        
	                 }
	                 },
	                 messages: {
	                  group:{
	                	  required:" *",
	                	  maxlength:"max 10 chars"
	                  },
	                  name:{
	                	  maxlength:"max 40 chars"
	                  },
	                  utype:{
	                	  required:" *"
	                        }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     function funExcelBtn(){
			  $("#jqxGroupSearch1").jqxGrid('exportdata', 'xls', 'Group');
		  }
	/* function verify()
	{
		document.getElementById("utypehidden").value=document.getElementById("utype").value
	} */
</script>

</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmGroup" action="saveActionGroup" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
    <div class='hidden-scrollbar receipt-header'>
			<div class="table-section" style="width: 100%;">
				<h3>Group Details</h3>
				<table class="cr-table" width="100%">
					<tr>
						<td><div align="right">Date</div></td>
						<td><div id="groupdate" name="groupdate"
								value='<s:property value="groupdate"/>'></div></td>
						<td><div align="right">Doc No</div></td>
						<td><input type="text" name="docno" id="docno"
							value='<s:property value="docno"/>' readonly  tabindex="-1"></td>
					</tr>
					<tr>
						<td><div align="right">Group</div></td>
						<td><input type="text" name="group" id="group"
							required="required" value='<s:property value="group"/>'></td>
						<td><div align="right">Name</div></td>
						<td><input type="text" name="name" 
							 value='<s:property value="name"/>' id="name"></td>
					</tr>
				</table>
                <!--<div align="right">Level</div><input type="text" name="level" 
							id="level" value='<s:property value="level"/>'>
<div align="right">Utility Type</div><select name="utype" id="utype" style="width:31%;"  
							value='<s:property value="utype"/>'><option value="">--Select--</option><option value="ECONOMY">ECONOMY</option><option value="LUXURY">LUXURY</option>
						</select>-->
										        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
						
<input type="hidden" id="mode" name="mode"/><input type="hidden" id="utypehidden" name="utypehidden" value='<s:property value="utypehidden"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="groupdatehidden" name="groupdatehidden" value='<s:property value="groupdatehidden"/>'/>
</div>
        <div id="jqxGroupSearch1"></div>
    </div>
</form>
<br/>

<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="groupSearch.jsp"></jsp:include>
	</div></div> --%>
		
</div>
</body>
</html>