<%@page import="com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeAction" %>
<%ClsPlateCodeAction cpa=new ClsPlateCodeAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Plate Code Master</title>
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

    .form-grid {
        display: grid;
        grid-template-columns: 100px 125px 100px 100px 1fr ;
        gap: 0px 30px;
        align-items: center;

    }
        .form-grid_new {
        display: grid;
        grid-template-columns: 100px 125px 90px 120px 90px 120px ;
        gap: 1px 30px;
        align-items: center;
        margin-bottom: 12px;
       
    }
    
    
    #nAliasgrid {
        grid-row: 1 / 4; 
        grid-column: 5/ 6;
        min-height: 100px; 
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
    #date_plateCode {
        height: 32px !important;
        width: 100% !important;
    }

    #jqxPlateCodeSearch1 {
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
var data= '<%=cpa.searchDetails() %>';

	$(document).ready(function() {
		$("#date_plateCode").jqxDateTimeInput({ width : '100%', height : '32px', formatString : "dd.MM.yyyy" });
	//	 $("#btnEdit").attr('disabled', true );		
		document.getElementById("formdet").innerText="Plate Code(PLT)";
		document.getElementById("formdetail").value="Plate Code";
		document.getElementById("formdetailcode").value="PLT";
		window.parent.formCode.value="PLT";
		window.parent.formName.value="Plate Code";
		getAuth();
		var data= '<%=cpa.searchDetails() %>'; 
	
	            
	            
	             var num = 0; 
	            var source =
	            {
	                datatype: "json",
	                datafields: [
								{name : 'doc_no' , type: 'number' },
	                          	{name : 'code_no' , type: 'String' },
	     						{name : 'code_name', type: 'String'  },
	                          	{name : 'authname', type: 'String'  },
	                          	{name : 'authId', type: 'String'  },
	                          	{name : 'plateDate', type: 'date'  }
	                          	
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
	         
	            $("#jqxPlateCodeSearch1").jqxGrid(
	                    {
	                    	width: '100%',
	                        height: 350,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'singlerow',
	                        sortable: true,
	                        altrows:true,
	                        columns: [
	                                  {text: 'Doc No',datafield:'doc_no',hidden:true},
	        					{ text: 'Plate Code', datafield: 'code_no', width: '30%' },
								{ text: 'Plate Name', datafield: 'code_name', width: '40%' },
								{ text: 'Authority Name', datafield: 'authname', width: '30%' },
								{ text: 'Authority Id', datafield: 'authId', width: '30%',hidden:true },
								{ text: 'Date', datafield: 'plateDate', width: '30%',hidden:true,cellsformat:'dd.MM.yyyy' }
								]
	                    });
	            $('#jqxPlateCodeSearch1').on('rowdoubleclick', function (event) 
	            		{
			            	var rowindex1=event.args.rowindex;
			            	$('#date_plateCode').jqxDateTimeInput({ disabled: false});
			        		
			            	document.getElementById("docno").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
			                document.getElementById("plateCode").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "code_no"); 
			                document.getElementById("platename").value = $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "code_name");
			                $('#authName').val($("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "authId")) ;
			                $("#date_plateCode").jqxDateTimeInput('val', $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "plateDate")); 
			        		$('#frmPlateCode select').attr('disabled', true);
			            	$('#date_plateCode').jqxDateTimeInput({ disabled: true});
			            	
			            	document.getElementById("authorityname").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "authname");
			            	
			            	var auth12=$('#jqxPlateCodeSearch1').jqxGrid('getcelltext', rowindex1, "authname");
			            	auth=auth12.replace(/ /g, "%20");
			            	 $("#nAliasgrid").load("nAliasgrid.jsp?itemno="+document.getElementById("docno").value);

			                $('#window').jqxWindow('close');
	            		 }); 
	
	});
	  function funSearchLoad(){
			changeContent('plateCodeSearch.jsp', $('#window')); 
		 }
	function funReadOnly() {
		$('#frmPlateCode input').attr('readonly', true);
		$('#frmPlateCode select').attr('disabled', true);
		 $('#date_plateCode').jqxDateTimeInput({ disabled: true}); 

	}
	function funRemoveReadOnly() {
		$('#frmPlateCode input').attr('readonly', false);
		 $('#date_plateCode').jqxDateTimeInput({ disabled: false}); 

		$('#frmPlateCode select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		
		if(document.getElementById("mode").value=='E'){
		$("#jqxnalias").jqxGrid({ disabled: false});
		 $('#jqxnalias').jqxGrid('addrow', null, {});
		}
	}
	
	function getAuth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var authItems = items[0].split(",");
				var authIdItems = items[1].split(",");
				var optionsauth = '<option value="">--Select--</option>';
				for (var i = 0; i < authItems.length; i++) {
					optionsauth += '<option value="' + authIdItems[i] + '">'
							+ authItems[i] + '</option>';
				}
				$("select#authName").html(optionsauth);
				if ($('#authId').val() != null) {
					$('#authName').val($('#authId').val());

				}

			} else {
			}
		}
		x.open("GET", "getAuthority.jsp", true);
		x.send();
	}
	function setValues() {
		
		 if($('#datehidden').val()){
				$("#date_plateCode").jqxDateTimeInput('val', $('#datehidden').val());
			}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 $("#nAliasgrid").load("nAliasgrid.jsp?itemno="+document.getElementById("docno").value);
	}
	function funFocus(){
		
		document.getElementById("authName").focus();
		
	}
	 $(function(){
	        $('#frmPlateCode').validate({
	                 rules: {
	                 authName:{
	                	 required:true
	                 },
	                 plateCode:{
	                	 required:true,
	                	 maxlength:10
	                 }
	                 },
	                 messages: {
	                  authName:{
	                	  required:" *"
	                  },
	                  plateCode:{
	                	  required:" *",
	                	  maxlength:"max 10 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	 var rows = $("#jqxnalias").jqxGrid('getrows'); 
	     	    var listss = new Array();
	    	 	var a = 1;
	    	   for(var i=0 ; i < rows.length ; i++){
	    		   var code=rows[i].code;
	    			if(code!="undefined" && code!=null && typeof(code)!="undefined" ){
	        	    	
	    		   listss.push(rows[i].code+"::"+rows[i].doc_no+"::"+a+"::");  
	    			}
	    	   }
	    	savenalias(listss);
	    		return 1;
		} 
	     function funExcelBtn(){
			  $("#jqxPlateCodeSearch1").jqxGrid('exportdata', 'xls', 'Platecode');
		  }
	     
	     function savenalias(listss)
	     {
	     	
	     	    var codeno=document.getElementById("plateCode").value;
	       	     var authname=$("#authName option:selected").text();
	         	   var docno=document.getElementById("docno").value;
	         		   	var x=new XMLHttpRequest();
	         		x.onreadystatechange=function(){
	         			if (x.readyState==4 && x.status==200)
	         				{
	         				 var itemsapprove= x.responseText;
	         				 	var itemvalappr=itemsapprove.trim();
	         					 	
	         	  if(parseInt(itemvalappr)==1)
	         	  	{
	    				}
	         			else
	         				{
	         			
	         				}  
	         		}
	         		}
	         		 
	         	x.open("GET","saveNAlias.jsp?list="+listss+"&docno="+docno+"&authname="+authname+"&codeno="+codeno);
	         		x.send();
	     	
	     	
	     	}  
	     
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmPlateCode" action="saveActionPlate"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	
    <div class="section-block">
        <h2>Plate Code Details</h2>
        
        <div class="form-grid">
            <label>Date</label>
            <div class="jqx-datetimeinput-container">
                <div id="date_plateCode" name="date_plateCode" value='<s:property value="date_plateCode"/>'></div>
            </div>
			<div id="nAliasgrid" class="n-alias-grid-container"><jsp:include page="nAliasgrid.jsp"></jsp:include></div>
            <label>Doc No</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly="readonly">
            </div>
	<div class="form-grid_new">
            <label>Authority</label>
            <select name="authName" id="authName" >
                <option value="">--Select--</option>
            </select>
            
            <label>Plate Code</label>
            <input type="text" id="plateCode" name="plateCode" value='<s:property value="plateCode"/>'>
            
            <label>Name</label>
            <input type="text" name="platename" id="platename" value='<s:property value="platename"/>'>
        </div>

        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="authId" name="authId" value='<s:property value="authId"/>' />
        <input type="hidden" id="authorityname" name="authorityname" value='<s:property value="authorityname"/>' />
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxPlateCodeSearch1"></div>
</div>

</div>
</body>
</html>