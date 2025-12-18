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
        grid-template-columns: 140px 1fr 140px 1fr;
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
    #maintearch1 {
        border-radius: 8px;
        border: 1px solid #d1d5db;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
                      //   alert(error);    
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
                theme: 'energyblue', /* Added Theme */

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
                         required:" * required",
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
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMain" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" />

    <div class='receipt-header'>
        <label>Date</label>
        <div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div>
        
        <div></div>

        <label>Doc No</label>
        <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
    </div>

    <div class="section-block">
        <h2>Maintenance Details</h2>
        <div class="form-row">
            <label for="maintenancetype">Maintenance Type</label>
            <input type="text" name="maintenancetype" id="maintenancetype" value='<s:property value="maintenancetype"/>'>

            <label for="desc">Description</label>
            <input type="text" name="desc" id="desc" value='<s:property value="desc"/>'>
        </div>
    </div>

    <div id="maintearch1" style="position:relative;"></div>

    <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
    <input type="hidden" id="mode" name="mode"/>
    <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
</form>

</div>
</body>
</html>