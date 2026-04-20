<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   1. YOUR ORIGINAL PAGE & WRAPPER STYLES (UNTOUCHED)
========================================================= */
form label.error {
    color:red;
    font-weight:bold;
}

.style1 {
	color: #FF0000;
	font-weight: bold;
}

.hidden-scrollbar {
    overflow: visible;
    height: auto;
}

html, body {
    background: #ffffff;                
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;                     
    color: #333;
    margin: 0;
    padding: 0; /* Removed heavy padding that was pushing everything down */
    box-sizing: border-box;
}

.windowCont,
#mainBG.homeContent {
    background: #ffffff !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 8px;
    padding: 5px 18px 16px 18px; /* Reduced top padding to pull content up */
    max-width: 1400px;
    margin: 0 auto;
    box-shadow: none;                    
}

/* =========================================================
   2. CASH RECEIPTS UI ELEMENTS (TIGHTENED SPACING)
========================================================= */
.middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 15px 15px 15px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 6px; 
    margin-bottom: 25px;
    margin-top: 15px; /* Reduced from 30px to tuck it closer to the header */
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 15px; 
    background: #ffffff; 
    padding: 0 10px; 
    color: #0056b3;
    font-weight: 700; 
    font-size: 15px; 
    border-left: 4px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Flexbox Layout for Rows & Columns */
.field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    width: 100%;
    flex-wrap: wrap;
    gap: 15px;
}

.lbl-right { 
    color: #1e293b;
    font-size: 13px; 
    font-weight: 600; 
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    white-space: nowrap; 
    text-align: right;
    min-width: 100px; 
}

/* Scoped 26px Inputs */
input[type="text"],
input[type="email"],
select { 
    height: 26px !important; 
    border: 1px solid #d1d5db; 
    border-radius: 4px; 
    padding: 4px 8px;
    font-size: 13px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"]:focus,
input[type="email"]:focus,
select:focus { 
    border-color: #3b82f6; 
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

input[readonly],
input:disabled,
select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        getBranchLimit();  
        
        $("#branchaccdate1").jqxDateTimeInput({ width: '125px', height: 26, formatString:"dd.MM.yyyy", theme: 'energyblue'}); 
        $("#branchaccdate2").jqxDateTimeInput({ width: '125px', height: 26, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        
        setTimeout(function () {
            $("#branchaccdate1, #branchaccdate2").find("input").css({
                "margin-top": "0px",
                "line-height": "26px",
                "font-size": "13px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#branchaccdate1, #branchaccdate2").find(".jqx-action-button").css({
                "top": "0px",
                "height": "26px"
            });
        }, 0);

        document.getElementById("datediv").style.display="none";
        document.getElementById("formdet").innerText="Branch(BRH)";
        document.getElementById("formdetail").value="Branch";
        document.getElementById("formdetailcode").value="BRH";
        window.parent.formCode.value="BRH"; 
        window.parent.formName.value="Branch";
     });
    
    function funSearchLoad(){
        changeContent('branchSearch.jsp', $('#window')); 
     }
     
    function funReadOnly(){
        $('#frmBranch input').attr('readonly', true );
        $('#frmBranch select').attr('disabled', true );
         $('#branchaccdate1').jqxDateTimeInput({ disabled: true});
         $('#branchaccdate2').jqxDateTimeInput({ disabled: true});
    }
    
    function funRemoveReadOnly(){
        $('#frmBranch input').attr('readonly', false );
        $('#frmBranch select').attr('disabled', false );
        $('#branchaccdate1').jqxDateTimeInput({ disabled: false});
         $('#branchaccdate2').jqxDateTimeInput({ disabled: false});
    }
    
    function getCurrency()
     {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                var currItems=items[0].split(",");
                var curridItems=items[1].split(",");
                    var optionscurr = '<option value="">--Select--</option>';
                for ( var i = 0; i < currItems.length; i++) {
                   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
                }
                 $("select#cmbbranchcurr").html(optionscurr);
                 $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
                }
         }
          x.open("GET","getCurrency.jsp",true);
         x.send();
       }
       
    function getCompany()
    {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                 var compidItems=items[1].split(",");
                var compItems=items[0].split(",");
                 var optionscomp = '<option value="">--Select--</option>';
                for ( var i = 0; i < compItems.length; i++) {
                   optionscomp += '<option value="' + compidItems[i] + '">' + compItems[i] + '</option>';
                }
                 $("select#cmbcompname").html(optionscomp);
                 $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
                 $('#cmbcompname').val($('#hidcmbcompname').val()) ;
                }
         }
          x.open("GET","getCompany.jsp",true);
         x.send();  
    }


     function getBranchLimit()
    {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                 var brLimit=items[0];
                 if(brLimit>10){
                    $("#btnCreate").attr('disabled', true );
                    document.getElementById("errormsg").innerText="Branch Count Exceeds Limit,Contact Administrator!!!";
                 }
                }
         }
          x.open("GET","getBrlimit.jsp",true);
         x.send();  
    }

    function verify() { }
    
    function setValues(){   
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    }
    
    function checkBranchid(value){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                var items=x.responseText;
                if(items.trim()!='undefine'){
                    document.getElementById("txtbranchid").focus();
                    document.getElementById("errormsg").innerText="Branch ID Already Exists";
                }
                else{
                    document.getElementById("errormsg").innerText="";
                }
                }
         }
          x.open("GET","checkBranchid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
         x.send();
    }
    
    function funFocus()
    {
        document.getElementById("cmbcompname").focus();
    }
   
    $(function(){
        $('#frmBranch').validate({
                 rules: {
                 txtbranchid: { required:true, maxlength:5 },
                txtbranchname:"required",
                cmbcompname:"required",
                cmbbranchcurr:"required"
                 },
                 messages: {
                  txtbranchid:{ required:" *", maxlength:'max 5 chars' },
                  txtbranchname:" *",
                  cmbcompname:" *",
                  cmbbranchcurr:" *"
                 }
        });});
        
     function funNotify(){
        var date1 = $('#branchaccdate1').jqxDateTimeInput('getDate');
        var date2 = $('#branchaccdate2').jqxDateTimeInput('getDate');
    
        if(date1>date2){
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText="Accounting To Date Cannot be less than From Date";
            $('#branchaccdate1').jqxDateTimeInput('focus');
            return 0;
        }   
        document.getElementById("errormsg").innerText="";
        return 1;
    } 
</script>
</head>
<body onLoad="getCurrency();getCompany();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBranch" action="saveActionBranch" autocomplete="off">
    
    <jsp:include page="../../../../header.jsp" />
  
    <div class="hidden-scrollbar">

        <div class="middle-panel" style="max-width: 1000px;">
            <span class="middle-panel-title">Branch Info</span>
            
            <div class="field-row">
                <label class="lbl-right">Company</label>
                <select name="cmbcompname" id="cmbcompname" value='<s:property value="cmbcompname"/>' style="flex: 1; max-width: 600px;">
                    <option></option>
                </select>
            </div>

            <div class="field-row">
                <label class="lbl-right">Branch</label>
                <div style="display: flex; flex: 1; gap: 10px; max-width: 600px;">
                    <input type="text" id="txtbranchid" name="txtbranchid" value='<s:property value="txtbranchid"/>' onblur="checkBranchid(this.value);" style="width: 100px; flex: none;">
                    <input type="text" id="txtbranchname" name="txtbranchname" value='<s:property value="txtbranchname"/>' style="flex: 1;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <label class="lbl-right">P.B.No</label>
                <input type="text" id="txtpbno" name="txtpbno" value='<s:property value="txtpbno"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel1" name="txttel1" value='<s:property value="txttel1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel2" name="txttel2" value='<s:property value="txttel2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax1"  name="txtfax1" value='<s:property value="txtfax1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax2" name="txtfax2" value='<s:property value="txtfax2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Email</label>
                <input type="email" id="txtemail1" name="txtemail1" value='<s:property value="txtemail1"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <label class="lbl-right">Website</label>
                <input type="text" id="txtwebsite" name="txtwebsite" value='<s:property value="txtwebsite"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tin No.</label>
                    <input type="text" id="txttinno" name="txttinno" value='<s:property value="txttinno"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">STC No.</label>
                    <input type="text" id="txtstcno" name="txtstcno" value='<s:property value="txtstcno"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">CST No</label>
                    <input type="text" id="txtcstno" name="txtcstno" value='<s:property value="txtcstno"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px; padding-left: 30px;">
                    <input type="checkbox" id="chckfollowhr" name="chckfollowhr" onChange="verify();" value='<s:property value="chckfollowhr"/>' style="margin-right: 8px;">
                    <label for="chckfollowhr" style="font-weight: 600; color: #444; font-size: 13px; cursor: pointer;">Follows Company HR Calendar</label>
                </div>
            </div>

            <div style="border-top: 1px solid #e5e7eb; margin-top: 15px; padding-top: 15px;">
                <div class="field-row">
                    <label class="lbl-right">Account Period</label>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <div id="branchaccdate1" name="branchaccdate1" value='<s:property value="branchaccdate1"/>'></div>
                        <input type="hidden" id="hidbranchaccdate1" name="hidbranchaccdate1" value='<s:property value="hidbranchaccdate1"/>'/>
                        
                        <span style="font-weight: 600; color: #444;">To</span>
                        
                        <div id="branchaccdate2" name="branchaccdate2" value='<s:property value="branchaccdate2"/>'></div>
                        <input type="hidden" id="hidbranchaccdate2" name="hidbranchaccdate2" value='<s:property value="hidbranchaccdate2"/>'/>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <div style="display: flex; align-items: center; flex: 1; max-width: 300px;">
                        <label class="lbl-right">Currency</label>
                        <select id="cmbbranchcurr" name="cmbbranchcurr" value='<s:property value="cmbbranchcurr"/>' style="flex: 1; margin-left: 15px;">
                            <option></option>
                        </select>
                    </div>
                </div>
            </div>

        </div>

        <input type="hidden" name="hidcmbcompname" id="hidcmbcompname" value='<s:property value="hidcmbcompname"/>'>
        <input type="hidden" id="hidcmbbranchcurr" name="hidcmbbranchcurr" value='<s:property value="hidcmbbranchcurr"/>'/>
        
        <div class="style1" id="datediv" style="display: none;">
            <div align="right">Please select a valid Date</div>
        </div>

        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>

    </div>
</form>
</div>                                   
</body>
</html>