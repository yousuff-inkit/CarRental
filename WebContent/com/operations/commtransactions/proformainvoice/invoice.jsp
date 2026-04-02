<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>

<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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
.modern-ui select {
    height: 24px !important; 
    border: 1px solid #ccc; 
    border-radius: 3px;
    padding: 2px 6px; 
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
}

/* Textarea styling */
.modern-ui textarea {
    border: 1px solid #ccc; 
    border-radius: 3px;
    padding: 4px 6px; 
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    resize: none;
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

.modern-ui #invoiceDiv { 
    border-radius: 4px;
    border: 1px solid #d1d5db;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
    margin-top: 10px;
    background: #fff;
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
$(document).ready(function () { 

    $('#btnEdit').click(function(){
        $("#jqxManualInvoice").jqxGrid("addrow", null, {}); 
    });
    
    /* Upgraded height to 24px for Modern UI */
    $("#date").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"}); 
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
    
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
    
    $('#accountwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#accountwindow').jqxWindow('close');
    
    $('#agmtnowindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '57%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#agmtnowindow').jqxWindow('close');
    
    $('#date').on('change', function (event) {  
        var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
        if(docdateval==0){
            $('#date').jqxDateTimeInput('focus');
            return false;
        }
    });
    
    $('#agmtvoucherno').dblclick(function(){
        if(document.getElementById("mode").value!="A"){
             return false;
        }
        if(document.getElementById("cmbagmttype").value==''){
             document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
             return false;
        }
        document.getElementById("errormsg").innerText="";
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');
        agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
    });
});

function getAgmtno(event){
    if(document.getElementById("mode").value!="A"){
         return false;
    }
    if(document.getElementById("cmbagmttype").value==''){
         document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
         return false;
    }
    document.getElementById("errormsg").innerText="";
    var x= event.keyCode;
    if(x==114){
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');
        agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
    }
}

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountwindow').jqxWindow('setContent', data);
    }); 
}

function agmtnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#agmtnowindow').jqxWindow('setContent', data);
    }); 
}

function funReset(){}

function funReadOnly(){
    $('#frmProformaInvoice input').attr('readonly', true );
    $('#frmProformaInvoice select').attr('disabled', true);
    $('#frmProformaInvoice textarea').attr('readonly', true );
    $('#date').jqxDateTimeInput({ disabled: true});
    $("#fromdate").jqxDateTimeInput({ disabled: true});
    $("#todate").jqxDateTimeInput({ disabled: true});
}
    
function funRemoveReadOnly(){
    $('#Sendmail').hide();
    $('#frmProformaInvoice input').attr('readonly', false );
    $('#frmProformaInvoice select').attr('disabled', false);
    $('#frmProformaInvoice textarea').attr('readonly', false );
    $('#date').jqxDateTimeInput({ disabled: false});
    $("#fromdate").jqxDateTimeInput({ disabled: false});
    $("#todate").jqxDateTimeInput({ disabled: false});
    
    $('#docno').attr('readonly', true);
    $('#agmtno').prop('readonly', true);
    $('#client').prop('readonly', true);
    $('#clientdetails').prop('readonly', true);
    $('#driver').prop('readonly', true);
    $('#driverdetails').prop('readonly', true);
    $('#contractvehicle').prop('readonly', true);
    $('#vehicledetails').prop('readonly', true);
    
    if(document.getElementById("mode").value=='A'){
        $("#invoiceDiv").load("invoiceGrid.jsp");
        $('#fromdate').jqxDateTimeInput('setDate',new Date());
        $('#todate').jqxDateTimeInput('setDate',new Date());
        $('#date').jqxDateTimeInput('setDate',new Date());
    }
    
    if(document.getElementById("mode").value=="E"){
        $('#cmbagmttype').prop('disabled',true);
    }
    
    if($('#mode').val()=='A' || $('#mode').val()=='E'){
        var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
        if(docdateval==0){
            $('#date').jqxDateTimeInput('focus');
            return false;
        }
    }
}

function funNotify(){
    var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
    if(docdateval==0){
        $('#date').jqxDateTimeInput('focus');
        return 0;
    }
    
    if($('#fromdate').jqxDateTimeInput('getDate')==null){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Invoice From Date is Mandatory";
        return 0;
    }
    if($('#todate').jqxDateTimeInput('getDate')==null){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Invoice To Date is Mandatory";
        return 0;
    }

    var rows = $("#jqxManualInvoice").jqxGrid('getrows');
    var gridlength=0;
    
    if(rows[0].idno=="undefined" || rows[0].idno==null || rows[0].idno==""){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
        return 0;
    }
    
    if(rows[0].total=="undefined" || rows[0].total==null || rows[0].total==""){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
        return 0;
    }
    
    if(!((rows[0].idno=="undefined") && (rows[0].idno==null) && (rows[0].idno==""))){
        var j=0;
        for(var i=0 ; i < rows.length ; i++){
            if(rows[i].idno!="undefined" && rows[i].idno!=null && rows[i].idno!=""){    
                if(rows[i].total!="undefined" && rows[i].total!=null && rows[i].total!=""){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+j)
                    .attr("name", "test"+j)
                    .attr("hidden", "true");
                    
                    gridlength++;j++;
                    newTextBox.val(rows[i].idno+"::"+rows[i].account+"::"+rows[i].description+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].total);       
                    newTextBox.appendTo('form');
                }
            }
        }
        $('#gridlength').val(gridlength);
    }
    $('#cmbagmttype').prop('disabled',false);
    return 1;
 } 
 
function setValues(){
    if ($('#hidcmbagmttype').val() != null) {
        $('#cmbagmttype').val($('#hidcmbagmttype').val());
    }
    if(document.getElementById("docno").value>0){
        var docno1=document.getElementById("docno").value;
        document.getElementById("brchName").disabled=false;
        $("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1+"&branch="+document.getElementById("brchName").value);
        document.getElementById("brchName").disabled=true;
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
}

function funChkButton() {}

function funSearchLoad(){
    changeContent('invMainSearch.jsp', $('#window'));
}
        
function funFocus(){
    document.getElementById("cmbagmttype").focus();             
}

function funPrintBtn() {
    var url=document.URL;
    document.getElementById("brchName").disabled=false;
    
    if(document.getElementById("docno").value==""){
        if(document.getElementById("mode").value=="view"){
            var reurl=url.split("invoice.jsp");
            var win= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");       
        } else {
            var reurl=url.split("saveProformaInvoice");
            var win= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");       
        }
    } else {
        var reurl=url.split("saveProformaInvoice");
        var win_voucher= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");
        win_voucher.focus(); 
    } 
 }

function funSendmail() {
     if (($("#mode").val() == "view") && $("#docno").val()!="") {
        if(document.getElementById("email").value==""){
            document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
            return 0;
        }
        
        $("#overlay, #PleaseWait").show();
        sample();
        var recipient1=document.getElementById("email").value; 
        var recipient=recipient1.replace(/ /g, "%20");
     } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
     }
}

function sample() {  
    var formcode=document.getElementById("formdetailcode").value;
    var recep=document.getElementById("email").value.trim();
    var branch=<%=session.getAttribute("BRANCHID").toString()%>;
    
    $.ajaxFileUpload({  
        url: 'invjspToPdf.action?vocno='+document.getElementById("voucherno").value+'&docno='+document.getElementById("docno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
        secureuri:false,
        fileElementId:'file', 
        dataType: 'string',
        success: function (data, status) {  
            if(status=='success'){
                $("#overlay, #PleaseWait").hide();
                $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                });
            }
            if(status=='error'){
                $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                });
            }
            
            $("#testImg").attr("src",data.message);
            if(typeof(data.error) != 'undefined') {  
                if(data.error != '') {  
                    alert(data.error);  
                } else {  
                    alert(data.message);  
                }  
            }  
        },  
        error: function (data, status, e) {  
            alert(e);  
        }  
    }) 
    return false;
}
</script>  
</head>
<body onload="funReadOnly();setValues();">

<div class="homeContent" data-type="background">
    <form id="frmProformaInvoice" action="saveProformaInvoice" autocomplete="off">
        <script>
            window.parent.formName.value="Proforma Invoice";
            window.parent.formCode.value="PIV";
        </script>
        
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 100px;">Agreement Type</label>
                        <select name="cmbagmttype" id="cmbagmttype" class="input-md" value='<s:property value="cmbagmttype"/>'>
                            <option value="">--Select--</option>
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                        </select>
                        <input type="hidden" name="hidcmbagmttype" id="hidcmbagmttype" value='<s:property value="hidcmbagmttype"/>'>

                        <label class="lbl-right" style="width: 90px;">Agreement No</label>
                        <input type="text" name="agmtvoucherno" id="agmtvoucherno" class="input-lg" value='<s:property value="agmtvoucherno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">

                        <label class="lbl-right" style="width: 40px; margin-left: auto;">Date</label>
                        <div style="width: 125px;">
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                        </div>
                        <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>

                        <label class="lbl-right" style="width: 50px;">Doc No</label>
                        <input type="text" name="voucherno" id="voucherno" class="input-sm" value='<s:property value="voucherno"/>'>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 100px;">Client</label>
                        <input type="text" name="client" id="client" class="input-md" value='<s:property value="client"/>'>

                        <input type="text" name="clientdetails" id="clientdetails" class="input-lg" value='<s:property value="clientdetails"/>'>
                        
                        <input type="text" title="E-mail" name="email" id="email" class="input-lg" value='<s:property value="email"/>' placeholder="Email">

                        <label class="lbl-right" style="width: 100px; margin-left: auto;">Contract Vehicle</label>
                        <input type="text" name="contractvehicle" id="contractvehicle" class="input-lg" value='<s:property value="contractvehicle"/>'>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 100px;">Driver</label>
                        <input type="text" name="driver" id="driver" class="input-md" value='<s:property value="driver"/>'>

                        <input type="text" name="driverdetails" id="driverdetails" class="input-lg" value='<s:property value="driverdetails"/>'> 
                        
                        <label class="lbl-right" style="width: 100px; margin-left: auto;">Vehicle Details</label>
                        <textarea name="vehicledetails" id="vehicledetails" rows="2" style="width: 320px;"><s:property value="vehicledetails"/></textarea>
                    </div>

                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Invoice Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 100px;">Period From</label>
                        <div style="width: 125px;">
                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                        </div>
                        <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'>

                        <label class="lbl-right" style="width: 90px;">Ledger Note</label>
                        <input type="text" name="ledgernote" id="ledgernote" class="input-full" style="max-width: 250px;" value='<s:property value="ledgernote"/>'>

                        <label class="lbl-right" style="width: 80px; margin-left: auto;">Period To</label>
                        <div style="width: 125px;">
                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                        </div>
                        <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'>

                        <label class="lbl-right" style="width: 80px;">Invoice Note</label>
                        <input type="text" name="invoicenote" id="invoicenote" class="input-full" style="max-width: 250px;" value='<s:property value="invoicenote"/>'>
                    </div>

                </div>
            </div>

            <div id="invoiceDiv">
                <jsp:include page="invoiceGrid.jsp"></jsp:include>
            </div> 

            <input type="hidden" name="acno" id="acno" value='<s:property value="acno"/>'>
            <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
            <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
            <input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
            <input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">
            <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
            
        </div>
    </form>

    <div id="accountwindow"><div></div></div>
    <div id="agmtnowindow"><div></div></div>

</div>
</body>
</html>