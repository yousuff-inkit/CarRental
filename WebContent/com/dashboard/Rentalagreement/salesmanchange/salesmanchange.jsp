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
<style>
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
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
    padding: 15px 20px 25px;
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
    font-size: 12px; /* Uniform 12px label */
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



/* ===== BUTTONS ===== */
.btn-submit, .myButton {
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

.btn-submit:hover, .myButton:hover {
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

legend {
    font-size: 11px;
    font-weight: bold;
    color: #2563eb;
    text-transform: uppercase;
    margin-bottom: 5px;
}

fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 10px;
    margin: 0;
}

/* Strips inherited green background */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}

.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    background: #fff;
    height: 100%;      /* was: 100vh */
    box-sizing: border-box;
    padding: 0;        /* was: 15px 20px */
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
    flex-shrink: 0;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
    padding: 15px 20px;
    box-sizing: border-box;
}
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;      
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}
</style>
  

<script type="text/javascript">

$(document).ready(function () {
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientwindow').jqxWindow('close');
     $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#fleetwindow').jqxWindow('close');
     $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#salesmanwindow').jqxWindow('close');
     
     $('#catwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#catwindow').jqxWindow('close');
     
    
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
    
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
     $('#salesman').dblclick(function(){
          $('#salesmanwindow').jqxWindow('open');
         salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow')); 
       });
     $('#salesmann').dblclick(function(){
          $('#salesmanwindow').jqxWindow('open');
         salesmannSearchContent('salesmannsearch.jsp?', $('#salesmanwindow')); 
       });
      
    // UPDATED: Standardized height to 24px and width to 100%
     $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
     $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
     
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
      
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     
     $('#todate').on('change', function (event) {
           var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
            if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date ','warning');   
           return false;
          }    
     });
});

function funExportBtn(){
     //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
         JSONToCSVCon(dataildata, 'Rental List', true);
     }
  
function getclcat(event){
     var x= event.keyCode;
     if(x==114){
      $('#catwindow').jqxWindow('open');
      catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    }
} 
    
function catnameSearchContent(url) {
         $.get(url).done(function (data) {
             $('#catwindow').jqxWindow('open');
        $('#catwindow').jqxWindow('setContent', data);
    }); 
}  

function getsalesman(event){
     var x= event.keyCode;
     if(x==114){
      $('#salesmanwindow').jqxWindow('open');
    salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow'));    }
} 

function salesmanSearchContent(url) {
         $.get(url).done(function (data) {
             $('#salesmanwindow').jqxWindow('open');
        $('#salesmanwindow').jqxWindow('setContent', data);
    }); 
} 

function getsalesmann(event){
     var x= event.keyCode;
     if(x==114){
      $('#salesmanwindow').jqxWindow('open');
    salesmannSearchContent('salesmannsearch.jsp?', $('#salesmanwindow'));    }
} 

function salesmannSearchContent(url) {
         $.get(url).done(function (data) {
             $('#salesmanwindow').jqxWindow('open');
        $('#salesmanwindow').jqxWindow('setContent', data);
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
         var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
       if(fromdates>todates){
           $.messager.alert('Message','To Date Less Than From Date ','warning');   
       return false;
      } 
       else
           {
     var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
     var todate= $("#todate").val(); 
       $("#overlay, #PleaseWait").show();
       
      $("#detlist").load("detailedGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&salesmandoc="+document.getElementById("salesmandoc").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val());
    
           }
    }
function getrentaltype() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var rentaltype  = items.split(",");
            var optionsrental = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < rentaltype.length; i++) {
                optionsrental += '<option value="' + rentaltype[i].trim() + '">'
                        + rentaltype[i] + '</option>';
            }
            $("select#rentaltype").html(optionsrental);
            
        }
    }
    x.open("GET","getrentaltypes.jsp", true);
    x.send();
}

function  funcleardata()
{
    document.getElementById("catid").value="";
    document.getElementById("cldocno").value="";
    document.getElementById("salesmandoc").value="";
    
    document.getElementById("salesman").value="";
    document.getElementById("salesmann").value="";
    document.getElementById("fleet").value="";
    document.getElementById("clientname").value="";
    document.getElementById("rentaltype").value="";
    document.getElementById("status").value="";
    document.getElementById("catname").value="";
    document.getElementById("salesman_txt").value="";
    document.getElementById("ra_no").value="";
    
     if (document.getElementById("clientname").value == "") {
        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("salesman_txt").value == "") {
        $('#get_docno').attr('placeholder', ' '); 
    }
     if (document.getElementById("ra_no").value == "") {
        $('#"ra_no"').attr('placeholder', ' '); 
    }
     if (document.getElementById("salesman").value == "") {
        $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("salesmann").value == "") {
        $('#salesmann').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("fleet").value == "") {
        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
    }
     if (document.getElementById("catname").value == "") {
        $('#catname').attr('placeholder', 'Press F3 TO Search'); 
    }
}
</script>

<script>
function funupdate()
{
     $('#detailedGrid').jqxGrid('clearfilters');
     var selectedrows = $("#detailedGrid").jqxGrid('selectedrowindexes');
     selectedrows = selectedrows.sort(function(a,b){return a - b});

     if(selectedrows.length==0){
         $.messager.alert('Warning','Please select a document!');   
        return false;
    }
     var salid=$("#salesman_txt").val();
     if(salid==0){
         $.messager.alert('Warning','Please select Salesman!');   
            return false;
     }
        
     var i=0,j=0;
     var temptrno="";
     for (i = 0; i < selectedrows.length; i++) {
         if(i==0){  
             var srvdetmtrno= $('#detailedGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
             temptrno=srvdetmtrno;   
         }  
            else{  
                var srvdetmtrno = $('#detailedGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                temptrno=temptrno+","+srvdetmtrno;     
            }
            j++; 
     }
            
    
     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false)
         {
            return false; 
         }
        else{
             savegriddata(temptrno,salid);  
        }
         });
}

function savegriddata(temptrno,salid)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText;
             
             document.getElementById("ra_no").value="";
             document.getElementById("salesmann").value="";
             document.getElementById("salesman_txt").value="";
             funreload(event); 
             $("#detailedGrid").jqxGrid('clear');
             $('#salesmann').attr('placeholder', 'Press F3 TO Search'); 
             if(items>0){ 
                  $.messager.alert('Message','Record Successfully Updated','success');
            }else{
                  $.messager.alert('Message','Not Updated','warning');             
            }   
            }
    }
        
x.open("GET","salesmansavedata.jsp?ra_no="+encodeURIComponent(temptrno)+"&salesman_txt="+salid);
x.send(); 
}
</script>
</head>
<body onload="getBranch();getrentaltype();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">
<div class="master-container">

    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
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
                                   readonly placeholder="Press F3 TO Search"
                                   onkeydown="getclinfo(event);"
                                   value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Category</td>
                        <td>
                            <input type="text" id="catname" name="catname"
                                   readonly placeholder="Press F3 TO Search"
                                   onkeydown="getclcat(event);"
                                   value='<s:property value="catname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" id="fleet" name="fleet"
                                   readonly placeholder="Press F3 TO Search"
                                   onkeydown="getfleet(event);"
                                   value='<s:property value="fleet"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Salesman</td>
                        <td>
                            <input type="text" id="salesman" name="salesman"
                                   readonly placeholder="Press F3 TO Search"
                                   onkeydown="getsalesman(event);"
                                   value='<s:property value="salesman"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype"></select>
                        </td>
                    </tr>
                </table>

                <button type="button" class="btn-submit" onclick="funcleardata();">
                    Clear
                </button>
            </div>

            <div class="filter-card">
                <fieldset>
                    <legend>Salesman change</legend>
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Salesman</td>
                            <td>
                                <input type="text" id="salesmann" name="salesmann"
                                       readonly placeholder="Press F3 TO Search"
                                       onkeydown="getsalesmann(event);"
                                       value='<s:property value="salesman"/>'>
                            </td>
                        </tr>
                    </table>

                    <button type="button" class="btn-submit" onclick="funupdate();">
                        Update
                    </button>
                </fieldset>
            </div>

            <div id="paychaaaaa" style="height:100px;"></div>

            <input type="hidden" id="ra_no" value='<s:property value="ra_no"/>'>
            <input type="hidden" id="salesman_txt" value='<s:property value="salesman_txt"/>'>
            <input type="hidden" id="cldocno" value='<s:property value="cldocno"/>'>
            <input type="hidden" id="salesmandoc" value='<s:property value="salesmandoc"/>'>
            <input type="hidden" id="catid" value='<s:property value="catid"/>'>

        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="detlist">
                <jsp:include page="detailedGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>

<div id="catwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="salesmanwindow"><div></div></div>

</div>
</div>
</body>
</html>