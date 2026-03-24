
<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

input[type="text"], select, textarea {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 100%;
}

textarea {
    height: auto !important;
    min-height: 60px;
}

input[type="text"]:focus, select:focus, textarea:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important;
    max-height: none !important;
    padding: 10px;
}

.tarif-action-btn {
    border: none;
    background: none;
    cursor: pointer;
    transition: transform 0.2s;
}

.tarif-action-btn:hover {
    transform: scale(1.1);
}
body::-webkit-scrollbar {
	width: 0px;
}
.myButton {
 font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
</style>

<script type="text/javascript">
	$(document).ready(function () { 
    	getTariftype();
    	getcheckbox();
     	setCheck();
    	/* Date */
    	document.getElementById("fieldextrainsur").style.display="none";
    	document.getElementById("grouplabel").style.display="none";
		document.getElementById("txtclient").disabled="true";
    	$("#jqxTariffDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#jqxTariffFromDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#jqxTariffToDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	document.getElementById("btnTarifEdit").style.display="none";

		$('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#clienttarifwindow').jqxWindow('close');
		//$('#frmTariffManagement select').attr('disabled', false );
		selectTarif();
		//$('#frmTariffManagement select').attr('disabled', true );
	    $('#txtclient').dblclick(function(){
			$('#clienttarifwindow').jqxWindow('open');
			$('#clienttarifwindow').jqxWindow('focus');
		 	clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
		});
	     
	});
    
    function clientSearchContent(url) {
		$.get(url).done(function (data) {
  	    	$('#clienttarifwindow').jqxWindow('setContent', data);
  		}); 
  	}
      
    function getClient(event){
  		var x= event.keyCode;
        if(x==114){
        	$('#clienttarifwindow').jqxWindow('open');
       		$('#clienttarifwindow').jqxWindow('focus');
       		clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
        }
        else{
        }
    }
    function selectTarif(){
    	$('#frmTariffManagement select').attr('disabled',false );
  		var temp=document.getElementById("cmbtariftype").value;
  		// $('#frmTariffManagement select').attr('disabled',true );
  		// if(document.getElementById("mode").value=='A'){
  		$("#divRegularTarif").load("gridRegularTarif.jsp");
        $("#divfoc").load("gridFoc.jsp");
        $("#divweekday").load("gridWeekday.jsp");
        $("#divslab").load("gridSlabTarif.jsp");
        $("#divpackage").load("gridPackageTarif.jsp");
        $("#divgroup1").load("gridgroup1.jsp");
      	$("#divgroup2").load("gridgroup2.jsp");
  	//	 }
  		 
  		/* if(temp=="Condition"){
  			//alert("Inside condition");
  			
			document.getElementById("fieldfoc").style.display="block";
    	  	document.getElementById("fieldweekday").style.display="block";
  			$('#txtclient').attr('disabled', true );
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: false});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else */ 
  		if(temp=="Client"){
  			document.getElementById("fieldextrainsur").style.display="none";
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  		else if(temp=="Corporate"){
  			document.getElementById("fieldextrainsur").style.display="none";
  			$('#txtclient').attr('disabled', false );
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldpackage").style.display="none";
  			document.getElementById("fieldslab").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldregular").style.display="block";
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  		
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			}	
  		}
  		else if(temp=="Weekend"){
  			$('#txtclient').attr('disabled', true );
  			document.getElementById("fieldextrainsur").style.display="none";
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldregular").style.display="none";
  			document.getElementById("fieldpackage").style.display="none";
  			document.getElementById("fieldslab").style.display="none";
  			document.getElementById("fieldweekday").style.display="block";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  		
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			}
  			
  		}
  		else if(temp=="FOC"){
  			$('#txtclient').attr('disabled', true );
  			document.getElementById("fieldextrainsur").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldfoc").style.display="block";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else if(temp=="Slab"){
  			$('#txtclient').attr('disabled', true );
  			document.getElementById("fieldextrainsur").style.display="none";
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldregular").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldpackage").style.display="none";
  			document.getElementById("fieldslab").style.display="block";
  			$("#jqxslabtarif").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  		
  			$("#jqxslabtarif").jqxGrid({ disabled: true});
  			}
  		}
  		else if(temp=="Package"){
  			$('#txtclient').attr('disabled', true );
  			document.getElementById("fieldextrainsur").style.display="none";
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldregular").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldslab").style.display="none";
  			document.getElementById("fieldpackage").style.display="block";
  			$("#jqxpackagetarif").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  		
  			$("#jqxpackagetarif").jqxGrid({ disabled: true});
  			}
  		}
  		else{
  			$('#txtclient').attr('disabled', true );
  			document.getElementById("fieldextrainsur").style.display="block";
  			document.getElementById("fieldfoc").style.display="none";
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldpackage").style.display="none";
  			document.getElementById("fieldslab").style.display="none";
  			document.getElementById("fieldregular").style.display="block";
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  		if(document.getElementById("mode").value=='A'){
  		
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			}
  	} 
      }
	function funReset(){
    	
    		
    	}
		
    	function funReadOnly(){
    		$('#frmTariffManagement input').attr('readonly', true );
			$('#frmTariffManagement select').attr('disabled', true );
			$('#frmTariffManagement textarea').attr('readonly', true );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
    		
    	    		
    		$("#jqxgridtarif").jqxGrid({ disabled: true});
    		//$("#jqxgridtarifgrp").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: true});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
    		
			
    		
    	} 
    	
    	function funRemoveReadOnly(){
    		
    		$('#frmTariffManagement input').attr('readonly', false );
			$('#frmTariffManagement select').attr('disabled', false );
			$('#frmTariffManagement textarea').attr('readonly', false );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxgridtarif").jqxGrid({ disabled: false});
    		//$("#jqxgridtarifgrp").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: false});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		
    		
    		if(document.getElementById("mode").value=='A'){
    			$("#divRegularTarif").load("gridRegularTarif.jsp");
             	 $("#divfoc").load("gridFoc.jsp");
             	 $("#divweekday").load("gridWeekday.jsp");
             	 $("#divslab").load("gridSlabTarif.jsp");
             	 $("#divpackage").load("gridPackageTarif.jsp");
          		 $("#divgroup1").load("gridgroup1.jsp");
          		 $("#divgroup2").load("gridgroup2.jsp");
          		 document.getElementById("grouplabel").style.display="none";
          		 document.getElementById("btnTarifEdit").style.display="none";
          		document.getElementById("btnTarifSave").style.display="none";
          		 $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());
          		
          		 document.getElementById("fieldfoc").style.display="none";
	        	  document.getElementById("fieldweekday").style.display="none";	
	        	  
	        	  document.getElementById("fieldslab").style.display="none";
	        	  document.getElementById("fieldpackage").style.display="none";
	       	  document.getElementById("fieldregular").style.display="block";
	       	 document.getElementById("fieldextrainsur").style.display="block";
    		}
    		
    		if(document.getElementById("mode").value=='E'){
    			$('#cmbtariftype').attr('disabled', 'disabled');
    			$('#txtclient').attr('disabled', true );
    			$('#cmbtariffor').attr('disabled', 'disabled');
    		}
    		if(document.getElementById("mode").value=='D'){
    			$("#divRegularTarif").load("gridRegularTarif.jsp");
            	 $("#divfoc").load("gridFoc.jsp");
            	 $("#divweekday").load("gridWeekday.jsp");
            	 $("#divslab").load("gridSlabTarif.jsp");
            	 $("#divpackage").load("gridPackageTarif.jsp");
         		 $("#divgroup1").load("gridgroup1.jsp");
         		 $("#divgroup2").load("gridgroup2.jsp");
    		}
    	}
    	
    	function funNotify(){	
    			if(document.getElementById("docno").value!=''){
    			
    				if(document.getElementById("cmbtariftype").value=='Regular' || document.getElementById("cmbtariftype").value=='Corporate'  || document.getElementById("cmbtariftype").value=='Agent'){	
    	var rows = $("#jqxgridtarif").jqxGrid('getrows');
		$('#gridlength').val(rows.length);
    		//alert($('#gridlength').val());
    		for(var i=0 ; i < rows.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
				
			newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
		}
    				else if(document.getElementById("cmbtariftype").value=='Weekend'){
    		var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
    		
    		var j=0;
    		
    		
    		for(var i=0 ; i < rowsweekday.length ; i++){

    				newTextBoxweekday = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtweekday"+i)
    			    .attr("name", "txtweekday"+i);
    			 	//alert(rowsweekday[i].cstime.getMinutes());
    			 	//alert((rowsweekday[i].cstime.getMinutes().getMinutes()<10?'0':'') + rowsweekday[i].cstime.getMinutes().getMinutes());
    				var d=new Date(rowsweekday[i].cstime);
    				
    				var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
    				//alert(tempstarttime.toString());
    				var d1=new Date(rowsweekday[i].cetime);
    				var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
    				//alert(tempendtime.toString());
    				if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
    						typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
    					newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
    				j++;
    				newTextBoxweekday.appendTo('form');
    				}
    				
    			
    				
    				//alert("ddddd"+$("#txtweekday"+i).val());
    			}
    		$('#weekdaylength').val(j);
    	}
    	
    		else if(document.getElementById("cmbtariftype").value=='Slab'){
    			
    			 var rowsslab = $("#jqxslabtarif").jqxGrid('getrows');
    				var z=0;
            		for(var i=0;i<rowsslab.length;i++){
            			var slabfrom=rowsslab[i].slabfromday;
    	    			var slabto=rowsslab[i].slabtoday;
    	    			var slabperday=rowsslab[i].slabrateperday;
    	    		if(slabfrom!="undefined" && slabfrom!="" && slabfrom!=null && typeof(slabfrom)!="undefined" && slabto!="undefined" && slabto!="" && slabto!=null && typeof(slabto)!="undefined" && slabperday!="undefined" && slabperday!="" && slabperday!=null && typeof(slabperday)!="undefined"){
    	    				
    	    				newTextBoxSlab = $(document.createElement("input"))
        			        .attr("type", "dil")
        			        .attr("id", "txtslab"+z)
        			        .attr("name", "txtslab"+z)
        			        .attr("hidden", "true");
    	    				newTextBoxSlab.val(rowsslab[i].rentaltype="Slab "+(z+1)+"::"+rowsslab[i].slabfromday+"::"+rowsslab[i].slabtoday+"::"+rowsslab[i].slabrateperday+"::"+rowsslab[i].cdw+"::"+rowsslab[i].pai+"::"+rowsslab[i].cdw1+"::"+rowsslab[i].pai1+"::"+rowsslab[i].gps+"::"+rowsslab[i].babyseater+"::"+rowsslab[i].cooler+"::"+rowsslab[i].exhrchg+"::"+rowsslab[i].chaufexchg+"::"+rowsslab[i].kmrest+"::"+rowsslab[i].exkmrte+"::"+rowsslab[i].oinschg);
        	    			newTextBoxSlab.appendTo('form');
    	    				z++;
    	    			}
    	    			
            		}
            		
            		$('#slablength').val(z);
            		
        	}
    		
    	
    		else if(document.getElementById("cmbtariftype").value=='Package'){
    			
    			var rowspackage = $("#jqxpackagetarif").jqxGrid('getrows');
        	  	var z=0;
            		for(var i=0 ; i < rowspackage.length ; i++){
            			var packageday=rowspackage[i].packageblockday;
    	    			var packagetarif=rowspackage[i].packageblocktarif;
    	    			var packageextarif=rowspackage[i].packageextradaytarif;
    	    		if(packageday!="undefined" && packageday!="" && packageday!=null && typeof(packageday)!="undefined" && packagetarif!="undefined" && packagetarif!="" && packagetarif!=null && typeof(packagetarif)!="undefined" && packageextarif!="undefined" && packageextarif!="" && packageextarif!=null && typeof(packageextarif)!="undefined"){
    	    			
        				newTextBoxPackage = $(document.createElement("input"))
        			    .attr("type", "dil")
        			    .attr("id", "txtpackage"+z)
        			    .attr("name", "txtpackage"+z)
        				.attr("hidden", "true");
        				newTextBoxPackage.val(rowspackage[i].rentaltype="Package "+(z+1)+"::"+rowspackage[i].packageblockday+"::"+rowspackage[i].packageblocktarif+"::"+rowspackage[i].packageextradaytarif+"::"+rowspackage[i].cdw+"::"+rowspackage[i].pai+"::"+rowspackage[i].cdw1+"::"+rowspackage[i].pai1+"::"+rowspackage[i].gps+"::"+rowspackage[i].babyseater+"::"+rowspackage[i].cooler+"::"+rowspackage[i].exhrchg+"::"+rowspackage[i].chaufexchg+"::"+rowspackage[i].kmrest+"::"+rowspackage[i].exkmrte+"::"+rowspackage[i].oinschg);
        			
        				newTextBoxPackage.appendTo('form');
        				z++;
    	    		}
        			}
           		
           		$('#packagelength').val(z);
           		
       	}			
    				
    	
    				else if(document.getElementById("cmbtariftype").value=='FOC'){
    		var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
    		

    		$('#foclength').val(rowsfoc.length);
    		for(var i=0 ; i < rowsfoc.length ; i++){
    
    				newTextBoxfoc = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtfoc"+i)
    			    .attr("name", "txtfoc"+i);
    				
    				newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
    			
    				newTextBoxfoc.appendTo('form');
    				//alert("ddddd"+$("#txtfoc"+i).val());
    			}
    		
    	}
    		
    		var a=document.getElementById("gridlength").value;
			var b=document.getElementById("weekdaylength").value;
			var c=document.getElementById("foclength").value;
			var d=document.getElementById("fuellength").value;
			var e=document.getElementById("slablength").value;
			var f=document.getElementById("packagelength").value;
			//alert("Regular:"+a+"Weekday:"+b+"FOC:"+c+"Fuel"+d);
    			}
    			$('#frmTariffManagement select').attr('disabled',false);
    			$('#txtclient').attr('disabled',false);
			return 1;
			$('#frmTariffManagement select').attr('disabled',true);
    		
 	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

    	function funSearchLoad(){
    		changeContent('tarifSearch.jsp', $('#window')); 
    	}
    		
     	function funFocus(){
    	   	$('#jqxTariffDate').jqxDateTimeInput('focus'); 	    		
     	}
		function setCheck(){
			if(document.getElementById("chckdeliverychg").checked==true){
				document.getElementById("hidcheck").value=1;
			}
			else
				document.getElementById("hidcheck").value=0;
		}
		function getcheckbox(){
			if(document.getElementById("hidcheck").value==1){
				document.getElementById("chckdeliverychg").checked=true;
			}
			else{
				document.getElementById("chckdeliverychg").unchecked=true;
			}
		}
		function setValues(){
				
			if(document.getElementById("mode").value=='view'){
	  			$("#divRegularTarif").load("gridRegularTarif.jsp");
	        	 $("#divfoc").load("gridFoc.jsp");
	        	 $("#divweekday").load("gridWeekday.jsp");
	        	 $("#divslab").load("gridSlabTarif.jsp");
	        	 $("#divpackage").load("gridPackageTarif.jsp");
	        	 $("#divgroup1").load("gridgroup1.jsp");
	      		 $("#divgroup2").load("gridgroup2.jsp");
	  		 }
		document.getElementById("cmbtariftype").disabled=false;
			
		//	document.getElementById("fieldextrainsur").style.display="none";
			/* if(document.getElementById("cmbtariftype").value=="Weekend"){
				document.getElementById("fieldweekday").style.display="block";
	  			document.getElementById("fieldfoc").style.display="none";
			}
			if(document.getElementById("cmbtariftype").value=="FOC"){
				document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldfoc").style.display="block";
			} */
			
			if(document.getElementById("hidcmbtariftype").value=="Regular"){
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldregular").style.display="block";
	  			document.getElementById("fieldextrainsur").style.display="block";
			}
			else if(document.getElementById("hidcmbtariftype").value=="Corporate"){
				
				document.getElementById("fieldextrainsur").style.display="none";
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldregular").style.display="block";
			}
			else if(document.getElementById("hidcmbtariftype").value=="Weekend"){
				document.getElementById("fieldextrainsur").style.display="none";
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldregular").style.display="none";
	  			document.getElementById("fieldweekday").style.display="block";
			}
			else if(document.getElementById("hidcmbtariftype").value=="Slab"){
				document.getElementById("fieldextrainsur").style.display="none";
				document.getElementById("fieldslab").style.display="block";
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldregular").style.display="none";
	  			
			}
			else if(document.getElementById("hidcmbtariftype").value=="Package"){
				document.getElementById("fieldextrainsur").style.display="none";
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldregular").style.display="none";
	  			document.getElementById("fieldpackage").style.display="block";
			}
			else if(document.getElementById("hidcmbtariftype").value=="FOC"){
				document.getElementById("fieldextrainsur").style.display="none";
				
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldregular").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldfoc").style.display="block";
			} 
			else if(document.getElementById("hidcmbtariftype").value=="Agent"){
				document.getElementById("fieldfoc").style.display="none";
	  			document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldpackage").style.display="none";
	  			document.getElementById("fieldslab").style.display="none";
	  			document.getElementById("fieldregular").style.display="block";
	  			document.getElementById("fieldextrainsur").style.display="block";
			}
			//alert("CMB"+document.getElementById("hidcmbtariftype").value);
			if(document.getElementById("docno")!=''){
				var temp=document.getElementById("docno").value;
				$("#divgroup2").load("gridgroup2.jsp?id="+temp);
				$("#divgroup1").load("gridgroup1.jsp?id="+temp);
			}
			 if ($('#hidcmbtariftype').val() != null) {
					$('#cmbtariftype').val($('#hidcmbtariftype').val());
			 }
			if ($('#hidcmbtariffor').val() != null) {
				$('#cmbtariffor').val($('#hidcmbtariffor').val());
			}
			if($('#hidjqxTariffDate').val()){
				$("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
			}
			if($('#hidjqxTariffFromDate').val()){
				$("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
			}
			if($('#hidjqxTariffToDate').val()){
				$("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
			}
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
if(document.getElementById("docno").value==''){
	document.getElementById("btnTarifEdit").style.display="none";
}


document.getElementById("cmbtariftype").disabled=true;

		}
		 function funTarifEdit(){
		 	 document.getElementById("cmbtariftype").disabled=false;
		 	$("#jqxgridtarifgrp").jqxGrid({ disabled:false});
		 	document.getElementById("insurexcess").readOnly=false;
		 	document.getElementById("cdwexcess").readOnly=false;
		 	document.getElementById("scdwexcess").readOnly=false;
		 	document.getElementById("securityamt").readOnly=false;
				/* if(document.getElementById("cmbtariftype").value=="Condition"){
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	        		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	        		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});

	    		} */
	    		if(document.getElementById("cmbtariftype").value=="Weekend"){
	    				    			
	    			 $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="Slab"){
	    			 $("#jqxslabtarif").jqxGrid({ disabled: false});
	    	 	
	    			 var rows = $('#jqxslabtarif').jqxGrid('getrows');
	                 var rowlength= rows.length;
	                 var slabval = $("#jqxslabtarif").jqxGrid('getcellvalue', rowlength-1, 'slabrateperday');
	                 if(slabval!="undefined" && slabval!="" && slabval!=null && typeof(slabval)!="undefined")
	                	 {
	                            $("#jqxslabtarif").jqxGrid('addrow', null, {});
	                            rowlength++;
	                            $("#jqxslabtarif").jqxGrid('setcellvalue',rowlength-1,'rentaltype','Slab '+rowlength);
	                	 }
	    		
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="Package"){
	    			
	    			 $("#jqxpackagetarif").jqxGrid({ disabled: false});
	    			 var rows1 = $('#jqxpackagetarif').jqxGrid('getrows');
	                 var rowlengthpack= rows1.length;
	                 var packval = $("#jqxpackagetarif").jqxGrid('getcellvalue', rowlengthpack-1, 'packageextradaytarif');
	                 if(packval!="undefined" && packval!="" && packval!=null && typeof(packval)!="undefined")
	                	 {
	                            $("#jqxpackagetarif").jqxGrid('addrow', null, {});
	                            rowlengthpack++;
	                        $("#jqxpackagetarif").jqxGrid('setcellvalue',rowlengthpack-1,'rentaltype','Package '+rowlengthpack);
	    		 }
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="FOC"){
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	    				 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else{
	    			$("#jqxgridtarif").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			
	    		}
		/*  alert("CMB"+document.getElementById("hidcmbtariftype").value);
		
    		$("#jqxgridtarifgrp").jqxGrid({ disabled: false});
    		$("#jqxgridtarifdelivery").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		$('#frmTariffManagement select').attr('disabled', false); */
    	
		 	document.getElementById("cmbtariftype").disabled=true;
		}  
		 function funTarifSave(){
			 document.getElementById("cmbtariftype").disabled=false;
			 if(document.getElementById("cmbtariftype").value=="Weekend"){
	
				 var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
	
				 if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
			
					 document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Tariff is Mandatory";
		    			return false;
		    		}
			 }
			if(document.getElementById("docno").value!=""){
				 document.getElementById("mode").value="A";
				 $('#btnSave').mousedown();	 
			 }
			 else{
				 $.messager.alert('Warning','Please Select a Valid Document');
				 return false;
			 }
			// document.getElementById("btnTarifSave").disabled=true;
			 document.getElementById("cmbtariftype").disabled=true;
		 }
		  function isNumber(evt,id) {
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
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   		}
	   		var url=document.URL;
	   	 var reurl=url.split("com/");
	   	  	//var reurl=url.split("tarifMgmt.jsp");

	   	   	var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   	    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();  


	   	 }
		
		function getTariftype(){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items=items.split("***");
					var tarifitems = items[0].split(",");
					var status=items[1];				
					var optionstarif = '<option value="">--Select--</option>';
					for (var i = 0; i < tarifitems.length; i++) {
						optionstarif += '<option value="' + tarifitems[i] + '">'
								+ tarifitems[i] + '</option>';
					}
					$("select#cmbtariftype").html(optionstarif);
				 	 if ($('#hidcmbtariftype').val() != null) {
						$('#cmbtariftype').val($('#hidcmbtariftype').val());
					}
				 	/*  if(status.trim()=="1"){
			    		  document.getElementById("fieldfoc").style.display="block";
			        	  document.getElementById("fieldweekday").style.display="block";
			    	  }
			    	  else{
			    		  document.getElementById("fieldfoc").style.display="none";
			        	  document.getElementById("fieldweekday").style.display="none";	  
			    	  }   */
				 	 /*  document.getElementById("fieldfoc").style.display="none";
		        	  document.getElementById("fieldweekday").style.display="none";	
		        	  
		        	  document.getElementById("fieldslab").style.display="none";
		        	  document.getElementById("fieldpackage").style.display="none";
		       	  document.getElementById("fieldregular").style.display="block"; */
		        	 
		        	  
		        	  
				}
			}
			x.open("GET", "getTariftype.jsp", true);
			x.send();
		}
		
</script>

</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmTariffManagement" action="saveTariffManagementnew" autocomplete="off">
        <script>
            window.parent.formName.value="Tariff Management";
            window.parent.formCode.value="TFM";
        </script>
        <jsp:include page="../../../../header.jsp" />
      <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">

 
    <div style="display:flex; align-items:center; gap:8px;">
        <label>Date</label>
        <div id="jqxTariffDate"
             name="jqxTariffDate"
             value='<s:property value="jqxTariffDate"/>'
             style="width:120px;">
        </div>
    </div>

  
    <div style="display:flex; align-items:center; gap:8px;">
        <label>Doc No</label>
        <input type="text"
               id="docno"
               name="docno"
               tabindex="-1"
               value='<s:property value="docno"/>'
               style="width:120px;">
    </div>

</div>   
        <br/>

        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>General Information</h2>
                <div class="trans-info-grid">
               
                    
                    <label>Tariff Type</label>
                    <div style="display: flex; gap: 8px;">
                        <select id="cmbtariftype" name="cmbtariftype" onchange="selectTarif();" value='<s:property value="cmbtariftype"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="text" name="txtclient" id="txtclient" placeholder="F3 for Client" value='<s:property value="txtclient"/>' onkeydown="getClient(event);">
                    </div>

                    <label>Tariff For</label>
                    <select id="cmbtariffor" name="cmbtariffor" value='<s:property value="cmbtariffor"/>'>
                        <option value="">--Select--</option>
                        <option value="Vehicle">Vehicle</option>
                    </select>

                   

                    <label>Validity From</label>
                    <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div>

                    <label>Validity To</label>
                    <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div>

                    <div style="grid-column: span 2; display: flex; align-items: center; gap: 10px;">
                        <input type="checkbox" id="chckdeliverychg" name="chckdeliverychg" onchange="setCheck();">
                        <label for="chckdeliverychg">Delivery Charge</label>
                    </div>
                </div>

                <div class="agmt-info-grid" style="margin-top: 15px;">
                    <label>Notes</label>
                    <div style="display: flex; gap: 15px; align-items: flex-start;">
                        <textarea id="notes" name="notes"><s:property value="notes"/></textarea>
                        <div style="display: flex; flex-direction: column; gap: 5px;">
                            <button type="button" id="btnTarifEdit" class="tarif-action-btn" title="Tarif Edit" onclick="funTarifEdit();">
                                <img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
                            </button>
                            <button type="button" id="btnTarifSave" class="tarif-action-btn" title="Tarif Save" hidden="true" onclick="funTarifSave();">
                                <img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <center><label id="grouplabel" style="color:red;font-weight:bold;"></label></center>

            <div style="display: flex; gap: 20px; align-items: flex-start;">
                <div style="width: 250px;">
                    <div class="section-block">
                        <h2>Groups</h2>
                        <div id="divgroup1"><jsp:include page="gridgroup1.jsp"></jsp:include></div>
                    </div>
                </div>

                <div style="flex: 1;">
                    <div class="section-block" id="fieldextrainsur">
                        <h2>Excess & Insurance Details</h2>
                        <div class="trans-info-grid">
                            <label>Security Amt</label>
                            <input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber(event,id)">
                            
                            <label>Insurance Excess</label>
                            <input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber(event,id)">
                            
                            <label>CDW Excess</label>
                            <input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber(event,id)">
                            
                            <label>Super CDW Excess</label>
                            <input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber(event,id)">
                        </div>
                    </div>

                    <div class="section-block" id="fieldregular">
                        <h2>Tariff Configuration</h2>
                        <div id="divRegularTarif"><jsp:include page="gridRegularTarif.jsp"></jsp:include></div>
                        
                        <div id="fieldweekday" style="margin-top:20px;">
                            <h2 style="font-size: 0.9rem; border-left-color: #28a745;">Week Day Tariff</h2>
                            <div id="divweekday"><jsp:include page="gridWeekday.jsp"></jsp:include></div>
                        </div>

                        <div id="fieldslab" style="margin-top:20px;">
                            <h2 style="font-size: 0.9rem; border-left-color: #fd7e14;">Slab Tariff</h2>
                            <div id="divslab"><jsp:include page="gridSlabTarif.jsp"></jsp:include></div>
                        </div>

                        <div id="fieldpackage" style="margin-top:20px;">
                            <h2 style="font-size: 0.9rem; border-left-color: #6f42c1;">Package Tariff</h2>
                            <div id="divpackage"><jsp:include page="gridPackageTarif.jsp"></jsp:include></div>
                        </div>

                        <div id="fieldfoc" style="margin-top:20px;">
                            <h2 style="font-size: 0.9rem; border-left-color: #17a2b8;">FOC Tariff</h2>
                            <div id="divfoc"><jsp:include page="gridFoc.jsp"></jsp:include></div>
                        </div>
                    </div>
                </div>

                <div style="width: 250px;">
                    <div class="section-block">
                        <h2>Sub Groups</h2>
                        <div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div>
                    </div>
                </div>
            </div>

            <input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
            <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/>
            <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/>
            <input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
            <input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
            <input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'>
            <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'>
            <input type="hidden" id="mode" name="mode"/>
            <input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
            <input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
            <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
            <input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
            <input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
            <input type="hidden" name="slablength" id="slablength" value='<s:property value="slablength"/>'>
            <input type="hidden" name="packagelength" id="packagelength" value='<s:property value="packagelength"/>'>
            <input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
            <input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
            <input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'> 
            <input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
            <input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>
            <input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'>
            <input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" name="addrow" id="addrow" value='<s:property value="addrow"/>'>
        </div>
    </form>

    <div id="clienttarifwindow"><div></div></div>

    <div hidden="true">
        <div class="section-block">
            <h2>Fuel Info</h2>
            <div id="divfuel"><jsp:include page="gridfuel.jsp"></jsp:include></div>
        </div>
    </div>
</div>

</body>
</html>
