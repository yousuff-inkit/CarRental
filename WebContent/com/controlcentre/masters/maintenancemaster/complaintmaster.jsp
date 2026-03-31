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
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }


#docno {
    width: 100px !important;
}


#compliant {
    width: 200px !important;
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
<fieldset>
  <legend>Compliant Details</legend>

  <div class="top-grid">

    <!-- Date -->
    <label>Date</label>
    <div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div>

    <!-- Empty spacing -->
    <div></div>
    <div></div>



    <!-- Name -->
    <label>Name</label>
    <input type="text" name="compliant" id="compliant"
           value='<s:property value="compliant"/>'>
           
               <!-- Doc No -->
    <label>Doc No</label>
    <input type="text" name="docno" readonly="readonly" id="docno"
           value='<s:property value="docno"/>'>

    <!-- Hidden -->
    <input type="hidden" name="compdatehidden" id="compdatehidden"
           value='<s:property value="compdatehidden"/>'>

  </div>

<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</fieldset>

			    <table width="100%">
                  <tr>
                    <td width="20%">&nbsp;</td>
                     
                    <td width="60%"><div id="maintearch10" style="position:relative;"></div>
</td>
                    <td width="20%">&nbsp;</td>
                  </tr>
                </table>
               
         
</form>



</div>
</body>
</html>