<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Booking</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../../../js/animate/animate.css">
    <jsp:include page="../../../../bookingIncludes.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../../../../vendors/select2/select2.min.css">

    <style type="text/css">
        @media (min-width: 900px) {
            .modal-xl {
                width: 100%;
                max-width: 1200px;
            }
        }
        
        .branch {
            font-weight: normal;
        }
        
        .tabling {
            border: 1px solid red;
            padding-right: 10px;
            padding-left: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
        }
        
        .textpanel {
            color: blue;
        }
        
        .custompanel {
            float: left;
            display: inline-block;
            margin-top: 10px;
            padding:10px;
            border-radius: 8px;
        	border:1px solid #ccc;
        	margin-bottom:4px;
        	
        }
        .custompanel:not(:last-child){
        	margin-right:10px;
        }
        .badge-notify {
            position: absolute;
            right: -5px;
            top: -8px;
            z-index: 2;
            background-color: red;
        }
        
        .comment {
            background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            clear: both;
            float: right;
            display: block;
            padding-top: 8px;
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 5px;
            border-radius: 12px;
            border-top-right-radius: 0;
            margin-bottom: 8px;
            transition: all 0.5s ease-in;
        }
        
        .msg-details {
            text-align: right;
        }
        
        .comments-container {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 8px;
            padding-right: 5px;
        }
        
        .comments-outer-container {
            width: 100%;
            height: 100%;
        }
        
        .msg {
            word-break: break-all;
        }
        
        .rowgap {
            margin-bottom: 6px;
        }
        .div-inline{
		    display:inline-block;
		}
		.badge-bg{
			background: #a8c0ff;  /* fallback for old browsers */
			background: -webkit-linear-gradient(to right, #3f2b96, #a8c0ff);  /* Chrome 10-25, Safari 5.1-6 */
			background: linear-gradient(to right, #3f2b96, #a8c0ff); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
			color:#fff;
		}
		.d-flex{
			display:flex;align-items:center;
		}
		.d-flex label{
			margin-right:1rem;
		}
		.d-flex label:not(:first-child){
			margin-left:1rem;
		}
    </style>
</head>

<body onload="getBranch();getTariffConfigBook();">
    <form autocomplete="off">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="branchpanel custompanel form-inline">
                    	<div class="d-flex">
							<label>From:</label>
							<div id="fromdate"></div>
						
						<label>To:</label>
							<div id="todate"></div>
							<div class="form-group" style="margin-left:1rem;">
							<select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:min-width:125px;">
	                        	<option value="">--Select--</option>
	                        </select>
						 	<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>' />
						</div>
						<div class="form-group" style="margin-left:1rem;">
							<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
                        	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
						    </div>
						<div class="dropdown div-inline" style="margin-left:0.5rem;">
  							<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
  							<ul class="dropdown-menu">
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#FFEBEB;"></i>Reservation</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#e8d4b4;"></i>Job Assigned</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#e8d4b4;"></i>Driver Accepted</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#c06c84;"></i>Change In Time</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#F6F874;"></i>Waiting For Guest</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#B5E3AE;"></i>Trip Started</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#CAF0F8;"></i>Trip Ended</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#AEAF9D;"></i>No Show</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#E88375;"></i>No Vendor Amount </a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#DBA67B;"></i>Cancelled </a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#e0aaff;"></i>Job Closed </a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#ffadad;"></i>Invoiced </a></li>
  							</ul>
						</div>
							
						</div>
						
						                        
                    </div>
                    <!-- <div class="primarypanel custompanel">
                        
                    </div> -->
                    <div class="actionpanel custompanel">
                        <button type="button" class="btn btn-default" id="btnattach"  data-toggle="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>        
	                    <button type="button" class="btn btn-default" id="btnstatus" data-toggle="modal" data-target="#modalstatusupdate"><i class="fa fa-database " aria-hidden="true" data-toggle="tooltip" title="STATUS UPDATE" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnjobassign" data-toggle="modal" data-target="#modaljobaasign"><i class="fa fa-pencil-square-o " aria-hidden="true" data-toggle="tooltip" title="JOB ASSIGNMENT" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnconassign"><i class="fa fa-check" aria-hidden="true" data-toggle="tooltip" title="Confirm Assignment" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnchangetime" data-toggle="modal" data-target="#modalchangetime"><i class="fa fa-history " aria-hidden="true" data-toggle="tooltip" title="CHANGE IN TIME" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnstarttrip" data-toggle="modal" data-target="#modalstarttrip" style="display: none;"><i class="fa fa-play" aria-hidden="true" data-toggle="tooltip" title="START TRIP" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnendtrip" data-toggle="modal" data-target="#modalendtrip" style="display: none;"><i class="fa fa-stop" aria-hidden="true" data-toggle="tooltip" title="END TRIP" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnconfirmss" data-toggle="modal" data-target="#modalconfirm"><i class="fa fa-check-circle " aria-hidden="true" data-toggle="tooltip" title="CONFIRM" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btntaskcreation" data-toggle="modal" data-target="#modaltaskcreation"><i class="fa fa-plus-square " aria-hidden="true" data-toggle="tooltip" title="TASK CREATION" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnvendorprice"><i class="fa fa-exchange " aria-hidden="true" data-toggle="tooltip" title="Vendor Price" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btncomplete"><i class="fa fa-check-square " aria-hidden="true" data-toggle="tooltip" title="Complete" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnjobexpense"><i class="fa fa-money" aria-hidden="true" data-toggle="tooltip" title="Expense" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnmultiassign"><i class="fa fa-users" aria-hidden="true" data-toggle="tooltip" title="Multi-Assignment" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnopenbooking"><i class="fa fa-eye" aria-hidden="true" data-toggle="tooltip" title="View Booking" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnviewguest"><i class="fa fa-id-badge" aria-hidden="true" data-toggle="tooltip" title="View Guest" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btncopytoclipboard"><i class="fa fa-clipboard" aria-hidden="true" data-toggle="tooltip" title="Copy to clipboard" data-placement="bottom"></i></button>
                    	<div class="btn-group" role="group">
                    		<button type="button" class="btn btn-default" id="btnbookconfirmmail"><i class="fa fa-paper-plane " aria-hidden="true" data-toggle="tooltip" title="Confirmation Mail" data-placement="bottom"></i></button>
                    		<span class="badge badge-notify badge-bg">B</span>
                    	</div>
                    	<div class="btn-group" role="group">
                    		<button type="button" class="btn btn-default" id="btndriverdetmail"><i class="fa fa-paper-plane " aria-hidden="true" data-toggle="tooltip" title="Confirmation Mail" data-placement="bottom"></i></button>
                    		<span class="badge badge-notify badge-bg">D</span>
                    	</div>
                    	
                    	
                    </div>
                    <div class="warningpanel custompanel">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnteamselection" data-toggle="modal" data-target="#modalpendingtask"><i class="fa fa-newspaper-o " aria-hidden="true" data-toggle="tooltip" title="PENDING TASK" data-placement="bottom"></i></button>
                            
                        </div>
                        <div class="btn-group hidden" role="group">
                            <button type="button" class="btn btn-default" id="btnconfirm" data-toggle="tooltip" title="Confirmation" data-placement="bottom" data-filtervalue="Confirmation" data-datafield="status"><i class="fa fa-check-square-o " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-confirm"></span>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnjbassign" data-toggle="tooltip" title="Job Assigned" data-placement="bottom" data-filtervalue="Job Assigned" data-datafield="status"><i class="fa fa-file-text " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-jbassign"></span>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnchngetime" data-toggle="tooltip" title="Change in Time" data-placement="bottom" data-filtervalue="Change in Time" data-datafield="status"><i class="fa fa-clock-o " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-chngetime"></span>
                        </div>
                    </div>
                    <div class="otherpanel custompanel">
                        <button type="button" class="btn btn-default" id="btncomment" data-toggle="modal" data-target="#modalcomments"><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnlogs"><i class="fa fa-list " aria-hidden="true" data-toggle="tooltip" title="Logs" data-placement="bottom"></i></button>
                    </div>
                    <div class="textpanel custompanel">
                        <p style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div id="bookdiv">
                        <jsp:include page="bookingGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
        <!-- Logs Modal -->
		<div id="modallogs" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Logs</h4>
					</div>
					<div class="modal-body">
						<div class="table-responsive">
							<table class="table table-striped" id="tbllogs">
								<thead>
									<tr>
										<th>Branch</th>
										<th>User</th>
										<th>Date &amp; Time</th>
										<th>User Remarks</th>
										<th>System Remarks</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Vendor Price Modal -->
		<div id="modalvendorprice" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Vendor Price</h4>
					</div>
					<div class="modal-body">
						<div class="text-center" style="margin-bottom:15px;"><span class="label label-default vendor-job"></span></div>
						<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Amount</label>
                    			<div class="col-sm-10">
                        			<input type="text" class="form-control text-right" id="vendoramount" name="vendoramount" onblur="funRoundAmt(this.value,this.id);"/>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Discount</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="vendordiscount" id="vendordiscount" class="form-control text-right"  onblur="funRoundAmt(this.value,this.id);">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Net Amount</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="vendornetamount" id="vendornetamount" class="form-control text-right" onblur="funRoundAmt(this.value,this.id);">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnvendorpriceupdate" id="btnvendorpriceupdate">Save changes</button>
					</div>
				</div>
			</div>
		</div>
        <!-- Status update Modal-->
        <div id="modalstatusupdate" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Status Update</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Status</label>
                    			<div class="col-sm-10">
                        			<select class="form-control" name="cmbstatus" id="cmbstatus" style="width: 100%">
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                    			
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="remarks" id="remarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                	<div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdate" id="btnstatuspdate">Save changes</button>
	          		</div>
                </div>
            </div>
        </div>

        <!-- Job Assign Modal-->
        <div id="modaljobaasign" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Job Assignment</h4>
                    </div>
                    <div class="modal-body">
						<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Date</label>
                    			<div class="col-sm-9">
                        			<div id="uptodate"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="cmbprocess" >Process</label>
                    			<div class="col-sm-9">
                    				<select id="cmbprocess" class="form-control">
                                        <option value="">--Select--</option>
                                        <option value="1">Branch Transfer</option>
                                        <option value="2">Assignment - Internal</option>
                                        <option value="3">Assignment - External</option>
                                    </select>
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="driverss" >Driver</label>
                    			<div class="col-sm-9">
                    				<div id="driverss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="driverSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="driver" id="driver">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="fleetsearchdiv" >Fleet</label>
                    			<div class="col-sm-9">
                    				<div id="fleetsearchdiv" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="fleetSearchInput.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="fleetno" id="fleetno">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="vendorsearchdiv" >Vendor</label>
                    			<div class="col-sm-9">
                    				<div id="vendorsearchdiv" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="vendorsearchlist.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="vendorid" id="vendorid">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="fleetsearchdiv" >Transfer branch</label>
                    			<div class="col-sm-9">
                    				<select id="cmbtransferbranch" class="form-control">
                                        <option value="">--Select--</option>
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>                    	
                    </div>
                    <div class="modal-footer">
                    	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearFieldsJobsAssign();">Close</button>
                		<button type="button" class="btn btn-default btn-primary" onclick="funSave();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Change Time Modal-->
        <div id="modalchangetime" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Change In Time</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">New Date</label>
                    			<div class="col-sm-9">
                        			<div id="cgdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">New Time</label>
                    			<div class="col-sm-9">
                        			<div id="cgtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Assign Driver</label>
                    			<div class="col-sm-9">
                        			<div id="cgdriverss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="cgdriverSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="cgdriver" id="cgdriver">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Remarks</label>
                    			<div class="col-sm-9">
                        			<input type="text" class="form-control" placeholder="Remarks" id="cgdesc">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-default btn-primary" onclick="funCTSave();">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Comments Modal-->
        <div id="modalcomments" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#CDFDFA">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Comments</h4>
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
        
        
        <!-- start Modal -->
		<div id="modalstarttrip" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width:400px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Start Trip</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="startkm" >Start Km</label>
                    			<div class="col-sm-6">
                    				<input type="number" name="startkm" id="startkm" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="tripdate">Date</label>
                    			<div class="col-sm-9">
                        			<div id="tripdates"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="triptimes" >Time</label>
                    			<div class="col-sm-9">
                        			<div id="triptimes" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="remarkstart" >Remarks</label>
                    			<div class="col-sm-9">
                    				<input type="text" name="remarkstart" id="remarkstart" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                	<div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdate" id="btnstatuspdate" onclick="validatestartkm()">Save changes</button>
	          		</div>
                </div>
            </div>
        </div>        
     
     	<!-- end Modal -->
		<div id="modalendtrip" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width:400px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">End Trip</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="endkm" >End Km</label>
                    			<div class="col-sm-6">
                    				<input type="number" name="endkm" id="endkm" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="tripdatee" >Date</label>
                    			<div class="col-sm-9">
                        			<div id="tripdatee"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="triptimee" >Time</label>
                    			<div class="col-sm-9">
                        			<div id="triptimee" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="remarkend" >Remarks</label>
                    			<div class="col-sm-9">
                    				<input type="text" name="remarkend" id="remarkend" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                	<div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdate" id="btnstatuspdate" onclick="validateendkm()">Save changes</button>
	          		</div>
                </div>
            </div>
        </div>
        
        
        <!-- task creation Modal-->
        <div id="modaltaskcreation" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Task Creation</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Reference Type</label>
                    			<div class="col-sm-9">
                        			<select id="reftype" class="form-control">
                                        <option value="Booking">Booking</option>
                                        <option value="Others">Others</option>
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Reference No</label>
                    			<div class="col-sm-9">
                        			<input type="number" placeholder="Ref.No" id="refno" class="form-control">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Start Date</label>
                    			<div class="col-sm-9">
                        			 <div id="date" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Start Time</label>
                    			<div class="col-sm-9">
                        			<div id="vtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Assigned User</label>
                    			<div class="col-sm-9">
                        			<div id="userss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="userSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="tuser" id="tuser">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Description</label>
                    			<div class="col-sm-9">
                        			<input type="text" class="form-control" placeholder="Description" id="desc"/>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  		</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-default btn-primary" onclick="funSaveTask();">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Pending Modal-->
        <div id="modalpendingtask" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Pending Task</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">
                            <div class="container-fluid">
                                <table width="100%">
                                    <tr>
                                        <td colspan="6">
                                            <div id="pnddiv">
                                                <jsp:include page="pendingtaskGrid.jsp"></jsp:include>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <div id="flwupdiv">
                                                <jsp:include page="taskfollowupGrid.jsp"></jsp:include>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="7%" align="right">Select Status</td>
                                        <td width="9%">
                                            <select id="assgntask" class="form-control"></select>
                                        </td>
                                        <td width="7%" align="right">Assign To</td>
                                        <td width="4%">
                                            <div id="part" onkeydown="return (event.keyCode!=13);">
                                                <jsp:include page="userSearch2.jsp"></jsp:include>
                                            </div>
                                            <input type="hidden" name="puser" id="puser">
                                        </td>
                                        <td width="5%" align="right">Remarks</td>
                                        <td width="25%">
                                            <input type="text" class="form-control" id="remarks" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default btn-primary">Update Changes</button>
                        
                    </div>
                </div>
            </div>
        </div>
        
       <!--  expense modal -->
       <div id="modaljobexpense" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style=" display: inline;">Job Expense</h4> <p id="selecteddoc"  style="color:blue; display: inline;"></p>
                    </div>
                    <div class="modal-body">
                            <div class="container-fluid">
                            	<div id="jobexpdiv"><jsp:include page="jobexpensegrid.jsp"></jsp:include> </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!--  Multi Assign modal -->
        <div id="modalmultiassign" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style=" display: inline;">Multiple Vehicle Assignment</h4> <p id="doubleclickselecteddoc"  style="color:blue; display: inline;"></p>
                    </div>
                    <div class="modal-body">
                    		<div >
                    			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="assigndriver" style="width: auto;" >Driver</label>
                    			<div class="col-sm-3">
                    				<div id="assigndriver" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="assigndriversearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="assigndrivers" id="assigndrivers">
                                    <input type="hidden" name="assigndriversname" id="assigndriversname">
                                    <span class="help-block hidden"></span>
                    			</div>
                    			</div>
               					<div class="col-sm-1"></div>
                    			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="fleetsearchsdiv" style="width: auto;" >Fleet</label>
                    			<div class="col-sm-4">
                    				<div id="fleetsearchsdiv" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="assignfleetsearchinput.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="fleetnos" id="fleetnos">
                                    <input type="hidden" name="fleetnames" id="fleetnames">
                                    <span class="help-block hidden"></span>
                    			</div>
                    			 <button type="button" class="btn btn-primary" onclick="addAssignment();">Add</button>
                  			</div>
                    			
                    		</div>
                            <div class="container-fluid">
                            	<div id="multiassigndiv"><jsp:include page="assignmultivehgrid.jsp"></jsp:include> </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                         <button type="button" class="btn btn-default btn-primary" onclick="funsavemultiveh();">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!--  Guest View modal -->
        <div id="modalguestview" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style=" display: inline;"> Guest Details </h4> <p id="doubleclickselecteddocguestview"  style="color:blue; display: inline;"></p>
                    </div>
                    <div class="modal-body">
                    	
                            <div class="container-fluid">
                            	<div id="guestviewdiv"><jsp:include page="assignmultivehgrid.jsp"></jsp:include> </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
         <!--  Copy Details modal -->
        <div id="modalcopyview" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style=" display: inline;"> Copied Details </h4>
                    </div>
                    <div class="modal-body">
                    	
                            <div class="container-fluid">
                            	<div id="copiedviewdiv"> <textarea id="copiedText" class="form-control" rows="10" style="width: 100%; resize: vertical; overflow-y: auto;"></textarea> </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-default" onClick="copytoclipboard();">Copy to clipboard</button>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        <input type="hidden" name="hidcomments" id="hidcomments">
        <input type="hidden" name="txtrowno" id="txtrowno">
        <input type="hidden" name="txtdocno" id="txtdocno">
        <input type="hidden" name="bdocno" id="bdocno">
        <input type="hidden" name="type" id="type">
        <input type="hidden" name="rowno" id="rowno">
        <input type="hidden" name="bookdocno" id="bookdocno">
        <input type="hidden" name="detaildocno" id="detaildocno">
        <input type="hidden" name="txtoldstatus" id="txtoldstatus">
        <input type="hidden" name="txtcrtuser" id="txtcrtuser">
        <input type="hidden" name="txtasgnuser" id="txtasgnuser">
        <input type="hidden" name="txtpendocno" id="txtpendocno">
        <input type="hidden" name="txtstartkm" id="txtstartkm">
        <script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
        <script src="../../../../js/sweetalert2.all.min.js"></script>
        <script src="../../../../vendors/select2/select2.min.js"></script>
        <script src="../../../../vendors/cookie/cookie.min.js"></script>
        <script type="text/javascript">
        var isTariffHiddenbook = true;
            $(document).ready(function() {
            	$('[data-toggle="tooltip"]').tooltip();
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#uptodate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#fromdate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#todate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#date").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $('#tripdates').jqxDateTimeInput({
                	 width: '100px',
                     height: '15px',
                     formatString: "dd.MM.yyyy"
                });
                $('#tripdatee').jqxDateTimeInput({
               	 	width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
               });
                $("#triptimes").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#triptimee").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#vtime").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#cgdate").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#cgtime").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#cmbbranch").select2({
                    placeholder: "Select Branch",
                    allowClear: true
                });
                $("#cmbstatus").select2({
                    placeholder: "Select Status",
                    allowClear: true,
                    width: '100%'
                });
                
                $('.actionpanel div.btn-group button').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}

                	//Getting Mail Details
                	var mailmode=0;
                	if($(this).attr('id')=='btnbookconfirmmail'){
                		mailmode=1;
                	}
                	else if($(this).attr('id')=='btndriverdetmail'){
						mailmode=2;                	
                	}
                	var bookarray=new Array();
                	for(var i=0;i<selectedrows.length;i++){
                		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
                		bookarray.push(bookdocno+"::"+jobname);
                	}
                	$.get('getMailDetails.jsp',{'mailmode':mailmode,'bookarray[]':bookarray},function(data){
                		data=JSON.parse(data.trim());
                		var formname="Limousine Booking";
                		formname=encodeURIComponent(formname);
                		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode=LBK&docno="+data.bookdocno+"&brchid="+data.brhid+"&frmname="+formname+"&recipient="+data.mail+"&cldocno="+data.cldocno+"&client="+data.clientname+"&userid="+data.userid+"&dtype=LBK&msg="+encodeURIComponent(data.message),"E-Mail","menubar=0,resizable=1,width=900,height=950");
                	});
                });
                $('.warningpanel div button').click(function() {
                    $(this).toggleClass('active');
                    if ($(this).hasClass('active')) {
                        addGridFilters($(this).attr('data-filtervalue'), $(this).attr('data-datafield'));
                    } else {
                        $('#jqxbookGrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                    }
                });
                $('#btnjobassign').click(function(){
                	var select = document.getElementById("cmbprocess");
                    select.value = "2"; // Set default selection
                    select.dispatchEvent(new Event("change"));
                });
                $('#btncopytoclipboard').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Please select any valid documents'
                            });
                            return false;
                    	}
                	copySelectedRow();
                	$('#modalcopyview').modal("toggle");
                });
                $('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
                /*var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                fromdate=fromdate.setMonth(fromdate.getMonth()-1);
                $('#fromdate').jqxDateTimeInput('setDate',new Date(fromdate));*/
                getBrch();
                funGetCountData();
                
                $('#cmbprocess').on('change', function(){
                	var selectedProcess = $('#cmbprocess').val();
                	if(selectedProcess==3){
                		 $("#jqxInputUser").jqxInput('disabled', true);
                		 $("#fleetSearchInput").jqxInput('disabled', true);
                		 $('#cmbtransferbranch').prop('disabled', true);
                		 
                		 $("#vendorSearchInput").jqxInput('disabled', false);
                	} else if(selectedProcess==2){
                		 $("#jqxInputUser").jqxInput('disabled', false);
                		 $("#fleetSearchInput").jqxInput('disabled', false);
                		 
                		 $("#vendorSearchInput").jqxInput('disabled', true);
                		 $('#cmbtransferbranch').prop('disabled', true);
                	} else if(selectedProcess==1){
	                	 $("#jqxInputUser").jqxInput('disabled', true);
	               		 $("#fleetSearchInput").jqxInput('disabled', true);
	               		 $("#vendorSearchInput").jqxInput('disabled', true);
	               		 
	               		 $('#cmbtransferbranch').prop('disabled', false);
                	}
                	
                })
                
                $('#btnviewguest').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Please select any valid documents'
                            });
                            return false;
                    	}
                    	else if(selectedrows.length>0 && selectedrows.length!=1){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Can select only one document at a time'
                            });
                            return false;
                    	}
                	funviewguest();
                });
                
                $('#btnopenbooking').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Please select any valid documents'
                            });
                            return false;
                    	}
                    	else if(selectedrows.length>0 && selectedrows.length!=1){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Can select only one document at a time'
                            });
                            return false;
                    	}
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bookingno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");

                	Swal.fire({
	  					title: 'Are you sure?',
	  					text: "Do you want to view booking details for "+bookingno+" - "+docname,
	  					icon: 'warning',
	  					showCancelButton: true,
	  					confirmButtonColor: '#3085d6',
	  					cancelButtonColor: '#d33',
	  					confirmButtonText: 'Yes'
					}).then((result) => {
	  					if (result.value) {
	  						$("#overlay, #PleaseWait").show();
	  						funOpenBooking();
	  					}
	  					})
                });
                
                
                $('#btnmultiassign').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Please select any valid documents'
                            });
                            return false;
                    	}
                    	else if(selectedrows.length>0 && selectedrows.length!=1){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Can select only one document at a time'
                            });
                            return false;
                    	}
                	
                	
                	
                	
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bookingno");
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                	var bookingstatus=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bstatus");
            		
                	if(bookingstatus>=7){
                		new	swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'The trip has already been ended'
                        });
                        return false;
                	}
                	
                	Swal.fire({
	  					title: 'Are you sure?',
	  					text: "Do you want to assign multiple vehicle for "+bookingno+" - "+docname,
	  					icon: 'warning',
	  					showCancelButton: true,
	  					confirmButtonColor: '#3085d6',
	  					cancelButtonColor: '#d33',
	  					confirmButtonText: 'Yes'
					}).then((result) => {
	  					if (result.value) {
	  						$("#overlay, #PleaseWait").show();
                			multiassign(bookdocno,docname);
	  					}
	  					})
                });
                
                function funviewguest(){
                	
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Please select any valid documents'
                            });
                            return false;
                    	}
                    	else if(selectedrows.length>0 && selectedrows.length!=1){
                    	new	swal({
                                type: 'warning',
                                title: 'Warning',
                                icon: 'warning',
                                text: 'Can select only one document at a time'
                            });
                            return false;
                    	}
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	$('#doubleclickselecteddocguestview').text($('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[0],'bookingno')+' - '+$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[0],'job')+' - '+$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[0],'client'));
                	
                	$('#modalguestview').modal("toggle");
         		    $('#guestviewdiv').load('guestviewdetail.jsp?docno='+bookingno);

                }
               
                function multiassign(bookdocno,docname) {
                	var x = new XMLHttpRequest();
                    x.onreadystatechange = function() {
                        if (x.readyState == 4 && x.status == 200) {
                            var items = x.responseText.trim();
                            if(items=="1"){
	                			new swal({
	                                type: 'success',
	                                title: 'Message',
	                                icon: 'success',
	                                text: 'Updated Successfully'
	                            });
	                			reload();
	                            $("#overlay, #PleaseWait").hide();
							                    		
                        } else {
                        }
                    }
                    }
                    x.open("GET", "savemultipleassign.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                    x.send();
                }
                
                
                $('#btnjobexpense').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bookingno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                	//console.log(bookdocno+"   "+ docname);
                	$('#selecteddoc').text(bookingno+' - '+docname);
                	if(selectedrows.length==0){
                	new	swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                	new	swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	$('#modaljobexpense').modal("toggle");
                	
                	$('#jobexpdiv').load('jobexpensegrid.jsp?docno='+bookdocno+'&job='+docname);
                });
                
                
                $('#btnsubmit').click(function() {
                	if($('.warningpanel div button').hasClass('active')){
                		$('#jqxbookGrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                		$('.warningpanel div button').removeClass('active');
                	}
                    funGetCountData();
                    reload();
                });

                $('#btnconassign').click(function() {
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bookingno");
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                	var bookingstatus=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bstatus");
                	Swal.fire({
	  					title: 'Are you sure?',
	  					text: "Do you want to assign vehicle for "+bookingno+" - "+docname,
	  					icon: 'warning',
	  					showCancelButton: true,
	  					confirmButtonColor: '#3085d6',
	  					cancelButtonColor: '#d33',
	  					confirmButtonText: 'Yes'
					}).then((result) => {
	  					if (result.value) {
	  						$("#overlay, #PleaseWait").show();
	                		funconfirmassignment();
	  					}
	  					})
                });
                
                function funconfirmassignment(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	var bookingno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bookingno");
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                	var bookingstatus=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"bstatus");
                	var x = new XMLHttpRequest();
                    x.onreadystatechange = function() {
                        if (x.readyState == 4 && x.status == 200) {
                            var items = x.responseText.trim();
                            if(items=="1"){
	                			new swal({
	                                type: 'success',
	                                title: 'Message',
	                                icon: 'success',
	                                text: 'Updated Successfully'
	                            });
	                			reload();
	                            $("#overlay, #PleaseWait").hide();
							                    		
                        } else {
                        }
                    }
                    }
                    x.open("GET", "confirmassign.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                    x.send();
                	
            		
                }
                
                $('#btnlogs').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	$("#overlay, #PleaseWait").show();
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                    var x = new XMLHttpRequest();
                	x.onreadystatechange = function() {
                    	if (x.readyState == 4 && x.status == 200) {
                        	var items = x.responseText.trim();
                        	items=JSON.parse(items);
                        	var htmldata='';
                        	$(items.logdata).each(function( index ,value) {
  								htmldata+='<tr>';
  								htmldata+='<td>'+value.branch+'</td>';
  								htmldata+='<td>'+value.user+'</td>';
  								htmldata+='<td>'+value.logdate+'</td>';
  								htmldata+='<td>'+value.userremarks+'</td>';
  								htmldata+='<td>'+value.systemremarks+'</td>';
  								htmldata+='</tr>';
							});
							$("#overlay, #PleaseWait").hide();
							$('#tbllogs tbody').html($.parseHTML(htmldata));
							$('#modallogs .modal-title').text('Logs of '+bookdocno+' - '+docname);
							$('#modallogs').modal();
                		
                    	}else {
                    	}
                	}
                	x.open("GET", "getLogs.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                	x.send();
                });
                $('#btncomplete').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	else{
						var assigntype=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'assigntype');
						var bstatus=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'bstatus');
						if(assigntype!='3'){
							new swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            icon: 'warning',
	                            text: 'Document must be assigned to vendor'
	                        });
	                        return false;
						}
						if(bstatus=='7'){
							new swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            icon: 'warning',
	                            text: 'Document already completed'
	                        });
	                        return false;
						}
						var vendornetamount=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'vendornetamount');
						if(vendornetamount=="" || vendornetamount==null || vendornetamount=="undefined" || typeof(vendornetamount)=="unedfined" || parseFloat(vendornetamount)==0.0){
							new swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            icon: 'warning',
	                            text: 'Vendor amount is mandatory'
	                        });
	                        return false;
						}
                		var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                		var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                		Swal.fire({
			  					title: 'Are you sure?',
			  					text: "Do you want to complete "+bookdocno+" - "+docname,
			  					icon: 'warning',
			  					showCancelButton: true,
			  					confirmButtonColor: '#3085d6',
			  					cancelButtonColor: '#d33',
			  					confirmButtonText: 'Yes'
							}).then((result) => {
			  					if (result.value) {
			    					$("#overlay, #PleaseWait").show();
			                        var x = new XMLHttpRequest();
					                x.onreadystatechange = function() {
					                    if (x.readyState == 4 && x.status == 200) {
					                        var items = x.responseText.trim();
					                        if(items=="0"){
					                			new swal({
					                                type: 'success',
					                                title: 'Message',
					                                icon: 'success',
					                                text: 'Updated Successfully'
					                            });
					                            $('#btnsubmit').trigger('click');
					                            $("#overlay, #PleaseWait").hide();
					                		}
					                		else{
					                			new swal({
						                            type: 'warning',
						                            title: 'Warning',
						                            icon: 'warning',
						                            text: 'Vendor amount is mandatory'
						                        });
						                        $("#overlay, #PleaseWait").hide();
					                		}
					                		
					                    } else {
					                    }
					                }
					                x.open("GET", "completeVendorJob.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
					                x.send();
			  					}
							});
                	}
                });
                $('#btnvendorprice').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	
                	if(selectedrows.length==0){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	else{
						var assigntype=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'assigntype');
						if(assigntype!='3'){
							new swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            icon: 'warning',
	                            text: 'Document must be assigned to vendor'
	                        });
	                        return false;
						}
                		var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                		var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                		getVendorPrice(bookdocno,docname);
                	}
                });
                $('#vendordiscount').change(function(){
                	if($(this).val()!=''){
                		var vendoramount=$('#vendoramount').val();
                		var vendordiscount=$('#vendordiscount').val();
                		if(vendoramount!=''){
                			vendoramount=parseFloat(vendoramount);
                			vendordiscounnt=parseFloat(vendordiscount);
                			var vendornetamount=vendoramount-vendordiscount;
                			vendornetamount=vendornetamount.toFixed(2);
                			$('#vendornetamount').val(vendornetamount);
                			funRoundAmt(vendordiscounnt,"vendordiscounnt");
                			funRoundAmt(vendornetamount,"vendornetamount");
                		}
                	}
                });
                
                $('#btnvendorpriceupdate').click(function(){
                	var vendoramount=$('#vendoramount').val();
                	var vendordiscount=$('#vendordiscount').val();
                	var vendornetamount=$('#vendornetamount').val();
                	if(vendornetamount=="" || vendornetamount==null || vendornetamount=="undefined" || typeof(vendornetamount)=="undefined"){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Vendor Net Amount is mandatory'
                        });
                        return false;
                	}
                	else{
                		if(parseFloat(vendornetamount)==0.00){
                			new swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            icon: 'warning',
	                            text: 'Vendor Net Amount cannot be zero'
	                        });
	                        return false;
                		}
                		else{
                			var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                			var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                			var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                			Swal.fire({
			  					title: 'Are you sure?',
			  					text: "Do you want to save changes?",
			  					icon: 'warning',
			  					showCancelButton: true,
			  					confirmButtonColor: '#3085d6',
			  					cancelButtonColor: '#d33',
			  					confirmButtonText: 'Yes'
							}).then((result) => {
			  					if (result.value) {
			    					$("#overlay, #PleaseWait").show();
			                        var x = new XMLHttpRequest();
					                x.onreadystatechange = function() {
					                    if (x.readyState == 4 && x.status == 200) {
					                        var items = x.responseText.trim();
					                        if(items=="0"){
					                			new swal({
					                                type: 'success',
					                                title: 'Message',
					                                text: 'Updated Successfully',
					                                icon: 'success'
					                            });
					                            $('#vendoramount,#vendordiscount,#vendornetamount').val('');
					                            $('#btnsubmit').trigger('click');
					                            $('#modalvendorprice').modal('hide');
					                            $("#overlay, #PleaseWait").hide();
					                		}
					                		
					                    } else {
					                    }
					                }
					                x.open("GET", "updateVendorPrice.jsp?bookdocno="+bookdocno+"&docname="+docname+"&vendoramount="+vendoramount+"&vendordiscount="+vendordiscount+"&vendornetamount="+vendornetamount, true);
					                x.send();
			  					}
							});
                			
                		}
                	}
                });
                $('#btnconfirmss').click(function() {
               		var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    if(selectedrows.length==0){
                    	swal.fire({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    else{
                    	for(var i=0;i<selectedrows.length;i++){
                    		var status=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'status');
                    		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                    		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
                    		if(!(status.trim()=="Trip Ended"|| status.trim()=="No show" || status.trim()=="Cancel")){
                    		    new swal({
		                            type: 'warning',
		                            title: 'Warning',
		                            icon: 'warning',
		                            text: 'Trip not ended '+bookdocno+' - '+jobname
		                        });
		                        return false;
                    		}
                    	}
                    	var gridarray=new Array();
                    	for(var i=0;i<selectedrows.length;i++){
                    		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                    		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
							gridarray.push(bookdocno+"::"+jobname);
                    	}
                    	funupdatecn(gridarray);
                    }
                    
                });
                $('#btnjobassign').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    
                    if(selectedrows.length == 0){
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
                
                $('#btnstarttrip').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    
                    if(selectedrows.length == 0){
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }else if (selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                });
                
                $('#btnendtrip').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    
                    if(selectedrows.length == 0){
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    } else if (selectedrows.length>0 && selectedrows.length!=1){
                		new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                    for(var i=0; i<selectedrows.length;i++){
       					funGetStart((parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0)+"-"+$('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job"));
                    }          	 	
                });
                
                
                $('#btnteamselection').click(function() {
                    load();
                });
                $('#btnchangetime').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    selectedrows = selectedrows.sort(function(a, b) {
                        return a - b
                    });
                    if (selectedrows.length == 0) {
                       new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    for (var i = 0; i < selectedrows.length; i++) {
                        var rowIndex = selectedrows[i];
                        var rowData = $("#jqxbookGrid").jqxGrid('getrowdata', rowIndex);
                       // console.log(rowData);  // Logs the row data to the console
                        if(rowData.bstatus<=1|| rowData.multivehassign==1) {
                        	$('#jqxInputdriver2').prop('disabled', true);
                        } else {
                        	$('#jqxInputdriver2').prop('disabled', false);
                        }
                    }
                });

                $('#btnexcel').click(function() {
                    $("#bookdiv").excelexportjs({
						containerid: "bookdiv",
						datatype: 'json',
						dataset: null,
						gridId: "jqxbookGrid",
						columns: getColumns("jqxbookGrid"),
						worksheetName: "Booking Management"
					});
                });
                $('#btnstatus').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    selectedrows = selectedrows.sort(function(a, b) {
                        return a - b
                    });
                    if (selectedrows.length == 0) {
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    getStatus();
                });
                $('#btnstatuspdate').click(function() {
                    if($('#cmbstatus').val() == '') {
                        $('#cmbstatus').closest('.form-group').addClass('has-error').find('span.help-block').removeClass('hidden').text('Please select status');
                        /*swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a status'
                        });*/
                        return false;
                    }
                    else{
                    	$('#cmbstatus').closest('.form-group').removeClass('has-error').find('span.help-block').addClass('hidden').text('');
                    }
                    if($('#remarks').val().length>500){
                    	$('#remarks').closest('.form-group').addClass('has-error').find('span.help-block').removeClass('hidden').text('Max 500 chars allowed');
                    	return false;
                    }
                    else{
                    	$('#remarks').closest('.form-group').removeClass('has-error').find('span.help-block').addClass('hidden').text('');
                    }
                    funUpdateStatus();
                });
                $('#btncommentsend').click(function() {
                    var docno = $('#txtdocno').val();
                    var txtcomment = $('#txtcomment').val();
                    if (docno == "") {
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    if (txtcomment == "") {
                        new swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please type in comment'
                        });
                        return false;
                    }
                    saveComment();
                });
                $('#btncomment').click(function() {
                    getComments();
                    var docno = $('#txtdocno').val();
                    if (docno == "") {
                       new  swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
           	 $('#btnattach').click(function(){   
 	         	funAttachs(event);      
 	         });
           	 
           	$("#modaljobaasign").on('hidden.bs.modal', function(){
       			clearFieldsJobsAssign();
       	  	});
           	 
           });
            
            function funAttachs(event){  
            	 $('#jqxbookGrid').jqxGrid('clearfilters');
            	 var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
            	 selectedrows = selectedrows.sort(function(a,b){return a - b});

            	 if(selectedrows.length==0){
            		 $.messager.alert('Warning','Please select a document!');    
            		return false;
            	}
            	 
            	 var i=0,j=0;
            	 var docno="",branchid="",jobname="";
            	 for (i = 0; i < selectedrows.length; i++) {
            		 if(i==0){  
            			docno= $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
            			branchid= $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
            			jobname= $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
            		 }
            	 }
            			
            	 /* var branchid=document.getElementById("branchid").value; 
       	   		var docno=document.getElementById("empdocno").value;   */
       	   		var url=document.URL;
       			var reurl=url.split("/com/");
       	 		if(docno!="" && docno!="0"){                
       	   			var frmdet="BMG"; 
       	   			var fname="Booking Management";
       	   		 
       	   			
         	var myWindow= window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+branchid+"&jobname="+jobname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			 		
  			
       	 	<%--  var myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+branchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		 --%>	
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
			function funRoundAmt(value,id){
				var res=parseFloat(value).toFixed(window.parent.amtdec.value);
				var res1=(res=='NaN'?"0":res);
				document.getElementById(id).value=res1;
			}
			function getVendorPrice(bookdocno,docname){
				var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        var vendorprice=items;
                        if(vendorprice=="" || vendorprice=="undefined" || typeof(vendorprice)=="undefined"){
                        	vendorprice=0.00;
                        }
                        else{
                        	vendorprice=parseFloat(vendorprice);
                        }
                		$('#vendoramount').val(vendorprice);
                		$('.vendor-job').text(bookdocno+' - '+docname);
                		funRoundAmt(vendorprice,"vendoramount");
                		funRoundAmt(0.0,"vendordiscount");
                		funRoundAmt(vendorprice,"vendornetamount");
                		$("#modalvendorprice").modal();
                		
                    } else {
                    }
                }
                x.open("GET", "getVendorPrice.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                x.send();
			}
			
			function funsavemultiveh(){
				var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
        		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[0],'docno');
                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[0], "rowno");
                var brch = $('#cmbbranch').val();
                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[0], "type");
                var date = $('#uptodate').val();
                var process="2";
        		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[0],'job');
                var detailtrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[0], "tdocno");
				var rows = $("#multivehassigngrid").jqxGrid('getrows');
				
				
            	if(rows.length==0){
                	new	swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please add vehicle and assign the driver'
                        });
                        return false;
                }
            	var dataArray = [];

            	rows.forEach(function(row) {
            		if((row['drvid']==null ||row['drvid']=='' || typeof(row['drvid'])=='undefined')||(row['fleetno']==null ||row['fleetno']=='' || typeof(row['fleetno'])=='undefined')){
            			new	swal({
                            type: 'warning',
                            title: 'Warning',
                            icon: 'warning',
                            text: 'Please select vehicle and the driver'
                        });
                        return false;
            		}
            	    var rowObject = {
            	        drvid: row['drvid'],  // replace 'column1Name' with actual column name
            	        fleetno: row['fleetno'],
            	        addition: row['addition']=="undefined"?0:row['addition'],
            	        status: row['status'],
            	        // add more columns as needed
            	    };
            	    //console.log(row['addition']);
            	    dataArray.push(rowObject);
            	});
            	var pushedData = JSON.stringify(dataArray);
				//console.log("Data - "+pushedData);
				//console.log("Data selected - "+bookdocno);
				//console.log(rowno+"  "+detailtrno);
				
				Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes?", 
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
					}).then((result) => {
  						if (result.value) {
    						$("#overlay, #PleaseWait").show();
    						funsavemulveh(pushedData,bookdocno,rowno,brch,type,date,process,jobname,detailtrno);
  						}});
					}
				
					
			function funsavemulveh(pushedData,bookdocno,rowno,brch,type,date,cmbprocess,jobname,detailtrno){
				//console.log(pushedData); 
				var x = new XMLHttpRequest();
	                x.onreadystatechange = function() {
	                    if (x.readyState == 4 && x.status == 200) {
	                        var items = x.responseText;
	                        if (parseInt(items) >= 1) {
	                            new swal({
	                                type: 'success',
	                                title: 'Message',
	                                text: 'Successfully Saved',
	                                icon: 'success'
	                            });
	                            $("#jqxbookGrid").jqxGrid('clear');
	                            $('#bookdocno').val("");
	                            $('#rowno').val("");
	                            $('#type').val("");
	                            $('#detaildocno').val("");
	                            $("#cmbprocess").val("");
	                            $("#cmbtransferbranch").val("");
	                            $("#driver").val("");
	                            $("#fleetno").val("");
	                            $("#jqxInputUser").val("");
	                            $("#fleetSearchInput").val("");
	                            reload();
	                            $('#modalmultiassign').modal('hide');
	                        } else {
	                           new swal({
	                                type: 'error',
	                                title: 'Message',
	                                text: 'Not Saved',
	                                icon:'error'
	                            });
	                            $('#bookdocno').val("");
	                            $('#rowno').val("");
	                            $('#type').val("");
	                            $('#detaildocno').val("");
	                        }
	                    }
	                }
	                x.open("GET", "savemultivehicleassignment.jsp?bookdocno=" + bookdocno + "&jobname="+ jobname + "&type=" + type + "&rowno=" + rowno + "&detaildocno=" + detailtrno + "&cmbprocess=" + cmbprocess + "&date=" + date + "&brch=" + brch+"&data="+encodeURIComponent(pushedData) , true);
	                x.send();
			}
			
			
			function addAssignment(){
				var driver = $('#assigndrivers').val();
				var drivername = $('#assigndriversname').val();
				var fleet = $('#fleetnos').val();
				var fleetname = $('#fleetnames').val();
				var rows = $("#multivehassigngrid").jqxGrid('getrows');
				
				var assigndata = {drvid:driver,driver:drivername,bookingno:"",jobname:"",fleetno:fleet,vehname:fleetname,regno:"",addition:""};
				if(rows.length==0){
					$("#multivehassigngrid").jqxGrid('addrow', null, assigndata)
                } else {
                	let isDuplicate=rows.some(function(row){
                		return row.drvid==driver || row.fleetno==fleet;
                	});
                	
                	if(!isDuplicate){
                		$("#multivehassigngrid").jqxGrid('addrow', null, assigndata)
                	} else {
                		 new swal({
                             type: 'warning',
                             title: 'Message',
                             text: 'The driver or fleet has already been added!',
                             icom: 'warning'
                         });
                	}
                }
				$('#assigndriver').val("");
				$('#assigndriversname').val("");
				$('#fleetnos').val("");
				$('#fleetnames').val("");
				$('#jqxInputdriver3').val("");
				$('#assignfleetSearchInput').val("");
			}
			
			
            function reload() {
                $("#overlay, #PleaseWait").show();
                var branch = $('#cmbbranch').val();
                var fromdate=$('#fromdate').jqxDateTimeInput('val');
                var todate=$('#todate').jqxDateTimeInput('val');
                $('#bookdiv').load('bookingGrid.jsp?branch=' + branch + '&id=1&fromdate='+fromdate+'&todate='+todate);
            }

            function addGridFilters(filtervalue, datafield) {
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                var filtercondition = 'equal';
                var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
                filtergroup.addfilter(filter_or_operator, filter1);
                //filtergroup.addfilter(filter_or_operator, filter2);
                // add the filters.
                $("#jqxbookGrid").jqxGrid('addfilter', datafield, filtergroup);
                // apply the filters.   
                $("#jqxbookGrid").jqxGrid('applyfilters');
            }

            function getBranch() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        //alert(items);
                        items = items.split('####');

                        var branchIdItems = items[0].split(",");
                        var branchItems = items[1].split(",");
                        var perm = items[2];
                        var optionsbranch;
                        if (perm == 0) {
                            optionsbranch = '<option value="a" selected>All</option>';
                        } else {

                        }
                        for (var i = 0; i < branchItems.length; i++) {
                            optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
                        }
                        $("select#cmbbranch").html(optionsbranch);
                        /* if ($('#hidcmbbranch').val() != null) {
                        	$('#cmbbranch').val($('#hidcmbbranch').val());
                        } */
                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/getBranch.jsp", true);
                x.send();
            }

            function getBrch() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        items = x.responseText;
                        items = items.split('####');
                        brchIdItems = items[0].split(",");
                        brchItems = items[1].split(",");
                        var optionsbrch = '<option value="">--Select--</option>';
                        for (var i = 0; i < brchItems.length; i++) {
                            optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                        }
                        $("select#cmbtransferbranch").html(optionsbrch);

                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "getBranch.jsp", true);
                x.send();
            }

         //edited   
         
         function validatestartkm(){
                 var x = new XMLHttpRequest();
                 var startkm="";
                 var fleet = "";
                 var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes'); 
                 var jobno = "";
                 for(var i = 0;i<selectedrows.length;i++){
                	 if(parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))<2){
                		 $("#overlay, #PleaseWait").hide();
                         $.messager.alert('Warning', 'Please assign the job');
                		 return false;
                	 } else if (parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))>6){
                		 $("#overlay, #PleaseWait").hide();
                		 new swal({
		                    	type: 'error',
		                        title: 'The Trip has ended!'
		                    });
                		 return false;
                	 }
                	 
                	 fleet=$('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "fno");
                	 jobno = (parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0)+"-"+$('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
                 }
                 if(fleet==""){
                	 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'Please assign first');
                     return false;
                 }
                 x.onreadystatechange = function() {
                     if (x.readyState == 4 && x.status == 200) {
                         items = x.responseText;
                         startkm = items.split("::")[0];
                         status = items.split("::")[3];
                         if(parseInt(status)>=6){
                        	 $("#overlay, #PleaseWait").hide();
                             $.messager.alert('Warning', "The trip has either begun or ended!");
                             return false;
                         }
                         if(parseInt(startkm)<=parseInt($('#startkm').val())){
                         	funStartTrip()
                         }else{
                        	 $("#overlay, #PleaseWait").hide();
                             $.messager.alert('Warning', "Begin at or above recent trip's finish(" +startkm+")");
                             return false;
                         }
                     } else {

                     }
                 }
                 x.open("GET", "getmaxdata.jsp?fleet="+fleet+"&jobno="+jobno, true);
                 x.send();

         }
         
         
         
            function funStartTrip(){
            	 var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes'); 
        	 	 var startkm = $('#startkm').val();
        	 	 var date = $('#tripdates').jqxDateTimeInput('val')
        	 	 var time = $('#triptimes').val();
        	 	 var remark = $('#remarkstart').val();
        	 	 var userid = "<%= session.getAttribute("USERID").toString()%>";
                 if(startkm==''){
                	 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'Please enter start kilometer');
                     return false;
                 }
                 if(date==''){
                	 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'Please enter start date');
                     return false;
                 }
                 if(time==''){
                	 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'Please enter start time');
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
   					if (result.value) {
     					$("#overlay, #PleaseWait").show();
     					var i = 0;
                        var regno = "",
                            fleet = "",
	                        vehname= "",
                         	dname="",
                         	slocation="",
                         	elocation="",
                         	driverid="",
                         	jobdoc="",
                         	jobtype="",
                         	tarifdoc="",
                         	tarifdetdoc="",
                         	jobno="",
                         	bookdocno="",
                         	branchid = "",
                         	jobname="";
                        for (i = 0; i < selectedrows.length; i++) {

                            if (i == 0) {
                               	regno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "regdetails");
                                fleet = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "fno");
                                vehname = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "fname");
                                dname = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "drivername");
                                slocation = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "pickuplocation");
                                elocation = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "dropofflocation");
                               // driverid = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "");
                                jobdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                jobtype = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                tarifdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdocno");
                                tarifdetdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdetaildocno");
                                bookdocno = parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0;
                                jobname = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
                                jobno = bookdocno+"-"+jobname;
                                branchid =  $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
                            } else {
                            	regno +="," +$('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                            	fleet +="," +$('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "fno");
                            	vehname +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "fname");
                                dname +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "drivername");
                                slocation +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "pickuplocation");
                                elocation +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "dropofflocation");
                                //driverid +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "");
                                jobdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                jobtype +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                tarifdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdocno");
                                tarifdetdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdetaildocno");
                                bookdocno +=","+ (parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0); //tdocno
                                jobname +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
                                jobno +=","+ bookdocno+"-"+jobname;
                                branchid += ","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
                            }
   					}
                    
                    saveStartTrip(regno, fleet, vehname, dname, slocation, elocation, jobtype, tarifdoc, tarifdetdoc, bookdocno, jobname, jobno, startkm, date, time, remark, userid, branchid, jobdoc);
 				}
 				});
                 
            }
         
         
         function saveStartTrip(regno, fleet, vehname, dname ,slocation, elocation, jobtype, tarifdoc, tarifdetdoc, bookdocno, jobname, jobno, startkm, date, time, remark, userid, branchid, jobdoc){
        	// alert("reg_no=" + regno + "&fleet=" + fleet + "&vehname=" + vehname + "&dname=" + dname + "&slocation=" + slocation + "&elocation=" + elocation + "&jobtype=" + jobtype + "&tarifdoc=" + tarifdoc + "&tarifdetdoc=" + tarifdetdoc + "&jobno=" + jobno + "&startkm=" + startkm + "&date=" + date + "&time=" + time +"&remark=" + remark +"&userid=" + userid +"&branch=" + branchid + "&jobdoc="+ jobdoc)
        	 var x = new XMLHttpRequest();
               x.onreadystatechange = function() {
                   if (x.readyState == 4 && x.status == 200) {
                       var items = x.responseText;
                       items=items.split("::")[0];
                       if (parseInt(items) >= 1) {
                          new swal({
                               type: 'success',
                               title: 'Message',
                               text: 'Successfully Saved'
                           });
                           $('#startkm').val("");
                           $('#tripdates').val("");
                           $('#triptimes').val("");
                           $('#remarkstart').val("");
                           reload();
                           $('#modalstarttrip').modal('hide');
                       } else {
                         new  swal({
                               type: 'success',
                               title: 'Message',
                               text: 'Not Saved'
                           });
                       }
                   }
               }
               x.open("GET", "startSave.jsp?reg_no=" + regno + "&fleet=" + fleet + "&vehname=" + vehname + "&dname=" + dname + "&startlocation=" + slocation + "&endlocation=" + elocation + "&jobtype=" + jobtype + "&tarifdoc=" + tarifdoc + "&tarifdetdoc=" + tarifdetdoc + "&jobno=" + jobno + "&startkm=" + startkm + "&startdate=" + date + "&starttime=" + time +"&remark=" + remark +"&userid=" + userid +"&branch=" + branchid + "&jobdoc="+ jobdoc, true);
               x.send();
           }
           
         
         
         //endTrip 
         function validateendkm(){
        	 var endkm = parseInt($('#endkm').val());
        	 var endd =  new Date(parseInt($('#tripdatee').val().split(".")[2]),parseInt($('#tripdatee').val().split(".")[1],10)-1,parseInt($('#tripdatee').val().split(".")[0]));
        	 var endt =  $('#triptimee').val();
        	 var startk = $('#txtstartkm').val().split("::")[0];
        	 var startd = new Date(parseInt($('#txtstartkm').val().split("::")[1].split(".")[2]),parseInt($('#txtstartkm').val().split("::")[1].split(".")[1],10)-1,parseInt($('#txtstartkm').val().split("::")[1].split(".")[0]));
        	 var startt = $('#txtstartkm').val().split("::")[2];
        	 var startstatus = parseInt($('#txtstartkm').val().split("::")[3]);
        	 var sh = parseInt(startt.split(':')[0]);
        	 var eh = parseInt(endt.split(':')[0]);
        	 var sm = parseInt(startt.split(':')[1]);
        	 var em = parseInt(endt.split(':')[1]);
         	 if(startstatus!==6){
         		$("#overlay, #PleaseWait").hide();
                $.messager.alert('Warning', 'Trip has not been started!');
                return false;
         	 } else if(startstatus===7){
         		$("#overlay, #PleaseWait").hide();
                $.messager.alert('Warning', 'Trip has already been ended!');
                return false;
         	 }
        	 if(endkm==''){
            	 $("#overlay, #PleaseWait").hide();
                 $.messager.alert('Warning', 'Please enter end kilometer');
                 return false;
             }

            	 if(endkm<parseInt(startk)){
                	 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'End km cannot be less than Start km('+startk+')');
                     return false;
                 }
            	 
            	 if(endd<startd){
            		 $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Warning', 'End date cannot be less than Start date('+startd+')');
                     return false;
            	 }else if (endd>startd){
            		 
            	 } else {
            		 if(eh<sh){
            			 $("#overlay, #PleaseWait").hide();
                         $.messager.alert('Warning', 'End time cannot be less than Start time('+sh+')');
                         return false;
            		 } else if (eh==sh){
            			 if(em<sm){
            				 $("#overlay, #PleaseWait").hide();
                             $.messager.alert('Warning', 'End time cannot be less than Start time('+sh+')');
                             return false;
            			 }
            		 }
            	 }
           
             funEndTrip();
         }
         
         
         function funGetStart(jobno) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        $('#txtstartkm').val(items);
                    } else {}
                }
                x.open("GET", 'getStartData.jsp?jobno='+jobno);
                x.send();
            }
         
         
         
         
         function funEndTrip(){
        	 var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes'); 
        	
    	 	 var endkm = parseInt($('#endkm').val());
			
    	 	 var date = $('#tripdatee').val();
    	 	 var time = $('#triptimee').val();
    	 	 var remark = $('#remarkend').val();
    	 	 var userid = "<%= session.getAttribute("USERID").toString()%>";
 			             
             if(date==''){
            	 $("#overlay, #PleaseWait").hide();
                 $.messager.alert('Warning', 'Please enter end date');
                 return false;
             }
             if(time==''){
            	 $("#overlay, #PleaseWait").hide();
                 $.messager.alert('Warning', 'Please enter end time');
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
					if (result.value) {
 					$("#overlay, #PleaseWait").show();
 					var i = 0;
                    var elocation="",
                     	jobdoc="",
                     	jobtype="",
                     	tarifdoc="",
                     	tarifdetdoc="",
                     	jobno="",
                     	bookdocno="",
                     	jobname="",
                     	startdate="",
                     	startkm="",
                     	rowno="",
                     	branchid="",
                     	starttime="";
                    for (i = 0; i < selectedrows.length; i++) {

                        if (i == 0) {
                            elocation = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "dropofflocation");
                            jobdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                            jobtype = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                            tarifdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdocno");
                            tarifdetdoc = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdetaildocno");
                            bookdocno = parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0;
                            jobname = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
                            jobno = bookdocno+"-"+jobname;
                            branchid =  $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
                        } else {
                            elocation +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "dropofflocation");
                            jobdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                            jobtype +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                            tarifdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdocno");
                            tarifdetdoc +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tarifdetaildocno");
                            bookdocno +=","+ parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bookingno").slice(-6))+0;
                            jobname +=","+ $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "job");
                            jobno +=","+ bookdocno+"-"+jobname;
                            branchid += "," +  $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
                        }
					}
                    
                saveEndTrip(elocation, jobtype, tarifdoc, tarifdetdoc, bookdocno, jobname, jobno, endkm, date, time, remark, userid, branchid, jobdoc);
				}
				});
             
        }
     
     function saveEndTrip(elocation, jobtype, tarifdoc, tarifdetdoc, bookdocno, jobname, jobno, endkm, date, time, remark, userid, branchid, jobdoc){
    	 var x = new XMLHttpRequest();
           x.onreadystatechange = function() {
               if (x.readyState == 4 && x.status == 200) {
                   var items = x.responseText;
                   items=items.split("::")[0];
                   if (parseInt(items)>= 1) {
                     new swal({
                           type: 'success',
                           title: 'Message',
                           text: 'Successfully Saved'
                       });
                       $('#endkm').val("");
                       $('#tripdatee').val("");
                       $('#triptimee').val("");
                       $('#remarkend').val("");
                       reload();
                       $('#modalendtrip').modal('hide');
                   } else {
                     new  swal({
                           type: 'success',
                           title: 'Message',
                           text: 'Not Saved'
                       });
                   }
               }
           }
           x.open("GET", "endSave.jsp?&city=" + elocation + "&jobtype=" + jobtype + "&tarifdoc=" + tarifdoc + "&tarifdetdoc=" + tarifdetdoc + "&jobno=" + jobno + "&endkm=" + endkm + "&enddate=" + date + "&endtime=" + time +"&remark=" + remark +"&userid=" + userid +"&branch=" + branchid + "&jobdoc="+ jobdoc , true);
           x.send();
       }
         
         
         
         
         
         
         
         
          //end edited
            
            function funUpdateStatus() {
                var statusid = $('#cmbstatus').val();
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');                
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Warning', 'Please select documents.');
                    return false;
                }
                if (statusid == '') {
                    //$.messager.alert('Message', 'Select Status', 'warning');
                    Swal.fire({
						icon: 'error',
					  	title: 'Select Status'
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
  					if (result.value) {
    					$("#overlay, #PleaseWait").show();
                        var i = 0;
                        var temprow = "";
                        var j = 0;
                        for (i = 0; i < selectedrows.length; i++) {
                            if (i == 0) {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = rowno;
                            } else {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = temprow + "," + rowno;
                            }
                            temptrno3 = temprow + ",";
                            j++;
                        }
                        $('#rowno').val(temptrno3);
                        savestatus($('#rowno').val());
  					}
				})
               
            }

            function savestatus(rowno) {
                var statusid = $('#cmbstatus').val();
                var remarks = $('#remarks').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items == "0") {
                           new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Status Updated',
                                icon: 'success'
                            });
                            $('#rowno').val("");
                            $('#remarks').val("");
                            $('#cmbstatus').val("");
                            reload();
                            $('#modalstatusupdate').modal('hide');
                        } else {
                            new swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated',
                                icon: 'error'
                            });
                            $('#rowno').val("");
                        }

                    } else {}
                }
                x.open("GET", "statUpdate.jsp?statusid=" + statusid + "&rowno=" + rowno + "&remarks=" + remarks, true);
                x.send();
            }

            function getStatus() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        items = items.split('####');

                        var srno = items[0].split(",");
                        var status = items[1].split(",");
                        var optionsbranch = '<option value="" selected>-- Select -- </option>';
                        for (var i = 0; i < status.length; i++) {
                            optionsbranch += '<option value="' + srno[i].trim() + '">' + status[i] + '</option>';
                        }
                        $("select#cmbstatus").html(optionsbranch);

                    } else {}
                }
                x.open("GET", "getStatuses.jsp", true);
                x.send();
            }

            function funSave() {
                var rows = $("#jqxbookGrid").jqxGrid('getrows');
                var process = $("#cmbprocess").val();
                var transferbranch = $("#cmbtransferbranch").val();
                var driver = $("#driver").val();
                var vendorid = $("#vendorid").val();
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                if (process == '') {
                    //$.messager.alert('Message', 'Select Process', 'warning');
                   new swal({
                    	type: 'error',
                        title: 'Please select process'
                    });
                    return 0;
                }
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    //$.messager.alert('Warning', 'Please select documents.');
                   new swal({
                    	type: 'error',
                        title: 'Please select documents'
                    });
                    return false;
                }
                if (process == "1") {
                    if (transferbranch == '') {
                        //$.messager.alert('Message', 'Select Transfer Branch', 'warning');
                       new swal({
	                    	type: 'error',
	                        title: 'Please select Transfer branch'
	                    });
                        return false;
                    }
                }
               
                
                if(process=="2"){
                	for(var i=0;i<selectedrows.length;i++){
                		var tarifdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'tarifdocno');
                		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
                		if((tarifdocno=="" || tarifdocno=="undefined" || tarifdocno=="0" || tarifdocno==null) && isTariffHiddenbook==false){
                			new swal({
                                type: 'error',
                                title: 'Tarif not configured',
                                text: 'Please set tarif of '+bookdocno+' - '+jobname,
                                icon: 'error'
                            });
                            return false;
                		}
                	}
                }
                if (process == "2") {
                    if (driver == '') {
                        //$.messager.alert('Message', 'Select Driver', 'warning');
                       new swal({
	                    	type: 'warning',
	                        title: 'Please select driver',
	                        icon: 'warning'
	                    });
                        return false;
                    }
                } 
                
                if(process == "3"){
                	if(vendorid == ''){
                		 new swal({
 	                    	type: 'warning',
 	                        title: 'Please select vendor',
 	                        icon: 'warning'
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
  						if (result.value) {
    						$("#overlay, #PleaseWait").show();
	
	                        var i = 0;
	                        var tempbook = "",
	                            tempdetail = "",
	                            temprow = "",
	                            temptype = "";
	                        var j = 0;
	                        for (i = 0; i < selectedrows.length; i++) {
	                        	console.log(parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus")));
									 if(parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))>2 && !(parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))==4 || parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))==8 || parseInt($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus"))==5)){
										new swal({
						                    	type: 'error',
						                        title: 'The Trip has either been started or ended, cannot assign jobs!',
						                        icon : 'error'
						                    });
										 $("#overlay, #PleaseWait").hide();
					                        return false;
									} 
	                            if (i == 0) {
	                                var booktrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
	                                tempbook = booktrno;
	                                var detailtrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
	                                tempdetail = detailtrno;
	                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
	                                temprow = rowno;
	                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
	                                temptype = type;
	                            } else {
	                                var booktrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
	                                tempbook = tempbook + "," + booktrno;
	                                var detailtrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
	                                tempdetail = tempdetail + "," + detailtrno;
	                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
	                                temprow = temprow + "," + rowno;
	                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
	                                temptype = temptype + "," + type;
	                            }
	                            temptrno1 = tempbook + ",";
	                            temptrno2 = tempdetail + ",";
	                            temptrno3 = temprow + ",";
	                            temptrno4 = temptype + ",";
	                            j++;
	
	                        }
	                        $('#bookdocno').val(temptrno1);
	                        $('#detaildocno').val(temptrno2);
	                        $('#rowno').val(temptrno3);
	                        $('#type').val(temptrno4);
	                        savegriddata($('#rowno').val(), $('#bookdocno').val(), $('#detaildocno').val(), $('#type').val());
  						}
				});
                
            }

            function savegriddata(rowno, bookdoc, detaildoc, type) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        if (parseInt(items) >= 1) {
                            new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved',
                                icon: 'success'
                            });
                            $("#jqxbookGrid").jqxGrid('clear');
                            $('#bookdocno').val("");
                            $('#rowno').val("");
                            $('#type').val("");
                            $('#detaildocno').val("");
                            $("#cmbprocess").val("");
                            $("#cmbtransferbranch").val("");
                            $("#driver").val("");
                            $("#fleetno").val("");
                            $("#jqxInputUser").val("");
                            $("#fleetSearchInput").val("");
                            reload();
                            $('#modaljobaasign').modal('hide');
                        } else {
                          new  swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Not Saved'
                            });
                            $('#bookdocno').val("");
                            $('#rowno').val("");
                            $('#type').val("");
                            $('#detaildocno').val("");
                        }
                    }
                }
                x.open("GET", "saveData.jsp?bookdocno=" + bookdoc + "&type=" + type + "&rowno=" + rowno + "&detaildocno=" + detaildoc + "&cmbprocess=" + $("#cmbprocess").val() + "&cmbtransferbranch=" + $("#cmbtransferbranch").val() + "&hiddriver=" + $("#driver").val() + "&fleetno=" + $("#fleetno").val() + "&date=" + $('#uptodate').jqxDateTimeInput('val') + "&brch=" + $('#cmbbranch').val() + "&vendor="+$('#vendorid').val(), true);
                x.send();
            }
            
            function getTariffConfigBook(){
        		var x = new XMLHttpRequest();
        		x.onreadystatechange = function() {
        			if (x.readyState == 4 && x.status == 200) {
        				 var data = JSON.parse(x.responseText);
        				 if(data==1){
        					isTariffHiddenbook=true;
        				 } else {
        					 isTariffHiddenbook=false;
        				 }
        				 
        			} else {
        			}
        		}
        		x.open("GET",'tariffhideconfig.jsp', true);
        		x.send();
        	}

            function funGetCountData() {
            	var fromdate=$('#fromdate').jqxDateTimeInput('val');
            	var todate=$('#todate').jqxDateTimeInput('val');
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split("::");
                        $('.badge-confirm').text(items[0]);
                        $('.badge-jbassign').text(items[1]);
                        $('.badge-chngetime').text(items[2]);
                    } else {}
                }
                x.open("GET", 'getCountData.jsp?branch='+$('#cmbbranch').val()+'&fromdate='+fromdate+'&todate='+todate, true);
                x.send();
            }

            function saveComment() {
                var comment = $('#txtcomment').val();
                var docno = $('#txtdocno').val();
            	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
            	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
            	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
            	
                $('#hidcomments').val($('#txtcomment').val());
                if (($(hidcomments).val()).includes('$')) {
                    $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));
                };
                if (($(hidcomments).val()).includes('%')) {
                    $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));
                };
                if (($(hidcomments).val()).includes('^')) {
                    $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));
                };
                if (($(hidcomments).val()).includes('`')) {
                    $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));
                };
                if (($(hidcomments).val()).includes('~')) {
                    $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));
                };
                if ($(hidcomments).val().indexOf('\'') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));
                };
                if (($(hidcomments).val()).includes(',')) {
                    $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));
                }
                if ($(hidcomments).val().indexOf('"') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));
                };
                if (($(hidcomments).val()).match(/\\/g)) {
                    $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));
                };

                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        $('#txtcomment').val('');
                        getComments();
                    } else {}
                }
                x.open("GET", "saveComment.jsp?docname="+docname+"&bookdocno="+bookdocno+"&comment=" + encodeURIComponent($('#hidcomments').val()) + "&docno=" + docno, true);
                x.send();
            }

            function getComments() {
                var docno = $('#txtdocno').val();
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
            	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
            	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        var str = '';
                        $('.comments-container').empty();
                        if (items != '') {
                            for (var i = 0; i < items.length; i++) {
                                str += '<div class="comment"><div class="msg"><p>' + items[i].split("::")[0] + '</p></div><div class="msg-details"><p>' + items[i].split("::")[1] + ' - ' + items[i].split("::")[2] + '</p></div></div>';
                            }
                            $('.comments-container').html($.parseHTML(str));
                        } else {}
                    } else {}
                }
                x.open("GET", "getComments.jsp?docname="+docname+"&bookdocno="+bookdocno+"&docno=" + docno, true);
                x.send();
            }

            function funSaveTask() {
                var reftype = document.getElementById("reftype").value;
                var refno = document.getElementById("refno").value;
                var sdate = $('#date').jqxDateTimeInput('val');
                var stime = document.getElementById("vtime").value;
                var user = document.getElementById("jqxUser").value;
                var hiduser = document.getElementById("tuser").value;
                var desc = document.getElementById("desc").value;
                var userid = "<%= session.getAttribute("USERID").toString()%>";
                if (refno == "") {
                    //$.messager.alert('Message', 'Enter Ref. No.', 'warning');
                   new swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Ref. No'
                    });
                    document.getElementById('refno').focus();
                    return false;
                }
                if (stime == "") {
                    //$.messager.alert('Message', 'Enter time', 'warning');
                    new swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter time'
                    });
                    document.getElementById('stime').focus();
                    return false;
                }
                if (user == "") {
                    //$.messager.alert('Message', 'Enter Assigned User', 'warning');
                    new swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Assigned User'
                    });
                    document.getElementById('user').focus();
                    return false;
                }
                if (desc == "") {
                    //$.messager.alert('Message', 'Enter Description', 'warning');
                   new swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Description'
                    });
                    document.getElementById('desc').focus();
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
  					if (result.value) {
    					saveDatasss(reftype, refno, sdate, stime, user, desc, userid, hiduser);
  					}
				});
                
            }

            function saveDatasss(reftype, refno, sdate, stime, user, desc, userid, hiduser) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var msg = x.responseText.trim().split(',');
                        // alert(msg);
                        if (msg == "1") {
                            document.getElementById("refno").value = "";
                            document.getElementById("vtime").value = "";
                            document.getElementById("jqxUser").value = "";
                            document.getElementById("tuser").value = "";
                            document.getElementById("desc").value = "";
                            new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved'
                            });

                        } else {
                            new swal({
                                type: 'error',
                                title: 'Message',
                                text: 'Not Saved'
                            });
                        }
                    }
                }
                x.open("GET", "taskCreate.jsp?reftype=" + reftype + "&refno=" + refno + "&sdate=" + sdate + "&stime=" + stime + "&user=" + user + "&desc=" + desc + "&userid=" + userid + "&hiduser=" + hiduser, true);
                x.send();
            }

            function funpendingUpdate() {
                var docno = $('#txtpendocno').val();
                var crtuser = $('#txtcrtuser').val();
                var status = $('#assgntask').val();
                var oldstat = document.getElementById("txtoldstatus").value;
                var asgnuser = $('#puser').val();
                var oldassuser = document.getElementById("txtasgnuser").value;
                var userid = $('#puser').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items > 0) {
                            document.getElementById("txtcrtuser").value = "";
                            document.getElementById("puser").value = "";
                            document.getElementById("txtpendocno").value = "";
                            document.getElementById("jqxInputUsers").value = "";
                            $('#remarks').val('');
                            new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Status Updated'
                            });
                            funGetCountData();
                            reload();
                        } else if (items == -888) {
                            new swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Task is not completed'
                            });
                        } else {
                            new swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated'
                            });
                        }
                    } else {}
                }
                x.open("GET", "penStatUpdate.jsp?userid=" + userid + "&docno=" + docno + "&status=" + status + "&asgnuser=" + asgnuser + "&oldassuser=" + oldassuser + "&oldstatus=" + oldstat + "&crtuser=" + crtuser + "&remarks=" + $('#remarks').val(), true);
                x.send();
            }

            function funstatusval(crtuserid) {
                // var crtuserid=document.getElementById("txtcrtuser").value;  
                var sesuserid = "<%=session.getAttribute("USERID").toString()%>";
                var optionref = "";
                if (crtuserid == sesuserid) {
                    optionref += '<option value="Assigned">Assign</option>';
                    optionref += '<option value="Accepted">Accepted</option>';
                    optionref += '<option value="Completed">Completed</option>';
                    optionref += '<option value="Close">Close</option>';
                    $("select#assgntask").html(optionref);
                } else {
                    optionref += '<option value="Assigned">Assign</option>';
                    optionref += '<option value="Accepted">Accepted</option>';
                    optionref += '<option value="Completed">Completed</option>';
                    $("select#assgntask").html(optionref);
                }
            }

            function funCTSave() {
                var remarks = $('#cgdesc').val();
                var rows = $("#jqxbookGrid").jqxGrid('getrows');
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    //$.messager.alert('Warning', 'Please select documents.');
                    new swal({
                    	type: 'error',
                        title: 'Warning',
                        text: 'Please select documents.'
                    });
                    return false;
                }
                if (remarks == "") {
                    //$.messager.alert('Message', 'Please Enter Remarks', 'warning');
                    new swal({
                    	type: 'error',
                        title: 'Warning',
                        text: 'Please Enter Remarks'
                    });
                    document.getElementById('cgremarks').focus();
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
  					if (result.value) {
    					$("#overlay, #PleaseWait").show();

                        var i = 0;
                        var temprow = "",
                            tempbk = "",
                            tempdet = "",
                            temptype = "";
                        let ishidedriver=false;
                        var j = 0;
                        for (i = 0; i < selectedrows.length; i++) {
							if($('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "bstatus")<=1 || $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "multivehassign")==1){
								ishidedriver=true;
							}
                            if (i == 0) {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = rowno;
                                var detno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                tempdet = detno;
                                var bkno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                                tempbk = bkno;
                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                temptype = type;
                            } else {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = temprow + "," + rowno;
                                var detno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                tempdet = tempdet + "," + detno;
                                var bkno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                                tempbk = tempbk + "," + bkno;
                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                temptype = temptype + "," + type;
                            }
                            temptrno3 = temprow + ",";
                            temptrno4 = tempdet + ",";
                            temptrno5 = temptype + ",";
                            temptrno6 = tempbk + ",";
                            j++;

                        }
                        $('#rowno').val(temptrno3);
                        $('#bookdocno').val(temptrno6);
                        $('#detaildocno').val(temptrno4);
                        $('#type').val(temptrno5);
                        savecg($('#bookdocno').val(), $('#detaildocno').val(), $('#type').val(), $('#rowno').val(), ishidedriver);
  					}
				});
                
            }

            function savecg(bdocno, ddocno, type, rowno, ishidedriver) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items > 0) {
                            new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved'
                            });
                            $('#rowno').val("");
                            $('#bookdocno').val("");
                            $('#detaildocno').val("");
                            $('#type').val("");
                            $('#cgdesc').val("");
                            $('#jqxInputdriver2').val("");
                            $('#cgdriver').val("");
                            $('#cgdesc').val('');
                            reload();
                            $('#modalchangetime').modal('hide');
                        } else {
                            new swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Saved'
                            });
                            $('#rowno').val("");
                            $('#bookdocno').val("");
                            $('#detaildocno').val("");
                            $('#type').val("");
                        }

                    } else {}
                }
                x.open("GET", "saveCT.jsp?bookdocno=" + bdocno + "&detaildocno=" + ddocno + "&rowss=" + rowno + "&type=" + type + "&cgdate=" + $('#cgdate').val().replace(/ /g, "%20") + "&cgtime=" + $('#cgtime').val() + "&cgdesc=" + $('#cgdesc').val() + "&cgdriver=" + $('#cgdriver').val()+"&ishidedriver="+ishidedriver, true);
                x.send();
            }

            function load() {
                var userid = "<%=session.getAttribute("USERID").toString()%>";
                $('#pnddiv').load('pendingtaskGrid.jsp?userid=' + userid);
            }
            
            function clearFieldsJobsAssign(){
            	$('#cmbprocess').val('');
            	$('#driver').val('');
            	$('#jqxInputUser').val('');
            	$('#fleetno').val('');
            	$('#fleetSearchInput').val('');
            	$('#vendorid').val('');
            	$('#vendorSearchInput').val('');
            	$('#cmbtransferbranch').val('');
            }

            function funupdatecn(gridarray) {
            	Swal.fire({
  					title: 'Are you sure?',
  					text: "Do you want to confirm?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					updatConfrm(gridarray);
  					}
				})
            }

            function updatConfrm(gridarray) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        //alert(items);       
                        if (parseInt(items) > 0) {
                            new swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Confirmed'
                            });
                            reload();
                        } else {
                            new swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Confirmed'
                            });
                        }
                    } else {}
                }
                x.open("GET", "SaveCofrm.jsp?gridarray="+gridarray, true);
                x.send();
            }
            
            function getDriverFleet(driverid){
            	var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if(items!=""){
                        	$('#fleetSearchInput').jqxInput('val', {label: items.split("::")[1], value: items.split("::")[0]});
                        	$('#fleetno').val(items.split("::")[0]);
                        }
                        else{
                        	$('#fleetSearchInput').jqxInput('val', '');
                        }
                    } else {}
                }
                x.open("GET", "getDriverFleet.jsp?driverid="+driverid, true);
                x.send();
            }
            
            function getVendor(){
            	var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if(items!=""){
                        	$('#vendorSearchInput').jqxInput('val', {label: items.split("::")[1], value: items.split("::")[0]});
                        	$('#vendorid').val(items.split("::")[0]);
                        }
                        else{
                        	$('#vendorSearchInput').jqxInput('val', '');
                        }
                    } else {}
                }
                x.open("GET", "vendorsearchlisk.jsp", true);
                x.send();
            }
            
            function funOpenBooking(){    
            	
            	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
            	
            	if(selectedrows.length==0){
            		new swal({
                        type: 'warning',
                        title: 'Warning',
                        icon: 'warning',
                        text: 'Please select any valid documents'
                    });
                    return false;
            	}
            	else if(selectedrows.length>0 && selectedrows.length!=1){
            		new swal({
                        type: 'warning',
                        title: 'Warning',
                        icon: 'warning',
                        text: 'Can select only one document at a time'
                    });
                    return false;
            	}
        		
            	var docno=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'docno');
            	var brhid=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'brhid');

        		  
            	  var path1="com/limousine/limobooking/limoBooking.jsp";  
            	  var name="Limousine Booking";
            	  var url=document.URL;
            	  var reurl=url.split("com/");    
            	//  var brhid = $("#cmbbranch").val();
            	  
            	  window.parent.formName.value = "Limousine Booking"; 
            	  window.parent.formCode.value = "LBK";
            	  window.parent.branchid.value = brhid;  
            	  var detName = "Limousine Booking";  
            	  var mode = "view";
            	  var path= path1+"?detailmode=1&tempdocno="+docno;          
            	  //console.log("path==="+path)
            	  top.addTab( detName,reurl[0]+""+path);  
            	  $("#overlay, #PleaseWait").hide();
                }
            
            function copySelectedRow() {
                var grid = $("#jqxbookGrid");
                var selectedRowIndexes = grid.jqxGrid('getselectedrowindexes');

                if (selectedRowIndexes.length === 0) {
                    alert("No row selected!");
                    return;
                }

                let copiedText = "";

                selectedRowIndexes.forEach(index => {
                    var rowData = grid.jqxGrid('getrowdata', index);

                    // Define the columns you want to copy
                    var columnsToCopy = ["bookingno", "client", "allguest", "pax", "pickupdate", "pickuptime", "pickuplocation", "pickupaddress", "dropofflocation",
                    	"dropoffaddress", "refno", "vesselno", "vesselname", "flightdetails", "hoteldetails", "groupname", "babyseat", "description"]; // Replace with your actual column names

                    var columnsToCopy = [
                        { datafield: "bookingno", text: "Booking No." },
                        { datafield: "client", text: "Client" },
                        { datafield: "allguest", text: "Guest" },
                        { datafield: "pax", text: "PAX" }, 
                        { datafield: "pickupdate", text: "Pickup Date" }, 
                        { datafield: "pickuptime", text: "Pickup Time" }, 
                        { datafield: "pickuplocation", text: "Pickup Location" }, 
                        { datafield: "pickupaddress", text: "Pickup Address" }, 
                        { datafield: "dropofflocation", text: "Dropoff Location" }, 
                        { datafield: "dropoffaddress", text: "Dropoff Address" }, 
                        { datafield: "refno", text: "Ref No." }, 
                        { datafield: "vesselno", text: "V. No." }, 
                        { datafield: "vesselname", text: "V. Name" }, 
                        { datafield: "flightdetails", text: "Flight Details" }, 
                        { datafield: "hoteldetails", text: "Hotel Details" }, 
                        { datafield: "groupname", text: "Group" }, 
                        { datafield: "babyseat", text: "Other Service" }, 
                        { datafield: "description", text: "Description" }, 
                    ];
                    
                    columnsToCopy.forEach(col => {
                    	if(col.datafield=="pickupdate"){
	                        copiedText += col.text +" : "+new Date(rowData[col.datafield]).toDateString()+" \n"; 
                    	} else if (col.datafield=="pickuptime"){
                    		copiedText += col.text +" : "+new Date(rowData[col.datafield]).toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit", hour12: true })+" \n"; 
                    	} else if (col.datafield=="babyseat"){
                    		copiedText += col.text +" : "+(rowData[col.datafield]==1?'Baby Seat':'N/A')+" \n";
                    	} else if(col.datafield=="flightdetails" || col.datafield=="hoteldetails"){
                    		if(!(rowData[col.datafield].trim()==''||rowData[col.datafield].trim()==null)){
                    			 copiedText += col.text +" : "+rowData[col.datafield]+" \n"; 
                    		}
                    	} else {
                    	
    	                    copiedText += col.text +" : "+rowData[col.datafield]+" \n"; 
                    	}
                    });

                    copiedText += "\n"; // Separate rows with a new line
                });
                // Copy to clipboard
                $('#copiedText').val(copiedText);
            }
            
            function copytoclipboard(){
            	 var tempTextArea = document.createElement("textarea");
                 tempTextArea.value = $('#copiedText').val();
                 document.body.appendChild(tempTextArea);
                 tempTextArea.select();
                 document.execCommand("copy");
                 document.body.removeChild(tempTextArea);
                 
                 Swal.fire({
                	  icon: "success",
                	  title: "Text Copied To ClipBoard",
                	  showConfirmButton: false,
                	  timer: 1000
                	});
            }
            
        </script>
    </form>
</body>

</html>