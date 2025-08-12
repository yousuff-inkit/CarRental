
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#dateDue").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#timeDue").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	 
	 
	 
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

		   
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   
	   
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
	    
		 $("#duegridDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("#duegridDate1").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 
		 $('#dateDue').on('change', function (event) {
				
			   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); //del date
			 	 var outdate=new Date($('#duegridDate1').jqxDateTimeInput('getDate'));
			   /* if(indate1>agmtdate1){
				   
				   $.messager.alert('Message','Date Cannot Be Less Than Due Date  ','warning');   
				 
			   return false;
			  }   
			    */
	            if(outdate>agmtdate1){
				   
				   $.messager.alert('Message','Date Cannot Be Less Than Out Date  ','warning');   
				 
			   return false;
			  }   
		 });
	
});



/* function funExportBtn(){
	
	 JSONToCSVCon(dataildata, 'LA Due Date', true);
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Lease List');
	 }
 */
 
 
 function funExportBtn(){
		$("#detlist").excelexportjs({
			containerid: "detlist", 
			datatype: 'json', 
			dataset: null, 
			gridId: "detailsgrid", 
			columns: getColumns("detailsgrid") ,   
			worksheetName:"LA Due Date List"
			});
		
	}
function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	 else{
		 }
	 } 
function fleetSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);

	}); 
	} 
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	 clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	 else{
		 }
	 } 
function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var uptodate = $('#uptodate').val();
	  $("#overlay, #PleaseWait").show();
	 // $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&uptodate="+uptodate+"&cldocno="+document.getElementById("cldocno").value+"&fleet="+document.getElementById("fleet").value);
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&uptodate="+uptodate);
		
		  
	}


function  funcleardata()
{
	
	document.getElementById("cldocno").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	
	
	
	 if (document.getElementById("clientname").value == "") {
		
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
		  }
		  
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}	
function funchangeinfo()
{
  if($('#cmbinfo').val()==1)
	  {
	 
	 $('#dateDue').jqxDateTimeInput({ disabled: false});
	 $('#timeDue').jqxDateTimeInput({ disabled: true});
		$('#dateDue').jqxDateTimeInput('focus'); 
	 
	  }
  else if($('#cmbinfo').val()==2)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: false});
 $('#timeDue').jqxDateTimeInput({ disabled: true});
	$('#dateDue').jqxDateTimeInput('focus'); 
  }
  else if($('#cmbinfo').val()==3)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: true});
 $('#timeDue').jqxDateTimeInput({ disabled: true});
 document.getElementById("remarks").focus();
 
  }
	 
	
	}
	
function disitems()
{
	
	 $('#dateDue').jqxDateTimeInput({ disabled: true});
	 $('#timeDue').jqxDateTimeInput({ disabled: true});
	 
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	

	
}

function funupdate()
{
	
	
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
					 
		 return 0;
	 }
	
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		
		 
		
		 return 0;
	 }
	 
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
		
		
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   
   	 
   	 
   	   } 
	 
	 
	
	 var rentaldocno = document.getElementById("rentaldoc").value;
	 var branchids = document.getElementById("branchids").value;
	 var remarks = document.getElementById("remarks").value;
	 var cmbinfo = document.getElementById("cmbinfo").value;
	 var exdate =  $('#dateDue').val();
	 var extime =  $('#timeDue').val();
	 var duedategd =  $('#duegridDate').val();
	 if($('#cmbinfo').val()!=3)
	  {
	 var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
	 var outdate=new Date($('#duegridDate1').jqxDateTimeInput('getDate'));
		
	  // out date
	 	 var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); //del date
	 	 
	   /* if(indate1>agmtdate1){
		   
		   $.messager.alert('Message',' Date Cannot Be Less Than Due Date ','warning');      
		  
	   return false;
	  }  */  
	 	 
      if(outdate>agmtdate1){
		   
		   $.messager.alert('Message',' Date Cannot Be Less Than Out Date ','warning');      
		  
	   return false;
	  }   
	  }

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd);	
	     	}
		     });
	
	
	
}
function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 document.getElementById("fleetno").value="";
			 document.getElementById("rentaldoc").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			  $('#dateDue').val(new Date());
			  $('#timeDue').val(new Date());
			  $('#duegridDate').val("");
			
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');
			 disitems();
			 
			
			}
		
	}
		
x.open("GET","saveduedate.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&extime="+extime+"&duedategd="+duedategd,true);

x.send();
		
}

function funduedatesms(){
	
	 /* if($('#docno').val()=="" || $('#docno').val()=="Null"){
		$.messager.alert("warning","Please select Driver");
		return false;
	}  */
	if(document.getElementById("cmbbranch").value=="a")
	 {
		 $.messager.alert('Message','Select Branch ','warning');   
					 
		 return 0;
	 }
	 
   /* var url=document.URL;
   alert(url);
   var reurl=url.split("/Rentalagreement/dueDate/duedateMaster.jsp");
   reurl[0]=reurl[0]+"/rentalagreement/";
   alert(reurl[0]);
   var win= window.open(reurl[0]+"duedatesmssend1?dtype=BVDD"+'&branch='+document.getElementById("cmbbranch").value+'&docno='+document.getElementById("rentaldoc").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
  
   win.focus();  */
	 var uri=encodeURI('com/dashboard/leaseagreement/duedatesmssend1.action?dtype=BLDR'+'&branch='+document.getElementById("cmbbranch").value+'&docno='+document.getElementById("rentaldoc").value);
	//alert(uri);
   $.ajaxFileUpload  
    (    
        {  
            url: uri,
            secureuri:false,//false  
            fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            dataType: 'String',// json  
            success: function (data, status)  //  
            {  
                //alert(data.message);//jsonmessage,messagestruts2
           	
         //       $('#refreshdiv').load();
               
               if(status=='success'){
             
              	/*  getapprcount(); */
                   $.messager.show({title:'Message',msg:'Msg Sent',showType:'show',
                      style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
                }
               
                if(typeof(data.error) != 'undefined')  
                {  
                    if(data.error != '')  
                    {  
                        //$.messager.alert('Message',data.error);
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }else  
                    {  
                        //$.messager.alert('Message',data.message);
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
 	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
 	                        }); 
                    }  
                }  
            },  
            error: function (data, status, e)//  
            {  
                //alert(e);  
                $.messager.alert('Message',e);
            }  
        }  
    )  
 

}

</script>
<style>
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


</style>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<%-- <td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	<td align="right" width="20%"><label class="branch">Up To</label></td>
            <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
	</tr> 
	 <tr><td colspan="2"></td></tr>
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td></tr> 
  <tr><td align="right"><label class="branch">Fleet</label></td><td align="left"><input type="text" name="fleet" id="fleet"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getfleet(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="fleet"/>' ></td></tr> 
   
	 <tr><td colspan="2"></td></tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
      
	<tr>
	 <tr><td colspan="2"></td></tr>
	 <tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 270px;"></div></td> 
	</tr>	
	</table>
	</fieldset>
	
	
	<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	
</td> --%>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	   <tr>
	<td align="right" width="20%"><label class="branch">Up To</label></td>
            <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
	</tr>
	 <tr><td align="right"><label class="branch">Fleet NO</label></td>
	 <td align="left"><input type="text" id="fleetno" style="height:20px;width:70%;" name="fleetno"  value='<s:property value="fleetno"/>' readonly="readonly"> </td></tr>
	<tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
 <select name="cmbinfo" id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
       

</select></td></tr>

	<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='dateDue' name='dateDue' value='<s:property value="dateDue"/>'></div>
                   </td></tr>
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timeDue' name='timeDue' value='<s:property value="timeDue"/>'  ></div>
                </td></tr>
	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
	<!-- <tr><td  align="center" colspan="2"><input type="Button" name="driversms" id="driversms" class="myButton" value="SEND SMS" onclick="funduedatesms()"></td> </tr>
	 -->
	 <tr><td colspan="2">&nbsp;</td></tr>  
 <tr><td colspan="2">&nbsp;</td></tr>  
 <tr><td colspan="2">&nbsp;</td></tr>  
 <tr><td colspan="2">&nbsp;</td></tr>  
 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>

	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>




  </table>
   <input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
<div hidden="hidden" id='duegridDate' name='duegridDate' value='<s:property value="duegridDate"/>'></div>	 
<div hidden="hidden" id='duegridDate1' name='duegridDate1' value='<s:property value="duegridDate1"/>'></div>	 
	 
   </fieldset>

</td>

<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detlist"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td>
		</tr>
		
		<tr>
		<td colspan="2" align="left" ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
		
	</table>
</tr>
</table>

</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>

</div>
</div>
</body>
</html>
	 