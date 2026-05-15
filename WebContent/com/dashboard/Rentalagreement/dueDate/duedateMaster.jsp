
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("#uptodate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#dateDue").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#timeDue").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	 
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

function funExportBtn(){
    

	   JSONToCSVConvertor(duedateexcel, 'Due Date List', true);
	   }
	  
	  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

	      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	      
	     // alert("arrData");
	      var CSV = '';    
	      //Set Report title in first row or line
	      
	      CSV += ReportTitle + '\r\n\n';

	      //This condition will generate the Label/Header
	      if (ShowLabel) {
	          var row = "";
	          
	          //This loop will extract the label from 1st index of on array
	          for (var index in arrData[0]) {
	              
	              //Now convert each value to string and comma-seprated
	              row += index + ',';
	          }

	          row = row.slice(0, -1);
	          
	          //append Label row with line break
	          CSV += row + '\r\n';
	      }
	      
	      //1st loop is to extract each row
	      for (var i = 0; i < arrData.length; i++) {
	          var row = "";
	          
	          //2nd loop will extract each column and convert it in string comma-seprated
	          for (var index in arrData[i]) {
	              row += '"' + arrData[i][index] + '",';
	          }

	          row.slice(0, row.length - 1);
	          
	          //add a line break after each row
	          CSV += row + '\r\n';
	      }

	      if (CSV == '') {        
	          alert("Invalid data");
	          return;
	      }   
	      
	      //Generate a file name
	      var fileName = "";
	      //this will remove the blank-spaces from the title and replace it with an underscore
	      fileName += ReportTitle.replace(/ /g,"_");   
	      
	      //Initialize file format you want csv or xls
	      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	      
	      // Now the little tricky part.
	      // you can use either>> window.open(uri);
	      // but this will not work in some browsers
	      // or you will not get the correct file extension    
	      
	      //this trick will generate a temp <a /> tag
	      var link = document.createElement("a");    
	      link.href = uri;
	      
	      //set the visibility hidden so it will not effect on your web-layout
	      link.style = "visibility:hidden";
	      link.download = fileName + ".csv";
	      
	      //this part will append the anchor tag and remove it after automatic click
	      document.body.appendChild(link);
	      link.click();
	      document.body.removeChild(link);
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


function funreload(event)
{
	var uptodate = $('#uptodate').val();
	 var barchval = document.getElementById("cmbbranch").value;
	 $("#duedetailsgrid").jqxGrid('clear');
	   $("#overlay, #PleaseWait").show();
	  $("#duedatediv").load("duedateGrid.jsp?barchval="+barchval+"&uptodate="+uptodate);
	
	
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
		 var uri=encodeURI('com/dashboard/rentalagreement/duedatesmssend1.action?dtype=BVDD'+'&branch='+document.getElementById("cmbbranch").value+'&docno='+document.getElementById("rentaldoc").value);
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
function setValues(){
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	}
</script>
</head>
<style type="text/css">
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 80%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

.btn-submit, .myButton, .myButtons {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover, .myButton:hover, .myButtons:hover {
    background: #1d4ed8 !important;
}



.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}
</style>
<body onload="getBranch();getinfo();disitems();setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet NO</td>
                        <td><input type="text" id="fleetno" name="fleetno" value='<s:property value="fleetno"/>' readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Process</td>
                        <td>
                            <select name="cmbinfo" id="cmbinfo" value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td><div id='dateDue' name='dateDue' value='<s:property value="dateDue"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Time</td>
                        <td><div id='timeDue' name='timeDue' value='<s:property value="timeDue"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'></td>
                    </tr>
                </table>
            </div>

           <div class="filter-card">

    <input type="button"
           name="driverUpdate"
           id="driverUpdate"
           class="myButton"
           value="UPDATE"
           onclick="funupdate()"
           style="width:100%; margin-bottom:6px;">

    <input type="button"
           name="driversms"
           id="driversms"
           class="myButton"
           value="SEND SMS"
           onclick="funduedatesms()"
           style="width:100%;">

</div>
            <div style="display:none;">
                <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>' >
                <div id='duegridDate' name='duegridDate' value='<s:property value="duegridDate"/>'></div>
                <div id='duegridDate1' name='duegridDate1' value='<s:property value="duegridDate1"/>'></div>
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="duedatediv">
                <jsp:include page="duedateGrid.jsp"></jsp:include>
            </div>
            <div id="detaildiv">
                <jsp:include page="detailgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</body>
