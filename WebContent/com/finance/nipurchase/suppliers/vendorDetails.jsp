<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Full Page Width, Compact Inputs
* All rules are scoped inside .modern-ui to protect header.jsp *
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
.modern-ui input[type="email"],
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

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
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
    gap: 30px; /* Spacing between input groups */
    margin-bottom: 12px; 
    flex-wrap: nowrap;
}

.modern-ui .input-group {
    display: flex;
    align-items: center;
    gap: 8px; /* Spacing between label and input */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
}

.modern-ui .align-right-input { 
    text-align: right !important;
}

/* Middle Section Panels */
.modern-ui .modern-panel { 
    border: 1px solid #e1e4e8; 
    padding: 20px 15px 15px 15px; 
    background: #fff;
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    width: 100%; /* Panel takes full screen width */
}

.modern-ui .modern-panel-title { 
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

/* Validation Error override */
.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    margin-left: 5px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Upgraded height to 24px */
    $("#jqxVendorDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
  
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

    getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType();
});  
    
function getGroup() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var groupItems = items[0].split(",");
            var groupIdItems = items[1].split(",");
            var optionsgroup = '<option value="">--Select--</option>';
            for (var i = 0; i < groupItems.length; i++) {
                optionsgroup += '<option value="' + groupIdItems[i] + '">' + groupItems[i] + '</option>';
            }
            $("select#cmbaccgroup").html(optionsgroup);
            if ($('#hidcmbaccgroup').val() != null) {
                $('#cmbaccgroup').val($('#hidcmbaccgroup').val());
            }
        }
    }
    x.open("GET", "getGroup.jsp", true);
    x.send();
} 
    
function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var categoryItems = items[0].split(",");
            var categoryIdItems = items[1].split(",");
            var optionscategory = '<option value="">--Select--</option>';
            for (var i = 0; i < categoryItems.length; i++) {
                optionscategory += '<option value="' + categoryIdItems[i] + '">' + categoryItems[i] + '</option>';
            }
            $("select#cmbcategory").html(optionscategory);
            if ($('#hidcmbcategory').val() != null) {
                $('#cmbcategory').val($('#hidcmbcategory').val());
            }
        }
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}
    
function getType() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var typeItems = items[0].split(",");
            var typeIdItems = items[1].split(",");
            var optionstype = '';
            for (var i = 0; i < typeItems.length; i++) {
                optionstype += '<option value="' + typeIdItems[i] + '">' + typeItems[i] + '</option>';
            }
            $("select#cmbtype").html(optionstype);
            if ($('#hidcmbtype').val() != null) {
                $('#cmbtype').val($('#hidcmbtype').val());
            }
        }
    }
    x.open("GET", "getType.jsp", true);
    x.send();
}
    
function getTypeAllowed(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1) {
                $('#typeallowed').val(1);
                $('#wrapperType').css('display', 'flex');
                $('#wrapperTRN').css('display', 'flex');
                $('#cmbtype').attr('disabled', false);
                $('#txtregisteredtrnno').attr('readonly', false);
            } else {
                $('#typeallowed').val(0);
                $('#wrapperType').css('display', 'none');
                $('#wrapperTRN').css('display', 'none');
                $('#cmbtype').attr('disabled', true);
                $('#txtregisteredtrnno').attr('readonly', true);
            }
        }
    }
    x.open("GET", "getTypeAllowed.jsp", true);
    x.send();
}
    
function getCategoryAccountGroup(a) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#hidcmbaccgroup').val(items);
            if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
                $('#cmbaccgroup').val($('#hidcmbaccgroup').val());
            }
        }
    }
    x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
    x.send();
} 
      
function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var multiItems=items[2];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                multiItems.split(",");
               for ( var i = 0; i < currencycode.length; i++) {
                   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                 $("select#cmbcurrency").html(optionscurr);
                 if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                     $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                 } 
            } else {
               optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                 $("select#cmbcurrency").html(optionscurr);
                 if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                     $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                 }
            }
        }
     }
     x.open("GET", "getCurrencyId.jsp",true);
     x.send();
}
   
function getVendorAlreadyExists(vendorname,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                 document.getElementById("errormsg").innerText="Vendor Already Exists.";
                 return 0;
             }else{
                $('#cmbaccgroup').attr('disabled', false);
                $("#frmVendorDetails").submit();
             }
        }
    }
    x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
    
function getMobileNoAlreadyExists(mobileno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                 $.messager.alert('Message','Mobile No. Already Exists.','warning');
                 return 0;
             }
        }
    }
    x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
      
function funReadOnly(){
    $('#frmVendorDetails input').attr('readonly', true );
    $('#frmVendorDetails select').attr('disabled', true); 
    $('#jqxVendorDate').jqxDateTimeInput({disabled: true});
}
    
function funRemoveReadOnly(){
    getCurrencyIds();getTypeAllowed();
    $('#frmVendorDetails input').attr('readonly', false );
    $('#frmVendorDetails select').attr('disabled', false); 
    $('#jqxVendorDate').jqxDateTimeInput({disabled: false});
    $('#txtaccount').attr('readonly', true);
    $('#txtcode').attr('readonly', true);
    $('#cmbaccgroup').attr('disabled', true);
    $('#docno').attr('readonly', true);
    $('#cmbtype').val("1");       
    $('#hidcmbtype').val("1");      

    if ($("#mode").val() == "A") {
        $('#jqxVendorDate').val(new Date());
    }
}

function funNotify(){   
    if(parseInt($('#typeallowed').val())==1) {
        var taxtype=document.getElementById("cmbtype").value;
        if(taxtype.trim()==''){
            document.getElementById("errormsg").innerText="Type is Mandatory.";
            return 0;
        }
        if($('#cmbtype').find('option:selected').text()=='Registered'){
            var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
            if(registeredtrnno.trim()==''){
                document.getElementById("errormsg").innerText="TRN No. is Mandatory for Registered.";
                return 0;
            } 
        }
    }
    var account=document.getElementById("cmbaccgroup").value;
    if(account=="") {
        document.getElementById("errormsg").innerText=" Enter Account Group";
        document.getElementById("cmbaccgroup").focus();  
        return 0;
    }
    
    var vendorname=document.getElementById("txtvendorname").value;
    var docno=document.getElementById("docno").value;
    var mode=document.getElementById("mode").value;
    getVendorAlreadyExists(vendorname,docno,mode);
} 

function funSearchLoad(){
    changeContent('vndMainSearch.jsp'); 
}
    
function funFocus(){
    $('#jqxVendorDate').jqxDateTimeInput('focus');           
}
    
function setValues(){
    getCurrencyIds();
    if($('#hidjqxVendorDate').val()){
        $("#jqxVendorDate").jqxDateTimeInput('val', $('#hidjqxVendorDate').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
}
    
function funChkButton() {}
    
/* Validations */
$(function(){
    $('#frmVendorDetails').validate({
        rules: {
            txtvendorname:"required",
            cmbcurrency:"required",
            cmbcategory:"required",
            cmbaccgroup:"required",
        },
        messages: {
            txtvendorname:" *",
            cmbcurrency:" *",
            cmbcategory:" *",
            cmbaccgroup:" *",
        }
    });
});
    
function funExcelBtn(){
    var url=document.URL;
    var reurl=url.split("suppliers");
    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
}
</script>
</head>
<body onload="setValues();">

<div class="homeContent" data-type="background">
    <form id="frmVendorDetails" action="saveVendorDetails" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">

            <div class="modern-panel">
                <span class="modern-panel-title">Document Details</span>
                
                <div class="field-row">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Date</label>
                        <div style="width: 125px;">
                            <div id="jqxVendorDate" name="jqxVendorDate" value='<s:property value="jqxVendorDate"/>'></div>
                            <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate" value='<s:property value="hidjqxVendorDate"/>'/>
                        </div>
                    </div>
                    
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Code</label>
                        <input type="text" id="txtcode" name="txtcode" tabindex="-1" style="width: 150px;" value='<s:property value="txtcode"/>'/>
                    </div>
                    
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Name</label>
                        <input type="text" id="txtvendorname" name="txtvendorname" style="width: 300px;" value='<s:property value="txtvendorname"/>'/>
                    </div>
                    
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Doc No</label>
                        <input type="text" id="docno" name="txtvendordocno" tabindex="-1" style="width: 150px;" value='<s:property value="txtvendordocno"/>'/>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom: 0;">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Currency</label>
                        <select id="cmbcurrency" name="cmbcurrency" style="width: 125px;" value='<s:property value="cmbcurrency"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Category</label>
                        <select id="cmbcategory" name="cmbcategory" style="width: 150px;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                    </div>

                    <div class="input-group" id="wrapperType">
                        <label class="lbl-right" id="lbltypeentity" style="width: 60px;">Type</label>
                        <select id="cmbtype" name="cmbtype" style="width: 300px;" value='<s:property value="cmbtype"/>'></select>
                        <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                    </div>

                    <div class="input-group" id="wrapperTRN">
                        <label class="lbl-right" id="lbltrnnoentity" style="width: 60px;">TRN No.</label>
                        <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width: 150px;" value='<s:property value="txtregisteredtrnno"/>'/>
                    </div>
                </div>
            </div>

            <div class="modern-panel">
                <span class="modern-panel-title">Account Details</span>
                
                <div class="field-row" style="margin-bottom: 0;">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 90px;">Account Group</label>
                        <select id="cmbaccgroup" name="cmbaccgroup" style="width: 200px;" value='<s:property value="cmbaccgroup"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Account</label>
                        <input type="text" id="txtaccount" name="txtaccount" tabindex="-1" style="width: 150px;" value='<s:property value="txtaccount"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 140px;">Cr. Period - Min(Days)</label>
                        <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" class="align-right-input" style="width: 60px;" value='<s:property value="txtcredit_period_min"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 70px;">Max(Days)</label>
                        <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" class="align-right-input" style="width: 60px;" value='<s:property value="txtcredit_period_max"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 70px;">Credit Limit</label>
                        <input type="text" id="txtcredit_limit" name="txtcredit_limit" class="align-right-input" style="width: 100px;" value='<s:property value="txtcredit_limit"/>'/>
                    </div>
                </div>
            </div>

            <div class="modern-panel">
                <span class="modern-panel-title">Contact Details</span>
                
                <div class="field-row">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 90px;">Address</label>
                        <input type="text" id="txtaddress" name="txtaddress" style="width: 400px;" value='<s:property value="txtaddress"/>'/>
                    </div>
                    
                    <div class="input-group">
                        <label class="lbl-right" style="width: 80px;">Address 2</label>
                        <input type="text" id="txtaddress1" name="txtaddress1" style="width: 400px;" value='<s:property value="txtaddress1"/>'/>
                    </div>
                </div>

                <div class="field-row">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 90px;">Tel</label>
                        <input type="text" id="txttel" name="txttel" style="width: 150px;" value='<s:property value="txttel"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 80px;">Mob</label>
                        <input type="text" id="txtmob" name="txtmob" style="width: 150px;" onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtmob"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 80px;">Office No.</label>
                        <input type="text" id="txtoffice" name="txtoffice" style="width: 150px;" value='<s:property value="txtoffice"/>'/>
                    </div>
                </div>

                <div class="field-row">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 90px;">Fax</label>
                        <input type="text" id="txtfax" name="txtfax" style="width: 150px;" value='<s:property value="txtfax"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 80px;">Email</label>
                        <input type="email" id="txtemail" name="txtemail" style="width: 410px;" placeholder="someone@example.com" value='<s:property value="txtemail"/>'/>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom: 0;">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 90px;">Contact Person</label>
                        <input type="text" id="txtcontact" name="txtcontact" style="width: 400px;" value='<s:property value="txtcontact"/>'/>
                    </div>

                    <div class="input-group">
                        <label class="lbl-right" style="width: 80px;">Extn. No.</label>
                        <input type="text" id="txtextno" name="txtextno" style="width: 100px;" value='<s:property value="txtextno"/>'/>
                    </div>
                </div>

            </div>

            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
            <input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>'/>

        </div>
    </form>
</div>

</body>
</html>