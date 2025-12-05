<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ===================== MASTER UI RESET ===================== */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Roboto, Arial, sans-serif;
    margin: 0;
    padding: 24px 0;
}

#mainBG {
    width: 1200px;
    margin: auto;
    background: #fff;
    border-radius: 14px;
    padding: 20px 26px 30px 26px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

/* ===================== HEADER BAR ===================== */
.ra-header-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 18px;
    background: #f0f4ff;
    border-radius: 10px;
    margin-bottom: 18px;
    box-shadow: 0 0 0 1px #e1e7f5;
}

.ra-header-bar h2 {
    margin: 0;
    color: #243b55;
    font-weight: 700;
    font-size: 20px;
}

.ra-actions {
    display: flex;
    gap: 10px;
}

.ra-button {
    background: #eef3fb;
    border: 1px solid #d5ddee;
    padding: 6px 16px;
    border-radius: 6px;
    color: #364b75;
    font-weight: 600;
    cursor: pointer;
}

.ra-button:hover {
    background: #dfe7f7;
}

/* ===================== SCROLL AREA ===================== */
.scroll-area {
    max-height: 75vh;
    overflow-y: auto;
    padding-right: 10px;
}

/* Hide scrollbars but keep scroll functionality */
.scroll-area::-webkit-scrollbar {
    width: 6px;
}
.scroll-area::-webkit-scrollbar-thumb {
    background: #c9d3e6;
    border-radius: 10px;
}

/* ===================== TWO COLUMN LAYOUT ===================== */
.section-two-col {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
    margin-bottom: 22px;
}

/* ===================== SECTION CARD ===================== */
.section {
    background: #f7f9fc;
    border-radius: 10px;
    padding: 16px 18px;
    box-shadow: 0 0 0 1px #e6e9f1;
}

.section-title {
    font-size: 15px;
    font-weight: 600;
    margin-bottom: 14px;
    color: #243b55;
}

/* ===================== FORM GRID ===================== */
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 14px 16px;
}

.form-item {
    display: flex;
    flex-direction: column;
}

.form-item.full {
    grid-column: 1 / -1;
}

.form-item label {
    font-size: 13px;
    margin-bottom: 4px;
    font-weight: 500;
    color: #253858;
}

/* ===================== INPUT FIELDS ===================== */
.input, select, .widget {
    height: 30px;
    border-radius: 6px;
    border: 1px solid #d1d9e6;
    padding: 4px 8px;
    font-size: 13px;
    background: #ffffff;
    box-sizing: border-box;
}

.input:focus, select:focus {
    border-color: #4b75e6;
    outline: none;
}

/* jqx widgets fix */
.jqx-widget, .jqx-input {
    height: 30px !important;
    font-size: 13px !important;
}

/* ===================== GRIDS INSIDE SECTIONS ===================== */
#divDrivGrid,
#tariffDivId,
#divpaymentGrid {
    background: #fff;
    padding: 6px;
    border-radius: 8px;
    border: 1px solid #e3e7ef;
    box-shadow: inset 0 0 0 1px #f2f4f8;
}

/* Table UI inside grids */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
}

.cr-table td, .cr-table th {
    padding: 6px 8px;
    border-bottom: 1px solid #eceef3;
    font-size: 13px;
}

.cr-table th {
    background: #f0f3fa;
    font-weight: 600;
    color: #364b75;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ===================== RESPONSIVE ===================== */
@media (max-width: 1100px) {
    .section-two-col {
        grid-template-columns: 1fr;
    }
}

/* make jqx-date div look like an input fallback */
.widget, .date-fallback {
  display: inline-block;
  min-width: 140px;
  height: 30px;
  line-height: 30px;
  padding: 4px 8px;
  border: 1px solid #d1d9e6;
  border-radius: 6px;
  background: #fff;
  box-sizing: border-box;
  font-size: 13px;
  color: #222;
  vertical-align: middle;
}

/* ensure the jqx widget stays compact when present */
.jqx-widget, .jqx-input {
  height: 30px !important;
  font-size: 13px !important;
}

/* small visual hint when fallback input is active */
.date-fallback.placeholder {
  color: #7a8698;
}
.date-input-fallback {
    width: 130px;
    height: 28px;
    border: 1px solid #ccd3e0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 13px;
    background: #fff;
    box-sizing: border-box;
}
/* Force JQX date & time fields to appear properly */
.jqx-widget,
.jqx-input,
.jqx-datetimeinput {
    width: 100% !important;
    height: 32px !important;
    font-size: 13px !important;
    box-sizing: border-box;
}

.jqx-fill-state-normal {
    border-radius: 6px !important;
}

.jqx-datetimeinput-input {
    padding: 6px 8px !important;
}



</style>

<%-- <link rel="text/css" href="../../../../vendors/select2/select2.min.css"/>
<script type="text/javascript" src="../../../../vendors/select2/select2.min.js"></script> --%>
<script type="text/javascript">   
$(document).ready(function() {
    var mth,ratehideprintchk=0;
    setOrgRegCard();
    getTax();
    setIGST();
    checkweek();
    getPriorClose();
    getConfigs();
    getprintratehideConfig();
    
    $('#printWindow').jqxWindow({width: '40%', height: '20%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#printWindow').jqxWindow('close');
    
    $('#actualclientwindow').jqxWindow({width: '62%',height: '65%',maxHeight: '85%',maxWidth: '80%', title: 'Actual Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#actualclientwindow').jqxWindow('close');
    
    
    /* create jqxMenu */
    $("#jqxMenuMore").jqxMenu({width: '40%',height: '26px',autoSizeMainItems: true});
    $("#jqxMenuMore").jqxMenu('minimize');
    $("#jqxMenuMore").css('visibility', 'visible');

    /*      Menu-minimized window */
    $('#window1').jqxWindow({
        width: '71%',
        height: '70%',
        maxHeight: '70%',
        maxWidth: '80%',
        title: 'Details',
        position: {
            x: 180,
            y: 60
        },
        theme: 'energyblue',
        showCloseButton: true,
        keyboardCloseKey: 27
    });
    $('#window1').jqxWindow('close');

    /* Date */
    $("#jqxRentalDate").jqxDateTimeInput({
        width: '120px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });
    $("#jqxDateOut").jqxDateTimeInput({
        width: '110px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });
    $("#jqxOnDate").jqxDateTimeInput({
        width: '110px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });
    $("#jqxDeliveryOut").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString: "dd.MM.yyyy",
        enableBrowserBoundsDetection: true
    });
    /* Time */
    $("#jqxTimeOut").jqxDateTimeInput({
        width: '80%',
        height: '17px',
        formatString: 'HH:mm',
        showCalendarButton: false
    });

    $("#jqxOnTime").jqxDateTimeInput({
        width: '80%',
        height: '15px',
        formatString: 'HH:mm',
        showCalendarButton: false
    });
    $("#jqxDelTimeOut").jqxDateTimeInput({
        width: '80%',
        height: '15px',
        formatString: 'HH:mm',
        showCalendarButton: false
    });

    // window

    $('#vehinfowindow').jqxWindow({
        width: '62%',
        height: '67%',
        maxHeight: '85%',
        maxWidth: '80%',
        title: 'Fleet Search',
        position: {
            x: 250,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#vehinfowindow').jqxWindow('close');

    $('#clientinfowindow').jqxWindow({
        width: '62%',
        height: '65%',
        maxHeight: '85%',
        maxWidth: '80%',
        title: ' Client Search',
        position: {
            x: 250,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#clientinfowindow').jqxWindow('close');

    /*  $('#Driverdlswindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' ,title: 'Driver Search', position: { x: 250, y: 140 }, keyboardCloseKey: 27});
								   	     $('#Driverdlswindow').jqxWindow('close');  */

    $('#driverinfowindow').jqxWindow({
        width: '50%',
        height: '58%',
        maxHeight: '62%',
        maxWidth: '50%',
        title: 'Driver Search',
        position: {
            x: 250,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#driverinfowindow').jqxWindow('close');

    $('#chauffeurinfowindow').jqxWindow({
        width: '30%',
        height: '55%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Driver Search',
        position: {
            x: 200,
            y: 70
        },
        keyboardCloseKey: 27
    });
    $('#chauffeurinfowindow').jqxWindow('close');

    $('#tariffinbtnwindow').jqxWindow({
        width: '50%',
        height: '47%',
        maxHeight: '95%',
        maxWidth: '50%',
        title: 'Tariff Search',
        position: {
            x: 150,
            y: 150
        },
        keyboardCloseKey: 27
    });
    $('#tariffinbtnwindow').jqxWindow('close');

    $('#Salesagentinfowindow').jqxWindow({
        width: '30%',
        height: '55%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Sales Agent Search',
        position: {
            x: 200,
            y: 120
        },
        keyboardCloseKey: 27
    });
    $('#Salesagentinfowindow').jqxWindow('close');

    $('#Rentalagentinfowindow').jqxWindow({
        width: '30%',
        height: '55%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Rental Agent Search',
        position: {
            x: 250,
            y: 120
        },
        keyboardCloseKey: 27
    });
    $('#Rentalagentinfowindow').jqxWindow('close');

    $('#Checkoutinfowindow').jqxWindow({
        width: '30%',
        height: '55%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Checkout Search',
        position: {
            x: 700,
            y: 120
        },
        keyboardCloseKey: 27
    });
    $('#Checkoutinfowindow').jqxWindow('close');


    $('#usersearchwindow').jqxWindow({
        width: '55%',
        height: '53%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'User Search',
        position: {
            x: 160,
            y: 150
        },
        keyboardCloseKey: 27
    });
    $('#usersearchwindow').jqxWindow('close');



    $('#cardwindow').jqxWindow({
        width: '30%',
        height: '53%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Card Search',
        position: {
            x: 650,
            y: 150
        },
        keyboardCloseKey: 27
    });
    $('#cardwindow').jqxWindow('close');

    $('#projectwindow').jqxWindow({
        width: '30%',
        height: '62%',
        maxHeight: '54%',
        maxWidth: '50%',
        title: 'Project Search',
        position: {
            x: 800,
            y: 150
        },
        keyboardCloseKey: 27
    });
    $('#projectwindow').jqxWindow('close');

    $("#btnEdit").attr('disabled', true);
    //	 $("#btnDelete").attr('disabled', true );

    $('#rentalproject').dblclick(function() {
        $('#projectwindow').jqxWindow('open');
        $('#projectwindow').jqxWindow('focus');
        projectinfoSearchContent('searchproject.jsp');
    });

    $('#jqxRentalDate').on('change', function(event) {

        var maindate = $('#jqxRentalDate').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A") {
            funDateInPeriod(maindate);
        }
    });
    
    
    $('#actualcldocno').dblclick(function(){
    	var disabled=$(this).attr('disabled');
    	if(disabled!=true && $('#mode').val()=="A"){
    		$('#actualclientwindow').jqxWindow('open');
            $('#actualclientwindow').jqxWindow('focus');
            actualClientSearchContent('actualClientSearch.jsp');
    	}
    });
    /* 				  $('#jqxDateOut').on('change', function (event) {
    					
    				        var dateout = $('#jqxDateOut').jqxDateTimeInput('getDate');
    				   	 if ($("#mode").val() == "A") {  
    				        funDateInPeriod(dateout);
    				        
    				        var checkdate =document.getElementById("rentaltype").value;
    						
    						  var curdateout=new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); 
    						  
    				             if(checkdate=="Daily")
    				              {
    				          			          
    				                  var plusoneday=new Date(new Date(curdateout).setDate(curdateout.getDate()+1));
    				                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(plusoneday));
    								
    				              }
    				             else  if(checkdate=="Weekly")
    			              {
    				            	 var oneweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+7));
    				                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(oneweek));
    			            	
    			              }
    				             else  if(checkdate=="Fortnightly")
    			              {
    				            	 var twoweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+14));
    				                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(twoweek));
    			            	
    			              }
    				             else if(checkdate=="Monthly")
    			              {
    				            	    var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
    						    
    						                 $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(onemounth));
    			            	
    			              }
    				             else
    				            	 {
    				            	 
    				            	 }
    						  
    						
    					  
    				        
    				   	 }
    				       }); */


    $('#jqxDeliveryOut').on('change', function(event) {
        if ($("#mode").val() == "ADD") {
            var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); // out date
            var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
            indate1.setHours(0, 0, 0, 0);
            agmtdate1.setHours(0, 0, 0, 0);
            if (indate1 > agmtdate1) {
                document.getElementById("errormsg").innerText = "Delivery Date Cannot be Less than Out Date";
                return false;
            } else {

                document.getElementById("errormsg").innerText = "";
            }
        }

    });


    $('#jqxDelTimeOut').on('change', function(event) {

        if ($("#mode").val() == "ADD") {
            var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); // out date
            var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date

            var intime1 = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate')); //out time
            var agmttime1 = new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

            indate1.setHours(0, 0, 0, 0);
            agmtdate1.setHours(0, 0, 0, 0);
            if (indate1 > agmtdate1) {
                document.getElementById("errormsg").innerText = "Delivery Date Cannot be Less than Out Date";
                return false;
            }

            if (indate1.valueOf() == agmtdate1.valueOf()) {

                var out = intime1.getHours();
                var del = agmttime1.getHours();

                if (out > del) {

                    document.getElementById("errormsg").innerText = "Delivery Time Cannot be Less than Out Time";
                    return false;
                }
                if (out == del) {
                    if (intime1.getMinutes() > agmttime1.getMinutes()) {
                        document.getElementById("errormsg").innerText = "Delivery Time Cannot be Less than Out Time";
                        return false;
                    }
                }
            }

            document.getElementById("errormsg").innerText = "";

        }

    });



    $('#ratariff_checkout').dblclick(function() {
        $('#Checkoutinfowindow').jqxWindow('open');
        $('#Checkoutinfowindow').jqxWindow('focus');
        checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));
    });


    $('#rarenral_Agent').dblclick(function() {
        $('#Rentalagentinfowindow').jqxWindow('open');
        $('#Rentalagentinfowindow').jqxWindow('focus');
        rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));
    });


    $('#rasales_Agent').dblclick(function() {
        $('#Salesagentinfowindow').jqxWindow('open');
        $('#Salesagentinfowindow').jqxWindow('focus');
        salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
    });


    $('#ratariffbutton').click(function() {
        if (($('#txtfleetno').val() != "") && ($('#txtcusid').val() != "")) {


            $('#tariffinbtnwindow').jqxWindow('open');
            $('#tariffinbtnwindow').jqxWindow('focus');
            if (document.getElementById("weekend").checked == true) {



                tariffbtnSearchContent('getWeekendtariff.jsp?vehgpid=' + document.getElementById("veh_fleetgrouptariff").value + "&cldocno=" + document.getElementById("txtcusid").value + "&outdate=" + document.getElementById("jqxDateOut").value + "&outtime=" + document.getElementById("jqxTimeOut").value);

            } // jqxDateOut jqxTimeOut
            else {
                tariffbtnSearchContent('gettariffbtn.jsp?vehgpid=' + document.getElementById("veh_fleetgrouptariff").value + "&cldocno=" + document.getElementById("txtcusid").value);

            }



        } else {
            if ($('#txtfleetno').val() == "") {
                document.getElementById("errormsg").innerText = "  Select Vehicle";
                document.getElementById("txtfleetno").focus();
                return false;
            }
            if ($('#txtcusid').val() == "") {
                document.getElementById("errormsg").innerText = "  Select Client";
                document.getElementById("txtcusid").focus();
                return false;
            }

        }


    });




    $('#searchuser').click(function() {

        if (($('#ratariffdocno1').val() != "")) {

            $('#usersearchwindow').jqxWindow('open');
            $('#usersearchwindow').jqxWindow('focus');


            searchuserContent('searchotheruser.jsp?vehgpid=' + document.getElementById("veh_fleetgrouptariff").value + "&tarifdoc=" + document.getElementById("ratariffdocno1").value + "&fleetno=" + document.getElementById("txtfleetno").value + "&cldocno=" + document.getElementById("txtcusid").value + "&odate=" + $('#jqxDateOut').jqxDateTimeInput('getDate'));

        } else {
            document.getElementById("errormsg").innerText = "  Search Tariff";
            return false;
        }

    });





    $('#txtcusid').dblclick(function() {

        $('#clientinfowindow').jqxWindow('open');
        $('#clientinfowindow').jqxWindow('focus');
        clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow'));
    });

    $('#txtfleetno').dblclick(function() {
        $('#vehinfowindow').jqxWindow('open');
        $('#vehinfowindow').jqxWindow('focus');
        vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));
    });


    $('#radriverlist').dblclick(function() {
        $('#chauffeurinfowindow').jqxWindow('open');

        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));
    });

    $('#jqxDateOut').on('change', function(event) {


        if ($('#jqxDateOut').jqxDateTimeInput('getDate') != null && $('#jqxTimeOut').jqxDateTimeInput('getDate') != null) {

            var intime = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));
            var indate=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
            var status = checkPriorTime(intime,indate);
            if (status) {
                document.getElementById("errormsg").innerText = "";
                return true;
            } else {
                $('#jqxTimeOut').jqxDateTimeInput('focus');
                return false;
            }
        }

    });

    $('#jqxTimeOut').on('change', function(event) {


        if ($('#jqxTimeOut').jqxDateTimeInput('getDate') != null) {

            var intimestatus = checkfuturetime($('#jqxDateOut').jqxDateTimeInput('getDate'), $('#jqxTimeOut').jqxDateTimeInput('getDate'));
            if (intimestatus) {
                document.getElementById("errormsg").innerText = "";

            } else {
                $('#jqxTimeOut').jqxDateTimeInput('focus');
                return false;
            }
            var intime = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));
            var indate=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
            var status = checkPriorTime(intime,indate);
            if (status) {
                document.getElementById("errormsg").innerText = "";
                return true;
            } else {
                $('#jqxTimeOut').jqxDateTimeInput('focus');
                return false;
            }
        }

    });





}); // close ready

function getConfigs(){
	$.get('getConfigs.jsp',function(data){
		data=JSON.parse(data);
		$('#insurcompconfig').val(data.RAGInsurComp);
		if(data.RAGInsurComp=="1"){
			$('.row-insurcomp').show();
		}
		else{
			$('.row-insurcomp').hide();
		}
		var htmldata='<option value="">--Select--</option>';
		$.each(data.insurcomparray,function(index,value){
			htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
		});
 		$('#cmbinsurcomp').html($.parseHTML(htmldata));
 		$('#lpovalidateconfig').val(data.LPOValidate);
 		if($('#lpovalidateconfig').val()=="1"){
 			$('.racraterow').show();
 		}
 		else{
 			$('.racraterow').hide();
 		}
 		/*		$('#cmbinsurcomp').select2({
			allowClear:true,
			placeholder:"Select Insurance Comp"
		});
 */		
		if($('#hidcmbinsurcomp').val()!=''){
			$('#cmbinsurcomp').val($('#hidcmbinsurcomp').val());
		}
 		htmldata='';
		if(data.InvQuarterly=="1"){
			htmldata+='<option value="1">Month End</option><option value="2">Period</option><option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
			$('#invoice').html($.parseHTML(htmldata));
			if($('#invoval').val()!="")
			{
				$('#invoice').val($('#invoval').val());
			}
		}
		
		htmldata='<option value="">--Select--</option>';
		$.each(data.enqtypedata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
		});
 		$('#cmbenqtype').html($.parseHTML(htmldata));
 		if($('#hidcmbenqtype').val()!=''){
 			$('#cmbenqtype').val($('#hidcmbenqtype').val());
 		}
 		$('#actualclientconfig').val(data.actualclientconfig);
 		if($('#actualclientconfig').val()=="1"){
 			$('.actualclientrow').show();
 		}
 		else{
 			$('.actualclientrow').hide();
 		}
 		
 		$('#rainsurexcessconfig').val(data.RAGInsurExcess);
	});
}
function PrintContent(url) {
	$('#printWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#printWindow').jqxWindow('setContent', data);
	$('#printWindow').jqxWindow('bringToFront');
}); 
}

function getproject(event) {

    var x = event.keyCode;
    if (x == 114) {
        $('#projectwindow').jqxWindow('open');

        // $('#accountWindow').jqxWindow('focus');
        projectinfoSearchContent('searchproject.jsp');
    } else {}
}

function actualClientSearchContent(url) {
    $.get(url).done(function(data) {
    	$('#actualclientwindow').jqxWindow('setContent', data);
    });
}

function projectinfoSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#projectwindow').jqxWindow('setContent', data);

    });
}

function checkfuturetime(date, time) {
    var date1 = new Date(date);
    var time1 = new Date(time);
    var currentdate = new Date();
    var currenthours = currentdate.getHours();
    var currentminutes = currentdate.getMinutes();
    var time1hours = time1.getHours();
    var time1minutes = time1.getMinutes();
    date1.setHours(0, 0, 0, 0);
    currentdate.setHours(0, 0, 0, 0);
    if (date1 - currentdate == 0) {
        if (time1hours > currenthours) {
            document.getElementById("errormsg").innerText = "";
            document.getElementById("errormsg").innerText = "Future Time Not Allowed";
            return false;
        } else if (time1hours == currenthours) {
            if (time1minutes > currentminutes) {
                document.getElementById("errormsg").innerText = "";
                document.getElementById("errormsg").innerText = "Future Time Not Allowed";
                return false;
            }
        }
    }
    return true;
}

function checkPriorTime(intime,indate) {
	if(document.getElementById("mode").value!="view"){
    var currenttime = new Date();
    var priormethod = document.getElementById("priormethod").value;
    var priorvalue = document.getElementById("priorvalue").value;
    var priorhours = priorvalue / 60;
    if (priormethod == "0") {
        return true;
    } else if (priormethod == "1" || priormethod == "2") {
    	var priordate=indate;
		priordate.setHours(intime.getHours());
		priordate.setMinutes(intime.getMinutes());
		var difference=currenttime-priordate;
        var minutediff = parseInt(difference / (1000 * 60));
        if (minutediff > priorvalue) {
            document.getElementById("errormsg").innerText = "";
            document.getElementById("errormsg").innerText = "Prior Opening time is " + priorhours + " hours";
            return false;
        } else {
            return true;
        }
    }
	}
}

function getPriorClose() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('***');
            document.getElementById("priormethod").value = items[0];
            document.getElementById("priorvalue").value = items[1];
        } else {}
    }
    x.open("GET", "../getPriorCreate.jsp", true);
    x.send();
}


function getTax() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            document.getElementById("taxmethod").value = items;
            setIGST();
        } else {}
    }
    x.open("GET", "../getTax.jsp", true);
    x.send();
}





function cardSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {

        $('#cardwindow').jqxWindow('open');
        $('#cardwindow').jqxWindow('setContent', data);

    });
}




function getcheckout(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#Checkoutinfowindow').jqxWindow('open');

        checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));
    } else {}
}

function checkoutSearchContent(url) {

    $.get(url).done(function(data) {

        $('#Checkoutinfowindow').jqxWindow('setContent', data);

    });
}

function getrentalAgent(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#Rentalagentinfowindow').jqxWindow('open');


        rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));
    } else {}
}

function rentalagentSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#Rentalagentinfowindow').jqxWindow('setContent', data);

    });
}

function getsalesAgent(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#Salesagentinfowindow').jqxWindow('open');


        salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
    } else {}
}

function salesagentSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#Salesagentinfowindow').jqxWindow('setContent', data);

    });
}


function tariffbtnSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#tariffinbtnwindow').jqxWindow('setContent', data);

    });
}

function searchuserContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#usersearchwindow').jqxWindow('setContent', data);

    });
}



function driverinfoSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {

        $('#driverinfowindow').jqxWindow('open');
        $('#driverinfowindow').jqxWindow('setContent', data);

    });
}

function getchauffeur(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#chauffeurinfowindow').jqxWindow('open');


        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));
    } else {}
}

function chauffeurSearchContent(url) {

    $.get(url).done(function(data) {

        $('#chauffeurinfowindow').jqxWindow('setContent', data);

    });
}



function getvehinfo(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#vehinfowindow').jqxWindow('open');


        vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));
    } else {}
}

function vehinfoSearchContent(url) {

    $.get(url).done(function(data) {

        $('#vehinfowindow').jqxWindow('setContent', data);

    });
}


function getclientinfo(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#clientinfowindow').jqxWindow('open');

        clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow'));
    } else {}
}

function clieninfoSearchContent(url) {

    $.get(url).done(function(data) {

        $('#clientinfowindow').jqxWindow('setContent', data);

    });
}


function menuContent(url) {
    $.get(url).done(function(data) {
        $('#window1').jqxWindow('open');
        $('#window1').jqxWindow('setContent', data);
        $('#window1').jqxWindow('bringToFront');

    });

}

function funReset() {

}



function checkconfig() {

    var aa = 0;

    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {


            var items = x.responseText;

            var chk = items.trim();

            if (parseInt(chk) == 1) {
                document.getElementById("configtarif").value = 1;


            } else {
                document.getElementById("configtarif").value = 0;
            }


        }

    }
    x.open("GET", "chksetdata.jsp?aa=" + aa, true);

    x.send();




}


function checkweek() {

    var aa = 0;

    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {


            var items = x.responseText;

            var cm = items.split("::");

            var chk = cm[0].trim();
            mth = cm[1].trim();

            if (parseInt(chk) == 1) {
                $("#weekend").show();
                $("#weekend1").show();

            } else {
                $("#weekend").hide();
                $("#weekend1").hide();
            }


        }

    }
    x.open("GET", "checkweekend.jsp?aa=" + aa, true);

    x.send();




}



function funReadOnly() {
    $("#jqxMenuMore").css('visibility', 'visible');
    $('#frmRentalAgreement input').attr('readonly', true);
    $('#frmRentalAgreement textarea').attr('readonly', true);
    $('#frmRentalAgreement select').attr('disabled', true);
    $("#ratariffbutton").attr("disabled", true);
    $("#searchuser").attr("disabled", true);



    //$('#frmRentalAgreement button').attr('disabled', true);

    $('#jqxRentalDate').jqxDateTimeInput({
        disabled: true
    });
    $('#jqxDateOut').jqxDateTimeInput({
        disabled: true
    });
    $('#jqxDeliveryOut').jqxDateTimeInput({
        disabled: true
    });
    $('#jqxOnDate').jqxDateTimeInput({
        disabled: true
    });
    $('#jqxTimeOut').jqxDateTimeInput({
        disabled: true
    });
    $('#jqxOnTime').jqxDateTimeInput({
        disabled: true
    });
    $("#jqxgrid2").jqxGrid({
        disabled: true
    });

    $("table#tariffsub input").prop("disabled", true);
    $("table#tariff input").prop("disabled", true);
    $("table#tariff select").attr("disabled", true);
    $("table#payment input").prop("disabled", true);
    $("table#vehicle input").prop("disabled", true);
    $("table#driver input").prop("disabled", false);
    $('#delivery_chk').attr('disabled', true);
    $('#radrivercheck').attr('disabled', true);
    $("#radriverlist").prop("disabled", true);
    $("#additional_driver").prop("disabled", true);
    $("#adidrvcharges").prop("disabled", true);

    $('#jqxDelTimeOut').jqxDateTimeInput({
        disabled: true
    });

    $("#jqxgridpayment").jqxGrid({
        disabled: true
    });
    $("#jqxgridtarif").jqxGrid({
        disabled: true
    });
    document.getElementById("driverUpdate").value = "Edit";
    $("#hiddrivertable").prop("hidden", false);
    $("#forspace").prop("hidden", true);
    
}

function funRemoveReadOnly() {


    if ($("#mode").val() == "D") {
        $('#docno').attr('disabled', false);
        $('#txtfleetno').attr('disabled', false);
        var valfleetno = document.getElementById("txtfleetno").value;
        var docnos = document.getElementById("masterdoc_no").value;

        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {


                var items = x.responseText;

                var chkfleet = items.trim();

                if (parseInt(chkfleet) == 1) {
                    $.messager.alert('Message', ' Transaction Found Not Deleted ', 'warning');
                    $('#docno').attr('disabled', true);
                    $('#txtfleetno').attr('disabled', true);
                    $("#mode").val("view");
                    exit();
                    return 0;
                } else {
                    $.messager.alert('Message', 'RA Is Successfully Deleted ', 'warning');

                    $('#docno').attr('disabled', true);
                    $('#txtfleetno').attr('disabled', true);
                    $("#mode").val("D");
                    exit();

                    return 0;
                }


            }

        }

        x.open("GET", "deleterantal.jsp?valfleet=" + valfleetno + "&docnos=" + docnos, true);

        x.send();
        exit();
    }


    $("table#tariff input").prop("disabled", false); /*  fleet search in after veh came grid */
    $('#frmRentalAgreement input').attr('readonly', false);
    $('#frmRentalAgreement select').attr('disabled', false);
    
    $("table#tariffsub input").prop("disabled", false);
    $("table#tariffsub input").prop("disabled", false);
    $("#ratariffbutton").attr("disabled", false);
    $("#searchuser").attr("disabled", false);
    // $("table#tariff input").prop("disabled", false);
    $("table#tariff select").attr("disabled", false);
    $("table#payment input").prop("disabled", false);
    $("table#vehicle input").prop("disabled", false);
    $("table#driver input").prop("disabled", false);
    
    $('#cmbinsurcomp,#insurcompdays').attr('disabled',true);
    $('#jqxRentalDate').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxDateOut').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxDeliveryOut').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxOnDate').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxTimeOut').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxDelTimeOut').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxOnTime').jqxDateTimeInput({
        disabled: false
    });
    $('#delivery_chk').attr('disabled', false);
    $('#radrivercheck').attr('disabled', false);
    $("#radriverlist").prop("readonly", true);
    $("#radriverlist").prop("disabled", true);
    $("#delcharges").attr("disabled", true);
    $("#jqxgrid2").jqxGrid({
        disabled: false
    });

    $("#jqxgridpayment").jqxGrid({
        disabled: false
    });
    $("#jqxgridtarif").jqxGrid({
        disabled: false
    });
    $('#docno,#rentalproject').attr('readonly', true);
    $('#jqxDeliveryOut').jqxDateTimeInput({
        disabled: false
    });
    $('#jqxDelTimeOut').jqxDateTimeInput({
        disabled: false
    });
    $('#del_Driver').attr('readonly', true);
    $('#del_KM').attr('disabled', false);
    $('#del_Fuel').attr('disabled', false);
    $('#txtfleetno').attr('readonly', true);
    $('#vehdetails').attr('readonly', true);
    $('#txtcusid').attr('readonly', true);
    $('#client_Name').attr('readonly', true);
    $('#re_salman').attr('readonly', true);
    $('#cusaddress').attr('readonly', true);
    $("#additional_driver").prop("disabled", false);
    $("#adidrvcharges").prop("disabled", true);
    $('#rasales_Agent').attr('readonly', true);
    $('#rarenral_Agent').attr('readonly', true);
    $('#re_Km').attr('readonly', true);
    $('#ratariff_fuel').attr('readonly', true);
    $('#ratariff_checkout').attr('readonly', true);
    $('#ratariffdocno1').attr('readonly', true);
    $('#payment_Conveh').attr('readonly', true);
    //$('#excessinsur').attr('readonly', true);

    if ($("#mode").val() == "A") {
        checkconfig();
        $("#jqxMenuMore").css('visibility', 'hidden');
        $('#jqxRentalDate').val(new Date());
        $('#jqxDateOut').val(new Date());
        $('#jqxOnDate').val(new Date());
        //
        $('#jqxOnTime').val(new Date());
        $('#jqxTimeOut').val(new Date());

        $("#jqxgrid2").jqxGrid('clear');
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#tariffDivId").load('rateDescription.jsp');
        $("#divpaymentGrid").load("paymentdetailsgrid.jsp");
        $("#jqxgrid2").jqxGrid({
            disabled: false
        });
        $("#jqxgridpayment").jqxGrid({
            disabled: false
        });
        // $("table#driver input").prop("disabled", true); 
        $("#hiddrivertable").prop("hidden", true);

        $("#forspace").prop("hidden", false);
        document.getElementById("rentalstatus").innerText = "";
        // $("#branch").prop("hidden", true);
        getTax();

        setIGST();

        getDeliveryDriverConfig();
        
        getConfigs();
        $('#actualcldocno,#actualclientname').attr('disabled',true);
    }





    //return 0;

    getPriorClose();

}

function chkavailable(valfleet, dateout, timeout) {

    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {


            var items = x.responseText;
            var chkfleet = items.trim();

            if (chkfleet == 1) {
                $.messager.alert('Message', 'Fleet Is Not Available ', 'warning');
                return 0;
            } else {

                funSetlabel();

                $('#advance_chk').attr('disabled', false);
                $('#invoice').attr('disabled', false);




                $('#frmRentalAgreement').submit();
            }


        }

    }

    x.open("GET", "chkavailablefleet.jsp?valfleet=" + valfleet + "&dateout=" + dateout + "&timeout=" + timeout, true);

    x.send();

}

function funNotify() {

    if ($('#mraconfig').val() == '1') {
        if ($('#payment_Mra').val() == '') {
            document.getElementById("errormsg").innerText = "";
            document.getElementById("errormsg").innerText = "Manual RA is Mandatory";
            return 0;
        }
    }
    var duedate = $('#jqxOnDate').jqxDateTimeInput('getDate');
    var outdate = $('#jqxDateOut').jqxDateTimeInput('getDate');
   if(duedate<outdate){
	   document.getElementById("errormsg").innerText = " Due Date should be greater than Out Date  ";
	          return 0;
	  }
    var maindate = $('#jqxRentalDate').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(maindate);
    if (validdate == 0) {
        return 0;
    }

    var dateout = $('#jqxDateOut').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(dateout);
    if (validdate == 0) {
        return 0;
    }
    var intimestatus = checkfuturetime($('#jqxDateOut').jqxDateTimeInput('getDate'), $('#jqxTimeOut').jqxDateTimeInput('getDate'));
    if (intimestatus) {
        document.getElementById("errormsg").innerText = "";

    } else {
        $('#jqxTimeOut').jqxDateTimeInput('focus');
        return false;
    }
    var intimeprior = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));
    var indateprior = new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
    var intimepriorstatus = checkPriorTime(intimeprior,indateprior);
    if (intimepriorstatus) {
        document.getElementById("errormsg").innerText = "";
    } else if (intimepriorstatus == false && document.getElementById("priormethod").value == "2") {
        $('#jqxTimeOut').jqxDateTimeInput('focus');
        return 0;
    }
    $('#jqxDeliveryOut').jqxDateTimeInput({
        disabled: false
    });

    var valfleet = document.getElementById("txtfleetno").value;

    if (valfleet == "") {
        document.getElementById("errormsg").innerText = " Select Vehicle  ";
        document.getElementById("txtfleetno").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
    }


    var valid2 = document.getElementById("txtcusid").value;

    if (valid2 == "") {
        document.getElementById("errormsg").innerText = " Select Client";
        document.getElementById("txtcusid").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
    }




    var validdesc = document.getElementById("rentaldesc").value;


    if (validdesc != "") {

        var nmaxs = validdesc.length;


        if (nmaxs > 249) {
            document.getElementById("errormsg").innerText = "Description Cannot Contain More Than 250 Characters";
            document.getElementById("rentaldesc").focus();

            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }

    }


    if (document.getElementById('additional_driver').checked) {

        var addcharge = document.getElementById("adidrvcharges").value;

        if (addcharge == "") {
            document.getElementById("errormsg").innerText = " Enter Additional Driver Charge";
            document.getElementById("adidrvcharges").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }
    }
    var x = document.rentalform.adidrvcharges.value;
    if (isNaN(x) || x.indexOf(" ") != -1) {
        document.getElementById("errormsg").innerText = " Invalid Amount";
        document.getElementById("adidrvcharges").focus();

        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
    }



    if (document.getElementById('radrivercheck').checked == false) {

        var rows = $("#jqxgrid2").jqxGrid('getrows');
        var aa = 0;
        for (var i = 0; i < rows.length; i++) {

            if (parseInt(rows[i].dr_id1) > 0) {
                aa = 1;
                break;
            } else {

                aa = 0;
            }



        }



        if (parseInt(aa) == 0) {

            document.getElementById("errormsg").innerText = " Select Driver";

            return 0;

        } else {
            document.getElementById("errormsg").innerText = "";
        }


    }


    if ((document.getElementById('delivery_chk').checked) || (document.getElementById('radrivercheck').checked)) {

        var drvname = document.getElementById("radriverlist").value;

        if (drvname == "" && $('#deliverydriverconfig').val() == "1") {
            document.getElementById("errormsg").innerText = " Select Driver";
            document.getElementById("radriverlist").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }
    }








    var raagent = document.getElementById("rarenral_Agent").value;

    if (raagent == "") {
        document.getElementById("errormsg").innerText = " Select Rental Agent";
        document.getElementById("rarenral_Agent").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
    }
    var checkoutagent = document.getElementById("ratariff_checkout").value;

    if (checkoutagent == "" && $('#deliverydriverconfig').val() == "1") {
        document.getElementById("errormsg").innerText = " Select Checkout";
        document.getElementById("ratariff_checkout").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
    }

    var excessinsur = document.getElementById("excessinsur").value;


    if (excessinsur == "") {
    	var excessinsurconfig=$('#rainsurexcessconfig').val();
    	if(parseInt(excessinsurconfig)>0){
    		var cdw=$('#jqxgridtarif').jqxGrid('getcellvalue',3,'cdw');
    		var pai=$('#jqxgridtarif').jqxGrid('getcellvalue',3,'pai');
    		
    		if((cdw==null || cdw=="" || cdw=="undefined" || typeof(cdw)=="undefined") && (pai==null || pai=="" || pai=="undefined" || typeof(pai)=="undefined")){
    			$.messager.alert('Warning','Insurance Excess is not entered');
    			return false;
    		}
    		else{
    			document.getElementById("excessinsur").value = 0;
    		}
    	}
    	else{
    		document.getElementById("excessinsur").value = 0;	
    	}
        
	
    }

    if ((document.getElementById('delivery_chk').checked)) {

        var delcharge = document.getElementById("delcharges").value;

        if (delcharge == "") {
            document.getElementById("errormsg").innerText = "Enter Delivery Charges ";
            document.getElementById("delcharges").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }
    }

	var lpoconfig=$('#lpoconfig').val();
	if(lpoconfig=="1"){
		var lpostatus=$('#lpostatus').val();
		var lponumber=$('#payment_PO').val();
		if(lpostatus=="1" && lponumber==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("payment_PO").focus();
			document.getElementById("errormsg").innerText="LPO Mandatory";
			return false;
		}
		var racratestatus=$('#racratestatus').val();
		var racrate=$('#racrate').val();
		if(racratestatus=="1" && $('#racrate').val()==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("racrate").focus();
			document.getElementById("errormsg").innerText="RAC Rate Mandatory";
			return false;
		}
	}

    // driver grid
    var rows = $("#jqxgrid2").jqxGrid('getrows');
    $('#drivergridlength').val(rows.length);
    //alert($('#gridlength').val());
    for (var i = 0; i < rows.length; i++) {
        // var myvar = rows[i].tarif; 
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "drvtest" + i)
            .attr("name", "drvtest" + i)
            .attr("hidden", "true");

        newTextBox.val(rows[i].dr_id1 + " :: ");

        newTextBox.appendTo('form');


    }
    // tariff grid

    var rows = $("#jqxgridtarif").jqxGrid('getrows');
    $('#tariffgridlength').val(rows.length);
    //alert($('#gridlength').val());

    for (var i = 0; i < rows.length; i++) {

        var rowlgt = rows.length - 1;

        if (i == rowlgt) {





            var rateval = rows[i].rate;


            if (rateval == "" || typeof(rateval) == "undefined" || typeof(rateval) == "NaN") {

                document.getElementById("errormsg").innerText = "Tariff Is Not Selected";
                return 0;
            }


            if (document.getElementById("configtarif").value == 1) {

                var kmrestval = rows[i].kmrest;


                if (parseFloat(kmrestval) >= 0) {


                } else {
                    document.getElementById("errormsg").innerText = "KM Restrict Is Not Selected";
                    return 0;
                }


                var exkmrteval = rows[i].exkmrte;


                if (parseFloat(exkmrteval) >= 0) {


                } else {

                    document.getElementById("errormsg").innerText = "Excess KM Rate Is Not Selected";
                    return 0;
                }



            }


        }
    }

    for (var i = 0; i < rows.length; i++) {


        //  startday starttime endday endtime
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test" + i)
            .attr("name", "test" + i)
            .attr("hidden", "true");
        newTextBox.val(rows[i].rentaltype + "::" + rows[i].rate + " :: " + rows[i].cdw + " :: " + rows[i].pai + " :: " + rows[i].cdw1 + " :: " + rows[i].pai1 + " :: " + rows[i].gps + " :: " + rows[i].babyseater + " :: " + rows[i].cooler + " :: " + rows[i].kmrest + " :: " + rows[i].exkmrte + " :: " + rows[i].oinschg + " :: " + rows[i].exhrchg + " :: " + rows[i].chaufchg + " :: " + rows[i].chaufexchg + " :: " + rows[i].status + " :: " + rows[i].startday + " :: " + rows[i].starttime + " :: " + rows[i].endday + " :: " + rows[i].endtime);

        newTextBox.appendTo('form');


    }

    $('#advance_chk').attr('disabled', false);
    $('#invoice').attr('disabled', false);




    if ($("#invruleoverride").val() != "1") {

        var checkinvoice = document.getElementById("rentaltype").value;
        var invoicevalue = document.getElementById("invoice").value;




        /*   if(checkinvoice!="Monthly")
							              {
							          		if(invoicevalue=="2")
							          			{
							          			document.getElementById("errormsg").innerText="Rental Type is "+checkinvoice+" Change  Invoice Type" ;
							          			
							          			
							          			 if(document.getElementById("configmethod").value>0)// in client search set this value 
											           
									        	   {	
							          		  $('#advance_chk').attr('disabled', true);
							       	           $('#invoice').attr('disabled', true);
									        	   }
							       	           
							       	           
												document.getElementById("invoice").focus(); 
												return 0;
							          			}
							          		else
							          			{
							          			
							          			
							          			document.getElementById("errormsg").innerText="";
							          			}
							              }
							           
							            	 */


        if (document.getElementById("configmethod").value > 0) // in client search set this value 

        {


            if (checkinvoice == "Monthly") {


                if (document.getElementById("advchkval").value != document.getElementById("advance_chk").value) {

                    document.getElementById("errormsg").innerText = "Please check the client invoice rule";
                    return 0;
                }




                if (document.getElementById("invval").value != document.getElementById("invoice").value) {

                    document.getElementById("errormsg").innerText = "Please check the client invoice rule";
                    return 0;
                }

            }

        }


        if (checkinvoice != "Monthly") {






            if (invoicevalue == "1") {
                //document.getElementById("errormsg").innerText="Rental Type is "+checkinvoice+" Change  Invoice Type" ;


                if (document.getElementById("configmethod").value > 0) // in client search set this value 

                {
                    $('#advance_chk').attr('disabled', false);
                    $('#invoice').attr('disabled', false);
                }


                //document.getElementById("invoice").focus(); 
                //return 0;
            } else {


                document.getElementById("errormsg").innerText = "";
            }
        }



    }



    var rows = $("#jqxgridpayment").jqxGrid('getrows');

    var cardnum = "";
    var cardtype = "";
    var preauthstatus = 0;
    for (var i = 0; i < rows.length; i++) {
        var paymentmode = rows[i].mode;
        var payment = rows[i].payment;
        if (payment == "Pre Auth" && (paymentmode == "Cash" || paymentmode == "CASH")) {
            document.getElementById("errormsg").innerText = "";
            document.getElementById("errormsg").innerText = "Cash is not allowed for Pre-Auth";
            preauthstatus = 1;
            return 0;
        }
    }
    if (preauthstatus == 1) {
        return 0;
    }
    for (var i = 0; i < rows.length; i++) {

        var checkdate = new Date();
        checkdate.setHours(0, 0, 0, 0);
        var checkoutdate = $('#jqxDateOut').jqxDateTimeInput('getDate');
        checkoutdate.setHours(0, 0, 0, 0);
        var paymentmode = rows[i].mode;
        if (checkoutdate < checkdate && (paymentmode != "" && paymentmode != "undefined" && paymentmode != null && typeof(paymentmode) != "undefined")) {
            $.messager.alert('warning', 'Cannot process payment with old date');
            $("#divpaymentGrid").load("paymentdetailsgrid.jsp");
            return 0;
        }

        if (rows[i].mode == "CARD" || rows[i].mode == "CASH") {


            if (rows[i].amount == "" || rows[i].amount == "0.00" || typeof(rows[i].amount) == "undefined" || typeof(rows[i].amount) == "NaN")

            {
                document.getElementById("errormsg").innerText = "Enter Amount In   " + rows[i].payment;
                return 0;
            }
        }

        if (rows[i].mode == "CARD") {


            cardtype = rows[i].card;
            cardnum = rows[i].cardno;


            /*  if(!(cardtype=="MASTER"||cardtype=="VISA"))
            	{ */
            if (cardtype == "" || typeof(cardtype) == "undefined" || typeof(cardtype) == "NaN") {
                document.getElementById("errormsg").innerText = "Select Card Type In " + rows[i].payment;
                return 0;
            } else {

            }


            if (cardnum == "" || typeof(cardnum) == "undefined" || typeof(cardnum) == "NaN") {

                document.getElementById("errormsg").innerText = "Enter Card NO In  " + rows[i].payment;
                return 0;
            } else {

            }

            /* 		var str = ""+cardnum;
            		var n = str.length;
						
            		if(n!=16)
            		{
            	
            		document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
                	return 0;
            		}
            	else
            		{
            		
            		}
            		 */
        }

    }


    var rows = $("#jqxgridpayment").jqxGrid('getrows');
    $('#paymentgridlength').val(rows.length);
    //alert($('#gridlength').val());
    for (var i = 0; i < rows.length; i++) {
        // var myvar = rows[i].tarif; 
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "paytest" + i)
            .attr("name", "paytest" + i)
            .attr("hidden", "true");

        newTextBox.val(rows[i].payment + "::" + rows[i].mode + " :: " + rows[i].amount + " :: " + rows[i].acode + " :: " + rows[i].cardno + " :: " + rows[i].hidexpdate + " :: " + rows[i].card + " :: " + rows[i].cardtype + " :: " + rows[i].paytype + " :: " + rows[i].invno + " :: " + rows[i].status + " :: ");

        newTextBox.appendTo('form');


    }

    if (window.parent.cardnumbervalidator.value == 1) {
        var checkingcard = "0";
        var rows = $("#jqxgridpayment").jqxGrid('getrows');
        if (rows.length > 0) {
            for (var l = 0; l < rows.length; l++) {
                /* if(typeof(rows[l].mode) != "undefined" && rows[l].mode != "undefined" && rows[l].mode != "" && rows[l].mode != null){
                	var mode=rows[l].mode; */
                if (rows[l].mode == "CARD") {
                    var cardno = rows[l].cardno;
                    if (typeof(cardno) != "undefined") {

                        var chckcardno = cardnumber(cardno + "");
                        if (chckcardno == "0") {
                            checkingcard = "1";
                            break;
                        }
                    }
                }
                //}


            }
            if (checkingcard == "1") {

                document.getElementById("errormsg").innerText = "Invalid Card Number.";
                return 0;
            }
        }
    }

    var valfleetno = document.getElementById("txtfleetno").value;
    var dateout = $('#jqxDateOut').val();
    var timeout = $('#jqxTimeOut').val();
    chkavailable(valfleetno, dateout, timeout);





}




function funSearchLoad() {
    changeContent('masterSearch.jsp', $('#window'));
}

function funFocus() {
    document.getElementById("txtfleetno").focus();

}

function replacement() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('vehReplaceGrid.jsp?docnovals=' + document.getElementById("masterdoc_no").value, $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function fine() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('trafficFines.jsp?docnovals=' + document.getElementById("masterdoc_no").value, $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function account() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('accountsmainForm.jsp?docnovals=' + document.getElementById("masterdoc_no").value, $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function funinspection() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('inspectionchecklist.jsp?docnovals=' + document.getElementById("masterdoc_no").value, $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function closing() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        var url = document.URL;
        var reurl = url.split("saveRentalAgreement");
        $("#docno").prop("disabled", false);

        var win = window.open(reurl[0] + "printRAClosingSummaryNormal?docno=" + document.getElementById("masterdoc_no").value, "_blank", "top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function funKmDetails() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('kmdetails.jsp?docno=' + document.getElementById("masterdoc_no").value + '&id=1', $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}

function funFuelDetails() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {
        $('#window1').jqxWindow('open');
        menuContent('fueldetails.jsp?docno=' + document.getElementById("masterdoc_no").value + '&id=1', $('#window1'));
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }
}












function funChkButton() {

    frmRentalAgreement.submit();
}




function funaddidriverview() {

    if (document.getElementById('additional_driver').checked) {
        $("#adidrvcharges").prop("disabled", false);
        document.getElementById('adidrvcharges').value = "";



    } else

    {
        $("#adidrvcharges").prop("disabled", true);

        document.getElementById('adidrvcharges').value = "";

    }
}


function fundriverdisable() {

    if (document.getElementById('delivery_chk').checked) {

        document.getElementById("radriverlist").value = "";
        $("#radriverlist").prop("disabled", false);
        $("#jqxgrid2").jqxGrid({
            disabled: false
        });
        $("#delcharges").attr("disabled", false);
        document.getElementById("radrivercheck").checked = false;
        $("#radrivercheck").prop("disabled", true);

    } else

    {
        $("#radriverlist").prop("disabled", true);
        $("#jqxgrid2").jqxGrid({
            disabled: false
        });
        $("#radrivercheck").prop("disabled", false);
        $("#delcharges").attr("disabled", true);
        document.getElementById('radriverlist').value = "";
        document.getElementById('del_Driver').value = "";
        document.getElementById("del_chaufferid").value = "";
        document.getElementById("delcharges").value = "";



    }
}


function funShaffurdisable() {

    if (document.getElementById('radrivercheck').checked) {
        document.getElementById("radriverlist").value = "";
        document.getElementById("fordrivervali").value = "";
        $("#radriverlist").prop("disabled", false);
        document.getElementById("delivery_chk").checked = false;
        $("#delivery_chk").prop("disabled", true);
        $("#delcharges").attr("disabled", true);
        document.getElementById("delcharges").value = "";
        $("#jqxgrid2").jqxGrid('clear');
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#jqxgrid2").jqxGrid({
            disabled: true
        });

        document.getElementById("errormsg").innerText = "";


    } else {
        $("#radriverlist").prop("disabled", true);
        $("#jqxgrid2").jqxGrid({
            disabled: false
        });
        $("#delivery_chk").prop("disabled", false);
        document.getElementById('radriverlist').value = "";
        document.getElementById('del_Driver').value = "";
        document.getElementById("del_chaufferid").value = "";

    }
}


function funchkKm() {
    $("#re_Km").prop("disabled", false);
    var outkm = document.getElementById("re_Km").value;
    //alert("out"+outkm);
    var delkm = document.getElementById("del_KM").value;
    if ((parseFloat(delkm) < parseFloat(outkm)))


    {

        document.getElementById("errormsg").innerText = "Delivery KM Less Than Out KM";
        $("#re_Km").prop("disabled", true);
        return 0;
    } else {
        document.getElementById("errormsg").innerText = "";
        $("#re_Km").prop("disabled", true);
    }

}

function funchkDelStatus() {
    var masterdoc = document.getElementById("masterdoc_no").value;

    var x = new XMLHttpRequest();


    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            if (items > 0) {
                $.messager.alert('Message', ' Already Edited ', 'warning');

                return 0;
            } else {
                document.getElementById("errormsg").innerText = "";
                $("table#driver input").prop("disabled", false);
                $("table#driver select").prop("disabled", false);

                $('#jqxDeliveryOut').val(new Date());
                $('#jqxDelTimeOut').val(new Date());
                document.getElementById("del_Fuel").value = "";
                document.getElementById("del_KM").value = "";
                $('#del_Driver').attr('readonly', true);
                $('#del_KM').attr('readonly', false);
                $('#del_KM').attr('disabled', false);
                $('#del_Fuel').attr('disabled', false);
                $('#jqxDeliveryOut').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxDelTimeOut').jqxDateTimeInput({
                    disabled: false
                });

                document.getElementById("driverUpdate").value = "Update";
                document.getElementById("mode").value = 'ADD';
                return 0;
            }

        } else {

        }
    }
    x.open("GET", 'checkUpdate.jsp?masterdocno=' + masterdoc, true);
    x.send();
}




function funupdate() {

    if (document.getElementById("driverUpdate").value == "Edit") {
        if (document.getElementById("delchkvalue").value == 1) {
            funchkDelStatus();

        } else {
            $.messager.alert('Message', ' Delivery Update Need Not Be Entered ', 'warning');

        }
        return 0;
    } else if (document.getElementById("driverUpdate").value == "Update") {


        if (document.getElementById("del_KM").value == "") {
            document.getElementById("errormsg").innerText = "Enter KM";
            document.getElementById("del_KM").focus();
            return false;
        } else {
            document.getElementById("errormsg").innerText = "";
        }
        if ($('#del_Fuel').val() == "") {
            document.getElementById("errormsg").innerText = " Select Fuel";
            document.getElementById("del_Fuel").focus();
            return false;
        } else {
            document.getElementById("errormsg").innerText = "";
        }
        $("#re_Km").prop("disabled", false);
        var outkm = document.getElementById("re_Km").value;
        var delkm = document.getElementById("del_KM").value;

        if ((parseFloat(delkm) < parseFloat(outkm)))


        {

            document.getElementById("errormsg").innerText = "Delivery KM Less Than Out KM";
            $("#re_Km").prop("disabled", true);
            return 0;
        } else {

            document.getElementById("errormsg").innerText = "";
            $("#re_Km").prop("disabled", true);
        }


        var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); // out date
        var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date

        var validdeldate=funDateInPeriod(agmtdate1);
		if(validdeldate==0){
			return 0; 
		}
        var intime1 = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate')); //out time
        var agmttime1 = new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

        var curdate=new Date();
        curdate.setHours(0,0,0,0);
        
        indate1.setHours(0, 0, 0, 0);
        agmtdate1.setHours(0, 0, 0, 0);
        
        if(agmtdate1-curdate==0){
        	var curtime=new Date();
        	if(agmttime1.getHours()>curtime.getHours()){
        		document.getElementById("errormsg").innerText = "Future Time Restricted";
                return 0;	
        	}
        	else if(agmttime1.getHours()==curtime.getHours()){
        		if(agmttime1.getMinutes()>curtime.getMinutes()){
        			document.getElementById("errormsg").innerText = "Future Time Restricted";
                    return 0;	
        		}
        	}
        }
        
        if (indate1 > agmtdate1) {
            document.getElementById("errormsg").innerText = "Delivery Date Cannot be Less than Out Date";
            return 0;
        }

        if (indate1.valueOf() == agmtdate1.valueOf()) {

            var out = intime1.getHours();
            var del = agmttime1.getHours();

            if (out > del) {

                document.getElementById("errormsg").innerText = "Delivery Time Cannot be Less than Out Time";
                return 0;
            }
            if (out == del) {
                if (intime1.getMinutes() > agmttime1.getMinutes()) {
                    document.getElementById("errormsg").innerText = "Delivery Time Cannot be Less than Out Time";
                    return 0;
                }
            }
        }

        document.getElementById("errormsg").innerText = "";

        $.messager.confirm('Confirm', 'Do you want to save changes?', function(r) {
            if (r == false) {

                return 0;
            } else {
                funSetlabel();


                $('#frmRentalAgreement txtfleetno').attr('disabled', false);
                $('#frmRentalAgreement txtcusid').attr('disabled', false);
                $('#frmRentalAgreement docno').attr('disabled', false);
                $("table#vehicle input").prop("disabled", false);
                $('#jqxRentalDate').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxDateOut').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxDeliveryOut').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxOnDate').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxTimeOut').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxDelTimeOut').jqxDateTimeInput({
                    disabled: false
                });
                $('#jqxOnTime').jqxDateTimeInput({
                    disabled: false
                });
                $('#frmRentalAgreement select').attr('disabled', false);
                $("table#tariffsub input").prop("disabled", false);
                $("table#tariff input").prop("disabled", false);
                $("table#tariff select").attr("disabled", false);
                $("table#payment input").prop("disabled", false);
                $("table#vehicle input").prop("disabled", false);
                $("table#chauffer input").prop("disabled", false);
                $('#frmRentalAgreement').submit();
            }



        });
    }
}


function checkReqveh() {

    if (document.getElementById("txtfleetno").value == "")

    {
        document.getElementById("errormsg").innerText = "  Select Vehicle";
        document.getElementById("txtfleetno").focus();
        $('#txtcusid').attr('disabled', true);

    }

}

function checkReqclient() {
    if (document.getElementById("txtcusid").value == "")


    {
        document.getElementById("delivery_chk").checked = false;
        document.getElementById("radrivercheck").checked = false;

        if (document.getElementById("txtfleetno").value == "")

        {
            document.getElementById("errormsg").innerText = "  Select Vehicle";
            document.getElementById("txtfleetno").focus();
            $('#txtcusid').attr('disabled', true);
            $('#delivery_chk').attr('disabled', true);
            $('#radrivercheck').attr('disabled', true);
            $("table#tariffsub input").prop("disabled", true);
            return false;

        } else {
            document.getElementById("txtcusid").focus();

            $('#delivery_chk').attr('disabled', true);
            $('#radrivercheck').attr('disabled', true);
            $("table#tariffsub input").prop("disabled", true);
            document.getElementById("errormsg").innerText = "  Select Client";
            return false;
        }
    }
}

/* function fundriverreq()
         {
        	 
        	  if(document.getElementById("fordrivervali").value=="")
             	
        		{ 
        		  if (document.getElementById('delivery_chk').checked) {
        	    	  document.getElementById("errormsg").innerText="  Select Client Driver"; 
         	          $("table#tariffsub input").prop("disabled", true); 
         	         return false;     		            	              		          	  
        		       }
        		}
        	  
      
        	  
        	if(document.getElementById("radriverlist").value=="")
        		{
        		   document.getElementById("radriverlist").focus();
        		document.getElementById("errormsg").innerText="  Select A Driver "; 
        	    $("table#tariffsub input").prop("disabled", true); 
        		
        		}
            }
   */

/*     function funsalagentreqs()
   {
  	
  	  if(document.getElementById("rasales_Agent").value=="")
       	
  		{ 
  		  document.getElementById("rasales_Agent").focus();
  		   $('#rarenral_Agent').attr('disabled', true);
   	       $('#ratariff_checkout').attr('disabled', true);
  		  document.getElementById("errormsg").innerText="  Select Sales Agent";
 		}  
   } 
    */
function checkReqrental() {
    if (document.getElementById("rarenral_Agent").value == "")

    {
        document.getElementById("rarenral_Agent").focus();

        $('#ratariff_checkout').attr('disabled', true);
        document.getElementById("errormsg").innerText = "  Select Rental Agent";

    }
}

function delvalueChange() {
    if ($("#mode").val() == "view") {
        if (document.getElementById("delchkvalue").value == 1) {
            $("#driverUpdate").attr("disabled", false);
        } else {
            $("#driverUpdate").attr("disabled", true);
        }
    }
    //	alert(document.getElementById("delchkvalue").value);
    if (document.getElementById("delchkvalue").value == 1) {
        document.getElementById("delivery_chk").checked = true;
        document.getElementById("delivery_chk").value = 1;
        if ($("#mode").val() == "A") {
            $('#radriverlist').attr('disabled', false);
            $("#delcharges").attr("disabled", false);
        }

    } else if (document.getElementById("chaffchkvalue").value == 1) {
        document.getElementById("radrivercheck").checked = true;
        document.getElementById("radrivercheck").value = 1;
        if ($("#mode").val() == "A") {
            $('#radriverlist').attr('disabled', false);

        }
    } else {
        /*  document.getElementById("radrivercheck").checked = false; */
        $('#radriverlist').attr('disabled', true);
    }
    if (document.getElementById("add_drchk").value == 1) {
        document.getElementById("additional_driver").checked = true;
        document.getElementById("additional_driver").value = 1;
        if ($("#mode").val() == "A") {
            $('#adidrvcharges').attr('disabled', false);
        }
    } else {
        document.getElementById("additional_driver").checked = false;
        document.getElementById("additional_driver").value = 0;
        $('#adidrvcharges').attr('disabled', true);
    }
    // ,invoice

    if ($('#systemval').val() != "") {


        $('#ratariffsystem').val($('#systemval').val());
    }
    if ($('#invoval').val() != "") {


        $('#invoice').val($('#invoval').val());
    }

    if ($('#hiddel_Fuel').val() != "") {


        $('#del_Fuel').val($('#hiddel_Fuel').val());
    }


    if (document.getElementById("advance_chkval").value == 1) {
        document.getElementById("advance_chk").checked = true;
        document.getElementById("advance_chk").value = 1;

    } else {
        document.getElementById("advance_chk").checked = false;
        document.getElementById("advance_chk").value = 0;

    }



    if (document.getElementById("weekendval").value == 1) {
        document.getElementById("weekend").checked = true;
        document.getElementById("weekend").value = 1;

    } else {
        document.getElementById("weekend").checked = false;
        document.getElementById("weekend").value = 0;

    }

}

function getAgmtDates(doctemp) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var showdate = items.split("::")[0];
            var showtime = items.split("::")[1];
            var showagmtdate = items.split("::")[2];
            if (showagmtdate == "1") {
                if (showdate != "null") {
                    document.getElementById("errormsg").innerText = "Closed On " + showdate + "  " + showtime;
                }
            }
            //$('#agmtnowindow').jqxWindow('close');
        }
    }
    x.open("GET", "getAgmtDates.jsp?docno=" + doctemp, true);
    x.send();
}

function setValues() {

    var maindoc = document.getElementById("masterdoc_no").value;
    if (maindoc > 0) {

        var indexVal1 = document.getElementById("masterdoc_no").value;
        var revehGroup = document.getElementById("veh_fleetgrouptariff").value;

        $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno=' + indexVal1 + '&revehGroup=' + revehGroup);

        var indexVal2 = document.getElementById("masterdoc_no").value;

        $("#divDrivGrid").load("driverGrid.jsp?txtrentaldocno1=" + indexVal2);

        var indexVal3 = document.getElementById("masterdoc_no").value;

        $("#divpaymentGrid").load("paymentdetailsgrid.jsp?txtrentaldoc=" + indexVal3);

        getAgmtDates(indexVal1);


    }


    // main
    if ($('#hidjqxRentalDate').val()) {
        $("#jqxRentalDate").jqxDateTimeInput('val', $('#hidjqxRentalDate').val());
    }
    // tariff OUT date
    if ($('#hidjqxDateOut').val()) {
        $("#jqxDateOut").jqxDateTimeInput('val', $('#hidjqxDateOut').val());
    }
    // tariff OUT time
    if ($('#hidjqxTimeOut').val()) {

        $("#jqxTimeOut").jqxDateTimeInput('val', $('#hidjqxTimeOut').val());
    }
    // tariff DUE date
    if ($('#hidjqxOnDate').val()) {
        $("#jqxOnDate").jqxDateTimeInput('val', $('#hidjqxOnDate').val());
    }
    // tariff DUE time
    if ($('#hidjqxOnTime').val()) {
        $("#jqxOnTime").jqxDateTimeInput('val', $('#hidjqxOnTime').val());
    }
    // delivery date
    if ($('#hidjqxDeliveryOut').val()) {
        $("#jqxDeliveryOut").jqxDateTimeInput('val', $('#hidjqxDeliveryOut').val());
    }

    //deivery time

    if ($('#hidjqxDelTimeOut').val()) {
        $("#jqxDelTimeOut").jqxDateTimeInput('val', $('#hidjqxDelTimeOut').val());
    }


    if ($('#msg').val() != "") {
        $.messager.alert('Message', $('#msg').val());
    }
    delvalueChange();

    document.getElementById("formdet").innerText = $('#formdetail').val() + " (" + $('#formdetailcode').val().trim() + ")";
    funSetlabel();

    if (document.getElementById("checkbranch").value == "WOB") {

        $("#btnDelete").attr('disabled', true);
        $("#driverUpdate").attr('disabled', true);

    }


    if (document.getElementById("hidchkorgregcard").value == "1") {
        document.getElementById("chkorgregcard").checked = true;

    } else {
        document.getElementById("chkorgregcard").checked = false;

    }


    if (document.getElementById("hidchkigst").value == "1") {
        document.getElementById("chkigst").checked = true;

    } else {
        document.getElementById("chkigst").checked = false;

    }
    
    if($('#hidchkinsurcomp').val()=='1'){
    	document.getElementById("chkinsurcomp").checked=true;
    	funChkInsurComp();
    }
    else{
    	document.getElementById("chkinsurcomp").checked=false;
    	funChkInsurComp();
    }
    
}
/*       function funchknumber()
          {
                  var x = document.rentalform.adidrvcharges.value;
                  if(isNaN(x)|| x.indexOf(" ")!=-1){
                      //  alert("Enter numeric value");
                        document.getElementById("errormsg").innerText=" Invalid Amount";   
                        document.getElementById("adidrvcharges").focus();
                        return false;
                        }
                  else
                  	{
                  	 document.getElementById("errormsg").innerText="";
                  	}
                 
                     
          } */


function funPrintBtn() {
    if (($("#mode").val() == "view") && $("#masterdoc_no").val() != "") {


        var url = document.URL;

       
        if (mth == 1) {


            $("#docno").prop("disabled", false);

            
            PrintContent('printVoucherWindow.jsp');
        }else  if (ratehideprintchk == 1) {
            $("#docno").prop("disabled", false);    

            PrintContent('printVoucherWindowEpic.jsp');
        } else {
        	
        	 var reurl = url.split("saveRentalAgreement");
            $("#docno").prop("disabled", false);
            var win = window.open(reurl[0] + "printRA?docno=" + document.getElementById("masterdoc_no").value + "&formdetailcode=RAG", "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");

        }
    } else {
        $.messager.alert('Message', 'Select a Document....!', 'warning');
        return false;
    }

}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText = " Enter Numbers Only";

        return false;
    }
    document.getElementById("errormsg").innerText = "";
    return true;
}

function fundescvalidate() {
    var validdescs = document.getElementById("rentaldesc").value;

    if (validdescs != "") {

        var nmaxs = validdescs.length;


        if (nmaxs > 249) {
            document.getElementById("errormsg").innerText = "Description Cannot Contain More Than 250 Characters";
            document.getElementById("rentaldesc").focus();

            return 0;
        } else {
            document.getElementById("errormsg").innerText = "";
        }


    }
}

function setOrgRegCard() {

    if ($('#mode').val() == "A") {
        if (document.getElementById("chkorgregcard").checked == true) {
            document.getElementById("hidchkorgregcard").value = "1";
        } else {
            document.getElementById("hidchkorgregcard").value = "0";
        }
    }

}


function setIGST() {
    if ($('#taxmethod').val() == '1') {
        $('.igst').show();
    } else {
        $('.igst').hide();
    }


    if ($('#mode').val() == "A") {
        if ($('#taxmethod').val() == '1') {
            $('.igst').show();

            if (document.getElementById("chkigst").checked == true) {
                document.getElementById("hidchkigst").value = "1";
            } else {
                document.getElementById("hidchkigst").value = "0";
            }
        } else {
            $('.igst').hide();
        }
    }
    //Overridden for carfare
    $('.igst').hide();
}


function getDeliveryDriverConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split("::");
            $('#deliverydriverconfig').val(items[0].trim());
            $('#invruleoverride').val(items[1].trim());
            //if($('#deliverydriverconfig').val()=="0"){
            $('#rarenral_Agent').val(items[3].trim());
            $('#tariffrenral_Agentid').val(items[2].trim());
            //}

        } else {}
    }
    x.open("GET", "getDeliveryDriverConfig.jsp", true);
    x.send();
} 
function getprintratehideConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            ratehideprintchk=parseInt(items);

        } else {}
    }
    x.open("GET", "getprintratehideConfig.jsp", true);
    x.send();
} 
function funChkInsurComp(){
	if(document.getElementById("chkinsurcomp").checked==true){
		document.getElementById("hidchkinsurcomp").value="1";
		document.getElementById("cmbinsurcomp").disabled=false;
		document.getElementById("insurcompdays").disabled=false;
		
	}
	else{
		document.getElementById("hidchkinsurcomp").value="0";
		document.getElementById("cmbinsurcomp").disabled=true;
		document.getElementById("insurcompdays").disabled=true;
	}
	
	//for updating Insur Days
	var agmtdocno=$('#masterdoc_no').val();
	if(agmtdocno!=null && agmtdocno!='undefined' && agmtdocno!='' && typeof(agmtdocno)!='undefined'){
		//getting details
		$.get('getAgmtDetails.jsp',{'agmtdocno':agmtdocno},function(data){
			data=JSON.parse(data);
			if(data.clstatus=="0" && data.insurcompconfig=="1" && data.chkinsurcomp=="1"){
				$('#insurcompdays,#btninsurupdate').attr('disabled',false);
				$('#insurcompdays').attr('readonly',false);
			}
		});
	}
	
}

function funUpdateInsurComp(){
	
	var insurcompdays=$('#insurcompdays').val();
	var agmtdocno=$('#masterdoc_no').val();
	if(insurcompdays==''){
		$.messager.alert('Warning','Please enter valid days');
		return false;
	}
	
	$.messager.confirm('Confirm', 'Do you want to update Insur.Company Days?', function(r){
		if (r){
			$.post('updateInsurComp.jsp',{'agmtdocno':agmtdocno,'insurcompdays':insurcompdays},function(data,status){
				data=JSON.parse(data);
				if(data.errorstatus=="0"){
					$.messager.alert('Message','Successfully Updated');
					$('#insurcompdays,#btninsurupdate').attr('disabled',true);
				}
				else{
					$.messager.alert('Message','Not Updated');
				}
			})
		}
	});
}


function funResetExcessInsur(){
	var excessinsurconfig=$('#rainsurexcessconfig').val();
	if(parseInt(excessinsurconfig)>0){
		var excessinsur=$('#excessinsur').val();
		if(excessinsur==null || excessinsur=="" || excessinsur=="undefined" || typeof(excessinsur)=="undefined" || parseFloat(excessinsur)==0.0){
			$('#excessinsur').val('');
		}
	}
}
</script>
    

</head>
<script>
(function(){
  // list of date/time element ids you use on the page (add/remove as needed)
  var widgets = [
    {id: 'jqxRentalDate', serverVal: '<s:property value="hidjqxRentalDate"/>'},
    {id: 'jqxDateOut', serverVal: '<s:property value="hidjqxDateOut"/>'},
    {id: 'jqxOnDate', serverVal: '<s:property value="hidjqxOnDate"/>'},
    {id: 'date', serverVal: '<s:property value="date"/>'},
    {id: 'dateout', serverVal: '<s:property value="dateout"/>'},
    {id: 'garagedeldate', serverVal: '<s:property value="garagedeldate"/>'},
    {id: 'garagecollectdate', serverVal: '<s:property value="garagecollectdate"/>'},
    {id: 'closedate', serverVal: '<s:property value="closedate"/>'}
    // add other ids if you have more
  ];

  function initJqx(id, opts){
    try {
      if (typeof $ !== 'undefined' && typeof $.jqx !== 'undefined' && $('#' + id).jqxDateTimeInput) {
        // choose a compact width/height so it looks like small textbox
        $('#' + id).jqxDateTimeInput(opts || { width: '140px', height: '30px', formatString: 'dd.MM.yyyy' });
        return true;
      }
    } catch (e) {
      // ignore - we'll fallback
    }
    return false;
  }

  function insertFallback(id, value){
    var $div = $('#' + id);
    if (!$div.length) return;
    // build fallback input element (small)
    var inputId = id + '_fallback';
    // if already replaced, do nothing
    if ($('#' + inputId).length) return;
    var text = (value && value !== 'null') ? value : '';
    var $input = $('<input>', {
      type: 'text',
      id: inputId,
      class: 'date-fallback',
      value: text,
      placeholder: text ? '' : 'dd.MM.yyyy'
    });
    // replace the div with input (preserves layout)
    $div.replaceWith($input);
  }

  // run after DOM ready
  $(function(){
    widgets.forEach(function(w){
      var ok = initJqx(w.id, null);
      if (!ok) {
        // fallback to input and set server value
        insertFallback(w.id, w.serverVal);
      } else {
        // if server provided a value, set it into jqx widget
        try {
          if (w.serverVal && w.serverVal !== '') {
            $('#' + w.id).jqxDateTimeInput('setDate', w.serverVal);
          }
        } catch(e){}
      }
    });
  });
})();
</script>
<script>
$(document).ready(function() {

    // list of jqx date div IDs used in RA page
    const dateIDs = [
        "jqxRentalDate", "jqxDateOut", "jqxOnDate",
        "date", "dateout", "garagedeldate",
        "garagecollectdate", "closedate"
    ];

    dateIDs.forEach(id => {
        const el = $("#" + id);
        if (el.length) {

            // read server value (if stored in hidden field)
            const hiddenVal = $("[name='hid" + id + "']").val() || "";

            // Create a real input box
            const input = $("<input>")
                .attr("type", "text")
                .attr("id", id)
                .attr("name", id)
                .addClass("date-input-fallback")
                .val(hiddenVal);

            // Replace the div with input
            el.replaceWith(input);
        }
    });

});
$(document).ready(function(){
    $("#jqxRentalDate").jqxDateTimeInput({
        width: "100%",
        height: 32,
        formatString: "dd.MM.yyyy"
    });
});

</script>

<body onload="setValues();">

<div id="mainBG" class="homeContent">

<form id="frmRentalAgreement" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ======== HEADER BAR ======== -->
    <div class="ra-header-bar">
        <h2>Rental Agreement (RA)</h2>
        <div class="ra-actions">
            <button type="button" class="ra-button">Search</button>
            <button type="button" class="ra-button">Create</button>
            <button type="button" class="ra-button">Edit</button>
            <button type="button" class="ra-button">Print</button>
            <button type="button" class="ra-button">Delete</button>
        </div>
    </div>

    <!-- ========= SCROLL WRAPPER ========== -->
    <div class="scroll-area">


        <!-- ========================================================= -->
        <!-- ===============   ROW 1 (2 Columns)    ================== -->
        <!-- ========================================================= -->
        <div class="section-two-col">

            <!-- ========== COLUMN 1: VEHICLE & CLIENT INFO ========== -->
            <div class="section">
                <h3 class="section-title">Vehicle & Client Info</h3>

                <div class="form-grid">

                    <div class="form-item">
                        <label>Vehicle</label>
                        <input class="input" id="txtfleetno" name="txtfleetno"
                               placeholder="Press F3 To Search"
                               onkeydown="getvehinfo(event);"
                               value='<s:property value="txtfleetno"/>'>
                    </div>

                    <div class="form-item">
                        <label>Client</label>
                        <input class="input" id="txtcusid" name="txtcusid"
                               placeholder="Press F3 To Search"
                               onkeydown="getclientinfo(event);"
                               value='<s:property value="txtcusid"/>'>
                    </div>

                    <div class="form-item">
                        <label>Doc No</label>
                        <input class="input" id="docno" name="docno" readonly
                               value='<s:property value="docno"/>'>
                    </div>

                    <div class="form-item full">
                        <label>Vehicle Details</label>
                        <input class="input" id="vehdetails" name="vehdetails"
                               value='<s:property value="vehdetails"/>'>
                    </div>

                    <div class="form-item">
                        <label>Date</label>
                        <div id="jqxRentalDate"></div>
                    </div>

                    <div class="form-item full">
                        <label>Description</label>
                        <input class="input" id="rentaldesc" name="rentaldesc"
                               value='<s:property value="rentaldesc"/>'
                               onblur="fundescvalidate()">
                    </div>

                </div>
            </div>



            <!-- =========== COLUMN 2: DRIVER DETAILS =========== -->
            <div class="section">
                <h3 class="section-title">Driver Details</h3>

                <div class="form-grid">

                    <div class="form-item">
                        <label>Additional Driver</label>
                        <input type="checkbox" id="additional_driver" name="additional_driver"
                               onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    </div>

                    <div class="form-item">
                        <label>Driver</label>
                        <input class="input" id="radriverlist" name="radriverlist"
                               placeholder="Press F3 To Search"
                               onkeydown="getchauffeur(event);"
                               value='<s:property value="radriverlist"/>'>
                    </div>

                    <div class="form-item full">
                        <div id="divDrivGrid">
                            <jsp:include page="driverGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>
            </div>

        </div> <!-- END ROW 1 -->




        <!-- ========================================================= -->
        <!-- ===============   ROW 2 (2 Columns)    ================== -->
        <!-- ========================================================= -->
        <div class="section-two-col">

            <!-- ========== COLUMN 1: TARIFF INFO ========== -->
            <div class="section">
                <h3 class="section-title">Tariff Info</h3>

                <div class="form-grid">

                    <div class="form-item">
                        <label>Sales Agent</label>
                        <input class="input" id="rasales_Agent" name="rasales_Agent"
                               placeholder="Press F3 To Search"
                               onkeydown="getsalesAgent(event);"
                               value='<s:property value="rasales_Agent"/>'>
                    </div>

                    <div class="form-item">
                        <label>Rental Agent</label>
                        <input class="input" id="rarenral_Agent" name="rarenral_Agent"
                               placeholder="Press F3 To Search"
                               onkeydown="getrentalAgent(event);"
                               value='<s:property value="rarenral_Agent"/>'>
                    </div>

                    <div class="form-item">
                        <label>Out KM</label>
                        <input class="input" id="re_Km" name="re_Km"
                               value='<s:property value="re_Km"/>'>
                    </div>

                    <div class="form-item full">
                        <div id="tariffDivId">
                            <jsp:include page="rateDescription.jsp"></jsp:include>
                        </div>
                    </div>

                </div>
            </div>



            <!-- ========== COLUMN 2: PAYMENT INFO ========== -->
            <div class="section">
                <h3 class="section-title">Payment Info</h3>

                <div class="form-grid">

                    <div class="form-item full">
                        <div id="divpaymentGrid">
                            <jsp:include page="paymentdetailsgrid.jsp"></jsp:include>
                        </div>
                    </div>

                    <div class="form-item">
                        <label>Manual RA</label>
                        <input class="input" id="payment_Mra" name="payment_Mra"
                               value='<s:property value="payment_Mra"/>'>
                    </div>

                    <div class="form-item">
                        <label>LPO</label>
                        <input class="input" id="payment_PO" name="payment_PO"
                               value='<s:property value="payment_PO"/>'>
                    </div>

                    <div class="form-item">
                        <label>Project</label>
                        <input class="input" id="rentalproject" name="rentalproject"
                               placeholder="Press F3 To Search" readonly
                               value='<s:property value="rentalproject"/>'>
                    </div>

                </div>
            </div>

        </div> <!-- END ROW 2 -->

    </div> <!-- scroll-area end -->

</form>
</div>

</body>


</html> 
    