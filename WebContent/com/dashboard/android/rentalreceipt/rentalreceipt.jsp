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
.release-filter-table div[id^="fdate"],
.release-filter-table div[id^="tdate"] {
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
     $("#fdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
     $("#tdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"}); 
});

 function updateStatus(){
     var barchval = document.getElementById("cmbbranch").value;
    if(barchval=='a'){
        $.messager.alert('Message',"Please Select a branch");
    }
    else{
     $.messager.confirm('Message', 'Do you want to Generate?', function(r){
            
        if(r==false)
          {
            return false; 
          }
        else{
                
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
         if (x.readyState == 4 && x.status == 200) {
            var itm = x.responseText;
            var items=itm.split("::");
            var val1=items[1].trim();
            if(items[0].trim()=="1"){
                    $.messager.alert('Message',"Rental Receipt '"+val1+"'  Successfully Generated");
                        
                    funreload(this);
                    $("#detailsgrid").jqxGrid('clear');
                  
            }
                else{
                    $.messager.alert('Message',"Not Generated");
                    funreload(this);
                    $("#detailsgrid").jqxGrid('clear'); 
                }

        } else {
        }
    }
    //alert("date1="+document.getElementById("date1").value+"&doc="+document.getElementById("doc").value+"&brno="+document.getElementById("brno").value+"&type="+document.getElementById("type").value+"&ctype="+document.getElementById("ctype").value+"&chkno="+document.getElementById("chkno").value+"&chkdate="+document.getElementById("chkdate").value+"&amount="+document.getElementById("amount").value+"&desc="+document.getElementById("desc").value+"&cldocno="+document.getElementById("cldocno").value+"&txtacno="+document.getElementById("txtacno").value+"&txtdoc="+document.getElementById("txtdoc").value);
    x.open("GET", "updateStatus.jsp?date1="+document.getElementById("date1").value+"&doc="+document.getElementById("doc").value+"&brno="+document.getElementById("brno").value+"&type="+document.getElementById("type").value+"&ctype="+document.getElementById("ctype").value+"&chkno="+document.getElementById("chkno").value+"&chkdate="+document.getElementById("chkdate").value+"&amount="+document.getElementById("amount").value+"&desc="+document.getElementById("desc").value+"&cldocno="+document.getElementById("cldocno").value+"&txtacno="+document.getElementById("txtacno").value+"&txtdoc="+document.getElementById("txtdoc").value, true);
    x.send();
    
        }
     });
    }
 } 
 
 function funreload(event)
{
     document.getElementById("btnUpdate").disabled=true;
    
    $('input[type=text],[type=hidden]').val('');
        var barchval = document.getElementById("cmbbranch").value;
    
    var fdateval = $("#fdate").val();
    var tdateval = $("#tdate").val();
      $("#fleetdiv").load("rentalreceiptGrid.jsp?branchval="+barchval+"&fdate1="+fdateval+"&tdate1="+tdateval);
      
    }

    
 function funExportBtn(){
      
     $("#fleetdiv").excelexportjs({
         containerid: "fleetdiv", 
         datatype: 'json', 
         dataset: null, 
         gridId: "rentalreceiptGrid", 
         columns: getColumns("rentalreceiptGrid") , 
         worksheetName:"Rental Receipt List"
         });
      // JSONToCSVConvertor(rentalexcel, 'Rental Receipt List', true);
       }
      
      
  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
      
     // alert("arrData");
      var CSV = '';    
      //Set Report title in first row or line
      
      CSV += ReportTitle + '\r\n\n';

      //This condition will generate the Label/Header
      if (ShowLabel) {
          var row = "";
          
          //This loop will extract the label from 1st index of on array
          for (var index in arrData[0]) {
              
              //Now convert each value to string and comma-seprated
              row += index + ',';
          }

          row = row.slice(0, -1);
          
          //append Label row with line break
          CSV += row + '\r\n';
      }
      
      //1st loop is to extract each row
      for (var i = 0; i < arrData.length; i++) {
          var row = "";
          
          //2nd loop will extract each column and convert it in string comma-seprated
          for (var index in arrData[i]) {
              row += '"' + arrData[i][index] + '",';
          }

          row.slice(0, row.length - 1);
          
          //add a line break after each row
          CSV += row + '\r\n';
      }

      if (CSV == '') {        
          alert("Invalid data");
          return;
      }   
      
      //Generate a file name
      var fileName = "";
      //this will remove the blank-spaces from the title and replace it with an underscore
      fileName += ReportTitle.replace(/ /g,"_");   
      
      //Initialize file format you want csv or xls
      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
      
      // Now the little tricky part.
      // you can use either>> window.open(uri);
      // but this will not work in some browsers
      // or you will not get the correct file extension    
      
      //this trick will generate a temp <a /> tag
      var link = document.createElement("a");     
      link.href = uri;
      
      //set the visibility hidden so it will not effect on your web-layout
      link.style = "visibility:hidden";
      link.download = fileName + ".csv";
      
      //this part will append the anchor tag and remove it after automatic click
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
  }

</script>
</head>
<body onload="getBranch();">
<form autocomplete="off" id="rentalform">

<div id="mainBG" class="homeContent" data-type="background"> 

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="release-filter-table">

                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fdate" name="fdate" value='<s:property value="fdate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="tdate" name="tdate" value='<s:property value="tdate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <textarea id="recdetails"
                                          name="recdetails"
                                          rows="5"
                                          readonly
                                          placeholder="Receipt Details..."></textarea>
                            </td>
                        </tr>

                    </table>

                    <div class="release-actions">
                        <button type="button"
                                id="btnUpdate"
                                class="btn-submit"
                                onclick="updateStatus();">
                            Generate
                        </button>
                    </div>
                </div>

                <input type="hidden" id="doc" name="doc">
                <input type="hidden" id="date1" name="date1">
                <input type="hidden" id="cname" name="cname">
                <input type="hidden" id="type" name="type">
                <input type="hidden" id="chkno" name="chkno">
                <input type="hidden" id="chkdate" name="chkdate">
                <input type="hidden" id="amount" name="amount">
                <input type="hidden" id="ctype" name="ctype">
                <input type="hidden" id="desc" name="desc">
                <input type="hidden" id="brno" name="brno">
                <input type="hidden" id="cldocno" name="cldocno">
                <input type="hidden" id="txtdoc" name="txtdoc">
                <input type="hidden" id="txtacno" name="txtacno">

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div class="grid-wrapper" id="fleetdiv">
                    <jsp:include page="rentalreceiptGrid.jsp"></jsp:include>
                </div>

                <div class="grid-wrapper" id="detaildiv">
                    <jsp:include page="followDetailgrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
    
    <input type="hidden" name="docno" id="docno">
</div>

<label id="trncodeval" hidden="true"></label>
<label id="statusval" hidden="true"></label>

</form>
</body>
