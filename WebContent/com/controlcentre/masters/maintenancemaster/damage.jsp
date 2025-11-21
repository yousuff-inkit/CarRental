<%@page import="com.controlcentre.masters.maintenancemaster.damage.ClsDamageDAO" %>
<%ClsDamageDAO cdd=new ClsDamageDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
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
function funSearchLoad(){
	changeContent('damageSearch.jsp', $('#window')); 
 }
$(document).ready(function() {
	$("#damagedate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	
	document.getElementById("formdet").innerText="Damage(DAM)";
	document.getElementById("formdetail").value="Damage";
	document.getElementById("formdetailcode").value="DAM";
	window.parent.formCode.value="DAM";
	window.parent.formName.value="Damage";
    var data= '<%=cdd.getDamage()  %>';
 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'type', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'String'},
                          	{name : 'dmg_chg', type:'number'}
                 ],
                 localdata: data,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
       
            $("#jqxDamageSearch1").jqxGrid(
                    {
                    	width: '100%',
                    	height:358,
                        source: dataAdapter,
                        sortable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
									{ text: 'Doc No', datafield: 'doc_no', width: '15%' },
									{ text: 'Type', datafield: 'type', width: '25%' },
									{ text: 'Name', datafield: 'name', width: '60%' },
									{ text: 'Charge', datafield: 'dmg_chg', width: '30%' ,hidden:true},
									{text: 'Date',datafield:'date',width:'20%' ,hidden:true} 
        					]
                    });
  
            $('#jqxDamageSearch1').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("cmbtype").value=$('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "type");
                document.getElementById("name1").value=$('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
                //document.getElementById("dmgcharge").value=$('#jqxDamageSearch1').jqxGrid('getcellvalue', rowindex1, "dmg_chg");
                $("#damagedate").jqxDateTimeInput('val',$("#jqxDamageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));

});
});
  </script>

<script type="text/javascript">
function funReadOnly(){
	$('#frmDamage input').attr('readonly', true );
	$('#frmDamage select').attr('disabled', true );
	 $('#damagedate').jqxDateTimeInput({ disabled: true});
}
function funRemoveReadOnly(){
	$('#frmDamage input').attr('readonly', false );
	$('#frmDamage select').attr('disabled', false );
	$('#damagedate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function funFocus()
{
	document.getElementById("cmbtype").focus();
		
}
function setValues()
{
	if($('#hiddamagedate').val()){
		$("#damagedate").jqxDateTimeInput('val', $('#hiddamagedate').val());
	}
	if ($('#hidcmbtype').val() != null) {
		$('#cmbtype').val($('#hidcmbtype').val());
	}
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
function funNotify(){
	
		return 1;
} 
$(function(){
    $('#frmDamage').validate({
            	 rules: {
                     cmbtype: {
                    	 required:true
                     },
                    name1:{
                    	//required:true,
                    	maxlength:45
                    },
                    	
                    	dmgcharge:{
                    		required:true,
                    		number:true
                    	}
                    },
                     
                     messages: {
                      cmbtype:{
                    	  required:" *"
                      },
                      name1:{
                    	  //required:" *",
                    	  maxlength:"Max 45 chars"
                      },
                      dmgcharge:{
                    	required:" *",
                    	number:"Only numbers allowed"
                      }
                      }
    });});
</script>

</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmDamage" action="saveActionDamage" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>

    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;">
<h3>Damage Details</h3>

<table class="cr-table" width="100%" >
  <tr>
    <td width="8%">&nbsp;</td>
    <td colspan="5">&nbsp;</td>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="18%"><input type="text" name="docno" id="docno" readonly value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td><div align="right">Date</div></td>
    <td colspan="5"><div id="damagedate" name="damagedate" value='<s:property value="damagedate"/>'></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td width="14%" align="left"><select name="cmbtype" id="cmbtype" style="width:90%;"><option value="">--Select--</option><option value="EXT">EXT</option><option value="INT">INT
    </option><option value="OTH">OTH</option></select></td>
    <td width="7%" align="right">Name</td>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
    <td width="27%"><input type="text" name="name1" id="name1" value='<s:property value="name1"/>' style="width:70%;"></td>
<%--     <td width="7%" align="right">Dmg Charge</td>
    <td width="10%" align="left"><input type="text" name="dmgcharge" id="dmgcharge" value='<s:property value="dmgcharge"/>'></td> --%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</div><br/>
<div id="jqxDamageSearch1"></div>

<input type="hidden" id="hiddamagedate" name="hiddamagedate" value='<s:property value="hiddamagedate"/>'>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    </div>
</form>

</div>
</body>
</html>