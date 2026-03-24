<%@page import="com.controlcentre.masters.vehiclemaster.group.ClsGroupAction" %>
<% ClsGroupAction cga =new ClsGroupAction();%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Group Master</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (Adopted)
    ------------------------------ */
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
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
        /* Allow internal scrolling if content is too tall */
        max-height: calc(100vh - 64px); 
        overflow-y: auto; 
    }
    
    /* ------------------------------
       HEADER & TITLE FIXES
    ------------------------------ */
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM & SECTIONS
    ------------------------------ */
    .section-block {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px; 
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 30px;
    }
    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }


     .form-row {
        display: grid;
        grid-template-columns: 90px 125px 90px 90px 90px 120px 90px 100px ;
        gap: 15px 20px;
        align-items: center;
        margin-bottom: 12px;
    }
    
    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        transition: border-color 0.2s;
        font-size: 14px;
        box-sizing: border-box;
        width: 100%;
    }

    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
    }
    
    /* JQ Date Picker size fix */
    .jqx-datetimeinput-container {
         height: 32px;
    }
    #groupdate {
        height: 32px !important;
        width: 100% !important;
    }

    /* JQWigets/Grid Styling */
    #jqxGroupSearch1 {
        margin-top: 20px;
        width: 100% !important; 
    }
    .jqx-grid-cell {
        font-size: 13px !important;
    }

    /* ------------------------------
       UTILITY STYLES
    ------------------------------ */
    fieldset {
        border: none;
        padding: 0;
        margin: 0;
    }
    body::-webkit-scrollbar {
	width: 0px;
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
	     						{name : 'gid', type: 'String'  },
	                        	{name : 'gname', type: 'String'  },
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
	                    	width: '100%',
	                        height: 315,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        sortable: true,
	                        altrows:true,
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
<jsp:include page="../../../../header.jsp" />
    
    <div class="section-block">
        <h2>Group Details</h2>
        
        <div class="form-row">
            <label>Date</label>
            <div class="jqx-datetimeinput-container">
                <div id="groupdate" name="groupdate" value='<s:property value="groupdate"/>'></div>
            </div>
            
        
            <label>Group</label>
            <input type="text" name="group" id="group" required="required" value='<s:property value="group"/>'>
            
            <label>Name</label>
            <input type="text" name="name" value='<s:property value="name"/>' id="name">
            
             <label>Doc No</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>

        <div class="form-row" style="display: none;">
             <label>Level</label>
            <input type="text" name="level" id="level" value='<s:property value="level"/>' readonly tabindex="-1">
            
            <label>Utility Type</label>
             <select name="utype" id="utype" value='<s:property value="utype"/>'>
                <option value="">--Select--</option>
                <option value="ECONOMY">ECONOMY</option>
                <option value="LUXURY">LUXURY</option>
            </select>
        </div>


        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="utypehidden" name="utypehidden" value='<s:property value="utypehidden"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="groupdatehidden" name="groupdatehidden" value='<s:property value="groupdatehidden"/>'/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxGroupSearch1"></div>
</div>
		
</div>
</body>
</html>