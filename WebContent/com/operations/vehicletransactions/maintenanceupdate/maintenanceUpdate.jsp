<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Cash Receipts / Client Master)
========================================================= */
body {
    background-color: #f8fafc; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: transparent; 
    max-width: 100%;
    margin: 0 auto;
}

#formdet {
    text-align: left !important;
    display: block;
    font-size: 22px;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 12px;
    padding-left: 5px;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 0px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 25px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton, .modern-ui .myButtonss, .modern-ui .myButtonp {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff !important;
    white-space: nowrap;
}
.modern-ui .myButton:hover, .modern-ui .myButtonss:hover, .modern-ui .myButtonp:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 10px; display: block; padding-left: 5px; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 80px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
    $(document).ready(function() {

        var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
        $("#maintainceDate").jqxDateTimeInput(dateWidgetSettings);
        $("#invDate").jqxDateTimeInput(dateWidgetSettings);
        
        // Force internal alignment AFTER render
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);

        $('#fleetsearchwindow').jqxWindow({ width: '62%', height: '67%', maxHeight: '85%', maxWidth: '80%', title: 'Fleet Search', position: { x: 400, y: 60 }, keyboardCloseKey: 27});
        $('#fleetsearchwindow').jqxWindow('close');
        
        $('#garragesearchwindow').jqxWindow({ width: '30%', height: '63%', maxHeight: '70%', maxWidth: '50%', title: 'Garrage Search', position: { x: 700, y: 60 }, keyboardCloseKey: 27});
        $('#garragesearchwindow').jqxWindow('close');
        
        $('#typeservsearchwndow').jqxWindow({ width: '30%', height: '59%', maxHeight: '65%', maxWidth: '65%', title: 'Type Search', position: { x: 200, y: 100 }, keyboardCloseKey: 27});
        $('#typeservsearchwndow').jqxWindow('close');
        
        $('#serdescsearchwndow').jqxWindow({ width: '25%', height: '55%', maxHeight: '62%', maxWidth: '60%', title: 'Description Search', position: { x: 200, y: 100 }, keyboardCloseKey: 27});
        $('#serdescsearchwndow').jqxWindow('close');

        $('#maintainceDate').on('change', function(event) {
            var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
            funDateInPeriod(receiptdate);
        });
        
        $('#garagemaster').dblclick(function() {
            $('#garragesearchwindow').jqxWindow('open');
            garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
        });

        $('#mtfleetno').dblclick(function() {
            $('#fleetsearchwindow').jqxWindow('open');
            fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
        });

    });
    
    function descservSearchContent(url) {
        $.get(url).done(function(data) {
            $('#serdescsearchwndow').jqxWindow('open');
            $('#serdescsearchwndow').jqxWindow('setContent', data);
        });
    }
    
    function TypeservSearchContent(url) {
        $.get(url).done(function(data) {
            $('#typeservsearchwndow').jqxWindow('open');
            $('#typeservsearchwndow').jqxWindow('setContent', data);
        });
    }
    
    function getgarrage(event) {
        var x = event.keyCode;
        if (x == 114) {
            $('#garragesearchwindow').jqxWindow('open');
            garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
        }
    }
    
    function garragechangeContent(url) {
        $.get(url).done(function(data) {
            $('#garragesearchwindow').jqxWindow('setContent', data);
        });
    }

    function getfleet(event) {
        var x = event.keyCode;
        if (x == 114) {
            $('#fleetsearchwindow').jqxWindow('open');
            fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
        }
    }
    
    function fleetchangeContent(url) {
        $.get(url).done(function(data) {
            $('#fleetsearchwindow').jqxWindow('setContent', data);
        });
    }

    function funFocus() {
        $('#maintainceDate').jqxDateTimeInput('focus');
    }
    
    function funReset() {
    }
    
    function funReadOnly() {
        $('#frmmaint input').attr('readonly', true);
        $('#frmmaint select').attr('disabled', true);
        $('#mtfleetno').attr('disabled', true);
        $('#garagemaster').attr('disabled', true);

        $("#maindowngrid").jqxGrid({ disabled : true });
        $("#mainuppergrid").jqxGrid({ disabled : true });
        $('#invDate').jqxDateTimeInput({ disabled : true });
        $('#maintainceDate').jqxDateTimeInput({ disabled : true });
    }
    
    function funRemoveReadOnly() {
        $('#frmmaint input').attr('readonly', false);
        $('#frmmaint select').attr('disabled', false);
        $('#mtfleetno').attr('disabled', false);
        $('#garagemaster').attr('disabled', false);
        $('#nextserdue').attr('disabled', false);
        $('#maintainceDate').jqxDateTimeInput({ disabled : false });
        $('#invDate').jqxDateTimeInput({ disabled : false });
        $('#mtfleetno').attr('readonly', true);
        $('#mtflname').attr('readonly', true);
        $('#garagemaster').attr('readonly', true);
        $('#docno').attr('readonly', true);
        
        $("#maindowngrid").jqxGrid({ disabled : false });
        $("#mainuppergrid").jqxGrid({ disabled : false });
        
        if ($('#mode').val() == 'A') {
            $('#nextserdue').attr('disabled', false);
            $('#maintainceDate').val(new Date());
            $('#invDate').val(new Date());
            $("#maindowngrid").jqxGrid('clear');
            $("#maindowngrid").jqxGrid('addrow', null, {});
            $("#mainuppergrid").jqxGrid('clear');
            $("#mainuppergrid").jqxGrid('addrow', null, {});
        }
        if ($('#mode').val() == 'E') {
            if ($('#maintype').val() == "repair") {
                $('#nextserdue').attr('disabled', true);
            } else {
                $('#nextserdue').attr('disabled', false);
            }
        }
    }
    
    function valchange() {
        if ($('#maintypeval').val() != "") {
            $('#maintype').val($('#maintypeval').val());
        }
        if ($('#maintypeval').val() == "repair") {
            $('#nextserdue').attr('disabled', true);
        } else {
            $('#nextserdue').attr('disabled', false);
        }
    }

    function changetype() {
        if ($('#maintype').val() == "repair") {
            $('#nextserdue').attr('disabled', true);
        } else {
            $('#nextserdue').attr('disabled', false);
        }
    }

    function setValues() {
        if ($('#hidmaintainceDate').val()) {
            $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
        }
        if ($('#hidinvDate').val()) {
            $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
        }

        if ($('#msg').val() != "") {
            $.messager.alert('Message', $('#msg').val());
        }
        document.getElementById("formdet").innerText = $('#formdetail').val() + " (" + $('#formdetailcode').val().trim() + ")";
        valchange();
        
        var docval = document.getElementById("masterdoc_no").value;
        if (docval > 0) {
            var indexVal2 = document.getElementById("masterdoc_no").value;
            $("#maingrid").load("maintGrid.jsp?maindoc=" + indexVal2);
            $("#servgrid").load("servicemaingrid.jsp?maindoc1=" + indexVal2);
        }
    }

    function funNotify() {
        var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
        var validdate = funDateInPeriod(receiptdate);
        if (validdate == 0) {
            return 0;
        }
        
        var fleetval = document.getElementById("mtfleetno").value;
        if (fleetval == "") {
            document.getElementById("errormsg").innerText = "Select Fleet No";
            document.getElementById("mtfleetno").focus();
            return 0;
        }
        
        if ($('#maintype').val() == "service") {
            var cuurkmval = document.getElementById("currkm").value;
            var nextserkmval = document.getElementById("nextserdue").value;
            if ((parseFloat(nextserkmval) < parseFloat(cuurkmval))) {
                document.getElementById("errormsg").innerText = "Service Due KM Less Than Current KM";
                document.getElementById("nextserdue").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
            }
        }
        
        var garrage = document.getElementById("garrageid").value;
        if (garrage == "") {
            document.getElementById("errormsg").innerText = "Select Garrage";
            document.getElementById("garagemaster").focus();
            return 0;
        }

        var invno = document.getElementById("invno").value;
        if (invno == "") {
            document.getElementById("errormsg").innerText = " Enter Inv NO";
            document.getElementById("invno").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }

        var rows = $("#mainuppergrid").jqxGrid('getrows');
        $('#maingridlength').val(rows.length);
        for (var i = 0; i < rows.length; i++) {
            newTextBox = $(document.createElement("input")).attr("type", "dil")
                    .attr("id", "main" + i).attr("name", "main" + i).attr("hidden", "true");
            newTextBox.val(rows[i].hidcldate + "::" + rows[i].clear + " :: "
                    + rows[i].clremarks + " :: " + rows[i].srno + " :: " + rows[i].hidcltime + " :: ");
            newTextBox.appendTo('form');
        }

        var rows = $("#maindowngrid").jqxGrid('getrows');
        $('#servicegridlenght').val(rows.length);

        for (var i = 0; i < rows.length; i++) {
            if (rows[i].description == '') {
                $.messager.alert('Message', 'Select Description....!', 'warning');
                return false;
            }

            newTextBox = $(document.createElement("input")).attr("type", "dil")
                    .attr("id", "service" + i).attr("name", "service" + i).attr("hidden", "true");
            newTextBox.val(rows[i].type + "::" + rows[i].description + " :: "
                    + rows[i].remarks + " :: " + rows[i].lbrcost + " :: "
                    + rows[i].partscost + " :: " + rows[i].total + " :: ");
            newTextBox.appendTo('form');
        }

        var lbrcost = document.getElementById("lbrtotalcost").value;
        if (lbrcost == "" || typeof (lbrcost) == "undefined" || typeof (lbrcost) == "NaN") {
            document.getElementById("lbrtotalcost").value = 0.00;
        }

        var partscost = document.getElementById("partstotalcost").value;
        if (partscost == "" || typeof (partscost) == "undefined" || typeof (partscost) == "NaN") {
            document.getElementById("partstotalcost").value = 0.00;
        }
        
        var totalcost = document.getElementById("totalcost").value;
        if (totalcost == "" || typeof (totalcost) == "undefined" || typeof (totalcost) == "NaN") {
            document.getElementById("totalcost").value = 0.00;
        }

        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                var chk = items.trim();
                if (parseInt(chk) == 1) {
                    document.getElementById("errormsg").innerText = "Inv No " + document.getElementById("invno").value + " Already Exists ";
                    document.getElementById("invno").focus();
                    return 0;
                } else {
                    document.getElementById("errormsg").innerText = "";
                    document.getElementById("frmmaint").submit();
                }
            }
        }
        x.open("GET", "checkinvno.jsp?invno=" + document.getElementById("invno").value + '&masterdocno=' + document.getElementById("masterdoc_no").value + '&garrageid=' + document.getElementById("garrageid").value);
        x.send();
    }

    function funchkinv() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                var chk = items.trim();
                if (parseInt(chk) == 1) {
                    document.getElementById("errormsg").innerText = "Inv No " + document.getElementById("invno").value + " Already Exists ";
                    document.getElementById("invno").focus();
                    return 0;
                } else {
                    document.getElementById("errormsg").innerText = "";
                    return 1;
                }
            }
        }
        x.open("GET", "checkinvno.jsp?invno=" + document.getElementById("invno").value + '&masterdocno=' + document.getElementById("masterdoc_no").value + '&garrageid=' + document.getElementById("garrageid").value);
        x.send();
    }

    function funChkButton() {
        /* funReset(); */
    }

    function funSearchLoad() {
        changeContent('masterSearch.jsp?', $('#updatesearchwindow'));
    }

    $(function() {
        $('#frmmaint').validate({
            rules : {
                currkm : { "required" : true, number : true },
                nextserdue : { "required" : true, number : true },
            },
            messages : {
                currkm : { required : " *required", number : " inValid" },
                nextserdue : { required : " *required", number : " inValid" }
            }
        });
    });

    function funPrintBtn() {
        if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
            var url = document.URL;
            var reurl = url.split("saveMaint");
            $("#docno").prop("disabled", false);
            var win = window.open(reurl[0] + "printMintupdate?docno=" + document.getElementById("masterdoc_no").value, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        } else {
            $.messager.alert('Message', 'Select a Document....!', 'warning');
            return false;
        }
    }
</script>
</head>

<body onload="setValues();">

<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" /><br />

    <form id="frmmaint" action="saveMaint" name="maintUpdate" method="post" autocomplete="OFF">
    
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">General Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width:120px;">
                        <div id="maintainceDate" name="maintainceDate" value='<s:property value="date_accountmaster"/>'></div>
                        <input type="hidden" id="hidmaintainceDate" name="hidmaintainceDate" value='<s:property value="hidmaintainceDate"/>'>
                    </div>
                    
                    <div style="flex:1;"></div>
                    
                    <label class="lbl-right" style="width:100px;">Doc No</label>
                    <input type="text" id="docno" name="docno" style="width:150px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
                </div>
            </div>

            <div class="middle-panel" style="padding-top:25px;">
                <span class="middle-panel-title">Maintenance Update</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Fleet No</label>
                    <div class="input-search-container" style="width:120px;">
                        <input type="text" id="mtfleetno" name="mtfleetno" placeholder="Press F3" value='<s:property value="mtfleetno"/>' onkeydown="getfleet(event)">
                        <svg class="magnifier-icon" onclick="$('#fleetsearchwindow').jqxWindow('open'); fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">Name</label>
                    <input type="text" id="mtflname" tabindex="-1" name="mtflname" style="flex:1;" value='<s:property value="mtflname"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Remarks</label>
                    <input type="text" id="mtremark" name="mtremark" style="flex:1;" value='<s:property value="mtremark"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Type</label>
                    <select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>' style="width:120px;">
                        <option value="service">Service</option>
                        <option value="repair">Repair</option>
                    </select>
                    
                    <label class="lbl-right" style="width:80px;">Curr.KM</label>
                    <input type="text" id="currkm" name="currkm" style="width:120px;" value='<s:property value="currkm"/>'>
                    
                    <label class="lbl-right" style="width:120px;">Next Ser.Due KM</label>
                    <input type="text" id="nextserdue" name="nextserdue" style="width:120px;" value='<s:property value="nextserdue"/>'>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Garage</label>
                    <div class="input-search-container" style="flex:1; max-width: 300px;">
                        <input type="text" id="garagemaster" name="garagemaster" placeholder="Press F3" value='<s:property value="garagemaster"/>' onkeydown="getgarrage(event)">
                        <svg class="magnifier-icon" onclick="$('#garragesearchwindow').jqxWindow('open'); garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:80px;">Inv NO</label>
                    <input type="text" id="invno" name="invno" style="width:120px;" value='<s:property value="invno"/>' onblur="funchkinv();">
                    
                    <label class="lbl-right" style="width:80px;">Inv Date</label>
                    <div style="width:120px;">
                        <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                        <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
                    </div>
                </div>
            </div>

            <div class="middle-panel" style="padding-top:25px;">
                <span class="middle-panel-title">Maintenance Requirements</span>
                <div class="grid-container">
                    <div id="maingrid"><jsp:include page="maintGrid.jsp"></jsp:include></div>
                </div>
            </div>

            <div class="middle-panel" style="padding-top:25px;">
                <span class="middle-panel-title">Service Details</span>
                <div class="grid-container">
                    <div id="servgrid"><jsp:include page="servicemaingrid.jsp"></jsp:include></div>
                </div>
            </div>
            
        </div> <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'> 
        <input type="hidden" id="garrageid" name="garrageid" value='<s:property value="garrageid"/>'> 
        <input type="hidden" id="mtypename" name="mtypename" value='<s:property value="mtypename"/>'>
        <input type="hidden" id="lbrtotalcost" name="lbrtotalcost" value='<s:property value="lbrtotalcost"/>'> 
        <input type="hidden" id="partstotalcost" name="partstotalcost" value='<s:property value="partstotalcost"/>'> 
        <input type="hidden" id="totalcost" name="totalcost" value='<s:property value="totalcost"/>'> 
        <input type="hidden" id="maintypeval" name="maintypeval" value='<s:property value="maintypeval"/>'> 
        <input type="hidden" id="maintTrno" name="maintTrno" value='<s:property value="maintTrno"/>'> 
        <input type="hidden" id="jvmDovno" name="jvmDovno" value='<s:property value="jvmDovno"/>'>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'> 
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'> 
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="maingridlength" name="maingridlength" value='<s:property value="maingridlength"/>'> 
        <input type="hidden" id="servicegridlenght" name="servicegridlenght" value='<s:property value="servicegridlenght"/>'>

    </form>

    <div id="fleetsearchwindow"><div></div></div>
    <div id="typeservsearchwndow"><div></div></div>
    <div id="serdescsearchwndow"><div></div></div>
    <div id="garragesearchwindow"><div></div></div>
    <div id="updatesearchwindow"><div></div></div>

</div>
</body>
</html>