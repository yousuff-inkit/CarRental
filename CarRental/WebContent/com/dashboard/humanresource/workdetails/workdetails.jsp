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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.myButtonses {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
 background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
 background-color:#599bb3;
 -moz-border-radius:4px;
 -webkit-border-radius:4px;
 border-radius:4px;
 display:inline-block;
 cursor:pointer;
 color:#ffffff;
 font-family:Verdana;
 font-size:10px;
 padding:4px 8px;
 text-decoration:none;
}
.myButtonses:hover {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
 background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
 background-color:#408c99;
}
.myButtonses:active {
 position:relative;
 top:1px;
}
.myButtonReCheck {
	-moz-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	-webkit-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	box-shadow:inset 0px 1px 0px 0px #3dc21b;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #44c767), color-stop(1, #5cbf2a));
	background:-moz-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-webkit-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-o-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-ms-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#44c767', endColorstr='#5cbf2a',GradientType=0);
	background-color:#44c767;
	-moz-border-radius:42px;
	-webkit-border-radius:42px;
	border-radius:42px;
	border:6px solid #18ab29;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:10px;
	font-weight:bold;
	padding:3px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.myButtonReCheck:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cbf2a), color-stop(1, #44c767));
	background:-moz-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-webkit-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-o-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-ms-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:linear-gradient(to bottom, #5cbf2a 5%, #44c767 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cbf2a', endColorstr='#44c767',GradientType=0);
	background-color:#5cbf2a;
}
.myButtonReCheck:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">
      $(document).ready(function () {
    	  $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
 		  $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
 		 document.getElementById("formdet").innerText="Work Details(WRD)";
 		document.getElementById("formdetail").value="Work Details";
 		document.getElementById("formdetailcode").value="WRD";
 		window.parent.formCode.value="WRD";
 		window.parent.formName.value="Work Details";
 		
		 document.getElementById("btnView").value ="View";

		 $('#cmbholiday').attr('disabled', true);
		 $('#rdholiday').attr('disabled', true);

			$("#commentsGrid").jqxGrid('clear');

  		 $("#commentsGrid").jqxGrid({ disabled: true});

  		 $("#attendanceGridID").jqxGrid({ disabled: true});
		 $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		 
    	 getYear();getHoliday();
    	 var curmonth=new Date().getMonth()-1;
  	   $('#cmbmonth').prop('selectedIndex',curmonth);
 
      }); 
      
      
      
    
    function getYear() {
   	 var curyear=new Date().getFullYear();

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbyear").html(optionsyear);
				if ($('#hidcmbyear').val() != null) {
					$('#cmbyear').val($('#hidcmbyear').val());
				}
				if (curyear != null) {

					document.getElementById("cmbyear").value=curyear;
					}
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
   

    
   
    function getLeaveType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var leavetypeItems = items[0].split(",");
				var leavetypeIdItems = items[1].split(",");
				var optionsleavetype = '<option value="">--Select--</option>';
				for (var i = 0; i < leavetypeItems.length; i++) {
					optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
							+ leavetypeItems[i] + '</option>';
				}
				$("select#cmbleavetype").html(optionsleavetype);
				if ($('#hidcmbleavetype').val() != null) {
					$('#cmbleavetype').val($('#hidcmbleavetype').val());
				}
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
    
    function getHoliday() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var holidayItems = items[0].split(",");
				var holidayIdItems = items[1].split(",");
				var alpha = items[2].split(",");

				//alert(holidayItems+","+holidayIdItems);
				var optionsholiday = '<option value="">--Select--</option>';
				for (var i = 0; i < holidayItems.length; i++) {
					optionsholiday += '<option value="' + holidayIdItems[i] + '">'
							+ holidayItems[i] + '</option>';
				}
				$("select#cmbholiday").html(optionsholiday);
				if ($('#hidcmbholiday').val() != null) {
					$('#cmbholiday').val($('#hidcmbholiday').val());
				}
				if (holidayItems != null) {

					document.getElementById("cmbholiday").value= holidayIdItems[0];
					document.getElementById("hidalpha").value= alpha[0];

					}
			} else {
			}
		}
		x.open("GET", "getHoliday.jsp", true);
		x.send();
	}
    
    function getNewGridValue(a){
    	//alert(a);
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  				
  			    $('#txtselectedcelltextvalue').val(items);
  		}
  		}
  		x.open("GET", "getNewGridValue.jsp?refno="+a, true);
  		x.send();
    }
    
    function getHolidaysOfMonth(year,month) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtholidaysofmonth').val(items);
  		}
  		}
  		
  		x.open("GET", "getHolidaysOfMonth.jsp?year="+year+"&month="+month, true);
  		x.send();
     }
    
   
   
    
    
    
    
    function getUser() {
    	var x = new XMLHttpRequest();
    	var items, nameItems, IdItems,docItems;
    	x.onreadystatechange = function() {
    		if (x.readyState == 4 && x.status == 200) {
    			items = x.responseText;
    			items = items.split('***');
    			IdItems = items[0];
    			nameItems = items[1];
    			docItems = items[2];

  			    $('#txtemployeename').val(nameItems);
  			    $('#txtemployeeid').val(IdItems);
  			    $('#txtemployeedocno').val(docItems);

    		}
    	}
    	x.open("GET", "getuser.jsp", true);
    	x.send();
    }
   
      
	function funReadOnly(){} 
	
	function funRemoveReadOnly(){
		
	}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	 
	 function funNotify(){	

		  
		   document.getElementById("hidcmbmonth").value=document.getElementById("cmbmonth").value;
			document.getElementById("hidcmbyear").value=document.getElementById("cmbyear").value;
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 			
				 if(document.getElementById("rdholiday").checked==true)
                     {
					 var alpha=document.getElementById("hidalpha").value;
					// alert(alpha);
		  			    $('#txtselectedcelltextvalue').val(alpha);

					 if($('#txtselectedcelltextvalue').val()=='')
						{
						// alert("marked");
						 document.getElementById("errormsg").innerText="Select a Day";
						 return 0;
						}
					// alert( $('#txtselectedcellrow').val()+","+ $('#txtselectedcellcolumn').val()+","+$('#txtselectedcelltextvalue').val())
			    	$('#attendanceGridID').jqxGrid('setcellvalue', $('#txtselectedcellrow').val(), $('#txtselectedcellcolumn').val(),$('#txtselectedcelltextvalue').val());
			    	document.getElementById("rdholiday").checked=false;
					 }
	 			var rows1 = $("#attendanceGridID").jqxGrid('getrows');
			 	
                    var temparray="",tempdata="",tempval="",tempvalue="";
				 for(var k=0 ; k< rows1.length ; k++){	
						tempdata=tempdata+","+rows1[k].costtype;

			    		temparray=tempdata;
			    		}
				 if(temparray.includes("SJOB") && temparray.includes("COST") || temparray.includes("SJOB") && temparray.includes("SJOB"))	
                  {
					 
	 			var day1=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date1', ['sum'], true);
	            var date1=day1.sum;
	            var day2=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date2', ['sum'], true);
	            var date2=day2.sum;
	            var day3=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date3', ['sum'], true);
	            var date3=day3.sum;
	            var day4=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date4', ['sum'], true);
	            var date4=day4.sum;
	            var day5=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date5', ['sum'], true);
	            var date5=day5.sum;
	            var day6=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date6', ['sum'], true);
	            var date6=day6.sum;
	            var day7=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date7', ['sum'], true);
	            var date7=day7.sum;
	            var day8=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date8', ['sum'], true);
	            var date8=day8.sum;
	            var day9=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date9', ['sum'], true);
	            var date9=day9.sum;
	            var day10=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date10', ['sum'], true);
	            var date10=day10.sum;
	            var day11=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date11', ['sum'], true);
	            var date11=day11.sum;
	            var day12=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date12', ['sum'], true);
	            var date12=day12.sum;
	            var day13=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date13', ['sum'], true);
	            var date13=day13.sum;
	            var day14=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date14', ['sum'], true);
	            var date14=day14.sum;
	            var day15=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date15', ['sum'], true);
	            var date15=day15.sum;
	            var day16=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date16', ['sum'], true);
	            var date16=day16.sum;
	            var day17=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date17', ['sum'], true);
	            var date17=day17.sum;
	            var day18=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date18', ['sum'], true);
	            var date18=day18.sum;
	            var day19=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date19', ['sum'], true);
	            var date19=day19.sum;
	            var day20=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date20', ['sum'], true);
	            var date20=day20.sum;
	            var day21=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date21', ['sum'], true);
	            var date21=day21.sum;
	            var day22=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date22', ['sum'], true);
	            var date22=day22.sum;
	            var day23=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date23', ['sum'], true);
	            var date23=day23.sum;
	            var day24=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date24', ['sum'], true);
	            var date24=day24.sum;
	            var day25=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date25', ['sum'], true);
	            var date25=day25.sum;
	            var day26=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date26', ['sum'], true);
	            var date26=day26.sum;
	            var day27=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date27', ['sum'], true);
	            var date27=day27.sum;
	            var day28=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date28', ['sum'], true);
	            var date28=day28.sum;
	            var day29=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date29', ['sum'], true);
	            var date29=day29.sum;
	            var day30=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date30', ['sum'], true);
	            var date30=day30.sum;
	            var day31=$('#attendanceGridID').jqxGrid('getcolumnaggregateddata', 'date31', ['sum'], true);
	            var date31=day31.sum;
	                  if(date1!=8 && date1!=0 || date2!=8 && date2!=0 || date3!=8 && date3!=0|| date4!=8 && date4!=0|| date5!=8 && date5!=0|| date6!=8 && date6!=0|| date7!=8 && date7!=0|| date8!=8 && date8!=0|| date9!=8 && date9!=0|| 
	            		date10!=8 && date10!=0|| date11!=8 && date11!=0|| date12!=8 && date12!=0|| date13!=8 && date13!=0|| date14!=8 && date14!=0|| date15!=8 && date15!=0|| date16!=8 && date16!=0|| date17!=8 && date17!=0|| date18!=8 && date18!=0|| 
	            		date19!=8 && date19!=0|| date20!=8 && date20!=0|| date21!=8 && date21!=0|| date22!=8 && date22!=0|| date23!=8 && date23!=0|| date24!=8 && date24!=0|| date25!=8 && date25!=0|| date26!=8 && date26!=0|| date27!=8 && date27!=0|| 
	            		date28!=8 && date28!=0|| date29!=8 && date29!=0|| date30!=8 && date30!=0|| date31!=8 && date31!=0)
	                  {

	  	            	
	  	            	
		    		 document.getElementById("errormsg").innerText=" Total Hrs should be 8";
					 return 0;
				       }
                  }
		            
				 if(document.getElementById("errormsg").innerText!="")
					 {
		  	       document.getElementById("errormsg").innerText="Characters Not Allowed";    

					 return 0;
					 }
			 		//clearUpdate();

	 			/* Time Sheet Grid  Saving*/
	 			
				var year=$("#cmbyear").val();
				var month=$("#cmbmonth").val();
				var empid=$("#txtemployeedocno").val();
		 		var branch=document.getElementById("brchName").value;    
		 		
			 	var rows = $("#attendanceGridID").jqxGrid('getrows');
			 	var length=0;
if(rows.length==0)
	{
	 document.getElementById("errormsg").innerText="Enter values !!!";
	 return 0;
	}
else
	{
					 for(var i=0 ; i < rows.length ; i++){	
						 var confirm=rows[i].confirmed;
						// alert(confirm);
						 if(confirm=="1")
	  	 				 {
	  	 				 document.getElementById("errormsg").innerText="Already Confimed";
						 return 0;
						
	  	 				 }
											newTextBox = $(document.createElement("input"))
										    .attr("type", "dil")
										    .attr("id", "test"+length)
										    .attr("name", "test"+length)
											.attr("hidden", "true");
											length=length+1;
												newTextBox.val(empid+"::"+year+":: "+month+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "totdays")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "tot_leave1")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "code")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "costtype")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "dbname")+":: "+branch+":: "
								       				+$('#attendanceGridID').jqxGrid('getcelltext', i, "date1")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date2")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date3")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date4")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date5")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date6")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date7")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date8")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date9")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date10")+":: "
								       				+$('#attendanceGridID').jqxGrid('getcelltext', i, "date11")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date12")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date13")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date14")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date15")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date16")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date17")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date18")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date19")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date20")+":: "
								       				+$('#attendanceGridID').jqxGrid('getcelltext', i, "date21")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date22")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date23")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date24")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date25")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date26")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date27")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date28")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date29")+":: "+$('#attendanceGridID').jqxGrid('getcelltext', i, "date30")+":: "
								       				+$('#attendanceGridID').jqxGrid('getcelltext', i, "date31")+":: "+rows[i].srno+"::");
								       		newTextBox.appendTo('form');
								       }
	}
	 		 	$('#gridlength').val(length);
			 	/* Time Sheet Grid  Saving Ends*/
			 document.getElementById("mode").value='A';
			 document.getElementById("frmWorkDetails").submit();

	 		 }
	 		document.getElementById("btnView").value =="View";
			 funViewAttendance();

	 		
	 		});
		return 1;
	}
	
	function markHoliday()
	{
		var rows = $("#attendanceGridID").jqxGrid('getrows');
		for(var i=0 ; i < rows.length ; i++){
			$("#overlay, #PleaseWait").show();
			$('#attendanceGridID').jqxGrid('setcellvalue', i, $('#txtselectedcellcolumn').val() ,$('#txtselectedcelltextvalue').val()); 
		}
	//	document.getElementById("cmbholiday").value="";
		document.getElementById("rdholiday").checked=false;

	}
	 
	 function funSearchLoad(){}
	 
	 function funFocus(){
		    document.getElementById("cmbyear").focus();
	    }
	 
	 function setValues(){
			
		 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				   funreload();
				  }

            
          
		}
	  function funreload()
	  {
		  document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
			document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;

	  }
	 
	
	 
	  
	 function getDay() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var daysItems = items[0].split(",");
					var daysIdItems = items[1].split(",");
					var optionsdays = '<option value="">--Select--</option>';
					for (var i = 0; i < daysItems.length; i++) {
						optionsdays += '<option value="' + daysIdItems[i] + '">'
								+ daysItems[i] + '</option>';
					}
					$("select#cmbday").html(optionsdays);
					if ($('#hidcmbday').val() != null) {
						$('#cmbday').val($('#hidcmbday').val());
					}
				} else {
				}
			}
			x.open("GET", "getDay.jsp?year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val(), true);
			x.send();
		}
	    
	 
	 
	 function funViewAttendance(){
		    if(document.getElementById("btnView").value =="View"){
				 document.getElementById("errormsg").innerText="";


			$("#attendanceGridID").jqxGrid('addrow', null, {});
			$("#attendanceGridID").jqxGrid({ disabled: false});
			$("#commentsGrid").jqxGrid({ disabled: false});

		    	
		    	if($('#cmbyear').val()==''){
		    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
					 return 0;
				 }
		    	
		    	if($('#cmbmonth').val()==''){
		    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
					 return 0;
				 }
		    	
		    	var x = document.getElementById("cmbday").length; 
		    	var totdays=(x-1);
				var year=$("#cmbyear").val();
				var month=$("#cmbmonth").val();
				var empid=$("#txtemployeedocno").val().trim();
			//	alert(empid);
		 		var branch=document.getElementById("brchName").value;    
		 		var check=1;    
		    	
		    	$("#overlay, #PleaseWait").show();
		    	$("#attendanceDiv").load("attendanceGrid.jsp?totdays="+totdays+"&year="+year+"&month="+month+"&empid="+empid+"&check="+check+"&branch="+branch+"");
	            $("#commentsDiv").load("commentsGrid.jsp?year="+year+"&month="+month+"&empid="+empid+"");
	  
		    }
		   
	 }
	 
	 function newValueSet(){
		 if(document.getElementById("rdovertime").checked==true){
			 var overtimes = $('#overtime').val();
			 var overtime = overtimes.split(":");
			 var value = ((parseInt(overtime[0])*60)+parseInt(overtime[1]));
			 $('#txtselectedcellvalue').val(value);
			 $('#txtselectedcelltextvalue').val(overtimes);
			 
		 }else{
			 var holiday = $('#cmbholiday').val();
			 $('#txtselectedcellvalue').val(holiday);
		   }	 
	 }
	 
	 
	 function radioClick(){
		 if(document.getElementById("rdovertime").checked==true){
			 $('#overtime').jqxDateTimeInput({disabled: false});
			 $('#cmbholiday').attr('disabled', true);
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			// document.getElementById("cmbholiday").value = "";
			// document.getElementById("cmbleavetype").value = "";
			 document.getElementById("chckhalfday").checked=false;
			 document.getElementById("hidchckhalfday").value = 0;
			 
			 var overtimes = $('#overtime').val();
			 var overtime = overtimes.split(":");
			 var value = ((overtime[0]*60)+overtime[1]);
			 $('#txtselectedcellvalue').val(value);
			 
		 }else if(document.getElementById("rdtotalleaves").checked==true){
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			 $('#cmbholiday').attr('disabled', true);
			 $('#overtime').jqxDateTimeInput({disabled: true});
			 document.getElementById("cmbholiday").value = "";
			 var settime=new Date();
			 settime.setHours(0,0,0,0);
			 $('#overtime').jqxDateTimeInput('setDate',settime);
		 }else{
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			 $('#overtime').jqxDateTimeInput({disabled: true});
			 if(document.getElementById("rdholiday").checked==true)
				 {
				 $('#cmbholiday').attr('disabled', false);

				 }
			 document.getElementById("cmbleavetype").value = "";
			 document.getElementById("chckhalfday").checked=false;
			 document.getElementById("hidchckhalfday").value = 0;
			 var settime=new Date();
			 settime.setHours(0,0,0,0);
			 $('#overtime').jqxDateTimeInput('setDate',settime);
		   }	 
	 }
	 
	function  funClearInfo(){
			
		
		    $('select').find('option').prop("selected", false);
		
			$("#attendanceGridID").jqxGrid('clear');
			$("#attendanceGridID").jqxGrid('addrow', null, {});
			$("#attendanceGridID").jqxGrid({ disabled: true});
			$("#commentsGrid").jqxGrid('clear');
			$("#commentsGrid").jqxGrid('addrow', null, {});
			$("#commentsGrid").jqxGrid({ disabled: true});
			
			 var curmonth=new Date().getMonth()-1;
		  	   $('#cmbmonth').prop('selectedIndex',curmonth);
		 getYear();
			 
			 document.getElementById("btnView").value ="View";
			   document.getElementById("savemsg").innerText="";
		     document.getElementById("errormsg").innerText="";
	}
	 
	 
	 
	 
	 
	
		
		 function funExcelBtn() {
			  //JSONToCSVCon(dataExcelExport, 'Attendance', true);
			 $("#attendanceDiv").excelexportjs({  
				 containerid: "attendanceDiv", 
				 datatype: 'json', 
				 dataset: null, 
				 gridId: "attendanceGridID", 
				 columns: getColumns("attendanceGridID") ,   
				 worksheetName:"Work Details"
				 });
		  }
		
		 function getCheckdate(temp,db,trno) {
				
 	    	var x = new XMLHttpRequest();
 	    	var items, sItems, eItems;
 	    	x.onreadystatechange = function() {
 	    		if (x.readyState == 4 && x.status == 200) {
 	    			items = x.responseText;
 	    			items = items.split('***');
 	    			sItems = items[0];
 	    			eItems = items[1];
 	    			//alert("sitem="+sItems+"eitems="+eItems);
 	  			    $('#hidsdate').val(sItems);
 	  			    $('#hidedate').val(eItems);

 	    		}
 	    	}
 	    	x.open("GET", "checkDate.jsp?docno="+temp+"&db="+db+"&trno="+trno, true);
 	    	x.send();
 	    }
		
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getUser();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWorkDetails" action="saveWorkDetails" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<table width="99%" >
  <tr>
    <td width="15%">
<fieldset style="background-color: #EBDEF0;">
<table width="99%" >

<tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
<tr>
<tr>
    <td colspan="3">&nbsp;</td>
    </tr>
  <tr>
    <td width="1%" align="left">Year</td>
    <td  width="15%"><select id="cmbyear" name="cmbyear" style="width:95%;" onchange="getDay();" value='<s:property value="cmbyear"/>'>
      </select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td>
  </tr>
  <tr>
    <td align="left">Month</td>
    <td ><select id="cmbmonth" name="cmbmonth" style="width:95%;" onchange="getDay();" value='<s:property value="cmbmonth"/>'>
      <option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td>
  </tr>
  <tr hidden="true">
     <td align="right">Day</td>
    <td><select id="cmbday" name="cmbday" style="width:80%;" value='<s:property value="cmbday"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbday" name="hidcmbday" value='<s:property value="hidcmbday"/>'/></td>
  
     </tr>
 
  <tr>
    <td  align="left">Employee</td>
    <td colspan="2"><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:90%;"  value='<s:property value="txtemployeeid"/>'  />
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
  </tr>
   <tr>
   <td></td>
    <td colspan="4"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:90%;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td>
  </tr>
 
      <tr>
    <td  align="center"><input type="radio" id="rdholiday" name="rdo" value="rdholiday" onclick="radioClick();newValueSet();getNewGridValue(this.value);"><label for="rdholiday">Holiday</label></td>
    <td><select id="cmbholiday" name="cmbholiday" style="width:80%;" onchange="newValueSet();getNewGridValue(this.value);" value='<s:property value="cmbholiday"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbholiday" name="hidcmbholiday" value='<s:property value="hidcmbholiday"/>'/></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="2">
	  <fieldset hidden="true">
	 <table width="100%">
	 
</table>
	  </fieldset>
	</td>
    </tr>
    
  <tr hidden="true">
    <td><input type="radio" id="rdovertime" name="rdo" value="rdovertime" ><label for="rdovertime">Over Time</label></td>
    <td><div id="overtime" name="overtime"  value='<s:property value="overtime"/>'></div>
    <input type="hidden" id="hidovertime" name="hidovertime" value='<s:property value="hidovertime"/>'/></td>
  </tr>
  <tr hidden="true">
    <td colspan="2"><input type="radio" id="rdtotalleaves" name="rdo" value="rdtotalleaves" ><label id="rdtotalleaves1" for="rdtotalleaves"></label></td>
    </tr>
	<tr>
    <td hidden="true"><input type="checkbox" id="chckmarkall" name="chckmarkall" value=""  onclick="$(this).attr('value', this.checked ? 1 : 0)">Mark All
	    <input type="hidden" id="hidchckmarkall" name="hidchckmarkall" value='<s:property value="hidchckmarkall"/>'/></td>
    </tr>
    <tr>
     <!--       <td align="center"><input type="button" class="myButtonses" name="btnmark" id="btnmark"  value="Mark As Holiday" onclick="markHoliday();"/></td>   --> 
    
    </tr>
    <tr>
        <td colspan="3"><input type="button" class="myButtonses" name="btnView" id="btnView"  value="View" onclick="funViewAttendance();"/>&nbsp;&nbsp;&nbsp;&nbsp;
    
    <input type="button" class="myButtonses" name="btnsave" id="btnsave"  value="Save" onclick="funNotify();">&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="button" class="myButtonses" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td>
    
    </tr>
	
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    
<tr>
<tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr><tr>
    <td colspan="2">&nbsp;</td>
    </tr>
    
<tr>
    <td colspan="3">&nbsp;</td>
    </tr>
  <tr>
</table>
</fieldset>
    </td>
    <td width="80%">
    <table width="100%">
    <tr><td> <div id="attendanceDiv"><jsp:include page="attendanceGrid.jsp"></jsp:include></div></td></tr>
 <tr><td><div id="commentsDiv"><jsp:include page="commentsGrid.jsp"></jsp:include></div></td></tr>
  
</table>
</td>
</tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="txtattendancedocno" style="width:75%;" value='<s:property value="txtattendancedocno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtselectedemployee" name="txtselectedemployee" value='<s:property value="txtselectedemployee"/>'/>
<input type="hidden" id="txtselectedcellrow" name="txtselectedcellrow" value='<s:property value="txtselectedcellrow"/>'/>
<input type="hidden" id="txtselectedcellcolumn" name="txtselectedcellcolumn" value='<s:property value="txtselectedcellcolumn"/>'/>
<input type="hidden" id="txtselectedcellvalue" name="txtselectedcellvalue" value='<s:property value="txtselectedcellvalue"/>'/>
<input type="hidden" id="txtselectedcelltextvalue" name="txtselectedcelltextvalue" value='<s:property value="txtselectedcelltextvalue"/>'/>
<input type="hidden" id="txtselectedcellleave1totalvalue" name="txtselectedcellleave1totalvalue" value='<s:property value="txtselectedcellleave1totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave2totalvalue" name="txtselectedcellleave2totalvalue" value='<s:property value="txtselectedcellleave2totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave3totalvalue" name="txtselectedcellleave3totalvalue" value='<s:property value="txtselectedcellleave3totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave4totalvalue" name="txtselectedcellleave4totalvalue" value='<s:property value="txtselectedcellleave4totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave5totalvalue" name="txtselectedcellleave5totalvalue" value='<s:property value="txtselectedcellleave5totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave6totalvalue" name="txtselectedcellleave6totalvalue" value='<s:property value="txtselectedcellleave6totalvalue"/>'/>
<input type="hidden" id="txtemptotalleaves" name="txtemptotalleaves" value='<s:property value="txtemptotalleaves"/>'/>
<input type="hidden" id="txtemptotalleavesgridlength" name="txtemptotalleavesgridlength" value='<s:property value="txtemptotalleavesgridlength"/>'/>
<input type="hidden" id="txtselectedcellovertimevalue" name="txtselectedcellovertimevalue" value='<s:property value="txtselectedcellovertimevalue"/>'/>
<input type="hidden" id="txtselectedcellholidayovertimevalue" name="txtselectedcellholidayovertimevalue" value='<s:property value="txtselectedcellholidayovertimevalue"/>'/>
<input type="hidden" id="txtholidaysofmonth" name="txtholidaysofmonth" value='<s:property value="txtholidaysofmonth"/>'/>
<input type="hidden" id="txtmonthlypayrollprocessed" name="txtmonthlypayrollprocessed" value='<s:property value="txtmonthlypayrollprocessed"/>'/>
<input type="hidden" id="txtattendanceleaveseditgrid" name="txtattendanceleaveseditgrid" value='<s:property value="txtattendanceleaveseditgrid"/>'/>
<input type="hidden" id="txtmarkedattendance" name="txtmarkedattendance" value='<s:property value="txtmarkedattendance"/>'/>
<input type="hidden" id="txtrecheckemptotalleaves" name="txtrecheckemptotalleaves" value='<s:property value="txtrecheckemptotalleaves"/>'/>
<input type="hidden" id="txtrecheckemptotalleavesgridlength" name="txtrecheckemptotalleavesgridlength" value='<s:property value="txtrecheckemptotalleavesgridlength"/>'/>
<input type="hidden" id="gridlength" name="gridlength" style="width:75%;" value='<s:property value="gridlength"/>'/>
<input type="hidden" id="txtpholiday" name="txtpholiday" style="width:75%;" value='<s:property value="txtpholiday"/>'/>
<input type="hidden" id="hidcostcode" name="hidcostcode" style="width:75%;" value='<s:property value="hidcostcode"/>'/>
<input type="hidden" id="hidcosttype" name="hidcosttype" style="width:75%;" value='<s:property value="hidcosttype"/>'/>
<input type="hidden" id="hiddoc_no" name="hiddoc_no" style="width:75%;" value='<s:property value="hiddoc_no"/>'/>
<input type="hidden" id="hiddbname" name="hiddbname" style="width:75%;" value='<s:property value="hiddbname"/>'/>
<input type="hidden" id="hidday" name="hidday" style="width:75%;" value='<s:property value="hidday"/>'/>
<input type="hidden" id="hiddate" name="hiddate" style="width:75%;" value='<s:property value="hiddate"/>'/>
<input type="hidden" id="hidcode" name="hidcode" style="width:75%;" value='<s:property value="hidcode"/>'/>
<input type="hidden" id="hidtype" name="hidtype" style="width:75%;" value='<s:property value="hidtype"/>'/>
<input type="hidden" id="hiddb" name="hiddb" style="width:75%;" value='<s:property value="hiddb"/>'/>
<input type="hidden" id="hidalpha" name="hidalpha" style="width:75%;" value='<s:property value="hidalpha"/>'/>
<input type="hidden" id="hidsdate" name="hidsdate" style="width:75%;" value='<s:property value="hidsdate"/>'/>
<input type="hidden" id="hidedate" name="hidedate" style="width:75%;" value='<s:property value="hidedate"/>'/>

</div>
</form>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>
</html>
