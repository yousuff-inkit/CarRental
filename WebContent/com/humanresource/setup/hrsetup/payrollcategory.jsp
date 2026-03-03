<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
  color:red;
  font-weight:bold;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO();%> 

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Payroll Category(PCT)";
		document.getElementById("formdetail").value="Payroll Category";
		document.getElementById("formdetailcode").value="PCT";
		window.parent.formCode.value="PCT";
		window.parent.formName.value="Payroll Category";
	    
		$("#parrolldate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
 
		var catdata='<%=showDAO.searchcategory()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'category', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'timesheet', type: 'Int'  },
                 ],
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#categorygrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
		        					{ text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%',hidden:true },
        	              ]
                    });

            $('#categorygrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                document.getElementById("docno").value= $('#categorygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "category");
                $("#parrolldate").jqxDateTimeInput('val', $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                
                $('#timesheet').attr('disabled', false);
                
                var timesheet=$("#categorygrid").jqxGrid('getcellvalue', rowindex1, "timesheet");
	            if(parseInt(timesheet)==1) {
	            	 document.getElementById("timesheet").checked = true;
	       		     document.getElementById("timesheet").value=1;
	            	} else {
	           	     document.getElementById("timesheet").checked = false;
	       		     document.getElementById("timesheet").value=0;
	            	}
	            
	            if ($("#mode").val() == "view") {
	            	$('#timesheet').attr('disabled', true);
	            }

	            /// parrolldate category
            });  
        });

	function funSearchLoad(){
		 changeContent('payrollcategorysearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', true);
		$('#timesheet').attr('disabled', true);
		$('#parrolldate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', false);
		$('#timesheet').attr('disabled', false);
		$('#parrolldate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#parrolldate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#parrolldate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		var hidtimesheet=$('#hidtimesheet').val();
		if(parseInt(hidtimesheet)==1) {
       	 	document.getElementById("timesheet").checked = true;
  		    document.getElementById("timesheet").value=1;
       	} else {
      	    document.getElementById("timesheet").checked = false;
  		    document.getElementById("timesheet").value=0;
       	}
	}
 
	     function funNotify(){
	        	if(document.getElementById("category").value=="") {
        			document.getElementById("errormsg").innerText=" Enter Category";
        			document.getElementById("category").focus();
        			return 0;
        		}
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#parrolldate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

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

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

form label.error {
    color: red;
    font-weight: bold;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 17.4px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 2fr auto auto auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

/* Fixed Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: 550px;
    padding: 10px;
}
</style>

<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" /><br/>

    <form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Payroll Category Details</h2>
                
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'></div>
                    
                    <label>Category</label>
                    <input type="text" name="category" id="category" placeholder="Category" value='<s:property value="category"/>'>
                    
                    <div style="display: flex; align-items: center; gap: 8px; margin-left: 10px;">
                        <input type="checkbox" id="timesheet" name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        <label for="timesheet">Time Sheet</label>
                    </div>

                    <label>Doc No</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                </div>

                <div class="agmt-info-grid" style="margin-top: 15px;">
                    <label>Remarks</label>
                    <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>'>
                </div>
            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 

            <div class="section-block">
                <h2>Category List</h2>
                <div id="categorygrid" style="width: 100%;"></div>
            </div>
            
        </div>
    </form>
</div>

</body>
</html>