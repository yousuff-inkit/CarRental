<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="tab.css" />
<jsp:include page="tab.jsp" />
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
    color: red;
    font-weight: bold;
}
.sep {
    border-bottom: 1px solid black;
}
.alignright {
    text-align: right;
}

/* =========================================================
   CASH RECEIPTS UI OVERLAY (Safe CSS)
========================================================= */
body {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 12px; /* Adjusted to match ERP compact style */
    margin: 0;
    background: #f5f7fa;
    box-sizing: border-box;
}

fieldset {
    border-radius: 6px;
    border: 1px solid #c5d3e0;
    padding: 8px 10px;
    margin-bottom: 10px;
    background: #fff;
}

legend {
    font-size: 13px;
    font-weight: bold;
    padding: 0 8px;
    border-left: 3px solid #0b45a2;
    color: #0b45a2;
}

/* Compact 24px Inputs for Cash Receipts Look */
input[type="text"], select {
    height: 24px !important;
    font-size: 12px;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    width: 100%;
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[readonly], input:disabled, select:disabled {
    background: #f8f9fa;
    color: #666;
}

.myButton {
    font-weight: 700;
    font-size: 12px;
    height: 26px !important;
    line-height: 24px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-transform: uppercase;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

#head {
    background: #fff;
    border-radius: 8px;
    padding-bottom: 5px;
    padding-left: 5px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    margin-bottom: 10px;
}

#mainBG {
    background: transparent;
    padding: 10px;
}

/* Search Box CSS */
.input-search-container {
    position: relative;
    display: inline-block;
    width: 100%; 
}

.input-search-container input {
    padding-right: 25px !important; 
    width: 100% !important;
    box-sizing: border-box !important;
}

.magnifier-icon {
    position: absolute;
    right: 5px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #2563eb; 
    z-index: 10;
    font-size: 13px;
}

.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 40px);
}

#content {
    background: #E0ECF8;
    padding: 10px !important; /* Added padding to prevent text touching borders */
    height: 100%;
    position: relative;
    z-index: 2;
    border-radius: 0 5px 5px 5px;
    border: 1px solid #c5d3e0;
}

.narrow-input {
    width: 100% !important; /* Overridden to fit tables properly */
}

/* Table text alignment fix */
td {
    font-size: 12px;
    padding: 2px 4px;
}
td[align="right"] {
    font-weight: 600;
    color: #444;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    document.getElementById("lbllastsrvkm").style.display="none";           
    document.getElementById("last_srvc_km").style.display="none";           
    document.getElementById("fleetwarning").style.display="none";
    document.getElementById("releasesave").style.display="none";
    
    $("#releasefleet").attr("disabled", true); 
    $("#cmbrlsbranch").attr("disabled", true); 
    $("#cmbrlsloc").attr("disabled", true); 
    $("#cmbrentalstatus").attr("disabled", true); 
    
    /* Enforcing 24px height on JQX to match Cash Receipts CSS */
    $("#releasetime").jqxDateTimeInput({ width: '20%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
    $("#jqxDate1").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });  
    $("#jqxPurchaseDate").jqxDateTimeInput({width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxFinRegDate").jqxDateTimeInput({width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxFinRelDate").jqxDateTimeInput({width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxOtherRegExp").jqxDateTimeInput({ width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxOtherInsExp").jqxDateTimeInput({ width : '100%',height : '24px',formatString : "dd.MM.yyyy" ,value:null});
    $("#jqxWrntyFrmDate").jqxDateTimeInput({width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxWrntyToDate").jqxDateTimeInput({width : '100%', height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#jqxLstSrvcDate").jqxDateTimeInput({ width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    $("#releasedate").jqxDateTimeInput({width : '100%',height : '24px',formatString : "dd.MM.yyyy",value:null});
    
    /* Fix internal JQX fonts */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);

    $('#dealerWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#dealerWindow').jqxWindow('close');
    $('#financierWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#financierWindow').jqxWindow('close');
    $('#insuranceWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#insuranceWindow').jqxWindow('close');
    $('#specwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#specwindow').jqxWindow('close'); 
    $('#tcnowindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'TC No Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#tcnowindow').jqxWindow('close');
    
    if(document.getElementById("mode").value=="A"){
        changeDate();   
    }
    
    $('#jqxFinRegDate').on('change', function (event) {  
        changeDate();
    });
    $('#jqxPurchaseDate').on('change', function (event) {  
        var purdate= $('#jqxPurchaseDate').jqxDateTimeInput('getDate');
        $('#jqxWrntyFrmDate ').jqxDateTimeInput('setDate', new Date(purdate));
    });

    getTestPlateCode();
    getTestModel();
    getTestLocation(); 

    $('#mortgaged').dblclick(function(){
        $('#financierWindow').jqxWindow('open');
        $('#financierWindow').jqxWindow('focus');
        financierSearchContent('mortgagedGrid.jsp?', $('#financierWindow'));
    });
    
    $('#tcno').dblclick(function(){
        $('#tcnowindow').jqxWindow('open');
        $('#tcnowindow').jqxWindow('focus');
        tcnoSearchContent('tcnoSearchGrid.jsp?id=1');
    });
});
    
function getTcno(event){
    var x= event.keyCode;
    if(x==114){
        $('#tcnowindow').jqxWindow('open');
        $('#tcnowindow').jqxWindow('focus');
        tcnoSearchContent('tcnoSearchGrid.jsp?id=1');
    }
}
    
function tcnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#tcnowindow').jqxWindow('setContent', data);
    }); 
}
    
function getMortgaged(event){
    var x= event.keyCode;
    if(x==114){
        financierSearchContent('mortgagedGrid.jsp');
    }
    else{
     }
    }
      
function changeDate(){
      var finregdate= $('#jqxFinRegDate').jqxDateTimeInput('getDate');
         var finaldate=new Date(new Date(finregdate).setMonth(finregdate.getMonth()+12));
         var finaldate2=new Date(new Date(finaldate).setDate(finaldate.getDate()-1));
         $('#jqxOtherRegExp ').jqxDateTimeInput('setDate', new Date(finaldate2));
         var insexp1=new Date(new Date(new Date(finregdate).setMonth(finregdate.getMonth()+13)));
         var insexp2=new Date(new Date(insexp1).setDate(insexp1.getDate()-1));
        $('#jqxOtherInsExp ').jqxDateTimeInput('setDate', new Date(insexp2));
  }
function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window')); 
}
  function dealerSearchContent(url) {
      $('#dealerWindow').jqxWindow('open');
         $.get(url).done(function (data) {
        $('#dealerWindow').jqxWindow('setContent', data);
    }); 
    }
    
function funSearchdblclick(){
    var url=document.URL;
         var reurl=url.split("com/");
      dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
}
function getDealer(event){
         var x= event.keyCode;
         if(x==114){
             var url=document.URL;
             var reurl=url.split("com/");
          dealerSearchContent(reurl[0]+'com/search/masterssearch/dealerMSearch.jsp');
         }
         else{
          }
         }
function financierSearchContent(url) {
       $('#financierWindow').jqxWindow('open');
         $.get(url).done(function (data) {
        $('#financierWindow').jqxWindow('setContent', data);
    }); 
    }
function specSearchContent(url) {
       $('#specwindow').jqxWindow('open');
         $.get(url).done(function (data) {
        $('#specwindow').jqxWindow('setContent', data);
    }); 
    }
function funFinSearchdblclick(){
     var url=document.URL;
         var reurl=url.split("com/");
          financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
}
function getFin(event){
      var x= event.keyCode;
      if(x==114){
         var url=document.URL;
             var reurl=url.split("com/");
              financierSearchContent(reurl[0]+'com/search/masterssearch/financierMSearch.jsp');
      }
      else{
       }
      }
function insuranceSearchContent(url) {
       $('#insuranceWindow').jqxWindow('open');
         $.get(url).done(function (data) {
        $('#insuranceWindow').jqxWindow('setContent', data);
    }); 
    }
function funInsurSearchdblclick(){
     var url=document.URL;
         var reurl=url.split("com/");
      insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
}
function getInsurance(event){
var x= event.keyCode;
if(x==114){
      var url=document.URL;
             var reurl=url.split("com/");
     insuranceSearchContent(reurl[0]+'com/search/masterssearch/insuranceMSearch.jsp');
}
else{
 }
}

function funReadOnly() {
     $('#frmVehicle input').attr('readonly', true);
     $('#frmVehicle select').attr('disabled', true);
     $('#jqxDate1').jqxDateTimeInput({ disabled: true}); 
     $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
     $('#jqxFinRegDate').jqxDateTimeInput({ disabled: true});
     $('#jqxFinRelDate').jqxDateTimeInput({ disabled: true});
     $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: true});
     $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: true});
     $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
     $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true}); 
     $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: true}); 
     $('#releasedate').jqxDateTimeInput({ disabled: true}); 
     $('#releasetime').jqxDateTimeInput({ disabled: true}); 
     getAuth();
    getBrand();
    getGroup();
    getYOM();
    getColor();
    getFinancier();
    getBrch();
    showRelease(); 
    getStatus();
}
function showRelease(){
     var temp=$("#aststatus").val();
    if(temp=="INDUCTED"){
        document.getElementById("btnrelease").value="To Be Released";
    }
    else if(temp=="LIVE"){
        document.getElementById("btnrelease").style.display="none";
        document.getElementById("releasesave").style.display="none";
    }
    else{
        document.getElementById("btnrelease").disabled=true;
    }
}
function funRelease(){
    
    $('#mode').val("R");
    $("#cmbrlsbranch").attr("disabled", false); 
    var testfleet=document.getElementById("releasefleet").value;
    var testbranch=document.getElementById("cmbrlsbranch").value;
    var testloc=document.getElementById("cmbrlsloc").value;
    var testkm=document.getElementById("releasekm").value;
    var testfuel=document.getElementById("releasefuel").value;
    
    if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
        document.getElementById("fleetwarning").style.display="block";
        return false;
    }
    else{
        document.getElementById("fleetwarning").style.display="none";
         $('#cmbfuel').attr('disabled', false); 
         if(document.getElementById("releasefleet").value<=0){
             return false;
         }
         $('#jqxDate1').jqxDateTimeInput({disabled:false});
        $('#jqxPurchaseDate').jqxDateTimeInput({disabled:false});
        $('#jqxFinRegDate').jqxDateTimeInput({disabled:false});
        $('#jqxFinRelDate').jqxDateTimeInput({disabled:false});
        $('#jqxOtherRegExp').jqxDateTimeInput({disabled:false});
        $('#jqxOtherInsExp').jqxDateTimeInput({disabled:false});
        $('#jqxWrntyFrmDate').jqxDateTimeInput({disabled:false});
        $('#jqxWrntyToDate').jqxDateTimeInput({disabled:false});
        $('#jqxLstSrvcDate').jqxDateTimeInput({disabled:false});
        document.getElementById("frmVehicle").submit();
        $("#cmbrlsbranch").attr("disabled", true); 
         $('#cmbfuel').attr('disabled', true); 
        
    }
    
}
function funEnable(){
    document.getElementById("btnrelease").style.display="none";
    document.getElementById("releasesave").style.display="block";
    $("#releasefleet").attr("disabled", false); 
    $("#cmbrlsbranch").attr("disabled", false); 
    $("#cmbrlsloc").attr("disabled", false); 
    $("#cmbrentalstatus").attr("disabled", false); 
    $("#cmbrentalstatus").val("R");
    $('#releasedate').jqxDateTimeInput({ disabled: false});
    $('#releasetime').jqxDateTimeInput({ disabled: false});
     $("#releasekm").prop("readonly", true);
    $("#releasefuel").prop("readonly", true); 
    $("#cmbrlsbranch").attr("disabled", true); 
    if(document.getElementById("aststatus").value=='INDUCTED'){
        document.getElementById("releasekm").value=document.getElementById("current_km").value;
        document.getElementById("releasefuel").value=$("#cmbfuel option:selected").text();
        $('#cmbrlsbranch').val($('#cmbavail_br1').val());
        getLocation($('#cmbrlsbranch').val());
    }
    
}
function getTestPlateCode(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var plateItems = items[0].split(",");
            var plateIdItems = items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            for (var i = 0; i < plateItems.length; i++) {
                optionsplate += '<option value="' + plateIdItems[i] + '">'
                        + plateItems[i] + '</option>';
            }
            $("select#cmbplate").html(optionsplate);
             if ($('#hidcmbplate').val() != null) {
                $('#cmbplate').val($('#hidcmbplate').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
    x.send();
}

function funRemoveReadOnly() {
    $('#frmVehicle input').attr('readonly', false);
    $('#frmVehicle select').attr('disabled', false);
    $('#docno').attr('readonly', true);
    $('#dealer').attr('readonly', true);
    $('#financier').attr('readonly', true);
    $('#insurance_comp').attr('readonly', true);
    $('#mortgaged').attr('readonly', true);
     $('#jqxDate1').jqxDateTimeInput({ disabled: false}); 
     $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
     $('#jqxFinRegDate').jqxDateTimeInput({ disabled: false});
     $('#jqxFinRelDate').jqxDateTimeInput({ disabled: false});
     $('#jqxOtherRegExp').jqxDateTimeInput({ disabled: false});
     $('#jqxOtherInsExp').jqxDateTimeInput({ disabled: false});
     $('#jqxLstSrvcDate').jqxDateTimeInput({ disabled: false}); 
     $("#releasefleet").attr("disabled", true); 
        $("#cmbrlsbranch").attr("disabled", true); 
        $("#cmbrlsloc").attr("disabled", true); 
        $("#cmbrentalstatus").attr("disabled", true); 
        $('#releasedate').jqxDateTimeInput({ disabled: true});
        $('#releasetime').jqxDateTimeInput({ disabled: true});
        $("#releasekm").attr("readonly",true);
        $("#releasefuel").attr("readonly", true);
     if(document.getElementById("mode").value=='A'){
         $("#jqxSpecification").jqxGrid("clear");
         $("#jqxSpecification").jqxGrid("addrow", null, {});
         $("#jqxFinRegDate,#jqxDate1").jqxDateTimeInput('setDate', new Date());
         $("#jqxPurchaseDate").jqxDateTimeInput('setDate', new Date());
         $("#jqxFinRelDate").jqxDateTimeInput('setDate', new Date());
         $("#releasedate").jqxDateTimeInput('setDate', new Date());
         $("#jqxWrntyFrmDate").jqxDateTimeInput('setDate', new Date());
         $("#jqxWrntyToDate").jqxDateTimeInput('setDate', new Date());
         $("#jqxLstSrvcDate").jqxDateTimeInput('setDate', new Date());
         $("#releasetime").jqxDateTimeInput('setDate', new Date());
         changeDate(); 
         document.getElementById("accu_dep").value="0";
     }
    if(document.getElementById("cmbbrand").value!=""){
        getModel(document.getElementById("cmbbrand").value);
       }
    $('#fleetno').attr('readonly', true);
    
    funGetConfigs();
}
function getAuth() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var authItems = items[0].split(",");
            var authIdItems = items[1].split(",");
            var optionsauth = '<option value="">--Select--</option>';
            for (var i = 0; i < authItems.length; i++) {
                optionsauth += '<option value="' + authIdItems[i] + '">'
                        + authItems[i] + '</option>';
            }
            $("select#cmbauthority").html(optionsauth);
            if ($('#hidcmbauthority').val() != null) {
                $('#cmbauthority').val($('#hidcmbauthority').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getAuthority.jsp", true);
    x.send();
}
function getColor() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var colorItems = items[0].split(",");
            var colorIdItems = items[1].split(",");
            var optionscolor = '<option value="">--Select--</option>';
            for (var i = 0; i < colorItems.length; i++) {
                optionscolor += '<option value="' + colorIdItems[i] + '">'
                        + colorItems[i] + '</option>';
            }
            $("select#cmbveh_color").html(optionscolor);
            if ($('#hidcmbveh_color').val() != null) {
                $('#cmbveh_color').val($('#hidcmbveh_color').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getColor.jsp", true);
    x.send();
}
function getPlateCode(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var plateItems = items[0].split(",");
            var plateIdItems = items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            if(plateItems!=''){
            for (var i = 0; i < plateItems.length; i++) {
                optionsplate += '<option value="' + plateIdItems[i] + '">'
                        + plateItems[i] + '</option>';
            }
            }
            $("select#cmbplate").html(optionsplate);
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getPlateCode.jsp?id="+value, true);
    x.send();
}
function getGroup() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var groupItems = items[0].split(",");
            var groupIdItems = items[1].split(",");
        
            var optionsgroup = '<option value="">--Select--</option>';
            for (var i = 0; i < groupItems.length; i++) {
                optionsgroup += '<option value="' + groupIdItems[i] + '">'
                        + groupItems[i] + '</option>';
            }
    
            $("select#cmbgroup").html(optionsgroup);
            
            if ($('#hidcmbgroup').val() != null) {
                $('#cmbgroup').val($('#hidcmbgroup').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getGroup.jsp", true);
    x.send();
}
function getLevel(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#group_name').val(items);
            
        } else {
        }
        
    }
    x.open("GET", "../vehiclemaster/getLevel.jsp?id="+value, true);
    x.send();
}
function getBrand() {
    
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('***');
            var brandItems = items[0].split(",");
            var brandidItems = items[1].split(",");
            var optionsbrand = '<option value="">--Select--</option>';
            for (var i = 0; i < brandItems.length; i++) {
                optionsbrand += '<option value="' + brandidItems[i] + '">'
                        + brandItems[i] + '</option>';
            }
            $("select#cmbbrand").html(optionsbrand);
            if ($('#hidcmbbrand').val() != null) {
                $('#cmbbrand').val($('#hidcmbbrand').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getBrand.jsp", true);
    x.send();
}
function getTestModel(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var modelItems = items[0].split(",");
            var modelidItems = items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            for (var i = 0; i < modelItems.length; i++) {
                optionsmodel += '<option value="' + modelidItems[i] + '">'
                        + modelItems[i] + '</option>';
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null) {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
    x.send();
}
function getModel(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var modelItems = items[0].split(",");
            var modelidItems = items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            if(modelItems!=''){
            for (var i = 0; i < modelItems.length; i++) {
                optionsmodel += '<option value="' + modelidItems[i] + '">'
                        + modelItems[i] + '</option>';
            }
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null) {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getModel.jsp?id="+value, true);
    x.send();
}
function getYOM() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var yomItems = items[0].split(",");
            var yomidItems = items[1].split(",");
            var optionsyom = '<option value="">--Select--</option>';
            for (var i = 0; i < yomItems.length; i++) {
                optionsyom += '<option value="' + yomidItems[i] + '">'
                        + yomItems[i] + '</option>';
            }
            $("select#cmbyom").html(optionsyom);
            if ($('#hidcmbyom').val() != null) {
                $('#cmbyom').val($('#hidcmbyom').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getYOM.jsp", true);
    x.send();
}
function getFinancier() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var finItems = items[0].split(",");
            var finidItems = items[1].split(",");
            var optionsfin = '<option value="">--Select--</option>';
            for (var i = 0; i < finItems.length; i++) {
                optionsfin += '<option value="' + finidItems[i] + '">'
                        + finItems[i] + '</option>';
            }
            $("select#cmbfinancer").html(optionsfin);
            if ($('#hidcmbfinancer').val() != null) {
                $('#cmbfinancer').val($('#hidcmbfinancer').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getFinancier.jsp", true);
    x.send();
}
function getBrch() {
    var x = new XMLHttpRequest();
    var items, brchItems, currItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            brchIdItems = items[0].split(",");
            brchItems = items[1].split(",");
            var optionsbrch = '<option value="">--Select--</option>';
            for (var i = 0; i < brchItems.length; i++) {
                optionsbrch += '<option value="' + brchIdItems[i] + '">'
                        + brchItems[i] + '</option>';
            }
            $("select#cmbavail_br1").html(optionsbrch);
            $("select#cmbrlsbranch").html(optionsbrch);
            if ($('#hidcmbavail_br1').val() != null) {
                $('#cmbavail_br1').val($('#hidcmbavail_br1').val());
            }
            if ($('#hidcmbrlsbranch').val() != null) {
                $('#cmbrlsbranch').val($('#hidcmbrlsbranch').val());
            }
        } else {
        }
    }
    x.open("GET", "../vehiclemaster/getBranch.jsp", true);
    x.send();
}
function getLocation(value)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                var locationItems=items[0].split(",");
                var locationidItems=items[1].split(",");
                    var optionslocation = '<option value="">--Select--</option>';
               for ( var i = 0; i < locationItems.length; i++) {
                   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
                }
               $("select#cmbrlsloc").html(optionslocation);
                if ($('#hidcmbrlsloc').val() != null) {
                $('#cmbrlsloc').val($('#hidcmbrlsloc').val());
            }
            }
        else
            {
            }
    }
    x.open("GET","../vehiclemaster/getLocation.jsp?id="+value,true);
    x.send();

}
function getTestLocation(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                var locationItems=items[0].split(",");
                var locationidItems=items[1].split(",");
                    var optionslocation = '<option value="">--Select--</option>';
               for ( var i = 0; i < locationItems.length; i++) {
                   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
                }
               $("select#cmbrlsloc").html(optionslocation);
                if ($('#hidcmbrlsloc').val() != null) {
                $('#cmbrlsloc').val($('#hidcmbrlsloc').val());
            }
            }
        else
            {
            }
    }
    x.open("GET","../vehiclemaster/getTestLocation.jsp",true);
    x.send();

}

function getStatus()
{
    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('####');
                var status=items[0].split(",");
                var stdesc=items[1].split(",");
                    var optionsstatus = '<option value="">--Select--</option>';
               for ( var i = 0; i < stdesc.length; i++) {
                   optionsstatus += '<option value="' + status[i] + '">' + stdesc[i] + '</option>';
                }
               
               $("select#cmbstatus").html(optionsstatus);
               
                if ($('#hidcmbstatus').val() != null) {
                $('#cmbstatus').val($('#hidcmbstatus').val());
            }
            }
        else
            {
            }
    }
    x.open("GET","../vehiclemaster/getStatus.jsp",true);
    x.send();

}
function setValues() {
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();

    if($('#hidreleasetime').val()){
        $("#releasetime").jqxDateTimeInput('val', $('#hidreleasetime').val());
    }
    if ($('#hidcmbfueltype').val() != null) {
        $('#cmbfueltype').val($('#hidcmbfueltype').val());
    }
    if ($('#hidpurchase').val() != null) {
        $('#purchase').val($('#hidpurchase').val());
    }
    if ($('#hidcmbplate').val() != null) {
        $('#cmbplate').val($('#hidcmbplate').val());
    } 
    if ($('#hidcmbinsurance_type').val() != null) {
        $('#cmbinsurance_type').val($('#hidcmbinsurance_type').val());
    }
    if ($('#hidcmbfuel').val() != null) {
        $('#cmbfuel').val($('#hidcmbfuel').val());
    }
     if ($('#hidcmbrentalstatus').val() != null) {
        $('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
        
    } 
    
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    
     if(document.getElementById("docno").value!=''){
         var docno1=document.getElementById("docno").value.trim();
         $("#specdiv").load("specificationGrid.jsp?aaa=aaa&docno1="+docno1);
        }
}

 function funFocus()
    {
        document.getElementById("cmbauthority").focus();
            
    }
    $(function(){
        $('#frmVehicle').validate({
                 rules: {
                cmbauthority:"required",
                cmbplate:"required",
                cmbgroup:"required",
                regno:"required",
                cmbbrand:"required",
                cmbmodel:"required",
                cmbyom:"required",
                purchase_cost:"required",
                cmbavail_br1:"required",
                purchase:"required",
                cmbfueltype:"required",
                fuelcapacity:"required",
                cmbfuel:"required",
                purchase_cost:"number",
                additions:"number",
                current_km:"required",
                accu_dep:"required"
                 }, 
        messages:{
            cmbauthority:" *",
            cmbplate:" *",
            cmbgroup:" *",
            regno:" *",
            cmbbrand:" *",
            cmbmodel:" *",
            cmbyom:" *",
            purchase_cost:" *",
            cmbavail_br1:" *",
            purchase:" *",
            cmbfueltype:" *",
            fuelcapacity:" *",
            cmbfuel:" *",
            purchase_cost:"Digits",
            additions:"Digits",
            current_km:"*",
            accu_dep:"*"
        
        }
        });
        });
     function funNotify(){
         if($("#defaultdeprconfig").val()!="1"){  
             if(document.getElementById("purchase_cost").value==""){
                 document.getElementById("errormsg").innerText="";
                 document.getElementById("errormsg").innerText="Purchase Cost is Mandatory";
                 $('#inductiontab').trigger('click');
                 document.getElementById("purchase_cost").focus();
                 return 0;
             }
         }
         if(document.getElementById("cmbfueltype").value==""){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Fuel Type is Mandatory";
             $('#servtab').trigger('click');
             document.getElementById("cmbfueltype").focus();
             return 0;
         }
         if(document.getElementById("fuelcapacity").value==""){
             document.getElementById("errormsg").innerText="";
             $('#servtab').trigger('click');
             document.getElementById("errormsg").innerText="Fuel Capacity is Mandatory";
             document.getElementById("fuelcapacity").focus();
             return 0;
         }
        
         if(document.getElementById("cmbfuel").value==""){
             document.getElementById("errormsg").innerText="";
             $('#servtab').trigger('click');
             document.getElementById("errormsg").innerText="Fuel is Mandatory";
             document.getElementById("cmbfuel").focus();
             return 0;
         }
         if(document.getElementById("cmbavail_br1").value==""){
             document.getElementById("errormsg").innerText="";
             $('#servtab').trigger('click');
             document.getElementById("errormsg").innerText="Available Branch is Mandatory";
             document.getElementById("cmbavail_br1").focus();
             return 0;
         }
        
         var rows = $("#jqxSpecification").jqxGrid('getrows');
            if(!((rows[0].doc_no=="undefined") || (rows[0].doc_no==null) || (rows[0].doc_no==""))){
         $('#gridlength').val(rows.length);
            for(var i=0 ; i < rows.length ; i++){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+i)
                .attr("name", "test"+i)
                .attr("hidden", "true");
                
            newTextBox.val(rows[i].doc_no+"::");
            
            newTextBox.appendTo('form');
            
            }
         }
            $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: false});
            $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: false});
             $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: false});
            
            var regnostatus=checkRegNo();
            if(regnostatus==false){
                return 0;
            }
            if(document.getElementById("errormsg").innerText!=""){
                return 0;   
            }else {
                document.getElementById("errormsg").innerText="";
                return 1;
            }
            $('#jqxWrntyFrmDate').jqxDateTimeInput({ disabled: true});
            $('#jqxWrntyToDate').jqxDateTimeInput({ disabled: true});
                    
     } 
    function getTotal(){
         var pcost = document.getElementById('purchase_cost').value;
         var addit = document.getElementById('additions').value;
         if (pcost == "")
             pcost = 0;
         if (addit == "")
             addit = 0;

         var result = parseFloat(pcost) + parseFloat(addit);
         if (!isNaN(result)) {
             document.getElementById('total').value = result;
         }     
         }
    function getFleetName(){
        document.getElementById("fleetname").value="";
        var r=$("#cmbbrand option:selected").text();
        var r1=$("#cmbmodel option:selected").text();
        document.getElementById("fleetname").value = r+" "+r1;
    }
function depr_percent(value){
    if(value>100){
        document.getElementById("errormsg").innerText="Depr.Percent Must be less than 100%";
        document.getElementById("depr_perc").focus();
    }else{
        document.getElementById("errormsg").innerText=""; 
    }
}
function getWarrantyDate(value){
    
    
    if(value!=''){
    var fvalue=parseInt(value);
        var tempdate= $('#jqxWrntyFrmDate').jqxDateTimeInput('getDate');
             var finaldate=new Date(new Date(tempdate).setMonth(tempdate.getMonth()+fvalue));
             $('#jqxWrntyToDate ').jqxDateTimeInput('setDate', new Date(finaldate));
    }
    
}
function getservtab(){
    
    $('#servtab').trigger('click');
    
}
function getspectab(){
    $('#spectab').trigger('click');
}
function checkRegNo(){
    var mode=document.getElementById("mode").value;
    var docno=document.getElementById("docno").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)>0){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Reg No Already Exists";
                document.getElementById("regno").focus();
                return false;
            }
            document.getElementById("errormsg").innerText="";
        } else {
        }
    }
    x.open("GET", "checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplate").value+"&mode="+mode+"&docno="+docno, false);
    x.send();
}

function funGetConfigs(){
      
     $.get('getConfigs.jsp',function(data){
        data=JSON.parse(data);
        $('#defaultdeprconfig').val(data.defaultdeprconfig);
        $('#defaultdeprpercent').val(data.defaultdeprpercent);
        if($('#defaultdeprconfig').val()=="1"){
            if($('#mode').val()=="A"){
                $('#depr_perc').val($('#defaultdeprpercent').val());
                 $('#purchase_cost').attr('readonly', true);
                 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
                        
            }
            else if($('#mode').val()=="E"){
                if($('#depr_perc').val()=="" || parseFloat($('#depr_perc').val())==0.0){
                    $('#depr_perc').val($('#defaultdeprpercent').val());
                            
                }
                 $('#purchase_cost').attr('readonly', true);
                 $('#jqxPurchaseDate').jqxDateTimeInput({ disabled: true});
        
            }
        }
    });
       
}
</script>
</head>
<body onLoad="setValues();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <form id="frmVehicle" action="saveVehicle" method="post" autocomplete="off">
        <div id="head"><jsp:include page="../../../../header.jsp" /></div>
        
                <div class="modern-ui">

                <fieldset><legend>Vehicle Details</legend>
                <table width="100%" cellspacing="0">
                    <tr>
                        <td width="68" height="24" id="f" style="text-align: right"><div align="right">Fleet No</div></td>
                        <td colspan="5">
                            <div class="input-search-container" style="width: 25%; display:inline-block;">
                                <input type="text" name="fleetno" id="fleetno" readonly tabindex="-1" value='<s:property value="fleetno"/>'>
                                <i class="fa fa-search magnifier-icon" onclick="funSearchLoad();"></i>
                            </div>
                            <input type="text" name="fleetname" id="fleetname" readonly tabindex="-1" style="width: 70%;" value='<s:property value="fleetname"/>'>
                        </td>
                        <td align="right">Date</td>
                        <td colspan="2" align="left"><div id='jqxDate1' name='jqxDate1' value='<s:property value="jqxDate1"/>'></div></td>
                        <input type="hidden" id="hidjqxDate1" name="hidjqxDate1" value='<s:property value="hidjqxDate1"/>' />
                        <td align="left">&nbsp;</td>
                        <td width="64" align="right">Doc No</td>
                        <td width="168" align="left"><input type="text" name="docno" id="docno"  readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
                    </tr>
                    <tr>
                      <td height="24" align="right">Authority</td>
                      <td><select name="cmbauthority" id="cmbauthority" value='<s:property value="cmbauthority"/>' style="width:81%;" onchange="getPlateCode(this.value);">
                        <option value="">--Select--</option>
                      </select>
                      </td><input type="hidden" id="hidcmbauthority" name="hidcmbauthority" value='<s:property value="hidcmbauthority"/>' />
                      <td align="right">Plate Code</td>
                      <td><select name="cmbplate" id="cmbplate" value='<s:property value="cmbplate"/>' style="width:75%;">
                        <option>--select--</option>
                      </select>
                      <input type="hidden" id="hidcmbplate" name="hidcmbplate" value='<s:property value="hidcmbplate"/>' /></td>
                      <td align="right">Reg No</td>
                      <td width="146" align="left"><input type="text" name="regno" id="regno" style="width:89%;" value='<s:property value="regno"/>' autocomplete="off" ></td>
                      <td align="right">Group</td>
                      <td align="left"><select name="cmbgroup" id="cmbgroup" value='<s:property value="cmbgroup"/>' style="width:74%;" onchange="getLevel(this.value);">
                        <option>--Select--</option>
                      </select>
                      </td><input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>' />
                      <td align="right">Level</td>
                      <td align="left"><input type="text" name="group_name" id="group_name" value='<s:property value="group_name"/>' tabindex="-1"></td>
                      <td align="right">&nbsp;</td>
                      <td align="left">&nbsp;</td>
                  </tr>
                    <tr>
                        <td height="24" align="right"><span style="text-align: right">Brand</span></td>
                        <td width="142"><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:81%;" onchange="getModel(this.value);">
                          <option>--Select--</option>
                        </select>
                      </td><input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>
                        <td width="66" align="right">Model</td>
                        <td width="128"><select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' style="width:75%;" onchange="getFleetName();">
                          <option>--Select--</option>
                        </select>
                      <input type="hidden" id="hidcmbmodel" name="hidcmbmodel" value='<s:property value="hidcmbmodel"/>' /></td>
                        <td width="70" align="right">YoM</td>
                        <td align="left"><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>' style="width:91%;">
                          <option>--Select--</option>
                        </select>
                      </td><input type="hidden" id="hidcmbyom" name="hidcmbyom" value='<s:property value="hidcmbyom"/>' />
                        <td width="70" align="right">Salik Tag</td>
                        <td width="166" align="left"><input type="text" id="salik_tag" name="salik_tag"   value='<s:property value="salik_tag"/>' /></td>
                        <td width="39" align="right">TC No</td>
                        <td width="123" align="left">
                            <div class="input-search-container">
                                <input type="text" id="tcno" name="tcno" value='<s:property value="tcno"/>' onkeydown="getTcno(event);"/>
                                <i class="fa fa-search magnifier-icon" onclick="tcnoSearchContent('tcnoSearchGrid.jsp?id=1'); $('#tcnowindow').jqxWindow('open');"></i>
                            </div>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                    
                </table>
<br />

                <ul id="tabs">
                    <li><a href="#" name="tab1" id="inductiontab">Induction</a></li>
                    <li><a href="#" name="tab2" id="servtab">Services And Other Details</a></li>
                    <li><a href="#" name="tab3" id="spectab">Specifications</a>
                    
                    <input type="text" id="deal_no" name="deal_no" value='<s:property value="deal_no"/>' hidden="true"/>
                    
                    <input type="text" id="interest_amt"  name="interest_amt" value='<s:property value="interest_amt"/>' hidden="true"/>
            
                    <input type="text" id="down_payment" name="down_payment" value='<s:property value="down_payment"/>' hidden="true"/>
                    
                    <input type="text" id="no_installments" name="no_installments"
                                                     value='<s:property value="no_installments"/>' hidden="true"/>
            
                                                        <span style="text-align: right"></span>
                                                        <input type="text" id="installment_amt" name="installment_amt" value='<s:property value="installment_amt"/>' hidden="true"/>
                                                        
                                                        <input type="text" id="insured_amt" name="insured_amt"  hidden="true" value='<s:property value="insured_amt"/>'/>

                    <select name="purchase" id="purchase"  hidden="true"  value='<s:property value="purchase"/>' style="width:89%;">
                      <option>--Select--</option>
                      <option value="Cash" selected>Cash</option>
                      <option value="Credit">Credit</option>
                      </select>
                    
                    <input type="text" id="premium_perc" name="premium_perc"  hidden="true" value='<s:property value="premium_perc"/>' />
                    
                    <input type="text" id="premium_amt" name="premium_amt"  hidden="true" value='<s:property value="premium_amt"/>' />
                    </li>
                </ul>

                <div id="content" >
                    <div id="tab1">
                        <table width="100%">
                            <tr >
                                    <td width="25%">
                                    <fieldset><legend>Info</legend>
                                      <table width="100%" >
                                        <tr>
                                          <td align="right">&nbsp;Registered Date</td>
                                          <td align="left"><div id='jqxFinRegDate' name='jqxFinRegDate' value='<s:property value="jqxFinRegDate"/>'></div></td>
                                          <input type="hidden" name="hiddealer" id="hiddealer" value='<s:property value="hiddealer"/>'>
                                        </tr>
                                        <tr>
                                          <td align="right">&nbsp;Reg. Expiry</td>
                                          <td align="left"><div id='jqxOtherRegExp' name='jqxOtherRegExp' value='<s:property value="jqxOtherRegExp"/>'></div></td>
                                        </tr>
                                        <tr>
                                          <td align="right">Insurance Expiry</td>
                                          <td align="left"><div id='jqxOtherInsExp' name='jqxOtherInsExp' value='<s:property value="jqxOtherInsExp"/>'></div></td>
                                            <input type="hidden" name="hidpurchase" id="hidpurchase" value='<s:property value="hidpurchase"/>'>
                                        </tr>
                                        <tr>
                                          <td align="right">Purchase Cost</td>
                                          <td align="left" ><input type="text" class="narrow-input" name="purchase_cost"  id="purchase_cost" value='<s:property value="purchase_cost"/>' style="text-align:right;" onblur="getTotal();" required/></td>
                                        </tr>
                                        <tr>
                                          <td align="right">Additions</td>
                                          <td align="left"><input type="text" id="additions" name="additions" class="narrow-input" value='<s:property value="additions"/>' style="text-align:right;" onblur="getTotal();"/></td>
                                        </tr>
                                        <tr>
                                          <td align="right">Total</td>
                                          <td align="left"><input type="text" id="total" name="total"class="narrow-input"  value='<s:property value="total"/>'  style="text-align:right;" readonly/></td>
                                        </tr>
                                        <tr>
                                          <td align="right">&nbsp;Depr %</td>
                                          <td align="left"><input type="text" id="depr_perc" class="narrow-input" name="depr_perc" value='<s:property value="depr_perc"/>' style="text-align:right;" onblur="depr_percent(this.value);"/></td>
                                        </tr>
                                        <tr>
                                          <td align="right">&nbsp;Accu. Dep.</td>
                                          <td align="left"><input type="text" id="accu_dep" name="accu_dep" class="narrow-input" value='<s:property value="accu_dep"/>' style="text-align:right;" /></td>
                                        </tr>
                                        <tr>
                                          <td align="right">&nbsp;CostTran No</td>
                                          <td align="left"><input type="text" id="tran_no" readonly name="tran_no" class="narrow-input" value='<s:property value="tran_no"/>'  tabindex="-1"/></td>
                                        </tr>
                                        <tr>
                                          <td align="right">Insur Membership</td>
                                          <td align="left"><input type="text" name="insurmember" id="insurmember" class="narrow-input" value='<s:property value="insurmember"/>' /></td>
                                        </tr>
                                        <tr>
                                          <td align="right">Tracking ID</td>
                                          <td align="left"><input type="text" name="trackid" id="trackid" class="narrow-input" value='<s:property value="trackid"/>' /></td>
                                        </tr>
                                      </table>
                                      <br />
                                        <br />
                                        <br /><br /><br />
                                        
                                        
                                        
                                      </fieldset>
                                </td>
                                <td width="25%"> 
                                    <fieldset>
                                      <legend>Other Info</legend>
                                        <table width="99%">
                                            <tr>
                                              <td align="right">Dealer</td>
                                              <td align="left">
                                                <div class="input-search-container">
                                                    <input type="text" name="dealer" id="dealer" class="narrow-input" value='<s:property value="dealer"/>' onDblClick="funSearchdblclick();" onKeyDown="getDealer(event);" placeholder="Press F3 to Search">
                                                    <i class="fa fa-search magnifier-icon" onclick="funSearchdblclick();"></i>
                                                </div>
                                              </td>
                                          </tr>
                                            <tr>
                                              <td align="right">LPO No</td>
                                              <td><input type="text" id="lpo_no" name="lpo_no" class="narrow-input" value='<s:property value="lpo_no"/>'/></td>
                                          </tr>
                                            <tr>
                                              <td align="right">Purchase Invoice</td>
                                              <td><input type="text" id="purchase_invoice" name="purchase_invoice" class="narrow-input" value='<s:property value="purchase_invoice"/>'/></td>
                                          </tr>
                                            <tr>
                                              <td align="right">Purchase Date</td>
                                              <td><div id='jqxPurchaseDate' name='jqxPurchaseDate'
                                                        value='<s:property value="jqxPurchaseDate"/>'></div></td>
                                          </tr>
                                            <tr>
                                                <td align="right">Financer</td>
                                                <td>
                                                    <div class="input-search-container">
                                                        <input type="text" name="financier" id="financier" class="narrow-input" value='<s:property value="financier"/>' ondblclick="funFinSearchdblclick();" onkeydown="getFin(event);" placeholder="Press F3 to Search">
                                                        <i class="fa fa-search magnifier-icon" onclick="funFinSearchdblclick();"></i>
                                                    </div>
                                                <input type="hidden" id="hidfinancier" name="hidfinancier"
                                                    value='<s:property value="hidfinancier"/>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="right">Release Date</td>
                                                <td align="left"><div id='jqxFinRelDate' name='jqxFinRelDate'  
                                                        value='<s:property value="jqxFinRelDate"/>'></div></td>
                                            </tr>
                                            <tr>
                                                <td align="right">Insurance Type</td>
                                                <td><select name="cmbinsurance_type"
                                                    id="cmbinsurance_type" class="narrow-input" value='<s:property value="cmbinsurance_type"/>' style="width:54%;">
                                                    <option value="">--Select--</option>
                                                  <option value="Comprehensive">Comprehensive</option>
                                                  <option value="3rdParty">3rd Party</option>
                                                </select></td>
                                            </tr>
                                            <tr>
                                                <td align="right">&nbsp;&nbsp;Insurance Comp</td>
                                                <td>
                                                    <div class="input-search-container">
                                                        <input type="text" id="insurance_comp" name="insurance_comp" class="narrow-input" placeholder="Press F3 to Search"  value='<s:property value="insurance_comp"/>' ondblclick="funInsurSearchdblclick();" onkeydown="getInsurance(event);"/>
                                                        <i class="fa fa-search magnifier-icon" onclick="funInsurSearchdblclick();"></i>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="41%" align="right">Policy No</td>
                                                <td width="59%"><input type="text" id="policy_no" name="policy_no" class="narrow-input" value='<s:property value="policy_no"/>' onblur="getservtab();" /></td><input type="hidden" id="hidjqxFinRegDate" name="hidjqxFinRegDate"
                                                    value='<s:property value="hidjqxFinRegDate"/>' />
                                            </tr>
                                            <tr>
                                              <td align="right">File No</td>
                                              <td><input type="text" name="fileno" id="fileno" class="narrow-input" value='<s:property value="fileno"/>' /></td>
                                          </tr>
                                          <tr>
                                              <td align="right">Mortgaged To</td>
                                              <td>
                                                <div class="input-search-container">
                                                    <input type="text" name="mortgaged" id="mortgaged" class="narrow-input" value='<s:property value="mortgaged"/>' placeholder="Press F3 to Search" readonly onkeydown="getMortgaged(event);"/>
                                                    <i class="fa fa-search magnifier-icon" onclick="financierSearchContent('mortgagedGrid.jsp'); $('#financierWindow').jqxWindow('open');"></i>
                                                </div>
                                              <input type="hidden" name="hidmortgaged" id="hidmortgaged" value='<s:property value="hidmortgaged"/>'/></td>
                                          </tr>
                                            
                                        </table>
                                    
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        
                                       
                                        
                                        
                                        
                                    </fieldset>
                                </td>
<input type="hidden" name="hidinsurance_comp" id="hidinsurance_comp"  value='<s:property value="hidinsurance_comp"/>'>
                                                     <input
                                                    type="hidden" id="hidjqxFinRelDate" class="narrow-input"name="hidjqxFinRelDate"
                                                    value='<s:property value="hidjqxFinRelDate"/>' /><input type="hidden" id="hidcmbinsurance_type"
                                                    name="hidcmbinsurance_type"
                                                    value='<s:property value="hidcmbinsurance_type"/>' /><input
                                                    type="hidden" id="hidjqxOtherRegExp" name="hidjqxOtherRegExp"
                                                    value='<s:property value="hidjqxOtherRegExp"/>' />
                                                    <input
                                                    type="hidden" id="hidjqxOtherInsExp" name="hidjqxOtherInsExp"
                                                    value='<s:property value="hidjqxOtherInsExp"/>' />
                                <td width="25%">
                                <fieldset id="releaseid"><legend>Fleet Release Info</legend>
                                  <table width="100%">
                                    <tr>
                                      <td colspan="3" align="center"><input type="button" name="releasesave" id="releasesave" class="myButton" value="Save" onClick="funRelease();"><input type="button" name="btnrelease" id="btnrelease" class="myButton"  value="Release" onClick="funEnable();"></td>
                                        </tr>
                                    <tr>
                                      <td width="36%" align="right">Fleet No</td>
                                      <td colspan="2" align="left"><input type="text" name="releasefleet" class="narrow-input" id="releasefleet" value='<s:property value="releasefleet"/>'></td>
                                        </tr>
                                    <tr>
                                      <td align="right">Branch</td>
                                      <td colspan="2" align="left"><select name="cmbrlsbranch" class="narrow-input" id="cmbrlsbranch" value='<s:property value="cmbrlsbranch"/>' onChange="getLocation(this.value);" style="width:50.5%;"  >
                                        <option value="">--Select--</option>
                                        </select>
                                      <input type="hidden" name="hidcmbrlsbranch" id="hidcmbrlsbranch" value='<s:property value="hidcmbrlsbranch"/>' ></td>
                                        </tr>
                                    <tr>
                                      <td align="right">Location</td>
                                      <td colspan="2" align="left"><select name="cmbrlsloc" id="cmbrlsloc" class="narrow-input" value='<s:property value="cmbrlsloc"/>' style="width:50%;" >
                                        <option value="">--Select--</option>
                                        </select>
                                          <input type="hidden" name="hidcmbrlsloc" id="hidcmbrlsloc" value='<s:property value="hidcmbrlsloc"/>'></td>
                                        </tr>
                                    <tr>
                                      <td align="right">Rental Status</td>
                                      <td colspan="2" align="left"><select name="cmbrentalstatus"class="narrow-input"  id="cmbrentalstatus" value='<s:property value="cmbrentalstatus"/>' style="width:50%;">
                                        <option value="R" >Rental</option>
                                        <option value="L">Lease</option>
                                        <option value="LM">Limousine</option>
                                        <option value="A">All</option>
                                        </select>
                                      <input type="hidden"  name="hidcmbrentalstatus" id="hidcmbrentalstatus" value='<s:property value="hidcmbrentalstatus"/>'></td>
                                        </tr>
                                    <tr>
                                      <td align="right">Date</td>
                                      <td colspan="2" align="left"><div id="releasedate" name="releasedate" value='<s:property value="releasedate"/>'> </td>
                                      <input type="hidden" name="hidreleasedate" id="hidreleasedate" value='<s:property value="hidreleasedate"/>'>
                                        </tr>
                                    <tr>
                                      <td align="right">Time</td>
                                      <td colspan="2" align="left"><div id="releasetime" class="narrow-input" name="releasetime" value='<s:property value="releasetime"/>'></td>
                                        </tr>
                                    <tr>
                                      <td align="right">KM</td>
                                      <td width="32%" align="left"><input type="text" class="narrow-input" name="releasekm" id="releasekm" value='<s:property value="releasekm"/>' tabindex="-1" readonly></td>
                                      <td width="32%" align="left">&nbsp;</td>
                                        </tr>
                                    <tr>
                                      <td align="right">Fuel</td>
                                      <td align="left"><input type="text" name="releasefuel"class="narrow-input" id="releasefuel" value='<s:property value="releasefuel"/>' tabindex="-1" readonly></td>
                                      <td align="left">&nbsp;</td>
                                        </tr>
                                    <tr>
                                      <td align="right">Op. Status</td>
                                      <td align="left"><input type="text"
                            name="opstatus" id="opstatus" class="narrow-input" value='IN' tabindex="-1" disabled="true"></td>
                                      <td align="left">&nbsp;</td>
                                        </tr>
                                    <tr>
                                      <td align="right">Ast status</td>
                                      <td align="left"><input type="text"
                            name="aststatus" id="aststatus"  style="align: left;"class="narrow-input" value='<s:property value="aststatus"/>'  tabindex="-1" ></td>
                                      <td align="left">&nbsp;</td>
                                        </tr>
                                    <tr>
                                      <td colspan="3" align="right"><div id="fleetwarning" align="center" style="color:red;font-weight:bold;">All fields are Mandatory</div></td>
                                        </tr>
                                    
                                          </table>
                                  <br /><br /><br /><br />
                                        
                                        
                                </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="tab2">
                        <table width="100%">
                            <tr>
                                <td colspan="8" >
                                    <fieldset>
                                        <legend>Vehicle Info</legend>
                                        <table width="100%">
                                            <tr>
                                                <td width="7%" height="28" align="right">Engine No</td>
                                                <td width="10%" align="left"><input type="text"
                                                    id="engine_no" name="engine_no" value='<s:property value="engine_no"/>'style="text-transform:uppercase;"/></td>
                                                <td width="5%" align="right" >Chasis No</td>
                                                <td width="10%" align="left"><input type="text"
                                                    id="chasis_no" name="chasis_no" value='<s:property value="chasis_no"/>' style="text-transform:uppercase;"/></td>
                                                <td width="5%" align="right">VIN</td>
                                              <td width="11%" ><input type="text"
                                                    name="vin" id="vin" value='<s:property value="vin"/>' /></td>
                                                <td width="9%" align="right">Fuel Type</td>
                                                <td width="8%" align="left"><select name="cmbfueltype" id="cmbfueltype" >
                                                  <option value="">--Select--</option>
                                                  <option value="P">Petrol</option>
                                                  <option value="D">Diesel</option>
                                                  <option value="E">Electric</option>
                                                </select></td>
                                                <td width="10%" align="right">Fuel Tank Capacity</td>
                                                <td width="10%" align="left"><input type="text" name="fuelcapacity" id="fuelcapacity" value='<s:property value="fuelcapacity"/>'/></td>
                                                <td width="3%" align="right">Color</td>
                                                <td width="12%" align="left"><select
                                                    name="cmbveh_color" id="cmbveh_color" value='<s:property value="cmbveh_color"/>'>
                                                        <option>--Select--</option>
                                                </select> </td>
                                                <input type="hidden" name="hidcmbveh_color" id="hidcmbveh_color" value='<s:property value="hidcmbveh_color"/>'>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="8" >
                                    <fieldset>
                                        <legend>Warranty Info</legend>
                                        <table width="100%">
                                            <tr>
                                                <td width="9%" height="28" align="right">Warranty
                                                    Period</td>
                                                <td width="9%" align="left"><input type="text"
                                                    id="warranty_period" name="warranty_period" value='<s:property value="warranty_period"/>' onblur="getWarrantyDate(this.value);"/></td>
                                                <td width="7%" align="right">From Date</td>
                                                <td width="8%" align="left"><div id='jqxWrntyFrmDate'
                                                        name='jqxWrntyFrmDate'
                                                        value='<s:property value="jqxWrntyFrmDate"/>'></div>
                                                         </td><input
                                                    type="hidden" id="hidjqxWrntyFrmDate" name="hidjqxWrntyFrmDate"
                                                    value='<s:property value="hidjqxWrntyFrmDate"/>' />
                                                <td width="9%" align="right">To Date</td>
                                                <td width="12%" align="left"><div id='jqxWrntyToDate'
                                                        name='jqxWrntyToDate'
                                                        value='<s:property value="jqxWrntyToDate"/>'></div> 
                                                        </td><input
                                                    type="hidden" id="hidjqxWrntyToDate" name="hidjqxWrntyToDate"
                                                    value='<s:property value="hidjqxWrntyToDate"/>' />
                                                <td width="8%" align="right">Warranty KM</td>
                                                <td width="38%" align="left"><input type="text"
                                                    name="warranty_km" id="warranty_km"  value='<s:property value="warranty_km"/>' style="text-align:right;"/></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" ></td>
                            </tr>

                            <tr>
                                <td colspan="8" >
                                    <fieldset>
                                        <legend>Service Info</legend>
                                        <table width="100%">
                                            <tr>
                                                <td width="106" height="28" align="right">Service Duration (KM)</td>
                                                <td width="116" align="left"><input type="text"
                                                    id="service_km" name="service_km" value='<s:property value="service_km"/>' style="text-align:right;"/></td>
                                                <td width="79" align="right">Last Srvc. Date</td>
                                                <td width="130" align="left">
                                                        <div id='jqxLstSrvcDate'
                                                        name='jqxLstSrvcDate'
                                                        value='<s:property value="jqxLstSrvcDate"/>'></div> 
                                                        </td><input type="hidden" id="hidjqxLstSrvcDate" name="hidjqxLstSrvcDate"
                                                    value='<s:property value="hidjqxLstSrvcDate"/>' />
                                                <td width="105" align="right"><label id="lbllastsrvkm">Last Service KM</label></td>
                                                <td width="400" align="left"><input type="text"
                                                    id="last_srvc_km" name="last_srvc_km" value='<s:property value="last_srvc_km"/>' style="text-align:right;"/></td>
                                                <td width="109" align="right">&nbsp;</td>
                                                <td width="185" align="left">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="8" >
                                    <fieldset>
                                      <legend>Release Info</legend>
                                        <table width="100%">
                                            <tr>
                                                <td width="107" height="30" align="right">Current KM</td>
                                                <td width="149" align="left"><input type="text"
                                                    id="current_km" name="current_km" value='<s:property value="current_km"/>' style="text-align:right;"/></td>
                                                <td width="45" align="right">Fuel</td>
                                                <td width="139" align="left"><select name="cmbfuel" 
                                                    id="cmbfuel" value='<s:property value="cmbfuel"/>'><option value=0.000>Level 0/8</option><option value=0.125 selected>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                                                </select>
                                                <input type="hidden" id="hidcmbfuel" name="hidcmbfuel"
                                                    value='<s:property value="hidcmbfuel"/>' /></td><input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
                                              <td width="88" align="right">Avail. Br.</td>
                                            <td width="134" align="left"><select
                                                    name="cmbavail_br1" id="cmbavail_br1" value='<s:property value="cmbavail_br1"/>'>
                                              </select>
                                              <input type="hidden" id="hidcmbavail_br1" name="hidcmbavail_br1"
                                                    value='<s:property value="hidcmbavail_br1"/>' />
                                              <input type="hidden" id="tcno2" name="tcno2" style="width: 275px;" value='<s:property value="tcno2"/>'/></td>
                                              <td width="251" align="right">Calibration Km</td>
                                            <td width="503" align="left"><input type="text" name="calibrationkm" id="calibrationkm" value='<s:property value="calibrationkm"/>' style="text-align:right;"  onblur="getspectab();"></td>
                                            <td width="172" align="left"><select name="branded" id="branded" value='<s:property value="branded"/>' hidden="true">
                                                        
                                                    <option value="Y" selected>Y</option>
                                                    <option value="N">N</option>
                                              </select>
                                              <input type="hidden" id="hidbranded" name="hidbranded"
                                                    value='<s:property value="hidbranded"/>' />
                                              </td>
                                              <input type="hidden" name="hidreleasetime" id="hidreleasetime" value='<s:property value="hidreleasetime"/>'>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="tab3"><table width="100%" >
                    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  <tr><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
  
    <td><div id="specdiv"><center><jsp:include page="specificationGrid.jsp"></jsp:include></center></div></td>
    </tr>
</table>

                        
                        
                    </div>

                </div>
                </div> </fieldset>
            <input type="hidden" name="defaultdeprconfig" id="defaultdeprconfig">
            <input type="hidden" name="defaultdeprpercent" id="defaultdeprpercent">
          
        </form>
<br/>
<div id="dealerWindow">
                <div></div><div></div>
                </div>
                <div id="tcnowindow">
                <div></div><div></div>
                </div>
<div id="financierWindow">
                <div></div><div></div>
                </div>
<div id="insuranceWindow">
                <div></div><div></div>
                </div>
                <div id="specwindow">
                <div></div>
                </div>
<div id="releaseWindow">
                <div></div><div style="background-color:#E0ECF8;"></div>
                
                </div>
    </div>
</body>
</html>