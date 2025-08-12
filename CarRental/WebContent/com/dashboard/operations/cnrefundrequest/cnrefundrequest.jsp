<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Email Log</title>             
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
  <style type="text/css"> 
	  .branch {  
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	}  
      .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 15px;
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
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:260px;  
  		/* height:50px;       */           
  } 
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    .custompanel1{
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
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
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
    .actionpanel{
        padding-right: 5px; 
    }
    .otherpanel{
        padding-right: 5px; 
    }
    .primarypanel{
        padding-right: 5px; 
    }
    .padtop{
        padding-top: 5px; 
    }
    .class-pad5{
     padding-top: 5px; 
    }
  </style>
</head>       
<body >   
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
		 <form  class="form-inline">      
		  <div class="primarypanel custompanel1">
    <div class="form-group mb-2">
        <label class="form-group mb-2" for="cmbpriority">From:</label>
        <div class="form-group mb-2">
            <div id='fromdate' name='fromdate'></div>
        </div>
    </div>

    <div class="form-group mb-2">
        <label class="form-group mb-2" for="cmbpriority">To:</label>
        <div class="form-group mb-2">
            <div id='todate' name='todate'></div>
        </div>
    </div>
    <div class="form-group mb-2">
        <div class="form-group mb-2">
            <select id="apprtype" name="apprtype" class="form-control" onchange="loads();checkUserRole();">
                <option value="0">Not Approved</option>
                <option value="1">Approved</option>
                <option value="3">Processed</option>
                <option value="2">Rejected</option>
               
            </select> 
        </div>
    </div>
</div>
		  
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>   
        <div class="primarypanel custompanel1">     
  			<button type="button" class="btn btn-default" id="btnrequest"  data-toggle="tooltip" title="Request" data-placement="bottom"><i class="fa fa-pencil-square-o " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnapprove" data-toggle="tooltip" title="Reject" data-placement="bottom"><i class="fa fa-check-square-o " aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btngmapproval"  data-toggle="tooltip" title="GM Approval" data-placement="bottom"><i class="fa fa-thumbs-o-up " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnfinalapproval"  data-toggle="tooltip" title="Final Approval" data-placement="bottom"><i class="fa fa-thumbs-up " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btncreditnote"  data-toggle="tooltip" title="Credit Note" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnrefund"  data-toggle="tooltip" title="Refund" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>    
            <button type="button" class="btn btn-default" id="btnattach"  data-toggle="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>        
        </div>   
        <div class="textpanel custompanel" >
			<p style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>          
        </div>
        </form>
      </div>
    </div>
     
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="cnrrDiv"><jsp:include page="cnrefundrequestGrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    
    
    <div class="modal fade" id="approveRejectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0 text-center" style="background-color: #007bff; color: white; height: 45px; padding: 5px 20px;">
        <h4 class="modal-title font-weight-bold" id="exampleModalLabel">Reject</h4>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form autocomplete="off">
        <div class="modal-body">
         <!--  <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 form-group">  
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="approveReject" id="approve" value="approve" onchange="funApprRadio();">
                  <label class="form-check-label" for="approve">Approve</label>
                </div>
            </div>
             <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 form-group">  
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="approveReject" id="reject" value="reject" onchange="funApprRadio();">
                  <label class="form-check-label" for="reject">Reject</label>
                </div>
            </div>
         </div>   --> 
         <!-- <div class="row" id="refnoID"> 
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 form-group">
              <label for="refNo">Ref No</label>
              <input type="text" class="form-control" id="apprrefNo" placeholder="Enter reference number">
            </div>
          </div> -->  
          <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
              <label for="description">Description</label>
              <textarea class="form-control" id="apprDescription" rows="3" placeholder="Enter description"></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer border-top-0 d-flex justify-content-between">
          <button type="button" class="btn btn-success" id="btnapprovesave">Save</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </form>
    </div>
  </div>
</div>
    
    
<div class="modal fade" id="requestModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0 text-center" style="background-color: #007bff; color: white; height: 45px; padding: 5px 20px;">
        <h4 class="modal-title font-weight-bold" id="exampleModalLabel">Request</h4>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <form autocomplete="off">
        <div class="modal-body">
          <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 form-group">  
              <label for="type">Type</label>
              <select class="form-control" id="type">
                <option value="">-- Select --</option>
                <option value="Credit Note">Credit Note</option>
                <option value="Refund">Refund</option>  
              </select>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 form-group">  
              <label for="Client">Client</label>
              <input type="text" class="form-control" id="txtclient" list="clientlist" placeholder="Search for client">    
              <datalist id="clientlist"></datalist>   
            </div>
          </div>
          <div class="row" >
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 form-group">
              <label for="agmtType">Agmt Type</label>
              <select class="form-control" id="agmtType" onchange="getAgmtno();">  
                <option value="">-- Select --</option>
                <option value="RAG">Rental</option>
                <option value="LAG">Lease</option>  
              </select>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 form-group">
              <label for="agmtNo">Agmt No</label>
               <input type="text" class="form-control" id="agmtNo" list="agmtnolist" placeholder="Search for Agmt No">    
                <input type="hidden" class="form-control" id="hidagmtNo" name="hidagmtNo">    
             <datalist id="agmtnolist"></datalist> 
               
              </div> 
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 form-group">
              <label for="amount">Amount</label>
              <input type="number" class="form-control" id="amount" placeholder="Enter amount">
            </div>  
             
         
        
         
        </div>
          <div class="row">
           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 form-group">
              <label for="salesman">Salesman</label>
              <input type="text" class="form-control" id="salesman">
               <input type="hidden" class="form-control" id="hidsalesman" name="hidsalesman">    
           
            </div>  
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 form-group">
              <label for="closedate">Agmt CloseDate</label>
              <input type="text" class="form-control" id="closedate" >
            </div>  
          </div>
       
         <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
              <label for="description">Description</label>
              <textarea class="form-control" id="description" rows="3" placeholder="Enter description"></textarea>
            </div>
          </div>
        <div class="modal-footer border-top-0 d-flex justify-content-between">
          <button type="button" class="btn btn-success" id="btncnrefundreqsave">Save</button>  
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>   
        </div>
      </form>
    </div>
  </div>
</div>

  
 
    <input type="hidden" name="hiddocno" id="hiddocno">   
    <input type="hidden" name="hidcldocno" id="hidcldocno">  
    <input type="hidden" name="hidagmtdocno" id="hidagmtdocno">  
    <input type="hidden" name="hidacno" id="hidacno">  
    <input type="hidden" name="hidaccount" id="hidaccount">         
    <input type="hidden" name="hidclient" id="hidclient">   
    <input type="hidden" name="hidbrhid" id="hidbrhid">     
    <input type="hidden" name="hidagmttype" id="hidagmttype">  
    <input type="hidden" name="hidagmtvocno" id="hidagmtvocno">  
    <input type="hidden" name="hiddescription" id="hiddescription">             
    <input type="hidden" name="hidamount" id="hidamount">   
    <input type="hidden" name="hidagmtdocno" id="hidagmtdocno">    
    <input type="hidden" name="hidtype" id="hidtype">  
    <input type="hidden" name="hidstatus" id="hidstatus">  
    <input type="hidden" name="hidconfig" id="hidconfig">     
    
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="../../../../vendors/cookie/cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){ 
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
	    $("#detailDiv").prop("hidden", true);
	    $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
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

	    getCustomer(); actionPoints(); checkUserRole(); 
        $('#btnsubmit').click(function(){  
        	$("#hidtype").val('');
        	$("#hiddocno").val('');
            loads(); 
            actionPoints();
        });  
      
        $('#btncreditnote').click(function(){
        	funFormInWindow("CNO");
        }); 
        
        $('#btnrefund').click(function(){
        	funFormInWindow("RRP");
        });
        
        $('#btnattach').click(function(){   
        	funFormInWindow("ATTACH");
	    });
        
        $('#btngmapproval').click(function(){  
        	var docno = $("#hiddocno").val();
        	if(docno == null || docno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Document'   
				});
		        return false; 
        	}
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Approve?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$("#overlay, #PleaseWait").show();
						funApproval("GM", docno);     
					}
			});
	    });
        
        $('#btnfinalapproval').click(function(){ 
        	var docno = $("#hiddocno").val();
        	if(docno == null || docno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Document'   
				});
		        return false; 
        	}
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Approve?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$("#overlay, #PleaseWait").show();
						funApproval("FINAL", docno);  
					}
			});
        	
	    });
        
        $('#btnexcel').click(function(){  
		    $("#cnrrDiv").excelexportjs({ 
				containerid: "cnrrDiv",       
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxCRRGrid",   
				columns: getColumns("jqxCRRGrid") ,   
				worksheetName:"CN/Refund Request"  
	 		});       
         });
        
        $('#btnapprove').click(function(){ 
            var docno = $("#hiddocno").val();
        	if(docno == null || docno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Document'   
				});
		        return false; 
        	}
        	$('#approveRejectModal').modal('show');
        	$('#approve').prop('checked', true);
        });
        
        $('#btnapprovesave').click(function(){   
        	var refno = 0;
        	var desc = $("#apprDescription").val();
        	var docno = $("#hiddocno").val();
        	var status=2;
        	/* if ($('#approve').is(':checked')) {
				if(refno == null || refno == ""){
					Swal.fire({  
						icon: 'warning',
						title: 'Warning',
						text: 'Please enter Ref No'
					});
					return false; 
				}
				status=1;
        	}else{
        		status=2;
        	} */  
        	if(desc == null || desc == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please enter Description'
				});
		        return false; 
        	} 
        	
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want save changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$("#overlay, #PleaseWait").show();
						var process = "Approve";
						saveApprove(docno, refno, desc, process, status);      
					}
			});
        });
        
        $('#btnrequest').click(function(){  
        	$('#requestModal').modal('show');
        });
        
        $('#btncnrefundreqsave').click(function(){    
        	var type = $("#type").val();
        	var agmtType = $("#agmtType").val();
        	var amount = $("#amount").val();
        	var description = $("#description").val();
        	var cldocno = $("#hidcldocno").val();
        	var agmtdocno = $("#hidagmtdocno").val();
        	var hidsalesman = $("#hidsalesman").val();
        	var closedate = $("#closedate").val();
        	if(type == null || type == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Type'
				});
		        return false; 
        	}
        	
        	if(cldocno == null || cldocno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Client'
				});
		        return false; 
        	}
        	
        	if(agmtType == null || agmtType == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select an Agmt Type'
				});
		        return false; 
        	}
        	
        	if(agmtdocno == null || agmtdocno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select an Agmt No'
				});
		        return false; 
        	}
        	
        	if(amount == null || amount == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please enter Amount'
				});
		        return false; 
        	}
        	
        	if(description == null || description == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please enter Description'
				});
		        return false; 
        	}
        	
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want save changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$("#overlay, #PleaseWait").show();
						var process = "Request";
						saveRequest(type, cldocno, agmtType, agmtdocno, amount, description, process,hidsalesman,closedate);      
					}
			});
        });
        
        $("#txtclient").change(function() {  
            var el = $("#txtclient")[0];
            if(el.value.trim() != '') {
                var cldocno = $("#clientlist option[value='" + $('#txtclient').val() + "']").attr('data-cldocno');
                $("#hidcldocno").val(cldocno);  
//                console.log(cldocno)
                getAgmtno();
            }
        });
        
        $("#agmtNo").change(function() {  
            var el = $("#agmtNo")[0];
            if(el.value.trim() != '') {
                var docno = $("#agmtnolist option[value='" + $('#agmtNo').val() + "']").attr('data-docno');   
                $("#hidagmtdocno").val(docno);  
            }
        });
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxCRRGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    Date.prototype.addDays = function(days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() + days);
        return date;
    }
    
    
    Date.prototype.addDays = function(days) {
        var uptodate = new Uptodate(this.valueOf());
        uptodate.setUptodate(uptodate.getUptodate() + days);
        return uptodate;
    }
    
    function clearfields(){
    	document.getElementById("hidid").value=""; 
    	 $("#cnrrDiv").jqxGrid('clear');
			 
    }
    
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#jqxCRRGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxCRRGrid").jqxGrid('applyfilters');    
 	}
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var fromdate= $("#fromdate").val();
	    var todate= $("#todate").val();
        var apprtype = $("#apprtype").val();
		$('#cnrrDiv').load('cnrefundrequestGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&apprtype='+encodeURIComponent(apprtype)+'&id=1');                    
		$(".textpanel p").text("");   
    } 
    
    function actionPoints(){
    	var type = $("#hidtype").val();
    	var status = $("#hidstatus").val();
    	var config = $("#hidconfig").val();
    	// alert(status);
    	if(parseInt(status) == 4){
    			if(type == "Credit Note"){
            		$("#btncreditnote").show();
            		$("#btnrefund").hide();
            	}else if(type == "Refund"){
            		$("#btnrefund").show();
            		$("#btncreditnote").hide();
            	}else{
            		$("#btncreditnote").hide();
            		$("#btnrefund").hide();
            	}
    	}else{
    		$("#btncreditnote").hide();
    		$("#btnrefund").hide();
    	}
    }
	  
    function getCustomer() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(","); 
				var optionsyear = "";
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearItems[i] + '" data-cldocno="'+yearIdItems[i]+'"></option>';
				}  
//				console.log(optionsyear);
				$("datalist#clientlist").html(optionsyear);  
				
			} else {
			}
		}
		x.open("GET", "getCustomer.jsp", true);
		x.send();
	}
    
    function getAgmtno() {
    	var cldocno = $("#hidcldocno").val();
    	var agmttype = $("#agmtType").val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(","); 
				var optionsyear = "";
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearItems[i] + '" data-docno="'+yearIdItems[i]+'"></option>';
					
					
				}  
				$("datalist#agmtnolist").html(optionsyear);
				
			} else {
			}
		}
		x.open("GET", "getAgmtno.jsp?cldocno="+cldocno+"&agmttype="+agmttype, true);     
		x.send();
	}
    
    function getSalesman() {
    	var agmtno = $("#hidagmtNo").val(); 
    	var agmttype = $("#agmtType").val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesman = items[0].split(",");
				var cldate = items[1].split(","); 
				var hidsalesman = items[2].split(","); 
				$("#salesman").val(salesman);
				$("#hidsalesman").val(hidsalesman);
				$("#closedate").val(cldate);
				
			} else {
			}
		}
		x.open("GET", "getSalesman.jsp?agmtno="+agmtno+"&agmttype="+agmttype, true);     
		x.send();
	}
      
    function saveRequest(type, cldocno, agmtType, agmtdocno, amount, description, process,hidsalesman,closedate){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.trim();
					 if(parseInt(items)>0){  	  
						 loads() 
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Saved'  
									});
								 $('#requestModal').modal('hide'); 
								 $('#txtclient').val('');
								 $('#agmtNo').val('');
								 $("#type").val('');
								 $("#agmtType").val('');
								 $("#amount").val('');
								 $("#description").val('');
								 $("#hidcldocno").val('');
								 $("#hidagmtdocno").val('');
								 $("#hidagmtNo").val('');
								 $("#salesman").val('');
								 $("#hidsalesman").val('');
								 $("#closedate").val('');
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Saved'  
								 });
						} 
				}
		}
	x.open("GET","saveData.jsp?description="+encodeURIComponent(description)+"&type="+type+"&cldocno="+cldocno+"&agmtdocno="+agmtdocno+"&amount="+amount+"&agmtType="+agmtType+"&process="+encodeURIComponent(process)+"&hidsalesman="+hidsalesman+"&closedate="+closedate,true);      
	x.send();    
    }
    
    function saveApprove(docno, refno, desc, process, status){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.trim();
					 if(parseInt(items)>0){  	  
						 loads() 
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
									 $('#approveRejectModal').modal('hide');   
									 $("#apprrefNo").val('');
									 $("#apprDescription").val('');
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
								 });
						} 
				}
		}
	x.open("GET","saveData.jsp?description="+encodeURIComponent(desc)+"&refno="+refno+"&status="+status+"&docno="+docno+"&process="+encodeURIComponent(process),true);      
	x.send();    
    }
    
    /*function funApprRadio(){
    	if ($('#approve').is(':checked')) {
    		 $("#refnoID").show();
    	} else {
    		 $("#refnoID").hide();
    	}
     }*/
    
    function funFormInWindow(formType){
    	var brhid = $("#hidbrhid").val();
	    $.ajax({
	        url: 'updateBranch.jsp',
	        type: 'POST',
	        data: { branch: brhid },
	        success: function(response) { 
	        	if(formType == "CNO"){
	        		funCreditNoteOpen()
	        	}else if(formType == "RRP"){
	        		funRentalRefundOpen()
	        	}else if(formType == "ATTACH"){
	        		funAttachs(event);  
	        	}else{}
	        },
	        error: function(xhr, status, error) {}
	    });
    }
    
    function funCreditNoteOpen(){      
	  var path1="com/finance/transactions/creditnote/creditNote.jsp";  
	  var name="Credit Note";
	  var url=document.URL;
	  var reurl=url.split("com/");    
	  var brhid = $("#hidbrhid").val();
	  
	  window.parent.formName.value = "Credit Note"; 
	  window.parent.formCode.value = "CNO";
	  window.parent.branchid.value = brhid;  
	  var detName = "Credit Note";  
	  var mode = "A";
	  
	  var cldocno = $("#hidcldocno").val();
	  var acno = $("#hidacno").val();
	  var account = $("#hidaccount").val();
	  var client = $("#hidclient").val();
	  var amount = $("#hidamount").val(); 
	  var atype = "AR"; 
	  var remarks = $("#hidagmttype").val()+" - "+$("#hidagmtvocno").val()+" - "+$("#hiddescription").val();  
	  var docno = $("#hiddocno").val();
	  var path= path1+"?mod="+mode+"&cnrdocno="+docno+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&acno="+acno+"&account="+account+"&atype="+atype+"&amount="+amount+"&remarks="+encodeURIComponent(remarks);          
//	  console.log("path==="+path)
	  top.addTab( detName,reurl[0]+""+path);  
    }
    
    function funRentalRefundOpen(){        
  	  var path1="com/operations/commtransactions/rentalrefund/rentalRefund.jsp";  
  	  var name="Rental Refund";
  	  var url=document.URL;
  	  var reurl=url.split("com/");    
  	  var brhid = $("#hidbrhid").val();
  	  
  	  window.parent.formName.value = "Rental Refund"; 
  	  window.parent.formCode.value = "RRP";
  	  window.parent.branchid.value = brhid;  
  	  var detName = "Rental Refund";  
  	  var mode = "A";
  	  
  	  var cldocno = $("#hidcldocno").val();
  	  var acno = $("#hidacno").val();
  	  var account = $("#hidaccount").val();
  	  var client = $("#hidclient").val();
  	  var amount = $("#hidamount").val(); 
  	  var agmttype = $("#hidagmttype").val();
  	  var agmtvocno = $("#hidagmtvocno").val();
  	  var agmtdocno = $("#hidagmtdocno").val();
  	  var remarks = $("#hiddescription").val();
  	  var docno = $("#hiddocno").val();
  	 
  	  var path = path1+"?mod="+mode+"&cnrdocno="+docno+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&acno="+acno+"&account="+account+"&agmttype="+agmttype+"&agmtvocno="+agmtvocno+"&agmtdocno="+agmtdocno+"&amount="+amount+"&remarks="+encodeURIComponent(remarks);          
  	  console.log("path==="+path)
  	  top.addTab( detName,reurl[0]+""+path);  
      }
    
    function checkUserRole(){
	    $.ajax({
	        url: 'checkUserRole.jsp',
	        type: 'GET',
	        success: function(resp) { 
	        	 var type = $("#apprtype").val();
	        	 
	        	 if(type == "0" && parseInt(resp.trim())>0){
	        		 var statusid = parseInt(document.getElementById("hidstatus").value.trim()==""?0:document.getElementById("hidstatus").value);
	        		// alert(parseInt(resp.trim())+"==="+ statusid);
	        		 if(parseInt(resp.trim())==2 && statusid < 2){
	        			 $("#btngmapproval").show();
	        			 $("#btnfinalapproval").hide();	 
	    				}
	        		 else if(parseInt(resp.trim())==1  && statusid==3){
	        			 $("#btngmapproval").hide();
	        			 $("#btnfinalapproval").show();	 
	    				}
	        		 else{
		        		 $("#btngmapproval").hide();
		        		 $("#btnfinalapproval").hide();  
		        	 }
	        		 
	        		 
	        	 }else{
	        		 $("#btngmapproval").hide();
	        		 $("#btnfinalapproval").hide();  
	        	 }
	        },
	        error: function(xhr, status, error) {}
	    });
    }
    
    function funAttachs(event){  
   	     var docno = $("#hiddocno").val();
   	     var branchid = $("#hidbrhid").val();
   	     var jobname = "";
   	     var url = document.URL;
		 var reurl = url.split("/com/");
	 	 if(docno != "" && docno != "0"){                
	   			var frmdet = "CRR"; 
	   			var fname = "CN/Refund Request";
	   		    var myWindow = window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+branchid+"&jobname="+jobname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
	            myWindow.focus();
	   	 }else{   
	   		swal.fire({
			    icon: 'warning',
				title: 'Warning',
				text: 'Please select a document!'
			});
			return;
	    }  
     }
    
    function funApproval(process, docno){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.trim();
					 if(parseInt(items)>0){  	  
						         loads() 
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Approved'  
									});
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Approved'  
								 });
						} 
				}
		}
	x.open("GET","saveData.jsp?docno="+docno+"&process="+encodeURIComponent(process),true);        
	x.send();    
    }
      
    $('#agmtNo').on('input', function() {
        var selectedValue = $(this).val();
    	var value = selectedValue;
    	var parts = value.split("-");
    	 if (selectedValue) {
             $('#hidagmtNo').val(parts[0]); // Set hidden input
             getSalesman();
         } else {
             $('#hidagmtNo').val(''); // Clear if not found
         }
    });
  </script>
  </div>
</body>
</html>
