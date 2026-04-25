<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<%  
    String contextPath=request.getContextPath();
    ClspurchaseDirectDAO pdao=new ClspurchaseDirectDAO();
    int method=pdao.getTaxMethod();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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

/* Custom UI Buttons */
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

/* Footer Alignment */
.footer-row {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 15px;
    margin-top: 15px;
    padding-top: 10px;
    border-top: 1px solid #c5d3e0;
}
</style>

<script type="text/javascript">
    $(document).ready(function() {
         
         var meth='<%=method%>';
            
         if(meth==0){
             document.getElementById("txttaxamount").style.display="none";
             document.getElementById("lbltax").style.display="none";
         }
        
         var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
         $("#vehpurorderDate").jqxDateTimeInput(dateWidgetSettings);
         $("#vehpurinvDate").jqxDateTimeInput(dateWidgetSettings);
        
         // Force internal alignment AFTER render
         setTimeout(function () {
             $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
         }, 100);
        
         $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
         $('#accountSearchwindow').jqxWindow('close');
             
         $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
         $('#fleetwindow').jqxWindow('close');
                
            
         $('#accid').dblclick(function(){
            if($('#mode').val()!="view") {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?');
            }
         });    
    
         $("#btnEdit").attr('disabled', true );
          
         $('#vehpurorderDate').on('change', function (event) {
             var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
             if ($("#mode").val() != "view"  ) {   
                 funDateInPeriod(maindate);
             }
         });  
    });
               
    function commenSearchContent(url) {
         $.get(url).done(function (data) {
             $('#accountSearchwindow').jqxWindow('open');
             $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    }   
               
    function  getfinacc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          commenSearchContent('finaccountSearch.jsp?');
         }
    }      
               
    function fleetSearchContent(url) {
         $.get(url).done(function (data) {
             $('#fleetwindow').jqxWindow('open');
             $('#fleetwindow').jqxWindow('setContent', data);
        }); 
    } 
    
    function getaccountdetails(event){
         var x= event.keyCode;
         if(x==114){
            if($('#mode').val()!="view") {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?'); 
            }
         }
    }  
    
    function accountSearchContent(url) {
          $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    }
   
    function funReadOnly(){
            $('#frmpurchasedir input').attr('readonly', true );
            $('#frmpurchasedir select').attr('disabled', true);
            
            $('#vehpurorderDate').jqxDateTimeInput({disabled: true});
            $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
    }
    
    function funRemoveReadOnly(){
            $('#frmpurchasedir input').attr('readonly', false );
            $('#frmpurchasedir select').attr('disabled', false);
            $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
            $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
            $('#docno').attr('readonly', true);
            $('#accid').attr('readonly', true);
            if ($("#mode").val() == "A") {
                tax();
                $('#vehpurorderDate').val(new Date());
                $('#vehpurinvDate').val(new Date());
                $("#vehpurchasedirgrid").jqxGrid('clear');
                $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
            }
            
            if($('#mode').val()=='D') {
                $('#frmpurchasedir input').attr('readonly',false);  
                $('#frmpurchasedir select').attr('disabled',false); 
                $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
    
                funchkfordel(document.getElementById("masterdoc_no").value);    
                funReadOnly();
                exit();
            }
     }
    
     function funchkfordel(masterdoc_no) {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();  
                if(parseInt(items)>0) {
                    $.messager.alert('Message',' Transaction Already Exists','warning');  
                     return 0;
                } else {
                    $('#frmpurchasedir input').attr('readonly',false);  
                    $('#frmpurchasedir select').attr('disabled',false); 
                    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                    $('#frmpurchasedir').submit(); 
                }
            }
        }
        x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
        x.send();
    }
    
     function funSearchLoad(){
        changeContent('mastersearch.jsp'); 
     }
        
     function funChkButton() {
            /* funReset(); */
        }
    
     function funFocus() {
        $('#vehpurorderDate').jqxDateTimeInput('focus');            
     }
     
     function getTaxPer(date){
         var x = new XMLHttpRequest();
         x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#txttaxpercentage').val(items);
           }
         }
          x.open("GET", "getTaxper.jsp?date="+date, true);
          x.send();
      }
      
     function tax(){
            var date=$('#vehpurorderDate').val();
            getTaxPer(date);
        }
    
      function funNotify(){
          var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
           var validdate=funDateInPeriod(maindate);
           if(validdate==0){
           return 0; 
           }
          
        var purid= document.getElementById("accid").value;

        if(purid=="") {
             document.getElementById("errormsg").innerText=" Select An Account";
             document.getElementById("accid").focus();
             return 0;
        } else {
               document.getElementById("errormsg").innerText="";
        } 
        
        var invno= document.getElementById("invno").value;

        if(invno=="") {
             document.getElementById("errormsg").innerText=" Enter Invoice No";
             document.getElementById("invno").focus();
             return 0;
        } else {
               document.getElementById("errormsg").innerText="";
        } 
        
          var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
            $('#vehpurchasegridlenght').val(rows.length);
           for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "vehpurchasetest"+i)
               .attr("name", "vehpurchasetest"+i) 
               .attr("hidden", "true"); 
            
           newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
                   +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
                   +rows[i].price+" :: ");
           newTextBox.appendTo('form');
           }   
            return 1;
        } 
    
      $(function(){
            $('#frmpurchasedir').validate({
                 rules: { 
                     vehdesc:{maxlength:200},
                 },
                 messages: {
                     vehdesc: {maxlength:"  Max 250 chars"}
                 }
            });});
 
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
           document.getElementById("errormsg").innerText=" Enter Numbers Only";  
            return false;
        }
        document.getElementById("errormsg").innerText="";  
        return true;
    }  
    
  function setValues() {
      
       if($('#hidvehpurorderDate').val()){
             $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
          }
    
      if($('#hidvehpurinvDate').val()){
             $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
          }
      
        var indexVa5 = document.getElementById("masterdoc_no").value;
        
        if(parseInt(indexVa5)>0){
            $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
        }
        if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
         funSetlabel(); 
  }
    
     function funPrintBtn(){
           if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
           
           var url=document.URL;
           var reurl=url.split("savePurchase");
           
           $("#docno").prop("disabled", false);                
           
     var win= window.open(reurl[0]+"printPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
          
     win.focus(); 
           } 
          
           else {
                      $.messager.alert('Message','Select a Document....!','warning');
                      return false;
                     }
            
        }  
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<div class='hidden-scrollbar'>

<form id="frmpurchasedir" action="savePurchaseDir" method="post" autocomplete="off">
<div id="head"><jsp:include page="../../../../header.jsp"></jsp:include></div>

<div class="modern-ui">

    <div class="middle-panel">
        <span class="middle-panel-title">Veh. Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width:120px;">
                <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>' onblur="tax()" onchange="tax()"></div>
                <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
            </div>
            
            <div style="flex:1;"></div>
            
            <label class="lbl-right" style="width:100px;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:150px; background-color:#fff;" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Vendor</label>
            <div class="input-search-container" style="width:120px;">
                <input type="text" id="accid" name="accid" placeholder="F3 Search" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)"/>
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){$('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsSearch.jsp?');}" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="vehpuraccname" name="vehpuraccname" style="flex:1;" value='<s:property value="vehpuraccname"/>'/>
            <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/>
            
            <label class="lbl-right" style="width:100px;">Inv No</label>
            <input type="text" id="invno" name="invno" style="width:120px;" value='<s:property value="invno"/>'/>
            
            <label class="lbl-right" style="width:100px;">Purchase Date</label>
            <div style="width:120px;">
                <div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
                <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
            </div>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="vehdesc" name="vehdesc" style="width:50%;" value='<s:property value="vehdesc"/>'/>
        </div>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Vehicle Details</span>
        
        <div class="grid-container">
            <div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div> 
        </div>

        <div class="footer-row">
            <label class="lbl-right" id="lbltax">Tax Amount</label>
            <input type="text" name="txttaxamount" id="txttaxamount" style="width:120px; text-align:right;" value='<s:property value="txttaxamount"/>' >
            
            <label class="lbl-right" style="margin-left: 20px;">Net Total</label>
            <input type="text" name="txtnetotal" id="txtnetotal" style="width:120px; text-align:right;" value='<s:property value="txtnetotal"/>'>
        </div>
    </div>


<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="headacccode" name="headacccode"  value='<s:property value="headacccode"/>'/>
<input type="hidden" id="txttaxpercentage" name="txttaxpercentage"  value='<s:property value="txttaxpercentage"/>'/>
<input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght"  value='<s:property value="vehpurchasegridlenght"/>'/>

</form>

<div id="accountSearchwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
 
</div>
</div>
</div>
</body>
</html>