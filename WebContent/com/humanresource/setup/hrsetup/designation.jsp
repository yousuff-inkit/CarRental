<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
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

<%@page import="com.humanresource.setup.hrsetup.designation.ClsDesignationDAO"%>
<% ClsDesignationDAO showDAO = new ClsDesignationDAO(); %>   

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Designation(DES)";
		document.getElementById("formdetail").value="Designation";
		document.getElementById("formdetailcode").value="DES";
		window.parent.formCode.value="DES";
		window.parent.formName.value="Designation";

		$("#desigdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
		var desigdata='<%=showDAO.searchDesignation()%>';

		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'designation', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	
                          	{name : 'remarks', type: 'String'  }
                 ],
               localdata: desigdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#designationgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Designation',columntype: 'textbox', filtertype: 'input', datafield: 'designation', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
           $('#designationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#designationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("designation").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "designation");
                $("#desigdate").jqxDateTimeInput('val', $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              
            });   
        });

	function funSearchLoad(){
		 changeContent('designationsearch.jsp'); 
	 }
 
 
	function funReadOnly() {
		$('#frmdesignation input').attr('readonly', true);
		$('#desigdate').jqxDateTimeInput({ disabled: true});
	}

	function funRemoveReadOnly() {
		$('#frmdesignation input').attr('readonly', false);
		$('#desigdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#desigdate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#desigdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	     function funNotify(){
	        	
	        	if(document.getElementById("designation").value=="") {
	        		document.getElementById("errormsg").innerText=" Enter Designation";
	        		document.getElementById("designation").focus();
	        		return 0;
	        	}
	        	
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#desigdate').jqxDateTimeInput('focus');
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
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
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
    font: 14px 'Segoe UI';
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
    font-size: 1.1rem;
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
    grid-template-columns: auto 1fr auto 2fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important;
    max-height: none !important;
    padding: 10px;
}
</style>

<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />
    <br/>

    <form id="frmdesignation" action="saveDesignation" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Designation Details</h2>
                
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="desigdate" name="desigdate" value='<s:property value="desigdate"/>'></div>
                    
                    <label>Designation</label>
                    <input type="text" name="designation" id="designation" placeholder="Enter Designation" value='<s:property value="designation"/>'>
                    
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
            
        </div>
    </form>

    <div class="section-block">
        <h2>View Designations</h2>
        <div id="designationgrid" style="width: 100%;"></div>
    </div>

</div>

</body>
</html>