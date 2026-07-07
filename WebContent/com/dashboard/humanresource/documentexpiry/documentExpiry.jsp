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

<style>
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

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    height: 24px;              
    padding: 2px 8px;          
}

textarea {
    padding: 6px 8px;
    resize: none;
    font-family: inherit;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
select:disabled,
textarea[readonly],
.release-filter-table input[readonly],
.release-filter-table input:disabled,
.release-filter-table textarea[readonly] {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="date"],
.release-filter-table div[id^="uptodate"],
.release-filter-table div[id^="expiryDate"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
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
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.release-actions {
    display: flex;
    gap: 8px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    flex: 1;
    min-width: 0;
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
    display: flex;
    flex-direction: column;
    gap: 15px;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}

.grid-wrapper {
    flex: 1;
    min-height: 250px;
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
        
         $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#expiryDate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
        
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
    });

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
                    optionsbranch += '<option value="' + srno[i].trim() + '">'
                            + process[i] + '</option>';
                }
                $("select#cmbprocess").html(optionsbranch);
                
            } else {}
        }
        x.open("GET","getProcess.jsp", true);
        x.send();
    }

    function  funClearData(){
        $('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#empinfo').val('');$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
        $('#expiryDate').val(new Date());$('#txtempdocno').val('');$('#txtempid').val('');$('#txtbranch').val('');$('#txtdocument').val('');$('#txtdocumentid').val('');disable();
        $("#documentsExpiry").jqxGrid('clear');$("#documentsExpiry").jqxGrid('addrow', null, {});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
    }
    
    function funExportBtn(){
        $("#documentExpiryDiv").excelexportjs({
            containerid: "documentExpiryDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "documentsExpiry", 
            columns: getColumns("documentsExpiry") ,   
            worksheetName:"DocumentsExpiry"
            });
    }  
    
    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var uptodate = $('#uptodate').val();

         $('#cmbprocess').val('');$('#date').val(new Date());$('#expiryDate').val(new Date());$('#txtbranch').val('');$('#txtempdocno').val('');$('#txtremarks').val('');
         $('#txtempid').val('');$('#txtdocument').val('');$('#txtdocumentid').val('');$('#update').attr("disabled",true);$('#cmbprocess').attr("disabled",true);$('#date').jqxDateTimeInput({ disabled: true});
         $("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
         $("#overlay, #PleaseWait").show();
        
         $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
    }

    function disable(){
         $('#date').jqxDateTimeInput({ disabled: true});
         $('#cmbprocess').attr("disabled",true);
         $('#txtremarks').attr("readonly",true);
         $('#update').attr("disabled",true);
    }
    
    function funUpdate(event){
        var process = $('#cmbprocess option:selected').text();
        var date =  $('#date').val();
        var branchid = $('#txtbranch').val();
        var empdocno = $('#txtempdocno').val();
        var expirydate = $('#expiryDate').val();
        var remarks = $('#txtremarks').val();
        var empid = $('#txtempid').val();
        var documentid = $('#txtdocumentid').val();
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
                
            if(r==false)
              {
                return false; 
              }
            else{
                saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid);  
            }
        });
    }
    
    function saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid){
        
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200){
                    
                var items=x.responseText;
                
                var process = $('#cmbprocess').val('');
                $('#date').val(new Date());
                var branchid = $('#txtbranch').val('');
                var empdocno = $('#txtempdocno').val('');
                $('#expiryDate').val(new Date());
                var remarks = $('#txtremarks').val('');
                var empid = $('#txtempid').val('');
                var document = $('#txtdocument').val('');
                var documentid = $('#txtdocumentid').val('');
                
                $.messager.alert('Message', '  Record Successfully Updated ', function(r){
                });
                funreload(event); 
                disable();
                $('#empinfo').val('');
                }
        }
            
    x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&empdocno="+empdocno+"&expirydate="+expirydate+"&remarks="+remarks+"&empid="+empid+"&document="+document+"&documentid="+documentid,true);
    x.send();
            
    }
    
</script>
</head>
<body onload="getBranch();getProcess();disable();">

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="release-filter-table">

                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <textarea id="empinfo"
                                          name="empinfo"
                                          readonly
                                          style="height: 80px;"
                                          placeholder="Employee Info..."><s:property value="empinfo"/></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Process</td>
                            <td>
                                <select id="cmbprocess" name="cmbprocess"></select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="date" name="date" value='<s:property value="date"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text"
                                       id="txtremarks"
                                       name="txtremarks"
                                       value='<s:property value="txtremarks"/>'>
                            </td>
                        </tr>

                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>
                        <button type="button" class="btn-submit" id="update" onclick="funUpdate(event);">Update</button>
                    </div>
                </div>

                <input type="hidden" id="expiryDate" name="expiryDate" value='<s:property value="expiryDate"/>'>
                <input type="hidden" id="txtempdocno" name="txtempdocno" value='<s:property value="txtempdocno"/>'>
                <input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'>
                <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'>
                <input type="hidden" id="txtdocument" name="txtdocument" value='<s:property value="txtdocument"/>'>
                <input type="hidden" id="txtdocumentid" name="txtdocumentid" value='<s:property value="txtdocumentid"/>'>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div class="grid-wrapper" id="documentExpiryDiv">
                    <jsp:include page="documentExpiryGrid.jsp"></jsp:include>
                </div>

                <div class="grid-wrapper" id="detailDiv">
                    <jsp:include page="detailGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

</div>
</body>
</html>