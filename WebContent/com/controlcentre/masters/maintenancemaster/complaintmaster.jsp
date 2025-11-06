<%@page import="com.controlcentre.masters.maintenancemaster.complaint.ClsComplaintDAO" %>
<%ClsComplaintDAO ccd=new ClsComplaintDAO(); %>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <s:head/>
 <% String contextPath=request.getContextPath();%>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	$("#compdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
		document.getElementById("formdet").innerText="Complaint(CMT)";
		document.getElementById("formdetail").value="Complaint";
		document.getElementById("formdetailcode").value="CMT";
		window.parent.formCode.value="CMT";
window.parent.formName.value="Complaint";
    var comdata= '<%=ccd.mainserch() %>';
	             var num = 0; 
            var source =
            {                            
                datatype: "json",
                datafields: [  
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'compname', type: 'String'  },
                        	{name : 'date', type: 'date'  }
          
                 ],
                 localdata: comdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#maintearch10").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: ' Name', datafield: 'compname', width: '80%' },
					{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
					
					]
            });
      

            $('#maintearch10').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#maintearch10').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("compliant").value=$('#maintearch10').jqxGrid('getcellvalue', rowindex1, "compname");
                $("#compdate").jqxDateTimeInput('val',$("#maintearch10").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
            
});
  </script>

<script type="text/javascript">

function funReadOnly(){
	$('#frmcomplaint input').attr('readonly', true );
	 $('#compdate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
	$('#frmcomplaint input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		 $('#compdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("compliant").focus();
		
}
function funSearchLoad(){
	changeContent('complaintmastersearch.jsp'); 
 }
function funNotify(){
	 $('#compdate').jqxDateTimeInput({ disabled: false}); 	
	return 1;
} 

    
    $(function(){
        $('#frmcomplaint').validate({
                	 rules: {
                	
                         compliant:{
                        	required:true,
                        	maxlength:50
                        }
                       
                        },
                         
                         messages: {
                        	 
                        	 compliant:{
                        	 required:"  *   required",
                        	  maxlength:"   Max 50 chars"
                          }
                       
                         
                          }
        });});
    
function setValues()
{
	if($('#compdatehidden').val()){
		$("#compdate").jqxDateTimeInput('val', $('#compdatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
</script>

</head>
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmcomplaint" action="saveComplaint" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/>
    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;"><h3>Compliant Details</h3>
<table class="cr-table" width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td> 
    <td colspan="3"><div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div></td>
    <input type="hidden" name="compdatehidden" id="compdatehidden" value='<s:property value="compdatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
   </td>
  </tr>                   
  <tr>
    <td><div align="right">Name</div></td>
    <td width="50%"><input type="text" name="compliant" style="width:50%;" id="compliant" value='<s:property value="compliant"/>'></td>
    
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</div>

			    <table class="cr-table" width="100%">
                  <tr>
                    <td width="20%">&nbsp;</td>
                     
                    <td width="60%"><div id="maintearch10" style="position:relative;"></div>
</td>
                    <td width="20%">&nbsp;</td>
                  </tr>
                </table>
               
    </div>
</form>



</div>
</body>
</html>