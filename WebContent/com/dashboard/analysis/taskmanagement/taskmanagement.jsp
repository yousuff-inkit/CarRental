<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Task Management</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">  
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>              
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />
<link href="formStyles.css" rel="stylesheet" />  
</head>       
<body>         
<form id="frmTaskManagement" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
     <div class="todatepanel custompanel">
	      <table>
		      <tr> 
		          <td align="left"><input type='checkbox' id="fromdtchk" onclick="$(this).attr('value', this.checked ? 1 : 0);" value='<s:property value="fromdtchk" />'/></td>   
			      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;From Date &nbsp;&nbsp;</label></td>    
			      <td align="left"><div id='fromdate'></div></td>
			      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;To Date &nbsp;&nbsp;</label></td>      
			      <td align="left"><div id='todate'></div></td>
		      </tr>                                          
		 </table>          
       </div>  
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
       	    <button type="button" class="btn btn-default" id="btnschedule"  data-toggle="tooltip" title="Schedule" data-placement="bottom"><i class="fa fa-calendar" aria-hidden="true"></i></button>      
        </div> 
        <div class="warningpanel custompanel">  
          <div class="btn-group" role="group">        
          	<button type="button" class="btn btn-default" id="btnAssigned" data-toggle="tooltip" title="Assigned" data-placement="bottom" data-filtervalue="Assigned" data-datafield="status"><i class="fa fa-outdent " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-Assigned"></span>  
          </div> 
          <div class="btn-group" role="group">        
          	<button type="button" class="btn btn-default" id="btnAccepted" data-toggle="tooltip" title="Accepted" data-placement="bottom" data-filtervalue="Accepted" data-datafield="status"><i class="fa fa-check-circle-o " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-Accepted"></span>  
          </div> 
          <div class="btn-group" role="group">        
          	<button type="button" class="btn btn-default" id="btnCompleted" data-toggle="tooltip" title="Completed" data-placement="bottom" data-filtervalue="Completed" data-datafield="status"><i class="fa fa-th-list " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-Completed"></span>  
          </div>
          <div class="btn-group" role="group" id="confirmgrp">          
          	<button type="button" class="btn btn-default" id="btnConfirmed" data-toggle="tooltip" title="Confirmed" data-placement="bottom" data-filtervalue="Confirmed" data-datafield="status"><i class="fa fa-check-square " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-Confirmed"></span>    
          </div>                                     
        </div>           
        <div class="textpanel custompanel">
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>             
        </div>  
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="taskdiv"><jsp:include page="taskGrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="subdiv"><jsp:include page="subGrid.jsp"></jsp:include></div>           
      </div>
    </div>    
 
  <!-- Schedule Modal-->              
      <div id="modalschedule" class="modal fade custom-modal" role="dialog">     
      <div class="modal-dialog modal-lg">    
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Schedule</h4>          
          </div>
          <div class="modal-body">
		    	<div class="container-fluid">
					    	<div class="row rowgap">     
							    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							    	      <div id="schdiv"><jsp:include page="scheduleGrid.jsp"></jsp:include></div>     
							        </div>  
							</div>  
				    	   <div class="row rowgap">
				    	     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
					    	    <div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">Expected Date of Completion</label>
								 <div id="jqxExpDateComp" class="form-control"></div>
								</div>
							</div>	
						     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
				    	        <div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">Ref No</label>
								 <input type="text" id="txtrefno" name="txtrefno" class="form-control" placeholder="Please Enter RefNo" value='<s:property value="txtrefno"/>'/>
								</div>
							</div>
							 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">	
				    	       <div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">User</label>
								   <div id="taskuser" onkeydown="return (event.keyCode!=13);">
								            <jsp:include page="userSearch.jsp"></jsp:include>
								   </div>
								   <input type="hidden" name="hiduser" id="hiduser">
								</div>
							</div>								
						</div>
			   </div>   
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">      
            <button type="button" name="btnScheduleCreate" id="btnScheduleCreate" class="btn btn-default" style="background-color: #04AA6D;color: white;">Create</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:#f44336;color: white;">Close</button>  
          </div>
      </div>
    </div>  
  </div>
<input type="hidden" name="docno" id="docno">  
<input type="hidden" name="schrowindex" id="schrowindex">    
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="../../../../vendors/cookie/cookie.min.js"></script>     
<script src="formScripts.js"></script>    
<script>
    var userid = '<%= session.getAttribute("USERID") != null ? session.getAttribute("USERID").toString() : "" %>';
    var contPath = '<%= contextPath %>'+"/";       
</script>
  </div>
  </form>   
</body>
</html>