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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<style>
    /* --- GLOBAL LAYOUT --- */
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
        overflow-x: auto; 
    }

    /* --- BACKGROUND WIDTH FIX --- */
    #mainBG, .homeContent {
        width: 100%;
        min-width: 1250px !important; /* Prevents header buttons from wrapping */
        box-sizing: border-box;
        display: block;
    }

    #frmDamage {
        width: 98%;
        margin: 20px auto;
        padding: 0 15px;
        box-sizing: border-box;
    }

    /* --- BLUE HEADER CARD SECTION --- */
    .header-card-section {
        background: linear-gradient(to right, #dbeafe, #eff6ff); 
        border-radius: 16px;
        padding: 25px 30px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
        margin-bottom: 25px;
        border: 1px solid #bfdbfe;
    }

    .header-card-section h3 {
        color: #1e3a8a; 
        font-weight: 700;
        font-size: 1.5rem;
        margin-top: 0;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgba(59, 130, 246, 0.2);
    }

    /* --- HEADER TABLE LAYOUT --- */
    .header-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 15px; 
        table-layout: fixed; 
    }

    /* Labels */
    .header-table td.label-cell {
        text-align: right;
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; /* Fixed at 15px */
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 15px; 
    }

    /* Inputs */
    .header-table td.input-cell {
        vertical-align: middle;
        text-align: left;
    }

    /* --- PILL INPUT STYLING --- */
    .header-card-section input[type="text"],
    .header-card-section select,
    .header-card-section .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important;
        border-radius: 8px !important; 
        height: 38px !important;
        padding: 0 12px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 14px;
        font-weight: 500;
        width: 100% !important;
        box-sizing: border-box; 
    }

    /* Focus State */
    .header-card-section input[type="text"]:focus,
    .header-card-section select:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* --- GRID CARD SECTION --- */
    .grid-card-section {
        background: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 20px;
        border: 1px solid #e2e8f0;
    }

    /* JQX Override */
    .jqx-widget-content {
        border-radius: 8px !important;
        border-color: #94a3b8 !important;
    }
</style>

<script type="text/javascript">
function funSearchLoad(){
    changeContent('damageSearch.jsp', $('#window')); 
 }
$(document).ready(function() {
    // UPDATED DATE INPUT SIZE
    $("#damagedate").jqxDateTimeInput({
        width : '100%', 
        height : '38px', 
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
    
    <div class="header-card-section">
        <h3>Damage Details</h3>

        <table class="header-table">
            <colgroup>
                <col style="width: 10%;">  <col style="width: 22%;">  <col style="width: 10%;">  <col style="width: 22%;">  <col style="width: auto;"> </colgroup>

            <tr>
                <td class="label-cell">Date</td>
                <td class="input-cell">
                    <div id="damagedate" name="damagedate" value='<s:property value="damagedate"/>'></div>
                </td>
                
                <td class="label-cell">Doc No</td>
                <td class="input-cell">
                    <input type="text" name="docno" id="docno" readonly value='<s:property value="docno"/>'>
                </td>
                
                <td></td>
            </tr>
            
            <tr>
                <td class="label-cell">Type</td>
                <td class="input-cell">
                    <select name="cmbtype" id="cmbtype">
                        <option value="">--Select--</option>
                        <option value="EXT">EXT</option>
                        <option value="INT">INT</option>
                        <option value="OTH">OTH</option>
                    </select>
                    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
                </td>
                
                <td class="label-cell">Name</td>
                <td class="input-cell">
                    <input type="text" name="name1" id="name1" value='<s:property value="name1"/>'>
                </td>
                
                <td></td>
            </tr>
            
            <%-- Hidden Rows (kept commented as in original)
            <tr>
               <td class="label-cell">Dmg Charge</td>
               <td class="input-cell"><input type="text" name="dmgcharge" id="dmgcharge" value='<s:property value="dmgcharge"/>'></td> 
            </tr> 
            --%>
        </table>
    </div>

    <div class="grid-card-section">
        <div id="jqxDamageSearch1"></div>
    </div>

    <input type="hidden" id="hiddamagedate" name="hiddamagedate" value='<s:property value="hiddamagedate"/>'>
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</div>
</form>

</div>
</body>
</html>