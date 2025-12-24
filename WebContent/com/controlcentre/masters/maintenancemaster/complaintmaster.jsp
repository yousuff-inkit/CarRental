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
        grid-template-columns: 80px 1fr;
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
    #maintearch10 {
        border-radius: 8px;
        border: 1px solid #d1d5db;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
                      //   alert(error);    
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
                theme: 'energyblue',

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
                             required:"  * required",
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
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmcomplaint" action="saveComplaint" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" />

    <div class='receipt-header'>
        <label>Date</label>
        <div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div>
        
        <div></div>

        <label>Doc No</label>
        <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
    </div>

    <div class="section-block">
        <h2>Complaint Details</h2>
        <div class="form-row">
            <label for="compliant">Name</label>
            <input type="text" name="compliant" id="compliant" value='<s:property value="compliant"/>'>
        </div>
    </div>

    <div id="maintearch10" style="position:relative;"></div>

    <input type="hidden" name="compdatehidden" id="compdatehidden" value='<s:property value="compdatehidden"/>'>
    <input type="hidden" id="mode" name="mode"/>
    <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                  
</form>

</div>
</body>
</html>