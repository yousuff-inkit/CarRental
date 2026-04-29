<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit {
    flex: 1;
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

input[type="checkbox"], input[type="radio"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
     // Standardized height to 24px and width to 100%
     $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     $('#clientwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientwindow').jqxWindow('close');
     
     $('#fleetwindow').jqxWindow({ width: '30%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#fleetwindow').jqxWindow('close');
     
     $('#groupwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#groupwindow').jqxWindow('close');
     
     $('#brandwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#brandwindow').jqxWindow('close');
     
     $('#modelwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelwindow').jqxWindow('close');
     
     $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#salesmanwindow').jqxWindow('close');
     
     $('#rentalagentWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#rentalagentWindow').jqxWindow('close');
     
     $('#catwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#catwindow').jqxWindow('close');
     
     document.getElementById('inchks').value=""; 
     document.getElementById('outchks').value="OUT"; 
    
     $('#salesman').dblclick(function(){
          $('#salesmanwindow').jqxWindow('open');
          salesmanSearchContent('salesmanSearch.jsp?', $('#salesmanwindow')); 
     });
     
     $('#rentalagent').dblclick(function(){
          $('#rentalagentWindow').jqxWindow('open');
          rentalagentSearchContent('rentalAgentSearch.jsp?', $('#rentalagentWindow')); 
     });
     
     $('#clientname').dblclick(function(){
          $('#clientwindow').jqxWindow('open');
          clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
     });
     
     $('#catname').dblclick(function(){
          $('#catwindow').jqxWindow('open');
          catnameSearchContent('categorysearch.jsp?', $('#catwindow'));  
     });
      
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

function funExportBtn(){
     JSONToCSVCon(exceldata, 'RA Tariff List', true);
}

function getRentalAgent(event){
     var x= event.keyCode;
     if(x==114){
         $('#rentalagentWindow').jqxWindow('open');
         rentalagentSearchContent('rentalAgentSearch.jsp', $('#rentalagentWindow'));
     }
}
function rentalagentSearchContent(url) {
     $.get(url).done(function (data) {
         $('#rentalagentWindow').jqxWindow('open');
         $('#rentalagentWindow').jqxWindow('setContent', data);
     }); 
}
    
function getSalesman(event){
     var x= event.keyCode;
     if(x==114){
         $('#salesmanwindow').jqxWindow('open');
         salesmanSearchContent('salesmanSearch.jsp', $('#salesmanwindow'));
     }
} 

function getclcat(event){
     var x= event.keyCode;
     if(x==114){
      $('#catwindow').jqxWindow('open');
      catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    
     }
} 
    
function getbrand(event){
     var x= event.keyCode;
     if(x==114){
      $('#brandwindow').jqxWindow('open');
      brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    
     }
} 

function salesmanSearchContent(url) {
     $.get(url).done(function (data) {
         $('#salesmanwindow').jqxWindow('open');
         $('#salesmanwindow').jqxWindow('setContent', data);
     }); 
}   

function catnameSearchContent(url) {
     $.get(url).done(function (data) {
         $('#catwindow').jqxWindow('open');
         $('#catwindow').jqxWindow('setContent', data);
     }); 
}  
    
function modelSearchContent(url) {
     $.get(url).done(function (data) {
         $('#modelwindow').jqxWindow('open');
         $('#modelwindow').jqxWindow('setContent', data);
     }); 
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
      groupSearchContent('groupsearch.jsp?', $('#groupwindow'));    
     }
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
      fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    
     }
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
      clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    
     }
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
         var ragent=$('#hidrentalagent').val();
         $("#overlay, #PleaseWait").show();
         var salesman=$('#hidsalesman').val();
         $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val()+'&salesman='+salesman+'&ragent='+ragent);
     }
}

function funcleardata()
{
    document.getElementById("catid").value="";
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
    document.getElementById("catname").value="";
    document.getElementById("salesman").value="";
    document.getElementById("hidsalesman").value="";
    document.getElementById("rentalagent").value="";
    document.getElementById("hidrentalagent").value="";
    
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
    if (document.getElementById("catname").value == "") {
        $('#catname').attr('placeholder', 'Press F3 TO Search'); 
    }
    if (document.getElementById("salesman").value == "") {
        $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
    }
    if (document.getElementById("rentalagent").value == "") {
        $('#rentalagent').attr('placeholder', 'Press F3 TO Search'); 
    }
}

function funchkval(){
    if (document.getElementById('outchk').checked) {
        document.getElementById('inchks').value=""; 
        document.getElementById('outchks').value="OUT"; 
    } else if (document.getElementById('inchk').checked) {
        document.getElementById('inchks').value="IN"; 
        document.getElementById('outchks').value=""; 
    }
}
</script>
</head>

<body onload="getBranch();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width="330px" valign="top">
    <div class="sidebar-filters">
        
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <div class="radio-group">
                    <label>
                        <input type="radio" name="chk" id="outchk" value="out" checked onchange="funchkval()">
                        Out Date
                    </label>
                    <label>
                        <input type="radio" name="chk" id="inchk" value="in" onchange="funchkval()">
                        In Date
                    </label>
                </div>

                <table class="filter-table">
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

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="status" name="status">
                                <option value="">All</option>
                                <option value="0">Open</option>
                                <option value="1">Close</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="clientname" name="clientname"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getclinfo(event);"
                                   value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Category</td>
                        <td>
                            <input type="text" id="catname" name="catname"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getclcat(event);"
                                   value='<s:property value="catname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" id="fleet" name="fleet"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getfleet(event);"
                                   value='<s:property value="fleet"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Group</td>
                        <td>
                            <input type="text" id="group" name="group"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getgroup(event);"
                                   value='<s:property value="group"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Brand</td>
                        <td>
                            <input type="text" id="brand" name="brand"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getbrand(event);"
                                   value='<s:property value="brand"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Model</td>
                        <td>
                            <input type="text" id="model" name="model"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getmodel(event);"
                                   value='<s:property value="model"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype">
                                <option value="Daily">Daily</option>
                                <option value="Weekly">Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Salesman</td>
                        <td>
                            <input type="text" id="salesman" name="salesman"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getSalesman(event);"
                                   value='<s:property value="salesman"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Rental Agent</td>
                        <td>
                            <input type="text" id="rentalagent" name="rentalagent"
                                   placeholder="Press F3 To Search" readonly 
                                   onkeydown="getRentalAgent(event);"
                                   value='<s:property value="rentalagent"/>'>
                        </td>
                    </tr>
                </table>

                <button type="button" class="btn-submit" onclick="funcleardata();">
                    Clear
                </button>
            </div>

            <div style="display:none;">
                <input type="hidden" id="outchks" name="outchks">
                <input type="hidden" id="inchks" name="inchks">
                <input type="hidden" id="cldocno" name="cldocno">
                <input type="hidden" id="groupdoc" name="groupdoc">
                <input type="hidden" id="brandid" name="brandid">
                <input type="hidden" id="modelid" name="modelid">
                <input type="hidden" id="catid" name="catid">
                <input type="hidden" id="hidsalesman" name="hidsalesman">
                <input type="hidden" id="hidrentalagent" name="hidrentalagent">
            </div>

        </div>
    </div>
</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="detlist">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<div id="catwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="brandwindow"><div></div></div>
<div id="modelwindow"><div></div></div>
<div id="salesmanwindow"><div></div></div>
<div id="rentalagentWindow"><div></div></div>

</div>
</body>
</html>