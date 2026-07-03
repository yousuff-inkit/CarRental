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
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
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
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 120px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         $('#txtemployeeid').attr('readonly', true);
         $('#txtemployeename').attr('readonly', true);
         
         $('#txtemployeeid').dblclick(function(){
                employeeSearchContent("employeeDetailsSearch.jsp");
              });
    });
    
    function employeeSearchContent(url) {
        $('#employeeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
    }

    function getDepartment() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var departmentItems = items[0].split(",");
                var departmentIdItems = items[1].split(",");
                var optionsdepartment = '<option value="">--Select--</option>';
                for (var i = 0; i < departmentItems.length; i++) {
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                            + departmentItems[i] + '</option>';
                }
                $("select#cmbempdepartment").html(optionsdepartment);
            } else {
            }
        }
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }
    
    function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
                            + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbempcategory").html(optionspayrollcategory);
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
            employeeSearchContent("employeeDetailsSearch.jsp");
        }
    }
    
    function funClearInfo(){
        $('#cmbbranch').val('a');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
        $('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
        $("#employeeDetailedListGridId").jqxGrid('clear');$("#employeeDetailedListGridId").jqxGrid('addrow', null, {});
    }
    
    function funExportBtn(){ 
        $("#employeeDetailedListDiv").excelexportjs({
            containerid: "employeeDetailedListDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "employeeDetailedListGridId", 
            columns: getColumns("employeeDetailedListGridId") ,      
            worksheetName:"EmployeeDetailedList"
            });
    } 
    
    function funreload(event){
         var department=$('#cmbempdepartment').val();
         var category=$('#cmbempcategory').val();
         var empId=$('#txtemployeedocno').val();
         var employeebranchchk=window.parent.employeebranchchk.value; 
         var branch=document.getElementById("cmbbranch").value;  
         $("#overlay, #PleaseWait").show();
         
         $("#employeeDetailedListDiv").load("employeeDetailedListGrid.jsp?department="+department+"&category="+category+"&empId="+empId+"&check=1"+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
    }
</script>
</head>

<body onload="getBranch();getDepartment();getPayrollCategory();">
<div id="mainBG" class="homeContent" data-type="background"> 

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Department</td>
                            <td>
                                <select id="cmbempdepartment" name="cmbempdepartment">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbempcategory" name="cmbempcategory">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Employee</td>
                            <td>
                                <input type="text"
                                       id="txtemployeeid"
                                       name="txtemployeeid"
                                       placeholder="Press F3 to Search"
                                       readonly
                                       onkeydown="getEmployeeId(event);"
                                       value='<s:property value="txtemployeeid"/>'>

                                <input type="hidden"
                                       id="txtemployeedocno"
                                       name="txtemployeedocno"
                                       value='<s:property value="txtemployeedocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="text"
                                       id="txtemployeename"
                                       name="txtemployeename"
                                       placeholder="Employee Name"
                                       readonly
                                       tabindex="-1"
                                       value='<s:property value="txtemployeename"/>'>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" onclick="funClearInfo();">Clear</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="employeeDetailedListDiv">
                    <jsp:include page="employeeDetailedListGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div> 

    <div id="employeeDetailsWindow">
        <div></div>
    </div>

</div>
</body>
</html>