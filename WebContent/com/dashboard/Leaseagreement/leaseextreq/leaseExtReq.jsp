<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>LA Extension Approval</title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>   
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script> 
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />
  
  <style type="text/css">
   .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 10px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    } 
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .custompanel2{
      float: left;
      display: inline-block;
       margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;  
      border-radius: 8px;  
    }
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel{
      color: blue;
    } 
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	 .fieldset{
 border: 1px solid #ccc;
    padding: 10px;	}
	/* #field-existing > table > tbody > tr > td,#field-extend > table > tbody > tr > td,,#field-paymentdet > table > tbody > tr > td{
		font:13px Tahoma;
	} */
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
/* 	.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  .padtop{
        padding-top: 5px; 
    }
  </style>
</head>
<body onload="getBranch();" >
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
        <div class="primarypanel custompanel">
	                       <div class="form-group col-auto">
				           <label class="form-group" for="cmbpriority">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" onchange="funload();"></select>
    						</div>  
    						</div>
    						 <!-- <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">To:</label>
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div> -->
			                </div>		  
					  <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<!-- <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button> -->
        </div>
         <div class="otherpanel custompanel">         
          <button type="button" class="btn btn-default" id="btnfollowup" ><i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title=" Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnrequest"><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip"  title=" Request" data-placement="bottom"></i></button>
      <!--     <button type="button" class="btn btn-default" id="btnappr"><i class="fa fa-adn" aria-hidden="true" data-toggle="tooltip"  title="Approve" data-placement="bottom"></i></button>
    -->     
         </div> 
         <div class="textpanel custompanel2" >
				   <label for="divid" id="selecteddiv" style="font-size:70%;"></label>  
				   				<p  style="font-size:75%;">&nbsp;</p>
				         
	           </div>
				         
	           </div>
	          
	         
	          
				</form>        
			</div> 
		</div>	 
		<div class="row">
           
        </div>    
      </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="agmtdiv"><jsp:include page="agmtGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
    <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      
      <div></div>
      <div></div>
      <table width="100%" border="1">
		
		<tr>
			<td width="55%" >
				<fieldset id= field-existing><legend>Existing Details</legend>
					<table style="width:100%;"  >
						<tr>
							<td width="22%">Total Amount of Contract</td>
							<td width="23%" align="left"><input type="text" name="exstamt" id="exstamt"  style="text-align:right;"></td>
						
							<td width="33%">Period & Payment Details with Cheques</td>
							<td width="18%" align="left"><input type="text" name="exstpaydet" id="exstpaydet"  ></td>
						</tr>
						<tr>
							<td width="22%">Residual Value</td>
							<td width="23%" align="left"><input type="text" name="exstresvalue" id="exstresvalue" style="text-align:right;" ></td>
						
							<td width="33%">Last deprecated Date and Value</td>
							<td width="18%" align="left"><input type="text" name="deprval" id="deprval" style="text-align:right;" ></td>
						</tr>
					</table>
				</fieldset>
			</td>
			<td width="45%" >
				<fieldset id=field-extension><legend>Extension Details</legend>
					<table style="width:100%;"  >
						<tr>
							<td width="30%">Total Amount of Additional months</td>
							<td width="17%"><input type="text" name="pyttotalrent" id="pyttotalrent"  style="text-align:right;">
							</td>
						
							<td width="19%">Extension Till Date</td>
							<td width="20%"><div id="extdate" name="extdate" ></div></td>
						</tr>
						<tr>
							<td width="30%">New Residual Value</td>
							<td width="17%"><input type="text" name="nwrsdvalue" id="nwrsdvalue" style="text-align:right;"></td>
						
							<td></td>
							<td></td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
		
	</table>
	<div></div>
	<div></div>
	<table width="100%">
		<tr>
		<td>
		<fieldset id="field-paymentdet"><legend>Payment Details</legend>
  <table width="100%" >
  <tr hidden="true">
 <!--    <td width="10%" align="right">Total Rent</td>
    <td width="14%" align="left"><input type="text" name="pyttotalrent" id="pyttotalrent"  style="text-align:right;"  onblur="funRoundAmt(value,id);"></td>
  --> 
    <td width="12%" align="right">Advance</td>
    <td width="12%" align="left"><input type="text" name="pytadvance" id="pytadvance"  onblur="getPytBalance();funRoundAmt(value,id);"  style="text-align:right;" ></td>
    <td width="10%" align="right">Balance</td>
    <td colspan="2" align="left"><input type="text" name="pytbalance" id="pytbalance"  style="text-align:right;"  onblur="funRoundAmt(value,id);"></td>
<!--     <td align="center"><button type="button" name="btnpytprint" id="btnpytprint" class="myButton" onClick="funPytPrint();">Print</button></td>
 -->  </tr>
  <tr>
    <td width="6%"align="left">Start Date</td>
    <td width="6%"align="left"><div id="pytstartdate" name="pytstartdate" ></div></td>
    <td width="7%"align="left">No. of Months</td>
    <td width="4%"align="left"><input type="text" name="pytmonthsno" id="pytmonthsno" ></td>
    <td width="4%"align="left">Bank A/c</td>
    <td width="19%"><input type="text" name="pytbankacno" id="pytbankacno"  readonly onkeydown="getBankAcc(event);" placeholder="Press F3 to Search" style="width:100%;">
        <input type="hidden" name="hidpytbankacno" id="hidpytbankacno" value='<s:property value="hidpytbankacno"/>'>
    
    <td width="10%" align="center"><button type="button" name="btnpytedit" id="btnpytedit" class="myButton" onClick="funPytEdit();">Edit</button>
      
      <button type="button" name="btnprocess" id="btnprocess" style="background-color:transparent;border:none;outline:none;" onclick="funPytProcess();"><img src="../../../../icons/process2.png" alt="" width="32" height="30"></button>
    </td>
    <td width="19%" align="center">
    <button type="button" name="btnpytsave" id="btnpytsave" class="myButton" onClick="funPytSave();">Save</button>&nbsp;&nbsp;
      <button type="button" name="btnpytcancel" id="btnpytcancel" class="myButton">Cancel</button>
    </td>
    <td width="12%" align="center"><button type="button" name="btncreatecheque" id="btncreatecheque" class="myButton" onClick="funCreateCheques();">Create Uncleared Cheque Reciepts</button></td>
<!--         <td align="center"><button type="button" name="btnpytprint" id="btnpytprint" class="myButton" onClick="funPytPrint();">Print</button></td>
 -->    
    </tr>
    </table>
  
  <table width="100%"  >

 <tr>
    <td colspan="8" height="200px">&nbsp;<div id="pytdetailsdiv"><jsp:include page="pytDetailsGrid.jsp"></jsp:include></div></td>
    <!-- <td width="28%">&nbsp;</td> -->
    </tr>
    <tr></tr>
    <tr></tr>
</table>

  </fieldset>
  </td>
  </tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
   <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
	</table>
      
      
      </div>
    </div>
	
	 <div id="modalrequest" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Extension Request<span></span></h4>      
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						
						 <div class="form-group">
						     <label class="control-label col-sm-3" for="reqdate">Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="reqdate"></div>
						     </div>
						  </div>
						  <div class="form-group">
    						<label class="control-label col-sm-3" for="reqamt">Total Amount:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="reqamt" name="reqamt" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<div class="form-group">
						     <label class="control-label col-sm-3" for="exttilldate"> Extension Till</label>   
						      <div class="col-sm-9 input-container">
						     <div id="exttilldate"></div>
						     </div>
						  </div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="newresval"> Residual Value:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="newresval" name="newresval" style="width:70%;"  >
    						</div>   						     
  						</div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="reqremarks">Remarks</label>    
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="reqremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="reqremarks"  class="form-control input-sm"></textarea>
  						</div>
  						</div> 
  									 
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnreq">Save</button>
          		
          		</div>
          		</div>
        </div>
      </div>
      
      <div id="modalfollowup" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Follow-Up<span></span></h4>      
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						
						 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="flwupdate"></div>
						     </div>
						  </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="Remarks">Remarks</label>    
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="flwupremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="flwupremarks"  class="form-control input-sm"></textarea>
  						</div>
  						</div> 
  						<div class="row" style="padding-top: 5px">
     						 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
     					     <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
    					     </div>
                        </div> 
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnflwp">Save</button>
          		</div>
          		</div>
        </div>
      </div>
    
   
       <input type="hidden" name="divname" id="divname"> 
       <input type="hidden" id="agmtvocno" name="agmtvocno">
	   <input type="hidden" id="agmtdocno" name="agmtdocno">
       <input type="hidden" id="extdocno" name="extdocno">
       <input type="hidden" id="date1" name="date1">
       <input type="hidden" id="le_clacno" name="le_clacno">
       <input type="hidden" id="extno" name="extno">
       <input type="hidden" id="brhid1" name="brhid1">
       <input type="hidden" id="hidapprstatus" name="hidapprstatus">
       <input type="hidden" id="hidperfleet" name="hidperfleet">
             <input type="hidden" id="hidfromdt" name="hidfromdt">
             <input type="hidden" id="hidtodt" name="hidtodt">
      
       
       
       
            
  <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="areainfowindow">
   <div ></div>
</div>
<div id="sourcesearchwndow">
   <div ></div>
</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){  
   	 $("#pytstartdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
   	 $("#extdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
   	 $("#exttilldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
   	 $("#reqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  $('#pytDetailsGrid').jqxGrid({disabled:true});

    		$('#pyttotalrent,#pytadvance,#pytbalance,#pytstartdate,#pytmonthsno,#pytbankacno').change(function(){
    			$('#pytDetailsGrid').jqxGrid('clear');
    		});
    		$('#btnpytsave,#btnpytcancel,#btnprocess,#btncreatecheque').hide();
    		$('#btnpytedit').attr('disabled',true);	
    		
    		 $('#bankacnowindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Bank Account Search' ,position: {  x: 250, y: 60 }, keyboardCloseKey: 27});
    		 $('#bankacnowindow').jqxWindow('close');
    		 $('#field-extension').attr("disabled",true);

    	$('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	    $('#areainfowindow').jqxWindow('close');
   	    $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#sourcesearchwndow').jqxWindow('close');
		$("#flwupdate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#date1").jqxDateTimeInput({ width: '100px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#hidfromdt").jqxDateTimeInput({ width: '100px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#hidtodt").jqxDateTimeInput({ width: '100px', height: '22px', formatString:"dd.MM.yyyy"});

		/* $("#fromdate").jqxDateTimeInput({ width: '100px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		 */
		$('#exttilldate').val(new Date(''));
	   // $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		/* $('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   if(fromdates<todates){
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'To Date Less Than From Date'
					});
			        return false;  
			  }   
		 }); */
		$('#pytbankacno').dblclick(function(){
		    $('#bankacnowindow').jqxWindow('open');
		  $('#bankacnowindow').jqxWindow('focus');
		 bankacnoSearchContent('getBankAccount.jsp?id=1');
		 });
    
    	 $('#btnenqview').click(function(){  
			 var lprdocno=$('#lprdocno').val();
	        	if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			viewEnquiry(); 
        	//funcleardata();

		});
    	
    	 $('#btnflwp').click(function(){
 			var process="1";

			  funflwp(process);
	        	//funcleardata();

	      });
    	 
    	 $('#btnreq').click(function(){
 			var process="2";

			  funflwp(process);
	        	//funcleardata();

	      });
    	 $('#btnappr').click(function(){
    		  var agmtdocno=$('#agmtdocno').val();  
  		    var approvalstatus=$('#hidapprstatus').val();  
  		    if(approvalstatus=="1"){
          		Swal.fire({
          			icon: 'warning',
  					title: 'Warning',
  					text: 'Already Approved'
  				});
          		return false;
      	    }
          	if(agmtdocno==""){
          		Swal.fire({
          			icon: 'warning',
  					title: 'Warning',
  					text: 'Please select a document'
  				});
          		return false;
      	    }
          	 var extdocno=$('#extdocno').val();  
           	if(extdocno==""){
           		Swal.fire({
           			icon: 'warning',
   					title: 'Warning',
   					text: 'Please Request for Extension'
   				});
           		return false;
       	    }
           	
    		 
    		 
  			var process="3";

 			  funflwp(process);
 	        	//funcleardata();

 	      });
		
		$('#btnsubmit').click(function(){   
			 $('.load-wrapp').show();
	        	funcleardata();

			 funload();
			  $('.textpanel p').text('');  


		});
		$('#btnexcel').click(function(){
			$("#agmtdiv").excelexportjs({  
				containerid: "agmtdiv",
				datatype: 'json',
				dataset: null,
				gridId: "agmtGrid",
				columns: getColumns("agmtGrid"),
				worksheetName: "Lease Agreement Extension Request "
			});
		});
		
       
       
        $('#btnfollowup').click(function(){
		    var agmtdocno=$('#agmtdocno').val();  
        	if(agmtdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
    	    }  
           $('#modalfollowup').modal('show');
        });
        $('#btnrequest').click(function(){
		    var agmtdocno=$('#agmtdocno').val();  
        	if(agmtdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
    	    }
        	 var extdocno=$('#extdocno').val();  
         	if(extdocno!="" && $('#hidapprstatus').val()!="1"){
         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Already Requested'
 				});
         		return false;
     	    } 
           $('#modalrequest').modal('show');
        });
        
        $('#btnapprove').click(function(){
		    var agmtdocno=$('#agmtdocno').val();  
		    var approvalstatus=$('#hidapprstatus').val();  
		//    alert("++=="+approvalstatus+"----");
		    if(approvalstatus=="1"){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Already Approved'
				});
        		return false;
    	    }
        	if(agmtdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
    	    }
        	 var extdocno=$('#extdocno').val();  
         	if(extdocno==""){
         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Please Request for Extension'
 				});
         		return false;
     	    }
         	
         	var rows=$('#pytDetailsGrid').jqxGrid('getrows');
    		var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');

    		if(rows.length=="0")
    			{
    			Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Enter Payment Details'
 				});
         		return false;
    			}
    		
    		if(bpvno=="")
			{
			Swal.fire({
     			icon: 'warning',
					title: 'Warning',
					text: 'Uncleared Cheque Reciept Not Created '
				});
     		return false;
			}
         	
           $('#modalapprove').modal('show');
        });
		
        
	});
   
    function bankacnoSearchContent(url) {
    	$.get(url).done(function (data) {
    	$('#bankacnowindow').jqxWindow('setContent', data);
    	  }); 
    	}
 	
	
	function funRoundAmt(value,id){
			  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
			 }
		
	 
		function funload(){
			// $("#amcfollowupGrid").jqxGrid('clear');
			 var brhid=$('#cmbbranch').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			$('#agmtdiv').load('agmtGrid.jsp?brhid='+brhid);  
		}
		function getBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				//alert(items);
					items = items.split('####');
					
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var perm = items[2];  
					var optionsbranch;
					 if(perm==0){
					 optionsbranch = '<option value="a" selected>All</option>';
					}
					else{    
						
					}
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#cmbbranch").html(optionsbranch);
					/* if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					} */
				} else {
					//alert("Error");
				}  
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);  
			x.send();
		} 
	
		function funflwp(process){
			var brhid=document.getElementById("brhid1").value;
			var flwpdate =  $('#flwupdate').val();
			var flwpremarks = $('#flwupremarks').val().replace(/\n/g, '');
			var agmtdocno = $('#agmtdocno').val();  
			var reqdate =  $('#reqdate').val();
			var reqremarks = $('#reqremarks').val().replace(/\n/g, '');
			var exttilldate =  $('#exttilldate').val();
			var reqamt = $('#reqamt').val();
			var newresval = $('#newresval').val();
			var extdocno = $('#extdocno').val();
			var extno = $('#extno').val();
			var perfleet = $('#hidperfleet').val();
			var rdtype = "LAER"; 
			var fromdt =  $('#hidfromdt').val();
			var todt =  $('#hidtodt').val();
//alert(fromdt+"-------"+todt);
			if(process==1)
{
			if(flwpremarks==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Enter Remarks.'
					});
	  		      return false;
			 }
}
			else if(process=="2")
				{
				if(exttilldate==''){
					
					 swal.fire({
						    icon: 'warning',
							title: 'Warning',
							text: 'Please Select Extension Till Date.'
						});
		  		      return false;
				 }
				}
			else if(process=="3")
			{
				if(extdocno==""){
	         		Swal.fire({
	         			icon: 'warning',
	 					title: 'Warning',
	 					text: 'Please Request for Extension'
	 				});
	         		return false;
	     	    }
	         	
	         	var rows=$('#pytDetailsGrid').jqxGrid('getrows');
	    		var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');

	    		if(rows.length=="0")
	    			{
	    			Swal.fire({
	         			icon: 'warning',
	 					title: 'Warning',
	 					text: 'Enter Payment Details'
	 				});
	         		return false;
	    			}
	    		
	    		if(bpvno=="")
				{
				Swal.fire({
	     			icon: 'warning',
						title: 'Warning',
						text: 'Uncleared Cheque Reciept Not Created '
					});
	     		return false;
				}
			
			}
			 Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$('.load-wrapp').show();
						saveflwp(flwpdate,agmtdocno,rdtype,flwpremarks,brhid,process,reqdate,exttilldate,reqremarks,reqamt,newresval,extdocno,extno,perfleet,fromdt,todt);       
					}
			});
		}
		function saveflwp(flwpdate,agmtdocno,rdtype,flwpremarks,brhid,process,reqdate,exttilldate,reqremarks,reqamt,newresval,extdocno,extno,perfleet,fromdt,todt){          
		//	alert("inside");
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)=="1"){  	  
								$('#btnsubmit').trigger('click');  
									 swal.fire({  
										    icon: 'success',
											title: 'Success',
											text: 'Successfully Updated'  
										});
                                    
										 $("#detailDiv").load("detailGrid.jsp?doc="+agmtdocno);  
										 $('#agmtdiv').load('agmtGrid.jsp?brhid='+brhid);  

									 
                                     //funcleardata();
							}else{
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Updated'    
										});
							}
						 $('#modalfollowup').modal('hide');  
						 $('#modalrequest').modal('hide');  
						// funcleardata();

					}
			}  
		//	alert("saveData.jsp?flwpdate="+flwpdate+"&rdtype="+rdtype+"&docno="+agmtdocno+"&brhid="+brhid+"&flwpremarks="+encodeURIComponent(flwpremarks)+"&process="+process+"&reqdate="+reqdate+"&exttilldate="+exttilldate+"&reqamt="+reqamt+"&reqremarks="+encodeURIComponent(reqremarks)+"&newresval="+newresval+"&fromdt="+fromdt+"&todt="+todt);
		x.open("GET","saveData.jsp?flwpdate="+flwpdate+"&rdtype="+rdtype+"&docno="+agmtdocno+"&brhid="+brhid+"&flwpremarks="+encodeURIComponent(flwpremarks)+"&process="+process+"&reqdate="+reqdate+"&exttilldate="+exttilldate+"&reqamt="+reqamt+"&reqremarks="+encodeURIComponent(reqremarks)+"&newresval="+newresval+"&extdocno="+extdocno+"&extno="+extno+"&perfleet="+perfleet+"&fromdt="+fromdt+"&todt="+todt,true);       
		x.send();
		}
		
		
		
	
		function  funcleardata()
		{
			$('input[type=text],[type=hidden]').val('');
			$('#extdate').val(new Date(''));
			$('#pytstartdate').val(new Date(''));
			 $("#pytDetailsGrid").jqxGrid('clear');
			 $("#pytDetailsGrid").jqxGrid('clear');

			  $('.textpanel p').text('');  
				document.getElementById("brhid1").value="";
	             document.getElementById("agmtdocno").value="";
	             document.getElementById("extdocno").value="";
	     	
	             document.getElementById("flwupremarks").value="";
	             document.getElementById("reqremarks").value="";
	             document.getElementById("reqamt").value="";
	             document.getElementById("newresval").value="";
	             document.getElementById("flwupremarks").value="";
	             document.getElementById("flwupremarks").value="";
	             document.getElementById("flwupremarks").value="";

			//  $('#date').val(new Date());
			
				  		
			}
		
		
		
		
		





		function getPytBalance(){
		var total=parseFloat(document.getElementById("pyttotalrent").value==null || document.getElementById("pyttotalrent").value=="" ?"0":document.getElementById("pyttotalrent").value);
		var advance=parseFloat(document.getElementById("pytadvance").value==null || document.getElementById("pytadvance").value=="" ?"0":document.getElementById("pytadvance").value);
		document.getElementById("pytbalance").value=total-advance;	
		}


		function funPytProcess(){
			//alert("totalrent"+document.getElementById("pyttotalrent").value);

		var totalrent=document.getElementById("pyttotalrent").value.replace(",","").trim();
		//alert(totalrent);
		if(totalrent=="")
			{
			 swal.fire({
				    icon: 'warning',
					title: 'Warning',
					text: 'Total Amount not Entered.'
				});
		      return false;
			}
		var advance="";
		if(advance==""){
			advance=0;
		}
		document.getElementById("pytbalance").value=totalrent;
		document.getElementById("pytadvance").value=advance;
		funRoundAmt($('#pytbalance').val(),"pytbalance");
		funRoundAmt($('#pytadvance').val(),"pytadvance");
		if($('#pytstartdate').jqxDateTimeInput('getDate')==null){
			//document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Payment Start Date is Mandatory";
			return false;
		}
		else{
			//document.getElementById("errormsg").innerText="";
			
			//alert('pytDetailsGrid.jsp?docno='+document.getElementById('agmtdocno').value+'&pytstartdate='+$('#pytstartdate').jqxDateTimeInput('val')+'&pytadvance='+$('#pytadvance').val()+'&pytbalance='+$('#pytbalance').val()+'&pytmonthno='+$('#pytmonthsno').val()+"&id=1");
			$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('extdocno').value+'&pytstartdate='+$('#pytstartdate').jqxDateTimeInput('val')+'&pytadvance='+$('#pytadvance').val()+'&pytbalance='+$('#pytbalance').val()+'&pytmonthno='+$('#pytmonthsno').val()+"&id=1");
		}

		}

		function funCreateCheques(){
			//alert("inside");
		var pytrows=$('#pytDetailsGrid').jqxGrid('getrows');
		var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');
		if(bpvno!="" && bpvno!="undefined" && typeof(bpvno)!="undefined" && bpvno!=null){
			return false;
		}

		if(document.getElementById("pytbankacno").value==""){
		//document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Bank Account is Mandatory";
			return false;
		}
		/* else{
			document.getElementById("errormsg").innerText="";
		} */

		if(pytrows.length==0){
	//	document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Process";
		return false;
		}
		else{
		//document.getElementById("errormsg").innerText="";
		var chequearray=new Array();
		var mstr_frm_date=$('#date1').jqxDateTimeInput('val');
		//alert("mstr_frm_date=="+mstr_frm_date);
		var docno=$('#extdocno').val();
		var bankacno=$('#hidpytbankacno').val();
		var clientacno=$('#le_clacno').val();
		var selectedrows=$('#pytDetailsGrid').jqxGrid('getselectedrowindexes');
		for(var i=0;i<parseInt(pytrows.length);i++){
			for(var j=0;j<parseInt(selectedrows.length);j++){
				if(i==selectedrows[j]){
					var date=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'date');
					var amount=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'amount');
					var chequeno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'chequeno');
					var detaildocno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'detaildocno');
				//	alert(date+"::"+amount+"::"+chequeno+"::"+detaildocno);
					
					chequearray.push(date + " :: "+ amount + " :: " + chequeno + "::"+ detaildocno);				
				}
			}

		}
		var cashlength=parseInt(pytrows.length)-parseInt(selectedrows.length);
		$.messager.confirm('Confirm', ''+cashlength+' payments are considered as cash/card payments', function(r){
			if (r){
				createchequesAJAX(chequearray,docno,bankacno,clientacno,mstr_frm_date);	
			}
				});

		}



		}

		function createchequesAJAX(chequearray,docno,bankacno,clientacno,mstr_frm_date){
		var masterdocno=document.getElementById("extdocno").value;
		var pyttotalrent=document.getElementById('pyttotalrent').value;
		var pytadvance="0";
		var pytbalance=document.getElementById("pyttotalrent").value;
		var pytmonthsno=document.getElementById("pytmonthsno").value;
		var pytstartdate=$('#pytstartdate').jqxDateTimeInput('val');
		var pytbankacno=document.getElementById("hidpytbankacno").value;
		var agmtvocno=document.getElementById("agmtvocno").value;
		var brhid1=document.getElementById("brhid1").value;
		var rsdval=document.getElementById("nwrsdvalue").value;
		var extdate=$('#extdate').jqxDateTimeInput('val');

		
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items= x.responseText.trim();
			if(items=="1"){
				
				/* $('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&id=2');
				var rows=$('#pytDetailsGrid').jqxGrid('getrows');
		    	var count=0;
		    	for(var i=0;i<rows.length;i++){
		    		var reciept=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno');
		    		if(reciept!="undefined" && reciept!=null && reciept!="" && typeof(reciept)!="undefined"){

		    		}
		    		else{
		    			count++;
		    		}
		    	}
				if(count!=0){
					$.messager.alert('message',''+count+' payments are considered as cash/card payments');				
				}
				else{
					$.messager.alert('message','Successfully Generated');
				} */
				$.messager.alert('message','Successfully Generated');
				funPytCancel();
                funload();
				$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('extdocno').value+'&id=2');
			}
			else{
				$.messager.alert('message','Not Generated');
			}
			
		}
		else
		{
		}
		}
		//alert('createChequeAJAX.jsp?chequearray='+chequearray+'&docno='+docno+'&bankacno='+bankacno+'&clientacno='+clientacno+'&masterdocno='+masterdocno+'&pyttotalrent='+pyttotalrent+'&pytadvance='+pytadvance+'&pytbalance='+pytbalance+'&pytmonthsno='+pytmonthsno+'&pytstartdate='+pytstartdate+'&pytbankacno='+pytbankacno+'&mstr_frm_date='+mstr_frm_date);
		x.open("GET", 'createChequeAJAX.jsp?chequearray='+chequearray+'&docno='+docno+'&bankacno='+bankacno+'&clientacno='+clientacno+'&masterdocno='+masterdocno+'&pyttotalrent='+pyttotalrent+'&pytadvance='+pytadvance+'&pytbalance='+pytbalance+'&pytmonthsno='+pytmonthsno+'&pytstartdate='+pytstartdate+'&pytbankacno='+pytbankacno+'&mstr_frm_date='+mstr_frm_date+"&brhid1="+brhid1+"&agmtvocno="+agmtvocno, true);
		x.send();
		}


		function funPytEdit(){
			  $('#pytDetailsGrid').jqxGrid({disabled:false});

		var pytrows=$('#pytDetailsGrid').jqxGrid('getrows');
		var bpvno=0;
		for(var i=0;i<pytrows.length;i++){
			var checkbpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno');
			if(checkbpvno!="" && checkbpvno!="undefined" && typeof(checkbpvno)!="undefined" && checkbpvno!=null){
				bpvno=checkbpvno;
				break;
			}
		}
		if(bpvno>0){
			return false;
		}
		/*var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');
		if(bpvno!="" && bpvno!="undefined" && typeof(bpvno)!="undefined" && bpvno!=null){
			return false;
		}*/
		checkPytInvoicing();
		}
		function checkPytInvoicing(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText.trim();
				//alert("asd"+items+"asd");
				if(items=="0"){
					$('#btnpytedit').hide();
					$('#btnpytsave,#btnpytcancel,#btnprocess,#btncreatecheque').show();
					$('#pytadvance,#pytbalance,#pytmonthsno,#pytbankacno').attr('disabled',false);
					$('#pytbankacno').attr('readonly',true);
				    $('#pytbankacno').attr('placeholder','Press F3 to Search');
					$('#pytstartdate').jqxDateTimeInput({disabled:false});
					$('#btnprocess').attr('disabled',false);
					/* if(document.getElementById("pyttotalrent").value==""){
						funPytCalc();
					} */
				}
				else if(items=="2"){
					$.messager.alert("Warning","Invoiced,Cannot Edit");
					return false;
				}
				else{
					$.messager.alert("Warning","Cannot Edit");
					return false;
				}
			}
			else
			{
			}
		}
		x.open("GET", 'checkPytInvoicingAJAX.jsp?docno='+$('#agmtdocno').val(), true);
		x.send();
		}

		
		function funPytCalc(){
			  
			  $('#rateGrid').jqxGrid({disabled:false});
			  $('#pername,#per_value').attr('disabled',false);
			  var periodtype=$('#per_name').val();
			  var periodno=$('#per_value').val();
			  var monthno=0;
			  if(periodtype=="1"){
				  monthno=(periodno*12);
			  }
			  else if(periodtype=="2"){
				  monthno=periodno;
			  }
			  var rent=$('#rateGrid').jqxGrid('getcellvalue',0,'rate');
			  var cdw=$('#rateGrid').jqxGrid('getcellvalue',0,'cdw');
			  var pai=$('#rateGrid').jqxGrid('getcellvalue',0,'pai');
			  var cdw1=$('#rateGrid').jqxGrid('getcellvalue',0,'cdw1');
			  var pai1=$('#rateGrid').jqxGrid('getcellvalue',0,'pai1');
			  var gps=$('#rateGrid').jqxGrid('getcellvalue',0,'gps');
			  var babyseater=$('#rateGrid').jqxGrid('getcellvalue',0,'babyseater');
			  var cooler=$('#rateGrid').jqxGrid('getcellvalue',0,'cooler');
			  var chauffer=$('#rateGrid').jqxGrid('getcellvalue',0,'chaufchg');
			  var apc=$('#rateGrid').jqxGrid('getcellvalue',0,'apc');
			  apc=parseFloat(apc==null || apc=="" || typeof(apc)=="undefined" || apc=="undefined"?"0":apc);
			  rent=parseFloat(rent==null || rent=="" || typeof(rent)=="undefined" || rent=="undefined"?"0":rent);
			  cdw=parseFloat(cdw==null || cdw=="" || typeof(cdw)=="undefined" || cdw=="undefined"?"0":cdw);
			  pai=parseFloat(pai==null || pai=="" || typeof(pai)=="undefined" || pai=="undefined"?"0":pai);
			  cdw1=parseFloat(cdw1==null || cdw1=="" || typeof(cdw1)=="undefined" || cdw1=="undefined"?"0":cdw1);
			  pai1=parseFloat(pai1==null || pai1=="" || typeof(pai1)=="undefined" || pai1=="undefined"?"0":pai1);
			  gps=parseFloat(gps==null || gps=="" || typeof(gps)=="undefined" || gps=="undefined"?"0":gps);
			  babyseater=parseFloat(babyseater==null || babyseater=="" || typeof(babyseater)=="undefined" || babyseater=="undefined"?"0":babyseater);
			  cooler=parseFloat(cooler==null || cooler=="" || typeof(cooler)=="undefined" || cooler=="undefined"?"0":cooler);
			  chauffer=parseFloat(chauffer==null || chauffer=="" || typeof(chauffer)=="undefined" || chauffer=="undefined"?"0":chauffer);
			  var total=(rent*monthno)+(cdw*monthno)+(pai*monthno)+(cdw1*monthno)+(pai1*monthno)+(gps*monthno)+(babyseater*monthno)+(cooler*monthno)+(chauffer*monthno)+(apc*monthno);
			  getLeaseCalcTax(document.getElementById("extdocno").value,total,monthno,rent,cdw,pai,cdw1,pai1,gps,babyseater,cooler,chauffer,apc);
			  
		  }
		 function getLeaseCalcTax(docno,total,monthno,rent,cdw,pai,cdw1,pai1,gps,babyseater,cooler,chaufferchg,apc){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						
						total=parseFloat(items);
						document.getElementById('pyttotalrent').value=total;
						  document.getElementById("pytmonthsno").value=monthno;
						  //alert($('#latype').val());
						  /* if(document.getElementById("latype").value=="2"){
								 getPytAdvanceAJAX($('#larefdoc').val());
							  $('#pytadvance').val((total/monthno) * 3 );
							} */
					}
				}
					
			x.open("GET","getLeaseCalcTax.jsp?docno="+docno+"&total="+total+"&monthno="+monthno+"&rent="+rent+"&cdw="+cdw+"&pai="+pai+"&cdw1="+cdw1+"&pai1="+pai1+"&gps="+gps+"&babyseater="+babyseater+"&cooler="+cooler+"&chaufferchg="+chaufferchg+"&apc="+apc,true);

			x.send();
					
		  }
		function getPytAdvanceAJAX(value){
		//alert("asd");
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items= x.responseText.trim();
			// $('#pytadvance').val(items.split("::")[0]);
			$('#pytmonthsno').val(items.split("::")[1]);
			$('#pytbalance').val($('#pyttotalrent').val()-$('#pytadvance').val());
			funRoundAmt($('#pytbalance').val(),"pytbalance");
			
		}
		else
		{
		}
		}
		x.open("GET", 'getPytAdvanceAJAX.jsp?larefdocno='+value, true);
		x.send();
		}
		function funPytCancel(){
		$('#btnpytedit').show();
		$('#btnpytsave,#btnpytcancel,#btnprocess,#btncreatecheque').hide();
		$('#pytadvance,#pytbalance,#pytmonthsno,#pytbankacno').attr('disabled',true);
		$('#pytbankacno').attr('readonly',true);
		$('#pytbankacno').attr('placeholder','Press F3 to Search');
		$('#pytstartdate').jqxDateTimeInput({disabled:true});
		$('#btnprocess').attr('disabled',true);
		  $('#pytDetailsGrid').jqxGrid({disabled:true});
		  $('.textpanel p').text('');  
			
			

		

		}
		function funPytSave(){
		var rows=$('#pytDetailsGrid').jqxGrid('getrows');
		if(rows.length==0){
			//document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return false;
		}
		var gridsum=$('#pytDetailsGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
		var gridsumtemp=gridsum.sum;
		var gridnewsum=gridsumtemp.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		var total=parseFloat(document.getElementById('pyttotalrent').value);
		if(parseFloat(gridnewsum)==parseFloat(total)){
			pytSaveAJAX();
		}
		else{
			$.messager.alert('warning','Amount is not tally');
			return false;
		}
		}

		function pytSaveAJAX(){
		var masterdocno=document.getElementById("extdocno").value;
		var pyttotalrent=document.getElementById('pyttotalrent').value;
		var pytadvance=document.getElementById("pytadvance").value;
		var pytbalance=document.getElementById("pyttotalrent").value;
		var pytmonthsno=document.getElementById("pytmonthsno").value;
		var pytstartdate=$('#pytstartdate').jqxDateTimeInput('val');
		var pytbankacno=document.getElementById("hidpytbankacno").value;
		var rsdval=document.getElementById("nwrsdvalue").value;
		var extdate=$('#extdate').jqxDateTimeInput('val');

		var rows=$('#pytDetailsGrid').jqxGrid('getrows');
		var arr=new Array();
		for(var i=0;i<rows.length;i++){
			arr.push($('#pytDetailsGrid').jqxGrid('getcelltext',i,'date')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'amount')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'chequeno')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno')+" :: ");
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items= x.responseText.trim();
			if(items=="1"){
				$.messager.alert('message','Successfully Updated');	
				funload();

				funPytCancel();
			
				$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('extdocno').value+'&id=2');
				 
			}
			else{
				$.messager.alert('message','Not Updated');
			}
			
		}
		else
		{
		}
		}
		//alert("pytSavePaymentAJAX.jsp?masterdocno="+masterdocno+"&pyttotalrent="+pyttotalrent+"&pytadvance="+pytadvance+"&pytbalance="+pytbalance+"&pytmonthsno="+pytmonthsno+"&pytstartdate="+pytstartdate+"&pytbankacno="+pytbankacno+"&gridarray="+arr);
		x.open("GET", "pytSavePaymentAJAX.jsp?masterdocno="+masterdocno+"&pyttotalrent="+pyttotalrent+"&pytadvance="+pytadvance+"&pytbalance="+pytbalance+"&pytmonthsno="+pytmonthsno+"&pytstartdate="+pytstartdate+"&pytbankacno="+pytbankacno+"&gridarray="+arr+"&rsdval="+rsdval+"&extdate="+extdate, true);
		x.send();
		}

		function  funReadOnly(){
			 $('#pytstartdate').jqxDateTimeInput({disabled:true});
			 $('#btnprocess').attr('disabled',true);
			
		}
		function funRemoveReadOnly(){
			
		}
		

</script>
<div id="bankacnowindow">
   <div ></div>
</div>
</body>
</html>
