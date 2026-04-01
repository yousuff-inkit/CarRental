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

<style>
/* =========================================================
SCOPED UI: Compact Input Sizing (Plain Colors)
*Note: All rules strictly scoped to .modern-ui so header.jsp is safe*
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 15px;
    box-sizing: border-box; 
}

/* Master Input Heights - Set to 24px */ 
.modern-ui input[type="text"], 
.modern-ui select, 
.modern-ui textarea {
    height: 24px !important; 
    border: 1px solid #ccc; 
    border-radius: 3px;
    padding: 2px 6px; 
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 220px !important; }
.modern-ui .input-xl { width: 350px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus, 
.modern-ui textarea:focus { 
    border-color: #007bff;
    outline: none;
}

.modern-ui input[readonly], 
.modern-ui textarea[readonly], 
.modern-ui select:disabled, 
.modern-ui input:disabled { 
    background-color: #f3f4f6;
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right; 
    color: #444; 
    font-size: 12px;
    font-weight: bold; 
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #e1e4e8; 
    padding: 20px 10px 10px 10px; 
    background: #fff;
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
}

.modern-ui .middle-panel-title { 
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

.modern-ui #jqxGarageSearch1 { 
    border-radius: 4px;
    border: 1px solid #d1d5db;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
    margin-top: 10px;
}

/* Validation Error override */
.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    margin-left: 5px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#accountWindow').jqxWindow('close');
    
    /* Upgraded to 24px height */
    $("#garagedate").jqxDateTimeInput({ width : '125px', height : '24px', formatString : "dd.MM.yyyy" });  
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "Arial, sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    document.getElementById("formdet").innerText="Garage(GRG)";
    document.getElementById("formdetail").value="Garage";
    document.getElementById("formdetailcode").value="GRG";
    window.parent.formCode.value="GRG";
    window.parent.formName.value="Garage";
    
    var data2= '<%=cgd.getGarage()%>';
    var num = 0; 
    var source = {
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
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            //alert(error);    
        }
    });

    $("#jqxGarageSearch1").jqxGrid({
        width: '100%',
        height: 310,
        source: dataAdapter,
        sortable: true,
        selectionmode: 'singlerow',
        theme: 'energyblue',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
            { text: 'Code', datafield: 'code', width: '50%',hidden:true },
            { text: 'Name',datafield:'name',width:'40%'},
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
    $('#accountWindow').jqxWindow('bringToFront');
    $.get(url).done(function (data) {
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
}
</script>

<script>
function getLocation() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
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
}

function funRemoveReadOnly(){
    $('#frmGarage input').attr('readonly', false );
    $('#frmGarage select').attr('disabled', false );
    $('#garagedate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
}

function funFocus(){
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
    });
});

function setValues(){
    $('#location').val($('#hidlocation').val()) ;
    $('#type').val($('#hidtype').val()) ;
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
<div class="homeContent" data-type="background">
    <form id="frmGarage" action="saveActionGarage" autocomplete="off">
        
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Garage Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Date</label>
                        <div style="width: 125px;">
                            <div id="garagedate" name="garagedate" value='<s:property value="garagedate"/>'></div>
                        </div>
                        
                        <div style="margin-left: auto; display: flex; align-items: center; gap: 8px; padding-right: 20px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" id="docno" class="input-sm" value='<s:property value="docno"/>' readonly tabindex="-1">
                        </div>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Code</label>
                        <input type="text" name="garagecode" id="garagecode" class="input-sm" value='<s:property value="garagecode"/>'>
                        
                        <label class="lbl-right" style="width: 60px; margin-left: 20px;">Name</label>
                        <input type="text" name="garagename" id="garagename" class="input-lg" value='<s:property value="garagename"/>'>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Type</label>
                        <select name="type" id="type" class="input-sm" value='<s:property value="type"/>'>
                            <option value="">--Select--</option>
                            <option value="E">External</option>
                            <option value="O">Own</option>
                        </select>
                        
                        <label class="lbl-right" style="width: 60px; margin-left: 20px;">Location</label>
                        <select name="location" id="location" class="input-md" value='<s:property value="location"/>'>
                            <option>----</option>
                        </select>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Account</label>
                        <input type="text" name="txtaccname" id="txtaccname" class="input-full" style="max-width: 400px;" value='<s:property value="txtaccname"/>' ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" readonly="readonly">
                        <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
                    </div>

                </div>
            </div>

            <div id="jqxGarageSearch1"></div>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>'>
            <input type="hidden" name="hidlocation" id="hidlocation" value='<s:property value="hidlocation"/>'>
            <input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
            <input type="hidden" name="hidgaragedate" id="hidgaragedate" value='<s:property value="hidgaragedate"/>'>
        </div>
    </form>

    <div id="accountWindow"><div></div><div></div></div>

</div>
</body>
</html>