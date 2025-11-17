<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>

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
	$("#miandate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
	    document.getElementById("formdet").innerText="Maintenance(MAT)";
		document.getElementById("formdetail").value="Maintenance";
		document.getElementById("formdetailcode").value="MAT";
		window.parent.formCode.value="MAT";
		window.parent.formName.value="Maintenance";
    var datas= '<%=cmd.mainserch() %>';
	             var num = 0; 
            var source =
            {                            
                datatype: "json",
                datafields: [  
                          	{name : 'docno' , type: 'number' },
     						{name : 'mtype', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'date'}
          
                 ],
                 localdata: datas,
                
                
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
            $("#maintearch1").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                sortable: true,    
                selectionmode: 'singlerow',
       

                columns: [
					{ text: 'Doc No', datafield: 'docno', width: '15%' },
					{ text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
					{ text: 'Description',datafield:'name',width:'50%' },
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true },
				
					]
            });
      

            $('#maintearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#maintearch1').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("maintenancetype").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "mtype");
                document.getElementById("desc").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "name");
               
                $("#miandate").jqxDateTimeInput('val',$("#maintearch1").jqxGrid('getcellvalue', rowindex1, "date"));
               
            }); 
            
});
  </script>

<script type="text/javascript">
function funReadOnly(){
	$('#frmmaint input').attr('readonly', true );
	 $('#miandate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
	$('#frmmaint input').attr('readonly', false );
	$('#miandate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("maintenancetype").focus();
		
}
function funSearchLoad(){
	changeContent('mainmasterSearch.jsp'); 
 }
function funNotify(){
	$('#miandate').jqxDateTimeInput({ disabled: false});
	return 1;
} 
$(function(){
    $('#frmmaint').validate({
            	 rules: {
            		 maintenancetype: {
                    	 required:true,
                    	 maxlength:20
                     },
                     desc:{
                    	required:true,
                    	maxlength:45
                    }
                   
                    },
                     
                     messages: {
                    	 maintenancetype:{
                    	  required:" * required",
                    	  maxlength:"  Max 20 chars"
                      },
                      desc:{
                    	 required:" *  required",
                    	  maxlength:"  Max 45 chars"
                      }
                   
                     
                      }
    });});
function setValues()
{
	if($('#miandatehidden').val()){
		$("#miandate").jqxDateTimeInput('val', $('#miandatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	}
</script>

</head>
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMain" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/>

    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;"><legend>Maintenance Details</legend>
<table class="cr-table" width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td> 
    <td colspan="3"><div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div></td>
    <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
   </td>
  </tr>                   
  <tr>
    <td><div align="right">Maintenance Type</div></td>
    <td width="30%"><input type="text" name="maintenancetype" id="maintenancetype" value='<s:property value="maintenancetype"/>'></td>
    <td width="11%" align="right"> Description </td>
    <td width="31%"><input type="text" name="desc" id="desc"  style="width:70%;" value='<s:property value="desc"/>'></td>
  
   
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</div>

			    <table class="cr-table" width="100%">
                  <tr>
                    <td width="10%">&nbsp;</td>
                     
                    <td width="78%"><div id="maintearch1" style="position:relative;"></div>
</td>
            <td width="10%">&nbsp;</td>
          </tr>
        </table>
    </div>
</form>



</div>
</body>
</html>