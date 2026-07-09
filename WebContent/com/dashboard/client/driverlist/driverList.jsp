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

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}


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

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: flex-start;
    gap: 15px;
    margin-top: 5px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

legend {
    font-size: 11px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 5px;
    text-transform: uppercase;
}

fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 10px;
    margin: 0;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;   /
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;       
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}




.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    background: #fff;
    height: 100%;         
    box-sizing: border-box;
    padding: 0;            
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

</style>

<script type="text/javascript">

$(document).ready(function () {
     // Standardized height to 24px and width to 100%
     $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

     $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#clientDetailsWindow').jqxWindow('close');
    
     $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#nationalityWindow').jqxWindow('close');
    
     $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#stateWindow').jqxWindow('close');
    
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
     $('#txtclientname').dblclick(function(){
          clientSearchContent('clientDetailsSearch.jsp');
     });
     
     document.getElementById("rddriverlist").checked=true;
     $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
     document.getElementById("mode").value="A";
     
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
    
function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function nationalitySearchContent(url) {
    $('#nationalityWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#nationalityWindow').jqxWindow('setContent', data);
        $('#nationalityWindow').jqxWindow('bringToFront');
    }); 
}
  
function stateSearchContent(url) {
    $('#stateWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#stateWindow').jqxWindow('setContent', data);
        $('#stateWindow').jqxWindow('bringToFront');
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

function getVisaNoAlreadyExists(visano,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','ID# Already Exists.','warning');
                 return 0;
             }
        }
    }
    x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
    x.send();
}
  
function getPassportNoAlreadyExists(passportno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                $.messager.alert('Message','Passport# Already Exists.','warning');
                 return 0;
             }
        }
    }
    x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function getClient(event){
      var x= event.keyCode;
      if(x==114){
          clientSearchContent('clientDetailsSearch.jsp');
      }
}

function funreload(event) {
    var branchval = document.getElementById("cmbbranch").value;
    var cldocno = $('#txtcldocno').val();
    
    if(document.getElementById("rddriverlist").checked==true) {
        $("#overlay, #PleaseWait").show();
        $("#driverListDiv").load("driverListGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
    } else if(document.getElementById("rdadditionaldriver").checked==true) {
         if(cldocno==''){
             $.messager.alert('Message','Choose a Client and Add Driver.','warning');
             return 0;
         }
        
         var row = $("#addDriverGridID").jqxGrid('getrows');
         if(row.length>=1){
            if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
                 $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
                 return 0;
             }
         }
            
    } else if(document.getElementById("rddeletedriver").checked==true) {
        if(cldocno==''){
             $.messager.alert('Message','Choose a Client and Remove Driver.','warning');
             return 0;
         }
        $("#overlay, #PleaseWait").show();$('#btndelete').attr('disabled', false );
        $("#deleteDriverDiv").load("deleteDriverGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
    }
}

function funAdd(event){
    var cldocno = $('#txtcldocno').val();
    var branch = $('#cmbbranch').val();
    
    if(branch=='a'){
         branch='1';
     }
    
    if(cldocno==''){
         $.messager.alert('Message','Client is Mandatory.','warning');
         return 0;
     }
    
    var row = $("#addDriverGridID").jqxGrid('getrows');
    if(row.length>=1){
        if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
             $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
             return 0;
         }
    }
    
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
            return false; 
        } else {
            var rows = $("#addDriverGridID").jqxGrid('getrows');   
            var gridlength = rows.length-2;
            for (var i = 0; i < rows.length; i++) {
                var chk=rows[i].name;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk.trim()!=""){
                    saveGridData(cldocno,rows[i].name,rows[i].hiddob,rows[i].nation1,rows[i].mobno,rows[i].passport_no,rows[i].hidpassexp,rows[i].dlno,rows[i].hidissdate,rows[i].issfrm,rows[i].hidled,rows[i].ltype,rows[i].visano,rows[i].hidvisaexp,rows[i].dr_id,rows[i].hcdlno,rows[i].hidhcissdate,rows[i].hidhcled,branch,i,gridlength);
                }
            }
        }
     });
}

function funDelete(event){
    var cldocno = $('#txtcldocno').val();
    var branch = $('#cmbbranch').val();
    
    if(branch=='a'){
         branch='1';
     }
    
    if(cldocno==''){
         $.messager.alert('Message','Client is Mandatory.','warning');
         return 0;
     }
    
    var selectedrows=$("#deleteDriverGridID").jqxGrid('selectedrowindexes');
    selectedrows = selectedrows.sort(function(a,b){return a - b});
    
    if(selectedrows.length==0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select Drivers to be Removed.');
        return false;
    }
    
    $.messager.confirm('Message', 'Do you want to remove?', function(r){
        if(r==false) {
            return false; 
        } else {
            var rows = $("#deleteDriverGridID").jqxGrid('getrows');
            var i=0;var j=0;var k=0;var tempdrid="";
            for (i = 0; i < rows.length; i++) {
                if(selectedrows[j]==i){
                    if(k==0){
                        tempdrid=rows[i].dr_id;
                        k=1;
                    } else{
                        tempdrid=tempdrid+","+rows[i].dr_id;
                    }
                j++; 
              }
            }
            $('#txtselecteddrivers').val(tempdrid);
            removeGridData(cldocno,$('#txtselecteddrivers').val(),branch);
        }
     });
}

function saveGridData(cldocno,drivername,dob,nation,mobno,passportno,passexp,dlno,issdate,issfrm,led,ltype,visano,visaexp,drid,hcdlno,hcissdate,hcled,branch,i,gridlength) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim();
            var cldocno = $('#txtcldocno').val('');
            var clientname = $('#txtclientname').val(''); 
            
             if(items==gridlength){
                $.messager.alert('Message', ' Record Successfully Inserted ', function(r){ });
             }

             $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
             $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
             $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val('');
            
             if (document.getElementById("txtclientname").value == "") {
                    $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
             }
       }
    }
        
x.open("GET","saveData.jsp?cldocno="+cldocno+"&drivername="+drivername+"&dob="+dob+"&nation="+nation+"&mobno="+mobno+"&passportno="+passportno+"&passexp="+passexp+"&dlno="+dlno+"&issdate="+issdate+"&issfrm="+issfrm+"&led="+led+"&ltype="+ltype+"&visano="+visano+"&visaexp="+visaexp+"&drid="+drid+"&hcdlno="+hcdlno+"&hcissdate="+hcissdate+"&hcled="+hcled+"&branch="+branch+"&index="+i,true);
x.send();
}

function removeGridData(cldocno,selecteddrivers,branch) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim();
            var cldocno = $('#txtcldocno').val('');
            var clientname = $('#txtclientname').val(''); 
            
             if(items.trim()=='1'){
                $.messager.alert('Message', ' Driver is in an Agreement. ', function(r){ });
             } else {
                 $.messager.alert('Message', ' Record Successfully Removed ', function(r){ }); 
             }

             $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
             $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
             $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val(''); 
            
             if (document.getElementById("txtclientname").value == "") {
                    $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
             }
       }
    }
        
x.open("GET","removeData.jsp?cldocno="+cldocno+"&selecteddrivers="+selecteddrivers+"&branch="+branch,true);
x.send();
}

function  funClearData() {
    $('#cmbbranch').val('a');$('#txtselecteddrivers').val('');
    $('#txtcldocno').val('');$('#txtclientname').val('');
    document.getElementById("rddriverlist").checked=true;
    $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
    $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear');
    
    if (document.getElementById("txtclientname").value == "") {
        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
    }
 }

function radioClick() {
    if(document.getElementById("rddriverlist").checked==true){
         $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true);
         $('#txtcldocno').val('');$('#txtclientname').val('');
         $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
         if (document.getElementById("txtclientname").value == "") {
                $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
         }
    } else if(document.getElementById("rdadditionaldriver").checked==true || document.getElementById("rddeletedriver")?.checked==true){
         // Preserved logic if those radios ever exist
         $('#btnadd').attr('disabled', false );$('#btndelete').attr('disabled', true );
         $('#txtcldocno').val('');$('#txtclientname').val('');
         $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
         $("#addDriverGridID").jqxGrid('addrow', null, {});
         if (document.getElementById("txtclientname").value == "") {
                $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
         }
    }
}

function funExportBtn(){
    $("#driverListDiv").excelexportjs({
        containerid: "driverListDiv", 
        datatype: 'json', 
        dataset: null, 
        gridId: "driverListGridID", 
        columns: getColumns("driverListGridID") ,   
        worksheetName:"Driver List"
    });
}
</script>
</head>

<body onload="getBranch();getIDPDetails();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">
<div class="master-container">

    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <fieldset>
                    <legend>Report Type</legend>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="rddriverlist" name="rdo" value="rddriverlist" onchange="radioClick();">
                            Driver List
                        </label>
                    </div>
                </fieldset>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Client Name</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname"
                                   placeholder="Press F3 to Search" readonly
                                   onkeydown="getClient(event);"
                                   value='<s:property value="txtclientname"/>'>
                        </td>
                    </tr>
                </table>

                <button type="button" class="btn-submit" onclick="funClearData();">
                    Clear
                </button>
            </div>

            <div style="display:none;">
                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="txtselecteddrivers" name="txtselecteddrivers" value='<s:property value="txtselecteddrivers"/>'>
                <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
                <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed">
                <div id="fromdate"></div>
                <div id="todate"></div>
            </div>

        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="driverListDiv">
                <jsp:include page="driverListGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>

<div id="clientDetailsWindow"><div></div></div>
<div id="nationalityWindow"><div></div></div>
<div id="stateWindow"><div></div></div>

</div>
</div>

</body>
</html>