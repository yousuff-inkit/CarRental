<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<jsp:include page="tab.css"/>
<%@ include file="tab.jsp" %> 

<script type="text/javascript">
      $(document).ready(function () {
        getSalesmanConfigs()
        /* Date - 24px height to match new design */
        $("#jqxClientDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#jqxContractDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy" , value:null, theme: 'energyblue'});
        $("#dateOfJoining").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy" , value:null, theme: 'energyblue'});
        
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
        
        /* Searching Window */
         $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#nationalityWindow').jqxWindow('close');
        
         $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#stateWindow').jqxWindow('close');
        
        getGroup();getSalesman();getCategory();getNationality();getSalutation();getContractDate();getContract();getIDPDetails();getCRMDriverDetailsVerify();getNonTaxableEntity();getTax();getSeparateServiceChargeAllowed();
        getConfigs();refdetConfig();getclientSrvChrges();
        
        $('#chksalikauhpercent,#chksalikdxbpercent,#chktrafficpercent,#chkparkingpercent').on('click',function(){
            var target=$(this).attr('id');
            if($(this).is(':checked')){
                $('#hid'+target).val('1');
            }
            else{
                $('#hid'+target).val('0');
            }
        });
      }); 
    
      function getclientSrvChrges(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    if(parseInt(items)>0){
                    $('#hidclientsrvchrges').val(parseInt(items));
                }
            }else {
                $('#hidclientsrvchrges').val(0);
            }
            }
            x.open("GET", "getservicechrgesConfig.jsp", false);
            x.send();
     }
      
      function refdetConfig(){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState == 4 && x.status == 200) {
                items = x.responseText;
                items = items.split('####');
                if (items[0]==1) 
                {
                     $("#jqxReferenceDetails2").show();
                     $("#jqxReferenceDetails1").hide();
                     $("#refid").text("ID Details");
                  
                    }else{
                        $("#jqxReferenceDetails1").show();
                        $("#jqxReferenceDetails2").hide();
                        $("#refid").text("Reference Details");
                    }
            }
        }
        x.open("GET", "refdetConfig.jsp",true);   
        x.send();
    }
    
      function getConfigs(){
        $.get('getConfigs.jsp',function(data){
            data=JSON.parse(data);
            var htmldata='';
               if(data.InvQuarterly=="1"){
                   htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
                   $('#cmbinvoicing_method').append($.parseHTML(htmldata));
                   if($('#hidcmbinvoicing_method').val()!="")
                   {
                       $('#cmbinvoicing_method').val($('#hidcmbinvoicing_method').val());
                   } 
               }
        });
    }
      function hidedata(){
        var contract=$('#txtforcontractdiv').val();
        if(parseInt(contract)==1){
               $("#contractDiv").prop("hidden", false);
               $("#sponsorDiv").attr("hidden", true);
            }
            else{
                $("#contractDiv").prop("hidden", true);
                $("#sponsorDiv").attr("hidden", false);
            }
        }
      
      function showSingleOrSeparateServiceCharges(){
            var separateservicechargeallowed=$('#separateservicechargeallowed').val();
            
            if(parseInt(separateservicechargeallowed)==1){
                   $("#singleServiceChargeDiv").prop("hidden", true);
                   $("#separateServiceChargeDiv").attr("hidden", false);
            }
            else{
                $("#singleServiceChargeDiv").prop("hidden", false);
                $("#separateServiceChargeDiv").attr("hidden", true);
            }
            if(parseInt(separateservicechargeallowed)==2){
                $('.row-salikpercent').show();
            }
            else{
                $('.row-salikpercent').hide();
            }
      }
      
      function getContract(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#txtforcontractdiv').val(items);
                    hidedata();
            }
            }
            x.open("GET", "getContract.jsp", true);
            x.send();
     }
    
    function getIDPDetails(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#idpdetailsallowed').val(items);
            }
            }
            x.open("GET", "getIDPDetailsAllowed.jsp", true);
            x.send();
    }
    
    function getCRMDriverDetailsVerify(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#driverdetailsverifyallowed').val(items);
        }
        }
        x.open("GET", "getCRMDriverDetailsVerifyAllowed.jsp", true);
        x.send();
    }
    
    function getSeparateServiceChargeAllowed(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#separateservicechargeallowed').val(items);
                showSingleOrSeparateServiceCharges();
                
                if(parseInt($('#separateservicechargeallowed').val())==1 && $('#mode').val()=='A'){
                     $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
                }
        }
        }
        x.open("GET", "getSeparateServiceChargeAllowed.jsp", true);
        x.send();
    }
    
    function getCategoryWiseEditEnable(a){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#txtcategorywiseedit').val(items);
                
              if(parseInt($('#txtcategorywiseedit').val())==1){
                $('#btnEdit').attr('disabled', true );
              }
        }
        }
        x.open("GET", "getCategoryWiseEditEnable.jsp?category="+a, true);
        x.send();
    }
      
      function getSalutation() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var salutnItems = items[0].split(",");
                    var salutnIdItems = items[1].split(",");
                    var optionssalutn = '<option value="">--Select--</option>';
                    for (var i = 0; i < salutnItems.length; i++) {
                        optionssalutn += '<option value="' + salutnItems[i] + '">'
                                + salutnItems[i] + '</option>';
                    }
                    $("select#cmbsalutation").html(optionssalutn);
                    if ($('#hidcmbsalutation').val() != null) {
                        $('#cmbsalutation').val($('#hidcmbsalutation').val());
                    }
                } else {
                }
            }
            x.open("GET", "getSalutation.jsp", true);
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
                $("select#cmbgroup1").html(optionsgroup);
                if ($('#hidcmbgroup1').val() != null) {
                    $('#cmbgroup1').val($('#hidcmbgroup1').val());
                }
            } else {
            }
        }
        x.open("GET", "getGroup.jsp", true);
        x.send();
    } 
    
    function getCategoryAccountGroup(a) {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                $('#hidcmbgroup1').val(items);
                
                if ($('#hidcmbgroup1').val() != null || $('#hidcmbgroup1').val() != "") {
                    $('#cmbgroup1').val($('#hidcmbgroup1').val());
                }
            } else {
            }
        }
        x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
        x.send();
    } 
     
      function getSalesman() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var salesagentItems = items[0].split(",");
                    var salesagentIdItems = items[1].split(",");
                    var linkItems = items[2].split(",");
                    
                    var optionssalesagent;
                    for (var i = 0; i < salesagentItems.length; i++) {
                        if(parseInt(linkItems[i])==1) {
                            optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                                    + salesagentItems[i] + '</option>';
                        } else {
                            if(i==0) {
                                optionssalesagent = '<option value="">--Select--</option>';
                                optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                                + salesagentItems[i] + '</option>';
                            } else {
                                optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                                + salesagentItems[i] + '</option>';
                            }
                        }
                    }
                    $("select#cmbsalesman").html(optionssalesagent);
                    if ($('#hidcmbsalesman').val() != null) {
                        $('#cmbsalesman').val($('#hidcmbsalesman').val());
                    }
                } else {
                }
            }
            x.open("GET", "getSalesagent.jsp", true);
            x.send();
        }
      
      function getCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var categoryItems = items[0].split(",");
                var categoryIdItems = items[1].split(",");
                var optionscategory = '<option value="">--Select--</option>';
                for (var i = 0; i < categoryItems.length; i++) {
                    optionscategory += '<option value="' + categoryIdItems[i] + '">'
                            + categoryItems[i] + '</option>';
                }
                $("select#cmbcategory").html(optionscategory);
                if ($('#hidcmbcategory').val() != null) {
                    $('#cmbcategory').val($('#hidcmbcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getCategory.jsp", true);
        x.send();
    }
      
      function getCurrencyIds(){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    items= x.responseText;
                    items=items.split('####');
                    var curidItems=items[0];
                    var curcodeItems=items[1];
                    var multiItems=items[2];
                    var optionscurr = '';
                    
                 if(curcodeItems.indexOf(",")>=0){
                        var currencyid=curidItems.split(",");
                        var currencycode=curcodeItems.split(",");
                        multiItems.split(",");
                       
                       for ( var i = 0; i < currencycode.length; i++) {
                           optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                        }
                      
                         $("select#cmbcurrency").html(optionscurr);
                         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                             $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                         } 
                         
                   }
            
                   else{
                       optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                       
                         $("select#cmbcurrency").html(optionscurr);
                       
                         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                             $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                         }
                      }
                }
             }
              x.open("GET", "getCurrencyId.jsp",true);
             x.send();
            
           }
     
      function getNationality() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var nationItems = items[0].split(",");
                    var nationIdItems = items[1].split(",");
                    var optionsnation = '<option value="">--Select--</option>';
                    for (var i = 0; i < nationItems.length; i++) {
                        optionsnation += '<option value="' + nationIdItems[i] + '">'
                                + nationItems[i] + '</option>';
                    }
                    $("select#cmbnationality").html(optionsnation);
                    if ($('#hidcmbnationality').val() != null) {
                        $('#cmbnationality').val($('#hidcmbnationality').val());
                    }
                } else {
                }
            }
            x.open("GET", "getNationality.jsp", true);
            x.send();
        } 
      
      function taxcheck() {
         if($('#cmbtax').val()=='1'){
             document.getElementById("chcknontaxableentity").checked=true;
             document.getElementById("hidchcknontaxableentity").value = 1;
         }
         else if($('#cmbtax').val()=='2'){
             document.getElementById("chcknontaxableentity").checked=false;
             document.getElementById("hidchcknontaxableentity").value = 0;
         }
         else{
             document.getElementById("chcknontaxableentity").checked=false;
             document.getElementById("hidchcknontaxableentity").value = 0;
         }
     }
      
      function getClientAlreadyExists(clientname,salutation,docno,mode){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)==1){
                         document.getElementById("errormsg").innerText="Client Already Exists.";
                         return 0;
                     } else {
                        
                        if(parseInt($('#driverdetailsverifyallowed').val())==1){
                             var driverdetails = new Array();
                             var rowsverify = $("#jqxDriver").jqxGrid('getrows');
                             for(var z=0 ; z < rowsverify.length ; z++){
                                var chkverify=rowsverify[z].name;
                                if(typeof(chkverify) != "undefined" && typeof(chkverify) != "NaN" && chkverify != ""){
                                    driverdetails.push(rowsverify[z].name+" ::"+rowsverify[z].mobno+" ::"+rowsverify[z].dlno+" ::"+rowsverify[z].dr_id);
                                }
                             }
                            getDriverDetailsVerification(driverdetails,docno,mode);
                        
                        } else {
                            var rows = $("#jqxDriver").jqxGrid('getrows');
                            var length=0;
                             for(var i=0 ; i < rows.length ; i++){
                                var chk=rows[i].name;
                                if(typeof(chk) != "undefined"){
                                    length=length+1;
                                    newTextBox = $(document.createElement("input"))
                                    .attr("type", "dil")
                                    .attr("id", "test"+i)
                                    .attr("name", "test"+i)
                                    .attr("hidden", "true");
                            
                            newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
                            newTextBox.appendTo('form');
                             }
                            }
                         $('#gridlength').val(length);
                        
                        /* new ref det grid*/
                         var rows = $("#refdetsearch").jqxGrid('getrows');
                         var referencelength1=0;
                         for(var i=0,j=0 ; i < rows.length ; i++){
                            var  chk=rows[i].validupto;
                            var  chks=rows[i].numbr;
                            if((typeof(chk) != "undefined" && chk!==null && chk!==0 && chk!=="" && chk!=="undefined") || (typeof(chks) != "undefined" && chks!==null && chks!==0 && chks!=="" && chks!=="undefined")){
                                referencelength1=referencelength1+1;
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "dil")
                                .attr("id", "iddetail"+j)
                                .attr("name", "iddetail"+j)
                                .attr("hidden", "true");
                            var validupto=$('#refdetsearch').jqxGrid('getcelltext',i,'validupto');
                            
                            newTextBox.val(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
                            newTextBox.appendTo('form');
                            j++;
                            }
                          }
                          $('#referencelength1').val(referencelength1);
                          
                         var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
                         var referencelength=0;
                         for(var i=0 ; i < rows.length ; i++){
                                var chkd=rows[i].cperson;
                                if(typeof(chkd) != "undefined"){
                                referencelength=referencelength+1;
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "dil")
                                .attr("id", "txtreference"+i)
                                .attr("name", "txtreference"+i)
                                .attr("hidden", "true");
                        
                            newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
                            newTextBox.appendTo('form');
                            }
                          }
                          $('#referencelength').val(referencelength);
                          
                          var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
                             var creditcardlength=0;
                                 for(var i=0 ; i < rows.length ; i++){
                                    var chkng=rows[i].type;
                                    if(typeof(chkng) != "undefined"){
                                        creditcardlength=creditcardlength+1;
                                        newTextBox = $(document.createElement("input"))
                                        .attr("type", "dil")
                                        .attr("id", "txtcard"+i)
                                        .attr("name", "txtcard"+i)
                                        .attr("hidden", "true");
                                
                                newTextBox.val(rows[i].type+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+":: "+rows[i].defaultcard+":: "+rows[i].remarks);
                                newTextBox.appendTo('form');
                                 }
                                }
                             $('#creditcardlength').val(creditcardlength);
                            
                        if(parseInt($('#separateservicechargeallowed').val())==1){
                            var rows = $("#separateServiceChargeGridId").jqxGrid('getrows');
                             var separateservicechargelength=0;
                                 for(var i=0 ; i < rows.length ; i++){
                                    var chked=rows[i].doc_no;
                                    if(typeof(chked) != "undefined"){
                                        separateservicechargelength=separateservicechargelength+1;
                                        newTextBox = $(document.createElement("input"))
                                        .attr("type", "dil")
                                        .attr("id", "txtseparateservicecharge"+i)
                                        .attr("name", "txtseparateservicecharge"+i)
                                        .attr("hidden", "true");
                                
                                newTextBox.val(rows[i].doc_no+" :: "+rows[i].salik+" :: "+rows[i].traffic);
                                newTextBox.appendTo('form');
                                 }
                                }
                             $('#separateservicechargelength').val(separateservicechargelength);
                        }
                            $("#cmbsalesman").attr("disabled",false);
                            $("#frmClientMaster").submit(); 
                        }
                     }
            }
        }
        x.open("GET", "getClientAlreadyExists.jsp?clientname="+clientname+"&salutation="+salutation+"&docno="+docno+"&mode="+mode, true);
        x.send();
   }
      
    function getDriverDetailsVerification(driverdetails,docno,mode) {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');
                
                    if(parseInt(items[0])==1){
                         document.getElementById("errormsg").innerText="Driver Details is Mandatory.";
                         return 0;
                     } else if(parseInt(items[0])==2){
                         document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Required.";
                         return 0;
                     } else if(parseInt(items[0])==3){
                         document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Already Exists.";
                         return 0;
                     } else if(parseInt(items[0])==4){
                         document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Required.";
                         return 0;
                     } else if(parseInt(items[0])==5){
                         document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Already Exists.";
                         return 0;
                     } else {
                        var rows = $("#jqxDriver").jqxGrid('getrows');
                        var length=0;
                         for(var i=0 ; i < rows.length ; i++){
                            var chk=rows[i].name;
                            if(typeof(chk) != "undefined"){
                                length=length+1;
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "dil")
                                .attr("id", "test"+i)
                                .attr("name", "test"+i)
                                .attr("hidden", "true");
                        
                        newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
                        newTextBox.appendTo('form');
                         }
                        }
                     $('#gridlength').val(length);
                    
                    /* new ref det grid*/
                     var rows = $("#refdetsearch").jqxGrid('getrows');
                     var referencelength1=0;
                     for(var i=0,j=0 ; i < rows.length ; i++){
                        var  chk=rows[i].validupto;
                        var  chks=rows[i].numbr;
                        if((typeof(chk) != "undefined" && chk!==null && chk!==0 && chk!=="" && chk!=="undefined") || (typeof(chks) != "undefined" && chks!==null && chks!==0 && chks!=="" && chks!=="undefined")){
                            referencelength1=referencelength1+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "iddetail"+j)
                            .attr("name", "iddetail"+j)
                            .attr("hidden", "true");
                        var validupto=$('#refdetsearch').jqxGrid('getcelltext',i,'validupto');
                        
                        newTextBox.val(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
                        newTextBox.appendTo('form');
                        j++;
                        }
                      }
                      $('#referencelength1').val(referencelength1);
                      
                     var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
                     var referencelength=0;
                     for(var i=0 ; i < rows.length ; i++){
                            var chkd=rows[i].cperson;
                            if(typeof(chkd) != "undefined"){
                            referencelength=referencelength+1;
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "txtreference"+i)
                            .attr("name", "txtreference"+i)
                            .attr("hidden", "true");
                    
                        newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
                        newTextBox.appendTo('form');
                        }
                      }
                      $('#referencelength').val(referencelength);
                      
                      var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
                         var creditcardlength=0;
                             for(var i=0 ; i < rows.length ; i++){
                                var chkng=rows[i].type;
                                if(typeof(chkng) != "undefined"){
                                    creditcardlength=creditcardlength+1;
                                    newTextBox = $(document.createElement("input"))
                                    .attr("type", "dil")
                                    .attr("id", "txtcard"+i)
                                    .attr("name", "txtcard"+i)
                                    .attr("hidden", "true");
                            
                            newTextBox.val(rows[i].type+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+":: "+rows[i].defaultcard+":: "+rows[i].remarks);
                            newTextBox.appendTo('form');
                             }
                            }
                         $('#creditcardlength').val(creditcardlength);
                        
                    if(parseInt($('#separateservicechargeallowed').val())==1){
                        var rows = $("#separateServiceChargeGridId").jqxGrid('getrows');
                         var separateservicechargelength=0;
                             for(var i=0 ; i < rows.length ; i++){
                                var chked=rows[i].doc_no;
                                if(typeof(chked) != "undefined"){
                                    separateservicechargelength=separateservicechargelength+1;
                                    newTextBox = $(document.createElement("input"))
                                    .attr("type", "dil")
                                    .attr("id", "txtseparateservicecharge"+i)
                                    .attr("name", "txtseparateservicecharge"+i)
                                    .attr("hidden", "true");
                            
                            newTextBox.val(rows[i].doc_no+" :: "+rows[i].salik+" :: "+rows[i].traffic);
                            newTextBox.appendTo('form');
                             }
                            }
                         $('#separateservicechargelength').val(separateservicechargelength);
                    }
                    
                    $('#cmbgroup1').attr('disabled', false);
                        $("#frmClientMaster").submit(); 
                     }
            }
        }
        x.open("GET", "getDriverDetailsVerification.jsp?driverdetails="+driverdetails+"&docno="+docno+"&mode="+mode, true);
        x.send();
     }
    
     function getMobileNoAlreadyExists(mobileno,docno,mode){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)==1){
                         $.messager.alert('Message','Personal Mobile No. Already Exists.','warning');
                         return 0;
                     }
            }
        }
        x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
        x.send();
    }
    
    function getDrivingLicenceNoAlreadyExists(licenceno,docno,mode){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)==1){
                        $.messager.alert('Message','Licence# Already Exists.','warning');
                         return 0;
                     }                  
            }
        }
        x.open("GET", "getDrivingLicenceNoAlreadyExists.jsp?licenceno="+licenceno+"&docno="+docno+"&mode="+mode, true);
        x.send();
    }
    
    function getVisaNoAlreadyExists(visano,docno,mode){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)==1){
                        $.messager.alert('Message','ID# Already Exists.','warning');
                         return 0;
                     }
            }
        }
        x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
        x.send();
    }
      
    function getPassportNoAlreadyExists(passportno,docno,mode){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)==1){
                        $.messager.alert('Message','Passport# Already Exists.','warning');
                         return 0;
                     }
            }
        }
        x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
        x.send();
    }

      function getContractDate(){
        if ($("#mode").val() == "A") {
            var curdate= $('#jqxClientDate').jqxDateTimeInput('getDate');
            var oneyeardate=new Date(new Date(curdate).setMonth(curdate.getMonth()+36));
            var oneyearafterdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
            $('#jqxContractDate ').jqxDateTimeInput('setDate', new Date(oneyearafterdate));
        }
      }
      
      function getDefaultService() {
          var hidclientsrvchrges=$('#hidclientsrvchrges').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var serviceItems = items[0].split(",");
                    var serviceRateItems = items[1].split(",");
                     $('#txtsalik').val("0");
                    $('#txtsalikauh').val("0");
                    $('#txttraffic').val("0");
                    $('#txtparking').val("0"); 
                    for (var i = 0; i < serviceItems.length; i++) {
                        if(serviceItems[i]=='saliksrv'){
                            if(hidclientsrvchrges==1 || hidclientsrvchrges==2 || hidclientsrvchrges==3 ){
                            $('#txtsalik').val(0);
                            document.getElementById("chksalikdxbpercent").checked=true;
                            document.getElementById("hidchksalikdxbpercent").value = 1;
                            }else{
                            $('#txtsalik').val(serviceRateItems[i]);    
                            }
                        }// saliksrv end
                        else if(serviceItems[i]=='trafficsrv'){
                            $('#txttraffic').val(serviceRateItems[i]);
                        }//trafficsrv end
                        else if(serviceItems[i]=='saliksrvAUH'){
                            $('#txtsalikauh').val(serviceRateItems[i]);
                        } //saliksrvAUH end
                        else if(serviceItems[i]=='InvSalikParking'){
                            if(hidclientsrvchrges==2  || hidclientsrvchrges==3){
                                $('#txtparking').val(0);
                                document.getElementById("chkparkingpercent").checked=true;
                                $('#parkingpercent').val(parseInt(serviceRateItems[i]));
                                 if(document.getElementById("chkparkingpercent").checked){
                                        document.getElementById("hidchkparkingpercent").value = 1;
                                    $('#parkingpercent').val(parseInt(serviceRateItems[i]));
                                }else if (!document.getElementById("chkparkingpercent").checked) {
                                    document.getElementById("hidchkparkingpercent").value = 0;
                                    $('#parkingpercent').val("0"); 
                                }
                            }else{
                            $('#txtparking').val(serviceRateItems[i]);
                             if(document.getElementById("chkparkingpercent").checked){
                                 document.getElementById("hidchkparkingpercent").value = 1;
                                 $('#parkingpercent').val(parseInt(serviceRateItems[i]));
                             }else if (!document.getElementById("chkparkingpercent").checked) {
                                 document.getElementById("hidchkparkingpercent").value = 0;
                                 $('#parkingpercent').val("0"); 
                             }
                            }
                        }  //InvSalikParking end
                        else if(serviceItems[i]=='clientSrvChrges'){
                            if(hidclientsrvchrges==1 || hidclientsrvchrges==2  || hidclientsrvchrges==3){
                            document.getElementById("chksalikdxbpercent").checked=true;
                            $('#salikpercent').val(parseInt(serviceRateItems[i]));
                             if(document.getElementById("chksalikdxbpercent").checked){
                                 document.getElementById("hidchksalikdxbpercent").value = 1;
                                 $('#salikpercent').val(parseInt(serviceRateItems[i]));
                             }else if (!document.getElementById("chksalikdxbpercent").checked) {
                                 document.getElementById("hidchksalikdxbpercent").value = 0;
                                 $('#salikpercent').val("0"); 
                             }
                        }
                            if(hidclientsrvchrges==3){
                                document.getElementById("chktrafficpercent").checked=true;
                                 if(document.getElementById("chktrafficpercent").checked){
                                        document.getElementById("hidchktrafficpercent").value = 1 ;
                                        $('#trafficpercent').val(parseInt("10"));
                                 }else if (!document.getElementById("chktrafficpercent").checked) {
                                        document.getElementById("hidchktrafficpercent").value = 0 ;
                                        $('#trafficpercent').val("0"); 
                                 }
                            }
                      }//clientSrvChrges end
                    }// loop end
                } else {
                }
            }
            x.open("GET", "getDefaultServiceCharge.jsp", true);
            x.send();
        }
        
      function getDefaultInvoicingMethod(){
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        $('#cmbinvoicing_method').val(items);
                }
                }
                x.open("GET", "getDefaultInvoicingMethod.jsp", true);
                x.send();
        }
      
      function getTax() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var taxItems = items[0].split(",");
                    var taxIdItems = items[1].split(",");
                    var optionstax ='<option value="">--Select--</option>';
                    
                    for (var i = 0; i < taxItems.length; i++) {
                        optionstax += '<option value="' + taxIdItems[i] + '">'
                                + taxItems[i] + '</option>';
                    }
                    $("select#cmbtax").html(optionstax);
                    if ($('#hidcmbtax').val() != null) {
                        $('#cmbtax').val($('#hidcmbtax').val());
                    }
                } else {
                }
            }
            x.open("GET", "getTax.jsp", true);
            x.send();
        }
      
      function getNonTaxableEntity(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(parseInt(items)==1) {
                        document.getElementById("lblnontaxableentity").style.display = 'none';
                        $('#chcknontaxableentity').attr('hidden', false);
                        document.getElementById("lbltaxableentity").style.display = 'inline-block';
                        $('#cmbtax').attr('hidden', false);
                        document.getElementById("lbltrnnoentity").style.display = 'inline-block';
                        $('#txtregisteredtrnno').attr('hidden', false);
                        if($('#mode').val()=='A') {
                            $('#hidchcknontaxableentity').val(1);
                            document.getElementById("chcknontaxableentity").checked = true;
                        }
                    } else {
                        document.getElementById("lblnontaxableentity").style.display = 'none';
                        $('#chcknontaxableentity').attr('hidden', true);
                        document.getElementById("lbltaxableentity").style.display = 'none';
                        $('#cmbtax').attr('hidden', true);
                        document.getElementById("lbltrnnoentity").style.display = 'none';
                        $('#txtregisteredtrnno').attr('hidden', true);
                        if($('#mode').val()=='A') {
                            $('#hidchcknontaxableentity').val(0);
                            document.getElementById("chcknontaxableentity").checked = false;
                        }
                    }
            }
            }
            x.open("GET", "getNonTaxableEntity.jsp", true);
            x.send();
     }
      
      function nationalitySearchContent(url) {
            $('#nationalityWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#nationalityWindow').jqxWindow('setContent', data);
            $('#nationalityWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function stateSearchContent(url) {
            $('#stateWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#stateWindow').jqxWindow('setContent', data);
            $('#stateWindow').jqxWindow('bringToFront');
        }); 
        }
      
      $(function(){
            $('#frmClientMaster').validate({
                    rules: {
                    txtclient_name:"required",
                    cmbcategory:"required",
                     },
                     messages: {
                     txtclient_name:" *",
                     cmbcategory:" *",
                     }
            });});
      
     function defaultcheck(){
         if(document.getElementById("chckdefault").checked){
             document.getElementById("hidchckdefault").value = 1;
             $('#txtsalik').attr('readonly', true );
             $('#txtsalikauh').attr('readonly', true );
             $('#txttraffic').attr('readonly', true );
             getDefaultService();
         }
         else{
             document.getElementById("hidchckdefault").value = 0;
             $('#txtsalik').attr('readonly', false );
             $('#txtsalikauh').attr('readonly', false );
             $('#txttraffic').attr('readonly', false );
             $('#txtparking').attr('readonly', false );
         }
     }
     
    function funChangeSalikPercent(){
        if(document.getElementById("chksalikpercent").checked){
            document.getElementById("hidchksalikpercent").value = 1;
            $('#salikpercent').attr('readonly', false);
            $('#salikauhpercent').attr('readonly',false );
            $('#trafficpercent').attr('readonly',false );
            if($('#mode').val()=='A' ){
                $('#salikpercent,#salikauhpercent,#trafficpercent').val(0); 
            }
        }
        else{
            document.getElementById("hidchksalikpercent").value = 0;
            $('#salikpercent').attr('readonly', true);
            $('#salikauhpercent').attr('readonly',true);
            $('#trafficpercent').attr('readonly',true);
            if($('#mode').val()!='view' ){
                $('#salikpercent,#salikauhpercent,#trafficpercent').val(0); 
            } 
        }
     }
     function funChangeSalikDARBPercent(){
            if(document.getElementById("chksalikauhpercent").checked){
                document.getElementById("hidchksalikauhpercent").value = 1;
                $('#salikauhpercent').attr('readonly',false );
                if($('#mode').val()=='A' ){
                    $('#salikauhpercent').val(0);   
                }
            }
            else{
                document.getElementById("hidchksalikauhpercent").value = 0;
                $('#salikauhpercent').attr('readonly',true);
                if($('#mode').val()!='view' ){
                    $('#salikauhpercent').val(0);   
                } 
            }
         }
        
        function funChangeSalikDXBPercent(){
            if(document.getElementById("chksalikdxbpercent").checked){
                getDefaultService();
                document.getElementById("hidchksalikdxbpercent").value = 1;
                $('#salikpercent').attr('readonly',false );
                if($('#mode').val()=='A' ){
                    $('#salikpercent').val(0);   
                }
            }
            else{
                document.getElementById("hidchksalikdxbpercent").value = 0;
                $('#salikpercent').attr('readonly',true);
                if($('#mode').val()!='view' ){
                    $('#salikpercent').val(0);   
                } 
            }
         }
        function funChangeSalikTRAFPercent(){
            if(document.getElementById("chktrafficpercent").checked){
                document.getElementById("hidchktrafficpercent").value = 1;
                $('#trafficpercent').attr('readonly',false );
                if($('#mode').val()=='A' ){
                    $('#trafficpercent').val(0);   
                }
            }
            else{
                document.getElementById("hidchktrafficpercent").value = 0;
                $('#trafficpercent').attr('readonly',true);
                if($('#mode').val()!='view' ){
                    $('#trafficpercent').val(0);   
                } 
            }
         }
        
        function funChangeSalikPARKFPercent(){
            if(document.getElementById("chkparkingpercent").checked){
                getDefaultService();
                document.getElementById("hidchkparkingpercent").value = 1;
                $('#parkingpercent').attr('readonly',false );
                if($('#mode').val()=='A' ){
                    $('#parkingpercent').val(0);   
                }
            }
            else{
                document.getElementById("hidchkparkingpercent").value = 0;
                $('#parkingpercent').attr('readonly',true);
                if($('#mode').val()!='view' ){
                    $('#parkingpercent').val(0);   
                } 
            }
         } 
     function defaultseparateservicecheck(){
         if(document.getElementById("chckseparatesrvcdefault").checked){
             document.getElementById("hidchckseparatesrvcdefault").value = 1;
         }
         else{
             document.getElementById("hidchckseparatesrvcdefault").value = 0;
         }
         getDefaultSeparateService();
     }
     
     function getDefaultSeparateService(){
         if(parseInt($('#separateservicechargeallowed').val())==1){
             $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
         }
     }
     
     function advancecheck(){
         if(document.getElementById("chckadvance").checked){
             document.getElementById("hidchckadvance").value = 1;
         }
         else{
             document.getElementById("hidchckadvance").value = 0;
         }
     }
    
     function nontaxableentitycheck() {
         if(document.getElementById("chcknontaxableentity").checked){
             document.getElementById("hidchcknontaxableentity").value = 1;
         }
         else{
             document.getElementById("hidchcknontaxableentity").value = 0;
         }
     }
    
     function mobileValid(value){
       if(value!=""){ 
        var phoneno = /^\d{12}$/;  
            if(value.match(phoneno)){
                document.getElementById("errormsg").innerText="";
                $('#txtmobilevalidation').val(0);
                return true;
            }
            else{
                document.getElementById("errormsg").innerText="Invalid Mobile Number";
                $('#txtmobilevalidation').val(1);
                return false;
            }
        } 
       return true;
     }
    
     function funReadOnly(){
            $('#frmClientMaster input').attr('readonly', true );
            $('#frmClientMaster select').attr('disabled', true);
            $('#jqxClientDate').jqxDateTimeInput({disabled: true});
            $('#jqxContractDate').jqxDateTimeInput({disabled: true});
            $('#dateOfJoining').jqxDateTimeInput({disabled: true});
            $('#chcknontaxableentity').attr('disabled', true);
            $('#chckseparatesrvcdefault').attr('disabled', true);
            $("#separateServiceChargeGridId").jqxGrid({ disabled: true});
            $("#jqxReferenceDetails").jqxGrid({ disabled: true});
            $("#refdetsearch").jqxGrid({ disabled: true});
            $("#jqxCreditCardDetails").jqxGrid({ disabled: true});
     }
    
     function funRemoveReadOnly(){
            getContract();getIDPDetails();getCRMDriverDetailsVerify();getSeparateServiceChargeAllowed();getNonTaxableEntity();getSalesmanConfigs();getclientSrvChrges();
            $('#frmClientMaster input').attr('readonly', false );
            $('#frmClientMaster select').attr('disabled', false);
            $('#chckdefault').attr('disabled', false);
            $('#chckseparatesrvcdefault').attr('disabled', false);
            $('#chcknontaxableentity').attr('disabled', false);
            $('#jqxClientDate').jqxDateTimeInput({disabled: false});
            $('#jqxContractDate').jqxDateTimeInput({disabled: false});
            $('#dateOfJoining').jqxDateTimeInput({disabled: false});
            $('#txtaccount').attr('readonly', true);
            $('#txtcode').attr('readonly', true);
            $('#docno').attr('readonly', true);
            $("#jqxReferenceDetails").jqxGrid({ disabled: false});
            $("#refdetsearch").jqxGrid({ disabled: false});
            $("#jqxCreditCardDetails").jqxGrid({ disabled: false});
            $("#separateServiceChargeGridId").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
             
                    getDefaultService();getDefaultInvoicingMethod();
                    $('#txtsalik').attr('readonly', true );
                    $('#txtsalikauh').attr('readonly', true );
                    $('#txttraffic').attr('readonly', true );
                    $('#hidchckdefault').val(1);
                    $('#hidchckseparatesrvcdefault').val(1);
                    $('#hidchckadvance').val(0);
                    var hidclientsrvchrges= $('#hidclientsrvchrges').val();
                    if(hidclientsrvchrges==1 ||hidclientsrvchrges==2 ||hidclientsrvchrges==3 ){
                        document.getElementById("chckdefault").checked = false;
                        document.getElementById("hidchckdefault").value = 0;
                        }else{
                        document.getElementById("chckdefault").checked = true;
                        document.getElementById("hidchckdefault").value = 1;
                            
                        }
                    document.getElementById("chckseparatesrvcdefault").checked = true;
                    document.getElementById("chckadvance").checked = false;
                    $('#cmbsalesman').prop('selectedIndex',0);
                    $('#cmbtax').prop('selectedIndex',0);
                    
                    $('#jqxClientDate').val(new Date());
                    $('#jqxContractDate').val(null);
                    $('#dateOfJoining').val(null);
                    
                    $("#jqxDriver").jqxGrid('clear'); 
                    $("#jqxDriver").jqxGrid('addrow', null, {});
                    $("#jqxCreditCardDetails").jqxGrid('clear'); 
                    $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
                    $("#jqxReferenceDetails").jqxGrid('clear'); 
                    $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
                    $("#separateServiceChargeGridId").jqxGrid('clear'); 
                    funChangeSalikPercent();
            }
            
            if ($("#mode").val() == "E") {
                $("#jqxDriver").jqxGrid('addrow', null, {});
                $("#jqxDriver").jqxGrid('hidecolumn', 'attachbtn');
                $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
                $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
                
                if($('#salesmaneditstatus').val()=="1"){
                    $("#cmbsalesman").attr("disabled",true);
                }
            }
            funCreditCardValidate();
     }
     function funNotify(){  
         /* Validation */
         $('#jqxDriver').jqxGrid('clearfilters');  
        
         valid=document.getElementById("txtvalidation").value;
         if(valid==1){
             document.getElementById("errormsg").innerText="Invalid Values.";
             return 0;
         }
        
         accgroup=document.getElementById("txtcategoryvalidation").value;
         if(accgroup==1){
             document.getElementById("errormsg").innerText="Individual Client should have Retail Client A/C Group.";
             return 0;
         }
        
         if($('#mode').val()=="A"){
             if($('#cmbsalesman').val()==""){
                 document.getElementById("errormsg").innerText="Salesman is mandatory.";
                 return 0;
             }
         }
         if($('#mode').val()=="E"){
             if($('#cmbsalesman').val()=="" && $('#salesmaneditstatus').val()!="1"){
                 document.getElementById("errormsg").innerText="Salesman is mandatory.";
                 return 0;
             }
         }
         if(document.getElementById("chksalikpercent").checked==true){
             if(document.getElementById("salikpercent").value==""){
                 document.getElementById("errormsg").innerText="Salik Percent Mandatory when percentage selected.";
                 return 0;
             }
             if(document.getElementById("salikauhpercent").value==""){
                 document.getElementById("errormsg").innerText="Salik DARB Percent Mandatory when percentage selected.";
                 return 0;
             }
             if(document.getElementById("trafficpercent").value==""){
                 document.getElementById("errormsg").innerText="Traffic Percent Mandatory when percentage selected.";
                 return 0;
             }
         }
        
         invoice=document.getElementById("cmbinvoicing_method").value;
         if(invoice=="" || invoice==0){
             document.getElementById("errormsg").innerText="Please Select Invoicing Method.";
             return 0;
         }
        
         chkvalid=document.getElementById("chkvalid").value;
         if(chkvalid==1){
             document.getElementById("errormsg").innerText="Invalid Values.";
             return 0;
         }
        
         chkcardvalid=document.getElementById("chkcardvalid").value;
         if(chkcardvalid==1){
             document.getElementById("errormsg").innerText="Invalid Credit Card.";
             return 0;
         }
        
         mobilevalid=document.getElementById("txtmobilevalidation").value;
         if(mobilevalid==1){
             document.getElementById("errormsg").innerText="Invalid Mobile Number.";
             return 0;
         }
        
         var tax=document.getElementById("cmbtax").value;
         if(tax.trim()=='' || tax.trim()=='0'){
             document.getElementById("errormsg").innerText="Tax is Mandatory.";
             return 0;
         }
        
         if($('#cmbtax').val()=='1'){
             var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
             if(registeredtrnno.trim()==''){
                 document.getElementById("errormsg").innerText="TRN No. is Mandatory for VAT.";
                 return 0;
             } 
         }
        var account=document.getElementById("cmbgroup1").value;
         if(account=="" || account=="null" || typeof(account)=="NaN" || typeof(account)=="undefined" || account=="0")
            {
            document.getElementById("errormsg").innerText=" Enter Account Group";
            document.getElementById("cmbgroup1").focus();  
            return 0;
            }
            
         if($('#creditcardstatus').val()=="1"){
            var cardtype=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'type');
            var cardno=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'cardno');
            var cardexp=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'exp_date');
            
            if(cardtype==null || cardtype=="" || cardtype=="undefined" || typeof(cardtype)=="undefined"){
                var targetid=$('#tabs').find('li').eq(2).attr('id');
                if(targetid!="current"){
                    $('#tabs').find('li').eq(2).trigger('click');
                }
                document.getElementById("errormsg").innerText="Card Type Required.";
                return 0;
            }
            var cardmax=0;
            if(cardtype=="VISA" || cardtype=="MASTER"){
                cardmax=16;
            }
            else if(cardtype=="AMEX"){
                cardmax=15;
            }
            
            if(cardno.length!=cardmax){
                var targetid=$('#tabs').find('li').eq(2).attr('id');
                if(targetid!="current"){
                    $('#tabs').find('li').eq(2).trigger('click');
                }
                document.getElementById("errormsg").innerText="Card Number should be "+cardmax+" digits";
                return 0;
            }
            
            if(cardexp==null || cardexp=="" || cardexp=="undefined" || typeof(cardexp)=="undefined"){
                document.getElementById("errormsg").innerText="Card Expiry not valid";
                return 0;
            }
            var currentdate=new Date();
            cardexp=new Date(cardexp);
            if(cardexp.getFullYear()<currentdate.getFullYear()){
                var targetid=$('#tabs').find('li').eq(2).attr('id');
                if(targetid!="current"){
                    $('#tabs').find('li').eq(2).find('a').trigger('click');
                }
                document.getElementById("errormsg").innerText="Card Expiry not valid";
                return 0;
            }
            else if(cardexp.getFullYear()==currentdate.getFullYear()){
                if(cardexp.getMonth()<currentdate.getMonth()){
                    var targetid=$('#tabs').find('li').eq(2).attr('id');
                    if(targetid!="current"){
                        $('#tabs').find('li').eq(2).find('a').trigger('click');
                    }
                    document.getElementById("errormsg").innerText="Card Expiry not valid";
                    return 0;   
                }
                else if(cardexp.getMonth()==currentdate.getMonth()){
                    if(cardexp.getDate()<currentdate.getDate()){
                        var targetid=$('#tabs').find('li').eq(2).attr('id');
                        if(targetid!="current"){
                            $('#tabs').find('li').eq(2).find('a').trigger('click');
                        }
                        document.getElementById("errormsg").innerText="Card Expiry not valid";
                        return 0;   
                    }
                }
            }
         }
         document.getElementById("errormsg").innerText="";      

             clientname=document.getElementById("txtclient_name").value;
             salutation=document.getElementById("cmbsalutation").value;
             docno=document.getElementById("docno").value;
             mode=document.getElementById("mode").value;
             getClientAlreadyExists(clientname,salutation,docno,mode);
        } 
    
     function funSearchLoad(){
            changeContent('crmMainSearch.jsp'); 
         }
    
     function funFocus(){
        $('#jqxClientDate').jqxDateTimeInput('focus');          
    }
    
     function setValues(){
            getSeparateServiceChargeAllowed();
            
            /* Enquiry Form dtype */
            document.getElementById("formdetail").value="Client";
            document.getElementById("formdetailcode").value="CRM";
             if($('#hidjqxClientDate').val()){
                 $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
              }
            
             if($('#hidjqxContractDate').val()){
                 $("#jqxContractDate").jqxDateTimeInput('val', $('#hidjqxContractDate').val());
              }
            
             if($('#hiddateOfJoining').val()){
                 $("#dateOfJoining").jqxDateTimeInput('val', $('#hiddateOfJoining').val());
              }
            
             if(document.getElementById("hidchckdefault").value==1){
                 document.getElementById("chckdefault").checked = true;
             }
             else if(document.getElementById("hidchckdefault").value==0){
                document.getElementById("chckdefault").checked = false;
             }
            
             if(document.getElementById("hidchckseparatesrvcdefault").value==1){
                 document.getElementById("chckseparatesrvcdefault").checked = true;
             }
             else if(document.getElementById("hidchckseparatesrvcdefault").value==0){
                document.getElementById("chckseparatesrvcdefault").checked = false;
             }
            
             if(document.getElementById("hidchckadvance").value==1){
                 document.getElementById("chckadvance").checked = true;
             }
             else if(document.getElementById("hidchckadvance").value==0){
                document.getElementById("chckadvance").checked = false;
             }
            
             if(document.getElementById("hidchcknontaxableentity").value==1){
                 document.getElementById("chcknontaxableentity").checked = true;
             }
             else if(document.getElementById("hidchcknontaxableentity").value==0){
                document.getElementById("chcknontaxableentity").checked = false;
             }
            
             if($('#hidcmbcurrency').val()!=""){
                 getCurrencyIds();
                 $('#cmbcurrency').val($('#hidcmbcurrency').val());
             }
            
            document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
            $('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
            
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
            
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 getCategoryWiseEditEnable($('#cmbcategory').val());
                 var check = 1;
                 $("#jqxDriver1").load("driver.jsp?txtclientdocno1="+indexVal+"&check="+check);
                 $("#creditCardDetailsDiv").load("creditCardDetailsGrid.jsp?txtclientdocno2="+indexVal+"&check="+check);
                 $("#jqxReferenceDetails1").load("referenceDetails.jsp?txtclientdocno3="+indexVal+"&check="+check);
                 $("#jqxReferenceDetails2").load("referenceDetailsnew.jsp?txtclientdocno4="+indexVal);
                 $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=1&txtclientdocno4="+indexVal);
                if(document.getElementById("hidchksalikpercent").value=="0"){
                    document.getElementById("chksalikpercent").checked=false;
                    funChangeSalikPercent();
                }
                else if(document.getElementById("hidchksalikpercent").value=="1"){
                    document.getElementById("chksalikpercent").checked=true;
                    funChangeSalikPercent();
                }
                funCreditCardValidate();
                
                if($('#hidchksalikauhpercent').val()=='1'){
                    document.getElementById('chksalikauhpercent').checked=true;
                }
                else{
                    document.getElementById('chksalikauhpercent').checked=false;
                }
                
                if($('#hidchksalikdxbpercent').val()=='1'){
                    document.getElementById('chksalikdxbpercent').checked=true;
                }
                else{
                    document.getElementById('chksalikdxbpercent').checked=false;
                }
                
                if($('#hidchktrafficpercent').val()=='1'){
                    document.getElementById('chktrafficpercent').checked=true;
                }
                else{
                    document.getElementById('chktrafficpercent').checked=false;
                }
                
                if($('#hidchkparkingpercent').val()=='1'){
                    document.getElementById('chkparkingpercent').checked=true;
                }
                else{
                    document.getElementById('chkparkingpercent').checked=false;
                }
             }
        }
     function getSalesmanConfigs(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    $('#salesmaneditstatus').val(items);
                    if(items=="1")   
                    {
                        if($('#mode').val()!="A"){
                            $("#cmbsalesman").attr("disabled",true);    
                        }
                    }else {
                        $("#cmbsalesman").attr("disabled",false);
                    }
                    }
            }
            x.open("GET", "getSalesmanConfigs.jsp", true);
            x.send();
     }
     function funChkButton() {}
     function funexcelexport(){
     $("#documentExpiryDiv").excelexportjs({
            containerid: "", 
            datatype: 'json', 
            dataset: null, 
            gridId: "jqxloaddataGrid", 
            columns: getColumns("jqxloaddataGrid") ,   
            worksheetName:"clientMaster"
            });
     }
    
     function funCreditCardValidate(){
         var catid=$('#cmbcategory').val();
         $.get('getCreditCardValidate.jsp',{'catid':catid},function(data){
            data=JSON.parse(data);
            $('#creditcardstatus').val(data.creditcardstatus);
         });
     }
</script>

<style>

body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }


.jqx-grid-header {
    /* Shifted from #f8f9fa to #e9ecef (subtly darker gradient) */
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
font-family: Arial, sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}

/* Cell Styling */
.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; /* Slightly darker grid lines */
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}

/* Zebra Striping (Alt Rows) */
.jqx-grid-cell-alt {
    background: #f1f3f5 !important; /* Darker than the previous #f8f9fa */
}

/* Hover & Selection States */
.jqx-grid-cell-hover {
    background: #dee2e6 !important; /* More pronounced hover */
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; /* Solid medium grey for selection */
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}

/* Main Container */
.jqx-grid {
    border: 1px solid #adb5bd !important; /* Darker outer border */
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}

/* Specialized Cell States */
.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}

/* Pager & UI Elements */
.jqx-grid-pager {
    background: #e9ecef !important; /* Darker pager background */
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}

/* Scrollbar Styling */
.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; /* Steel grey thumb */
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; /* Deep grey on hover */
    border-radius: 4px !important;
}


</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="saveClientMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div style="border: 1px solid transparent; padding: 5px 0;">
        <div class="top-grid">
            
            <label>Date</label>
            <div>
                <div id="jqxClientDate" name="jqxClientDate" onchange="getContractDate();" value='<s:property value="jqxClientDate"/>'></div>
                <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/>
            </div>
            
            <label>Code</label>
            <input type="text" id="txtcode" name="txtcode" tabindex="-1" value='<s:property value="txtcode"/>'/>
            
            <label>Name</label>
            <div class="flex-row">
                <input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyIds();" style="flex:2;" value='<s:property value="txtclient_name"/>'/>
                <select id="cmbsalutation" name="cmbsalutation" style="flex:1;" value='<s:property value="cmbsalutation"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbsalutation" name="hidcmbsalutation" value='<s:property value="hidcmbsalutation"/>'/>
            </div>
            
            <label>Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            
            <label>Doc No</label>
            <input type="text" id="docno" name="txtclientdocno" tabindex="-1" value='<s:property value="txtclientdocno"/>'/>
            
            <label>Category</label>
            <select id="cmbcategory" name="cmbcategory" onchange="getCategoryAccountGroup(this.value);funCreditCardValidate();" value='<s:property value="cmbcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            
            <label id="lblsalesman">Salesman</label>
            <select id="cmbsalesman" name="cmbsalesman" value='<s:property value="cmbsalesman"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/>
            
            <div></div> <div style="display:flex; justify-content: center;">
                <label class="chk-container">
                    <input type="checkbox" id="chckadvance" name="chckadvance" value="" onchange="advancecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    Advance
                </label>
                <input type="hidden" id="hidchckadvance" name="hidchckadvance" value='<s:property value="hidchckadvance"/>'/>
            </div>
            
            <label>Invoicing Method</label>
            <select id="cmbinvoicing_method" name="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                <option value="">--Select--</option>
                <option value="1">Month End</option>
                <option value="2">Period</option>
            </select>
            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
            
            <label>Knowledge Fee</label>
            <select id="cmbdel_charges" name="cmbdel_charges" value='<s:property value="cmbdel_charges"/>'>
                <option value="">--Select--</option>
                <option value=1>Yes</option>
                <option value=0>No</option>
            </select>
            <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/>
            
            <label id="lbltaxableentity">Tax</label>
            <select id="cmbtax" name="cmbtax" onchange="taxcheck();" value='<s:property value="cmbtax"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbtax" name="hidcmbtax" value='<s:property value="hidcmbtax"/>'/>
            
            <label id="lbltrnnoentity">TRN No.</label>
            <div style="grid-column: 4 / span 3; display: flex; align-items: center;">
                <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width: 50%;" value='<s:property value="txtregisteredtrnno"/>'/>
                <label class="chk-container" id="lblnontaxableentity" style="margin-left: 15px;">
                    <input type="checkbox" id="chcknontaxableentity" name="chcknontaxableentity" value="" onchange="nontaxableentitycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    Taxable Entity
                </label>
                <input type="hidden" id="hidchcknontaxableentity" name="hidchcknontaxableentity" value='<s:property value="hidchcknontaxableentity"/>'/>
            </div>
            
        </div>
    </div>


    <div class="middle-section">
        
        <div class="middle-panel" style="flex: 0 0 35%;">
            <span class="middle-panel-title">Account Info</span>
            
            <div style="display: flex; gap: 8px; margin-bottom: 6px; align-items: center;">
                <label class="lbl-right" style="width: 90px;">Account Group</label>
                <select id="cmbgroup1" name="cmbgroup1" style="flex:1;" value='<s:property value="cmbgroup1"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/>
                
                <label class="lbl-right" style="width: 60px;">Account</label>
                <input type="text" id="txtaccount" name="txtaccount" tabindex="-1" style="flex:1;" value='<s:property value="txtaccount"/>'/>
            </div>
            
            <div style="display: flex; gap: 8px; align-items: center;">
                <label class="lbl-right" style="width: 120px;">Credit Period-Min(Days)</label>
                <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="flex:1; text-align: right;" value='<s:property value="txtcredit_period_min"/>'/>
                
                <label class="lbl-right" style="width: 60px;">Max(Days)</label>
                <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="flex:1; text-align: right;" value='<s:property value="txtcredit_period_max"/>'/>
                
                <label class="lbl-right" style="width: 70px;">Credit Limit</label>
                <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="flex:1.5; text-align: right;" value='<s:property value="txtcredit_limit"/>'/>
            </div>
        </div>
        
        <div class="middle-panel" style="flex: 1;">
            <span class="middle-panel-title">Service Charge</span>
            
            <div id="singleServiceChargeDiv">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; gap: 10px;">
                    <label class="chk-container" style="width: 70px;">
                        <input type="checkbox" id="chckdefault" name="chckdefault" value="" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        Default
                    </label>
                    <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/>
                    
                    <div class="flex-row"><label class="lbl-right" style="width: 40px;">DARB</label><input type="text" id="txtsalikauh" name="txtsalikauh" style="text-align: right;" value='<s:property value="txtsalikauh"/>'/></div>
                    <div class="flex-row"><label class="lbl-right" style="width: 60px;">Salik DXB</label><input type="text" id="txtsalik" name="txtsalik" style="text-align: right;" value='<s:property value="txtsalik"/>'/></div>
                    <div class="flex-row"><label class="lbl-right" style="width: 45px;">Traffic</label><input type="text" id="txttraffic" name="txttraffic" style="text-align: right;" value='<s:property value="txttraffic"/>'/></div>
                    <div class="flex-row"><label class="lbl-right" style="width: 50px;">Parking</label><input type="text" id="txtparking" name="txtparking" style="text-align: right;" value='<s:property value="txtparking"/>'/></div>
                </div>
                
                <div class="row-salikpercent" style="display: flex; justify-content: space-between; align-items: center; gap: 10px;">
                    <label class="chk-container" style="width: 70px;">
                        <input type="checkbox" id="chksalikpercent" name="chksalikpercent" value="" onchange="funChangeSalikPercent();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        Percentage
                    </label>
                    <input type="hidden" id="hidchksalikpercent" name="hidchksalikpercent" value='<s:property value="hidchksalikpercent"/>'/>
                    
                    <div class="flex-row"><label class="chk-container" style="width: 60px; justify-content: flex-end;"><input type="checkbox" id="chksalikauhpercent" name="chksalikauhpercent" value='<s:property value="chksalikauhpercent"/>' onchange="funChangeSalikDARBPercent();">DARB %</label><input type="text" id="salikauhpercent" name="salikauhpercent" style="text-align: right;" value='<s:property value="salikauhpercent"/>'/></div>
                    <div class="flex-row"><label class="chk-container" style="width: 85px; justify-content: flex-end;"><input type="checkbox" id="chksalikdxbpercent" name="chksalikdxbpercent" value='<s:property value="chksalikdxbpercent"/>' onchange="funChangeSalikDXBPercent();">Salik DXB %</label><input type="text" id="salikpercent" name="salikpercent" style="text-align: right;" value='<s:property value="salikpercent"/>'/></div>
                    <div class="flex-row"><label class="chk-container" style="width: 70px; justify-content: flex-end;"><input type="checkbox" id="chktrafficpercent" name="chktrafficpercent" value='<s:property value="chktrafficpercent"/>' onchange="funChangeSalikTRAFPercent();">Traffic %</label><input type="text" id="trafficpercent" name="trafficpercent" style="text-align: right;" value='<s:property value="trafficpercent"/>'/></div>
                    <div class="flex-row"><label class="chk-container" style="width: 75px; justify-content: flex-end;"><input type="checkbox" id="chkparkingpercent" name="chkparkingpercent" value='<s:property value="chkparkingpercent"/>' onchange="funChangeSalikPARKFPercent();">Parking %</label><input type="text" id="parkingpercent" name="parkingpercent" style="text-align: right;" value='<s:property value="parkingpercent"/>'/></div>
                </div>
                <input type="hidden" id="hidchksalikauhpercent" name="hidchksalikauhpercent" value='<s:property value="hidchksalikauhpercent"/>'/>
                <input type="hidden" id="hidchksalikdxbpercent" name="hidchksalikdxbpercent" value='<s:property value="hidchksalikdxbpercent"/>'/>
                <input type="hidden" id="hidchktrafficpercent" name="hidchktrafficpercent" value='<s:property value="hidchktrafficpercent"/>'/>
                <input type="hidden" id="hidchkparkingpercent" name="hidchkparkingpercent" value='<s:property value="hidchkparkingpercent"/>'/>
            </div>
            
            <div id="separateServiceChargeDiv" hidden="true">
                <div style="display: flex; gap: 10px; align-items:flex-start;">
                    <input type="checkbox" id="chckseparatesrvcdefault" name="chckseparatesrvcdefault" value="" onchange="defaultseparateservicecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin-top: 5px;">
                    <input type="hidden" id="hidchckseparatesrvcdefault" name="hidchckseparatesrvcdefault" value='<s:property value="hidchckseparatesrvcdefault"/>'/>
                    <div id="separateServiceChargeGridDiv" style="flex:1;"><jsp:include page="separateServiceChargesGrid.jsp"></jsp:include></div>
                </div>
            </div>
        </div>
    </div>

    <ul id="tabs">
        <li><a href="#" name="tab1">Driver Details</a></li>
        <li><a href="#" name="tab2">Know Your Customer</a></li>
        <li><a href="#" name="tab3">Banking Details</a></li>
        <li><a href="#" name="tab4">Others</a></li>
    </ul>
    
    <div id="content">
        <div id="tab1">
            <div style="width:100%;">
                <div id="jqxDriver1"> <jsp:include page="driver.jsp"></jsp:include></div><br/>
            </div>
        </div>

        <div id="tab2">
            <div style="width:100%;">
                <table class="cr-table" width="100%">
                    <thead>
                        <tr>
                            <th width="15%" style="background:#fff; border:none;"></th>
                            <th width="21%">Communication Details</th>
                            <th width="21%">Office Details</th>
                            <th width="21%">Residence Details</th>
                            <th width="22%">Home Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="lbl-right" style="border:none;">Address 1</td>
                            <td><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" tabindex="3" value='<s:property value="txtpersonal_add1"/>'/></td>
                            <td><input type="text" id="txtoffice_add1" name="txtoffice_add1" tabindex="11" value='<s:property value="txtoffice_add1"/>'/></td>
                            <td><input type="text" id="txtresidence_add1" name="txtresidence_add1" tabindex="19" value='<s:property value="txtresidence_add1"/>'/></td>
                            <td><input type="text" id="txthome_add1" name="txthome_add1" tabindex="27" value='<s:property value="txthome_add1"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Address 2</td>
                            <td><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" tabindex="4" value='<s:property value="txtpersonal_add2"/>'/></td>
                            <td><input type="text" id="txtoffice_add2" name="txtoffice_add2" tabindex="12" value='<s:property value="txtoffice_add2"/>'/></td>
                            <td><input type="text" id="txtresidence_add2" name="txtresidence_add2" tabindex="20" value='<s:property value="txtresidence_add2"/>'/></td>
                            <td><input type="text" id="txthome_add2" name="txthome_add2" tabindex="28" value='<s:property value="txthome_add2"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Telephone</td>
                            <td><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" tabindex="5" value='<s:property value="txtpersonal_tel1"/>'/></td>
                            <td><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" tabindex="13" value='<s:property value="txtoffice_tel1"/>'/></td>
                            <td><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" tabindex="21" value='<s:property value="txtresidence_tel1"/>'/></td>
                            <td><input type="text" id="txthome_tel1" name="txthome_tel1" tabindex="29" value='<s:property value="txthome_tel1"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Mobile</td>
                            <td><input type="text" id="personal_tel2" name="personal_tel2" onblur="mobileValid(this.value);getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" tabindex="6" value='<s:property value="personal_tel2"/>'/></td>
                            <td><input type="text" id="office_tel2" name="office_tel2" onblur="mobileValid(this.value);" tabindex="14" value='<s:property value="office_tel2"/>'/></td>
                            <td><input type="text" id="residence_tel2" name="residence_tel2" onblur="mobileValid(this.value);" tabindex="22" value='<s:property value="residence_tel2"/>'/></td>
                            <td><input type="text" id="home_tel2" name="home_tel2" onblur="mobileValid(this.value);" tabindex="30" value='<s:property value="home_tel2"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Fax</td>
                            <td><input type="text" id="txtpersonal_fax" name="txtpersonal_fax" tabindex="7" value='<s:property value="txtpersonal_fax"/>'/></td>
                            <td><input type="text" id="txtoffice_fax" name="txtoffice_fax" tabindex="15" value='<s:property value="txtoffice_fax"/>'/></td>
                            <td><input type="text" id="txtresidence_fax" name="txtresidence_fax" tabindex="23" value='<s:property value="txtresidence_fax"/>'/></td>
                            <td><input type="text" id="txthome_fax" name="txthome_fax" tabindex="31" value='<s:property value="txthome_fax"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Email</td>
                            <td><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="@example.com" tabindex="8" value='<s:property value="txtpersonal_email"/>'/></td>
                            <td><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="@example.com" tabindex="16" value='<s:property value="txtoffice_email"/>'/></td>
                            <td><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="@example.com" tabindex="24" value='<s:property value="txtresidence_email"/>'/></td>
                            <td><input type="text" id="txthome_email" name="txthome_email" placeholder="@example.com" tabindex="32" value='<s:property value="txthome_email"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Contact</td>
                            <td><input type="text" id="txtpersonal_contact" name="txtpersonal_contact" tabindex="9" value='<s:property value="txtpersonal_contact"/>'/></td>
                            <td><input type="text" id="txtoffice_contact" name="txtoffice_contact" tabindex="17" value='<s:property value="txtoffice_contact"/>'/></td>
                            <td><input type="text" id="txtresidence_contact" name="txtresidence_contact" tabindex="25" value='<s:property value="txtresidence_contact"/>'/></td>
                            <td><input type="text" id="txthome_contact" name="txthome_contact" tabindex="33" value='<s:property value="txthome_contact"/>'/></td>
                        </tr>
                        <tr>
                            <td class="lbl-right" style="border:none;">Makani No.</td>
                            <td><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" tabindex="10" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                            <td><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" tabindex="18" value='<s:property value="txtoffice_extn_no"/>'/></td>
                            <td><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" tabindex="26" value='<s:property value="txtresidence_extn_no"/>'/></td>
                            <td><input type="text" id="txthome_extn_no" name="txthome_extn_no" tabindex="34" value='<s:property value="txthome_extn_no"/>'/></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="tab3">
            <fieldset>
                <legend>Credit Card Details</legend>
                <div id="creditCardDetailsDiv"> <jsp:include page="creditCardDetailsGrid.jsp"></jsp:include></div><br />
            </fieldset>
        </div>

        <div id="tab4">
            <div class="middle-section">
                <div class="middle-panel" style="flex: 0 0 48%;">
                    <span class="middle-panel-title" id="refid">Reference Details</span>
                    <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div><br/>
                    <div id="jqxReferenceDetails2"><jsp:include page="referenceDetailsnew.jsp"></jsp:include></div><br/>
                </div>
                
                <div class="middle-panel" style="flex: 1;">
                    <span class="middle-panel-title">Sponsor/Company Details</span>
                    <div style="display: grid; grid-template-columns: 80px 1fr 60px 1fr 70px 1fr; gap: 6px 10px; align-items: center; padding-top: 5px;">
                        
                        <label class="lbl-right">Name</label>
                        <div style="grid-column: 2 / span 5;"><input type="text" id="txtname" name="txtname" value='<s:property value="txtname"/>'/></div>
                        
                        <label class="lbl-right">Address</label>
                        <div style="grid-column: 2 / span 5;"><input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>'/></div>
                        
                        <label class="lbl-right">Telephone</label>
                        <div><input type="text" id="txttelephone" name="txttelephone" value='<s:property value="txttelephone"/>'/></div>
                        <label class="lbl-right">ID.</label>
                        <div><input type="text" id="txtid" name="txtid" value='<s:property value="txtid"/>'/></div>
                        <label class="lbl-right">Nationality</label>
                        <div>
                            <select id="cmbnationality" name="cmbnationality" value='<s:property value="cmbnationality"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/>
                        </div>
                        
                        <label class="lbl-right">Security</label>
                        <div><input type="text" id="txtsecurity" name="txtsecurity" value='<s:property value="txtsecurity"/>'/></div>
                        <div style="grid-column: 3 / span 4;"><input type="text" id="txtsecurity1" name="txtsecurity1" value='<s:property value="txtsecurity1"/>'/></div>
                        
                        <label class="lbl-right">Job Title</label>
                        <div style="grid-column: 2 / span 2;"><input type="text" id="txtjobtitle" name="txtjobtitle" value='<s:property value="txtjobtitle"/>'/></div>
                        <label class="lbl-right" style="grid-column: 4 / span 1;">Date of Joining</label>
                        <div style="grid-column: 5 / span 2;">
                            <div id="dateOfJoining" name="dateOfJoining" value='<s:property value="dateOfJoining"/>'></div>
                            <input type="hidden" id="hiddateOfJoining" name="hiddateOfJoining" value='<s:property value="hiddateOfJoining"/>'/>
                        </div>
                        
                        <label class="lbl-right">Bank Name</label>
                        <div style="grid-column: 2 / span 5;"><input type="text" id="txtbankname" name="txtbankname" value='<s:property value="txtbankname"/>'/></div>
                    </div>
                    
                    <div id="sponsorDiv"><br/></div>
                    
                    <div id="contractDiv" hidden="true">
                        <div style="margin-top:15px; padding-top: 10px; border-top: 1px dashed #e1e4e8;">
                            <span style="color:#0056b3; font-weight:bold; font-size:13px; display:block; margin-bottom:8px;">Trade Licence Details</span>
                            <div style="display: grid; grid-template-columns: 120px 1fr 120px 1fr; gap: 6px 10px; align-items: center;">
                                <label class="lbl-right">Trade Licence No.</label>
                                <div><input type="text" id="txtcontractno" name="txtcontractno" value='<s:property value="txtcontractno"/>'/></div>
                                <label class="lbl-right">Trade Licence Date</label>
                                <div>
                                    <div id="jqxContractDate" name="jqxContractDate" value='<s:property value="jqxContractDate"/>'></div>
                                    <input type="hidden" id="hidjqxContractDate" name="hidjqxContractDate" value='<s:property value="hidjqxContractDate"/>'/>
                                </div>
                                
                                <label class="lbl-right">Remarks</label>
                                <div style="grid-column: 2 / span 3;"><input type="text" id="txtcontractremarks" name="txtcontractremarks" value='<s:property value="txtcontractremarks"/>'/></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed"  value='<s:property value="idpdetailsallowed"/>'/>
    <input type="hidden" id="driverdetailsverifyallowed" name="driverdetailsverifyallowed"  value='<s:property value="driverdetailsverifyallowed"/>'/>
    <input type="hidden" id="separateservicechargeallowed" name="separateservicechargeallowed"  value='<s:property value="separateservicechargeallowed"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    <input type="hidden" id="txtforcontractdiv" name="txtforcontractdiv"/>
    <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
    <input type="hidden" id="txtcategoryvalidation" name="txtcategoryvalidation" value='<s:property value="txtcategoryvalidation"/>'/>
    <input type="hidden" id="txtcategorywiseedit" name="txtcategorywiseedit" value='<s:property value="txtcategorywiseedit"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <input type="hidden" id="referencelength" name="referencelength"/>
    <input type="hidden" id="referencelength1" name="referencelength1"/>
    <input type="hidden" id="attachlength" name="attachlength1"/>
    <input type="hidden" id="creditcardlength" name="creditcardlength"/>
    <input type="hidden" id="separateservicechargelength" name="separateservicechargelength"/>
    <input type="hidden" id="salesmaneditstatus" name="salesmaneditstatus"/>
    <input type="hidden" id="creditcardstatus" name="creditcardstatus"/>
    <input type="hidden" id="hidclientsrvchrges" name="hidclientsrvchrges" value='<s:property value="hidclientsrvchrges"/>'/>

</form>

<div id="nationalityWindow"><div></div></div>
<div id="stateWindow"><div></div></div>

</div>
</body>
</html>