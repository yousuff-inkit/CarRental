<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 

<style>
    /* ------------------------------
       GLOBAL STYLES
    ------------------------------ */
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important;
    }

    /* ------------------------------
       OVERRIDES (Logic Preservation)
    ------------------------------ */
    /* Forces Date/Time widgets to be responsive and visible */
    #date, #time, #accdate, #collectdate, #jqxValidUpTo, div[id^="jqx"] {
        height: 32px !important;
        width: 100% !important;
        font-size: 14px !important; /* Standard Size */
    }
    
    .jqx-input-content {
        height: 32px !important;
        padding: 5px !important;
        box-sizing: border-box;
        font-size: 14px !important; /* Standard Size */
    }

    /* ------------------------------
       GRID SYSTEM
    ------------------------------ */
    
    /* Title Style */
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr auto 1fr;
        gap: 15px 20px;
        align-items: center;
        margin-bottom: 20px;
        background: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        border: 1px solid #e9ecef;
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr; /* Default label width */
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input { grid-template-columns: 120px 1fr 120px 1fr; }
    .form-group.triple-input { grid-template-columns: 100px 1fr 100px 1fr 100px 1fr; }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 0;
    }

    .section-block h2 {
        font-size: 1.1rem; 
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: flex;
        align-items: center;
    }

    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select, textarea {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        font-size: 14px; /* Standard Size */
        width: 100%;
        box-sizing: border-box;
    }
    textarea { height: auto !important; min-height: 60px; }
    input[readonly] { background-color: #f3f4f6; color: #6b7280; }
    
    label {
        font-weight: 600;
        color: #253858;
        font-size: 14px; /* Standard Size */
        text-align: right;
        padding-right: 10px;
        white-space: nowrap;
    }

    /* ------------------------------
       BUTTONS & UTILS
    ------------------------------ */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 14px;
    }
    .myButton:hover { background: #0056b3; }

    #icons {
        width: 2.5em; height: 2em; border: none; background-color: transparent; cursor: pointer;
    }
    
    .hidden-scrollbar { overflow: auto; height: 600px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } 

    /* Camera Styles */
    #webcam, #canvas {
        width: 100%; max-width: 320px;
        border: 5px solid #333; background: #e0ecf8;
        border-radius: 10px; margin: 10px auto; display: block;
    }
    #imagediv img {
        border-radius: 10px; border: 1px solid #ccc;
        max-height: 200px; object-fit: contain;
    }
</style>

<script type="text/javascript">
      
      $(document).ready(function () { 
          
          
          document.getElementById('download').addEventListener('click', function() {
                downloadCanvas(this);
              //saveViaAJAX();
            }, false);
          
          $("#imagediv").prop("hidden", false); 
             $("#canvasdiv").prop("hidden", true);
        
          
          
          /* Date */
          document.getElementById("btnEdit").disabled=true;
            $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
            $("#time").jqxDateTimeInput({ width: '50%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
          $("#accdate").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
          $("#collectdate").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
          /* Window */
           $('#docwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
           $('#docwindow').jqxWindow('close');
         $('#damagewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Damage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
           $('#damagewindow').jqxWindow('close');
          $('#maintenancewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Complaint Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
           $('#maintenancewindow').jqxWindow('close');
           $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#printWindow').jqxWindow('close');
           $('#date').on('change', function (event) 
                   {  
                       var jsDate = event.args.date; 
                       var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
                       var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
                        if(docdateval=="0"){
                            $('#date').jqxDateTimeInput('focus');
                            return false;
                        }
                        var docdatevalnew=funCheckOneMonthBackDate($('#date').jqxDateTimeInput('val'),"1");
                        if($('#docdatestatus').val()=="0"){
                            return false;
                        }
                   }); 
           document.getElementById("savemsg").innerText="";
               $('#cmbagmtbranch').change(function(){
                document.getElementById("rdocno").value="";
                    document.getElementById("refvoucherno").value="";
                    document.getElementById("rfleet").value="";
                    document.getElementById("regno").value="";
                    document.getElementById("client").value="";
                    document.getElementById("hidinsurexcess").value=""; 
           });
           
         $('#refvoucherno').dblclick(function(){
             $('#cmbclaim').val('');
             document.getElementById("amount").value="";
          var reftype=document.getElementById("cmbreftype").value;
        
            if(document.getElementById("cmbreftype").value==''){
                 document.getElementById("errormsg").innerText="Reference Type is Mandatory";
                 return false;
             }
            if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
                if(document.getElementById("cmbagmtbranch").value==""){
                    document.getElementById("errormsg").innerText="";
                    document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
                    return false;
                }
            }
             document.getElementById("errormsg").innerText="";
                $('#docwindow').jqxWindow('open');
                                    docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val()+'&type='+$('#cmbtype').val(), $('#docwindow'));

            });
        $('#accremarks').keydown(function (evt) {
            //alert(evt.keyCode);
             if (evt.keyCode==9) {
              //alert("inside");
                     event.preventDefault();
                     $('#newmaintenanceGrid').jqxGrid('selectcell',0, 'description');
                     $('#newmaintenanceGrid').jqxGrid('focus',0, 'description');
             }
            });
       enableAccData();
      });
      
      function funCheckOneMonthBackDate(docdate,id){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                if(items=="0"){
                    //document.getElementById("errormsg").innerText="";
                    document.getElementById("errormsg").innerText="Transaction Prior one month is not valid";
                    $('#date').jqxDateTimeInput("focus");
                    $('#docdatestatus').val("0");
                }
                else{
                    document.getElementById("errormsg").innerText="";
                    $('#docdatestatus').val("1");
                }
            } else {
            }
        }
        x.open("GET", "checkDocDate.jsp?docdate="+docdate, true);
        x.send();

      }
   function getAgmtBranch(){
       var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('***');
                var locItems = items[0].split(",");
                var locIdItems = items[1].split(",");
                var optionsloc = '<option value="">--Select--</option>';
                for (var i = 0; i < locItems.length; i++) {
                    optionsloc += '<option value="' + locIdItems[i] + '">'
                            + locItems[i] + '</option>';
                }
                $("select#cmbagmtbranch").html(optionsloc);
                
                if ($('#hidcmbagmtbranch').val() != null && $('#hidcmbagmtbranch').val()!="") {
                    $('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
                }
            } else {
            }
        }
        x.open("GET", "getBranch.jsp", true);
        x.send();
   }
      
      function getDoc(event){
         $('#cmbclaim').val('');
         document.getElementById("amount").value="";
          var reftype=document.getElementById("cmbreftype").value;
         
           if(document.getElementById("cmbreftype").value==''){
             document.getElementById("errormsg").innerText="Reference Type is Mandatory";
             return false;
         }
         if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
                if(document.getElementById("cmbagmtbranch").value==""){
                    document.getElementById("errormsg").innerText="";
                    document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
                    return false;
                }
            }
             document.getElementById("errormsg").innerText="";
          var x= event.keyCode;
          if(x==114){
               $('#docwindow').jqxWindow('open');
                                    docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val()+'&type='+$('#cmbtype').val(), $('#docwindow'));

          }
          else{
           }
      }
      function docSearchContent(url) {
           $.get(url).done(function (data) {
         $('#docwindow').jqxWindow('setContent', data);
    }); 
    }
      function damageSearchContent(url) {
           $.get(url).done(function (data) {
             // alert(data);
         $('#damagewindow').jqxWindow('setContent', data);
    }); 
    }
      function maintenanceSearchContent(url) {
           $.get(url).done(function (data) {
             // alert(data);
         $('#maintenancewindow').jqxWindow('setContent', data);
    }); 
    }
   function readURL(input) {
      
       document.getElementById("filedet").value=1;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                
                document.getElementById('prevImage').src=e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
            loading();
        }
    }
      function funReadOnly(){
      $('#frmVehicleInspection input').attr('readonly',true);
    $('#frmVehicleInspection select').attr('disabled',true);
    $('#date').jqxDateTimeInput({disabled: false});
    
    }
  function setValues(){
 
       funSetlabel();
         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
          getAgmtBranch();
         if ($('#hidcmbtype').val() != null) {
                $('#cmbtype').val($('#hidcmbtype').val());
            }
         if ($('#hidcmbreftype').val() != null) {
                $('#cmbreftype').val($('#hidcmbreftype').val());
            }
         if ($('#hidcmbclaim').val() != null) {
                $('#cmbclaim').val($('#hidcmbclaim').val());
            }
         if($('#hiddate').val()){
                $("#date").jqxDateTimeInput('val', $('#hiddate').val());
            }
         if($('#hidtime').val()){
                $("#time").jqxDateTimeInput('val', $('#hidtime').val());
            }
         if($('#hidaccdate').val()){
                $("#accdate").jqxDateTimeInput('val', $('#hidaccdate').val());
            }
         if($('#hidcollectdate').val()){
                $("#collectdate").jqxDateTimeInput('val', $('#hidcollectdate').val());
            }
         if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
        /* if ($('#hidcmbagmtbranch').val() != null) {
                $('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
            } */
         if(document.getElementById("docno").value>0){
             $('#existingdiv').load('existingGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
             $('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
             $('#existmaintenancediv').load('existmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
             $('#newmaintenancediv').load('newmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
             
         }
  }
  function funSearchLoad(){
        changeContent('mainSearch.jsp'); 
     }
   function funRemoveReadOnly(){
       $('#newGrid').jqxGrid({ disabled: false});
       $('#newmaintenanceGrid').jqxGrid({ disabled: false});
        $('#frmVehicleInspection input').attr('readonly',false);
            $('#frmVehicleInspection select').attr('disabled',false);
       $('#docno').prop('readonly',true);
       $('#rdocno').prop('readonly',true);
       $('#rfleet').prop('readonly',true);
       if(document.getElementById("mode").value=='A'){
           $('#existingGrid').jqxGrid('clear');
           $("#existingGrid").jqxGrid("addrow", null, {});
           $('#newGrid').jqxGrid('clear');
           $("#newGrid").jqxGrid("addrow", null, {});
           $('#existmaintenanceGrid').jqxGrid('clear');
           $("#existmaintenanceGrid").jqxGrid("addrow", null, {});
           $('#newmaintenanceGrid').jqxGrid('clear');
           $("#newmaintenanceGrid").jqxGrid("addrow", null, {});
           $('#date').val(new Date());
           document.getElementById("savemsg").innerText="";
           document.getElementById("errormsg").innerText="";
       }
   }
   function funFocus(){
       document.getElementById("cmbtype").focus();
   }
   function funNotify(){
       var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
        if(docdateval==0){
            $('#date').jqxDateTimeInput('focus');
            return 0;
        }
        if($('#docdatestatus').val()=="0"){
            document.getElementById("errormsg").innerText="Transaction Prior one month is not valid";
            $('#date').jqxDateTimeInput("focus");
            return 0;
        }
       if(document.getElementById("cmbtype").value==""){
           document.getElementById("errormsg").innerText="";
           document.getElementById("errormsg").innerText="Type is Mandatory";
           document.getElementById("cmbtype").focus();
           return 0;
       }
       if(document.getElementById("cmbreftype").value==""){
           document.getElementById("errormsg").innerText="";
           document.getElementById("errormsg").innerText="Reference Type is Mandatory";
           document.getElementById("cmbreftype").focus();
           return 0;
       }
       if(document.getElementById("rdocno").value==""){
           document.getElementById("errormsg").innerText="";
           document.getElementById("errormsg").innerText="Reference Doc is Mandatory";
           document.getElementById("rdocno").focus();
           return 0;
       }
       if(document.getElementById("chkaccidents").checked==true){
           if($('#accdate').jqxDateTimeInput('getDate')==null){
               document.getElementById("errormsg").innerText="";
               document.getElementById("errormsg").innerText="Accident Date cannot be Empty";
               $("#accdate .jqx-input-content").focus();
               return 0;
           }
           if($('#collectdate').jqxDateTimeInput('getDate')==null){
               document.getElementById("errormsg").innerText="";
               document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
               $("#collectdate .jqx-input-content").focus();
               return 0;
           }
       }
       var existrowsdamage = $("#existingGrid").jqxGrid('getrows');
        if(!((existrowsdamage[0].srno=="undefined") || (existrowsdamage[0].srno==null) || (existrowsdamage[0].srno==""))){
    $('#existdamagegridlength').val(existrowsdamage.length);
        //alert($('#gridlength').val());
        for(var i=0 ; i < existrowsdamage.length ; i++){
            //  var myvar = rows[i].tarif; 
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "testexistdamage"+i)
                .attr("name", "testexistdamage"+i);
                
            newTextBox.val(existrowsdamage[i].srno+"::");
            
            newTextBox.appendTo('form');
            
                //alert("ddddd"+$("#testexistdamage"+i).val());
            }
    } 
        var rowsdamage = $("#newGrid").jqxGrid('getrows');
        if(!((rowsdamage[0].code=="undefined") || (rowsdamage[0].code==null) || (rowsdamage[0].code==""))){
    $('#damagegridlength').val(rowsdamage.length);
        //alert($('#gridlength').val());
        for(var i=0 ; i < rowsdamage.length ; i++){
            //  var myvar = rows[i].tarif; 
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+i)
                .attr("name", "test"+i);
                
            newTextBox.val(rowsdamage[i].code+"::"+rowsdamage[i].description+"::"+rowsdamage[i].type+"::"+rowsdamage[i].remarks+"::"+rowsdamage[i].upload+"::"+rowsdamage[i].dmgid);
            
            newTextBox.appendTo('form');
            
                //alert("ddddd"+$("#test"+i).val());
            }
    } 
           var rowsmaintenance = $("#newmaintenanceGrid").jqxGrid('getrows');
            if(!((rowsmaintenance[0].description=="undefined") || (rowsmaintenance[0].description==null) || (rowsmaintenance[0].description==""))){
        $('#maintenancegridlength').val(rowsmaintenance.length);
            //alert($('#gridlength').val());
            for(var i=0 ; i < rowsmaintenance.length ; i++){
                //  var myvar = rows[i].tarif; 
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "testmaint"+i)
                    .attr("name", "testmaint"+i);
                    
                newTextBox.val(rowsmaintenance[i].description+"::"+rowsmaintenance[i].remarks+"::"+rowsmaintenance[i].doc);
                
                newTextBox.appendTo('form');
                
                    //alert("ddddd"+$("#test"+i).val());
                }
        }
        
            document.getElementById("errormsg").innerText="";
       return 1;
   }

 function funResetValues(){
     funRemoveReadOnly();
     document.getElementById("rdocno").value="";
     document.getElementById("rfleet").value="";
 }
 function enableAccData(){
     if(document.getElementById("chkaccidents").checked==true){
         document.getElementById("hidaccidents").value="1";
         $('#accdate').jqxDateTimeInput({ disabled: false});
         $('#prcs').prop('disabled',false);
         $('#collectdate').jqxDateTimeInput({ disabled: false});
         $('#accplace').prop('disabled',false);
         $('#accfines').prop('disabled',false);
         $('#cmbclaim').prop('disabled',false);
         $('#accremarks').prop('disabled',false);
     }
     if(document.getElementById("chkaccidents").checked==false){
         document.getElementById("hidaccidents").value="0";
         $('#accdate').jqxDateTimeInput({ disabled: true});
         $('#prcs').prop('disabled',true);
         $('#collectdate').jqxDateTimeInput({ disabled: true});
         $('#accplace').prop('disabled',true);
         $('#accfines').prop('disabled',true);
         $('#cmbclaim').prop('disabled',true);
         $('#accremarks').prop('disabled',true);     
     }
 }
 function checkClaim(value){
     if(value=="1"){
         //document.getElementById("accfines").value=document.getElementById("hidinsurexcess").value;
        if(document.getElementById("hidinsurexcess").value!="" && parseFloat(document.getElementById("hidinsurexcess").value)>0){
            document.getElementById("accfines").value=document.getElementById("hidinsurexcess").value;
        }
     }
     else{
         
     }
 }
 function isNumber(evt,id) {
        //Function to restrict characters and enter number only
              var iKeyCode = (evt.which) ? evt.which : evt.keyCode
                if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
                 {
                     $.messager.alert('Warning','Enter Numbers Only');
                   $("#"+id+"").focus();
                    return false;
                    
                 }
                
                return true;
            }
 
 function funPrintBtn() {
     var value=$('#hidconfig').val();
     //alert(value);
     if(value=="1"){
         //alert($('#hidconfig').val());   rdocno
        // alert(document.getElementById("rdocno").value);
         //mobilePrintContent('mobileprintWindow.jsp?docno='+document.getElementById("docno").value+'&rfleet='+document.getElementById("rfleet").value+'&cmbreftype='+document.getElementById("cmbreftype").value+'&rdocno='+document.getElementById("rdocno").value);
         mobilePrintContent(
                   'mobileprintWindow.jsp?docno=' + document.getElementById("docno").value.trim() +
                   '&rfleet=' + document.getElementById("rfleet").value.trim() +
                   '&cmbreftype=' + document.getElementById("cmbreftype").value.trim() +
                   '&rdocno=' + document.getElementById("rdocno").value.trim()
                );
     }
     else{   
        if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
         $.messager.alert('Warning','Select a Document');
         return false;
            }
        var url=document.URL;
     var reurl=url.split("/com/");
        //var reurl=url.split("tarifMgmt.jsp");
        
        var win= window.open(reurl[0]+"/com/operations/vehicletransactions/vehicleinspection/inspectionPrint.action?docno="+document.getElementById("docno").value+"&fleetno="+document.getElementById("rfleet").value+"&lblurl="+window.location.origin,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            //var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
        
     }
     }

 function mobilePrintContent(url) {
        $('#printWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#printWindow').jqxWindow('setContent', data);
        $('#printWindow').jqxWindow('bringToFront');
    }); 
    } 
 function opensnapshotWindow()
 {
    /* var Pic = document.getElementById("canvas").toDataURL("image/png");
    Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, ""); */
    //alert(Pic);
    
    document.getElementById("canvasdet").value=1;
    $("#imagediv").prop("hidden", true); 
         $("#canvasdiv").prop("hidden", false);
    
    var url=document.URL;
      var reurl=url.split("vehicleInspection");
     
      window.open("snapshot.jsp", "Camera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
      
      
 }


 function downloadCanvas(link) {
    var formname=document.getElementById("formdetailcode").value;
    var docno=document.getElementById("docno").value;
    var filename=formname+"_"+docno;
      link.href = document.getElementById("canvas").toDataURL();
      link.download =filename;
 }


 function saveViaAJAX(row)
 {
    
    
     var formname=document.getElementById("formdetailcode").value;
     var docno=document.getElementById("docno").value;

     if(docno==""){
         document.getElementById("errormsg").innerText="Please Select a Document Number";
         return false;
     }
    var testCanvas = document.getElementById("canvas");  
    var canvasData = testCanvas.toDataURL("image/png");
    var postData = "canvasData="+canvasData;
    
    var ajax = new XMLHttpRequest();
    ajax.open("POST",'saveImage.jsp?formname='+formname+'&docno='+docno+'&srno='+row,true);    
    ajax.setRequestHeader('Content-Type', 'canvas/upload');
    
    ajax.onreadystatechange=function()
        {
        if (ajax.readyState == 4)
        { 
            document.getElementById("savemsg").innerText="Successfully Attached";
            document.getElementById("filedet").value=0;
            document.getElementById("canvasdet").value=0;
              $.messager.alert('Message',"Successfully Attached");
            $('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
            //alert(ajax.responseText);
            // Write out the filename.
            
        }
        }

    ajax.send(postData);  
 }
  
 </script>
        
            <script>
        
        (function ( $width, $height, $file) {
            
            // (C) WebReflection Mit Style License
            
            // simple FileReader detection
            
            
            // async callback, received the
            // base 64 encoded resampled image
            function resampled(data) {
                //$message.innerHTML = "done";
                
            /* ($img.lastChild || $img.appendChild(new Image)
                ).src = data; */
                document.getElementById("data").value=data;
                /* var img = document.getElementById('imgid').src;

                alert(img.getAttribute('src')); // foo.jpg
                alert(img.src); */
                
                /* document.getElementById('imgid').src=data; */
                
                var imgid = new Image();
                imgid.src =data;
                
                var temp_paint = $('#canvasid');
                var temp_ctx = temp_paint[0].getContext('2d');
                
                  //var img = document.getElementById('imgid').src;
                //alert(img);
                 document.getElementById("errormsg").innerText=" ";
                  temp_ctx.drawImage(imgid, 0, 0,640, 480);
              
            }
            
            // async callback, fired when the image
            // file has been loaded
            function load(e) {
                //$message.innerHTML = "resampling ...";
                // see resample.js
                Resample(
                        this.result,
                        this._width || null,
                        this._height || null,
                        resampled
                );
                
            }
            
            // async callback, fired if the operation
            // is aborted ( for whatever reason )
            function abort(e) {
                //$message.innerHTML = "operation aborted";
            }
            
            // async callback, fired
            // if an error occur (i.e. security)
            function error(e) {
                //$message.innerHTML = "Error: " + (this.result || e);
            }
            
            // listener for the input@file onchange
            $file.addEventListener("change", function change() {
                var
                    // retrieve the width in pixel
                    width = parseInt($width.value, 10),
                    // retrieve the height in pixels
                    height = parseInt($height.value, 10),
                    // temporary variable, different purposes
                    file
                ;
                // no width and height specified
                // or both are NaN
                if (!width && !height) {
                    // reset the input simply swapping it
                    $file.parentNode.replaceChild(
                        file = $file.cloneNode(false),
                        $file
                    );
                    // remove the listener to avoid leaks, if any
                    $file.removeEventListener("change", change, false);
                    // reassign the $file DOM pointer
                    // with the new input text and
                    // add the change listener
                    ($file = file).addEventListener("change", change, false);
                    // notify user there was something wrong
                    //$message.innerHTML = "please specify width or height";
                } else if(
                    // there is a files property
                    // and this has a length greater than 0
                    ($file.files || []).length &&
                    // the first file in this list 
                    // has an image type, hopefully
                    // compatible with canvas and drawImage
                    // not strictly filtered in this example
                    /^image\//.test((file = $file.files[0]).type)
                ) {
                    // reading action notification
                    //$message.innerHTML = "reading ...";
                    // create a new object
                    file = new FileReader;
                    // assign directly events
                    // as example, Chrome does not
                    // inherit EventTarget yet
                    // so addEventListener won't
                    // work as expected
                    file.onload = load;
                    file.onabort = abort;
                    file.onerror = error;
                    // cheap and easy place to store
                    // desired width and/or height
                    file._width = width;
                    file._height = height;
                    // time to read as base 64 encoded
                    // data te selected image
                    file.readAsDataURL($file.files[0]);
                    // it will notify onload when finished
                    // An onprogress listener could be added
                    // as well, not in this demo tho (I am lazy)
                } else if (file) {
                    // if file variable has been created
                    // during precedent checks, there is a file
                    // but the type is not the expected one
                    // wrong file type notification
                    //$message.innerHTML = "please chose an image";
                } else {
                    // no file selected ... or no files at all
                    // there is really nothing to do here ...
                    //$message.innerHTML = "nothing to do";
                }
            }, false);
        }(
        
            // all required fields ...
            document.getElementById("width"),
            document.getElementById("height"),
            document.getElementById("file")
        ));
        
        function loading(){
             
            var path=document.getElementById("file").value;
             var fsize = $('#file')[0].files[0].size;
             //alert(fsize);
             var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
            
             if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
               {
                 
                 if(fsize>1048576)
                     {
                     //document.getElementById("errormsg").innerText="Please Wait......";
                     }
                 
               }
        }
        
        function getConfig() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    
                        $('#hidconfig').val(items);
                    
                } else {
                }
            }
            x.open("GET", "getConfig.jsp", true);
            x.send();
        }
        
             </script>
</head>
<body onload="setValues();getConfig();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmVehicleInspection" action="saveVehicleInspection" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<script>
            window.parent.formName.value="Vehicle Inspection";
            window.parent.formCode.value="VIP";
    </script>

    <div id="formdet"></div>

    <div class="receipt-header">
        <label>Date</label>
        <div>
            <div id="date" name="date" value='<s:property value="date"/>'></div>
            <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
        </div>

        <label>Time</label>
        <div>
            <div id="time" name="time"  value='<s:property value="date"/>'></div>
            <input type="hidden" name="hidtime" id="hidtime" value='<s:property value="hidtime"/>'>
        </div>

        <label>Type</label>
        <select name="cmbtype" id="cmbtype">
            <option value="">--Select--</option><option value="IN">IN</option><option value="OUT">OUT</option>
        </select>
        <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>

        <label>Ref Type</label>
        <select name="cmbreftype" id="cmbreftype" onchange="funResetValues();">
            <option value="">--Select--</option>
            <option value="RAG">Rental</option>
            <option value="LAG">Lease</option>
            <option value="RPL">Replacement</option>
            <option value="NRM">Non Revenue  Movement</option>
        </select>
        <input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'>

        <label>Branch</label>
        <select name="cmbagmtbranch" id="cmbagmtbranch" onChange="funResetValues();" value='<s:property value="cmbagmtbranch"/>'>
            <option value="">--Select--</option>
        </select>
        <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch"/>'>

        <label>Doc No</label>
        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
    </div>

    <div class="section-block" style="margin-bottom: 20px;">
        <h2>Vehicle Details</h2>
        <div class="form-group dual-input">
            <label>Ref Doc No</label>
            <input type="text" name="refvoucherno" id="refvoucherno" value='<s:property value="refvoucherno"/>' readonly placeholder="Press F3 to Search" onKeyDown="getDoc(event);">
            
            <label>Ref Fleet No</label>
            <input type="text" name="rfleet" id="rfleet" value='<s:property value="rfleet"/>' readonly>
        </div>
        <div class="form-group dual-input">
            <label>Reg No</label>
            <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' readonly>
            
            <label>Client</label>
            <input type="text" name="client" id="client" value='<s:property value="client"/>' readonly>
        </div>
    </div>

    <div class="section-row">
        <div class="section-block">
            <h2>Existing Damage</h2>
            <div id="existingdiv">
                <jsp:include page="existingGrid.jsp"></jsp:include> 
            </div>
        </div>

        <div class="section-block" style="text-align: center;">
            <h2>Visual Evidence</h2>
            
            <div id="canvasdiv"><p><canvas id="canvas"  height="240" width="320"></canvas></p><ul id="cams"></ul></div>
            <div id="imagediv"><img id="prevImage" src="<%=contextPath%>/icons/gatewaybg.png" alt="Image" height="240" width="320"/></div>
            
            <input type="hidden" name="canvasdet" id="canvasdet"  value='<s:property value="canvasdet"/>'>
            <input type="hidden" name="filedet" id="filedet"  value='<s:property value="filedet"/>'>
            
            <div style="margin-top: 15px;">
                <a id="download" href="" style="margin-right: 10px;">
                    <button id="icons" title="Save Image" type="button"> <img alt="Download File" src="<%=contextPath%>/icons/isave.png"></button>
                </a>
                <button id="icons" title="SnapShot" type="button" onclick="opensnapshotWindow()">
                    <img alt="SnapShot" src="<%=contextPath%>/icons/snapshot.png"> 
                </button>
            </div>
        </div>
    </div>

    <div class="section-block" style="margin-bottom: 20px;">
        <h2>New Damage</h2>
        <div id="newdiv">
            <jsp:include page="newgrid.jsp"></jsp:include>
        </div>
        
        <div class="form-group" style="margin-top: 10px; grid-template-columns: 280px 1fr;">
            <label>Damage Charges (No Police Report)</label>
            <input type="text" name="amount" id="amount" value='<s:property value="amount"/>' style="text-align:right; width: 150px;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
        </div>
    </div>

    <div class="section-block" style="margin-bottom: 20px;">
        <h2>
            <input type="checkbox" name="chkaccidents" id="chkaccidents" value='<s:property value="chkaccidents"/>' onchange="enableAccData();">
            Accidents <span style="font-weight:400; font-size: 0.9em; margin-left: 10px;">(Considered only with Police Report)</span>
        </h2>
        
        <div class="form-group triple-input">
            <label>Date</label>
            <div>
                <div id="accdate" name="accdate" value='<s:property value="accdate"/>'></div>
                <input type="hidden" name="hidaccdate" id="hidaccdate" value='<s:property value="hidaccdate"/>'>
            </div>

            <label>Police Report</label>
            <input type="text" name="prcs" id="prcs" value='<s:property value="prcs"/>'>

            <label>Collection Date</label>
            <div>
                <div id="collectdate" name="collectdate" value='<s:property value="collectdate"/>'></div>
                <input type="hidden" name="hidcollectdate" id="hidcollectdate" value='<s:property value="hidcollectdate"/>'>
            </div>
        </div>

        <div class="form-group triple-input">
            <label>Place</label>
            <input type="text" name="accplace" id="accplace" value='<s:property value="accplace"/>'>

            <label>Claim</label>
            <select name="cmbclaim" id="cmbclaim" onchange="checkClaim(this.value);">
                <option value="">--Select--</option>
                <option value=1>Own</option>
                <option value=0>Third Party</option>
            </select>
            <input type="hidden" name="hidcmbclaim" id="hidcmbclaim" value='<s:property value="hidcmbclaim"/>'>

            <label>Ins Excess</label>
            <input type="text" name="accfines" id="accfines" value='<s:property value="accfines"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
        </div>

        <div class="form-group">
            <label>Remarks</label>
            <input type="text" name="accremarks" id="accremarks" value='<s:property value="accremarks"/>'>
        </div>
    </div>

    <div class="section-row">
        <div class="section-block">
            <h2>Existing Complaints</h2>
            <div id="existmaintenancediv">
                <jsp:include page="existmaintenanceGrid.jsp"></jsp:include>
            </div>
        </div>

        <div class="section-block">
            <h2>New Complaints</h2>
            <div id="newmaintenancediv">
                <jsp:include page="newmaintenanceGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="damagegridlength" id="damagegridlength" value='<s:property value="damagegridlength"/>'>
<input type="hidden" name="existdamagegridlength" id="existdamagegridlength" value='<s:property value="existdamagegridlength"/>'>
<input type="hidden" name="maintenancegridlength" id="maintenancegridlength" value='<s:property value="maintenancelength"/>'>
<input type="hidden" name="hidaccidents" id="hidaccidents" value='<s:property value="hidaccidents"/>'>
<input type="hidden" name="hidinsurexcess" id="hidinsurexcess" value='<s:property value="hidinsurexcess"/>'>
<input type="hidden" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>' readonly placeholder="Press F3 to Search" onkeydown="getDoc(event);">
<input type="hidden" name="docdatestatus" id="docdatestatus" value='<s:property value="docdatestatus"/>' >
<input type="hidden" name="hidconfig" id="hidconfig" value='<s:property value="hidconfig"/>' >

<div id="docwindow">
   <div ></div>
</div>
<div id="damagewindow">
   <div></div>
</div>

<div id="maintenancewindow">
   <div></div>
</div>
<div id="printWindow">
	<div></div><div></div>
</div> 	
</form>
</div>
</body>
</html>