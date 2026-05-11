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
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
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
    margin: 0 auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
input[type="text"], select, textarea {
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

textarea {
    height: auto !important; /* allow textarea to grow */
}

input[type="text"]:focus, select:focus, textarea:focus {
    border-color: #007bff;
    outline: none;
}

input[readonly], input:disabled, select:disabled, textarea:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
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
    background: #fff;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 0;
    margin-top: 15px; /* Added spacing to pull away from header */
    box-sizing: border-box;
    width: 100%;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
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

/* Specific grid layout for the Notes row */
.notes-grid {
    display: grid;
    grid-template-columns: 80px 1fr 100px;
    gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
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

form label.error {
    color: red;
    font-weight: bold;
}

.hidden-scrollbar {
    overflow: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}

.btn-icon {
    border: none;
    background: none;
    cursor: pointer;
    transition: transform 0.2s;
}
.btn-icon:hover {
    transform: scale(1.05);
}
</style>

<script type="text/javascript">
	$(document).ready(function () { 
    	getTariftype();
    	getcheckbox();
     	setCheck();
     	
    	document.getElementById("fieldextrainsur").style.display="none";
    	document.getElementById("grouplabel").style.display="none";
		document.getElementById("txtclient").disabled="true";
		
    	$("#jqxTariffDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	$("#jqxTariffFromDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	$("#jqxTariffToDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	document.getElementById("btnTarifEdit").style.display="none";
    	
    	/* Force exactly 24px styling onto JQX elements */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({
                "border": "1px solid #ccc", "border-radius": "3px", "height": "24px", "box-sizing": "border-box"
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

		$('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#clienttarifwindow').jqxWindow('close');
		
		selectTarif();
		
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
    }
    
    function selectTarif(){
    	$('#frmTariffManagement select').attr('disabled',false );
  		var temp=document.getElementById("cmbtariftype").value;
  		$("#divRegularTarif").load("gridRegularTarif.jsp");
        $("#divfoc").load("gridFoc.jsp");
        $("#divweekday").load("gridWeekday.jsp");
        $("#divslab").load("gridSlabTarif.jsp");
        $("#divpackage").load("gridPackageTarif.jsp");
        $("#divgroup1").load("gridgroup1.jsp");
      	$("#divgroup2").load("gridgroup2.jsp");
  		
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
	
	function funReset(){ }
		
    function funReadOnly(){
        $('#frmTariffManagement input').attr('readonly', true );
        $('#frmTariffManagement select').attr('disabled', true );
        $('#frmTariffManagement textarea').attr('readonly', true );
        $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
        $('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
        $('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
        $("#jqxgridtarif").jqxGrid({ disabled: true});
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
                for(var i=0 ; i < rows.length ; i++){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+i)
                    .attr("name", "test"+i);
                    
                    newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
                    newTextBox.appendTo('form');
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
                    
                    var d=new Date(rowsweekday[i].cstime);
                    var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
                    var d1=new Date(rowsweekday[i].cetime);
                    var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
                    
                    if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
                            typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
                        newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
                    j++;
                    newTextBoxweekday.appendTo('form');
                    }
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
                    }
            }
            
            var a=document.getElementById("gridlength").value;
            var b=document.getElementById("weekdaylength").value;
            var c=document.getElementById("foclength").value;
            var d=document.getElementById("fuellength").value;
            var e=document.getElementById("slablength").value;
            var f=document.getElementById("packagelength").value;
        }
        $('#frmTariffManagement select').attr('disabled',false);
        $('#txtclient').attr('disabled',false);
        return 1;
        $('#frmTariffManagement select').attr('disabled',true);
    } 

    function funChkButton() { }

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
    	    if (document.getElementById("docno").value == '' || document.getElementById("docno").value == '0') {
    	        $.messager.alert('Warning', 'Select a Document');
    	        return false;
    	    }

    	    var url = document.URL;
    	    var reurl = url.split("com/");
    	    
    	    var printUrl = reurl[0] + "com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno=" + 
    	                   document.getElementById("docno").value;

    	    var win = window.open(printUrl, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");

    	    if (win) {
    	        var checkReady = setInterval(function() {
    	            try {
    	                
    	                if (win.document && win.document.readyState === 'complete' && win.document.body.innerHTML.length > 500) {
    	                    clearInterval(checkReady);
    	                    
    	                    setTimeout(function() {
    	                        win.focus();
    	                        win.print();
    	                        
    	                        win.onafterprint = function () {
    	                            win.close();
    	                        };
    	                    }, 1500); 
    	                }
    	            } catch (e) {
    	                clearInterval(checkReady);
    	            }
    	        }, 500);
    	    } else {
    	        $.messager.alert('Message', 'Popup blocked by browser. Please allow popups for this site.', 'warning');
    	    }
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
            }
        }
        x.open("GET", "getTariftype.jsp", true);
        x.send();
    }
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent">
<form id="frmTariffManagement" action="saveTariffManagementnew" autocomplete="off">
	<script>
			window.parent.formName.value="Tariff Management";
			window.parent.formCode.value="TFM";
	</script>
	<jsp:include page="../../../../header.jsp" />
    <div style="height: 20px;"></div>

<div class='modern-ui hidden-scrollbar'>

    <div class="top-grid">
        <label>Date</label>
        <div>
            <div id='jqxTariffDate' name='jqxTariffDate' value='<s:property value="jqxTariffDate"/>'></div>
            <input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
        </div>
        
        <label>Tariff Type</label>
        <div>
            <select id="cmbtariftype" name="cmbtariftype" value='<s:property value="cmbtariftype"/>' onchange="selectTarif();" >
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/>
        </div>
        
        <label>Client</label>
        <div>
            <input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onkeydown="getClient(event);" placeholder="F3 for Client">
            <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'>
        </div>
        
        <label>Tariff For</label>
        <div>
            <select id="cmbtariffor" name="cmbtariffor" value='<s:property value="cmbtariffor"/>'>
                <option value="">--Select--</option>
                <option value="Vehicle">Vehicle</option>
            </select>
            <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/>
        </div>
        
        <label>Valid From</label>
        <div>
            <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div>
            <input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
        </div>
        
        <label>Valid To</label>
        <div>
            <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div>
            <input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
        </div>
        
        <div></div> <div class="chk-container">
            <input type="checkbox" id="chckdeliverychg" name="chckdeliverychg" onchange="setCheck();">
            <label for="chckdeliverychg" style="cursor:pointer;">Delivery Charge</label>
            <input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'>
        </div>
        
        <label>Doc No</label>
        <div>
            <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' readonly/>
        </div>
    </div>

    <div class="notes-grid">
        <label class="lbl-right">Notes</label>
        <textarea id="notes" name="notes" rows="1" style="width:100%; resize:none; font-family:Arial; font-size:12px; padding:2px 6px; border:1px solid #ccc; border-radius:3px;"><s:property value="notes"/></textarea>
        
        <div style="display:flex; justify-content: flex-end; gap:5px;">
            <button type="button" id="btnTarifEdit" title="Tarif Edit" class="btn-icon" onclick="funTarifEdit();">
                <img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="24" height="24">
            </button>
            <button type="button" id="btnTarifSave" title="Tarif Save" style="display:none;" class="btn-icon" onclick="funTarifSave();">
                <img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="24" height="24">
            </button>
        </div>
    </div>

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

<center><label id="grouplabel" style="color:red;font-weight:bold;"></label></center>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
  <tr>
    <td width="15%" valign="top" style="padding-right: 5px;">
        <div id="divgroup1"><jsp:include page="gridgroup1.jsp"></jsp:include></div>
    </td>
    <td width="70%" valign="top" align="center">
        
        <fieldset id="fieldregular" style="text-align: left;">
          <div id="divRegularTarif">
            <jsp:include page="gridRegularTarif.jsp"></jsp:include>
          </div>
        </fieldset>
        
        <fieldset id="fieldweekday" style="text-align: left; display: none;">
          <legend>Week Day Tariff</legend>
          <div id="divweekday">
            <jsp:include page="gridWeekday.jsp"></jsp:include>
          </div>
        </fieldset>
        
        <fieldset id="fieldslab" style="text-align: left; display: none;">
          <legend>Slab Tariff</legend>
          <div id="divslab">
            <jsp:include page="gridSlabTarif.jsp"></jsp:include>
          </div>
        </fieldset>
        
        <fieldset id="fieldpackage" style="text-align: left; display: none;">
          <legend>Package Tariff</legend>
          <div id="divpackage">
            <jsp:include page="gridPackageTarif.jsp"></jsp:include>
          </div>
        </fieldset>
        
        <fieldset id="fieldextrainsur" style="text-align: left; display: none;">
          <table width="100%" cellpadding="2" cellspacing="0">
            <tr>
              <td class="lbl-right" width="15%">Security Amount</td>
              <td width="10%"><input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,id)"></td>
              <td class="lbl-right" width="15%">Insurance Excess</td>
              <td width="10%"><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
              <td class="lbl-right" width="15%">CDW Excess</td>
              <td width="10%"><input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
              <td class="lbl-right" width="15%">Super CDW Excess</td>
              <td width="10%"><input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
            </tr>
          </table>
        </fieldset>
        
        <fieldset id="fieldfoc" style="text-align: left; display: none;">
          <legend>FOC Tariff</legend>
          <div id="divfoc">
            <jsp:include page="gridFoc.jsp"></jsp:include>
          </div>
        </fieldset>

    </td>
    <td width="15%" valign="top" style="padding-left: 5px;">
        <div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div>
    </td>
  </tr>
</table>

<input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'>
<input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="addrow" id="addrow" value='<s:property value="addrow"/>'>

</div>
</form>

<div id="clienttarifwindow"><div ></div></div>
<div hidden="true">
    <fieldset>
      <legend>Fuel Info</legend>
      <table width="100%">
        <tr>
          <td><div id="divfuel"><jsp:include page="gridfuel.jsp"></jsp:include></div></td>
        </tr>
      </table>
    </fieldset>
</div>

</div>
</body>
</html>