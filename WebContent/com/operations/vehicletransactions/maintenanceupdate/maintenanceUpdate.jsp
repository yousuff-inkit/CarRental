<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<style>
    /* --- GLOBAL LAYOUT --- */
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
    }

    #frmmaint {
        max-width: 98%; /* Use full width of screen */
        margin: 20px auto;
        padding: 0 15px;
    }

    /* --- BLUE HEADER SECTION --- */
    .header-card-section {
        background: linear-gradient(to right, #dbeafe, #eff6ff);
        border-radius: 16px;
        padding: 20px 25px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
        margin-bottom: 25px;
        border: 1px solid #bfdbfe;
        overflow-x: auto; /* Allow scroll if screen is too small, prevents breaking */
    }

    .header-card-section h3 {
        color: #1e3a8a;
        font-weight: 700;
        font-size: 1.5rem;
        margin-top: 0;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgba(59, 130, 246, 0.2);
    }

    /* --- HEADER TABLE STYLING --- */
    .header-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 15px 12px; /* Horizontal and Vertical spacing between cells */
        table-layout: auto; /* Let cells fit content */
    }

    /* LABEL STYLING (Bigger, One Line, Aligned) */
    .header-table td.label-cell {
        text-align: right;
        color: #1e3a8a; /* Dark Blue Text */
        font-weight: 700; /* Bold */
        font-size: 14px; /* Bigger Size */
        white-space: nowrap; /* Forces one line */
        vertical-align: middle;
        width: 1%; /* Shrink to fit text size */
        padding-right: 5px;
    }

    /* INPUT CELL STYLING */
    .header-table td.input-cell {
        vertical-align: middle;
        /* Let input cells take available space */
    }

    /* --- PILL INPUTS --- */
    .header-card-section input[type="text"],
    .header-card-section select,
    .header-card-section .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important; /* Slightly darker border for visibility */
        border-radius: 50px !important;
        height: 38px !important; /* Consistent height */
        padding: 0 15px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 14px;
        font-weight: 500;
        width: 100% !important;
        box-sizing: border-box; 
        vertical-align: middle;
    }

    /* Focus State */
    .header-card-section input[type="text"]:focus,
    .header-card-section select:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* --- GRIDS SECTION --- */
    .grid-card-section {
        background: #ffffff;
        border-radius: 12px;
        padding: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 20px;
        border: 1px solid #e2e8f0;
    }
    
    /* Error Message */
    #errormsg {
        color: #dc2626;
        font-weight: 700;
        text-align: center;
        margin-top: 10px;
    }
    
    /* JQX Date Widget Fix inside Pill */
    .jqx-widget-content {
        border-radius: 50px !important;
        border: none !important;
    }

</style>

<script type="text/javascript">
$(document).ready(function () {      
     $("#maintainceDate").jqxDateTimeInput({  width: '100%', height: '38px', formatString:"dd.MM.yyyy"}); // Changed to 100% width
    $('#fleetsearchwindow').jqxWindow({  width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
    $('#fleetsearchwindow').jqxWindow('close');
     $("#invDate").jqxDateTimeInput({  width: '100%', height: '38px', formatString:"dd.MM.yyyy"}); // Changed to 100% width
    $('#garragesearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '70%' ,maxWidth: '50%' ,title: 'Garrage Search' , position: { x: 700, y: 60 }, keyboardCloseKey: 27});
    $('#garragesearchwindow').jqxWindow('close');
    $('#typeservsearchwndow').jqxWindow({ width: '30%', height: '59%',  maxHeight: '65%' ,maxWidth: '65%' , title: 'Type Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#typeservsearchwndow').jqxWindow('close');
     $('#serdescsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Description Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#serdescsearchwndow').jqxWindow('close'); 
    
    $('#maintainceDate').on('change', function (event) {
        var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
        funDateInPeriod(receiptdate);
       });
    $('#garagemaster').dblclick(function(){
           $('#garragesearchwindow').jqxWindow('open');
              
              garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
                 });
    
    $('#mtfleetno').dblclick(function(){
       $('#fleetsearchwindow').jqxWindow('open');
              
          fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
             });
    
              }); 
function descservSearchContent(url) {
     //alert(url);
         $.get(url).done(function (data) {
           
             $('#serdescsearchwndow').jqxWindow('open');
        $('#serdescsearchwndow').jqxWindow('setContent', data);
 
    }); 
    }  
function TypeservSearchContent(url) {
      //alert(url);
          $.get(url).done(function (data) {
            
              $('#typeservsearchwndow').jqxWindow('open');
         $('#typeservsearchwndow').jqxWindow('setContent', data);
  
     }); 
     } 
function getgarrage(event){
     var x= event.keyCode;
     if(x==114){
      $('#garragesearchwindow').jqxWindow('open');

      garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));   }
     else{
         }
     }  
      function garragechangeContent(url) {
      //alert(url);
          $.get(url).done(function (data) {
//alert(data);
       $('#garragesearchwindow').jqxWindow('setContent', data);

             }); 
    }

function getfleet(event){
     var x= event.keyCode;
     if(x==114){
      $('#fleetsearchwindow').jqxWindow('open');
 
     fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));   }
     else{
         }
     }  
      function fleetchangeContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#fleetsearchwindow').jqxWindow('setContent', data);

             }); 
        }

function funFocus(){
    
    $('#maintainceDate').jqxDateTimeInput('focus');              
}
function funReset() {
    
}
function funReadOnly() {
    $('#frmmaint input').attr('readonly', true);
    $('#frmmaint select').attr('disabled', true);
    
    $('#mtfleetno').attr('disabled', true);
    $('#garagemaster').attr('disabled', true);
    
       $("#maindowngrid").jqxGrid({ disabled: true});
       $("#mainuppergrid").jqxGrid({ disabled: true}); 
        $('#invDate').jqxDateTimeInput({ disabled: true}); 
        $('#maintainceDate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly() {
    
    $('#frmmaint input').attr('readonly', false);
    $('#frmmaint select').attr('disabled', false);
    $('#mtfleetno').attr('disabled', false);
    $('#garagemaster').attr('disabled', false);
     $('#nextserdue').attr('disabled', false);
    $('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
    $('#invDate').jqxDateTimeInput({ disabled: false}); 
    $('#mtfleetno').attr('readonly', true);
    $('#mtflname').attr('readonly', true);
    $('#garagemaster').attr('readonly', true);
    $('#docno').attr('readonly', true);
    $("#maindowngrid").jqxGrid({ disabled: false});
    $("#mainuppergrid").jqxGrid({ disabled: false}); 
    if($('#mode').val()=='A')
        {
         $('#nextserdue').attr('disabled', false);
        $('#maintainceDate').val(new Date());
        $('#invDate').val(new Date());
        $("#maindowngrid").jqxGrid('clear');
        $("#maindowngrid").jqxGrid('addrow', null, {});
        $("#mainuppergrid").jqxGrid('clear');
        $("#mainuppergrid").jqxGrid('addrow', null, {});
        
        } 
    if($('#mode').val()=='E')
    {
        if($('#maintype').val()=="repair")
         {
        
              $('#nextserdue').attr('disabled', true);
        
         }  
        else
            {
             $('#nextserdue').attr('disabled', false);
            }
    } 
    
    
    
}
function valchange()
{
if($('#maintypeval').val()!="")
 {
    
 
 $('#maintype').val($('#maintypeval').val());
 }
if($('#maintypeval').val()=="repair")
{

      $('#nextserdue').attr('disabled', true);

}   
else
    {
     $('#nextserdue').attr('disabled', false);
    }
}

function changetype()
{
    if($('#maintype').val()=="repair")
     {
    
          $('#nextserdue').attr('disabled', true);
    
     }  
    else
        {
         $('#nextserdue').attr('disabled', false);
        }
    
}

function setValues() {
     if($('#hidmaintainceDate').val()){
       $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
      }
     if($('#hidinvDate').val()){
           $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
          }
     
      if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
      document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
      valchange();
      var docval=document.getElementById("masterdoc_no").value;
      if(docval>0)
          {
          
             var indexVal2 = document.getElementById("masterdoc_no").value;
        
             $("#maingrid").load("maintGrid.jsp?maindoc="+indexVal2);
             $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
          
          }
      
}


function funNotify(){
    
    var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
       var validdate=funDateInPeriod(receiptdate);
       if(validdate==0){
       return 0; 
       }
     var fleetval=document.getElementById("mtfleetno").value;
       
       if(fleetval=="")
       {
           document.getElementById("errormsg").innerText="Select Fleet No";  
           document.getElementById("mtfleetno").focus();
           return 0;
       }
       if($('#maintype').val()=="service")
         {
        var cuurkmval=document.getElementById("currkm").value;
        var nextserkmval=document.getElementById("nextserdue").value;
       if((parseFloat(nextserkmval)<parseFloat(cuurkmval)))
           
        
        {
          
           document.getElementById("errormsg").innerText="Service Due KM Less Than Current KM";  
           document.getElementById("nextserdue").focus();
           return 0;
        }
       else
           {
           document.getElementById("errormsg").innerText="";  
           }
        
         }
       var garrage=document.getElementById("garrageid").value;
       if(garrage=="")
       {
           document.getElementById("errormsg").innerText="Select Garrage";  
           document.getElementById("garagemaster").focus();
           return 0;
       }
       
        
             var invno= document.getElementById("invno").value;
            
            if(invno=="")
                {
                 document.getElementById("errormsg").innerText=" Enter Inv NO";
                 document.getElementById("invno").focus();
                 
                 return 0;
                   }
            else
                   {
                   document.getElementById("errormsg").innerText="";
                   } 
                
        var rows = $("#mainuppergrid").jqxGrid('getrows');
          $('#maingridlength').val(rows.length);
        for(var i=0;i<rows.length;i++){
        newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "main"+i)                  
               .attr("name", "main"+i)
                 .attr("hidden", "true");
        newTextBox.val(rows[i].hidcldate+"::"+rows[i].clear+" :: "+rows[i].clremarks+" :: "+rows[i].srno+" :: "+rows[i].hidcltime+" :: ");
            
        newTextBox.appendTo('form'); 
            
           }
           
       
      var rows = $("#maindowngrid").jqxGrid('getrows');
        $('#servicegridlenght').val(rows.length);
        
       for(var i=0 ; i < rows.length ; i++){
           
           if(rows[i].description==''){
               
               $.messager.alert('Message','Select Description....!','warning');
                      return false;
               
           }
           
        newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "service"+i)
               .attr("name", "service"+i)
            .attr("hidden", "true");
       newTextBox.val(rows[i].type+"::"+rows[i].description+" :: "+rows[i].remarks+" :: "
               +rows[i].lbrcost+" :: "+rows[i].partscost+" :: "+rows[i].total+" :: ");
                                                                                                                   

       newTextBox.appendTo('form');

        
       } 
       


       var lbrcost=document.getElementById("lbrtotalcost").value;

    
       if(lbrcost==""||typeof(lbrcost)=="undefined"||typeof(lbrcost)=="NaN")
           {
        
           document.getElementById("lbrtotalcost").value=0.00;
           }
       
       
       var partscost=document.getElementById("partstotalcost").value;
    
       if(partscost==""||typeof(partscost)=="undefined"||typeof(partscost)=="NaN")
       {
           document.getElementById("partstotalcost").value=0.00;
       }
       var totalcost=document.getElementById("totalcost").value;
    
       if(totalcost==""||typeof(totalcost)=="undefined"||typeof(totalcost)=="NaN")
       {
           
           document.getElementById("totalcost").value=0.00;
       }
       
       var x =new XMLHttpRequest();
        
        x.onreadystatechange=function()
        {
        if(x.readyState==4 && x.status==200)    
        
        {
            var items=x.responseText;
            var chk=items.trim();
            
        if(parseInt(chk)==1)
            {
            
            document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
            document.getElementById("invno").focus();
            
            return 0;
            
            }
        else
            {
             document.getElementById("errormsg").innerText="";
             
             document.getElementById("frmmaint").submit();
            }
        }
        }
        
        x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value);

        x.send();   
       
 
}

function funchkinv()
{
var x =new XMLHttpRequest();
x.onreadystatechange=function()
{
if(x.readyState==4 && x.status==200)    
{
    var items=x.responseText;
    var chk=items.trim();
if(parseInt(chk)==1)
    {
    document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
    document.getElementById("invno").focus();
    return 0;
    }
else
    {
     document.getElementById("errormsg").innerText="";
     return 1;
    }
}
}
x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value);
x.send();
}

function funChkButton() {
       /* funReset(); */
      }
      
function funSearchLoad(){

    changeContent('masterSearch.jsp?', $('#updatesearchwindow'));
 }
 
$(function(){
    $('#frmmaint').validate({
            rules: {
                 currkm:{"required":true,number:true},
                 nextserdue:{"required":true,number:true},
             },
             messages: {
                 currkm:{required:" *required",number:" inValid"},
                 nextserdue:{required:" *required",number:" inValid"}
             }
    });});

function funPrintBtn(){
       if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
      
       var url=document.URL;
    var reurl=url.split("saveMaint");
    $("#docno").prop("disabled", false);                
    
var win= window.open(reurl[0]+"printMintupdate?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 
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
<form id="frmmaint" action="saveMaint" name="maintUpdate" method="post" autocomplete="OFF">

<jsp:include page="../../../../header.jsp" /><br/>

<div class='hidden-scrollbar receipt-header'>
    <div class="header-card-section">
        <h3>Maintenance Update</h3>
        
        <table class="header-table">
            <tr>
                <td class="label-cell">Date</td> 
                <td class="input-cell" style="width: 12%;">
                    <div id="maintainceDate" name="maintainceDate" value='<s:property value="date_accountmaster"/>'></div>
                    <input type="hidden" id="hidmaintainceDate" name="hidmaintainceDate" value='<s:property value="hidmaintainceDate"/>'>
                </td>
                
                <td class="label-cell">Fleet No</td> 
                <td class="input-cell" style="width: 15%;">
                    <input type="text" id="mtfleetno" name="mtfleetno" placeholder="F3" value='<s:property value="mtfleetno"/>' onkeydown="getfleet(event)">
                </td>
                
                <td class="label-cell">Name</td> 
                <td class="input-cell" style="width: 25%;">
                    <input type="text" id="mtflname" tabindex="-1" name="mtflname" value='<s:property value="mtflname"/>'>
                </td>
                
                <td class="label-cell">Doc No</td> 
                <td class="input-cell">
                    <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'>
                </td>
            </tr>
        </table>
        
        <table class="header-table">
            <tr>
                <td class="label-cell">Remarks</td>
                <td class="input-cell"> 
                    <input type="text" id="mtremark" name="mtremark" value='<s:property value="mtremark"/>'>
                </td>
            </tr>
        </table>

        <table class="header-table">
            <tr>
                <td class="label-cell">Type</td>
                <td class="input-cell">
                    <select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>'>
                        <option value="service">Service</option>
                        <option value="repair">Repair</option>   
                    </select>
                </td>
                
                <td class="label-cell">Curr.KM</td>
                <td class="input-cell">
                    <input type="text" id="currkm" name="currkm" value='<s:property value="currkm"/>'> 
                </td>
                
                <td class="label-cell">Next Due KM</td>
                <td class="input-cell">
                    <input type="text" id="nextserdue" name="nextserdue" value='<s:property value="nextserdue"/>'> 
                </td>
                
                <td class="label-cell">Garage</td>
                <td class="input-cell" style="width: 15%;">
                    <input type="text" id="garagemaster" name="garagemaster" placeholder="F3" value='<s:property value="garagemaster"/>' onkeydown="getgarrage(event)">
                </td> 
                
                <td class="label-cell">Inv No</td>
                <td class="input-cell" style="width: 8%;"> 
                    <input type="text" id="invno" name="invno" value='<s:property value="invno"/>' onblur="funchkinv();">
                </td>
                
                <td class="label-cell">Inv Date</td>
                <td class="input-cell" style="width: 12%;"> 
                    <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                    <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-card-section">
        <div class="cr-table" id="maingrid">
            <jsp:include page="maintGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <div class="grid-card-section">
        <div class="cr-table" id="servgrid">
            <jsp:include page="servicemaingrid.jsp"></jsp:include>
        </div>
    </div>

    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
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
    
    <div id="errormsg"></div>
</div>

</form>

<div id="fleetsearchwindow"><div></div></div>
<div id="typeservsearchwndow"><div></div></div>
<div id="serdescsearchwndow"><div></div></div> 
<div id="garragesearchwindow"><div></div></div>
<div id="updatesearchwindow"><div></div></div>

</body>
</html>