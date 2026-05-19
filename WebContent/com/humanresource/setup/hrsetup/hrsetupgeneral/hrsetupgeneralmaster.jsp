<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   1. YOUR ORIGINAL PAGE & WRAPPER STYLES (UNTOUCHED)
========================================================= */
form label.error {
    color:red;
    font-weight:bold;
    font-size: 11px;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: 80vh;
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }

html, body {
    background: #ffffff;                
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;                     
    color: #333;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.windowCont,
#mainBG.homeContent {
    background: #ffffff !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 8px;
    padding: 16px 18px;
    max-width: 1400px;
    margin: 0 auto;
    box-shadow: none;                    
}

/* =========================================================
   2. CASH RECEIPTS UI ELEMENTS (24px Forced Height)
========================================================= */
.middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 15px 15px 15px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 6px; 
    margin-bottom: 25px;
    margin-top: 25px; 
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 15px; 
    background: #ffffff; 
    padding: 0 10px; 
    color: #0056b3;
    font-weight: 700; 
    font-size: 14px; 
    border-left: 4px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Flexbox Layout for Rows & Columns */
.field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    width: 100%;
    flex-wrap: wrap;
    gap: 15px;
}

.lbl-right { 
    color: #1e293b;
    font-size: 12px; 
    font-weight: 600; 
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    white-space: nowrap; 
    text-align: right;
    min-width: 110px; 
}

/* Scoped 24px Inputs */
input[type="text"],
input[type="email"],
select { 
    height: 24px !important; 
    border: 1px solid #d1d5db; 
    border-radius: 4px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"]:focus,
input[type="email"]:focus,
select:focus { 
    border-color: #3b82f6; 
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

input[readonly],
input:disabled,
select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Checkbox Group Styling */
.checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
    height: 24px;
}
.checkbox-group label {
    font-weight: 600;
    color: #444;
    cursor: pointer;
    margin-right: 5px;
    font-size: 12px;
}
.checkbox-group input[type="checkbox"] {
    margin: 0;
}

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
}
</style>

<script type="text/javascript">

 $(document).ready(function () {
        
        if(document.getElementById("formdet")) document.getElementById("formdet").innerText="HR Setup(HRS)";
        if(document.getElementById("formdetail")) document.getElementById("formdetail").value="HR Setup";
        if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="HRS";
        if(window.parent && window.parent.formCode) window.parent.formCode.value="HRS"; 
        if(window.parent && window.parent.formName) window.parent.formName.value="HR Setup";
        
        /* COMPACT DATE/TIME SIZING (120px) */
        $("#masterdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});   
        $("#validfromdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});   
        $("#lastreviseddate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});   
        $("#workingtime").jqxDateTimeInput({ width: '120px', height: '24px', formatString:'HH:mm', showCalendarButton: false, theme: 'energyblue'}); 
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
    
        $('#formulawindow').jqxWindow({ width: '45%', height: '54%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Salary Calculation Formula' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27,theme: 'energyblue', showCloseButton: true});
        $('#formulawindow').jqxWindow('close');
        
        $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#accountSearchwindow').jqxWindow('close');
        
        $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#costTypeSearchGridWindow').jqxWindow('close');
        
        $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#costCodeSearchWindow').jqxWindow('close');
    
        getCategory();getleave();
      
        $('#convformula').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#formulawindow').jqxWindow('open');
            var id="convformula";
            formulaSearchContent('formula.jsp?id='+id);
        } 
    });   
    
   $('#normalrate').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#formulawindow').jqxWindow('open');
            var id="normalrate";
            formulaSearchContent('formula.jsp?id='+id);
       } 
    });   
        
   $('#ot').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#formulawindow').jqxWindow('open');
            var id="ot";
            formulaSearchContent('formula.jsp?id='+id);
        }  
    });   
        
    $('#holidayot').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#formulawindow').jqxWindow('open');
            var id="holidayot";
            formulaSearchContent('formula.jsp?id='+id);
       } 
     });   
  
    });
        
    function formulaSearchContent(url) {
        $.get(url).done(function (data) {
            $('#formulawindow').jqxWindow('setContent', data);
        }); 
    }

    function accountSearchContent(url) {
        if($('#mode').val()!="view") {   
            $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('open');
            $('#accountSearchwindow').jqxWindow('setContent', data);
            }); 
        }
    }
    
    function costTypeSearchContent(url) {
        $('#costTypeSearchGridWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#costTypeSearchGridWindow').jqxWindow('setContent', data);
        $('#costTypeSearchGridWindow').jqxWindow('bringToFront');
        }); 
    }

    function costCodeSearchContent(url) {
        $('#costCodeSearchWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#costCodeSearchWindow').jqxWindow('setContent', data);
        $('#costCodeSearchWindow').jqxWindow('bringToFront');
        }); 
    }
 
    function getconfor(event){
        var x= event.keyCode;
        if($('#mode').val()!="view") {  
        if(x==114){
            $('#formulawindow').jqxWindow('open');
            var id="convformula";
            formulaSearchContent('formula.jsp?id='+id);
     } else{}
         }  
     }
 
    function getnr(event){
        var x= event.keyCode;
        if($('#mode').val()!="view") {  
        if(x==114){
          $('#formulawindow').jqxWindow('open');
          var id="normalrate";
          formulaSearchContent('formula.jsp?id='+id);
     } else{}
        }  
     }
    
    function getot(event){
        var x= event.keyCode;
        if($('#mode').val()!="view") { 
        if(x==114){
          $('#formulawindow').jqxWindow('open');
          var id="ot";
          formulaSearchContent('formula.jsp?id='+id);
     } else{}
         }  
     }
 
    function getholyot(event){
        var x= event.keyCode;
        if($('#mode').val()!="view") {  
        if(x==114){
          $('#formulawindow').jqxWindow('open');
          var id="holidayot";
          formulaSearchContent('formula.jsp?id='+id);
     } else{}
         } 
     }
 
    function funReset(){ }
    
    /* SAFE READONLY FUNCTION */
    function funReadOnly(){
        try {
            $('#masterdate').jqxDateTimeInput({ disabled: true});
            $('#validfromdate').jqxDateTimeInput({ disabled: true});
            $('#lastreviseddate').jqxDateTimeInput({ disabled: true});
            $('#workingtime').jqxDateTimeInput({ disabled: true});
            $('#frmhrsetups input').attr('readonly', true );
            $('#frmhrsetups select').attr('disabled', true);
            $('#mon, #tue, #wed, #thu, #fri, #sat, #sun').attr('disabled', true);
            $('#leaveid').attr('disabled', true);
            $('#cmbcategory').attr('disabled', true);
            $('#carryforward').attr('disabled', true);
        } catch(e) { console.error("Error in funReadOnly: ", e); }
    }
    
    /* SAFE REMOVE READONLY FUNCTION */
    function funRemoveReadOnly(){
        try {
            $('#masterdate').jqxDateTimeInput({ disabled: false});
            $('#validfromdate').jqxDateTimeInput({ disabled: false});
            $('#lastreviseddate').jqxDateTimeInput({ disabled: false});
            $('#workingtime').jqxDateTimeInput({ disabled: false});
            $('#frmhrsetups input').attr('readonly', false );
            $('#frmhrsetups select').attr('disabled', false);
            $('#mon, #tue, #wed, #thu, #fri, #sat, #sun').attr('disabled', false);
            $('#leaveid').attr('disabled', false);
            $('#cmbcategory').attr('disabled', false);
            $('#carryforward').attr('disabled', false);
            $('#convformula').attr('readonly', true );
            $('#normalrate').attr('readonly', true );
            $('#ot').attr('readonly', true );
            $('#holidayot').attr('readonly', true );
            
             if ($("#mode").val() == "A") {
                 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp");
                 if($("#resiggrid").length) {
                     $("#resiggrid").jqxGrid('clear');
                     $("#resiggrid").jqxGrid('addrow', null, {});
                     $("#resiggrid").jqxGrid('addrow', null, {});
                     $("#resiggrid").jqxGrid('addrow', null, {});
                     $("#resiggrid").jqxGrid('addrow', null, {});
                     $("#resiggrid").jqxGrid({ disabled: false}); 
                 }
                 if($("#trmigrid").length) {
                     $("#trmigrid").jqxGrid('clear');
                     $("#trmigrid").jqxGrid('addrow', null, {});
                     $("#trmigrid").jqxGrid('addrow', null, {});
                     $("#trmigrid").jqxGrid('addrow', null, {});
                     $("#trmigrid").jqxGrid('addrow', null, {});
                     $("#trmigrid").jqxGrid({ disabled: false}); 
                 }
                 if($("#accset").length) $("#accset").load("accountsetupgrid.jsp"); 
             }
            
             if ($("#mode").val() == "E") {
                 if($("#resiggrid").length) {
                     $("#resiggrid").jqxGrid({ disabled: false}); 
                     $("#resiggrid").jqxGrid('addrow', null, {});
                 }
                 if($("#trmigrid").length) {
                     $("#trmigrid").jqxGrid({ disabled: false}); 
                     $("#trmigrid").jqxGrid('addrow', null, {});
                 }
                 if($("#accountsetup").length) $("#accountsetup").jqxGrid({ disabled: false}); 
                
                 var docVal1 = document.getElementById("docno") ? document.getElementById("docno").value : 0;
                 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1+"&modeval="+"E");
             }
        } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
    }
 
    function funNotify(){   
          var z=0;
          if($("#benifitsgrid").length) {
              var rows = $("#benifitsgrid").jqxGrid('getrows');      
              var selectedrows=$("#benifitsgrid").jqxGrid('selectedrowindexes');
                
              $('#benigridlength').val(selectedrows.length);
              for (var i = 0; i < rows.length; i++) {
                   for(var j=0;j<selectedrows.length;j++){
                    if(selectedrows[j]==i){
                       newTextBox = $(document.createElement("input"))
                       .attr("type", "dil")
                       .attr("id", "trbenitest"+z)
                       .attr("name", "trbenitest"+z)
                       .attr("hidden", "true");  
                    
                       newTextBox.val(rows[i].allowanceid+" :: ");
                       newTextBox.appendTo('form');
                       z++;
                    }
                   }
               }
          }
       
        if($("#trmigrid").length) {
            var rows = $("#trmigrid").jqxGrid('getrows');      
            $('#trmigridlength').val(rows.length);
            for(var i=0;i<rows.length;i++){
                newTextBox = $(document.createElement("input"))
                   .attr("type", "dil")
                   .attr("id", "termitest"+i)
                   .attr("name", "termitest"+i)
                   .attr("hidden", "true");  
            
                newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
                newTextBox.appendTo('form');
           }
        }
       
        if($("#resiggrid").length) {
            var rows = $("#resiggrid").jqxGrid('getrows');
            $('#resiggridlength').val(rows.length);
            for(var i=0;i<rows.length;i++){
                newTextBox = $(document.createElement("input"))
                   .attr("type", "dil")
                   .attr("id", "resigtest"+i)
                   .attr("name", "resigtest"+i)
                   .attr("hidden", "true");  
            
                newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
                newTextBox.appendTo('form');
           }
        }
        
        if($("#accountsetup").length) {
            var rows = $("#accountsetup").jqxGrid('getrows');
            $('#accountsetupgridlength').val(rows.length);
            for(var i=0;i<rows.length;i++){
                newTextBox = $(document.createElement("input"))
                   .attr("type", "dil")
                   .attr("id", "acnotest"+i)
                   .attr("name", "acnotest"+i)
                   .attr("hidden", "true");  
            
                newTextBox.val(rows[i].allowanceid+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
                newTextBox.appendTo('form');
           }
        }
        return 1;
    } 

    function funChkButton() { }

    function funSearchLoad(){
         changeContent('mastersearch.jsp'); 
    }
     
        
    function funFocus(){
        $('#masterdate').jqxDateTimeInput('focus');     
    }
    
    /* SAFE SET VALUES FUNCTION */
    function setValues() {
        try {
            if($('#hidmasterdate').length && $('#hidmasterdate').val()){
                $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
            }
               
            if($('#hidvalidfromdate').length && $('#hidvalidfromdate').val()){
                $("#validfromdate").jqxDateTimeInput('val', $('#hidvalidfromdate').val());
            }
               
            if($('#hidlastreviseddate').length && $('#hidlastreviseddate').val()){
                $("#lastreviseddate").jqxDateTimeInput('val', $('#hidlastreviseddate').val());
            }
               
            if($('#hidworkingtime').length && $('#hidworkingtime').val()){
                $("#workingtime").jqxDateTimeInput('val', $('#hidworkingtime').val());
            }
               
            if($('#msg').length && $('#msg').val()!=""){
                $.messager.alert('Message',$('#msg').val());
            }
            
              var docVal1 = document.getElementById("docno") ? document.getElementById("docno").value : 0;
              if(docVal1>0) {
                 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1);
                 if($("#trimi").length) $("#trimi").load("terminationdetailsgrid.jsp?docno="+docVal1);
                 if($("#resig").length) $("#resig").load("resignationdetailsgrid.jsp?docno="+docVal1);
                 if($("#accset").length) $("#accset").load("accountsetupgrid.jsp?docno="+docVal1);
              }
            
              if(document.getElementById("hidweakoff")) {
                 var weakoff= document.getElementById("hidweakoff").value; 
                 if(weakoff!="") {
                    var arr = weakoff.split(",");
                    for(var i=0;i<=arr.length-1;i++) {
                                if(arr[i]=='1') { document.getElementById("mon").checked = true; document.getElementById("mon").value=1; }
                                if(arr[i]=='2') { document.getElementById("tue").checked = true; document.getElementById("tue").value=1; }
                                if(arr[i]=='3') { document.getElementById("wed").checked = true; document.getElementById("wed").value=1; }
                                if(arr[i]=='4') { document.getElementById("thu").checked = true; document.getElementById("thu").value=1; }
                                if(arr[i]=='5') { document.getElementById("fri").checked = true; document.getElementById("fri").value=1; }
                                if(arr[i]=='6') { document.getElementById("sat").checked = true; document.getElementById("sat").value=1; }
                                if(arr[i]=='7') { document.getElementById("sun").checked = true; document.getElementById("sun").value=1; }
                    }
                 }
              }
    
              if(document.getElementById("hidcarryforward")) {
                var carryforward=document.getElementById("hidcarryforward").value;
                if(parseInt(carryforward)==1) {
                    document.getElementById("carryforward").checked = true;
                    document.getElementById("carryforward").value=1;
                } else {
                    document.getElementById("carryforward").checked = false;
                    document.getElementById("carryforward").value=0;
                }
              }
              
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
        } catch(e) { console.error("Error in setValues: ", e); }
    }

    function getCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText; 
                items = items.split('***');
                var branchItems = items[0].split(",");
                var branchIdItems = items[1].split(",");
                var optionsbranch = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i] + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#cmbcategory").html(optionsbranch);
                
                  if ($('#hidcatval').length && $('#hidcatval').val() != null) {
                    $('#cmbcategory').val($('#hidcatval').val());
                  }  
            
            } else {}
        }
        x.open("GET", "getCategory.jsp", true);
        x.send();
    }
      
    function getleave() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText; 
                items = items.split('***');
                var branchItems = items[0].split(",");
                var branchIdItems = items[1].split(",");
                var optionsbranch = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i] + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#leaveid").html(optionsbranch);
                
                  if ($('#hidleaveid').length && $('#hidleaveid').val() != null) {
                    $('#leaveid').val($('#hidleaveid').val());
                   }  
            } else { }
        }
        x.open("GET", "getleaveid.jsp", true);
        x.send();
     }
    
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            document.getElementById("errormsg").innerText=" Enter Numbers Only";  
            return false;
        }
        document.getElementById("errormsg").innerText="";  
        return true;
    }   
    
    function termConfig() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText; 
                if(parseInt(items)===1){
                    $('.hideterm').hide();
                    $('#fs3').insertBefore('#fs1');
                }
            } else { 
            }
        }
        x.open("GET", "gettermconfig.jsp", true);
        x.send();
     }
</script>

</head>
<body onload="termConfig();setValues();">

<div class="homeContent" data-type="background">
<form id="frmhrsetups" action="saveHrsetup" autocomplete="OFF" >
    <jsp:include page="../../../../../header.jsp"></jsp:include>

    <div class="hidden-scrollbar">

        <div class="middle-panel" style="margin-top: 25px;">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width: 80px;">Date</label>
                <div style="width: 120px;">
                    <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                </div>

                <label class="lbl-right" style="width: 80px; margin-left: 20px;">Doc No</label>
                <input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>' style="width: 150px; background: #f3f4f6;" />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">For Days in Year</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width: 110px;">Valid From</label>
                <div style="width: 120px;">
                    <div id='validfromdate' name='validfromdate' value='<s:property value="validfromdate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width: 110px; margin-left: 10px;">Last Revised On</label>
                <div style="width: 120px;">
                    <div id='lastreviseddate' name='lastreviseddate' value='<s:property value="lastreviseddate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width: 110px; margin-left: 10px;">Payroll Category</label>
                <select name="cmbcategory" id="cmbcategory" value='<s:property value="cmbcategory"/>' style="width: 150px;">
                    <option value="">-- select -- </option>
                </select>
                
                <label class="lbl-right" style="width: 110px; margin-left: 10px;">Working Hrs/Day</label>
                <div style="width: 120px;">
                    <div id='workingtime' name='workingtime' value='<s:property value="workingtime"/>'></div>
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width: 110px;">Annual Leave ID</label>
                <select name="leaveid" id="leaveid" value='<s:property value="leaveid"/>' style="width: 150px;">
                    <option value="">-- select --</option>
                </select>
                
                <label class="lbl-right" style="width: 110px; margin-left: 10px;">Weekly Off</label>
                <div class="checkbox-group" style="flex: 1;">
                    <input type="checkbox" id="mon" name="mon" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="mon">Mon</label>
                    <input type="checkbox" id="tue" name="tue" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="tue">Tue</label>
                    <input type="checkbox" id="wed" name="wed" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="wed">Wed</label>
                    <input type="checkbox" id="thu" name="thu" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="thu">Thu</label>
                    <input type="checkbox" id="fri" name="fri" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="fri">Fri</label>
                    <input type="checkbox" id="sat" name="sat" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="sat">Sat</label>
                    <input type="checkbox" id="sun" name="sun" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="sun">Sun</label>
                </div>
                
                <div class="checkbox-group" style="margin-left: 20px;">
                    <input type="checkbox" id="carryforward" name="carryforward" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    <label for="carryforward" style="color: #0056b3;">Carry Forward</label>
                </div>
            </div>

            <div class="field-row" style="margin-bottom: 0;">
                <label class="lbl-right" style="width: 110px;">Eligible Days</label>
                <input type="text" id="eligibledays" name="eligibledays" onkeypress="javascript:return isNumber (event)" value='<s:property value="eligibledays"/>' style="width: 100px;">
                
                <label class="lbl-right" style="width: 110px; margin-left: 10px;">In a Year</label>
                <input type="text" id="forworkingdays" name="forworkingdays" onkeypress="javascript:return isNumber (event)" value='<s:property value="forworkingdays"/>' style="width: 100px;">
            </div>
        </div>

        <div class="middle-panel hideterm" id="fs1">
            <span class="middle-panel-title">Terminal Benefits & Details</span>
            
            <div style="display: flex; gap: 25px;">
                <div style="flex: 1.5; min-width: 400px;">
                    <div class="grid-container" id="termibeni"> 
                        <jsp:include page="terminationbenefitcondtiongrid.jsp"></jsp:include>
                    </div>
                </div>
                
                <div style="flex: 1; min-width: 300px;">
                    <div style="font-size: 12px; font-weight: bold; color: #444; margin-bottom: 8px;">Termination Details</div>
                    <div class="grid-container" id="trimi"> 
                        <jsp:include page="terminationdetailsgrid.jsp"></jsp:include>
                    </div>
                        
                    <div style="font-size: 12px; font-weight: bold; color: #444; margin-bottom: 8px; margin-top: 20px;">Resignation Details</div>
                    <div class="grid-container" id="resig"> 
                        <jsp:include page="resignationdetailsgrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>

        <div class="middle-panel" id="fs2">
            <span class="middle-panel-title">Salary Calculation Formula (Hrs)</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width: 200px;">Conv Formula (Month To Day)</label>
                <input type="text" id="convformula" readonly="readonly" placeholder="Press F3 To Search" name="convformula" value='<s:property value="convformula"/>' onkeydown="getconfor(event);" style="max-width: 300px;">
                
                <label class="lbl-right" style="width: 150px;">Rate per Hour</label>
                <input type="text" id="normalrate" name="normalrate" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="normalrate"/>' onkeydown="getnr(event);" style="max-width: 300px;"> 
            </div>
            
            <div class="field-row" style="margin-bottom: 0;">
                <label class="lbl-right" style="width: 200px;">OT</label>
                <input type="text" id="ot" name="ot" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="ot"/>' onkeydown="getot(event);" style="max-width: 300px;"> 
                
                <label class="lbl-right" style="width: 150px;">Holiday OT</label>
                <input type="text" id="holidayot" name="holidayot" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="holidayot"/>' onkeydown="getholyot(event);" style="max-width: 300px;"> 
            </div>
        </div>
        
        <div class="middle-panel" id="fs3">
            <span class="middle-panel-title">Account Setup</span>
            <div id="accset" class="grid-container" style="margin-top: 10px;"> 
                <jsp:include page="accountsetupgrid.jsp"></jsp:include>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
            <input type="hidden" id="hidvalidfromdate" name="hidvalidfromdate" value='<s:property value="hidvalidfromdate"/>'/>
            <input type="hidden" id="hidlastreviseddate" name="hidlastreviseddate" value='<s:property value="hidlastreviseddate"/>'/>
            <input type="hidden" id="hidworkingtime" name="hidworkingtime" value='<s:property value="hidworkingtime"/>'/>
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
            <input type="hidden" id="hidcatval" name="hidcatval"  value='<s:property value="hidcatval"/>'/>
            <input type="hidden" id="hidleaveid" name="hidleaveid"  value='<s:property value="hidleaveid"/>'/>
            <input type="hidden" id="hidweakoff" name="hidweakoff"  value='<s:property value="hidweakoff"/>'/>
            <input type="hidden" id="hidcarryforward" name="hidcarryforward"  value='<s:property value="hidcarryforward"/>'/>
            <input type="hidden" id="benigridlength" name="benigridlength"  value='<s:property value="benigridlength"/>'/>
            <input type="hidden" id="trmigridlength" name="trmigridlength"  value='<s:property value="trmigridlength"/>'/>
            <input type="hidden" id="resiggridlength" name="resiggridlength"  value='<s:property value="resiggridlength"/>'/>
            <input type="hidden" id="accountsetupgridlength" name="accountsetupgridlength"  value='<s:property value="accountsetupgridlength"/>'/>
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="formulawindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div> 
<div id="costCodeSearchWindow"><div></div></div> 

</div>
</body>
</html>