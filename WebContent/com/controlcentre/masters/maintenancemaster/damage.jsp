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
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT
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
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
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
       GRID SYSTEM
    ------------------------------ */
    /* Header Grid: Date on left, Spacer, Doc No on right */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 150px 1fr auto 150px;
        gap: 15px;
        align-items: center;
        margin-bottom: 25px;
        padding: 0 5px;
    }

    .section-block {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 20px;
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
        grid-template-columns: 80px 150px 80px 1fr; /* Specific widths for Type/Name */
        gap: 15px;
        align-items: center;
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

    input[type="text"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
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
        font-size: 14px;
    }
    
    label.error {
        color: red;
        font-weight: bold;
        font-size: 12px;
        margin-left: 5px;
    }

    /* Grid Container Override */
    #jqxDamageSearch1 {
        border-radius: 8px;
        border: 1px solid #d1d5db;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        margin-top: 10px;
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
                        theme: 'energyblue',
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
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDamage" action="saveActionDamage" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

    <div class='receipt-header'>
        <label>Date</label>
        <div id="damagedate" name="damagedate" value='<s:property value="damagedate"/>'></div>
        
        <div></div>

        <label>Doc No</label>
        <input type="text" name="docno" id="docno" readonly value='<s:property value="docno"/>'>
    </div>

    <div class="section-block">
        <h2>Damage Details</h2>
        <div class="form-row">
            <label for="cmbtype">Type</label>
            <div>
                <select name="cmbtype" id="cmbtype">
                    <option value="">--Select--</option>
                    <option value="EXT">EXT</option>
                    <option value="INT">INT</option>
                    <option value="OTH">OTH</option>
                </select>
                <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
            </div>

            <label for="name1">Name</label>
            <input type="text" name="name1" id="name1" value='<s:property value="name1"/>'>
            
            <%-- Hidden charge field preserved from original --%>
            <%-- 
            <label>Dmg Charge</label>
            <input type="text" name="dmgcharge" id="dmgcharge" value='<s:property value="dmgcharge"/>'> 
            --%>
        </div>
    </div>

    <div id="jqxDamageSearch1"></div>

    <input type="hidden" id="hiddamagedate" name="hiddamagedate" value='<s:property value="hiddamagedate"/>'>
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
         
</form>

</div>
</body>
</html>