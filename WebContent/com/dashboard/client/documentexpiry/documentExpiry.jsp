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
input[type="text"], select, textarea {
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

textarea {
    height: 80px !important;
    resize: none;
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

input[readonly], input:disabled, select:disabled, textarea[readonly] {
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

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.sidebar-filters label.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
         document.getElementById('activeradio').checked=true;   
         // Standardized height to 24px and width to 100%
         $("#uptodate, #date, #expiryDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         $('#clientwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
         $('#clientwindow').jqxWindow('close');
         
         $('#clientname').dblclick(function(){  
           $('#clientwindow').jqxWindow('open');
           clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
         });
    });
    
    function getclinfo(event){
         var x= event.keyCode;
        if(x==114){
            $('#clientwindow').jqxWindow('open');
            clientSearchContent('clientsearch.jsp', $('#clientwindow'));    
        }
    } 

    function clientSearchContent(url) {
        $.get(url).done(function (data) {
            $('#clientwindow').jqxWindow('open');
            $('#clientwindow').jqxWindow('setContent', data);
        }); 
    } 
        
    function getProcess() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                
                var srno  = items[0].split(",");
                var process = items[1].split(",");
                var optionsbranch = '<option value="" selected>-- Select -- </option>';
                for (var i = 0; i < process.length; i++) {
                    optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
                }
                $("select#cmbprocess").html(optionsbranch);
                
            }
        }
        x.open("GET","getProcess.jsp", true);
        x.send();
    }

    function funClearData(){  
        $('#clientname').val(''); $('#cldocno').val('');$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#clientinfo').val('');$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
        $('#expiryDate').val(new Date());$('#txtcldocno').val('');$('#txtdriver').val('');$('#txtbranch').val('');$('#txtdocument').val('');disable();
        $("#documentExpiry").jqxGrid('clear');$("#documentExpiry").jqxGrid('addrow', null, {});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
     }
    
    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var uptodate = $('#uptodate').val();
         var cldocno = $('#cldocno').val();   
         var active=1;  
         if(document.getElementById('inactiveradio').checked){
             active=0;
         }else if(document.getElementById('activeradio').checked){
             active=1;  
         }
         $('#cmbprocess').val('');$('#date').val(new Date());$('#expiryDate').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#txtremarks').val('');
         $('#txtdriver').val('');$('#txtdocument').val('');$('#btnupdate').attr("disabled",true);$('#cmbprocess').attr("disabled",true);$('#date').jqxDateTimeInput({ disabled: true});
         $("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
         $("#overlay, #PleaseWait").show();
        
         $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&active='+active+'&cldocno='+cldocno+'&uptodate='+uptodate+'&check=1');
    }

    function disable(){
         $('#date').jqxDateTimeInput({ disabled: true});
         $('#cmbprocess').attr("disabled",true);
         $('#txtremarks').attr("readonly",true);
         $('#btnupdate').attr("disabled",true);
    }
    
    function funUpdate(event){
        var process = $('#cmbprocess').val();
        var date =  $('#date').val();
        var branchid = $('#txtbranch').val();
        var cldocno = $('#txtcldocno').val();
        var expirydate = $('#expiryDate').val();
        var remarks = $('#txtremarks').val();
        var driversrno = $('#txtdriver').val();
        var document = $('#txtdocument').val();
        
        if(process==''){
             $.messager.alert('Message','Choose a Process.','warning');
             return 0;
         }

         if(remarks==''){
             $.messager.alert('Message','Please Enter Remarks.','warning');   
             return 0;
         }
        
         $.messager.confirm('Message', 'Do you want to save changes?', function(r){
            if(r==false) {
                return false; 
            } else{
                saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document);   
            }
        });
    }
    
    function saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200){
                var items=x.responseText;
                var process = $('#cmbprocess').val('');
                $('#date').val(new Date());
                var branchid = $('#txtbranch').val('');
                var cldocno = $('#txtcldocno').val('');
                $('#expiryDate').val(new Date());
                var remarks = $('#txtremarks').val('');
                var driversrno = $('#txtdriver').val('');
                var document = $('#txtdocument').val('');
                
                $.messager.alert('Message', ' Record Successfully Updated ', function(r){ });
                funreload(event); 
                disable();
                $('#clientinfo').val('');
            }
        }
            
    x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&driversrno="+driversrno+"&document="+document,true);
    x.send();
            
    }
    
    function funExportBtn(){
         $("#documentExpiryDiv").excelexportjs({
                containerid: "documentExpiryDiv",   
                datatype: 'json',
                dataset: null,
                gridId: "documentExpiry",
                columns: getColumns("documentExpiry") ,   
                worksheetName:"Document Expiry"  
            });   
    }
</script>
</head>

<body onload="getBranch();getProcess();disable();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width="330px" valign="top">
    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" name="clientname" id="clientname" 
                                       placeholder="Press F3 To Search" readonly="readonly" 
                                       onKeyDown="getclinfo(event);" 
                                       value='<s:property value="clientname"/>'>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="radio-group">
                        <label class="branch"><input type="radio" id="inactiveradio" name="activity"> Inactive</label>
                        <label class="branch"><input type="radio" id="activeradio" name="activity"> Active</label>
                    </div>
                </div>

                <div class="filter-card">
                    <textarea id="clientinfo" name="clientinfo" readonly="readonly" placeholder="Client Info"><s:property value="clientinfo" ></s:property></textarea>
                </div>

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Process</td>
                            <td><select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td><input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/></td>
                        </tr>
                    </table>
                    
                    <div class="button-group" style="margin-top: 15px;">
                        <button class="btn-submit" type="button" name="clear" id="clear" onclick="funClearData();">Clear</button>
                        <button class="btn-submit" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
                    </div>
                </div>

                <div style="display:none;">
                    <div id='expiryDate' name='expiryDate' value='<s:property value="expiryDate"/>'></div>
                    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                    <input type="hidden" id="txtdriver" name="txtdriver" value='<s:property value="txtdriver"/>'/>
                    <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                    <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>      
                    <input type="hidden" id="txtdocument" name="txtdocument" value='<s:property value="txtdocument"/>'/>
                </div>

            </div>
        </div>
    </div>
</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="documentExpiryDiv">
                <jsp:include page="documentExpiryGrid.jsp"></jsp:include>
            </div>
            
            <div style="height:15px;"></div>
            
            <div id="detailDiv">
                <jsp:include page="detailGrid.jsp"></jsp:include>
            </div>
            
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<div id="clientwindow">
    <div></div><div></div>
</div>

</body>
</html>