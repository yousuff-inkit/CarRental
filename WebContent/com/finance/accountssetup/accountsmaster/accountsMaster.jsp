<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

/* Checkbox/Radio Item Styling */
.modern-ui .radio-item {
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
}

.modern-ui .radio-item input[type="radio"],
.modern-ui .radio-item input[type="checkbox"] {
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

form label.error {
    color: red;
    font-weight: bold;
}
</style>

<script type="text/javascript">
$(document).ready(function () {    
    /* Upgraded JQX Date to match 24px inputs */
    $("#date_accountmaster").jqxDateTimeInput({ width: '130px', height: '24px' ,formatString : "dd.MM.yyyy" });
    
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
    
    $('#accountSearchwindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Currency  Search' ,position: { x: 600, y: 150 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
   
     $('#currs').dblclick(function(){
            if($('#mode').val()!= "view" && document.getElementById('category3').checked) {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountGridSearch.jsp');
            } 
    }); 
});

function getaccountdetails(event){
     var x= event.keyCode;
    if($('#mode').val()!= "view" && document.getElementById('category3').checked) {
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          accountSearchContent('accountGridSearch.jsp');   }
         else{
             }
      } 
}  

function accountSearchContent(url) {
      $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function funFocus(){}
function funReset() {} 

function funReadOnly() {
    $('#frmAccountmaster input').attr('readonly', true);
    $('#localcurrency').attr('disabled', true);
    $('#ageingdetails').attr('disabled', true);
    $('#interbranch').attr('disabled', true);
    $('#category1').attr('disabled', true);
    $('#category2').attr('disabled', true);
    $('#category3').attr('disabled', true);
    $('#frmAccountmaster select').attr('disabled', true);
    delvalueChange();
}

function funRemoveReadOnly() {
    $('#frmAccountmaster input').attr('readonly', true);
    $('#localcurrency').attr('disabled', true);
    $('#ageingdetails').attr('disabled', true);
    $('#interbranch').attr('disabled', false);
    $('#category1').attr('disabled', false);
    $('#category2').attr('disabled', false);
    $('#category3').attr('disabled', false);
    
     if ($("#mode").val() =="A") {
         $('#date_accountmaster').val(new Date());
         document.getElementById("interbranch").checked = false;
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
             $('#interbranch').attr('disabled', true);
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
             $('#interbranch').attr('disabled', true);
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
             $('#interbranch').attr('disabled', false);
         }
     }
     if ($("#mode").val() =="E") {
         $('#frmAccountmaster input').attr('readonly', false);
         $('#frmAccountmaster select').attr('readonly', false);
        
         var disother=document.getElementById("otherdis").value; 
         if(disother==1) {
             $("table#main input").prop("disabled", false);
             $("table#main select").prop("disabled", false);
             $('#category1').attr('disabled', false);
             $('#category2').attr('disabled', true);
             $('#category3').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $("table#trans input").prop("readonly", true);
             $('#interbranch').attr('disabled', true);
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
             $('#interbranch').attr('disabled', true);
         }
         if(disother==3) {
             $("table#trans input").prop("disabled", false);
             $("table#trans select").prop("disabled", false);
             $('#transcaccgpname').attr('readonly', true);
             $('#category3').attr('disabled', false);
             $('#category1').attr('disabled', true);
             $('#category2').attr('disabled', true);
             $("table#sub input").prop("readonly", true);
             $('#currs').attr('readonly', true);
             $("table#main input").prop("readonly", true);
             $('#interbranch').attr('disabled', false);
         }
     }
     if ($("#mode").val() =="D") {
            $('#frmAccountmaster input').attr('readonly', false);
            $('#localcurrency').attr('disabled', false);
            $('#ageingdetails').attr('disabled', false);
            $('#interbranch').attr('disabled', false);
            $('#category1').attr('disabled', false);
            $('#category2').attr('disabled', false);
            $('#category3').attr('disabled', false);
             $("table#trans input").prop("disabled", false);
             $("table#trans select").prop("disabled", false);
             $("table#main input").prop("disabled", false);
             $("table#main select").prop("disabled", false);
             $("table#sub input").prop("disabled", false);
             $("table#sub select").prop("disabled", false);
            $('#frmAccountmaster select').attr('disabled', false);
     }
    
    $('#docno').attr('readonly', true);
     funhidden();
}

function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window')); 
 }

function fundisable(){
    if (document.getElementById('category1').checked) {
        $('#frmAccountmaster input').attr('readonly', false);
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
         
         document.getElementById('otherdis').value=1;
         document.getElementById('radiotick').value=1;
         document.getElementById('radiosaveval').value=1;
         document.getElementById("errormsg").innerText=""; 
         document.getElementById('maindel').value=1;
         document.getElementById('main_account').value="mainacc";
        }
    else if (document.getElementById('category2').checked) {
        $('#frmAccountmaster input').attr('readonly', false);
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
         document.getElementById('otherdis').value=2;
         document.getElementById('radiotick').value=2;
         document.getElementById('radiosaveval').value=1;
         document.getElementById("errormsg").innerText=""; 
         document.getElementById('maindel').value=2;
         document.getElementById('sub_account').value="subacc";
        }
    else if (document.getElementById('category3').checked) {
        $('#frmAccountmaster input').attr('readonly', false);
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
         document.getElementById('otherdis').value=3;
            document.getElementById('radiotick').value=3;
             $('#docno').attr('readonly', true);    
            
             $('#currs').attr('readonly', true);
             document.getElementById('radiosaveval').value=1;
             document.getElementById("errormsg").innerText=""; 
             document.getElementById('maindel').value=3;
             document.getElementById('tran_account').value="tranacc";
        }
     }
    
function funhidden(){
     if (document.getElementById('interbranch').checked) {
         document.getElementById('intertick').value=1;
        $("#branch").prop("hidden", false);
    }
    else {
        document.getElementById('intertick').value="";
        $("#branch").prop("hidden", true);
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
                optionsauth += '<option value="' + headIdItems[i] + '">'
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
            var mainacItems = items[0].split(",");
            var mainacIdItems = items[1].split(",");
            var optionsauth = '';
            optionsauth += '<option value=""> -- select --</option>';
            for (var i = 0; i < mainacItems.length; i++) {
                optionsauth += '<option value="' + mainacIdItems[i] + '">'
                        + mainacItems[i] + '</option>';
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
    //frmAccountmaster.submit();        
}

function funNotify(){
    if (document.getElementById('category3').checked) {
         var currs=document.getElementById("currs").value; 
         if(currs=="") {
             document.getElementById("errormsg").innerText=" * Select Currency";
             return 0;
         }
         var ratess=document.getElementById("ratess").value; 
         if(parseFloat(ratess)>0) {
         } else {
             document.getElementById("ratess").focus();
             document.getElementById("errormsg").innerText=" * Rate Should Be Greater Than Zero";
             return 0;
         }
    }
    
     if ($("#mode").val() =="A") {
         var radval=document.getElementById("radiosaveval").value; 
         if(radval=="") {
             document.getElementById("errormsg").innerText=" *Select One Account";
             return 0;
         }
         var codeval=document.getElementById("codeval").value; 
         if(codeval==1) {
             document.getElementById("errormsg").innerText="Account Code Already Exists";
             return 0;
         } else{
             document.getElementById("errormsg").innerText="";
         }
     }
     if($("#mode").val() =="E") {
         var codeval=document.getElementById("codeval").value; 
         if(codeval==1) {
             document.getElementById("errormsg").innerText="Account Code Already Exists";
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
                    document.getElementById("errormsg").innerText="Account Code Already Exists";
                    return  false;
                } else {
                    document.getElementById("codeval").value="";
                    document.getElementById("errormsg").innerText="";
                    return  true;
                }
         }
    }
    x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
    }  

function getbranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var headItems = items[0].split(",");
                var headIdItems = items[1].split(",");
                var optionsauth = '';
                for (var i = 0; i < headItems.length; i++) {
                    optionsauth += '<option value="' + headIdItems[i] + '">'
                            + headItems[i] + '</option>';
                }
                $("select#branchone").html(optionsauth);
                if($('#interbr1').val()!="") {
                    $('#branchone').val($('#interbr1').val());
                }
            } 
        }
        x.open("GET", "getbranch.jsp", true);
        x.send();
    }

   function getSecbranch(second) {
       var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var headItems = items[0].split(",");
                var headIdItems = items[1].split(",");
                var optionsauth = '';
                for (var i = 0; i < headItems.length; i++) {
                    optionsauth += '<option value="' + headIdItems[i] + '">'
                            + headItems[i] + '</option>';
                }
                $("select#branchtwo").html(optionsauth);
                if($('#interbr2').val()!="") {
                    $('#branchtwo').val($('#interbr2').val());
                }
            } 
        }
        x.open("GET", 'secondBranch.jsp?second='+second, true);
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
    
     if(document.getElementById("intertick").value==1) {
      document.getElementById("interbranch").checked = true;
      } else {
        document.getElementById("interbranch").checked = false;
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
        $("#date_accountmaster").jqxDateTimeInput('val', $('#datehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    delvalueChange();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    var second=$('#interbr1').val();
    if(second!=""){
        document.getElementById('interbranch').checked=true;
    }
    funhidden();
    getSecbranch(second);
}

function checkreq() {
    if(document.getElementById('radiotick').value==1) {
        if(document.getElementById("mainacconame").value=="") { 
             document.getElementById("errormsg").innerText=" *Enter Account Name";
             return 0;
        }
    }
    else  if(document.getElementById('radiotick').value==2) {
         if(document.getElementById("subaccname").value=="") {
             document.getElementById("errormsg").innerText=" *Enter SubAccount Name";
             return 0;
        }
    }
    else  if(document.getElementById('radiotick').value==3) {
        if(document.getElementById("transaccname").value=="") { 
            document.getElementById("errormsg").innerText=" *Enter TraAccount Name";
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
    var reurl=url.split("accountsmaster");
    top.addTab("ChartOfAccounts",reurl[0]+"accountsmaster/chartOfAccount.jsp");
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
       document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}   

function getConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
        var items = x.responseText.trim();
        if(parseInt(items)>0){ 
               $('#subaccountfield').show();
            }else{
                $('#subaccountfield').hide();
            }
        }
    }       
    x.open("GET", "subaccConfig.jsp",true);
    x.send();
}   
</script>
</head>

<body onload="getHead();getMainac();getbranch();setValues();getConfig();">

<div class="homeContent hidden-scrollbar" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <form id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">
        
        <div class="modern-ui">

            <div class="bordered-panel highlight-panel">
                <div class="field-row" style="margin-bottom: 0; gap: 30px;">
                    <div class="input-group">
                        <label class="lbl-right" style="width: 50px;">Date</label>
                        <div style="width: 130px; flex: none;">
                            <div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div>
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
                                    <label class="lbl-right" style="width: 90px;">Cost Group</label>
                                    <select name="mainaccgroup" id="mainaccgroup" value='<s:property value="mainaccgroup"/>' onchange="funclear1();" style="flex: 1;">
                                        <option value="-1">--Select--</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Account Code</label>
                                    <input type="text" id="mainacccode" name="mainacccode" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" onkeypress="javascript:return isNumber (event);" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Account Name</label>
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
                                    <label class="lbl-right" style="width: 90px;">Main Group</label>
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
                                    <label class="lbl-right" style="width: 90px;">Account Code</label>
                                    <input type="text" id="subacccode" name="subacccode" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" onkeypress="javascript:return isNumber (event);" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Account Name</label>
                                    <input type="text" id="subaccname" name="subaccname" value='<s:property value="subaccname"/>' onblur="dismassge()" style="flex: 1;" />
                                    <input type="hidden" name="sub_account" id="sub_account" value='<s:property value="sub_account"/>' />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="bordered-panel" style="flex: 1.2;" id="transSection">
                    <span class="modern-panel-title">Transaction</span>
                    <table id="trans" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Sub Cost Grp</label>
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
                                    <label class="lbl-right" style="width: 90px;">Account Code</label>
                                    <input type="text" id="transacccode" name="transacccode" value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" onkeypress="javascript:return isNumber (event);" style="flex: 1;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Account Name</label>
                                    <input type="text" id="transaccname" name="transaccname" value='<s:property value="transaccname"/>' onblur="dismassge()" style="flex: 1;" />
                                    <input type="hidden" name="tran_account" id="tran_account" value='<s:property value="tran_account"/>' />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px;">
                                <div class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Currency</label>
                                    <input type="text" name="currs" id="currs" value='<s:property value="currs"/>' onkeydown="getaccountdetails(event);" style="width: 100px; flex: none;"/>
                                    
                                    <label class="lbl-right" style="width: 40px; margin-left: auto;">Rate</label>
                                    <input type="text" name="ratess" id="ratess" value='<s:property value="ratess"/>' onblur="funRoundRate(this.value,this.id);" onkeypress="javascript:return isNumber (event);" style="width: 80px; flex: none; text-align: right;">
                                </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <td style="border-top: 1px solid #e1e4e8; padding-top: 10px;">
                                <div class="radio-item" style="margin-bottom: 10px;">
                                    <input type="checkbox" id="interbranch" name="interbranch" onchange="funhidden();" value="1"/>
                                    <label for="interbranch">Inter branch Account</label>
                                </div>
                                <div id="branch" hidden="true" class="field-row" style="margin-bottom: 0;">
                                    <label class="lbl-right" style="width: 90px;">Branch Link</label>
                                    <select name="branchone" id="branchone" onClick="getSecbranch(this.value)" style="flex: 1; min-width: 0;">
                                        <option value="0">--Select--</option> 
                                    </select>
                                    <span style="font-weight: bold; color: #444; margin: 0 5px;">To</span>
                                    <select name="branchtwo" id="branchtwo" style="flex: 1; min-width: 0;">
                                        <option value="0">--Select--</option> 
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'> 
            <input type="hidden" id="currsid" name="currsid" value='<s:property value="currsid"/>'>
            <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
            <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
            <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
            <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
            <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
            <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
            <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
            <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>
            <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>

        </div>
    </form>
</div>

<div id="accountSearchwindow">
    <div></div>
</div>
</body>
</html>