<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<% String contextPath=request.getContextPath();
   ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO();
   String method=cvp.getMethod();
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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

/* Table Alignment for Perfect Grids */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Custom UI Buttons */
.modern-ui .myButton, .modern-ui .myButtonss, .modern-ui .myButtonp {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 15px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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
    width: 100%;
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

        getNonTaxableEntity();      
        getTaxPer($('#vehpurorderDate').val());
        
        var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
        $("#vehpurorderDate").jqxDateTimeInput(dateWidgetSettings);
        $("#jqxStartDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
        $("#uptoDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
        $("#vehpurinvDate").jqxDateTimeInput(dateWidgetSettings);
        $("#vehpurorderdelDate").jqxDateTimeInput(dateWidgetSettings);

        // Force internal alignment AFTER render
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);

        $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#brandsearchwndow').jqxWindow('close'); 

        $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
        $('#modelsearchwndow').jqxWindow('close');
        $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 400, y:60 }, keyboardCloseKey: 27});
        $('#colorsearchwndow').jqxWindow('close');
        $('#groupwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 400, y:60 }, keyboardCloseKey: 27});
        $('#groupwindow').jqxWindow('close');
        $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
         $('#accountSearchwindow').jqxWindow('close');
             
         $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
         $('#refnosearchwindow').jqxWindow('close'); 
         $('#fleetwindow').jqxWindow({ width: '50%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 600, y: 60 }, keyboardCloseKey: 27});
         $('#fleetwindow').jqxWindow('close');
             
         $('#slnosearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sl NO Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
         $('#slnosearchwindow').jqxWindow('close');      
             
         $("#btnEdit").attr('disabled', true );
         $("#btnDelete").attr('disabled', true );
          
        $('#vehrefno').dblclick(function(){
            if($('#mode').val()=="A") {
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
            }
        }); 
            
        $('#financeaccid').dblclick(function(){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('finaccountSearch.jsp?');
        }); 
           
        $('#bankaccid').dblclick(function(){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('bankaccountsearch.jsp?');
        }); 
        
        $('#interestaccid').dblclick(function(){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('inetestaccsearch.jsp?');
        }); 
        
        $('#loanaccid').dblclick(function(){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('loanaccount.jsp?');
        }); 
          
        $('#vehpurorderDate').on('change', function (event) {
            var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
             if ($("#mode").val() == "A"  ) {   
                funDateInPeriod(maindate);
             }
        });  
        
        $('#accid').dblclick(function(){
            if($('#mode').val()=="A") {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?');
            }
        }); 

    });
               
    function commenSearchContent(url) {
        $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('open');
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    }   
               
    function  getloanacc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          commenSearchContent('loanaccount.jsp?');
         }
    }   
    
    function  getInterestacc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          commenSearchContent('inetestaccsearch.jsp?');
         }
    }   
    
    function  getbankacc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          commenSearchContent('bankaccountsearch.jsp?');
         }
    }   
            
    function  getfinacc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          commenSearchContent('finaccountSearch.jsp?');
         }
    }      
               
    function slnoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#slnosearchwindow').jqxWindow('open');
            $('#slnosearchwindow').jqxWindow('setContent', data);
        }); 
    } 
    
    function fleetSearchContent(url) {
         $.get(url).done(function (data) {
             $('#fleetwindow').jqxWindow('open');
            $('#fleetwindow').jqxWindow('setContent', data);
        }); 
    } 
    
    function getrefDetails(event){
         var x= event.keyCode;
         if(x==114){
            if($('#mode').val()=="A") {
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
            }
         }
    }  
    
    function refsearchContent(url) {
        $.get(url).done(function (data) {
            $('#refnosearchwindow').jqxWindow('setContent', data);
        }); 
    }
    
    function getaccountdetails(event){
         var x= event.keyCode;
         if(x==114){
            if($('#mode').val()=="A") {
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
    
    function brandinfoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#brandsearchwndow').jqxWindow('open');
            $('#brandsearchwndow').jqxWindow('setContent', data);
        }); 
    } 
    
    function modelinfoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#modelsearchwndow').jqxWindow('open');
            $('#modelsearchwndow').jqxWindow('setContent', data);
        }); 
    } 
    
    function colorinfoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#colorsearchwndow').jqxWindow('open');
            $('#colorsearchwndow').jqxWindow('setContent', data);
        }); 
    } 
        
    function groupSearchContent(url) {
        $.get(url).done(function (data) {
            $('#groupwindow').jqxWindow('open');
            $('#groupwindow').jqxWindow('setContent', data);
        }); 
    }

    
     function funReadOnly(){
            $('#frmpurchase input').attr('readonly', true );
            $('#frmpurchase select').attr('disabled', true);
            
            $('#vehpurorderDate').jqxDateTimeInput({disabled: true});
            $('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
            $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
            $("#vehoredergrid").jqxGrid({ disabled: true});
               $("#editss").prop("disabled", false);
             $('#vehrefno').attr('disabled', true);
            
                $("table#finance input").prop("disabled", true);
                $("table#finance select").prop("disabled", true);
              
                $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
                
                $('#uptoDate').jqxDateTimeInput({disabled: true});  
                 $("#updatebtn").prop("disabled", true);
                 
                 
                 $("#btnsearch").prop("disabled", true);   
                
                 
                 
                // updateposting btnCalculate editss
                   $("#editss").prop("disabled", true);
                   $("#btnCalculate").prop("disabled", true);
                   $("#updateposting").prop("disabled", true);
                 $('#invno').attr('readonly', true);
             
               $('#updatefleet').show();
               $('#updateposting').show();
               
               
     }
     function funRemoveReadOnly(){
        
            $('#frmpurchase input').attr('readonly', false );
            $('#frmpurchase select').attr('disabled', false);
            $("#vehoredergrid").jqxGrid({ disabled: false});
            $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
            $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
            $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
             $('#vehrefno').attr('disabled', true);
            $('#docno').attr('readonly', true);
            $('#accid').attr('readonly', true);
            $('#vehrefno').attr('readonly', true);
              $("#btnsearch").prop("disabled", true);   
            $('#vehpuraccname').attr('readonly', true);
            
            if ($("#mode").val() == "A") {
                $('#vehpurorderdelDate').val(new Date());
                $('#vehpurorderDate').val(new Date());
                $('#vehpurinvDate').val(new Date());
                 $("#vehoredergrid").jqxGrid('clear');
                    $("#vehoredergrid").jqxGrid('addrow', null, {});
                    
                    $("table#finance input").prop("disabled", true);
                    $("table#finance select").prop("disabled", true);
                   // $("table#finance button").prop("disabled", true);
                    $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
                    $('#uptoDate').jqxDateTimeInput({disabled: true});
                    $('#invno').attr('readonly', true);
                    $('#updatefleet').hide();
                    $('#updateposting').hide();
                    $("#editss").prop("disabled", true);
                    $("#btnCalculate").prop("disabled", true);
                    $("#updateposting").prop("disabled", true);
                    
                     $("#jqxDistributionGrid").jqxGrid('clear');
                       $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                       $("#postgrid").jqxGrid('clear');
                       $("#postgrid").jqxGrid('addrow', null, {});
                      $("#postgrid").jqxGrid('addrow', null, {});
                    
                    
               }
            
     }
    
       function funrefdisslno()
       {
           if($('#vehtype').val()=="VPO") 
              {
               $('#vehrefno').attr('disabled', false);
               $("#vehoredergrid").jqxGrid('clear');
               $("#vehoredergrid").jqxGrid('addrow', null, {});
              } 
           else
               {
               $('#vehrefno').val("");
            
               $('#vehrefno').attr('disabled', true);
               $("#vehoredergrid").jqxGrid('clear');
               $("#vehoredergrid").jqxGrid('addrow', null, {});
               
               }
       }
    
     function funSearchLoad(){
        changeContent('vehPurchaseMastersearch.jsp'); 
     }
        
     function funChkButton() {
            /* funReset(); */
        }
    
     function funFocus()
    {
        $('#vehpurorderDate').jqxDateTimeInput('focus');            
    }
    
    
    
       
      function funNotify(){
          
          var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
           var validdate=funDateInPeriod(maindate);
           if(validdate==0){
           return 0; 
           }
          
          if ($("#brchName").val() == ""||$("#brchName").val() == "null" || typeof($("#brchName").val()) == "undefined" ) { 
                
                document.getElementById("errormsg").innerText="Your Secure Session Has Expired";
                return 0;
            }
          
            
        var purid= document.getElementById("accid").value;

        if(purid=="")
            {
             document.getElementById("errormsg").innerText=" Select An Account";
            
             document.getElementById("accid").focus();
             return 0;
               }
        else
               {
               document.getElementById("errormsg").innerText="";
               } 
        
        
         if($('#vehtype').val()=="VPO")
          {
        
             var vehrefno= document.getElementById("vehrefno").value; 
             if(vehrefno=="")
                {
              document.getElementById("errormsg").innerText=" Select Refno";
            
             document.getElementById("vehrefno").focus();
             return 0;
                }
             else
                 {
                  document.getElementById("errormsg").innerText="";
                 }
    
          }
        
               
             var rows = $("#vehoredergrid").jqxGrid('getrows');
            
                
               for(var i=0 ; i < rows.length ; i++){
                    
            
                
                if(parseInt(rows[i].brdid)>0)
              {
                
          
                    if(rows[i].price=="" ||typeof(rows[i].price)=="undefined"||typeof(rows[i].price)=="NaN")
            
                    {
                    document.getElementById("errormsg").innerText="Enter Price";  
                    return 0;
                    }
                    
               
        
            
                       
                } 
                    
               }
           
               
               
               var rows = $("#vehoredergrid").jqxGrid('getrows');   
               
            $('#vehpurchasegridlenght').val(rows.length);
           //alert($('#gridlength').val());
           for(var i=0 ; i < rows.length ; i++){
           // var myvar = rows[i].tarif; 
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
           .attr("id", "vehpurchasetest"+i)
               .attr("name", "vehpurchasetest"+i) 
                   .attr("hidden", "true"); 
            
        
           newTextBox.val(rows[i].srno+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
                   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].price+" :: "+rows[i].tempval+" :: "+rows[i].diff+" :: "
                   +rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].vehgroupid);
    //alert(newTextBox.val());
           newTextBox.appendTo('form');
          
            
           }   
                 /* Applying Invoice Grid Updating Ends*/
                $('#vehpurinvDate').jqxDateTimeInput({disabled: false});    
            return 1;
        } 
      
      function calculate()
      {
        //  downpayment  perinterest calcumethod instnos
        //document.getElementById("downpayment").value
          
         if(document.getElementById("downpayment").value=="")
             {
            
             document.getElementById("errormsg").innerText="Enter Down Payment";  
             document.getElementById("downpayment").focus();
             return 0;
            
             }
          
             if(document.getElementById("perinterest").value=="")
             {
            
             document.getElementById("errormsg").innerText="Enter Percentage Interest";  
             document.getElementById("perinterest").focus();
             return 0; 
             }
          
             if(document.getElementById("instnos").value=="")
             {
            
             document.getElementById("errormsg").innerText="Enter Number Of Installments";  
             document.getElementById("instnos").focus();
             return 0;
            
             }
            
             if(document.getElementById("paymentmethod").value=="")
             {
            
             document.getElementById("errormsg").innerText="Select Payment Method";  
             document.getElementById("paymentmethod").focus();
             return 0;
            
             }  
            
         // alert("");
               var calcumethod= $('#calcumethod option:selected').text();
             // alert("calcumethod"+calcumethod);
          
            // alert(document.getElementById("calcumethod").text());
                  // $("#imagedivv").show(); 
            // return 0;
            
              $.messager.confirm('Message', 'Do you want to calculate with '+calcumethod, function(r){
                    
                   
                    if(r==false)
                      {
                        return false; 
                      }
                    else{ 
                          
    
                          $("#jqxDistributionGrid").jqxGrid('clear');
                           $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                    
                    
                          var install=document.getElementById("instnos").value;
                          var payment=document.getElementById("paymentmethod").value;
                          for(var i=0;i<parseInt(install);i++)
                              {
                        
                                //$("#imagedivv").show();
                                         //   var curdateout=new Date($('#jqxStartDate').jqxDateTimeInput('getDate')); 
                                           
                                         var dtval=$("#jqxStartDate").val();
                                      //   alert(dtval);
                                         var aa1="yes";
                                         var ss=i;
                                         
                                        
                                        var x=new XMLHttpRequest();
                                        x.onreadystatechange=function(){
                                        if (x.readyState==4 && x.status==200)
                                            {
                                            var items = x.responseText;
                                            items = items.split('::');
                                      
                                            for (var i = 0; i < install; i++) {
                                                var data=items[i];
                                                
                                            //  alert(""+items[i]);
                                                
                                                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
                                            }
                                            
                                        /* var aa=x.responseText;
                                        //  alert("aa"+aa);
                                             $("#hideDate").jqxDateTimeInput('val', aa);
                                             */
                                            
                                                 }
                                            
                                            
                                            }
                                            
                                          
                                        
                                 x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);


                                 x.send();
                                         
                                         
                                        // $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("masterdoc_no").value+'&detval='+document.getElementById("detval").value); 
                                         //  $("#ssss").load("test.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1); 
                                           //alert(document.getElementById("month").value);
                                           
                                   
                                          // var curdateout=new Date($('#hideDate').jqxDateTimeInput('getDate')); 
                                    
                                         //  alert(curdateout);
                                                 //  alert($('#hideDate').jqxDateTimeInput('getDate'));
                                                //   var d = new Date($('#hideDate').jqxDateTimeInput('getDate'));
                                                /* addmnt =  [d.getMonth()]; 
                                                  var addval=parseInt(addmnt)+(i+1);    
                                                d.setMonth(parseInt(addval));  */
                                               var loanval=document.getElementById("loanamount").value;
                                               var perint=document.getElementById("perinterest").value;
                                               var instnos=document.getElementById("instnos").value;
                                           //  alert("loanval"+loanval);
                                           //  alert("perint"+perint);
                                           // alert("instnos"+instnos);
                                            var priamount=(parseFloat(loanval)/(parseFloat(instnos))).toFixed(2); 
                                            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))).toFixed(2); 
                                    //var interest=(((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)); 
                                    
                                     var amount=(parseFloat(priamount)+parseFloat(interest)).toFixed(2);
                                              if(parseInt(payment)==2)
                                              {
                                              $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+""+"-"+document.getElementById("docno").value);
                                              }
                                               /* loanamount,perinterest instnos */
                                                    //alert("----i--------"+i) ;     
                                               
                                               
                                
                                            $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
                                            // alert(priamount+"====="+interest+"======"+amount);
                                            $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
                                            $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest);
                                            $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
                                            
                                        if(i<(parseInt(install)-1))
                                            {
                                            $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                                            //$("#imagedivv").show();
                                            }
                                        
                                           }
                                        
                              
                          
                
                    
                          
                    }
                    }); 
      }
      
      function getNonTaxableEntity(){
        
         var x = new XMLHttpRequest();
         x.onreadystatechange = function() {
          if (x.readyState == 4 && x.status == 200) {
           var items = x.responseText.trim();
           $('#txtnontaxableentity').val(items);
           
           if(parseInt($('#txtnontaxableentity').val().trim())==1){
             getTaxPer($('#vehpurorderDate').val());
           }
         }
         }
         x.open("GET", "getNonTaxableEntity.jsp", true);
         x.send();
         
      }
      
      
      function getTaxPer(date){
        
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
         if (x.readyState == 4 && x.status == 200) {
          var items = x.responseText.trim();
         
         $('#txttaxpercentage').val(items);
         
        }
        }
        
        x.open("GET", "getTaxper.jsp?date="+date+"&accid="+$('#accid').val(), true);
        x.send();
        
        }
      
      function  funUpdate()
      {
        if(document.getElementById("updatebtn").value=="Edit")
            {
            
            
            var taxamount=0;
            var taxper=$('#txttaxpercentage').val();
            var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
            
            
            taxamount=parseFloat(summaryData.sum*(parseFloat(taxper)/100));
            
            // alert(taxper);
            var totalvalue=parseFloat(taxamount)+parseFloat(summaryData.sum);
            funRoundAmt(taxamount,"taxamount");
            funRoundAmt(totalvalue,"totalamt");
            
            $('#hidtaxamount').val(taxamount);
            $('#hidtotalamt').val(totalvalue);
            
            
            
            $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
            $('#uptoDate').jqxDateTimeInput({disabled: false}); 
            
               $("table#finance input").prop("disabled", false);
                $("table#finance select").prop("disabled", false);
                
                   $("table#finance input").prop("readonly", false);
                    $("table#finance select").prop("readonly", false);
                   
                    
                    $("#loanamount").prop("readonly", true);
                   $("#financeaccname").prop("readonly", true);
                   $("#bankaccname").prop("readonly", true);
                   $("#intaccname").prop("readonly", true);
                   $("#loanaccname").prop("readonly", true);
                  // financeaccid,bankaccid,interestaccid,loanaccid   
                    $("#financeaccid").prop("readonly", true);
                       $("#bankaccid").prop("readonly", true);
                       $("#interestaccid").prop("readonly", true);
                       $("#loanaccid").prop("readonly", true);
                       $("#btnsearch").prop("disabled", false); 
                       $("#taxamount").attr('readonly', true);
                        $("#totalamt").attr('readonly', true);
               // financeaccname  bankaccname intaccname loanaccname
               
               //  downpayment  perinterest calcumethod instnos
        //document.getElementById("downpayment").value
        
                  document.getElementById("perinterest").value="";
                  document.getElementById("instnos").value="";
                  document.getElementById("dealno").value="";
                
                $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                document.getElementById("updatebtn").value="Save";
                return 0;
             
                
                
            }
            else if(document.getElementById("updatebtn").value=="Save")
        {
        
                
                 var rows1 = $("#jqxDistributionGrid").jqxGrid('getrows');
                    
                   for(var i=0 ; i < rows1.length ; i++){
            
                         var sr_no=rows1[0].sr_no;
                            if(parseInt(sr_no)!=1)
                                {
                                
                                document.getElementById("errormsg").innerText="Calculate Process ";  
                                document.getElementById("calculatebtn").focus();
                                
                                return 0;
                                }
                 // alert(rows[i].fleet_no);

                     
                   
                   }    
                 //  Account(Financier) ,Bank A/C ,  Interest A/C ,Loan A/C, Security Cheque NO,Amount,Name In Cheque, Payment Method Description
                
                   
                   if(document.getElementById("financeaccid").value=="")
                     {
                    
                     document.getElementById("errormsg").innerText="Search Financier Account ";  
                     document.getElementById("financeaccid").focus();
                     return 0;
                    
                     }
                  
                     if(document.getElementById("bankaccid").value=="")
                     {
                    
                         document.getElementById("errormsg").innerText="Search Bank Account ";  
                     document.getElementById("bankaccid").focus();
                     return 0; 
                     }
                  
                     if(document.getElementById("interestaccid").value=="")
                     {
                    
                    document.getElementById("errormsg").innerText="Search Interest Account ";  
                     document.getElementById("interestaccid").focus();
                     return 0;
                    
                     }  
                      
                     if(document.getElementById("loanaccid").value=="")
                     {
                    
                    document.getElementById("errormsg").innerText="Search Loan Account ";  
                     document.getElementById("loanaccid").focus();
                     return 0;
                    
                     }  
                       if(document.getElementById("secchaqueno").value=="")
                         {
                        
                         document.getElementById("errormsg").innerText="Enter Security Cheque NO";  
                         document.getElementById("secchaqueno").focus();
                         return 0;
                        
                         }
                      
                         if(document.getElementById("chqamount").value=="")
                         {
                        
                         document.getElementById("errormsg").innerText="Enter Amount ";  
                         document.getElementById("chqamount").focus();
                         return 0; 
                         }
                         if(document.getElementById("dealno").value=="")
                         {
                        
                         document.getElementById("errormsg").innerText="Enter Deal No";  
                         document.getElementById("dealno").focus();
                         return 0;
                        
                         }  
                         if(document.getElementById("nameincheque").value=="")
                         {
                        
                         document.getElementById("errormsg").innerText="Enter Name In Cheque";  
                         document.getElementById("nameincheque").focus();
                         return 0;
                        
                         }  
                        
                
                        
                       
                         if(document.getElementById("txtdescription").value=="")
                         {
                        
                         document.getElementById("errormsg").innerText="Enter Description";  
                         document.getElementById("txtdescription").focus();
                         return 0;
                        
                         }  
                       //aaaaaa
                         if(parseFloat(document.getElementById("priamounts").value)!=parseFloat(document.getElementById("loanamount").value))
                         {
                        
                         document.getElementById("errormsg").innerText="Net Principal Amount Should Be Equal To Loan Amount";  
                        
                         return 0;
                        
                         }  
                       
                $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                    
                   
                    if(r==false)
                      {
                        return false; 
                      }
                    else{       
                
                
                
             var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
             $('#distributionlenght').val(rows.length);
           //alert($('#gridlength').val());
           for(var i=0 ; i < rows.length ; i++){
           // var myvar = rows[i].tarif; 
            newTextBox = $(document.createElement("input")) 
               .attr("type", "dil")       
               .attr("id", "dettest"+i)   
               .attr("name", "dettest"+i)  
               .attr("hidden", "true");    
            
          /* date    priamount interest amount     */
         
           newTextBox.val(rows[i].priamount+"::"+rows[i].date+" :: "+rows[i].interest+" :: "+rows[i].amount+" :: "+rows[i].chqno+" :: ");
    //alert(newTextBox.val());
           newTextBox.appendTo('form');
           
          
            
           }
           $("table#finance input").prop("disabled", false);
           $("table#finance select").prop("disabled", false);
           $("table#finance input").prop("readonly", false);
           $("table#finance select").prop("readonly", false);  
            $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
            $('#uptoDate').jqxDateTimeInput({disabled: false}); 
            $('#frmpurchase input').attr('readonly', false );
            $('#frmpurchase select').attr('disabled', false);
            $("#vehoredergrid").jqxGrid({ disabled: false});
            $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
            $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
            $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
            $('#vehrefno').attr('disabled', false);
           document.getElementById("mode").value="ADD";
           document.getElementById("fleetupdateval").value="";
           document.getElementById("msg").value="";
           document.getElementById("detval").value="";
           
           
           //alert(document.getElementById("loanamount").value);
        // return 0;
           $('#frmpurchase').submit();
               
                    
                   
                }
             });
                    
        
        //calculate_new
        
        
        
      }
      }
      
      
      
      
      
     function  changeval()
     {
        
         if($('#vehtypeval').val()!="")
          {
          
          
          $('#vehtype').val($('#vehtypeval').val());
          }
        
         if($('#vehtypeval').val()=="VPO")
          {
        
          $('#vehrefno').attr('disabled', false);
          
      $('#vehrefno').attr('readonly', true);
    
          }
     }

      
      function setValues(){
          
          if($('#restructure').val()!="" && $('#restructure').val()!=null && $('#restructure').val()=="1"){
                document.getElementById("errormsg").innerText="Loan Restructured";
          }
          
           if($('#hidvehpurorderDate').val()){
                 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
              }
        
          
          if($('#hidvehpurorderdelDate').val()){
                 $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
              }
          if($('#hidvehpurinvDate').val()){
                 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
              }
          
            var indexVa5 = document.getElementById("masterdoc_no").value;
        
             if(parseInt(indexVa5)>0){
                
             $("#updatebtn").attr("disabled", false);   
             $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);
             
           // $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("docno").value);  
             
         //   alert(document.getElementById("detval").value);
         
         /* var aaa=document.getElementById("detval").value;
             
            if(parseInt(document.getElementById("detval").value)!=11)
                {
            $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("docno").value);  
                }  */
                
             }  
             
           //  alert()
            // alert(document.getElementById("detval").value);
           
           
             
            if(parseInt(document.getElementById("detval").value)==10)
                 {
                // jqxStartDate hidjqxStartDate uptoDate    
                //calcumethod  paymentmethod calcuval paymentval
          
               if($('#hidjqxStartDate').val()){
                     $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
                  }
               if($('#hiduptoDate').val()){
                     $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
                  }
               
               
                 $('#calcumethod').val($('#calcuval').val());
                 $('#paymentmethod').val($('#paymentval').val());
            
                 $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("masterdoc_no").value+'&detval='+document.getElementById("detval").value);  
               //  detailsdiv  distributionGrid
                 if((parseInt(document.getElementById("clstatus").value)!=1) && (parseInt(document.getElementById("fleetupdateval").value)<1))
                     {
                 
                     $.messager.alert('Message','Successfully Saved'); 
               
                     }
                     document.getElementById("detval").value="";
                     document.getElementById("msg").value="";
                    
                    
                    
                     document.getElementById("updatebtn").value="Edit"; 
                     
                     $("table#finance input").prop("disabled", true);
                 $("table#finance select").prop("disabled", true);
                
                 $("table#finance input").prop("readonly", true);
                $("table#finance select").prop("readonly", true);
                    
                    
                     }
             else if(parseInt(document.getElementById("detval").value)==11)
             {
                    
                    // alert("1");
                      
            
                    
                       $("table#finance input").prop("disabled", false);
                   $("table#finance select").prop("disabled", false);
                   
                       $("table#finance input").prop("readonly", false);
                        $("table#finance select").prop("readonly", false);
                       
                        if($('#hidjqxStartDate').val()){
                             $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
                          }
                       if($('#hiduptoDate').val()){  
                             $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
                          }   
                        
                       $("#loanamount").prop("readonly", true);
                       $("#financeaccname").prop("readonly", true);
                       $("#bankaccname").prop("readonly", true);
                       $("#intaccname").prop("readonly", true);
                       $("#loanaccname").prop("readonly", true);
                      // financeaccid,bankaccid,interestaccid,loanaccid   
                           $("#financeaccid").prop("readonly", true);
                           $("#bankaccid").prop("readonly", true);
                           $("#interestaccid").prop("readonly", true);
                           $("#loanaccid").prop("readonly", true);
                    
                   // financeaccname  bankaccname intaccname loanaccname
                    
                    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                    $('#uptoDate').jqxDateTimeInput({disabled: false});  
                    
                    
                    
                    
             $("#jqxDistributionGrid").jqxGrid('clear');
                   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                  var install=document.getElementById("instnos").value;
                 var payment=document.getElementById("paymentval").value;
                  
                  for(var i=0;i<parseInt(install);i++)
                      {
                        // alert("2");
                        // alert("install"+install);

                         /* var curdateout=new Date($('#jqxStartDate').jqxDateTimeInput('getDate')); 
                                          var d = new Date(curdateout);
                                         addmnt =  [d.getMonth()]; 
                                          var addval=parseInt(addmnt)+(i+1);    
                                        d.setMonth(parseInt(addval));
                                         */
                         var dtval=$("#jqxStartDate").val();
                          //   alert(dtval);
                             var aa1="yes";
                             var ss=i;
                             
                            
                            var x=new XMLHttpRequest();
                            x.onreadystatechange=function(){
                            if (x.readyState==4 && x.status==200)
                                {
                                var items = x.responseText;
                                items = items.split('::');
                          
                                for (var i = 0; i < install; i++) {
                                    var data=items[i];
                                    
                                //  alert(""+items[i]);
                                    
                                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
                                }
                                
                            /* var aa=x.responseText;
                            //  alert("aa"+aa);
                                 $("#hideDate").jqxDateTimeInput('val', aa);
                                 */
                                
                                     }
                                
                                
                                }
                                
                              
                            
                     x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);


                     x.send();   
                                    
                                    
                                    
                               var loanval=document.getElementById("loanamount").value;
                               var perint=document.getElementById("perinterest").value;
                               var instnos=document.getElementById("instnos").value;
                           //  alert("loanval"+loanval);
                           //  alert("perint"+perint);
                           // alert("instnos"+instnos);
                           var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
                            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
                                    //var interest=(((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)); 
                                    
                                     var amount=parseFloat(priamount)+parseFloat(interest);
                                    //  alert("------"+payment);
                                      if(parseInt(payment)==2)
                                          {
                                          $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+" "+" - "+document.getElementById("docno").value);
                                          }
                                       /* loanamount,perinterest instnos */
                                            //alert("----i--------"+i) ;     
                                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
                            /* $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,d); */
                                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
                                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest );
                                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
                                    
                                if(i<(parseInt(install)-1))
                                    {
                                    $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                                    }
                      }
                         document.getElementById("updatebtn").value="Save"; 
             
             
             
             $('#calcumethod').val($('#calcuval').val());
             $('#paymentmethod').val($('#paymentval').val());   
             $.messager.alert('Message','Not Saved');
             document.getElementById("detval").value="";
             document.getElementById("msg").value="";
             return 0;
             }
            else
             {
                
             // $('#paymentmethod').val('');
             } 
             
             if(parseInt(document.getElementById("fleetupdateval").value)==1) // fleet save
                 {
                 $.messager.alert('Message','Fleet Updated Successfully'); 
                 document.getElementById("fleetupdateval").value="";
                
                 }
             else if(parseInt(document.getElementById("fleetupdateval").value)==2)
                 {
                 $.messager.alert('Message','Fleet Not Updated');
                 document.getElementById("fleetupdateval").value="";
                 }
             if(parseInt(document.getElementById("fleetupdateval").value)==3) //posting update
             {
             $.messager.alert('Message','Posting Updated Successfully'); 
             document.getElementById("fleetupdateval").value="";
            
             }
         else if(parseInt(document.getElementById("fleetupdateval").value)==4)
             {
             $.messager.alert('Message','Posting Not Updated');
             document.getElementById("fleetupdateval").value="";
             }
             
             else
                 {
                  if($('#msg').val()!=""){
                     $.messager.alert('Message',$('#msg').val());
                  }
                 
                 document.getElementById("fleetupdateval").value="";
                 }
             
             if(parseInt(document.getElementById("tranno").value)>0)
                    {
                
                   $("#postingdiv").load("postinggrid.jsp?srno="+document.getElementById("tranno").value);  
                
                    } 
         
             if(parseInt(document.getElementById("masterstatus").value)>0)
                 {
                  
                  $("#editss").prop("disabled", false);
                 
                 }
             
             
             changeval();
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             
            
             if($('#mode').val().trim()=="view" && parseInt(document.getElementById("clstatus").value)==1)
             {
             $("#editdeal").show();
            
             $("#editdeal").prop("disabled", false);
        //   $("#editdeal").prop("readonly", false);
            
            // $('#editdeal').attr('disabled', false);
            // $('#editdeal').attr('readonly', false);
             }
             
             
        }
      
      $(function(){
            $('#frmpurchase').validate({
                 rules: { 
                     vehdesc:{maxlength:200},
                    
                 },
                         messages: {
                              
                             vehdesc: {maxlength:"  Max 200 chars"}
                      
                         }
            });});
      
      
      function calculateval()
      {
          
          if(parseInt(document.getElementById("calcumethod").value)==1)
              
              {
              var downpayment=document.getElementById("downpayment").value;
              var totalamt=document.getElementById("totalamt").value;
              
             var loanamount=parseFloat(totalamt)-parseFloat(downpayment);
            
             var aa="loanamount";
              funRoundAmt(loanamount,aa);
             
              }
             // downpayment   loanamount calcumethod totalamount

      }
      

    
    function funupdatefleet()
    {
        if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
            
            

            var rows2 = $("#vehoredergrid").jqxGrid('getrows');
            
            var fleetval=0;
               for(var i=0 ; i < rows2.length ; i++){
        
                     var brdid=rows2[i].brdid;
                    
                     if(parseInt(brdid)>=0)
                        {
                               
                            var flstatuss=rows2[i].fleet_no;
                          
                            if(parseInt(flstatuss)>0)
                                {
                                fleetval=10;
                                 break;
                                }
                            else
                                {
                                //fleetval=11;
                            
                                }
                    
                        }
               }
             
               
               if(parseInt(fleetval)==0)
                   {
                    $.messager.alert('Message','Minimum One Fleet Required','warning');
                    //document.getElementById("errormsg").innerText="All Fleets Are Updated";  
                    return 0;
                   
                   }
            
            
            
            var rows1 = $("#vehoredergrid").jqxGrid('getrows');
            
            var aa=0;
               for(var i=0 ; i < rows1.length ; i++){
        
                     var brdid=rows1[i].brdid;
                    
                     if(parseInt(brdid)>=0)
                        {
                        
                               
                            var flstatus=rows1[i].flstatus;
                            if(parseInt(flstatus)==1)
                                {
                                
                                }
                            else
                                {
                             aa=1;
                             break;
                                }
                    
                        }
               }
               
               if(parseInt(aa)==0)
                   {
                    $.messager.alert('Message','All Fleets Are Updated','warning');
                    //document.getElementById("errormsg").innerText="All Fleets Are Updated";  
                    return 0;
                   
                   }
               
                
                 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                    
                   
                    if(r==false)
                      {
                        return false; 
                      }
                    else{   
               
                          var rows = $("#vehoredergrid").jqxGrid('getrows');
                            $('#vehpurchasegridlenght').val(rows.length);
                         
                           for(var i=0 ; i < rows.length ; i++){
                          
                            newTextBox = $(document.createElement("input"))
                               .attr("type", "dil")
                               .attr("id", "vehpurchasetest"+i)
                               .attr("name", "vehpurchasetest"+i) 
                               .attr("hidden", "true"); 
                            
                            
                           newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].totper+" :: "+rows[i].clrid+" :: ");
                    
                           newTextBox.appendTo('form');
                           
                           }
                           $("table#finance input").prop("disabled", false);
                           $("table#finance select").prop("disabled", false);
                           $("table#finance input").prop("readonly", false);
                           $("table#finance select").prop("readonly", false);  
                               $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                               $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                           $('#frmpurchase input').attr('readonly', false );
                            $('#frmpurchase select').attr('disabled', false);
                            $("#vehoredergrid").jqxGrid({ disabled: false});
                            $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
                            $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                            $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                            
                            $('#frmpurchase input').attr('disabled', false );
                                                
                            $('#vehrefno').attr('disabled', false);
                           document.getElementById("mode").value="UPD";
                           document.getElementById("fleetupdateval").value="";
                           document.getElementById("msg").value="";
                           $('#frmpurchase').submit();
                           
                           
                    }
                     });
                    
                            }
                   
        
        else {
            $.messager.alert('Message','Select a Document....!','warning');
            return 0;
        }
        
    }
    
    
 function funpostcalcu()
    {
        
        var taxper=parseFloat($('#txttaxpercentage').val());
        
        var venacc=$("#headacccode").val();
        var deldate= $("#vehpurorderDate").val();
        var nettotal=parseFloat($("#totalamount").val());
        
        var loanaccdocno=$("#loanaccdocno").val();
        var downpaymnt=$("#downpayment").val();
        var dealno=$('#dealno').val();
        var taxmethod=parseInt($('#txtnontaxableentity').val().trim());
        if(taxmethod==1){
            tax=parseFloat(nettotal*(taxper/100));
            total=parseFloat(nettotal+tax);
            loanamount=parseFloat(total)-parseFloat(downpaymnt);
            // alert(tax+"==="+total+"==="+loanamount);
            
        }
        else{
            tax=parseFloat(0);
            total=parseFloat(nettotal);
            loanamount=parseFloat(nettotal)-parseFloat(downpaymnt);
            
            document.getElementById("taxlabel").style.display='none';
            document.getElementById("taxbox").style.display='none';
        }
        
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
            
            
            var items=x.responseText.split('####');
            var chkstatus=items[0].trim();

             if(parseInt(chkstatus)>0)
                 {
                 document.getElementById("tranno").value=chkstatus; 
                 document.getElementById("validatepostcalu").value=1;
                  $("#postingdiv").load("postinggrid.jsp?srno="+chkstatus);  
                   
                   
                   
                 return 0;
                 }else{
                     var msg=items[1].trim();
                     if(msg!=""){   
                         $.messager.alert('Warning',msg,'warning');
                     }
                 }
            
            
            }
            
        } 
//alert("jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+total+"&nettotal="+nettotal+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount+"&tax="+tax);
if(taxmethod==1){

    x.open("GET","jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+total+"&nettotal="+nettotal+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount+"&tax="+tax+"&dealno="+dealno,true);
}
else{
    x.open("GET","jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+nettotal+"&nettotal="+nettotal+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount+"&tax=0&dealno="+dealno,true);
}
    
    
    x.send();
        
}

    
    function funeditpost()
    {
        if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
            
        
            
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                            if (x.readyState==4 && x.status==200)
                                {
                                
                                        
                                    var items=x.responseText;
                                    var chkstatus=items.trim();
                    
                                     if(parseInt(chkstatus)==1)
                                         {
                                         $.messager.alert('Message','Posting Already Done ','warning');   
                                         return 0;
                                         }
                                     else
                                         {
                                        
                                            var rows1 = $("#vehoredergrid").jqxGrid('getrows');
                                            
                                               for(var i=0 ; i < rows1.length ; i++){
                                        
                                                     var brdid=rows1[i].brdid;
                                                    
                                                     if(parseInt(brdid)>=0)
                                                        {
                                                               
                                                         var flstatus=rows1[i].flstatus;
                                                            if(parseInt(flstatus)!=1)
                                                                {
                                                                
                                                                document.getElementById("errormsg").innerText="Update All Fleet Before Posting";  
                                                                return 0;
                                                                }
                                                    
                                                        }
                                                              }
                                                
                                        
                                        
                                        
                                        
                                        
                                        
                                         $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                                          document.getElementById("invno").value="";
                                         
                                         $('#invno').attr('readonly', false);
                
                                         $("#btnCalculate").prop("disabled", false);
                                         $("#updateposting").prop("disabled", false);
                                        
                                         
                                         }
                                    
                                    
                                }
            }
            
            x.open("GET","checkUpdate.jsp?masterdocno="+ document.getElementById("masterdoc_no").value,true);

            x.send();
            
             
        }
            
            else
            {
 
                    $.messager.alert('Message','Select a Document....!','warning');
                    return 0;
             
            }
        
                    
            }
 
    
    function funupdateposting()
    {
    //alert(1)
        
           if(document.getElementById("invno").value=="")
             {
            
             document.getElementById("errormsg").innerText="Enter Inv No";  
             document.getElementById("invno").focus();
             return 0;
            
             }
        
        
        
        
           if(parseInt(document.getElementById("validatepostcalu").value)==1)
               {
               
                
                $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                    
                       
                    if(r==false)
                      {
                        return false; 
                      }
                    else{
                        
                    
        
                   

                      var rows = $("#vehoredergrid").jqxGrid('getrows');
                        $('#vehpurchasegridlenght').val(rows.length);
                     
                       for(var i=0 ; i < rows.length ; i++){
                      
                        newTextBox = $(document.createElement("input"))
                           .attr("type", "dil")
                               .attr("id", "vehpurchasetest"+i)
                           .attr("name", "vehpurchasetest"+i) 
                           .attr("hidden", "true"); 
                        
                     
                        newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: ");
                
                       newTextBox.appendTo('form');
                       
                       }
                       $("table#finance input").prop("disabled", false);
                        $("table#finance select").prop("disabled", false);
                           $("table#finance input").prop("readonly", false);
                            $("table#finance select").prop("readonly", false);  
                    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                       
                        $('#frmpurchase input').attr('disabled', false );
                       $('#frmpurchase input').attr('readonly', false );
                        $('#frmpurchase select').attr('disabled', false);
                        $("#vehoredergrid").jqxGrid({ disabled: false});
                        $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
                        $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                        $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                        $('#vehrefno').attr('disabled', false);
                       document.getElementById("mode").value="POS";
                       document.getElementById("fleetupdateval").value="";
                       document.getElementById("msg").value="";
                       $('#frmpurchase').submit();
                   
                    }
                 });
                
                   
                   }
            
            
            
                     else
                         {
                            document.getElementById("errormsg").innerText="Calculate Before Posting";  
                            return 0;
                        
                         }
                        
            
            
                
                                            
        
        
    }
      
      
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
            {
               document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
            }
        document.getElementById("errormsg").innerText="";  
        return true;
    }  
    
    
    function funcheckaccinvendor()
    {
        if(document.getElementById("accid").value=="")
            {
            
             document.getElementById("errormsg").innerText="Search Vendor";  
             document.getElementById("accid").focus();
               
                return 0;
            }
        
    }
    
    function paymtchg()
    {
        
        document.getElementById("errormsg").innerText="";  
    }
    
     function funPrintBtn(){
           if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
          
           var url=document.URL;

             var reurl=url.split("savePurchase");
             
             $("#docno").prop("disabled", false);                
             var dtype=$('#formdetailcode').val();
       
     var win= window.open(reurl[0]+"printPurchase?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
          
     win.focus();
           } 
          
           else {
                      $.messager.alert('Message','Select a Document....!','warning');
                      return false;
                     }
                    
        } 
     
     function funchkunique()
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
        
        document.getElementById("errormsg").innerText="Deal No "+document.getElementById("dealno").value+" Already Exists ";  
        document.getElementById("dealno").value="";
        
        return 0;
        
        }
    else
        {
         document.getElementById("errormsg").innerText="";
        }
        
        
    
    }
    }
    
    x.open("GET","checkdealno.jsp?dealno="+document.getElementById("dealno").value+"&masterdoc="+document.getElementById("masterdoc_no").value);

    x.send();
        
     }

     
     
     function saveExcelDataData(docNo){
        
        
        
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var items=x.responseText.trim();
                    
                    if(items==1){
                        
                        
                        
                           $("#detailsdiv").load("distributionGrid.jsp?docNo="+docNo);
                        $.messager.alert('Message', ' Successfully Imported.', function(r){
                    });
                    }
                    
              }
            }
                
        x.open("GET","saveData.jsp?docNo="+docNo,true);
        x.send();
        }
        
        function upload(){
            var fileInput = $('#file')[0];
            if(fileInput.files.length === 0) {
                $.messager.alert('Warning', 'Please choose a file to upload before clicking the attach button.', 'warning');
                return false;
            }
            
            $('#txtexcelvalidation').val(1);
            getAttachDocumentNo();
        }
        
        function getAttachDocumentNo(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function(){
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    
                    if(items > 0){
                        var path = document.getElementById("file").value;
                        var extn = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();
                        
                        if(extn == 'xls' || extn == 'xlsx' || extn == 'csv'){ 
                            ajaxFileUpload(items);  
                        } else {
                            $.messager.show({
                                title:'Message',
                                msg: 'Only Excel (xls/xlsx) or CSV formats are supported.',
                                showType:'show',
                                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                            }); 
                        } 
                    }
                }
            }
                
            x.open("GET", "getAttachDocumentNo.jsp", true);
            x.send();
        }
        
        function ajaxFileUpload(docNo) {  
          
                if (window.File && window.FileReader && window.FileList && window.Blob)
                {
                    var fsize = $('#file')[0].files[0].size;
                    
                    if(fsize>1048576) {
                        $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
                        return;
                    }
                }else{
                     $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    return;
                }
            
          $.ajaxFileUpload  
          (  
              {  
                  url:'fileAttachAction.action?formCode=VPUE&doc_no='+docNo+'&descpt=Excel Import' ,
                  secureuri:false,  
                  fileElementId:'file',   
                  dataType: 'json', 
                  success: function (data, status)   
                  {  
                     
                     if(status=='success'){
                         saveExcelDataData(docNo);
                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                      }
                     
                      if(typeof(data.error) != 'undefined')  
                      {  
                          if(data.error != '')  
                          {  
                              $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                          }else  
                          {  
                              $.messager.show({title:'Message',msg: data.message,showType:'show',
                                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                          }); 
                          }  
                      }  
                  },  
                  error: function (data, status, e){  
                      $.messager.alert('Message',e);
                  }  
              }  
          );  
          return false;  
      }
    
        function funeditdeal()
        {
             if(document.getElementById("editdeal").value.trim()=="Edit")
                 {
                $("#dealno").prop("disabled", false);
                $("#dealno").prop("readonly", false);
                document.getElementById("editdeal").value="Save";
                 }
            
             else if(document.getElementById("editdeal").value.trim()=="Save" && document.getElementById("errormsg").innerText=="")
                 {
                 var dealno=document.getElementById("dealno").value;
            
             var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200)
                    {
                        var items=x.responseText.trim();
                        
                        if(items==1){
                            
                        $.messager.alert('Message', ' Deal No Successfully Updated.');
                        document.getElementById("editdeal").value="Edit";
                        $("#dealno").prop("disabled", true);
                        $("#dealno").prop("readonly", true);
                            }
                        
                  }
                }
                    
            x.open("GET","updateDealNo.jsp?dealno="+dealno+"&masterdoc="+document.getElementById("masterdoc_no").value,true);
            x.send();
                }
             else
                 {
                 }
            
        }
        
</script>
</head>
<body onload="setValues();getNonTaxableEntity();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmpurchase" action="savePurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

   

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Date</td>
                <td width="15%">
                    <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
                    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
                </td>
                
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="15%">
                    <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' tabindex="-1"/>
                </td>
                
                <td class="lbl-right" width="10%">Type</td>
                <td width="15%">
                    <select id="vehtype" name="vehtype" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="VPO">VPO</option>
                    </select>
                </td>
                
                <td class="lbl-right" width="10%">Ref No</td>
                <td width="15%">
                    <div class="input-search-container">
                        <input type="text" id="vehrefno" name="vehrefno" placeholder="Press F3" value='<s:property value="vehrefno"/>' onfocus="funcheckaccinvendor();" onkeydown="getrefDetails(event)"/>
                        <svg class="magnifier-icon" onclick="if($('#mode').val()=='A') {$('#refnosearchwindow').jqxWindow('open'); refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById('headacccode').value);}" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Vendor</td>
                <td colspan="3">
                    <div style="display: flex; gap: 8px;">
                        <div class="input-search-container" style="width: 100px;">
                            <input type="text" id="accid" name="accid" placeholder="F3" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)"/>
                            <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E') {$('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsSearch.jsp?');}" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="vehpuraccname" name="vehpuraccname" style="flex:1;" value='<s:property value="vehpuraccname"/>'/>
                    </div>
                    <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/>
                </td>
                
                <td class="lbl-right">Exp. Delivery</td>
                <td>
                    <div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
                    <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/>
                </td>
                
                <td colspan="2" align="center">
                    <input type="button" class="myButton" name="updatefleet" id="updatefleet" onclick="funupdatefleet()" value="Fleet Update">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Description</td>
                <td colspan="7">
                    <input type="text" id="vehdesc" name="vehdesc" value='<s:property value="vehdesc"/>'/>
                </td>
            </tr>
        </table>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Order Details</span>
        
        <div class="grid-container">
            <div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div>
        </div>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Finance Details</span>
        
        <input type="hidden" id="hidtaxamount" name="hidtaxamount" value='<s:property value="hidtaxamount"/>' />
        <input type="hidden" id="hidtotalamt" name="hidtotalamt" value='<s:property value="hidtotalamt"/>' />
        <input type="hidden" id="priamounts" name="priamounts" value='<s:property value="priamounts"/>' />
        <input type="hidden" id="txttaxpercentage" value='<s:property value="txttaxpercentage"/>' />

        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="finance">
            <tr id="taxtable" style="display:none;">
                <td colspan="4"></td>
                <td class="lbl-right" id="taxlabel" width="10%">Tax Amt</td>
                <td id="taxbox" width="15%">
                    <input type="text" id="taxamount" name="taxamount" style="text-align: right;" value='<s:property value="taxamount"/>' readonly>
                </td>
                <td class="lbl-right" width="10%">Net Total</td>
                <td width="15%">
                    <input type="text" id="nettotal" name="nettotal" style="text-align: right;" value='<s:property value="nettotal"/>' readonly>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right" width="10%">Total Amt</td>
                <td width="15%">
                    <input type="text" id="totalamt" name="totalamt" style="text-align: right;" value='<s:property value="totalamt"/>' readonly>
                </td>
                <td class="lbl-right" width="10%">Down Pymt</td>
                <td width="15%">
                    <input type="text" id="downpayment" name="downpayment" style="text-align: right;" onblur="funRoundAmt(this.value,this.id);calculateval();" value='<s:property value="downpayment"/>'>
                </td>
                <td class="lbl-right" width="10%">Loan Amt</td>
                <td width="15%">
                    <input type="text" id="loanamount" name="loanamount" style="text-align: right;" value='<s:property value="loanamount"/>' readonly tabindex="-1">
                </td>
                <td colspan="2"></td>
            </tr>

            <tr>
                <td class="lbl-right">Start Date</td>
                <td>
                    <div id="jqxStartDate" name="jqxStartDate" value='<s:property value="jqxStartDate"/>'></div>
                    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                </td>
                <td class="lbl-right">% Interest</td>
                <td>
                    <input type="text" id="perinterest" name="perinterest" onkeypress="return isNumber(event)" value='<s:property value="perinterest"/>'>
                </td>
                <td class="lbl-right">Calc Method</td>
                <td>
                    <select id="calcumethod" name="calcumethod">
                        <option value="1">Flat Rate</option>
                        <option value="2">Diminishing rate</option>
                    </select>
                </td>
                <td class="lbl-right">Inst. Nos</td>
                <td>
                    <input type="text" id="instnos" name="instnos" onkeypress="return isNumber(event)" value='<s:property value="instnos"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Financier</td>
                <td colspan="3">
                    <div style="display: flex; gap: 8px;">
                        <div class="input-search-container" style="width: 100px;">
                            <input type="text" id="financeaccid" name="financeaccid" placeholder="F3" value='<s:property value="financeaccid"/>' onkeydown="getfinacc(event);"/>
                            <svg class="magnifier-icon" onclick="$('#accountSearchwindow').jqxWindow('open'); commenSearchContent('finaccountSearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="financeaccname" name="financeaccname" style="flex:1;" readonly value='<s:property value="financeaccname"/>'/>
                    </div>
                </td>
                <td class="lbl-right">Bank A/C</td>
                <td colspan="3">
                    <div style="display: flex; gap: 8px;">
                        <div class="input-search-container" style="width: 100px;">
                            <input type="text" id="bankaccid" name="bankaccid" placeholder="F3" value='<s:property value="bankaccid"/>' onkeydown="getbankacc(event);"/>
                            <svg class="magnifier-icon" onclick="$('#accountSearchwindow').jqxWindow('open'); commenSearchContent('bankaccountsearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="bankaccname" name="bankaccname" style="flex:1;" readonly value='<s:property value="bankaccname"/>'/>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Interest A/C</td>
                <td colspan="3">
                    <div style="display: flex; gap: 8px;">
                        <div class="input-search-container" style="width: 100px;">
                            <input type="text" id="interestaccid" name="interestaccid" placeholder="F3" value='<s:property value="interestaccid"/>' onkeydown="getInterestacc(event);"/>
                            <svg class="magnifier-icon" onclick="$('#accountSearchwindow').jqxWindow('open'); commenSearchContent('inetestaccsearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="intaccname" name="intaccname" style="flex:1;" readonly value='<s:property value="intaccname"/>'/>
                    </div>
                </td>
                <td class="lbl-right">Loan A/C</td>
                <td colspan="3">
                    <div style="display: flex; gap: 8px;">
                        <div class="input-search-container" style="width: 100px;">
                            <input type="text" id="loanaccid" name="loanaccid" placeholder="F3" value='<s:property value="loanaccid"/>' onkeydown="getloanacc(event);"/>
                            <svg class="magnifier-icon" onclick="$('#accountSearchwindow').jqxWindow('open'); commenSearchContent('loanaccount.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="loanaccname" name="loanaccname" style="flex:1;" readonly value='<s:property value="loanaccname"/>'/>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Security Chq</td>
                <td>
                    <input type="text" id="secchaqueno" name="secchaqueno" value='<s:property value="secchaqueno"/>'>
                </td>
                <td class="lbl-right">Chq Amount</td>
                <td>
                    <input type="text" id="chqamount" name="chqamount" style="text-align: right;" onkeypress="return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="chqamount"/>'>
                </td>
                <td class="lbl-right">Upto Date</td>
                <td>
                    <div id="uptoDate" name="uptoDate" value='<s:property value="uptoDate"/>'></div>
                    <input type="hidden" id="hiduptoDate" name="hiduptoDate" value='<s:property value="hiduptoDate"/>'/>
                </td>
                <td class="lbl-right">Deal No</td>
                <td>
                    <input type="text" id="dealno" name="dealno" onblur="funchkunique()" value='<s:property value="dealno"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Chq Name</td>
                <td colspan="3">
                    <input type="text" id="nameincheque" name="nameincheque" value='<s:property value="nameincheque"/>'>
                </td>
                <td class="lbl-right">Pymt Method</td>
                <td>
                    <select id="paymentmethod" name="paymentmethod" onchange="paymtchg()">
                        <option value="">--Select--</option>
                        <option value="1">Cheque</option> 
                        <option value="2">Direct Debit</option> 
                    </select>
                </td>
                <td colspan="2"></td>
            </tr>

            <tr>
                <td class="lbl-right">Description</td>
                <td colspan="7">
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'>
                </td>
            </tr>
            
            <tr>
                <td colspan="8" align="center" style="padding-top: 15px;">
                    <input type="button" class="myButton" id="calculatebtn" value="Calculate" onclick="calculate();">
                    <input type="button" class="myButton" id="updatebtn" value="Edit" onclick="funUpdate();" style="margin: 0 15px;">
                    
                    <div style="display: inline-block; vertical-align: middle;">
                        <input type="file" id="file" name="file" style="font-size: 11px; padding: 0; border:none; background:transparent; width:160px;">
                        <svg class="magnifier-icon" onclick="return upload();" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#28a745" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="position: relative; right: auto; top: auto; transform: none; vertical-align: middle;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Distribution</span>
        <div class="grid-container">
            <div id="detailsdiv"><jsp:include page="distributionGrid.jsp"></jsp:include></div>
        </div>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Posting</span>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 10px;">
            <tr>
                <td class="lbl-right" width="10%">Inv No</td>
                <td width="15%">
                    <input type="text" id="invno" name="invno" value='<s:property value="invno"/>'/>
                </td>
                
                <td class="lbl-right" width="15%">Purchase Date</td>
                <td width="15%">
                    <div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
                    <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
                </td>
                
                <td align="right">
                    <svg onclick="funpostcalcu();" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#007bff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer; vertical-align: middle; margin-right: 15px;"><rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect><line x1="8" y1="6" x2="16" y2="6"></line><line x1="16" y1="14" x2="16" y2="14.01"></line><line x1="12" y1="14" x2="12" y2="14.01"></line><line x1="8" y1="14" x2="8" y2="14.01"></line><line x1="16" y1="18" x2="16" y2="18.01"></line><line x1="12" y1="18" x2="12" y2="18.01"></line><line x1="8" y1="18" x2="8" y2="18.01"></line></svg>
                    <input type="button" class="myButton" id="updateposting" value="Posting" onclick="funupdateposting()">
                    <input type="button" class="myButton" id="editss" value="Edit" onclick="funeditpost()" style="margin-left: 10px;">
                </td>
            </tr>
        </table>
        
        <div class="grid-container" style="height: 180px;">
            <div id="postingdiv"> <jsp:include page="postinggrid.jsp"></jsp:include></div>
        </div>
    </div>

    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>    
    <input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
    <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
    <input type="hidden" id="pricetottal" name="pricetottal" value='<s:property value="pricetottal"/>'/>
    <input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
    <input type="hidden" id="hidtaxamount" name="hidtaxamount" value='<s:property value="hidtaxamount"/>'/>
    <input type="hidden" id="hidtotalamt" name="hidtotalamt" value='<s:property value="hidtotalamt"/>'/>
    <input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght" value='<s:property value="vehpurchasegridlenght"/>'/>
    <input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>
    <input type="hidden" id="dimqty" name="dimqty" value='<s:property value="dimqty"/>'/>
    <input type="hidden" id="fleetupdateval" name="fleetupdateval" value='<s:property value="fleetupdateval"/>'/> 
    <input type="hidden" id="detval" name="detval" value='<s:property value="detval"/>'/>
    <input type="hidden" id="calcuval" name="calcuval" value='<s:property value="calcuval"/>'/>
    <input type="hidden" id="paymentval" name="paymentval" value='<s:property value="paymentval"/>'/> 
    <input type="hidden" id="distributionlenght" name="distributionlenght" value='<s:property value="distributionlenght"/>'/>
    <input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>
    <input type="hidden" id="totalamount" name="totalamount" value='<s:property value="totalamount"/>'/>
    <input type="hidden" id="validatepostcalu" name="validatepostcalu" value='<s:property value="validatepostcalu"/>'/>
    <input type="hidden" id="bankcurrency" name="bankcurrency" value='<s:property value="bankcurrency"/>'/>
    <input type="hidden" id="bankrate" name="bankrate" value='<s:property value="bankrate"/>'/>
    <input type="hidden" id="intercurrency" name="intercurrency" value='<s:property value="intercurrency"/>'/>
    <input type="hidden" id="interrate" name="interrate" value='<s:property value="interrate"/>'/>
    <input type="hidden" id="loancurrecy" name="loancurrecy" value='<s:property value="loancurrecy"/>'/>
    <input type="hidden" id="loanrate" name="loanrate" value='<s:property value="loanrate"/>'/>
    <input type="hidden" id="vendorcurr" name="vendorcurr" value='<s:property value="vendorcurr"/>'/>
    <input type="hidden" id="vendorrate" name="vendorrate" value='<s:property value="vendorrate"/>'/>
    <input type="hidden" id="finaccdocno" name="finaccdocno" value='<s:property value="finaccdocno"/>'/>
    <input type="hidden" id="banckaccdocno" name="banckaccdocno" value='<s:property value="banckaccdocno"/>'/>  
    <input type="hidden" id="interestaccdocno" name="interestaccdocno" value='<s:property value="interestaccdocno"/>'/>
    <input type="hidden" id="loanaccdocno" name="loanaccdocno" value='<s:property value="loanaccdocno"/>'/>
    <input type="hidden" id="clstatus" name="clstatus" value='<s:property value="clstatus"/>'/>
    <input type="hidden" id="masterstatus" name="masterstatus" value='<s:property value="masterstatus"/>'/>
    <input type="hidden" id="tranno" name="tranno" value='<s:property value="tranno"/>'/>
    <input type="hidden" id="priamounts" name="priamounts" value='<s:property value="priamounts"/>'/>
    <input type="hidden" id="dealver" name="dealver" value="0"/>
    <input type="hidden" id="restructure" name="restructure" value='<s:property value="restructure"/>'/>
    <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
    <input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>
    <input type="hidden" id="txtexcelvalidation" name="txtexcelvalidation" value="0"/>
</form>

<div id="colorsearchwndow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="modelsearchwndow"><div></div></div>
<div id="brandsearchwndow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="refnosearchwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="slnosearchwindow"><div></div></div>

</div>
</body>
</html>