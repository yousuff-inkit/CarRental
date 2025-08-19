<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>CRM</title> 
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
<body onload="getBranch();getProcess();" >
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
      	<div class="row padtop">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="lprdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="lpr"></div>
                            <span><img src="../../../../icons/detail_add.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Lease Price Request</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="newclientdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="newclient"></div>
                            <span><img src="../../../../icons/driverAdd.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>New Client</span><br/>
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="calculdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">  
                            <div id="calcul"></div>
                            <span><img src="../../../../icons/calculate_new.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Calculator / Quote</span><br/>  
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div>	 
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="appldiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="appl"></div>
                            <span><img src="../../../../icons/appli.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Application</span><br/>
                             <span class="counter">0</span>  
                        </div>
                    </div>
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
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">To:</label>
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div>
			                </div>		  
					  <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<!-- <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button> -->
        </div>
         <div class="otherpanel custompanel">         
          <button type="button" class="btn btn-default" id="btnenqview"><i class="fa fa-money" aria-hidden="true" data-toggle="tooltip"  title="View Lease Price Request" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnenquiryfollowup" ><i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Lease Price Request Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnclientupdate" ><i class="fa fa-pencil-square-o" aria-hidden="true" data-toggle="tooltip" title="Customer Creation" data-placement="bottom"></i></button>  
         <button type="button" class="btn btn-default" id="btncalcprepare"  ><i class="fa fa-cogs" aria-hidden="true" data-toggle="tooltip" title="Quote Preparation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncalcview"><i class="fa fa-quora" aria-hidden="true" data-toggle="tooltip"  title="View Quote" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncalcfollowup" ><i class="fa fa-bars" aria-hidden="true" data-toggle="tooltip" title="Quote Followup" data-placement="bottom"></i></button>
         <button type="button" class="btn btn-default" id="btnapplprepare"  ><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Application Creation" data-placement="bottom"></i></button>  
          <button type="button" class="btn btn-default" id="btnapplview"><i class="fa fa-adn" aria-hidden="true" data-toggle="tooltip"  title="View Application" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
         </div> 
	            <div class="textpanel custompanel2" >
				   <label for="divid" id="selecteddiv" style="font-size:70%;"></label>  
				   				<p  style="font-size:75%;">&nbsp;</p>
				         
	           </div>
	          
	         
	          
				</form>        
			</div> 
		</div>	 
		<div class="row">
           
        </div>    
      </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="presalesdiv"><jsp:include page="crmGrid.jsp"></jsp:include></div>
      </div>
    </div>
	 <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<div id="modalsurveyupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Survey Update<span></span></h4>
          		</div>
          		<div class="modal-body">
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        <div id="siteDiv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
					      </div>  
	          		</div>  
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        	<label for="siteselected" id="selectedsite"></label>
					      </div>  
	          		</div>  
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="route">Route :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtroute" name="txtroute" style="width:85%;"  > 
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="gps">GPS X :</label>
    						<div class="col-sm-3 input-container">
      							<input type="text" id="txtgpsx" name="txtgpsx" style="width:90%;"> 
    						</div>
    						<label class="control-label col-sm-2" for="gps">GPS Y :</label>     
    						<div class="col-sm-3 input-container">  
      							<input type="text" id="txtgpsy" name="txtgpsy" style="width:90%;">     
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="desc">GPS URL :</label>    
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtdesc" name="txtdesc" style="width:85%;"  >     
    						</div>
  						</div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnsurvey">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalclient" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Client Creation<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="txtclientnw">Client:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtclientnw" name="txtclientnw" style="width:70%;"  >
    						</div>
  						</div>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtaddressnw">Address:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtaddressnw" name="txtaddressnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtmobnw">Mobile:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtmobnw" name="txtmobnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  							<div class="form-group">
    						<label class="control-label col-sm-3" for="txtemailnw">Email:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtemailnw" name="txtemailnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<%-- <div class="form-group">
    						<label class="control-label col-sm-3" for="cmbsalesman">Salesman:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="cmbsalesman" name="cmbsalesman"  style="width:70%;"  >
    						</div>
    						<input type="hidden" id="hidsalid" name="hidsalid" value='<s:property value="hidsalid"/>'/>     
  						</div> --%>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtsource">Source:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtsource" name="txtsource" readonly placeholder="Press F3 To Search" onKeyDown="getSource(event);" style="width:70%;"  >
    						</div>
    						<input type="hidden" id="sourceid" name="sourceid" value='<s:property value="sourceid"/>'/>     
  						</div>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtarea">Area:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtarea" name="txtarea" readonly placeholder="press F3 to search"  onKeyDown=" getareas(event);"  >
      							<input type="text" id="txtareadet" name="txtareadet" readonly style="width:68%;" />
    						</div>
    						<input type="hidden" id="txtareaid" name="txtareaid"/> 
    						   
  						</div>
  						<div class="form-group">
	  						<label class="control-label col-sm-3" for="cmbcategory">Category:</label>
	  						<div class="col-sm-9 input-container">
	  						  <select id="cmbcategory" name="cmbcategory" style="width:70%;" onchange="getCategoryAccountGroup(this.value);">
	  						  <option value="">--Select--</option></select>  
	  						</div>
  						</div>
  						<div class="form-group">
	  						<label class="control-label col-sm-3" for="cmbacgroup">Account Group:</label>
	  						<div class="col-sm-9 input-container">
	  						  <select id="cmbacgroup" name="cmbacgroup" style="width:70%;">
	  						  <option value="">--Select--</option></select>  
	  						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtaddressnw">TRN No:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txttinno" name="txttinno" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<%-- <div class="form-group">
    						<label class="control-label col-sm-3" for="cmbcperson">Contact Person:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="cmbcperson" name="cmbcperson" style="width:70%;"  >
    						</div>
    						<input type="hidden" id="hidcmbcpersonid" name="hidcmbcpersonid" value='<s:property value="hidcmbcpersonid"/>'/>     
  						</div> --%>
  						
  	
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalquotefollowup" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Quotation Follow-Up<span></span></h4>    
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						
    						 <label class="control-label col-sm-3" for="cmbprocess">Process</label>
							 <div class="col-sm-9 input-container">
							 <select name="cmbprocess" id="cmbprocess" style="width:52%;" name="cmbprocess" onChange="funtxtenable();"  value='<s:property value="cmbprocess"/>'></select>
  						</div> 
  						</div>
  						
                       
							 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label></td>
						      <div class="col-sm-9 input-container">
						     <div id="date" name="date" value='<s:property value="date"/>'></div>
						     </div>
						     </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Remarks</label>
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="txtremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="txtremarks" ></textarea>
  						</div>
  						</div>  
  						</div>
  						
  						
            		</div>
          		
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnqotflwp">Save Changes</button>
            		
          		</div>
          		</div>
        </div>
      </div>
      <div id="modalenquiryfollowup" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Enquiry Follow-Up<span></span></h4>      
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						 <div class="form-group">
							 <label class="control-label col-sm-3" for="cmbenqprocess">Process</label>  
							 <div class="col-sm-9 input-container">  
							 <select name="cmbenqprocess" id="cmbenqprocess" style="width:52%;" onChange="funenqdisable();" class="form-control input-sm">  
							 <option value="1">Follow-Up</option><option value="2">Drop</option></select>  
							 </div>  
						 </div>  
						<%--  <div class="form-group">   
                            <label class="control-label col-sm-3" for="cmbreason">Reason</label>  
							<div class="col-sm-9 input-container">
							<select name="cmbreason" id="cmbreason" style="width:90%;" name="cmbreason"  class="form-control input-sm"  value='<s:property value="cmbreason"/>'></select>  
							</div>
						</div>   --%>
						 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="enqflwupdate"></div>
						     </div>
						  </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="Remarks">Remarks</label>    
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="enqflwupremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="enqflwupremarks"  class="form-control input-sm"></textarea>
  						</div>
  						</div>  
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnenqflwp">Save Changes</button>
          		</div>
          		</div>
        </div>
      </div>
      <div id="modalchecklist" class="modal fade" role="dialog">  
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>  
            		<h4 class="modal-title">Checklist<span></span></h4>
          		</div>
          		<div class="modal-body">
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        <div id="chklistDiv"><jsp:include page="checklistGrid.jsp"></jsp:include></div>
					      </div>  
	          		</div>  
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        	<label for="siteselected" id="selectedsite"></label>
					      </div>  
	          		</div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnchecklistsave">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
    </div>
    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Comments</h4>
          </div>
          <div class="modal-body">
            <div class="comments-outer-container container-fluid">
              <div class="comments-container">
                
              </div>
              <div class="create-msg-container">
                <!-- <div class="container-fluid"> -->
                  <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      <div class="input-group">
                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        <div class="input-group-btn">
                          <button type="button" id="btncommentsend" class="btn btn-default">
                            <i class="fa fa-paper-plane"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                <!-- </div> -->
              </div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>
    <div id="modalpresaleslog" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Presales Log</h4>  
           <!--  <h6 class="modal-title" style="text-align:center"><label class="status" id="lblclientstatus9" name="lblclientstatus9"></label></h6>   -->
          </div>
          <div class="modal-body">
          <div id="wrkdiv"><jsp:include page="preSalesLogGrid.jsp"></jsp:include></div>
          </div>
          <<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          		</div> 
        </div>  
      </div>
       <div id="sidesearchwndow">
	   <div ></div>
	</div>
    </div>
     <div id="modalclientupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Client Update<span></span></h4>         
          		</div>
          		<div class="modal-body">
          		            		<div class="form-horizontal">
          		
            		<div class="form-group">
    						<label class="control-label col-sm-3" for="client">Client :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtclient" name="txtclient" style="width:85%;"  > 
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="address">Address :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtaddr" name="txtaddr" style="width:85%;"  > 
    						</div>
  						</div>
  				<div class="form-group">
    						<label class="control-label col-sm-3" for="email">Email :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtemail" name="txtemail" style="width:85%;"  > 
    						</div>
  						</div>
  						 <div class="form-group">
    						<label class="control-label col-sm-3" for="route">Mobile :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtmob" name="txtmob" style="width:85%;"  > 
    						</div>
  						</div>
            		</div>
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnclientsave">Save Changes</button>
          		</div>
          		</div>
        </div>
      </div>
       <input type="hidden" name="divname" id="divname"> 
       <input type="hidden" id="reportdocno" name="reportdocno">
       <input type="hidden" id="surveydocno" name="surveydocno">
       <input type="hidden" id="enqdocno" name="enqdocno">
              <input type="hidden" id="enqsource" name="enqsource">
                     <input type="hidden" id="enqdoc" name="enqdoc">
       
       <input type="hidden" id="sitedocno" name="sitedocno" >  
       <input type="hidden" id="reftrno" name="reftrno" >
       <input type="hidden" id="salmanid" name="salmanid" >
       <input type="hidden" id="qottrno" name="qottrno" >
       <input type="hidden" id="qotchkno" name="qotchkno" >
       <input type="hidden" id="brhid1" name="brhid1">  
       <input type="hidden" id="refdtype" name="refdtype">
       <input type="hidden" id="client" name="client">
       <input type="hidden" id="cldocno" name="cldocno">
       <input type="hidden" id="address" name="address">
       <input type="hidden" id="pertel" name="pertel">
       <input type="hidden" id="per_mob" name="per_mob">
       <input type="hidden" id="mail1" name="mail1">
       <input type="hidden" id="hidremarks" name="hidremarks">
       <input type="hidden" id="hidqotvoc" name="hidqotvoc">
       <input type="hidden" id="ldate" name="ldate">
             <input type="hidden" id="lprdocno" name="lprdocno">
             <input type="hidden" id="lprvocno" name="lprvocno">
             <input type="hidden" id="qotdocno" name="qotdocno">
             <input type="hidden" id="qotvocno" name="qotvocno">
             <input type="hidden" id="appldocno" name="appldocno">
       
       <input type="hidden" id="salname" name="salname">
       <input type="hidden" id="salid" name="salid" >  
       <input type="hidden" id="hidchecklist" name="hidchecklist">  
       <input type="hidden" id="hidcheckrowno" name="hidcheckrowno"> 
       <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup">   
       <input type="hidden" id="hidcontrno" name="hidcontrno"> 
       <input type="hidden" id="hidpayterms" name="hidpayterms"> 
       <input type="hidden" id="hidgroupcompanies" name="hidgroupcompanies"> 
       <input type="hidden" id="hidbillingmethod" name="hidbillingmethod">   
       <input type="hidden" id="hidcperson" name="hidcperson"> 
       <input type="hidden" id="hidcpersonid" name="hidcpersonid"> 
       <input type="hidden" id="hiddesignation" name="hiddesignation">          
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
    	<%-- <%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
    	var formname='<%=name2%>';      
    	if(formname=="Pre Sales Management"){ --%>
    		$("#btncreateclient").hide();
    		
    	$('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	    $('#areainfowindow').jqxWindow('close');
   	    $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#sourcesearchwndow').jqxWindow('close');
		$("#enqflwupdate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#date").jqxDateTimeInput({ width: '100px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#fromdate").jqxDateTimeInput({ width: '100px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		$('#btncreateclient').attr("disabled",true);
		$('#btnconfirm').attr("disabled",true);
		$('#cmbfollowup').attr("disabled",true);
		$('#cmbdecline').attr("disabled",true);
		funenqdisable();
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		$('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   if(fromdates<todates){
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'To Date Less Than From Date'
					});
			        return false;  
			  }   
		 });
		document.getElementById('selecteddiv').innerHTML=" - Lease Price Request"; 
    	document.getElementById("divname").value="lpr";  
    	 $('#btnattachs').click(function(){   
         	funAttachs(event);      
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
    	$('#btncalcview').click(function(){    
			 var lprdocno=$('#lprdocno').val();
	         if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var qotdocno=$('#qotdocno').val();
	         if(qotdocno=="" || qotdocno=="0"){   
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Quotation is not created'
					});
	        		return false;
	         }
			 viewQuotation(); 
	        	//funcleardata();

		});
    	$('#btnapplview').click(function(){    
			 var lprdocno=$('#lprdocno').val();
	         if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var appldocno=$('#appldocno').val();  
	         if(appldocno=="" || appldocno=="0"){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Application is not Created'    
					});
	        		return false;
	         }
	         viewContract(); 
	         //funcleardata();
		});
    	$('#btnclientupdate').click(function(){    
			 var lprdocno=$('#lprdocno').val();
	        	if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	        	var client=$('#cldocno').val();
	        	if(client!="0")
	        		{
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Client Already Exists'
					});
	        		return false;
	        		}
	        	else
	        		{
	        		  $('#cldiv').load('clientSearch.jsp?id=1');       
	  	 			$('#modalclientupdate').modal('show');    

	        		}
	        	//funcleardata();
		});
		$('#btncreateclient').click(function(){  
			 var lprdocno=$('#lprdocno').val();
	        	if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			$('#modalclient').modal('show');  
		});
		
		
		$('#btnsubmit').click(function(){   
			 $('.load-wrapp').show();
			 getInitChartData();   
			 funload();
			  $('.textpanel p').text('');  

	        	//funcleardata();

		});
		$('#btnexcel').click(function(){
			$("#presalesdiv").excelexportjs({  
				containerid: "presalesdiv",
				datatype: 'json',
				dataset: null,
				gridId: "enqlistgrid",
				columns: getColumns("enqlistgrid"),
				worksheetName: "CRM "
			});
		});
		$('#btncomment').click(function(){
			getComments();
			
        });
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var lprdocno=$('#lprdocno').val();
        	if(txtcomment==""){
        		swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(lprdocno==""){
        		swal({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
		
		 $('#btnclientcreation').click(function(){
				funCreateClient();
	        });
		
        $('#btnqotflwp').click(function(){
			  $('#modalquotefollowup').modal('hide');
			  funQotflwp(); 
	        	//funcleardata();

	      });
        $('#btnenqflwp').click(function(){
			  funEnqflwp();
	        	//funcleardata();

	      });
        $('#btnsurvey').click(function(){
        	 funUpdate(1);     
        });
        $('#btnclientsave').click(function(){
       	     funUpdate(6);     
       });
		$('#btncalcprepare').click(function(){
			    var lprdocno=$('#lprdocno').val();  
	        	if(lprdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}else{
	        		 var qotdocno=$('#qotdocno').val();  
	        		 if(parseInt(qotdocno)>0){
	    	        		Swal.fire({
	    	        			icon: 'warning',
	    						title: 'Warning',
	    						text: 'Already Quoted'
	    					});
	    	        		return false;
	    	         }else{
	    	        	 funCreate(1);
	    	     }  
	        		
	        	}
	        	//funcleardata();

	        });
		$('#btnapplprepare').click(function(){ 
		    var lprdocno=$('#lprdocno').val(); 
		    var cldocno=$('#cldocno').val(); 
		    var qotdocno=$('#qotdocno').val(); 
		    var appldocno=$('#appldocno').val(); 
        	if(lprdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	else if(cldocno=="" || cldocno=="0"){      
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please convert to client first'  
				});
        		return false;
        	} 
        	else if(!(appldocno=="") ){      
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Application Already Created'  
				});
        		return false;
        	}
        	else
        		{
        		funCreate(2); 

        		}

        	//validatechecklist(qottrno);  
            /* if(parseInt(checklist)>0){     
    	        		Swal.fire({
    	        			icon: 'warning',
    						title: 'Warning',
    						text: 'Check List is not fully updated'       
    					});
    	        		return false;
    	      }  */
    	      //lookforchanges(2);  
        	//funcleardata();

        });
        $('#btnenquiryfollowup').click(function(){
		    var lprdocno=$('#lprdocno').val();  
        	if(lprdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
    	    }  
           $('#modalenquiryfollowup').modal('show');
        });
		$('#btncalcfollowup').click(function(){
		    var lprdocno=$('#lprdocno').val();  
        	if(lprdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}else{
        		 var qotdocno=$('#qotdocno').val(); 
        		 if(qotdocno=="0" || qotdocno==""){   
    	        		Swal.fire({
    	        			icon: 'warning',
    						title: 'Warning',
    						text: 'Quotation not created yet'   
    					});
    	        		return false;
    	         }else{
    	        	  $('#modalquotefollowup').modal('show');       	
    	         }  
        	}
		
        });
		 $('#btnchecklistsave').click(function(){
        	 funUpdate(5);             
        });
        $('#txtarea').dblclick(function(){
  		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp?getarea=0');
			  });
        $('#txtsource').dblclick(function(){
	    	$('#sourcesearchwndow').jqxWindow('open');
			 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
	   });
        
	});
    function getSource(event){
  	  var x= event.keyCode;
  	  if(x==114){
   		 $('#sourcesearchwndow').jqxWindow('open');
   		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
   	 }
   	 else{
   	 }
    }
    function sourceinfoSearchContent(url) {
  	  $.get(url).done(function (data) {
  		  $('#sourcesearchwndow').jqxWindow('open');
  		  $('#sourcesearchwndow').jqxWindow('setContent', data);
  	  }); 
    }
	function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
		}); 
	}
	function getComments(){
    	var lprdocno=$('#lprdocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				$('.comments-container').html('');
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var i=0;i<items.length;i++){
						str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?reftrno="+lprdocno,true);
		x.send();
    }
 	function saveComment(){
    	var comment=$('#txtcomment').val();
    	var lprdocno=$('#lprdocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				$('#txtcomment').val('');
				getComments();		
			}
			else
			{
			}  
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&reftrno="+lprdocno,true);
		x.send();
    }
	
	 function funCreate(id){    
		var cldocno=document.getElementById("cldocno").value;
		var address=document.getElementById("address").value;
		var pertel=document.getElementById("pertel").value;
		var client=document.getElementById("client").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var salname=document.getElementById("salname").value;
		var salid=document.getElementById("salid").value;
		var brch=document.getElementById("brhid1").value;
		var source=document.getElementById("txtsource").value;
		var sourceid=document.getElementById("sourceid").value;
		var qotdocno=document.getElementById("qotdocno").value;  
		var qotvocno=document.getElementById("qotvocno").value;         
		var lprdocno=document.getElementById("lprdocno").value;
		var lprvocno=document.getElementById("lprvocno").value;
		var appldocno=document.getElementById("appldocno").value;

		
		if(parseInt(id)==1){  
			var path1="com/operations/marketing/leasecalculatoralfahim/leaseCalculator.jsp";  
			 var name="Lease Calculator / Quote";
			 var url=document.URL;
			var reurl=url.split("com/");  

		  window.parent.formName.value="Lease Calculator / Quote";
		  window.parent.formCode.value="LEC";
		  window.parent.branchid.value=brch;
		  var detName="Lease Calculator / Quote";  
		  var mode="A";
		   
		  
		  var path= path1+"?modes="+mode+"&brch="+brch+"&lprvocno="+lprvocno+"&client="+client+"&per_mob="+per_mob+"&lprdocno="+lprdocno;  
		 
		   top.addTab( detName,reurl[0]+""+path);
		   funcleardata();
		}
		
		if(parseInt(id)==2){  
			var cldocno=document.getElementById("cldocno").value;
			var address=document.getElementById("address").value;
			var client=document.getElementById("client").value;
			var mobile=document.getElementById("per_mob").value;
			var email=document.getElementById("mail1").value;
			var sal_name=document.getElementById("salname").value;
			var qotdocno=document.getElementById("qotdocno").value;  
			var qotvocno=document.getElementById("qotvocno").value;         
			var lprdocno=document.getElementById("lprdocno").value;
			var lprvocno=document.getElementById("lprvocno").value;
			var appldocno=document.getElementById("appldocno").value;

			var path1="com/operations/marketing/leasequotation/leaseQuotation.jsp";    
			 var name="Lease Application";
			 var url=document.URL;
			var reurl=url.split("com/");  

		  window.parent.formName.value="Lease Application";
		  window.parent.formCode.value="LQT";   
		  window.parent.branchid.value=brch;
		  var detName="Lease Application";
		  var mod="A"; 
		  var path= path1+"?mod="+mod+"&leasereqdocno="+lprdocno+"&cldocno="+cldocno+"&client="+client+
		  "&address="+address+"&mobile="+mobile+"&email="+email+"&sal_name="+sal_name+"&vocno="+qotvocno+"&docno="+qotdocno;

		  
		  top.addTab( detName,reurl[0]+""+path);
		  funcleardata();
		}
		
	}
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbprocess').html($.parseHTML(optionsbranch));
	  			$('#cmbprocess').select2({
	  				placeholder:"Select Process",
	  				allowClear:true
	  			});
				
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	
	function saveClientChange(processid,docno,brhid,client,address,email,mobile){      
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
								 $('#txtclient').val('');
								 $('#txtaddr').val('');
								 $('#txtemail').val('');
								 $('#txtmob').val('');  

						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						}
					 $('#modalclientupdate').modal('hide');   
					 funcleardata();

				}
		}
		//alert("saveData.jsp?processid="+encodeURIComponent(processid)+"&docno="+docno+"&brhid="+brhid+"&clientupdate="+client+"&address="+address+"&mobile="+mobile+"&email="+email);
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docno="+docno+"&brhid="+brhid+"&clientname="+client+"&address="+address+"&mobile="+mobile+"&email="+email,true);      
	x.send();      
	}
	function funchanges(processid,docno,brhid){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
							$('#btnsubmit').trigger('click');
							if(processid=="Confirm"){
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Confirmed'  
									});
								 document.getElementById('lblselectedrowdetail').innerHTML="";    
								 $("#amcfollowupGrid").jqxGrid('clear');  
							}
						}else{
							if(processid=="Confirm"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Confirmed'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docno="+docno+"&brhid="+brhid,true);      
	x.send();
	}
	 
		
		
		function funQotflwp(){
			var pro= $('#cmbprocess').val().split(":");
			var bibid=pro[0];
			var proname=pro[1];
			
			
			var date =  $('#date').val();
			var branchid = $('#brhid1').val();  
			var remarks = $('#txtremarks').val().replace(/\n/g, '');
			var qotdocno = $('#qotdocno').val();
			var lprdocno = $('#lprdocno').val();
			var rdtype = "QOT";      
			var client = $('#client').val();
			//var userid = $('#txtuserid').val();
			var qdate = $('#date').val(); 
			if(bibid==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Choose a Process.'
					});
	  		return false;
			 }
	//alert(bibid);                                                                                                             
		
			 
			 if(remarks==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Enter Remarks.'
					});
	  		return false;
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
						saveQotflwp(bibid,proname,date,branchid,qotdocno,rdtype,remarks,lprdocno,qdate,client);
					}
			});
		}
		    
		function saveQotflwp(bibid,proname,date,branchid,qotdocno,rdtype,remarks,lprdocno,qdate,client){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
					var items=x.responseText;
					if(parseInt(items)=="1")
					{	
					$('#cmbprocess').val('');
					$('#cmbdecline').val('');
					$('#date').val(new Date());
					$('#txtremarks').val('');
				
					$('.load-wrapp').hide();
					Swal.fire({
						icon: 'success',
						title: 'Success',  
						text: ' Successfully Updated'
					});
					
					$('#btnsubmit').trigger('click');
					$("#detailDiv").load("detailGrid.jsp?doc="+qotdocno+"&enqdocno="+lprdocno);   
					funcleardata();
					}
					else
					{
						$('.load-wrapp').hide();
						Swal.fire({
							icon: 'warning',
							title: 'Warning',
							text: 'Not Updated'
						});
						return false;
					}
					}
			}
			//alert("qutsavedata.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks+"&enqdocno="+enqdocno+"&qdate="+qdate+"&client="+client);
		x.open("GET","qutsavedata.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+qotdocno+"&rdtype="+rdtype+"&remarks="+remarks+"&enqdocno="+lprdocno+"&qdate="+qdate+"&client="+client,true)
		x.send();
				
		}
		function getareas(event){
	      	 var x= event.keyCode;
	      	 if(x==114){
	      	  		$('#areainfowindow').jqxWindow('open');
	                areaSearchContent('area.jsp?getarea=0');  	 
	                
	      	 } else{}
	      }
	             	 
		 function areaSearchContent(url) {
		      	 $.get(url).done(function (data) {
		 		 $('#areainfowindow').jqxWindow('setContent', data);
		      	 }); 
		 }
		 
		 function funCreateClient(){
			    var txtaddressnw =  $('#txtaddressnw').val();
				var txtmobnw = $('#txtmobnw').val();
				var remarks = $('#txtremarks').val();
				var txtemailnw = $('#txtemailnw').val();
				var hidsourceid = $('#sourceid').val();
				var txtareaid = $('#txtareaid').val();
				var client = $('#txtclientnw').val();
				var cpersonid = $('#txtcperson').val();
				var salid =  $('#salmanid').val();
				var reftrno = $('#lprdocno').val();
				var category = $('#cmbcategory').val();
				var acgroup = $('#cmbacgroup').val();
				var tinno = $('#txttinno').val();
				//alert("salid=="+salmanid);
				if(client==""){    
					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please enter client name!!!'
					});
					return false;
				}
				if(category==""){    
					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please select a category!!!'  
					});
					return false;
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
							saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno,acgroup);
						}
				});
		 }
		 
		 function saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno,acgroup){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
			     			
						var items=x.responseText;
						if(parseInt(items)>0) {	
							$('.load-wrapp').hide();
							Swal.fire({
								icon: 'success',
								title: 'Success',  
								text: ' Successfully Client '+items+' Created'
							});
							$('#modalclient').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else
						{
							$('.load-wrapp').hide();
							Swal.fire({
								icon: 'warning',
								title: 'Warning',
								text: 'Not Created'
							});
							return false;
						}
						}
				}
				
			x.open("GET","saveClient.jsp?address="+txtaddressnw+"&mobile="+txtmobnw+"&email="+txtemailnw+"&sourceid="+hidsourceid+"&areaid="+txtareaid+"&client="+client+"&cpersonid="+cpersonid+"&salid="+salid+"&enqdocno="+reftrno+"&category="+category+"&tinno="+tinno+"&acgroup="+acgroup,true)
			x.send();
		 }
		 function funUpdate(chkevent){  
				var proname="",prname="",prdocno="",saldocno="",salname="",processid="";
				var docno = $('#lprdocno').val();
				var brhid=$("#brhid1").val();
				if(parseInt(chkevent)==1){	
					var siteid = $('#sitedocno').val();
					var route= $('#txtroute').val(); 
					var gpsx= $('#txtgpsx').val();
					var gpsy= $('#txtgpsy').val();
					var desc= $('#txtdesc').val();  
					processid="Survery Update";     
					if(siteid==''){
						 swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Please select a site!!!' 
							});
			  		      return false;
					 }
					if(route==''){
						 swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Please enter route!!!'
							});
			  		      return false;
					 }
					Swal.fire({
						title: 'Are you sure?',
						text: "Do you want Update Changes?",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: 'Yes'
					}).then((result) => {
							if (result.isConfirmed) {
								$('.load-wrapp').show(); 
								console.log("====="+processid);
								saveSurvery(processid,siteid,route,gpsx,gpsy,desc,docno);
							}
					});
				}else if(parseInt(chkevent)==2){    	
					processid="Quotation";     
					funchanges(processid,docno,brhid);
				}else if(parseInt(chkevent)==3){    	
					processid="Contract";     
					funchanges(processid,docno,brhid);        
				}else if(parseInt(chkevent)==6){    	
					processid="Client Update"; 
					var client = $('#txtclient').val();
					var address = $('#txtaddr').val().replace(/\n/g, '');
					var email = $('#txtemail').val();
					var mobile = $('#txtmob').val();


					Swal.fire({
						title: 'Are you sure?',
						text: "Do you want Confirm?",  
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: 'Yes'
					}).then((result) => {
							if (result.isConfirmed) {
								saveClientChange(processid,docno,brhid,client,address,email,mobile); 
							}
					});
				}else{}   
			}
		
		 function lookforchanges(id){
			    var processid="Look Changes";   
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){  
						var items=x.responseText.split('####');
						if(parseInt(items[0])>0 && parseInt(id)==1){         	  
							 $('#btnsubmit').trigger('click');
							 $('#qotdocno').val(items[0]);  
	    	        		 $('#qottrno').val(items[0]);  
							 Swal.fire({
								    icon: 'warning',
		    						title: 'Warning',
		    						text: 'Quotation Already Created'  
		    					});
		    	        		return false;
						}else if(parseInt(items[1])>0 && parseInt(id)==2){      
							 $('#btnsubmit').trigger('click');
							 Swal.fire({
								    icon: 'warning',
		    						title: 'Warning',
		    						text: 'Application Already Created'  
		    					});
		    	        		return false;
						}else{
							if(parseInt(id)==1){
								 //funUpdate(2);  
		    	        		 funCreate(1); 
							}
							if(parseInt(id)==2){    
								// funUpdate(3);
		    	        	     funCreate(2);  
							}
						} 
						}
				}
					
			x.open("GET","lookforchangesDone.jsp?docno="+$('#lprdocno').val()+"&processid="+encodeURIComponent(processid),true);       
			x.send();
		}
		function getInitChartData(){
			  var brhid=$('#cmbbranch').val();
			  var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			  console.log("brhid="+brhid+"=="); 
			  var x=new XMLHttpRequest();
			  x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					var guagedata=JSON.parse(items);           
			        
		          	$("#lpr").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.lprcount);
		        	$("#newclient").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.newclientcount);  
		          	$("#calcul").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.calculcount);	
		          	$("#appl").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.applcount);
					
				}
				else{  
				}
			}
			x.open("GET","getInitChartData.jsp?brhid="+brhid+'&froms='+fromdate+'&tos='+todate,true);                              
			x.send();    
		 }
		$('div').click(function() {
			  var divid=$(this).attr('id');  
			  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
				  var realid=divid.replace(/div/g, "");
				  if(realid=="lpr" || realid=="newclient" || realid=="calcul" || realid=="appl" ){  
					  $("#amcfollowupGrid").jqxGrid('clear');
					  $('#btnconfirm').attr("disabled",true);
					  document.getElementById("divname").value=realid;         
					  funload();             
				  }
				  if(realid=="lpr"){ 
					  document.getElementById('selecteddiv').innerHTML=" - Lease Price Requested";
				  }else if(realid=="newclient"){
					  document.getElementById('selecteddiv').innerHTML=" - New Client";  
				  }else if(realid=="calcul"){
					  document.getElementById('selecteddiv').innerHTML=" - Quoted";
				  }else if(realid=="appl"){
					  document.getElementById('selecteddiv').innerHTML=" - Application";  
				  }else{}   
			  }
		  }); 
		function funload(){
			 $("#amcfollowupGrid").jqxGrid('clear');
			 var divname=$('#divname').val();  
			 var brhid=$('#cmbbranch').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 $('#presalesdiv').load('crmGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
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
					getInitChartData();
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
		function funAttachs(event){                         
			var brchid=document.getElementById("brhid1").value;  
	   		var docno=document.getElementById("lprdocno").value;  
	   		var url=document.URL;
			var reurl=url.split("com/");
	 		if(docno!="" && docno!="0"){                
	   			var frmdet="CRD"; 
	   			var fname="CRM";
	   		    var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
	   		}else{   
				swal({
					icon: 'warning',
					title: 'Warning',
					text: 'Select a Document....!'                                   
				});
				return;
			    }               
		   }
		
		function viewEnquiry(){        
			var lprvocno=document.getElementById("lprvocno").value;
			var lprdocno=document.getElementById("lprdocno").value;
			var address=document.getElementById("address").value;
			var brch=document.getElementById("brhid1").value;
			var client=document.getElementById("client").value;
			var cldocno=document.getElementById("cldocno").value;
			var mobile=document.getElementById("per_mob").value;
			var email=document.getElementById("mail1").value;
			var remarks=document.getElementById("hidremarks").value;
			var ldate=document.getElementById("ldate").value;
			var enqsource=document.getElementById("enqsource").value;
			var enqdoc=document.getElementById("enqdoc").value;

			var path1="com/operations/marketing/leasepricerequestalfahim/leasepricerequest.jsp";  
			var name="Lease Price Request";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Lease Price Request";
			window.parent.formCode.value="LPR";
			window.parent.branchid.value=brch;
			var detName="Lease Price Request";  
			var mode="view";  
			 // alert("&reftrno="+reftrno);
			// alert("modes="+mode+"&brhid="+brch+"&reftrno="+reftrno+"&address="+address+"&client="+client+"&cldocno="+cldocno+"&mobile="+mobile+"&email="+email+"&remarks="+remarks+"&ldate="+ldate);
			var path= path1+"?modes="+mode+"&brhid="+brch+"&lprvocno="+lprvocno+"&address="+address+"&client="+client+"&cldocno="+cldocno+"&mobile="+mobile+"&email="+email+"&remarks="+remarks+"&ldate="+ldate+"&lprdocno="+lprdocno+"&enqsource="+enqsource+"&enqdoc="+enqdoc;         
			top.addTab( detName,reurl[0]+""+path);
			funcleardata();
		}
		function viewQuotation(){ 
			var lprvocno=document.getElementById("lprvocno").value;  
			var lprdocno=document.getElementById("lprdocno").value;  
			var brch=document.getElementById("brhid1").value; 
			var per_mob=document.getElementById("per_mob").value;
			var client=document.getElementById("client").value;
			var qotdocno=document.getElementById("qotdocno").value; 
			var qotvocno=document.getElementById("qotvocno").value;  

//alert(qotchkno);
			
			var path1="com/operations/marketing/leasecalculatoralfahim/leaseCalculator.jsp";      
			var name="Lease Calculator / Quote";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Lease Calculator / Quote";   
			window.parent.formCode.value="LEC";
			window.parent.branchid.value=brch;             
			var detName="Lease Calculator / Quote";  
			var mode="view";  
			//alert("?modes="+mode+"&brch="+brch+"&reftrno="+reftrno+"&client="+client+"&per_mob="+per_mob+"&qotchkno="+qotchkno+"&refdocno="+refdocno+"&calcvoc="+calcvoc);
			  var path= path1+"?modes="+mode+"&brch="+brch+"&lprdocno="+lprdocno+"&client="+client+"&per_mob="+per_mob+"&qotdocno="+qotdocno+"&lprvocno="+lprvocno+"&qotvocno="+qotvocno;  
			top.addTab( detName,reurl[0]+""+path);
			funcleardata();
		}
		function viewContract(){                             
			var brch=document.getElementById("brhid1").value; 
			var cldocno=document.getElementById("cldocno").value;
			var address=document.getElementById("address").value;
			var client=document.getElementById("client").value;
			var mobile=document.getElementById("per_mob").value;
			var email=document.getElementById("mail1").value;
			var sal_name=document.getElementById("salname").value;
			var qotdocno=document.getElementById("qotdocno").value;  
			var lprvocno=document.getElementById("lprvocno").value;  
			var lprdocno=document.getElementById("lprdocno").value;
			var appldocno=document.getElementById("appldocno").value;         
			var qotvocno=document.getElementById("qotvocno").value;  

			var path1="com/operations/marketing/leasequotation/leaseQuotation.jsp";        
			var name="Lease Application";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Lease Application";            
			window.parent.formCode.value="LQT";
			window.parent.branchid.value=brch;             
			var detName="Lease Application";  
			var modes="view";  
			  
			  var path= path1+"?mod="+modes+"&appldocno="+appldocno+"&leasereqdocno="+lprdocno+"&cldocno="+cldocno+"&client="+client+
			  "&address="+address+"&mobile="+mobile+"&email="+email+"&sal_name="+sal_name+"&docno="+qotdocno+"&vocno="+qotvocno;
			top.addTab( detName,reurl[0]+""+path);
			funcleardata();
		}
		function funEnqflwp(){
			var brhid=document.getElementById("brhid1").value;
			var date =  $('#enqflwupdate').val();
			var remarks = $('#enqflwupremarks').val().replace(/\n/g, '');
			var lprdocno = $('#lprdocno').val();  
			var qotdocno = $('#qotdocno').val();  
		//	var reason= $('#cmbreason').val().split(":")[0]; 
			var enqprocess = $('#cmbenqprocess').val(); 
			var clname = $('#client').val(); 
            var cldocno= $('#cldocno').val();
            var type="";
          
			var rdtype = "LPR"; 
			var process="Lease Price Request Followup";
			if(remarks==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Enter Remarks.'
					});
	  		      return false;
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
						saveEnqflwp(date,lprdocno,rdtype,remarks,brhid,process,qotdocno,enqprocess,clname,type);       
					}
			});
		}
		function saveEnqflwp(date,lprdocno,rdtype,remarks,brhid,processid,qotdocno,enqprocess,clname,type){          
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
									 $('#modalenquiryfollowup').modal('hide');  
                                     if(enqprocess=="2"){
										 $('#amcfollowupGrid').jqxGrid('clear');  
									 }else{
										 $("#detailDiv").load("detailGrid.jsp?doc="+qotdocno+"&enqdocno="+lprdocno);  
									 } 
                                     funcleardata();
							}else{
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Updated'    
										});
							} 
					}
			}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&enqprocess="+enqprocess+"&date="+date+"&rdtype="+rdtype+"&docno="+lprdocno+"&brhid="+brhid+"&remarks="+encodeURIComponent(remarks)+"&clname="+encodeURIComponent(clname)+"&type="+type,true);       
		x.send();
		}
		
		
		
	
		function  funcleardata()
		{
			  $('.textpanel p').text('');  
				document.getElementById("enqsource").value="";
				document.getElementById("enqdoc").value="";

		
			document.getElementById("hidqotvoc").value="";

			document.getElementById("divname").value="";
		  	document.getElementById("enqdocno").value="";
		 	
		  	 document.getElementById("sitedocno").value="";
			 document.getElementById("qotchkno").value="";
			 document.getElementById("qottrno").value="";
			  	document.getElementById("brhid1").value="";
			 	
			  	 document.getElementById("refdtype").value="";
				 document.getElementById("client").value="";
				 document.getElementById("cldocno").value="";
				  	document.getElementById("address").value="";
				 	
				  	 document.getElementById("per_mob").value="";
					 document.getElementById("mail1").value="";
					 document.getElementById("hidremarks").value="";
					  	document.getElementById("ldate").value="";
					 	
					  	 document.getElementById("salname").value="";
						 document.getElementById("salid").value="";
						 document.getElementById("hidchecklist").value="";
						 document.getElementById("hidcheckrowno").value="";
						 document.getElementById("hidcmbacgroup").value="";
						 document.getElementById("hidcontrno").value="";
						 document.getElementById("lprdocno").value="";
						 document.getElementById("lprvocno").value="";
						 document.getElementById("qotdocno").value="";
						 document.getElementById("qotvocno").value="";
						 document.getElementById("appldocno").value="";
							 
			  $('#date').val(new Date());
			
				  		
			}
		
		function funenqdisable(){  
			var process=$("#cmbenqprocess").val();
			if(process=="1"){
				$('#cmbreason').attr("disabled",true);
			}else{
				$('#cmbreason').attr("disabled",false);
			}
		}
		function getProcess() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="" selected>-- Select -- </option>';
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbprocess').html($.parseHTML(optionsbranch));
		  			$('#cmbprocess').select2({
		  				placeholder:"Select Process",
		  				allowClear:true
		  			});
					
					
				} else {}
			}
			x.open("GET","getProcess.jsp", true);
			x.send();
		}
		function funtxtenable()
		{
			var def=$('#cmbprocess option:selected').text().trim();
		
			if(def=='Follow-Up')
			{
				 $('#cmbfollowup').attr("disabled",false);
				 $('#cmbdecline').attr("disabled",true);
					 
			}
			else if(def=='Declined')
			{
				 $('#cmbdecline').attr("disabled",false);
				 $('#cmbfollowup').attr("disabled",true);
					 
			}
			
		}
</script>
</body>
</html>
