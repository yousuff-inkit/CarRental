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
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
   HYBRID UI: Compact Input Sizing (Plain Colors) side-by-side
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
    text-align: left !important;
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
.input-full { width: 100% !important; }

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
    flex-wrap: wrap;
}

.lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    padding-right: 5px;
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
    margin-bottom: 15px;
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

.myButton {
    font-weight: 700;
    font-size: 11px;
    height: 24px !important;
    padding: 0px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.3);
}
</style>

<script type="text/javascript">
      $(document).ready(function () { 

        $('#btnEdit').click(function(){
            $("#jqxManualInvoice").jqxGrid("addrow", null, {}); 
        });
        
        /* Converted to exact 24px Master heights */
        $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"}); 
        $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});

        /* Force internal alignment AFTER render for JQX Dates */
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

           $('#date').on('change', function (event) 
                {  
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

    function funReset(){
        /* $("#invoiceDiv").load("invoiceGrid.jsp"); */
    }

    function funReadOnly(){
        $('#frmManualInvoice input').attr('readonly', true );
        $('#frmManualInvoice select').attr('disabled', true);
        $('#frmManualInvoice textarea').attr('readonly', true );
        $('#date').jqxDateTimeInput({ disabled: true});
        $("#fromdate").jqxDateTimeInput({ disabled: true});
        $("#todate").jqxDateTimeInput({ disabled: true});
    }
    
    function funRemoveReadOnly(){
         $('#Sendmail').hide();
        $('#frmManualInvoice input').attr('readonly', false );
        $('#frmManualInvoice select').attr('disabled', false);
        $('#frmManualInvoice textarea').attr('readonly', false );
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
    if($('#deleted').val()!=''){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Deleted Invoice";
    }
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
    
     function funChkButton() { }
    
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
            }
            else{
                var reurl=url.split("saveManualInvoice");
                 var win= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");      
            }
        }
        else{
            var reurl=url.split("saveManualInvoice");
             var win_voucher= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");
            win_voucher.focus(); 
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
                  url: 'invjspToPdf.action?vocno='+document.getElementById("voucherno").value+'&docno='+document.getElementById("docno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
                  secureuri:false, 
                  fileElementId:'file', 
                  dataType: 'string', 
                  success: function (data, status) 
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
</script>  
</head>

<body onload="funReadOnly();setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmManualInvoice" action="saveManualInvoice" autocomplete="off">
    <script>
            window.parent.formName.value="Invoice";
            window.parent.formCode.value="INV";
    </script>
    <jsp:include page="../../../../header.jsp" />
    
    <div style="border: 1px solid transparent; padding: 5px 0; margin-bottom:10px; display:none;">
        </div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Document Details</span>
        <div style="display: flex; gap: 20px; padding-top: 5px;">
            
            <div style="flex: 1;">
                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Agreement Type</label>
                    <select name="cmbagmttype" id="cmbagmttype" class="input-md" value='<s:property value="cmbagmttype"/>'>
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                    <input type="hidden" name="hidcmbagmttype" id="hidcmbagmttype" value='<s:property value="hidcmbagmttype"/>'>

                    <label class="lbl-right" style="width: 80px;">Agreement No</label>
                    <input type="text" name="agmtvoucherno" id="agmtvoucherno" class="input-md" value='<s:property value="agmtvoucherno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Client</label>
                    <input type="text" name="client" id="client" class="input-sm" value='<s:property value="client"/>'>
                    <input type="text" name="clientdetails" id="clientdetails" class="input-xl" value='<s:property value="clientdetails"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Driver</label>
                    <input type="text" name="driver" id="driver" class="input-sm" value='<s:property value="driver"/>'>
                    <input type="text" name="driverdetails" id="driverdetails" class="input-xl" value='<s:property value="driverdetails"/>'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Email</label>
                    <input type="text" title="E-mail" name="email" id="email" class="input-xl" value='<s:property value="email"/>'>
                </div>
            </div>

            <div style="flex: 1;">
                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Date</label>
                    <div style="width: 140px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                        <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
                    </div>

                    <label class="lbl-right" style="width: 80px;">Doc No</label>
                    <input type="text" name="voucherno" id="voucherno" class="input-md" value='<s:property value="voucherno"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Contract Vehicle</label>
                    <input type="text" name="contractvehicle" id="contractvehicle" class="input-xl" value='<s:property value="contractvehicle"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width: 100px;">Vehicle Details</label>
                    <textarea name="vehicledetails" id="vehicledetails" class="input-xl" style="height: 24px !important; padding: 2px 6px; resize: none;"><s:property value="vehicledetails"/></textarea>
                </div>
            </div>

        </div>
    </div>

    <div class="middle-panel" style="margin-bottom: 10px;">
        <span class="middle-panel-title">Invoice Details</span>
        <div style="padding-top: 5px;">
            
            <div class="field-row">
                <label class="lbl-right" style="width: 100px;">Period From</label>
                <div style="width: 140px;">
                    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                    <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'>
                </div>

                <label class="lbl-right" style="width: 80px;">Ledger Note</label>
                <input type="text" name="ledgernote" id="ledgernote" class="input-lg" value='<s:property value="ledgernote"/>'>

                <label class="lbl-right" style="width: 80px;">Period To</label>
                <div style="width: 140px;">
                    <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                    <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'>
                </div>

                <label class="lbl-right" style="width: 80px;">Invoice Note</label>
                <input type="text" name="invoicenote" id="invoicenote" class="input-lg" value='<s:property value="invoicenote"/>'>
            </div>
            
        </div>
    </div>

    <div style="margin-bottom: 20px;">
        <input type="hidden" name="acno" id="acno" value='<s:property value="acno"/>'>
        <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
        <div id="invoiceDiv">
            <jsp:include page="invoiceGrid.jsp"></jsp:include>
        </div>
    </div>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="curntvehgrn" name="curntvehgrn" value='<s:property value="curntvehgrn"/>'>
<input type="hidden" id="cntrctvehgrn" name="cntrctvehgrn" value='<s:property value="cntrctvehgrn"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
<input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="hidchkdeletedinv" id="hidchkdeletedinv" value='<s:property value="hidchkdeletedinv"/>' >

<div id="accountwindow"><div ></div></div>
<div id="agmtnowindow"><div ></div></div>

</form>
</div>
</body>
</html>