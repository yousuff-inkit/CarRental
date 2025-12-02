<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

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

    #frmGarage {
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

    /* Labels - RIGHT ALIGNED & BIGGER */
    .header-table td.label-cell {
        text-align: right; /* Aligns text to the right (next to input) */
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; /* Increased Size */
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 15px; /* Comfortable gap between label and input */
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

$(document).ready(function() {
    $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#accountWindow').jqxWindow('close');
    
    $("#garagedate").jqxDateTimeInput({ width : '100%', height : '38px', formatString : "dd.MM.yyyy" });  

     document.getElementById("formdet").innerText="Garage(GRG)";
        document.getElementById("formdetail").value="Garage";
        document.getElementById("formdetailcode").value="GRG";
        window.parent.formCode.value="GRG";
        window.parent.formName.value="Garage";
    var data2= '<%=cgd.getGarage()%>';

            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no' , type: 'number'},
                        {name : 'code', type: 'String'},
                            {name : 'name', type: 'String'},
                            {name : 'date',type:'date'},
                            {name : 'type', type:'String'},
                            {name : 'branch', type:'String'},
                            {name : 'location', type:'String'},
                            {name : 'acc_no', type:'number'},
                            {name : 'description', type:'String'}
                 ],
                 localdata: data2,
                 
                
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
                     {
                        loadError: function (xhr, status, error) {
                     //alert(error);    
                     }
                    }        
            );
            $("#jqxGarageSearch1").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                //Add row method
                columns: [
                    { text: 'Doc No', datafield: 'doc_no', width: '10%' },
                    { text: 'Code', datafield: 'code', width: '50%',hidden:true },
                    {text: 'Name',datafield:'name',width:'40%'},
                    { text: 'Branch', datafield: 'branch', width: '20%' ,hidden:true},
                    { text: 'Location', datafield: 'location', width: '20%' ,hidden:true},
                    { text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
                    { text: 'Acc No', datafield: 'acc_no', width: '20%' ,hidden:true},
                    { text: 'Type', datafield: 'type', width: '20%' ,hidden:true},
                    { text: 'Description', datafield: 'description', width:'30%'}
                    ]
            });

            $('#jqxGarageSearch1').on('rowselect', function (event) {
                
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("garagecode").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("garagename").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "name");
                $('#location').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "location")) ;
                $('#type').val($("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("txtaccname").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#jqxGarageSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
                $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                
            }); 
       
});
function accountSearchContent(url) {
      $('#accountWindow').jqxWindow('open');
         $.get(url).done(function (data) {
            // alert(data);
        $('#accountWindow').jqxWindow('setContent', data);
    }); 
    }
function funSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    var dtype = "GRG";
    accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);    
}
function funSearchLoad(){
    changeContent('garageSearch.jsp', $('#window')); 
 }
function getAcc(event){
    
   var x= event.keyCode;
   if(x==114){
       var url=document.URL;
        var reurl=url.split("com/");
        var dtype = "GRG";
        accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
   }
   else{
    }
   }
  </script>

<script>

function getLocation()
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
            
                items=items.split('***');
         var locItems=items[0].split(",");
         var locnoItems=items[1].split(",");
             var optionsloc = '<option value="">--Select--</option>';
        for ( var i = 0; i < locItems.length; i++) {
             optionsloc += '<option value="' + locnoItems[i] + '">' + locItems[i] + '</option>';
         }
        $("select#location").html(optionsloc);
        
        $('#location').val($('#hidlocation').val()) ;
        //$('#type').val($('#hidtype').val()) ;

            }
        else
            {
            }
    }
    x.open("GET","getLocation.jsp",true);
    x.send();
    }
</script>
<script type="text/javascript">
function funReadOnly(){
    $('#frmGarage input').attr('readonly', true );
    $('#frmGarage select').attr('disabled', true );
     $('#garagedate').jqxDateTimeInput({ disabled: true});
    //getLocation();
}
function funRemoveReadOnly(){
    $('#frmGarage input').attr('readonly', false );
    $('#frmGarage select').attr('disabled', false );
     $('#garagedate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
}
function funFocus()
{
    document.getElementById("garagecode").focus();
        
}
function funNotify(){
    
    return 1;
} 
$(function(){
    $('#frmGarage').validate({
                 rules: {
                      garagecode: {
                         required:true,
                         maxlength:2
                      },
                     garagename:{
                        required:true,
                        maxlength:25
                     }       
                     },
                      
                      messages: {
                         garagecode:{
                          required:" *",
                          maxlength:"Max 2 chars"
                       },
                       garagename:{
                         required:" *",
                          maxlength:"Max 25 chars"
                       }
                      
                       }
    });});
function setValues()
{
    $('#location').val($('#hidlocation').val()) ;
    $('#type').val($('#hidtype').val()) ;
    //$('#accno').val($('#hidaccno').val()) ;
    if($('#garagedatehidden').val()){
        $("#garagedate").jqxDateTimeInput('val', $('#garagedatehidden').val());
    }
    if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }

    }
</script>
</head>
<body onLoad="getLocation();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmGarage" action="saveActionGarage" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
    <div class='hidden-scrollbar receipt-header'>
    
    <div class="header-card-section">
        <h3>Garage Details</h3>
        
        <table class="header-table">
            <colgroup>
                <col style="width: 15%;">  <col style="width: 22%;">  <col style="width: 10%;">  <col style="width: 22%;">  <col style="width: auto;"> </colgroup>

            <tr>
                <td class="label-cell">Date</td>
                <td class="input-cell">
                    <div id="garagedate" name="garagedate" value='<s:property value="garagedate"/>'></div>
                </td>
                
                <td class="label-cell">Doc No</td>
                <td class="input-cell">
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
                </td>
                
                <td></td>
            </tr>
            
            <tr>
                <td class="label-cell">Code</td>
                <td class="input-cell">
                    <input type="text" name="garagecode" id="garagecode" value='<s:property value="garagecode"/>'>
                </td>
                
                <td class="label-cell">Name</td>
                <td class="input-cell">
                    <input type="text" name="garagename" id="garagename" value='<s:property value="garagename"/>' >
                </td>
                
                <td></td>
            </tr>
            
            <tr>
                <td class="label-cell">Type</td>
                <td class="input-cell">
                    <select name="type" id="type" value='<s:property value="type"/>'>
                        <option value="">--Select--</option>
                        <option value="E">External</option>
                        <option value="O">Own</option>
                    </select>
                </td>
                
                <td class="label-cell">Location</td>
                <td class="input-cell">
                    <select name="location" id="location" value='<s:property value="location"/>'>
                        <option>----</option>
                    </select>
                </td>
                
                <td></td>
            </tr>
            
            <tr>
                <td class="label-cell">Account</td>
                <td class="input-cell" colspan="3">
                    <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' 
                           ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" 
                           placeholder="Press F3 to Search" readonly="readonly">
                </td>
                <td></td>
            </tr>
        </table>
        
        <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
    </div>

     <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>'>
    <input type="hidden" name="hidlocation" id="hidlocation" value='<s:property value="hidlocation"/>'>
    <input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
    <input type="hidden" name="hidgaragedate" id="hidgaragedate" value='<s:property value="hidgaragedate"/>'>

        <div class="grid-card-section">
            <div id="jqxGarageSearch1"></div>
        </div>
        
        <div id="accountWindow">
            <div></div><div></div>
        </div>
    </div>
</form>


  </div>
</body>
</html>