<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<s:head/>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Client Master Style (Compact, Fixed Widths, Aligned)
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
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    min-width: 0;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Row Layouts */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    flex-wrap: nowrap;
}

.modern-ui .input-group {
    display: flex;
    align-items: center;
    gap: 8px;
    min-width: 0;
}

/* Labels */
.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0;
}

/* Exact Panel Styling from Client Master */
.modern-ui .bordered-panel { 
    border: 1px solid #c5d3e0; 
    padding: 20px 15px 15px 15px; 
    background: #fff; 
    border-radius: 4px; 
    margin-bottom: 15px;
    position: relative;
}

.modern-ui .highlight-panel {
    background: #f4f7fb; /* Light blueish background */
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

/* Radio Button Styling */
.modern-ui .radio-item {
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
}

.modern-ui .radio-item input[type="radio"] {
    margin: 0;
    cursor: pointer;
}

.modern-ui .radio-item label {
    font-size: 12px;
    font-weight: bold;
    color: #333;
    cursor: pointer;
    margin: 0;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
$(document).ready(function () {  
    /* Upgraded JQX Date to match 24px inputs */
    $("#date_costmaster").jqxDateTimeInput({ width: '130px', height: '24px' ,formatString : "dd.MM.yyyy" });

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
});

function funFocus(){}

function funReset() {} 

function funReadOnly() {
    $('#frmCostmaster input').attr('readonly', true);
    $('#category1').attr('disabled', true);
    $('#category2').attr('disabled', true);
    $('#category3').attr('disabled', true);
    $('#frmCostmaster select').attr('disabled', true);
    delvalueChange();
}

function funRemoveReadOnly() {
    $('#frmCostmaster input').attr('readonly', true);
    $('#category1').attr('disabled', false);
    $('#category2').attr('disabled', false);
    $('#category3').attr('disabled', false);
    
    if ($("#mode").val() =="A") {
         $('#date_costmaster').val(new Date());
         $('#frmAccountmaster select').attr('disabled', true);
         
         var disother=document.getElementById("otherdis").value; 
         if(disother==1) {
             $("table#main input").prop("disabled", false);
             $("table#main input").prop("readonly", false);
             $("table#main select").prop("disabled", false);
             $('#category1').attr('disabled', false);
             $('#category2').attr('disabled', true);
             $('#category3').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $("table#trans input").prop("readonly", true);
         }
         if(disother==2) {
             $("table#sub input").prop("disabled", false);
             $("table#sub input").prop("readonly", false);
             $("table#sub select").prop("disabled", false);
             $('#subaccgpname').attr('readonly', true);
             $('#category2').attr('disabled', false);
             $('#category1').attr('disabled', true);
             $('#category3').attr('disabled', true);
             $("table#trans input").prop("readonly", true);
             $("table#main input").prop("readonly", true);
         }
         if(disother==3) {
             $("table#trans input").prop("disabled", false);
             $("table#trans input").prop("readonly", false);
             $("table#trans select").prop("disabled", false);
             $('#transcaccgpname').attr('readonly', true);
             $('#category3').attr('disabled', false);
             $('#category1').attr('disabled', true);
             $('#category2').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $("table#main input").prop("readonly", true);
         }
     }
    
     if ($("#mode").val() =="E") {
         $('#frmCostmaster input').attr('readonly', false);
         $('#frmCostmaster select').attr('readonly', false);
         var disother=document.getElementById("otherdis").value; 
         
         if(disother==1) {
             $("table#main input").prop("disabled", false);
             $("table#main select").prop("disabled", false);
             $('#category1').attr('disabled', false);
             $('#category2').attr('disabled', true);
             $('#category3').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $("table#trans input").prop("readonly", true);
         }
         if(disother==2) {
             $("table#sub input").prop("disabled", false);
             $("table#sub select").prop("disabled", false);
             $('#subaccgpname').attr('readonly', true);
             $('#category2').attr('disabled', false);
             $('#category1').attr('disabled', true);
             $('#category3').attr('disabled', true);
             $("table#trans input").prop("readonly", true);
             $("table#main input").prop("readonly", true);
         }
         if(disother==3) {
             $("table#trans input").prop("disabled", false);
             $("table#trans select").prop("disabled", false);
             $('#transcaccgpname').attr('readonly', true);
             $('#category3').attr('disabled', false);
             $('#category1').attr('disabled', true);
             $('#category2').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $("table#main input").prop("readonly", true);
         }
     }
     if ($("#mode").val() =="D") {
            $('#frmCostmaster input').attr('readonly', false);
            $('#category1').attr('disabled', false);
            $('#category2').attr('disabled', false);
            $('#category3').attr('disabled', false);
             $("table#trans input").prop("disabled", false);
             $("table#trans select").prop("disabled", false);
             $("table#main input").prop("disabled", false);
             $("table#main select").prop("disabled", false);
             $("table#sub input").prop("disabled", false);
             $("table#sub select").prop("disabled", false);
            $('#frmCostmaster select').attr('disabled', false);
     }
    $('#docno').attr('readonly', true);
}

function funSearchLoad(){
    changeContent('masterSearch.jsp'); 
}

function fundisable(){
    if (document.getElementById('category1').checked) {
        $('#frmCostmaster input').attr('readonly', false);
         $("table#sub input").prop("disabled", true);
         $("table#sub select").prop("disabled", true);
         $("table#trans input").prop("disabled", true);
         $("table#trans select").prop("disabled", true);
         $("table#main input").prop("disabled", false);
         $("table#main select").prop("disabled", false);
         document.getElementById('subaccgpname').value="";
         document.getElementById('subacccode').value="";
         document.getElementById('subaccname').value="";
         document.getElementById('transcaccgpname').value="";
         document.getElementById('transacccode').value="";
         document.getElementById('transaccname').value="";
         $('#docno').attr('readonly', true); 
         document.getElementById('radiotick').value=1;
         document.getElementById('radiosaveval').value=1;
         document.getElementById("errormsg").innerText=""; 
         document.getElementById('maindel').value=1;
         document.getElementById('otherdis').value=1;
         document.getElementById('main_account').value="mainacc";
        }
    else if (document.getElementById('category2').checked) {
        $('#frmCostmaster input').attr('readonly', false);
         $("table#main input").prop("disabled", true);
         $("table#main select").prop("disabled", true);
         $("table#trans input").prop("disabled", true);
         $("table#trans select").prop("disabled", true);
         $("table#sub input").prop("disabled", false);
         $("table#sub select").prop("disabled", false);
         $('#subaccgpname').attr('readonly', true);
         $('#docno').attr('readonly', true); 
         document.getElementById('mainacccode').value="";
         document.getElementById('mainacconame').value="";
         document.getElementById('transcaccgpname').value="";
         document.getElementById('transacccode').value="";
         document.getElementById('transaccname').value="";
         document.getElementById('radiotick').value=2;
         document.getElementById('radiosaveval').value=1;
         document.getElementById("errormsg").innerText=""; 
         document.getElementById('maindel').value=2;
         document.getElementById('otherdis').value=2;
         document.getElementById('sub_account').value="subacc";
        }
    else if (document.getElementById('category3').checked) {
        $('#frmCostmaster input').attr('readonly', false);
        $("table#main input").prop("disabled", true);
         $("table#main select").prop("disabled", true);
         $("table#sub input").prop("disabled", true);
         $("table#sub select").prop("disabled", true);
         $("table#trans input").prop("disabled", false);
         $("table#trans select").prop("disabled", false);
         $('#transcaccgpname').attr('readonly', true);
         document.getElementById('mainacccode').value="";
         document.getElementById('mainacconame').value="";
         document.getElementById('subaccgpname').value="";
         document.getElementById('subacccode').value="";
         document.getElementById('subaccname').value="";
         $('#docno').attr('readonly', true);
            document.getElementById('radiotick').value=3;
             document.getElementById('radiosaveval').value=1;
             document.getElementById("errormsg").innerText=""; 
             document.getElementById('maindel').value=3;
             document.getElementById('otherdis').value=3;
             document.getElementById('tran_account').value="tranacc";
        }
}

function getHead() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var headItems = items[0].split(",");
            var headIdItems = items[1].split(",");
            var optionsauth = '';
            optionsauth += '<option value="">-- select -- </option>';
            for (var i = 0; i < headItems.length; i++) {
                optionsauth += '<option value="' + headIdItems[i].trim() + '">'
                        + headItems[i] + '</option>';
            }
            $("select#mainaccgroup").html(optionsauth);
            delvalueChange();
        }
    }
    x.open("GET", "getMain.jsp", true);
    x.send();
}

function getMainac() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var mainacItems = items[0].trim().split(",");
            var mainacIdItems = items[1].trim().split(",");
            var optionsauth = '';
            optionsauth += '<option value=""> -- select --</option>';
            for (var i = 0; i < mainacItems.length; i++) {
                optionsauth += '<option value="' + mainacIdItems[i].trim() + '">'
                        + mainacItems[i].trim()+ '</option>';
            }
            $("select#subaccgroup").html(optionsauth);
            $("select#tansaccgroup").html(optionsauth);
            delvalueChange();
        } 
    }
    x.open("GET", "getSubTranAccmain.jsp", true);
    x.send();
}

function getAcgroup(value,check) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            if (check==1) {
                 $('#subaccgpname').val(items) ;
            }               
            else if (check==2) {
                 $('#transcaccgpname').val(items) ;
            }
         }
    }
     x.open("GET","disAcgroup.jsp?subaccountgroup="+value,true);
    x.send();
  }

function funChkButton(){
    frmCostmaster.submit();     
}

function funNotify(){
     if ($("#mode").val() =="A") {
         var radval=document.getElementById("radiosaveval").value; 
        
         if(radval=="") {
             document.getElementById("errormsg").innerText=" *Select One Account";
             return 0;
         }
         var codeval=document.getElementById("codeval").value; 
         if(codeval==1) {
             document.getElementById("errormsg").innerText="Cost Code Already Exists";
             return 0;
         } else{
             document.getElementById("errormsg").innerText="";
         }
         
         var radiotick=document.getElementById("radiotick").value; 
         if(radiotick==1) {
             var mainval=document.getElementById("mainaccgroup").value;
             if(mainval=="") {
                 document.getElementById("errormsg").innerText="Select   Cost Group";
                 document.getElementById("mainaccgroup").focus();
                 return 0;
             }
             var mainacc=document.getElementById("mainacconame").value;
             if(mainacc=="") {
                 document.getElementById("errormsg").innerText="Enter Cost Name";
                 document.getElementById("mainacconame").focus();
                 return 0;
             }
         }
         else if(radiotick==2) {
             var subval=document.getElementById("subaccgroup").value;
             if(subval=="") {
                 document.getElementById("errormsg").innerText="Select  Cost Group";
                 document.getElementById("subaccgroup").focus();
                 return 0;
             }
             var subacc=document.getElementById("subaccname").value;
             if(subacc=="") {
                 document.getElementById("errormsg").innerText="Enter Cost Name";
                 document.getElementById("subaccname").focus();
                 return 0;
             }
         }
         else if(radiotick==3) {
            var tranval=document.getElementById("tansaccgroup").value;
             if(tranval=="") {
                 document.getElementById("errormsg").innerText=" Select  Cost Group";
                 document.getElementById("tansaccgroup").focus();
                 return 0;
             }
             var tranacc=document.getElementById("transaccname").value;
             if(tranacc=="") {
                 document.getElementById("errormsg").innerText="Enter Cost Name";
                 document.getElementById("transaccname").focus();
                 return 0;
             }
         } else{
             document.getElementById("errormsg").innerText="";
         } 
     }
     
     if($("#mode").val() =="E") {
         var codeval=document.getElementById("codeval").value; 
         if(codeval==1) {
             document.getElementById("errormsg").innerText="Cost Code Already Exists";
             return 0;
         } else{
             document.getElementById("errormsg").innerText="";
         }
     }
     
     if ($("#mode").val() =="view") {
            $('#category1').attr('disabled', false);
            $('#category2').attr('disabled', false);
            $('#category3').attr('disabled', false);
         $('#mainaccgroup').attr('disabled', false);
     }
    return 1;
}

function maincheck() {
    document.getElementById("errormsg").innerText="";
    document.getElementById("codeval").value="";    
    if(document.getElementById("mainacccode").value!=""){
        var code=document.getElementById("mainacccode").value;
        funtest(code);
    }
}
function subcheck() {
    document.getElementById("errormsg").innerText="";
    document.getElementById("codeval").value="";    
    if(document.getElementById("subacccode").value!=""){
        var code=document.getElementById("subacccode").value;
        funtest(code);
    }
}
function trancheck() {
    document.getElementById("errormsg").innerText="";
    document.getElementById("codeval").value="";    
    if(document.getElementById("transacccode").value!=""){
        var code=document.getElementById("transacccode").value;
        funtest(code);
    }
}

function funtest(code) {
    var masterdoc=document.getElementById("docno").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
                 if(items!="") {
                    document.getElementById("codeval").value=1;
                    document.getElementById("errormsg").innerText="Cost Code Already Exists";
                } else {
                    document.getElementById("codeval").value="";
                    document.getElementById("errormsg").innerText="";
                }
         }
    }
    x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
}  

function delvalueChange() {
      if(document.getElementById("radiotick").value==1) {
          document.getElementById("category1").checked = true;
      }
      else if(document.getElementById("radiotick").value==2) {
          document.getElementById("category2").checked = true;
      }
     else if(document.getElementById("radiotick").value==3) {
      document.getElementById("category3").checked = true;
      }
      
      if($('#checksetval').val()!="") {
          $('#mainaccgroup').val($('#checksetval').val());
      }
      if($('#subchecksetval').val()!="") {
         $('#subaccgroup').val($('#subchecksetval').val());
      }
      if($('#tranchecksetval').val()!="") {
         $('#tansaccgroup').val($('#tranchecksetval').val());
      }
}

function funclear1() {
       document.getElementById("subchecksetval").value=="";
       document.getElementById("tranchecksetval").value=="";
}
function funclear2() {
       document.getElementById("checksetval").value=="";
       document.getElementById("tranchecksetval").value=="";
}
function funclear3() {
       document.getElementById("checksetval").value=="";
       document.getElementById("subchecksetval").value=="";
}

function setValues() {
    if($('#datehidden').val()){
        $("#date_costmaster").jqxDateTimeInput('val', $('#datehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
     delvalueChange();
}

function checkreq() {
    if(document.getElementById('radiotick').value==1) {
        if(document.getElementById("mainacconame").value=="") { 
             document.getElementById("errormsg").innerText=" Enter Account Name";
             return 0;
        }
    }
    else if(document.getElementById('radiotick').value==2) {
         if(document.getElementById("subaccname").value=="") {
             document.getElementById("errormsg").innerText=" Enter SubAccount Name";
             return 0;
        }
    }
    else if(document.getElementById('radiotick').value==3) {
        if(document.getElementById("transaccname").value=="") { 
            document.getElementById("errormsg").innerText=" Enter TraAccount Name";
            return 0;
        }
    }
    else {
         document.getElementById("errormsg").innerText="";
    }
}

function dismassge() {
    document.getElementById("errormsg").innerText="";
}

function funExcelBtn(){
    var url=document.URL;
    var reurl=url.split("costcentermaster");
    top.addTab("ChartOfCost",reurl[0]+"costcentermaster/chartOfCost.jsp");
}
</script>
</head>

<body onload="getHead();getMainac();setValues();">

<div class="homeContent hidden-scrollbar" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    
    <form id="frmCostmaster" action="saveCostmaster" method="post" autocomplete="off">
        
        <div class="modern-ui">

            <div class="bordered-panel highlight-panel">
                <div class="field-row" style="margin-bottom: 0; gap: 30px;">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 50px;">Date</label>
                        <div style="width: 130px; flex: none;">
                            <div id="date_costmaster" name="date_costmaster" value='<s:property value="date_costmaster"/>'></div>
                        </div>
                    </div>
                    
                    <div class="input-group">
                        <label class="lbl-right" style="width: 60px;">Doc No.</label>
                        <input type="text" id="docno" name="docno" style="width: 150px;" tabindex="-1" value='<s:property value="docno"/>' readonly />
                    </div>
                </div>
            </div>

            <div class="bordered-panel">
                <div class="field-row" style="margin-bottom: 0;">
                    <div class="radio-item" style="margin-right: 20px;">
                        <input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();" checked>
                        <label for="category1">Main Account</label>
                    </div>
                    <div class="radio-item" style="margin-right: 20px;">
                        <input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();">
                        <label for="category2">Sub Account</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();">
                        <label for="category3">Transaction</label>
                    </div>
                    <div style="margin-left: auto; font-style: italic; color: #666; font-size: 11px;">
                        *Selection controls behavior and validation
                    </div>
                </div>
            </div>

            <div style="display: flex; gap: 15px; align-items: flex-start; width: 100%;">
                
                <div class="bordered-panel" style="flex: 1;" id="mainSection">
                    <span class="modern-panel-title">Main Account</span>
                    <table id="main" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 80px;">Cost Group</label>
                                    <select name="mainaccgroup" id="mainaccgroup" value='<s:property value="mainaccgroup"/>' onchange="funclear1();" style="flex: 1;">
                                        <option value="-1">--Select--</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 80px;">Cost Code</label>
                                    <input type="text" id="mainacccode" name="mainacccode" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 80px;">Cost Name</label>
                                    <input type="text" id="mainacconame" name="mainacconame" value='<s:property value="mainacconame"/>' onblur="dismassge()" style="flex: 1;" />
                                    <input type="hidden" name="main_account" id="main_account" value='<s:property value="main_account"/>' />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="bordered-panel" style="flex: 1;" id="subSection">
                    <span class="modern-panel-title">Sub Account</span>
                    <table id="sub" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Main Cost Grp</label>
                                    <div style="display: flex; gap: 5px; flex: 1; min-width: 0;">
                                        <select name="subaccgroup" id="subaccgroup" value='<s:property value="subaccgroup"/>' onChange="getAcgroup(this.value,1);" onfocus="funclear2();" style="width: 40%;">
                                            <option value="-1">--Select--</option>
                                        </select>
                                        <input type="text" id="subaccgpname" name="subaccgpname" value='<s:property value="subaccgpname"/>' placeholder="Group Name" style="width: 60%;" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Cost Code</label>
                                    <input type="text" id="subacccode" name="subacccode" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Cost Name</label>
                                    <input type="text" id="subaccname" name="subaccname" value='<s:property value="subaccname"/>' onblur="dismassge()" style="flex: 1;" />
                                    <input type="hidden" name="sub_account" id="sub_account" value='<s:property value="sub_account"/>' />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="bordered-panel" style="flex: 1;" id="transSection">
                    <span class="modern-panel-title">Transaction</span>
                    <table id="trans" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Sub Cost Grp</label>
                                    <div style="display: flex; gap: 5px; flex: 1; min-width: 0;">
                                        <select id="tansaccgroup" name="tansaccgroup" onChange="getAcgroup(this.value,2);" onfocus="funclear3();" style="width: 40%;">
                                            <option value="-1">--Select--</option>
                                        </select>
                                        <input type="text" id="transcaccgpname" name="transcaccgpname" value='<s:property value="transcaccgpname"/>' placeholder="Group Name" style="width: 60%;" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Cost Code</label>
                                    <input type="text" id="transacccode" name="transacccode" value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 100px;">Cost Name</label>
                                    <input type="text" id="transaccname" name="transaccname" value='<s:property value="transaccname"/>' onblur="dismassge()" style="flex: 1;" />
                                    <input type="hidden" name="tran_account" id="tran_account" value='<s:property value="tran_account"/>' />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>' />
            <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>' />
            <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>' />
            <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>' />
            <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>' />
            <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>' />
            <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
            <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>' />

        </div>
    </form>
</div>

<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</body>
</html>