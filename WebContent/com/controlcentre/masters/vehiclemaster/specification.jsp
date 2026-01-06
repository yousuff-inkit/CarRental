<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
    max-width: 100%; /* Matches Master UI requirement */
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
    COMMON UI ELEMENTS
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

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px Segoe UI;
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
}

/* ------------------------------
    CARD ROWS LAYOUT
------------------------------ */
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
    border-left: 4px solid #007bff; /* Blue vertical line from Master UI */
    display: flex;
    align-items: center;
    gap: 10px;
}

/* Grid for the Specification Info */
.spec-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 25px;
    align-items: center;
}

.details-full-row {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 12px 25px;
    align-items: center;
    margin-top: 12px;
}

.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding: 10px; 
}

/* ------------------------------
    TABLES & DYNAMIC GRIDS (Preserved)
------------------------------ */
.grid-container-table {
    width: 100%;
    margin-top: 10px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	document.getElementById("formdet").innerText="Specification(SPC)";
	document.getElementById("formdetail").value="Specification";
	document.getElementById("formdetailcode").value="SPC";
	window.parent.formCode.value="SPC";
	window.parent.formName.value="Specification";
	
});

function funNotify(){
	return 1;
}
function funReadOnly(){
	$('#frmSpecification input').attr('readonly', true );
}
function funRemoveReadOnly(){
	$('#frmSpecification input').attr('readonly', false );

}
function funSearchLoad(){
	changeContent('specificationSearch.jsp', $('#window')); 
 }
function chkButton(){
	
}
function funFocus(){
	document.getElementById("specname").focus();
}
function setValues(){
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}
function funExcelBtn(){
				  $("#specGrid").jqxGrid('exportdata', 'xls', 'Specifications');
			  }
	</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmSpecification" action="saveSpecification" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Specification Info</h2>
                
                <div class="spec-info-grid">
                    <label>Name</label>
                    <input type="text" name="specname" id="specname" value='<s:property value="specname"/>' placeholder="Spec Name" />
                    
                    <label>Doc No</label> 
                    <input type="text" name="docno" tabindex="-1" readonly id="docno" value='<s:property value="docno"/>'/>
                </div>

                <div class="details-full-row">
                    <label>Details</label>
                    <input type="text" name="specdetails" id="specdetails" value='<s:property value="specdetails"/>' placeholder="Spec Details"/>
                </div>
            </div>

            <div class="grid-container-table">
                <table width="100%">
                    <tr>
                        <td><jsp:include page="specGrid.jsp"></jsp:include></td>
                    </tr>
                </table>
            </div>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            
        </div>
    </form>
</div>

</body>
</html>