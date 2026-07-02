<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

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

.card-title {
    font-size: 13px;
    font-weight: 700;
    color: #2563eb;
    margin-bottom: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 1px solid #e1e8ed;
    padding-bottom: 6px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 60px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
}

/* Readonly / disabled look */
input[readonly], input:disabled, 
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
    width: 100%;
}

/* Radio Button Layout */
.radio-group {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    margin-top: 5px;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.radio-group input[type="radio"] {
    margin: 0 6px 0 0;
}

/* ===== BUTTONS ===== */
.action-buttons {
    display: flex;
    gap: 8px;
    margin-top: 15px;
}

.btn-submit {
    flex: 1;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover:not(:disabled) { background: #1d4ed8; }
.btn-submit.btn-secondary { background: #64748b; }
.btn-submit.btn-secondary:hover:not(:disabled) { background: #475569; }

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

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
         // Standardized height to 24px and width to 100%
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         
         $('#assetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Asset Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#assetDetailsWindow').jqxWindow('close');
         
         $('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#groupDetailsWindow').jqxWindow('close');
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
          $('#txtasset').dblclick(function(){
              assetSearchContent('assetSearchGrid.jsp?check=1');
          });
          
          $('#txtgroup').dblclick(function(){
              groupSearchContent('groupSearchGrid.jsp?check=1');
          });
            
         document.getElementById("rdall").checked=true;
         
    });
    
    function funExportBtn(){
        $("#assetDiv").excelexportjs({
            containerid: "assetDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "fixedAssetRegisterGrid", 
            columns: getColumns("fixedAssetRegisterGrid") ,   
            worksheetName:"FixedAssetRegister"
            });
    } 
    
    function assetSearchContent(url) {
        $('#assetDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#assetDetailsWindow').jqxWindow('setContent', data);
            $('#assetDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
    
    function groupSearchContent(url) {
        $('#groupDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#groupDetailsWindow').jqxWindow('setContent', data);
            $('#groupDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
    
    function getAsset(event){
        var x= event.keyCode;
        if(x==114){
            assetSearchContent('assetSearchGrid.jsp?check=1');
        }
    }
    
    function getGroup(event){
        var x= event.keyCode;
        if(x==114){
            groupSearchContent('groupSearchGrid.jsp?check=1');
        }
    }

    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var assetno = $('#txtasset').val();
         var group = $('#txtgroupno').val();
         var check=1;
         
         $("#overlay, #PleaseWait").show();
         
         if(document.getElementById("rdall").checked==true){
             $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
         }else if(document.getElementById("rdsold").checked==true){
             $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
         }else{
             $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
         }
    }
    
    function funClearInfo(){
        $('#fromdate').val(new Date());
        var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
        var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
        $('#todate').val(new Date());
        
        document.getElementById("txtasset").value="";
        document.getElementById("txtgroup").value="";
        document.getElementById("txtgroupno").value="";
        
        document.getElementById("rdall").checked=true;
        
         if (document.getElementById("txtgroup").value == "") {
                $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
         }
         if (document.getElementById("txtasset").value == "") {
                $('#txtasset').attr('placeholder', 'Press F3 to Search'); 
         }
    }
    
    function funPrint() {
        var branchval = document.getElementById("cmbbranch").value;
        var rpttype=0;
        
        if(document.getElementById("rdall").checked==true){
            rpttype=1;
        }
        else if(document.getElementById("rdsold").checked==true){
            rpttype=2;
        }
        else{
            rpttype=3;
        }
        
         var assetno = $('#txtasset').val();
         var group = $('#txtgroupno').val();    
         
         if ($("#cldocno").val()!="") {
             var url=document.URL;
             var reurl=url.split("fixedAssetRegister.jsp");
             var win= window.open(reurl[0]+"printfixedassetregister?rpttype="+rpttype+"&branchval="+branchval+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val()+"&assetno="+assetno+"&group="+group,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
             win.focus();
         }
         else {
            $.messager.alert('Message','Please Select a Client.','warning');
            return;
        }
     }
</script>
</head>

<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Asset</td>
                            <td>
                                <input type="text" id="txtasset" name="txtasset"
                                       placeholder="Press F3 to Search" readonly
                                       value='<s:property value="txtasset"/>'
                                       onkeydown="getAsset(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Group</td>
                            <td>
                                <input type="text" id="txtgroup" name="txtgroup"
                                       placeholder="Press F3 to Search" readonly
                                       value='<s:property value="txtgroup"/>'
                                       onkeydown="getGroup(event);">
                                       
                                <input type="hidden" id="txtgroupno" name="txtgroupno" value='<s:property value="txtgroupno"/>'>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <div class="card-title">Report Type</div>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="rdall" name="rdo" value="rdall"> All
                        </label>
                        <label>
                            <input type="radio" id="rdsold" name="rdo" value="rdsold"> Sold
                        </label>
                        <label>
                            <input type="radio" id="rdadditions" name="rdo" value="rdadditions"> Additions
                        </label>
                    </div>

                    <div class="action-buttons">
                        <button type="button" class="btn-submit btn-secondary" onclick="funClearInfo();">Clear</button>
                        <button type="button" class="btn-submit" onclick="funPrint();">Print</button>
                    </div>
                </div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="assetDiv">
                    <jsp:include page="fixedAssetRegisterGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="assetDetailsWindow"><div></div><div></div></div>
    <div id="groupDetailsWindow"><div></div><div></div></div>

</div>
</body>
</html>