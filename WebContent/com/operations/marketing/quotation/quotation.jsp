<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<% String contextPath=request.getContextPath();%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
SCOPED UI: Stable Modern Layout (Clean White)
========================================================= */
body {
    background: #ffffff; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e5e7eb; 
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 0;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Stable 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
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
.modern-ui input[type="email"]:focus,
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

/* Layout Utilities - Natural Wrapping */
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
    padding-right: 4px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 20px;
    margin-top: 15px; 
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -10px; 
    left: 10px; 
    background: #ffffff; 
    padding: 0 6px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
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
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Custom UI Buttons */
.modern-ui .myButton {
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
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 5px; display: block;}
</style>

<script type="text/javascript">   
   $(document).ready(function () {  
       /* STRICT 24px DATE INPUTS */
       $("#jqxQuoteDate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy" });
       
       setTimeout(function () {
             $(".jqx-datetimeinput").css({
                 "border": "1px solid #b8c6d8", "border-radius": "3px", "height": "24px", "box-sizing": "border-box"
             });
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "22px", "height": "22px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box",
                 "border": "none", "background": "transparent"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({
                 "top": "0px", "height": "22px", "border": "none", "background-color": "transparent"
             });
       }, 0);

       $('#descsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#descsearchwndow').jqxWindow('close');
       $('#brandsearchwndows').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#brandsearchwndows').jqxWindow('close'); 
       $('#modelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#modelsearchwndows').jqxWindow('close');
       $('#yomsearchwindow').jqxWindow({ width: '10%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'YOM Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
       $('#yomsearchwindow').jqxWindow('close');
       $('#colorsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 600, y: 100 }, keyboardCloseKey: 27});
       $('#colorsearchwndows').jqxWindow('close');
       $('#groupsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 1080, y: 100 }, keyboardCloseKey: 27});
       $('#groupsearchwndows').jqxWindow('close');
       $('#qotclientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#qotclientsearch').jqxWindow('close');
       $('#qotenqsearch').jqxWindow({ width: '55%', height: '59%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#qotenqsearch').jqxWindow('close');
       $('#tariffinbtnwindow').jqxWindow({ width: '50%', height: '47%',  maxHeight: '95%' ,maxWidth: '50%' , title: 'Tariff Search' ,position: { x: 150, y: 150 }, keyboardCloseKey: 27});
       $('#tariffinbtnwindow').jqxWindow('close'); 
            
       $('#emailwindow').jqxWindow({width: '75%', height: '85%',  maxHeight: '90%' ,maxWidth: '75%' , title: 'E-Mail',position: { x: 150, y: 77 } , theme: 'energyblue', showCloseButton: true,resizable: false});
       $('#emailwindow').jqxWindow('close');
               
       $('#jqxQuoteDate').on('change', function (event) {
            var maindate = $('#jqxQuoteDate').jqxDateTimeInput('getDate');
             if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
           funDateInPeriod(maindate);
             }
       });
       
       $('#cl_dcocno').dblclick(function(){
             if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
                $('#qotclientsearch').jqxWindow('open');
                quotclientSearchContent('quotclientINgridsearch.jsp?', $('#qotclientsearch')); 
             }
       });  
       $('#refno').dblclick(function(){
            $('#qotenqsearch').jqxWindow('open');
           enqSearchContent('enqMastersearch.jsp?', $('#qotenqsearch')); 
       }); 
                
        $('#ratariffbutton').click(function(){
            if(($('#tarigrpid').val()!="")) {  
                $('#tariffinbtnwindow').jqxWindow('open');
               $('#tariffinbtnwindow').jqxWindow('focus');     
               tariffbtnSearchContent('gettariffbtn.jsp?vehgpid='+document.getElementById("tarigrpid").value+"&cldocno="+document.getElementById("cl_dcocno").value);
             } else {
              document.getElementById("errormsg").innerText="  Select Group";
               return false;
             }
         });
   });
   
   function tariffbtnSearchContent(url) {
       $.get(url).done(function (data) {
         $('#tariffinbtnwindow').jqxWindow('setContent', data);
  	   }); 
  	}
 
    function descinfoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#descsearchwndow').jqxWindow('open');
        $('#descsearchwndow').jqxWindow('setContent', data);
    }); 
    } 
   function brandSearchContent(url) {
         $.get(url).done(function (data) {
             $('#brandsearchwndows').jqxWindow('open');
        $('#brandsearchwndows').jqxWindow('setContent', data);
    }); 
    } 
   function yomSearchContent(url) {
         $.get(url).done(function (data) {
             $('#yomsearchwindow').jqxWindow('open');
        $('#yomsearchwindow').jqxWindow('setContent', data);
    }); 
    } 
   
   function modelSearchContent(url) {
         $.get(url).done(function (data) {
             $('#modelsearchwndows').jqxWindow('open');
        $('#modelsearchwndows').jqxWindow('setContent', data);
    }); 
    } 
   function colorSearchContent(url) {
         $.get(url).done(function (data) {
             $('#colorsearchwndows').jqxWindow('open');
        $('#colorsearchwndows').jqxWindow('setContent', data);
    }); 
    }
   function groupSearchContent(url) {
         $.get(url).done(function (data) {
             $('#groupsearchwndows').jqxWindow('open');
        $('#groupsearchwndows').jqxWindow('setContent', data);
    }); 
    }
  function getclinfo1(event){
         if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
     var x= event.keyCode;
     if(x==114){
      $('#qotclientsearch').jqxWindow('open');
  
     quotclientSearchContent('quotclientINgridsearch.jsp?', $('#qotclientsearch'));  }  }
     else{
         }
     }  
      function quotclientSearchContent(url) {
           $.get(url).done(function (data) {
         $('#qotclientsearch').jqxWindow('setContent', data);
    }); 
        } 
      function getenq(event){
         var x= event.keyCode;
         if(x==114){
          $('#qotenqsearch').jqxWindow('open');
      
          enqSearchContent('enqMastersearch.jsp?', $('#qotenqsearch'));   }
         else{
             }
         }  
          function enqSearchContent(url) {
                 $.get(url).done(function (data) {
               $('#qotenqsearch').jqxWindow('setContent', data);
        
            }); 
            } 
  
      function funReadOnly(){
        $('#frmQuote input').attr('readonly', true);
        $('#frmQuote textarea').attr('readonly', true );
        $('#jqxQuoteDate').jqxDateTimeInput({ disabled: true});
        $('#refno').attr('disabled', true);
        $('#frmQuote select').attr('disabled', true );
          $("#qutgrid").jqxGrid({ disabled: true});
          $("#tarifcalGrid").jqxGrid({ disabled: true});
          $("#tarifGrid").jqxGrid({ disabled: true});
          $("#descgrid").jqxGrid({ disabled: true});
          $('#ratariffbutton').attr('disabled', true);   
          
        $('#Sendmail').show();
      }
      
      function funRemoveReadOnly(){
          $('#Sendmail').hide();
        $('#frmQuote input').attr('readonly', false );
      
          $('#cl_dcocno').attr('readonly', true);
          $('#client_details').attr('readonly', true);
          $('#frmQuote textarea').attr('readonly', false );
          $('#jqxQuoteDate').jqxDateTimeInput({ disabled: false});
         $('#refno').attr('disabled', true);
          $('#frmQuote select').attr('disabled', false );
          $('#docno').attr('readonly', true);
          $('#refno').attr('readonly', true);
          
          $('#txt_mobile').attr('readonly', true);
          $('#txt_email').attr('readonly', true);
          
          $('#ratariffbutton').attr('disabled', false);   
          
          $("#qutgrid").jqxGrid({ disabled: false});
          $("#tarifcalGrid").jqxGrid({ disabled: false});
          $("#tarifGrid").jqxGrid({ disabled: false});
          $("#descgrid").jqxGrid({ disabled: false});
        
        if ($("#mode").val() == "A") {
            $('#jqxQuoteDate').val(new Date());
              $("#qutgrid").jqxGrid('clear');
            $("#qutgrid").jqxGrid('addrow', null, {});
             $("#tarifcalGrid").jqxGrid('clear');
            $("#tarifcalGrid").jqxGrid('addrow', null, {});
             $("#descgrid").jqxGrid('clear');
            $("#descgrid").jqxGrid('addrow', null, {});
               $("#tarifcalGrid").jqxGrid('addrow', null,  {});
               
                 $("#tarifDivId").load("tarifGrid.jsp?");
           }
        if ($("#mode").val() == "E") {
             $("#qutgrid").jqxGrid({ disabled: false});
              $("#tarifcalGrid").jqxGrid({ disabled: false});
              
              $("#tarifGrid").jqxGrid({ disabled: false});
              $("#descgrid").jqxGrid({ disabled: false});
              $("#qutgrid").jqxGrid('addrow', null, {});
          if( document.getElementById("cmbreftype").value=="CEQ")
          {
          $('#refno').attr('disabled', false);
          
          }
        else{
          $('#refno').attr('disabled', true);
           }
          
           }
        
        if ($("#mode").val() == "D") {    
            $('#refno').attr('disabled', false);
            $('#cmbreftype').attr('disabled', false);
        }
      }
      
   function funReset(){
    //  $('#frmQuote')[0].reset(); 
    }

    function funNotify(){   
        var maindate = $('#jqxQuoteDate').jqxDateTimeInput('getDate');
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
            var validdate=funDateInPeriod(maindate);
            if(validdate==0){
            return 0; 
            }
         }
        
        if ($("#mode").val() == "A") {
        var saveval=document.getElementById("errorvalid").value;
        if(saveval==1)
            {
             document.getElementById("errormsg").innerText="Select Rental Type";
             return false;
            }
        else
            {
            document.getElementById("errormsg").innerText="";
            }
        }
        
         if( document.getElementById("cmbreftype").value=="CEQ")
            {
          var refno= document.getElementById('refno').value;
             
             if(refno=="")
             {
                 document.getElementById("errormsg").innerText=" Select Ref NO";  
                 document.getElementById('refno').focus();
                 return 0;
             }
             else
                 {
                 document.getElementById("errormsg").innerText="";
                 }
            }
         else
             {
             document.getElementById("errormsg").innerText="";
             }
        
        var cldcocno=document.getElementById("cl_dcocno").value;
        
        if(cldcocno==""){
             document.getElementById("errormsg").innerText="Select Client";
             document.getElementById("cl_dcocno").focus();
             return  0;
                     }
        else
            {
             document.getElementById("errormsg").innerText="";
            }
        
                 var rows1 = $("#qutgrid").jqxGrid('getrows');
                  for(var i=0 ; i < rows1.length ; i++){
                     if(i==0)
                         {
                         var brdid=rows1[i].brdid;
                        
                        if(brdid==""||typeof(brdid)=="undefined"||typeof(brdid)=="NaN")
                            {
                            document.getElementById("errormsg").innerText="Select Brand";  
                        return 0;
                            }
                         }
                    }
            
         var rows = $("#qutgrid").jqxGrid('getrows');
            $('#quotgridlenght').val(rows.length);
           for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "quottest"+i)
               .attr("name", "quottest"+i)
                   .attr("hidden", "true"); 
        
           newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
                   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].renttype+" :: "
                   +rows[i].hidfromdate+" :: "+rows[i].hidtodate+" :: "+rows[i].unit+" :: "+rows[i].grpid+" :: "+rows[i].yomid+" :: ");
        
           newTextBox.appendTo('form'); 
        
                       } 
           
           var rows = $("#tarifcalGrid").jqxGrid('getrows');
            $('#tarifgridlength').val(rows.length);
           for(var i=0;i<rows.length;i++){
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "test"+i)
               .attr("name", "test"+i)
                   .attr("hidden", "true"); 
                                   
           newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+" :: "+rows[i].cdw+" :: "
                   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
                   +rows[i].exkmrte+" :: "+rows[i].oinschg+" :: "+rows[i].exhrchg+" :: "+rows[i].grpid+"::"+rows[i].sr_no+"::"+rows[i].tdocno);
           newTextBox.appendTo('form'); 
            
           }
            
             var rows = $("#descgrid").jqxGrid('getrows');
                    $('#descgridlenght').val(rows.length);
                   for(var i=0 ; i < rows.length ; i++){
                    newTextBox = $(document.createElement("input"))
                       .attr("type", "dil")
                       .attr("id", "desctest"+i)
                       .attr("name", "desctest"+i)
                           .attr("hidden", "true"); 
                
                   newTextBox.val(rows[i].sr_no+"::"+rows[i].desid+" :: "+rows[i].descplus+" :: " );
                   newTextBox.appendTo('form'); 
                
                            } 
                    
                    
           return 1;
    }

    function funChkButton() {
        /* funReset(); */
    }

    function funSearchLoad(){
        changeContent('quotmasterSearch.jsp'); 
    }
        
    function funFocus(){
        $('#jqxQuoteDate').jqxDateTimeInput('focus');           
    }
    function fundisrefno()
    {
        if( document.getElementById("cmbreftype").value=="CEQ")
            {
            $('#refno').attr('disabled', false);
            
            document.getElementById("reftypeval").value="CEQ";
            }
        else{
            document.getElementById("reftypeval").value="";
            $('#refno').attr('disabled', true);
        }
                
        if( document.getElementById("cmbreftype").value=="DIR")
        {
            $('#refno').attr('disabled', false);
            document.getElementById("refno").value="";
            $('#refno').attr('disabled', true);
        }
    
    }
    
    function funval()
    {
         if($('#reftypeval').val()!="")
          {
          $('#cmbreftype').val($('#reftypeval').val());
          }
         var docvall=document.getElementById("masterdoc_no").value;
         if(docvall<=0)
             {
            if(document.getElementById("reftypeval").value=="CEQ")
            {
            $('#refno').attr('disabled', false);
            }
        else{
            $('#refno').attr('disabled', true);
           }
    }
    }
    
    function setValues() {
        if($('#hidjqxQuoteDate').val()){
            $("#jqxQuoteDate").jqxDateTimeInput('val', $('#hidjqxQuoteDate').val());
               }
         if($('#msg').val()!=""){
                
               $.messager.alert('Message',$('#msg').val());
              }
         var indexval2 = document.getElementById("masterdoc_no").value;
         if(indexval2>0)
             {
                 $("#qutdetaildiv").load("quatDetails.jsp?qutdocno1="+indexval2);
                 $("#targridcalc").load("taricalcu.jsp?qutdocno2="+indexval2);
                 $("#descdiv").load("descgrid.jsp?qutdocno3="+indexval2);
        
             }
        
            
         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        
        funval();
    }
    
    function funPrintBtn(){
       if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
      
       var url=document.URL;

         var reurl=url.split("saveQuote");
         
         $("#docno").prop("disabled", false);                
         
   
 var win= window.open(reurl[0]+"printQuot?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
      
 win.focus();
       } 
      
       else {
                  $.messager.alert('Message','Select a Document....!','warning');
                  return false;
                 }
            
    }
    function funSendmail()
    {
            
         if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
          
        if(document.getElementById("txt_email").value=="")
            {
            document.getElementById("errormsg").innerText="Recipient Is  Mandatory";  
            return 0;
            }
             
             
        sample();
        
         var recipient1=document.getElementById("txt_email").value; 
        var recipient=recipient1.replace(/ /g, "%20");
         }
        else {
              $.messager.alert('Message','Select a Document....!','warning');
              return false;
             }
        
    }
 
    function sample()
    {
        var formcode=document.getElementById("formdetailcode").value;
        var recep=document.getElementById("txt_email").value.trim();
        var genterms=document.getElementById("desc_main").value.trim();
        
        $.ajaxFileUpload
          (  
              {  
                
                  url: 'jspToPdf.action?docno='+document.getElementById("docno").value+"&formcode="+formcode+"&recep="+recep+"&genterms="+genterms,  
                  secureuri:false,//false  
                  fileElementId:'file', //id  <input type="file" id="file" name="file" />  
                  dataType: 'json',// json  
                  success: function (data, status)  //  
                  {  
                      //alert(status);
                     if(status=='success'){
                        
                        
                      }
                     if(status=='error'){
                         // $.messager.alert('Message',"E-Mail Sending failed");
                     }
                     
                      $("#testImg").attr("src",data.message);
                      if(typeof(data.error) != 'undefined')  
                      {  
                          if(data.error != '')  
                          {  
                              alert(data.error);  
                          }else  
                          {  
                              alert(data.message);  
                          }  
                      }  
                  },  
                   error: function (data, status, e)
                  {  
                      alert(e);  
                  }  
              }  
          ) 
          return false;
      }
    
</script>
 
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuote" action="saveQuote" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
<span id="errormsg"></span>

    <div class="middle-panel">
        <span class="middle-panel-title">Quotation Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width: 80px;">Date</label>
            <div style="width: 120px;">
                <div id='jqxQuoteDate' name='jqxQuoteDate'></div>
            </div>
            <input type="hidden" id="hidjqxQuoteDate" name="hidjqxQuoteDate" value='<s:property value="hidjqxQuoteDate"/>'/>
            
            <label class="lbl-right" style="width: 80px;">Ref Type</label>
            <select id="cmbreftype" name="cmbreftype" style="width: 100px;" onchange="fundisrefno();" value='<s:property value="cmbreftype"/>'>
                <option value="DIR">Direct</option>
                <option value="CEQ">Enquiry</option>
            </select>
            
            <label class="lbl-right" style="width: 80px;">Ref No</label>
            <div class="input-search-container" style="width: 120px;">
                <input type="text" id="refno" name="refno" readonly="readonly" value='<s:property value="refno"/>' onKeyDown="getenq(event);" placeholder="Press F3"/>
                <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#qotenqsearch').jqxWindow('open'); enqSearchContent('enqMastersearch.jsp?', $('#qotenqsearch')); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <div style="margin-left: auto; font-weight: bold; color: #0056b3; font-size: 11px;">
                User Name : <%=session.getAttribute("USERNAME")%>
            </div>

            <label class="lbl-right" style="width: 60px; margin-left: 15px;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width: 100px;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width: 80px;">Client</label>
            <div class="input-search-container" style="width: 120px;">
                <input type="text" id="cl_dcocno" name="cl_dcocno" value='<s:property value="cl_dcocno"/>' onKeyDown="getclinfo1(event);" placeholder="Press F3"/>
                <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#qotclientsearch').jqxWindow('open'); quotclientSearchContent('quotclientINgridsearch.jsp?', $('#qotclientsearch')); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="client_details" name="client_details" style="flex:1;" value='<s:property value="client_details"/>' readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width: 80px;">Mobile</label>
            <input type="text" id="txt_mobile" name="txt_mobile" style="width: 120px;" readonly="readonly" value='<s:property value="txt_mobile"/>'/>
            
            <label class="lbl-right" style="width: 80px;">Email</label>
            <input type="email" id="txt_email" name="txt_email" style="width: 250px;" value='<s:property value="txt_email"/>' />
            
            <label class="lbl-right" style="width: 80px;">Attention To</label>
            <input type="text" id="txt_attention" name="txt_attention" style="flex:1;" value='<s:property value="txt_attention"/>'/>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 80px;">Subject</label>
            <input type="text" id="txt_remarks" name="txt_remarks" style="flex:1;" value='<s:property value="txt_remarks"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Quotation Details</span>
        <div id="qutdetaildiv" style="width: 100%;"><jsp:include page="quatDetails.jsp"></jsp:include></div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Tariff Search & Selection</span>
        <div class="field-row" style="margin-bottom: 10px;">
             <button type="button" class="myButton" id="ratariffbutton" value='<s:property value="ratariffbutton"/>'>
                 <span style="display:flex; align-items:center; gap:5px;">
                     <img alt="tariffSearch" src="<%=contextPath%>/icons/tariffsearch.png" style="height:14px;"> Search Tariff
                 </span>
             </button>
        </div>
        <div id="tarifDivId" style="width: 100%;"><jsp:include page="tarifGrid.jsp"></jsp:include></div>
    </div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Tariff Calculation</span>
        <div id="targridcalc" style="width: 100%;"><jsp:include page="taricalcu.jsp"></jsp:include></div>
    </div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">General Terms</span>
        <div class="field-row" style="margin-bottom: 10px;">
            <input type="text" id="desc_main" name="desc_main" style="width: 100%;" value='<s:property value="desc_main"/>'/>
        </div>
        <div id="descdiv" style="width: 100%;"><jsp:include page="descgrid.jsp"></jsp:include></div>
    </div>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="enqrefno" name="enqrefno" value='<s:property value="enqrefno"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="qubrandval" id="qubrandval" value='<s:property value="qubrandval"/>'/>

<input type="hidden" name="tagrup" id="tagrup" value='<s:property value="tagrup"/>'/>
<input type="hidden" name="tagrupid" id="tagrupid" value='<s:property value="tagrupid"/>'/>
<input type="hidden" name="quotgridlenght" id="quotgridlenght" value='<s:property value="quotgridlenght"/>'/>

<input type="hidden" name="tarifgridlength" id="tarifgridlength" value='<s:property value="tarifgridlength"/>'/>
<input type="hidden" name="maingridlength" id="maingridlength" value='<s:property value="maingridlength"/>'/>
<input type="hidden" name="tacalrowindex" id="tacalrowindex" value='<s:property value="tacalrowindex"/>'/>
<input type="hidden" name="descgridlenght" id="descgridlenght" value='<s:property value="descgridlenght"/>'/>

<input type="hidden" name="errorvalid" id="errorvalid" value='<s:property value="errorvalid"/>'/>   <input type="hidden" name="fromdatesvals" id="fromdatesvals" value='<s:property value="fromdatesvals"/>' />  
<input type="hidden" name="todatevals" id="todatevals" value='<s:property value="todatevals"/>' />  

<input type="hidden" name="reftypeval" id="reftypeval" value='<s:property value="reftypeval"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="tarigrpid" name="tarigrpid"  value='<s:property value="tarigrpid"/>'/>
<input type="hidden" id="tdocnos" name="tdocnos"  value='<s:property value="tdocnos"/>'/>

</div>
</form>

<div id="descsearchwndow"><div ></div></div>
<div id="brandsearchwndows"><div ></div></div>
<div id="modelsearchwndows"><div ></div></div>
<div id="colorsearchwndows"><div ></div></div>
<div id="groupsearchwndows"><div ></div></div>
<div id="qotclientsearch"><div ></div></div>
<div id="qotenqsearch"><div ></div></div>
<div id="tariffinbtnwindow"><div ></div></div>
<div id="yomsearchwindow"><div ></div></div>
<div id="emailwindow"><div></div><div></div></div>

</div>
</body>
</html>