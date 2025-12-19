<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
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
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    /* Adjusted grid for Client Review Header: Label Input Label Input Label Status Check Button Button */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 2fr auto 1fr auto 1fr auto auto auto;
        gap: 15px;
        align-items: center;
        margin-bottom: 25px;
        padding: 0 5px; 
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 20px; /* Space between stacked blocks */
    }

    /* For full width sections not in a row */
    .section-block-full {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 20px;
    }

    .section-block h2, .section-block-full h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
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
        font-size: 14px;
    }

    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
        white-space: nowrap;
    }
    .myButton:hover { background: #0056b3; }

    /* ------------------------------
       SPECIFIC UTILS
    ------------------------------ */
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

    /* Cleaned up Status Animation */
    .status-text {
        color: #FD8725;
        font-weight: bold;
        animation: blink 1.5s infinite alternate;
    }

    @keyframes blink {
        from { opacity: 1; }
        to { opacity: 0.4; }
    }
    
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 14px;
        font-weight: 600;
        color: #253858;
    }
</style>

<script type="text/javascript">

    $(document).ready(function () { 
         $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnExcel').attr('disabled', true );
         $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );$('#btnPrint').attr('disabled', true );
        
         $("#jqxNonFinancialDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
         $("#jqxClientReviewDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        
        $('#clientWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Clients Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
        $('#clientWindow').jqxWindow('close');
        
        $('#nonFinancialWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '30%' ,maxWidth: '51%' , title: 'Non-Financial Comments',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
        $('#nonFinancialWindow').jqxWindow('close');
        
        document.getElementById("hidchckdetailed").value = 0;
        getIDPDetails();
        
        $('#txtclientname').dblclick(function(){
            clientSearchContent('clientDetailsSearch.jsp');
        });
    });
    
    function clientSearchContent(url) {
        $('#clientWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#clientWindow').jqxWindow('setContent', data);
        $('#clientWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function nonFinancialCommentsContent(url) {
        $('#nonFinancialWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#nonFinancialWindow').jqxWindow('setContent', data);
        $('#nonFinancialWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getIDPDetails(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#idpdetailsallowed').val(items);
        }
        }
        x.open("GET", "getIDPDetailsAllowed.jsp", true);
        x.send();
    }
    
    function getAccountBalance(a,b){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                $('#txtbalance').val(items[0]);
                $('#lblclientstatus').html(items[1]);
        }
        }
        x.open("GET", "getAccountBalance.jsp?accountno="+a+'&cldocno='+b, true);
        x.send();
    }
    
    function getAcc(event){
        var x= event.keyCode;
        if(x==114){
            clientSearchContent('clientDetailsSearch.jsp');
        }
        else{}
        }
    
    function funDetailed(){
         if(document.getElementById("chckdetailed").checked){
             $.messager.confirm('Confirm', 'Do you want to have detailed informations?', function(r){
                    if (r){
                        document.getElementById("hidchckdetailed").value = 1;
                        var detailed=$('#hidchckdetailed').val();
                        var cldocno=$('#txtcldocno').val();
                        var accno=$('#txtaccno').val();
                        if(cldocno != ""){
                            $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
                            $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
                                $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
                                $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
                            }
                        if(accno != ""){
                            $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
                        }
                     }
                    else{
                        document.getElementById("chckdetailed").checked = false;
                        document.getElementById("hidchckdetailed").value = 0;
                    }
                   });
         } else{
             document.getElementById("chckdetailed").checked = false;
             document.getElementById("hidchckdetailed").value = 0;
             var detailed=$('#hidchckdetailed').val();
             var cldocno=$('#txtcldocno').val();
             var accno=$('#txtaccno').val();
             if(cldocno != ""){
                $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
                $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
                                $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
                                $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
              }
              if(accno != ""){
                $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
              }
         }
     }
    
    function funOutStandingStatement(){
        var accno = $('#txtaccno').val();
        
        if(accno==''){
             $.messager.alert('Message','Please Choose a Client.','warning');
             return 0;
         }
        
        if ($("#txtaccno").val()!="") {
            var url=document.URL;
            var reurl=url.split("clientReview.jsp");
            
            $("#txtaccno").prop("disabled", false);
            var win= window.open(reurl[0]+"clientReviewOutstandingsStatement?atype=AR&acno="+document.getElementById("txtaccno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("brchName").value+'&uptoDate='+$("#jqxClientReviewDate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
         }
        else {
            $.messager.alert('Message','Account is Mandatory.','warning');
            return;
        }
       }
  
    function funSaveDetails(event){
        var mode = $("#mode").val("A");
        var cldocno = $('#txtcldocno').val();
        var description = $('#txtdescription').val();
        
        if(cldocno==''){
             $.messager.alert('Message','Choose a Client.','warning');
             return 0;
         }
            
        $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                
            if(r==false)
              {
                return false; 
              }
            else{
                 saveGridData(description,cldocno,mode);    
            }
         });
    }
    
    function funDeleteDocu(event){
        var mode = $("#mode").val("D");
        var cldocno = $('#txtcldocno').val();
        
        if(cldocno==''){
             $.messager.alert('Message','Choose a Client.','warning');
             return 0;
         }
            
        $.messager.confirm('Message', 'Do you want to delete?', function(r){
                
            if(r==false)
              {
                return false; 
              }
            else{
                $('#txtdescription').val('');
                $('#txtdescriptions').val('');
                var description = 0;
                 saveGridData(description,cldocno,mode);    
            }
         });
    }
    
    function saveGridData(description,cldocno,mode){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                var items=x.responseText;

                $.messager.alert('Message', 'Successfully Completed. ', function(r){
              });
          funreload(event); 
      }
        }
            
    x.open("GET","saveData.jsp?description="+description+"&cldocno="+cldocno+"&mode="+mode,true);
    x.send();
    }
    
    function funAttachButton(){
        if (($("#mode").val() == "view") && $("#txtcldocno").val()!="") {
            $("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
        
            changeAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);       
        } else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
    
    function funReadOnly(){
        $('#frmClientReview input').attr('readonly', true );
        $("#financialCommentsGridID").jqxGrid({ disabled: true});
        //$("#nonFinancialCommentsGridID").jqxGrid({ disabled: true});
        $("#operationGridID").jqxGrid({ disabled: true});
        $("#quotationGridID").jqxGrid({ disabled: true});
        $("#accidentDamageGridID").jqxGrid({ disabled: true});
        $("#driverGridID").jqxGrid({ disabled: true});
        $("#btnbalance").hide();
    }
    
    function funRemoveReadOnly(){}
 
    function funSearchLoad(){
    /* changeContent('cpvMainSearch.jsp'); */ 
    }
    
     function funChkButton() {
        /* funReset(); */
    }
 
    function funFocus(){
        document.getElementById("txtclientname").focus();           
    }
   
  function funNotify(){ 
            return 1;
    } 
  
  
  function setValues(){
      $("#btnbalance").show();
      
      if(document.getElementById("hidchckdetailed").value==1){
          document.getElementById("chckdetailed").checked = true;
      } else if(document.getElementById("hidchckdetailed").value==0){
          document.getElementById("chckdetailed").checked = false;
      }
      
      if($('#msg').val()!=""){
          $.messager.alert('Message',$('#msg').val());
      }
      
      document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
      funSetlabel();
      
      var detailed=$('#hidchckdetailed').val();
      var accno=$('#txtaccno').val();
      if(accno != ""){
           var indexVal = document.getElementById("txtcldocno").value;
           $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+indexVal+'&detailed='+detailed);
      }
    
      var cldocno=$('#txtcldocno').val();
      if(cldocno != ""){
          $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
          $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
          $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
          $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
      }
    
      /* var cldocno=$('#txtcldocno').val();
      if(cldocno != ""){
          $("#nonFinancialCommentsDiv").load("nonFinancialCommentsGrid.jsp?cldocno="+cldocno);
      } */
    
      $('#txtdescription').attr('readonly', false);
     
    }
    
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientReview" action="saveClientReview" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Client</label>
        <div>
            <input type="text" id="txtclientname" name="txtclientname" placeholder="Press F3 to Search" onkeydown="getAcc(event);" value='<s:property value="txtclientname"/>'/>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'/>
        </div>

        <label>Account Balance</label>
        <div>
            <input type="text" id="txtbalance" name="txtbalance" style="text-align: right;" value='<s:property value="txtbalance"/>'/>
        </div>

        <label>Status</label>
        <span class="status-text" id="lblclientstatus" name="lblclientstatus"><s:property value="lblclientstatus"/></span>

        <div class="checkbox-group">
            <input type="checkbox" id="chckdetailed" name="chckdetailed" value="" onchange="funDetailed();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
            <span>Detailed</span>
            <input type="hidden" id="hidchckdetailed" name="hidchckdetailed" value='<s:property value="hidchckdetailed"/>'/>
        </div>
        
        <div style="display:flex; gap:10px;">
            <button class="myButton" type="button" id="btnbalance" name="btnbalance" onclick="funOutStandingStatement();">Outstanding</button>
            <button class="myButton" type="button" id="btnAttach" name="btnAttach" onclick="funAttachButton();">Attach</button>
        </div>
    </div>

    <div class="hidden-scrollbar">
        
        <div class="section-block-full">
            <h2>Operations</h2>
            <div id="operationDiv"><jsp:include page="operationGrid.jsp"></jsp:include></div>
        </div>
        
        <div class="section-row">
            <div class="section-block">
                <h2>Payment Follow-Up</h2>
                <div id="paymentFollowUpDiv"><jsp:include page="paymentFollowUpGrid.jsp"></jsp:include></div>
            </div>
            
            <div class="section-block">
                <h2>Description</h2>
                 <jsp:include page="description.jsp"></jsp:include>
            </div>
        </div>

        <div class="section-block-full">
             <h2>Driver Details</h2>
             <div id="driverDiv"><jsp:include page="driverDetailsGrid.jsp"></jsp:include></div>
        </div>

        <div class="section-block-full">
             <h2>Accident/Damage History</h2>
             <div id="accidentDamageDiv"><jsp:include page="accidentDamageHistoryGrid.jsp"></jsp:include></div>
        </div>

        <div class="section-block-full">
             <h2>Quotation Details</h2>
             <div id="quotationDiv"><jsp:include page="quotationGrid.jsp"></jsp:include></div>
        </div>

    </div>

<div hidden="true" id="jqxClientReviewDate" name="jqxClientReviewDate" value='<s:property value="jqxClientReviewDate"/>'></div>
<div hidden="true" id="jqxNonFinancialDate" name="jqxNonFinancialDate" value='<s:property value="jqxNonFinancialDate"/>'></div>
<input type="hidden" id="hidjqxNonFinancialDate" name="hidjqxNonFinancialDate" value='<s:property value="hidjqxNonFinancialDate"/>'/>
<input type="hidden" id="txtnonfinancialcomment" name="txtnonfinancialcomment" style="width:80%;" value='<s:property value="txtnonfinancialcomment"/>'/>
<input type="hidden" id="docno" name="txtnonfinancialdocno" value='<s:property value="txtnonfinancialdocno"/>'/>
<input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed"  value='<s:property value="idpdetailsallowed"/>'/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>

<div id="clientWindow">
    <div></div><div></div>
</div>
<div id="nonFinancialWindow">
    <div></div><div></div>
</div>  
</div>
</body>
</html>