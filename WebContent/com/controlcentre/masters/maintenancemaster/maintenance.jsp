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
        min-width: 1250px !important; 
        box-sizing: border-box;
        display: block;
    }

    #frmmaint {
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
        font-size: 15px; /* Updated to 15px */
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
    .header-card-section input[type="text"]:focus {
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
$(document).ready(function() {
    $("#miandate").jqxDateTimeInput({
        width : '100%', 
        height : '38px', 
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
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMain" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/>

<div class='hidden-scrollbar receipt-header'>
    
    <div class="header-card-section">
        <h3>Maintenance Details</h3>
        <table class="header-table">
          <colgroup>
            <col style="width: 15%;">  <col style="width: 22%;">  
            <col style="width: 10%;"> 
            <col style="width: 22%;"> 
            <col style="width: auto;"> 
          </colgroup>

          <tr>
            <td class="label-cell">Date</td> 
            <td class="input-cell">
                <div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div>
                <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
            </td>
            
            <td class="label-cell">Doc No</td>
            <td class="input-cell">
              <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
            </td>
            
            <td></td>
          </tr>                    
          <tr>
            <td class="label-cell">Maintenance Type</td>
            <td class="input-cell">
                <input type="text" name="maintenancetype" id="maintenancetype" value='<s:property value="maintenancetype"/>'>
            </td>
            
            <td class="label-cell">Description</td>
            <td class="input-cell" colspan="2">
                <input type="text" name="desc" id="desc" value='<s:property value="desc"/>'>
            </td>
          </tr>
        </table>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          
    <div class="grid-card-section">
        <div id="maintearch1" style="position:relative;"></div>
    </div>

</div>
</form>

</div>
</body>
</html>