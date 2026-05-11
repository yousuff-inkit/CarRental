<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
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

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}
/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
     document.getElementById("hidadvance_chk").value=0;

     // Standardized height to 24px and width to 100%
     $("#jqxDateOut, #jqxDaterentalout, #fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientwindow').jqxWindow('close');
     $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#fleetwindow').jqxWindow('close');
     $('#groupwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#groupwindow').jqxWindow('close');
     $('#brandwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#brandwindow').jqxWindow('close');
     $('#modelwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelwindow').jqxWindow('close');
     $('#usersearchwindow').jqxWindow({ width: '55%', height: '56%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 160, y: 150 }, keyboardCloseKey: 27});
     $('#usersearchwindow').jqxWindow('close');
     
     getConfigs();
     
     $('#clientname').dblclick(function(){
          $('#clientwindow').jqxWindow('open');
          clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
     });
     
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     $('#fleet').dblclick(function(){
          $('#fleetwindow').jqxWindow('open');
          fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
     });
     $('#group').dblclick(function(){
          $('#groupwindow').jqxWindow('open');
          groupSearchContent('groupsearch.jsp?', $('#groupwindow')); 
     });
     $('#brand').dblclick(function(){
          $('#brandwindow').jqxWindow('open');
          brandSearchContent('brandsearch.jsp?', $('#brandwindow')); 
     });
     $('#model').dblclick(function(){
          $('#modelwindow').jqxWindow('open');
          modelSearchContent('modelsearch.jsp?', $('#modelwindow')); 
     }); 
     
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     
     $('#todate').on('change', function (event) {
           var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
           var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
           if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date ','warning');   
               return false;
          }    
     });
});

function getmodel(event){
     var x= event.keyCode;
     if(x==114){
      $('#modelwindow').jqxWindow('open');
      modelSearchContent('modelsearch.jsp?', $('#modelwindow'));    }
} 
function modelSearchContent(url) {
     $.get(url).done(function (data) {
         $('#modelwindow').jqxWindow('open');
         $('#modelwindow').jqxWindow('setContent', data);
    }); 
} 

function getbrand(event){
     var x= event.keyCode;
     if(x==114){
      $('#brandwindow').jqxWindow('open');
      brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    }
} 
function brandSearchContent(url) {
     $.get(url).done(function (data) {
         $('#brandwindow').jqxWindow('open');
         $('#brandwindow').jqxWindow('setContent', data);
    }); 
} 

function getgroup(event){
     var x= event.keyCode;
     if(x==114){
      $('#groupwindow').jqxWindow('open');
      groupSearchContent('groupsearch.jsp?', $('#groupwindow'));    }
} 
function groupSearchContent(url) {
     $.get(url).done(function (data) {
         $('#groupwindow').jqxWindow('open');
         $('#groupwindow').jqxWindow('setContent', data);
    }); 
} 

function getfleet(event){
     var x= event.keyCode;
     if(x==114){
      $('#fleetwindow').jqxWindow('open');
      fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
} 
function fleetSearchContent(url) {
     $.get(url).done(function (data) {
         $('#fleetwindow').jqxWindow('open');
         $('#fleetwindow').jqxWindow('setContent', data);
    }); 
} 

function getclinfo(event){
     var x= event.keyCode;
     if(x==114){
      $('#clientwindow').jqxWindow('open');
      clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
} 
function clientSearchContent(url) {
     $.get(url).done(function (data) {
         $('#clientwindow').jqxWindow('open');
         $('#clientwindow').jqxWindow('setContent', data);
    }); 
} 

function funreload(event)
{
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
     if(fromdates>todates){
         $.messager.alert('Message','To Date Less Than From Date ','warning');   
         return false;
     } else {
         var barchval = document.getElementById("cmbbranch").value;
         var fromdate= $("#fromdate").val();
         var todate= $("#todate").val(); 
         $("#overlay, #PleaseWait").show();
         $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val());
     }
     disiem(); 
     $("#rtaiff").jqxGrid('clear');
}

function funcleardata()
{
    document.getElementById("cldocno").value="";
    document.getElementById("groupdoc").value="";
    document.getElementById("brandid").value="";
    document.getElementById("modelid").value="";
    document.getElementById("model").value="";
    document.getElementById("brand").value="";
    document.getElementById("group").value="";
    document.getElementById("fleet").value="";
    document.getElementById("clientname").value="";
    document.getElementById("rentaltype").value="Daily";
    document.getElementById("status").value="0";
    
    $('#jqxDateOut').val(new Date());
    
    document.getElementById("docnos").value="";
    document.getElementById("excessinsur").value="";
    document.getElementById("normalinsu").value="";
    document.getElementById("cdwinsu").value="";
    document.getElementById("supercdwinsu").value="";
    document.getElementById("gridlength").value="";
    document.getElementById("branchid").value="";
    
     if (document.getElementById("clientname").value == "") {
        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("model").value == "") {
        $('#model').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("brand").value == "") {
        $('#brand').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("group").value == "") {
        $('#group').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("fleet").value == "") {
        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
    }
}
    
function funExportBtn(){
      $("#detlist").excelexportjs({
            containerid: "detlist", 
            datatype: 'json', 
            dataset: null, 
            gridId: "detailsgrid", 
            columns: getColumns("detailsgrid") ,   
            worksheetName:"LA Tarif Change"
            });
}

function funupdatera()
{
    $.messager.confirm('Message', 'Do you want to Update?', function(r){
        if(r==false) {
            return false; 
        } else {
             if(document.getElementById("configmethod").value>0) {
                 var advchkval=document.getElementById("advchkval").value;
                 var hidadvance_chk=document.getElementById("hidadvance_chk").value;
                  if(advchkval!=hidadvance_chk) {
                      $.messager.alert('Message', ' Please check the client advance rule ');    
                      return 0;
                  }
                  var invval=document.getElementById("invval").value;
                  var invoice=document.getElementById("cmbinvoicing_method").value;
                  if(invval!=invoice) {
                      $.messager.alert('Message', ' Please check the client invoice rule ');    
                      return 0;
                  }
             }
             
              var rows = $("#rtaiff").jqxGrid('getrows');
              for(var i=0 ; i < rows.length ; i++){
                 if(i==3 || i==5) {
                     var rateval=rows[i].rate;
                    if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN"||rateval=="0.00") {
                        $.messager.alert('Message', ' Tariff Is Not Selected ');    
                        return 0;
                    }
                 } 
              }
        
             $('#gridlength').val(rows.length); 
             var listss = new Array();
             var a = 1;
             
             for(var i=0 ; i < rows.length ; i++){
                 var rateval=rows[i].rate;
                    if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN"||rateval=="0.00") {
                        $.messager.alert('Message', ' Tariff Is Not Selected ');    
                        return 0;
                    }
                 listss.push(rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].kmrest+"::"+
                           rows[i].exkmrte+"::"+rows[i].oinschg+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+a+"::");  
             }
             save(listss);
        }
    });
}

function save(listss)
{
     var docnos= document.getElementById("docnos").value;       
     var excessinsur=document.getElementById("excessinsur").value; 
     var jqxDateOut=document.getElementById("jqxDaterentalout").value; 
     var branchid=document.getElementById("branchid").value; 
     var invoicevalue=document.getElementById("cmbinvoicing_method").value;
     var advance=document.getElementById("hidadvance_chk").value;
     var oinvdate=document.getElementById("oinvdate").value;
     var oadvchk=document.getElementById("oadvchk").value;
     var oinvtype=document.getElementById("oinvtype").value;
     var rvocno=document.getElementById("rvocno").value;
     var rcldocno=document.getElementById("rcldocno").value;
    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
             var items= x.responseText;
             var itemval=items.trim();
             
            if(parseInt(itemval)==1) {
                $.messager.alert('Message', ' Tariff Change Effective from '+oinvdate+'' );
                $('#gridlength').val(""); 
                $('#jqxDateOut').val(new Date());
                document.getElementById("docnos").value="";
                document.getElementById("excessinsur").value="";
                document.getElementById("normalinsu").value="";
                document.getElementById("cdwinsu").value="";
                document.getElementById("supercdwinsu").value="";
                 document.getElementById("gridlength").value="";
                document.getElementById("branchid").value="";
                document.getElementById("rvocno").value="";
                document.getElementById("rcldocno").value="";
                 document.getElementById("oinvdate").value="";
                document.getElementById("oadvchk").value="";
                document.getElementById("oinvtype").value="";
                document.getElementById("advchkval").value="";
                 document.getElementById("invval").value="";
                document.getElementById("configmethod").value="";
                document.getElementById("advance_chk").value="";
                 document.getElementById("cmbinvoicing_method").value="1";
                document.getElementById("advance_chk").checked = false;
                 funreload(event);
            }
            else {
                $.messager.alert('Message', '  Not Updated ', function(r){ });
            }  
        }
    }
    
    x.open("GET","savedata.jsp?list="+listss+"&docno="+docnos+"&excessinsur="+excessinsur+"&jqxDateOut="+jqxDateOut+"&branchid="+branchid+"&invoicevalue="+invoicevalue+"&advance="+advance+"&oinvdate="+oinvdate+"&oadvchk="+oadvchk+"&oinvtype="+oinvtype+"&rvocno="+rvocno+"&rcldocno="+rcldocno);
    x.send();
}

function getConfigs(){
    $.get('getConfigs.jsp',function(data){
        data=JSON.parse(data);
        var htmldata='';
            if(data.InvQuarterly=="1"){
                htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
                $('#cmbinvoicing_method').append($.parseHTML(htmldata));
                if($('#cmbinvoicing_method').val()!="")
                {
                    $('#cmbinvoicing_method').val($('#hidcmbinvoicing_method').val());
                } 
            }
    });
}

function disiem()
{
     $('#searchuser').attr("disabled",true);
     $('#update').attr("disabled",true);
     $('#advance_chk').attr("disabled",true);
     $('#cmbinvoicing_method').attr("disabled",true);
}
    
function funchangeadv(){
    if(document.getElementById('advance_chk').checked){
        document.getElementById("hidadvance_chk").value=1;
    }else{
        document.getElementById("hidadvance_chk").value=0;
    }
}
</script>
</head>

<body onload="getBranch();disiem()">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            
            <!-- Filter Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="status" name="status" value='<s:property value="status"/>'>
                                <option value="0">Open</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" value='<s:property value="clientname"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td><input type="text" name="fleet" id="fleet" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getfleet(event)" value='<s:property value="fleet"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Group</td>
                        <td><input type="text" name="group" id="group" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getgroup(event)" value='<s:property value="group"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Brand</td>
                        <td><input type="text" name="brand" id="brand" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getbrand(event)" value='<s:property value="brand"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Model</td>
                        <td><input type="text" name="model" id="model" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getmodel(event)" value='<s:property value="model"/>'></td>
                    </tr>
                    <tr style="display:none;">
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="Daily">Daily</option>
                                <option value="Weekly">Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select>
                        </td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px;">
                    <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata();">Clear</button>
                </div>
            </div>

            <!-- Invoicing Settings Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Advance</td>
                        <td>
                            <input type="checkbox" id="advance_chk" name="advance_chk" onchange="funchangeadv();">
                            <input type="hidden" id="hidadvance_chk" name="hidadvance_chk" value='<s:property value="hidadvance_chk"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Invoice</td>
                        <td>
                            <select name="cmbinvoicing_method" id="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Month End</option>
                                <option value="2">Period</option>
                            </select>
                            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
                        </td>
                    </tr>
                </table>

                <div style="margin-top: 15px;">
                    <button type="button" class="btn-submit" name="update" id="update" onclick="funupdatera();">Update</button>
                </div>
            </div>

            <!-- Hidden Fields -->
            <div style="display:none;">
                <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div> 
                <div id='jqxDaterentalout' name='jqxDaterentalout' value='<s:property value="jqxDaterentalout"/>'></div> 
                
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" name="groupdoc" id="groupdoc" value='<s:property value="groupdoc"/>'>
                <input type="hidden" name="brandid" id="brandid" value='<s:property value="brandid"/>'>
                <input type="hidden" name="modelid" id="modelid" value='<s:property value="modelid"/>'> 
                <input type="hidden" name="docnos" id="docnos" value='<s:property value="docnos"/>'>
                <input type="hidden" id="excessinsur" name="excessinsur" value='<s:property value="excessinsur"/>' >
                <input type="hidden" name="normalinsu" id="normalinsu" value='<s:property value="normalinsu"/>' />
                <input type="hidden" name="cdwinsu" id="cdwinsu" value='<s:property value="cdwinsu"/>' /> 
                <input type="hidden" name="supercdwinsu" id="supercdwinsu" value='<s:property value="supercdwinsu"/>' />
                <input type="hidden" id="gridlength" name="gridlength">
                
                <input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>' />  
                <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
                <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' />
                <input type="hidden" id="branchid" name="branchid" value='<s:property value="branchid"/>' >
                
                <input type="hidden" id="orentaltype" name="orentaltype" value='<s:property value="orentaltype"/>' >
                <input type="hidden" id="oinvdate" name="oinvdate" value='<s:property value="oinvdate"/>' >
                <input type="hidden" id="oadvchk" name="oadvchk" value='<s:property value="oadvchk"/>' >
                <input type="hidden" id="oinvtype" name="oinvtype" value='<s:property value="oinvtype"/>' >
                <input type="hidden" id="rvocno" name="rvocno" value='<s:property value="rvocno"/>' >
                <input type="hidden" id="rcldocno" name="rcldocno" value='<s:property value="rcldocno"/>' >
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="detlist">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
            
            <div style="height:15px;"></div>
            
            <div id="rtariff">
                <jsp:include page="ltariffdetails.jsp"></jsp:include>
            </div>
            
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="brandwindow"><div></div></div>
<div id="modelwindow"><div></div></div>
<div id="usersearchwindow"><div></div></div>

</body>
</html>