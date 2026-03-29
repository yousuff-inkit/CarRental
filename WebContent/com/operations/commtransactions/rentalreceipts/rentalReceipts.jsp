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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
   HYBRID UI: Client Master Panels + Compact Input Sizing
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
    overflow-x: hidden;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
input[type="text"], select, textarea {
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
.input-xs { width: 60px !important; }
.input-sm { width: 100px !important; }
.input-md { width: 140px !important; }
.input-lg { width: 220px !important; }
.input-xl { width: 350px !important; }

input[type="text"]:focus, select:focus, textarea:focus {
    border-color: #007bff;
    outline: none;
}

input[readonly], textarea[readonly], select:disabled, input:disabled {
    background-color: #f3f4f6;
    color: #6b7280;
}

/* Layout Utilities */
.field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
    flex-wrap: wrap; /* Allows safe wrapping on smaller screens */
}

.lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    padding-right: 5px;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Panels */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 20px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
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

.align-right-input {
    text-align: right !important;
}

.icon {
    width: 24px !important; 
    height: 24px !important;
    border: 1px solid #ccc;
    background-color: #f3f4f6 !important; 
    padding: 2px;
    border-radius: 3px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.icon img { width: 16px; height: 16px; }

</style>

<script type="text/javascript">
    $(document).ready(function() {
        
        /* Master UI 24px heights for JQX inputs (100% width inherits from parent div) */
        $("#jqxRentalReceiptDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        $("#jqxReferenceDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});      
    
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

         $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#agreementDetailsWindow').jqxWindow('close');
        
         $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#clientDetailsWindow').jqxWindow('close'); 
        
         $('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#cardDetailsWindow').jqxWindow('close');
        
         $('#jqxRentalReceiptDate').on('change', function (event) {
                 var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
                 var validdate=funDateInPeriod(rentalreceiptdate);
                 if(parseInt(validdate)==0){
                    document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
                    return 0;   
                 }
             });
        
         $('#txtagreementvocher').dblclick(function(){
              agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtcldocno').val());
              });
        
          $('#txtclientid').dblclick(function(){
              var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
              $("#maindate").jqxDateTimeInput('val', date);
              clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
              $('#txtforsearch').val(1);
              });
              
         $('#txtreceivedfrom').keydown(function (evt) {
              if (evt.keyCode==9) {
                  event.preventDefault();
                  $('#jqxApplyInvoice').jqxGrid('selectcell',0, 'applying');
                  $('#jqxApplyInvoice').jqxGrid('focus',0, 'applying');
              }
         });
    });
    
    function agreementSearchContent(url) {
        $('#agreementDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#agreementDetailsWindow').jqxWindow('setContent', data);
        $('#agreementDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function clientSearchContent(url) {
        $('#clientDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function cardSearchContent(url) {
        $('#cardDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#cardDetailsWindow').jqxWindow('setContent', data);
        $('#cardDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function checkIb(){
         if(document.getElementById("hidchckib").value==1){
             document.getElementById("chckib").checked = true;
         }
         else if(document.getElementById("hidchckib").value==0){
            document.getElementById("chckib").checked = false;
          }
         }
    
     function funReadOnly(){
            $('#frmRentalReceipt input').attr('readonly', true );
            $('#frmRentalReceipt select').attr('disabled', true);
            $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: true});
            $('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
            $('#btnCardSearch').attr('disabled', true);
            $("#jqxApplyInvoice").jqxGrid({ disabled: true});
            
     }
     function funRemoveReadOnly(){
            getBranch();getCardTypes();checkIb();getConfig();getPayTypes();
            $('#frmRentalReceipt input').attr('readonly', false );
            $('#frmRentalReceipt select').attr('disabled', false);
            
            $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
            $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
            $('#btnCardSearch').attr('disabled', true);
            $('#docno').attr('readonly', true);
            $('#txtdoctype').attr('readonly', true);
            $('#txtsrno').attr('readonly', true);
            $('#txtaccid').attr('readonly', true);
            $('#txtaccname').attr('readonly', true);
            $('#txtclientid').attr('readonly', true);
            $('#txtamounts').attr('readonly', true);
            $('#txtclientname').attr('readonly', true);
            $('#txtagreementvocher').attr('readonly', true);
            $('#txtnetvalue').attr('readonly', true ); 
            $('#txtapplyinvoiceamt').attr('readonly', true );
            $('#txtapplyinvoiceapply').attr('readonly', true );
            $('#txtapplyinvoicebalance').attr('readonly', true );
            $('#cmbbranch').attr('disabled', true);
            $("#jqxApplyInvoice").jqxGrid({ disabled: false}); 
            
            if ($("#mode").val() == "E") {
                if($('#chkstatus').val()=="2"){
                    $('#cmbpaytype').attr('disabled', true);
                    $('#chckib').attr('disabled', true);
                    $('#cmbbranch').attr('disabled', true);
                    $('#txtaccid').attr('readonly', true);
                    $('#txtaccname').attr('readonly', true);
                }else{
                    $('#cmbpaytype').attr('disabled', true);
                    $('#chckib').attr('disabled', true);
                    $('#cmbbranch').attr('disabled', true);
                    $('#txtaccid').attr('readonly', true);
                    $('#txtaccname').attr('readonly', true);
                }
                funchequedate();
              }
            
            if ($("#mode").val() == "A") {
                if($('#chkstatus').val()=="1"){
                    funchequedate();
                }else{
                    $('#cmbpaytype').val('');$('#cmbcardtype').val('');$('#cmbpayedas').val('');$('#cmbratype').val('');
                    $('#jqxRentalReceiptDate').val(new Date());
                    $("#jqxApplyInvoice").jqxGrid('clear');
                    $("#jqxApplyInvoice").jqxGrid('addrow', null, {});
                }
            }
     }
    
     function funSearchLoad(){
        changeContent('rrvMainSearch.jsp'); 
     }
        
     function funChkButton() { }
    
     function funFocus()
    {
        $('#jqxRentalReceiptDate').jqxDateTimeInput('focus');           
    }
    
     /* Validations */
        $(function(){
            $('#frmRentalReceipt').validate({
                rules: {
                txtamount:{number:true},
                txtdiscount:{number:true},
                txtaddcharges:{number:true},
                txtdescription:{maxlength:500},
                txtdescriptions:{maxlength:500},
                cmbpayedas:"required"
                 },
                 messages: {
                 txtamount:{number:"Invalid"},
                 txtdiscount:{number:"Invalid"},
                 txtaddcharges:{number:"Invalid"},
                 txtdescription: {maxlength:"    Max 500 chars"},
                 txtdescriptions: {maxlength:"    Max 500 chars"},
                 cmbpayedas:"*"
                 }
        });}); 
       
      function funNotify(){ 
          /* Validation */
          var config=document.getElementById("txtconfigchk").value;
        var  paytype=document.getElementById("cmbpaytype").value;
             if(paytype==""){
                 document.getElementById("errormsg").innerText="Please select pay type... ";
                 return 0;
             }
          
            var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(rentalreceiptdate);
             if(parseInt(validdate)==0){
                document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
                return 0;   
             }
            
            backdatevalid=document.getElementById("txtbackdatevalidation").value;
             if(backdatevalid==1){
                 document.getElementById("errormsg").innerText="Past Date, Transaction Restricted.";
                 return 0;
             }
            
            ibvalid=document.getElementById("txtibvalidation").value;
             if(ibvalid==1){
                 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
                 return 0;
             }
            
             valid=document.getElementById("txtvalidation").value;
             if(valid==1){
                 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
                 return 0;
             }
            
             if($('#txtcldocno').val()==''){
                 document.getElementById("errormsg").innerText="Client is Mandatory.";
                 return 0;
             }
            
             if($('#cmbpaytype').val()=='2' && $('#cmbcardtype').val()==''){
                 document.getElementById("errormsg").innerText="Choose a Card Type.";
                 return 0;
             }
            if($('#txtconfigchk').val().trim()=="1")
                {
             if($('#cmbpaytype').val()=='3' && $('#cmbsubchq').val()==null){
                 document.getElementById("errormsg").innerText="Choose a  Type.";
                 return 0;
             }
                }
            var cardnumbervalidator = window.parent.cardnumbervalidator.value;
            if($("#cmbpaytype").val()=='2'){
                if(cardnumbervalidator.trim()=="1"){
                    cardnumber($("#txtrefno").val());
                    if($("#txtheadercardnumbervalidrestrict").val()=='1'){  
                         document.getElementById("errormsg").innerText="Invalid Card Number.";
                         return 0;
                     }
                }
             }
            
             var netvalue = document.getElementById("txtnetvalue").value;
             if(netvalue=="" || netvalue=="NaN" || netvalue==0 || netvalue==0.0 || netvalue==0.00){
                 document.getElementById("errormsg").innerText="Invalid Transaction !!! Net Value should not be Zero.";
                  return 0;
            }
            if($('#cmbpayedas').val()=='3' && ($('#cmbratype').val()=='' || $('#txtagreementvocher').val()=='')){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Agreement is mandatory for Security";
                return 0;
            }
        document.getElementById("errormsg").innerText="";
            
        /* Validation Ends*/
        
                /* Apply Invoice Grid Saving */
                var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
                var length=0;
                 for(var i=0 ; i < rows.length ; i++){
                    var chk=rows[i].applying;
                    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "txtapply"+length)
                        .attr("name", "txtapply"+length)
                        .attr("hidden", "true");
                        length=length+1;
                        
                    newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
                    newTextBox.appendTo('form');
                    }
                  }
                $('#applylength').val(length);
                 /* Apply Invoice Grid Saving Ends*/
                
                 /* Apply Invoice Grid Updating */
                    var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
                    var lengthupdate=0;
                     for(var i=0 ; i < rows.length ; i++){
                        var chks=rows[i].applying;
                        if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
                            
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "txtapplyupdate"+lengthupdate)
                            .attr("name", "txtapplyupdate"+lengthupdate)
                            .attr("hidden", "true");
                            lengthupdate=lengthupdate+1;
                            
                        newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
                        newTextBox.appendTo('form');
                        }
                       }
                    $('#applylengthupdate').val(lengthupdate);
                     /* Apply Invoice Grid Updating Ends*/
                    
                     $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
                     $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
                     $('#cmbpaytype').attr('disabled', false);
                     $('#chckib').attr('disabled', false);
                     $('#cmbbranch').attr('disabled', false);
                    
            return 1;
        } 
  
      function setValues(){
          getBranch();getCardTypes();checkIb();getPayTypes();
          
          document.getElementById("cmbpaytype").value=document.getElementById("hidcmbpaytype").value;
          document.getElementById("cmbratype").value=document.getElementById("hidcmbratype").value;
          document.getElementById("cmbpayedas").value=document.getElementById("hidcmbpayedas").value;
          document.getElementById("cmbcardtype").value=document.getElementById("hidcmbcardtype").value;
          document.getElementById("cmbsubchq").value=document.getElementById("hidcmbsubchq").value;

          if($('#chkstatus').val()=="1" || $('#chkstatus').val()=="2"){
                funchequedate();
            }

          if($('#hidjqxRentalReceiptDate').val()){
                 $("#jqxRentalReceiptDate").jqxDateTimeInput('val', $('#hidjqxRentalReceiptDate').val());
              }
          
          if($('#hidjqxReferenceDate').val()){
                 $("#jqxReferenceDate").jqxDateTimeInput('val', $('#hidjqxReferenceDate').val());
              }
          
           if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
           
           document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
           funSetlabel();
        
             var indexVal1 = document.getElementById("txtacno").value;
             var indexVal2 = document.getElementById("txttranno").value;
             if(indexVal2>0){
                 Setedit();  
             }  
             if(indexVal1>0){
             $("#applyInvoicing1").load("applyInvoiceGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2); 
             } 
        }
    
      function getConfig(){
          
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim().split('####');
                    $("#txtconfigchk").val(items[0]);
                  $("#txtdiscountconfig").val(items[1]);
                    if($("#txtconfigchk").val()=="1"){
                        
                     } else {
                         $("#subchq_wrap").hide();
                     }
                    
                    if($("#txtdiscountconfig").val()=="1")
                    {
                          $("#discount_wrap").hide();
                        $("#addcharges_wrap").hide();
                    }else {
                         $("#discount_wrap").show();
                        $("#addcharges_wrap").show();
                    }
                    }
            }
            x.open("GET", "getConfig.jsp", true);
            x.send();
        }
  
    function getBranch() {   
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var branchIdItems  = items[0].split(",");
                var branchItems = items[1].split(",");
                var optionsbranch = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#cmbbranch").html(optionsbranch);
                if ($('#hidcmbbranch').val() != null) {
                    $('#cmbbranch').val($('#hidcmbbranch').val());
                }
            } else {
            }
        }
        x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
        x.send();
    }
    
     function getAccounts(a){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var accountIdItems  = items[0];
                    var accountItems = items[1];
                    var docNoItems = items[2];
                $('#txtaccid').val(accountIdItems) ;
                $('#txtaccname').val(accountItems) ;
                $('#txtdocno').val(docNoItems) ;
            }
            }
            x.open("GET", "getAccounts.jsp?paytype="+a, true);
            x.send();
     }
    
     function getCardTypes() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var cardIdItems  = items[0].split(",");
                    var cardItems = items[1].split(",");
                    var optionscard = '<option value="">--Select--</option>';
                    for (var i = 0; i < cardItems.length; i++) {
                        optionscard += '<option value="' + cardIdItems[i].trim() + '">'
                                + cardItems[i] + '</option>';
                    }
                    $("select#cmbcardtype").html(optionscard);
                    if ($('#hidcmbcardtype').val() != null) {
                        $('#cmbcardtype').val($('#hidcmbcardtype').val());
                    }
                } else {
                }
            }
            x.open("GET", "getCardTypes.jsp", true);
            x.send();
      }
    
     function getPayTypes() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var cardIdItems  = items[0].split(",");
                    var cardItems = items[1].split(",");
                    var optionscard = '<option value="">--Select--</option>';
                    for (var i = 0; i < cardItems.length; i++) {
                        optionscard += '<option value="' + cardIdItems[i].trim() + '">'
                                + cardItems[i] + '</option>';
                    }
                    $("select#cmbpaytype").html(optionscard);
                    if ($('#hidcmbpaytype').val() != null) {
                        $('#cmbpaytype').val($('#hidcmbpaytype').val());
                    }
                } else {
                }
            }
            x.open("GET", "getPayTypes.jsp", true);
            x.send();
      }
    
    function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
            agreementSearchContent('agreementSearch.jsp');
        }
       }
    
    function funCardSearch(){
        cardSearchContent('cardDetailsSearchGrid.jsp?clientId='+$('#txtcldocno').val());
    }
       
    function getClient(event){
        var x= event.keyCode;
        if(x==114){
            var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
            $("#maindate").jqxDateTimeInput('val', date);
            clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
             $('#txtforsearch').val(1);
        }
       }
    
    function funclearchequecardno(){
        $('#txtrefno').val('');
    }
    
    function applyDisable(){
        payed=document.getElementById("cmbpayedas").value;
        if(payed==2 || payed==3){
        $('#cmbratype').attr('disabled', false );
        $('#txtagreementvocher').attr('disabled', false);
        $("#jqxApplyInvoice").jqxGrid({ disabled: true});
        }
        else{
            $('#cmbratype').val('');$('#txtagreementvocher').val('');
            $('#cmbratype').attr('disabled', true );
            $('#txtagreementvocher').attr('disabled', true);
            $("#jqxApplyInvoice").jqxGrid({ disabled: false});
        }
    }
    
    function funCheck(a){
          if(document.getElementById("chckib").checked != false){
                 $('#hidchckib').val(1);
                 $('#cmbbranch').attr('disabled', false );
          }
          else{
              $('#hidchckib').val(0); 
              $('#cmbbranch').attr('disabled', true );
          }
      }
      
    function funcardvalidation(){
         var card = window.parent.cardnumbervalidator.value;
         if($("#cmbpaytype").val()=='2'){
            if(card.trim()=="1"){
                cardnumber($("#txtrefno").val());
            }else{
                document.getElementById("errormsg").innerText="";
            }
         }
    }
    
    function funchequedate(){
          paytype=document.getElementById("cmbpaytype").value;
          if(paytype==3){
              var chequedate = $('#jqxReferenceDate').jqxDateTimeInput('getDate');
              var chequeDates =new Date(chequedate).setDate(chequedate.getDate());   
              $('#jqxReferenceDate').jqxDateTimeInput('setDate', new Date(chequeDates)); 
              $('#cmbcardtype').attr('disabled', true);
              $('#txtrefno').attr('readonly', false);
              $('#btnCardSearch').attr('disabled', true);
              $('#cmbsubchq').attr('disabled', false);

          }
          else if(paytype==1){
              $('#cmbcardtype').attr('disabled', true); 
              $('#txtrefno').attr('readonly', true);
              $('#btnCardSearch').attr('disabled', true);
              $('#cmbsubchq').attr('disabled', true);
              
          }
          else if(paytype==2){
              $('#cmbcardtype').attr('disabled', false); 
              $('#txtrefno').attr('readonly', false);
              $('#btnCardSearch').attr('disabled', false);
              $('#cmbsubchq').attr('disabled', true);

          }
    }
    
    function funPaymentAmount(txtamount) {
        if (parseFloat($("#txtapplyinvoiceapply").val())>0) {
            if(parseFloat(txtamount.value)<parseFloat(txtamount.oldvalue)){
                $("#txtamount").val(txtamount.oldvalue);
                $.messager.alert('Message','Applied for '+txtamount.oldvalue+'/-, Remove applied & then change the Payment Amount.','warning');
                return;
            }
        }
      }
    
    function getNetValue(){
        var amount = $('#txtamount').val();
        var discount = $('#txtdiscount').val();
        var additional = $('#txtaddcharges').val();
        var additionalamt = $('#txtamt').val();
        var netamount=$('#txtnetvalue').val();
        
        if(amount==''){    
            amount=0;
        }
        
        if(discount==''){
            discount=0;
        }
        
        if(additional==''){
            additional=0;
        }
        
        if(additionalamt==''){
            additionalamt=0;
        }
        
        if(amount!=''){
            netamount=(parseFloat(amount));
        }
        
        if(discount!=''){
            netamount=((parseFloat(amount)-parseFloat(discount)));
        }
        
        if(additional!="" && additional!="0"){
            var chkaddamt=((parseFloat(amount)-parseFloat(discount))*(parseFloat(additional)/100));
            $('#txtamt').val(Math.round(parseFloat(chkaddamt)*100)/100);
            netamount=((parseFloat(amount)-parseFloat(discount))) + chkaddamt;
            $('#txtnetvalue').val(Math.round(netamount*100)/100);
        }
     
        if(additionalamt!="" && additionalamt!="0"){
            var addchgper = (additionalamt*100)/(parseFloat(amount)-parseFloat(discount));
            $('#txtaddcharges').val(Math.round(parseFloat(addchgper)*100)/100);
            netamount=((parseFloat(amount)-parseFloat(discount))+parseFloat(additionalamt));
        }   
        
        funRoundAmt((Math.round(netamount*100)/100),"txtnetvalue");
  }
    
    function getAmount(){
          var amount = $('#txtamount').val();
          if(!isNaN(amount)){
          $('#txtapplyinvoiceamt').val(amount);
          }
          else if(isNaN(amount)){
              $('#txtapplyinvoiceamt').val(0.00);
              $('#txtamount').val(0.00);
            }
      }
    
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#txtsrno").val()!="") {
            var url=document.URL;
            var reurl=url.split("saveRentalReceipt");
            $("#txtsrno").prop("disabled", false);                
         
            var win= window.open(reurl[0]+"printRentalReceipt?srno="+document.getElementById("txtsrno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
         }
        else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
    
    function datechange(){
          var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
          var validdate=funDateInPeriod(date);
             if(parseInt(validdate)==0){
                document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
                return 0;   
             }
            var validbackdate=funBackDate(date);
            if(validbackdate==0){
            return 0;   
            }
          $("#maindate").jqxDateTimeInput('val', date);
          
          if($('#hidchckib').val()==1){
              if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
                funIBDateInPeriod($('#jqxRentalReceiptDate').val(),$('#cmbbranch').val());
              }
            }
      }

function funSendmail() {
         if (($("#mode").val() == "view") && $("#docno").val()!="") {
          
        if(document.getElementById("email").value=="")
            {
            document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
            return 0;
            }
        
        $("#overlay, #PleaseWait").show();
        sample();
        
         var recipient1=document.getElementById("email").value; 
        var recipient=recipient1.replace(/ /g, "%20");
         }
        else {
             $.messager.alert('Message','Select a Document....!','warning');
             return false;
             }
    }
 
    function sample() {  
        var formcode=document.getElementById("formdetailcode").value;
        var recep=document.getElementById("email").value.trim();
        var branch=<%=session.getAttribute("BRANCHID").toString()%>;
        
        $.ajaxFileUpload({  
                  url: 'rrjspToPdf.action?docno='+document.getElementById("txtsrno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
                  secureuri:false,//false  
                  fileElementId:'file', //id  <input type="file" id="file" name="file" />  
                  dataType: 'string',// json  
                  success: function (data, status)  //  
                  {  
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
                      if(typeof(data.error) != 'undefined')  
                      {  
                          if(data.error != '')  
                          {  
                              alert(data.error);  
                          }else  
                          {  
                              alert(data.message);  
                          }  
                      }  
                  },  
                   error: function (data, status, e)
                  {  
                      alert(e);  
                  }  
              }); 
          return false;
      }

     function Setedit(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();  
                    if(parseInt(items)>0) {
                         $("#btnEdit").attr('disabled', true );
                         $("#btnDelete").attr('disabled', true );     
                    }
                } 
            }
            x.open("GET", "getConfrmEdit.jsp?txttranno="+$('#txttranno').val(), true);
            x.send();
        }
  
</script>
</head>

<body onload="setValues();getBranch();getCardTypes();getConfig();getPayTypes();" onmouseover="Setedit();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalReceipt" action="saveRentalReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div style="border: 1px solid transparent; padding: 5px 0;">
        <div class="field-row" style="margin-bottom: 15px;">
            <label class="lbl-right" style="width: 50px;">Date</label>
            <div style="width: 110px;">
                <div id="jqxRentalReceiptDate" name="jqxRentalReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxRentalReceiptDate"/>'></div>
                <input type="hidden" id="hidjqxRentalReceiptDate" name="hidjqxRentalReceiptDate" value='<s:property value="hidjqxRentalReceiptDate"/>'/>
            </div>

            <label class="lbl-right" style="width: 70px;">Doc Type</label>
            <input type="text" id="txtdoctype" name="txtdoctype" class="input-sm" value='<s:property value="txtdoctype"/>' tabindex="-1" readonly/>

            <label class="lbl-right" style="width: 60px;">Doc No.</label>
            <input type="text" id="docno" name="txtrentalreceiptdocno" class="input-md" value='<s:property value="txtrentalreceiptdocno"/>' tabindex="-1" readonly/>

            <div style="margin-left: auto; display: flex; align-items: center; gap: 8px; padding-right: 10px;">
                <label class="lbl-right">Receipt No.</label>
                <input type="text" id="txtsrno" name="txtsrno" class="input-md" value='<s:property value="txtsrno"/>' tabindex="-1" readonly/>
            </div>
        </div>
    </div>

    <div class="middle-section">
        
        <div class="middle-panel" style="flex: 1.2;">
            <span class="middle-panel-title">Client & Agreement Details</span>
            <div style="padding-top: 5px;">
                
                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">IB</label>
                    <label class="chk-container input-sm">
                        <input type="checkbox" id="chckib" name="chckib" onclick="funCheck();">
                        Inter-Branch
                    </label>
                    
                    <label class="lbl-right" style="width: 60px;">Branch</label>
                    <select id="cmbbranch" name="cmbbranch" class="input-lg" onchange="funIBDateInPeriod($('#jqxRentalReceiptDate').val(),this.value);" value='<s:property value="cmbbranch"/>'>
                        <option value="">--Select--</option>
                    </select>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Client</label>
                    <input type="text" id="txtclientid" name="txtclientid" class="input-md" placeholder="Press F3 to Search" value='<s:property value="txtclientid"/>' onkeydown="getClient(event);"/>
                    <input type="text" id="txtclientname" name="txtclientname" class="input-lg" value='<s:property value="txtclientname"/>' readonly/>
                    
                    <label class="lbl-right" style="width: 50px;">Email</label>
                    <input type="text" id="email" name="email" class="input-md" placeholder="Email" value='<s:property value="email"/>' readonly/>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Paid As</label>
                    <select id="cmbpayedas" name="cmbpayedas" class="input-md" value='<s:property value="cmbpayedas"/>' onchange="applyDisable();">
                        <option value="1">On Account</option><option value="2">Advance</option><option value="3">Security</option>
                    </select>

                    <label class="lbl-right" style="width: 70px;">Agreement</label>
                    <select id="cmbratype" name="cmbratype" class="input-sm" value='<s:property value="cmbratype"/>'>
                        <option value="RAG">Rental</option><option value="LAG">Lease</option>
                    </select>
                    <input type="text" id="txtagreementvocher" name="txtagreementvocher" class="input-md" placeholder="Press F3 to Search" value='<s:property value="txtagreementvocher"/>' onkeydown="getAgreement(event);"/>
                </div>

            </div>
        </div>

        <div class="middle-panel" style="flex: 1;">
            <span class="middle-panel-title">Payment Details</span>
            <div style="padding-top: 5px;">
                
                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Pay Type</label>
                    <select id="cmbpaytype" name="cmbpaytype" class="input-md" value='<s:property value="cmbpaytype"/>' onchange="funchequedate();getAccounts(this.value);">
                        <option value="">--Select--</option>
                        <option value="1">Cash</option><option value="2">Card</option><option value="3">Cheque/Online</option>
                    </select>
                    
                    <div id="subchq_wrap" style="display: contents;">
                        <label class="lbl-right" style="width: 60px;">Sub Chq</label>
                        <select id="cmbsubchq" name="cmbsubchq" class="input-sm" value='<s:property value="cmbsubchq"/>' onchange="funchequedate();">
                            <option value="1">Uber</option><option value="2">Careem</option><option value="3">Voucher</option>
                        </select>
                    </div>

                    <label class="lbl-right" style="width: 60px;">Account</label>
                    <input type="text" id="txtaccid" name="txtaccid" class="input-xs" value='<s:property value="txtaccid"/>' tabindex="-1" readonly/>
                    <input type="text" id="txtaccname" name="txtaccname" class="input-lg" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
                </div>

                <div class="field-row">
                    <div style="width: 80px; display: flex; align-items: center; justify-content: flex-end; gap: 5px;">
                        <button type="button" class="icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
                            <img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png">
                        </button>
                        <label class="lbl-right" style="padding-right:0;">Card Type</label>
                    </div>
                    <select id="cmbcardtype" name="cmbcardtype" class="input-md" onchange="funclearchequecardno();" value='<s:property value="cmbcardtype"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label class="lbl-right" style="width: 90px;">Chq/Card/Onl</label>
                    <input type="text" id="txtrefno" name="txtrefno" class="input-md" onchange="funcardvalidation();" value='<s:property value="txtrefno"/>'/>

                    <label class="lbl-right" style="width: 40px;">Date</label>
                    <div style="width: 110px;">
                        <div id="jqxReferenceDate" name="jqxReferenceDate" value='<s:property value="jqxReferenceDate"/>'></div>
                        <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/>
                    </div>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Description</label>
                    <input type="text" id="txtdescription" name="txtdescription" class="input-xl" value='<s:property value="txtdescription"/>'/>
                </div>

            </div>
        </div>

    </div>

    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Amount Details</span>
        <div style="padding-top: 5px;">
            
            <div class="field-row">
                <label class="lbl-right" style="width: 80px;">Amount</label>
                <input type="text" id="txtamount" name="txtamount" class="input-md align-right-input" value='<s:property value="txtamount"/>' 
                       onblur="funRoundAmt(this.value,this.id);getNetValue();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" />

                <div id="discount_wrap" style="display: contents;">
                    <label class="lbl-right" style="width: 80px;">Discount</label>
                    <input type="text" id="txtdiscount" name="txtdiscount" class="input-md align-right-input" value='<s:property value="txtdiscount"/>' 
                           onblur="funRoundAmt(this.value,this.id);getNetValue();"/>
                </div>

                <div id="addcharges_wrap" style="display: contents;">
                    <label class="lbl-right" style="width: 100px;">Add. Chg %</label>
                    <input type="text" id="txtaddcharges" name="txtaddcharges" class="input-sm align-right-input" value='<s:property value="txtaddcharges"/>' 
                           onblur="funRoundAmt(this.value,this.id);getNetValue();"/>
                    
                    <label class="lbl-right" style="width: 40px;">Amt</label>
                    <input type="text" id="txtamt" name="txtamounts" class="input-sm align-right-input" value='<s:property value="txtamounts"/>' 
                           onblur="funRoundAmt(this.value,this.id);getNetValue();" />
                </div>

                <label class="lbl-right" style="width: 70px;">Net Value</label>
                <input type="text" id="txtnetvalue" name="txtnetvalue" class="input-md align-right-input" value='<s:property value="txtnetvalue"/>' tabindex="-1" readonly/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width: 80px;">Description</label>
                <input type="text" id="txtdescriptions" name="txtdescriptions" class="input-xl" value='<s:property value="txtdescriptions"/>'/>

                <label class="lbl-right" style="width: 90px;">Received From</label>
                <input type="text" id="txtreceivedfrom" name="txtreceivedfrom" class="input-lg" value='<s:property value="txtreceivedfrom"/>'/>
            </div>

        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Apply Invoices</span>
        <div style="padding-top: 5px;">
            <div id="applyInvoicing1" style="min-height: 100px; margin-bottom: 10px;"><jsp:include page="applyInvoiceGrid.jsp"></jsp:include></div>

            <div class="field-row" style="margin-top: 10px;">
                <label class="lbl-right" style="width: 80px;">Amount</label>
                <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" class="input-md align-right-input" value='<s:property value="txtapplyinvoiceamt"/>' readonly/>

                <label class="lbl-right" style="width: 80px; margin-left: 20px;">Applied</label>
                <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" class="input-md align-right-input" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly/>

                <label class="lbl-right" style="width: 80px; margin-left: 20px;">Balance</label>
                <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" class="input-md align-right-input" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly/>
            </div>
        </div>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
    <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
    <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    <input type="hidden" id="txtbackdatevalidation" name="txtbackdatevalidation" value='<s:property value="txtbackdatevalidation"/>'/>
    <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
    <input type="hidden" id="applylength" name="applylength"/>
    <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
    <input type="hidden" id="txtconfigchk" name="txtconfigchk" value='<s:property value="txtconfigchk"/>'/>
    <input type="hidden" id="configchk" name="configchk" value='<s:property value="configchk"/>'/>
    <input type="hidden" id="txtdiscountconfig" name="txtdiscountconfig" value='<s:property value="discountconfig"/>'/>
    
    <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/>
    <input type="hidden" id="hidcmbsubchq" name="hidcmbsubchq" value='<s:property value="hidcmbsubchq"/>'/>
    <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/>
    
    <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
    <input type="hidden" id="hidcmbpayedas" name="hidcmbpayedas" value='<s:property value="hidcmbpayedas"/>'/>
    <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
    <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
    <input type="hidden" id="txtagreement" name="txtagreement" value='<s:property value="txtagreement"/>'/>
    
</form>

<div id="agreementDetailsWindow"><div></div><div></div></div> 
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="cardDetailsWindow"><div></div><div></div></div> 

</div>
</body>
</html>