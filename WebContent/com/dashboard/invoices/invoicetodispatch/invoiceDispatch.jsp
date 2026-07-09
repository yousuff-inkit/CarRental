<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    
    <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

    <style type="text/css">
    /* ===== MASTER LAYOUT (Modern Flexbox) ===== */
    html, body, #mainBG {
        height: 100%;
        margin: 0;
        overflow: hidden;
        background-color: #f4f7f9;
    }

    .master-container {
        display: flex;
        width: 100%;
        height: 100vh;
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    }

    /* ===== LEFT SIDEBAR ===== */
    .sidebar-filters {
        width: 280px;
        flex: 0 0 280px; 
        background: #fff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        height: 100%;
        box-shadow: 2px 0 8px rgba(0,0,0,.05);
        z-index: 10;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 15px 25px;
    }

    /* Cards */
    .filter-card {
        background: #f8fafc;
        border: 1px solid #e3e8ee;
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 12px;
    }

    /* Tables inside Cards */
    .dispatch-filter-table {
        width: 100%;
        border-spacing: 0 10px;
    }

    .dispatch-filter-table .label-cell {
        text-align: right;
        padding-right: 10px;
        font-size: 12px;
        color: #4e5e71;
        font-weight: 600;
        width: 70px;
    }

    /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
    input[type="text"], select, textarea,
    .dispatch-filter-table input[type="text"],
    .dispatch-filter-table select {
        width: 100%;
        height: 24px !important;              
        padding: 2px 8px !important;          
        border: 1px solid #ccd6e0 !important;
        border-radius: 4px !important;        
        font-size: 12px !important;          
        background-color: #ffffff;
        box-sizing: border-box;
        color: #333;
        outline: none;
    }

    select {
        padding: 2px 24px 2px 8px !important; 
        font-family: inherit;
        cursor: pointer;
        appearance: none;
        -webkit-appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 6px center;
        background-size: 12px;
    }

    textarea#clienthtml {
        height: 50px !important;
        resize: vertical;
    }

    /* Readonly / disabled look */
    input[readonly], input:disabled, 
    .dispatch-filter-table input[readonly], 
    .dispatch-filter-table input:disabled {
        background-color: #f3f6f9 !important;
        color: #555;
        border-color: #e1e8ed !important;
        cursor: default;
    }

    /* jqx date/time containers */
    #fromdate, #todate {
        width: 100%;
    }

    /* Mail type group styling */
    .mail-type-group {
        display: flex;
        align-items: center;
        gap: 6px;
        flex-wrap: wrap;
        font-size: 12px;
        color: #4e5e71;
        font-weight: 600;
    }
    
    .mail-type-group input[type="radio"] {
        margin: 0;
        cursor: pointer;
        width: 13px;
        height: 13px;
        vertical-align: middle;
    }

    .mail-type-group label {
        cursor: pointer;
        margin-right: 4px;
    }

    /* ===== BUTTONS ===== */
    .dispatch-actions {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
        margin-top: 15px;
    }

    .btn-submit, .btn-whatsapp, .btn-wa-direct {
        height: 30px !important;            
        border: none !important;
        border-radius: 4px !important;      
        font-size: 12px !important;
        font-weight: 600 !important;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        box-sizing: border-box;
        padding: 0 10px !important;
        color: #fff !important;
        transition: background 0.2s;
        white-space: nowrap;
    }

    .btn-submit { background: #2563eb !important; }
    .btn-submit:hover { background: #1d4ed8 !important; }
    
    .btn-whatsapp { background: #25D366 !important; }
    .btn-whatsapp:hover { background: #1ebe5d !important; }
    
    .btn-wa-direct { background: #128C7E !important; }
    .btn-wa-direct:hover { background: #0e7268 !important; }

    .dispatch-actions button:last-child {
        grid-column: span 2;
    }

    /* ===== RIGHT CONTENT AREA ===== */
    .main-content-area {
        flex: 1;
        display: flex;
        flex-direction: column;
        background: #ffffff;
        height: 100%;
        overflow: hidden;
    }

    .top-toolbar-container {
        width: 100%;
        padding: 10px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e1e8ed;
        box-sizing: border-box;
    }

    .grid-content-container {
        flex: 1;
        padding: 15px;
        overflow: auto;
        box-sizing: border-box;
        position: relative;
    }

    /* Loader Positioning */
    #PleaseWait {
        position: absolute !important;
        z-index: 1002;
        top: 50% !important;
        left: 50% !important;
        transform: translate(-50%, -50%);
    }

    /* ===== WHATSAPP MODAL ===== */
    #waDirectModal {
        display: none;
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0,0,0,0.52);
        z-index: 9999;
        align-items: center;
        justify-content: center;
    }

    #waDirectModal.open { display: flex; }

    .wa-modal-box {
        background: #fff;
        border-radius: 12px;
        padding: 24px;
        width: 350px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.22);
    }

    .wa-modal-title {
        font-size: 16px;
        font-weight: 700;
        color: #128C7E;
        margin-bottom: 14px;
    }

    .wa-modal-box input[type="text"] {
        width: 100%;
        padding: 9px 12px !important;
        border: 1px solid #ccd6e0 !important;
        border-radius: 6px !important;
        font-size: 14px !important;
        margin-bottom: 5px;
        height: auto !important;
    }

    .wa-modal-hint {
        font-size: 11px;
        color: #888;
        margin-bottom: 10px;
    }

    .wa-modal-preview {
        width: 100%;
        height: 130px !important;
        font-size: 12px !important;
        border: 1px solid #ccd6e0 !important;
        border-radius: 6px !important;
        padding: 8px !important;
        margin-bottom: 14px;
        resize: none;
        background: #f8fafc;
        color: #333;
        font-family: monospace;
    }

    .wa-modal-actions { display: flex; gap: 8px; }
    .wa-modal-actions button {
        flex: 1; padding: 10px; border: none;
        border-radius: 6px; font-size: 13px;
        font-weight: 600; cursor: pointer;
    }

    .wa-send-btn { background: #25D366; color: #fff; }
    .wa-send-btn:hover { background: #1ebe5d; }
    .wa-cancel-btn { background: #f0f4f8; color: #4e5e71; }
    .wa-cancel-btn:hover { background: #e1e8ed; }
    </style>

    <script type="text/javascript">
    $(document).ready(function () {
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../../../icons/31load.gif'/></div>"); 
        $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

        $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
        $('#clientDetailsWindow').jqxWindow('close');
        
        $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#agreementDetailsWindow').jqxWindow('close');
        
        var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
        
        $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
        getInitData();
        
        $('#todate').on('change', function (event) {
            var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
            if(fromdates>todates){
                $.messager.alert('Message','To Date Less Than From Date','warning');   
                return false;
            }   
        });
        
        $('#txtclientname').dblclick(function(){
            clientSearchContent('clientDetailsSearchGrid.jsp');
        });
        
        $('#agmtvocno').dblclick(function(){
            agreementSearchContent('agreementDetailsSearch.jsp'); 
        });
    });

    function getInitData(){
        $.get('getInitData.jsp',function(data){
            data=JSON.parse(data);
            var htmldata='<option value="">--Select--</option>';
            $.each(data.catdata,function(index,value){
                htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
            });
            $('#cmbcategory').html($.parseHTML(htmldata));
        });
    }

    function clientSearchContent(url) {
        $('#clientDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#clientDetailsWindow').jqxWindow('setContent', data);
            $('#clientDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
    
    function agreementSearchContent(url) {
        $('#agreementDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#agreementDetailsWindow').jqxWindow('setContent', data);
            $('#agreementDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
    
    function getClient(event){
        var x= event.keyCode;
        if(x==114){
            clientSearchContent('clientDetailsSearchGrid.jsp');
        }
    }
    
    function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
            var branchval = document.getElementById("cmbbranch").value; 
            agreementSearchContent('agreementDetailsSearch.jsp');
        }
    }
    
    function funExportBtn(){
        $("#rentalInvoiceGrid").excelexportjs({
            containerid: "rentalInvoiceGrid",
            datatype: 'json',
            dataset: null,
            gridId: "rentalInvoiceGrid",
            columns: getColumns("rentalInvoiceGrid") ,
            worksheetName:"Invoices To Dispatch List"
        });  
    }

    function funClearData(){
        $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#todate').val(new Date());$('#clstatuss').val('');
        var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
        
        $('#fromdate').val(onemounth);
        $('#todate').val(new Date());
        
        if (document.getElementById("txtclientname").value == "") {
            $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
        }
        if (document.getElementById("txtagreementno").value == "") {
            $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
        }
    }
    
    function funreload(event){
        var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
        
        if(fromdates>todates){
            $.messager.alert('Message','To Date Less Than From Date','warning');   
            return false;
        } else {
            var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
            if(docdateval==0){
                $('#todate').jqxDateTimeInput('focus');
                return false;
            }
        
            var branchval = document.getElementById("cmbbranch").value;
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            var cldocno = $('#txtcldocno').val();
            var rentaltype = $('#rentaltype').val();
            var agmtno = $('#agmtvocno').val();
            var clstatuss= $('#clstatuss').val();
            var invtype=$('#cmbinvtype').val();
            var catid=$('#cmbcategory').val();
            
            $("#overlay, #PleaseWait").show();
            $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?catid="+catid+"&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&clstatuss='+clstatuss+'&invtype='+invtype);
        }
    }

    function chktype() {
        if($('#rentaltype').val()=="") {
            $.messager.alert('Message','Select Type','warning');   
            document.getElementById("rentaltype").focus(); 
            return false;
        }
    }
    
    function clearagno() {
        $('#txtagreementno').val('');
        $('#agmtvocno').val('');
    }
    
    function funPrintData(){
        var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
        var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
        document.getElementById("printdocno").value="";
        
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid document');
            return false;
        }
        
        var cnodocarray=new Array();
        var invdocarray=new Array();
        for(var i=0;i<selectedrows.length;i++){
            var dtype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
            if(i==0){
                if(dtype=="TCN" || dtype=="CNO"){
                    cnodocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid'));
                }
                else if(dtype=="INV" || dtype=="INS" || dtype=="INT"){
                    document.getElementById("printdocno").value=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
                    invdocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no'));
                }
            } else{
                if(dtype=="TCN" || dtype=="CNO"){
                    cnodocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid'));
                }
                else if(dtype=="INV" || dtype=="INS" || dtype=="INT"){
                    document.getElementById("printdocno").value+=","+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
                    invdocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no'));
                }
            }
        }
        
        var urlBase = document.URL.split("/com")[0];
        var openAndPrint = function(url) {
            var win = window.open(url, "_blank", "top=100,left=100,width=1000,height=800");
            if (win) {
                var checkReady = setInterval(function() {
                    if (win.document.readyState === 'complete') {
                        clearInterval(checkReady);
                        setTimeout(function() {
                            win.focus();
                            win.print();
                        }, 1000); 
                    }
                }, 500);
            }
        };
        
        if(cnodocarray.length>1){
            $.messager.alert('Warning','Cannot select multiple CNO');
            return false;
        }
        if(cnodocarray.length>0){
            var cnoUrl = urlBase + "/com/finance/transactions/creditnote/printCreditNote?docno=" + cnodocarray[0].split("::")[0] + "&branch=" + cnodocarray[0].split("::")[1] + "&header=1";
            openAndPrint(cnoUrl);
        }
        if(invdocarray.length>0){
            document.getElementById("printdocno").value = invdocarray.join(",");
            var invUrl = urlBase + "/com/operations/commtransactions/invoice/printManualInvoice?allbranch=1&printdocno=" + document.getElementById("printdocno").value + "&hidheader=1&chkdeletedinvprint=0&bankdocno=1";
            openAndPrint(invUrl);
        }
    }

    function funSendWhatsApp(){
        var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid invoice');
            return false;
        }
        var lines=[];
        lines.push('*Invoice Details*');
        lines.push('────────────────────────');
        for(var i=0;i<selectedrows.length;i++){
            var r=selectedrows[i];
            var docno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'doc_no')  ||'';
            var vocno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'voc_no')  ||'';
            var acname =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'acname')  ||'';
            var amount =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'amount')  ||'';
            var dtype  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'dtype')   ||'';
            var fdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'fromdate')||'';
            var tdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'todate')  ||'';
            if(selectedrows.length>1) lines.push('*#'+(i+1)+'*');
            lines.push('Doc No : '+docno+(vocno?'  ('+vocno+')':''));
            lines.push('Client : '+acname);
            lines.push('Type   : '+dtype);
            lines.push('Amount : '+amount);
            if(fdate||tdate) lines.push('Period : '+fdate+' – '+tdate);
            if(i<selectedrows.length-1) lines.push('────────────────────────');
        }
        var msg=lines.join('\n');
        window.open('https://wa.me/?text='+encodeURIComponent(msg),'_blank');
    }

    function funSendWhatsAppDirect(){
        var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid invoice');
            return false;
        }
        var lines=['*Invoice Details*','────────────────────────'];
        for(var i=0;i<selectedrows.length;i++){
            var r=selectedrows[i];
            var docno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'doc_no')  ||'';
            var vocno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'voc_no')  ||'';
            var acname =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'acname')  ||'';
            var amount =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'amount')  ||'';
            var dtype  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'dtype')   ||'';
            var fdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'fromdate')||'';
            var tdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'todate')  ||'';
            if(selectedrows.length>1) lines.push('*#'+(i+1)+'*');
            lines.push('Doc No : '+docno+(vocno?'  ('+vocno+')':''));
            lines.push('Client : '+acname);
            lines.push('Type   : '+dtype);
            lines.push('Amount : '+amount);
            if(fdate||tdate) lines.push('Period : '+fdate+' – '+tdate);
            if(i<selectedrows.length-1) lines.push('────────────────────────');
        }
        document.getElementById('waDirectMsg').value=lines.join('\n');
        document.getElementById('waDirectModal').classList.add('open');
        setTimeout(function(){ document.getElementById('waDirectPhone').focus(); },100);
    }

    function funWaDirectSend(){
        var phone=document.getElementById('waDirectPhone').value.trim();
        var msg=document.getElementById('waDirectMsg').value.trim();
        if(!phone){
            alert('Please enter a WhatsApp number with country code');
            return;
        }
        document.getElementById('waDirectModal').classList.remove('open');
        $("#overlay, #PleaseWait").show();
        $.post('sendWhatsAppDirect.jsp',{phone:phone,message:msg},function(data){
            $("#overlay, #PleaseWait").hide();
            try{ data=JSON.parse(data); }catch(e){ data={success:false,error:'Invalid response'}; }
            if(data && data.success){
                $.messager.alert('Message','WhatsApp message sent successfully');
            } else {
                $.messager.alert('Warning','Failed: '+(data.error||'Check API credentials in sendWhatsAppDirect.jsp'));
            }
        });
    }

    function funWaDirectCancel(){
        document.getElementById('waDirectModal').classList.remove('open');
    }

    function funDispatchData(){
        var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid invoice');
            return false;
        }
        document.getElementById("printdocno").value="";
        var docarray=new Array();
        for(var i=0;i<selectedrows.length;i++){
            var trno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
            var dtype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
            var doc_no=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
            var brhid=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
            docarray.push(trno+"::"+dtype+"::"+doc_no+"::"+brhid);
        }
        $("#overlay, #PleaseWait").show();
        $.post('dispatchData.jsp',{'docarray':docarray.join(",")},function(data,status){
            $("#overlay, #PleaseWait").hide();
            if(parseInt(data)>0){
                $.messager.alert('Message','Record Successfully Dispatched','warning');   
            }
            else{
                $.messager.alert('Message','Not Dispatched','warning');
                return false;
            }
            funreload("");
        });
    }

    function validateEmail(email){
        var res,part1,part2,dotsplt;
        
        if(email.indexOf("@")>=0) {
            res = email.split('@');
            part1=res[0];
            part2=res[1];
            dotsplt=part2.split('.');
        } else{
            return false;
        }
        
        if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(email.indexOf("@")<0) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(email.split('@').length!=2) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(part1.length==0) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(part1.split(" ").length>2) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(part2.split(".").length<2) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(dotsplt[0].length==0 ) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
            $.messager.alert('Message','Email is not Configured Properly.','warning');
            return false;
        }
        return true;
    }

    function funSendingEmail() {  
        var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
        var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
        var email="";
        var printdoc="";
        var vocno="";
        var docno="";
        
        if(selectedrows.length==0){
            $.messager.alert('Warning','Please select valid invoice');
            return false;
        }
        
        var doctype="";
        var emailinvalid="0";
        for(var i=0;i<selectedrows.length;i++){
            var emailstatus=validateEmail($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'mail1'));
            if(emailstatus==false){
                emailinvalid="1";
                return false;
            }
        }
        
        if(emailinvalid=="1"){
            return false;
        }
        
        var docarray=new Array();
        for(var i=0;i<selectedrows.length;i++){
            docno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
            var trno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
            brhid=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
            doctype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
            docarray.push(trno+"::"+brhid+"::"+doctype);
        }
        
        var mailurl="";
        var mailtype=$('input[name="chkmailtype"]:checked').val();
        
        $("#overlay, #PleaseWait").show();
        $.ajaxFileUpload ({  
            url: "sendInvDispatchMail.action?docarray="+docarray.join(",")+"&mailtype="+mailtype,  
            secureuri:false,  
            fileElementId:'file',  
            dataType: 'string',  
            success: function (data, status) {
                if(status=='success'){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','E-Mail Send Successfully');
                    funreload("");
                }
                if(status=='error'){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','E-Mail Sending failed');
                }
            },  
            error: function (data, status, e) {  
                $("#overlay, #PleaseWait").hide();
                $.messager.alert('Message','E-Mail Sending failed');
            }  
        }); 
        return false;
    } 
    </script>
</head>

<body onload="getBranch();">
    <div id="mainBG" class="homeContent">
        <div class="master-container">

            <!-- ================= LEFT SIDEBAR ================= -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    
                    <!-- Date Filter Card -->
                    <div class="filter-card">
                        <table class="dispatch-filter-table">
                            <tr>
                                <td class="label-cell">From</td>
                                <td><div id="fromdate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To</td>
                                <td><div id="todate"></div></td>
                            </tr>
                        </table>
                    </div>

                    <!-- Mail Settings Card -->
                    <div class="filter-card">
                        <div class="mail-type-group">
                            <input type="radio" name="chkmailtype" id="chkclientwise" value="CRM" checked>
                            <label for="chkclientwise">Client Wise</label>

                            <input type="radio" name="chkmailtype" id="chkagmtwise" value="AGMT">
                            <label for="chkagmtwise">Agreement Wise</label>

                            <input type="radio" name="chkmailtype" id="chksaperate" value="SEP">
                            <label for="chksaperate">Separate</label>
                        </div>
                    </div>

                    <!-- Primary Filters Card -->
                    <div class="filter-card">
                        <table class="dispatch-filter-table">
                            <tr>
                                <td class="label-cell">Client</td>
                                <td>
                                    <input type="text" id="txtclientname" name="txtclientname" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'>
                                    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea id="clienthtml"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Category</td>
                                <td>
                                    <select id="cmbcategory" name="cmbcategory">
                                        <option value="">--Select--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Inv Type</td>
                                <td>
                                    <select id="cmbinvtype" name="cmbinvtype">
                                        <option value="">--Select--</option>
                                        <option value="rental">Rental</option>
                                        <option value="lease">Lease</option>
                                        <option value="traffic">Traffic</option>
                                        <option value="salik">Salik</option>
                                        <option value="damage">Damage</option>
                                        <option value="extrasrvc">Extra Services</option>
                                        <option value="extrakm">Extra KM</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Status</td>
                                <td>
                                    <select id="clstatuss" name="clstatuss">
                                        <option value="">--Select--</option>
                                        <option value="0">Open</option>
                                        <option value="1">Close</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Agmt Type</td>
                                <td>
                                    <select id="rentaltype" name="rentaltype" onchange="clearagno();">
                                        <option value="">--Select--</option>
                                        <option value="RAG">Rental</option>
                                        <option value="LAG">Lease</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Agreement</td>
                                <td>
                                    <input type="text" id="agmtvocno" name="agmtvocno" readonly placeholder="Press F3 to Search" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'>
                                </td>
                            </tr>
                        </table>

                        <!-- Action Buttons -->
                        <div class="dispatch-actions">
                            <button type="button" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                                Clear
                            </button>
                            <button type="button" class="btn-submit" onclick="funPrintData();">
                                Print
                            </button>
                            <button type="button" class="btn-whatsapp" onclick="funSendWhatsApp();">
                                &#128904; WhatsApp
                            </button>
                            <button type="button" class="btn-wa-direct" onclick="funSendWhatsAppDirect();">
                                &#128222; WA Direct
                            </button>
                            <button type="button" class="btn-submit" onclick="funDispatchData();" style="background:#10b981 !important;">
                                Dispatch
                            </button>
                        </div>
                    </div>
                    
                    <!-- Hidden -->
                    <div style="display:none;">
                        <input type="hidden" id="printdocno" name="printdocno">
                        <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'>
                    </div>

                </div>
            </div>

            <!-- ================= RIGHT SIDE (GRID) ================= -->
            <div class="main-content-area">
                
                <!-- Toolbar/Heading (Moved from Sidebar) -->
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
                
                <div class="grid-content-container">
                    <div id="notInvoicedDiv">
                        <jsp:include page="rentalInvoiceGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>

        </div>

        <!-- POPUPS -->
        <div id="clientDetailsWindow"><div></div><div></div></div>
        <div id="agreementDetailsWindow"><div></div><div></div></div>

        <!-- WhatsApp Direct Modal -->
        <div id="waDirectModal">
            <div class="wa-modal-box">
                <div class="wa-modal-title">&#128904; Send via WhatsApp</div>
                <input type="text" id="waDirectPhone" placeholder="e.g. 971501234567 (country code, no +)" onkeydown="if(event.keyCode==13)funWaDirectSend();">
                <div class="wa-modal-hint">Country code + number, no spaces or + symbol&nbsp;&nbsp;(UAE: 971xxxxxxxxx)</div>
                <textarea id="waDirectMsg" class="wa-modal-preview"></textarea>
                <div class="wa-modal-actions">
                    <button class="wa-cancel-btn" onclick="funWaDirectCancel();">Cancel</button>
                    <button class="wa-send-btn" onclick="funWaDirectSend();">Send</button>
                </div>
            </div>
        </div>

    </div>
</body>
</html>