<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Employee</title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />
  
  <style type="text/css">
  .border1 {
	  border-radius: 25px;
	  padding: 8px;
	  -moz-box-shadow:    inset 0 0 3px #000000;
      -webkit-box-shadow: inset 0 0 3px #000000;
      box-shadow:         inset 0 0 3px #000000;   
}
  .btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {       
    border-radius: 30px !important;       
} 
  .btn:focus,.btn:active {
   outline: none !important;
   box-shadow: none;
   }
   .modalStyle {      
    background-color:#33b5e5; `
    padding: 10px; 
   }
   .borderStyle{  
    margin-bottom: 0;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    border: none;
    line-height: 1.42857143;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
   box-shadow: 1px 2px 7px 3px #d4cece;                          
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }   
  .iconStyle{
	color: #000000 !important;  
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;   
  }
  .btnStyle{  
  	display: inline-block;   
    margin-bottom: 0;
    font-weight: 400;
    margin-right:5px;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: none;
    padding: 3px 8px;  
    font-size: 14px;
    line-height: 1.42857143;
    border-radius: 30px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);                     
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }
   @media (min-width: 900px) {               
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
} 
   .textpanel{
    color: blue;
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      /* background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
      background-color:#FEFE56;   
      color: black;
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

    .rowgap{
    	margin-bottom:6px;
    }
    .msg{
    	word-break:break-all;
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
}
  </style>
</head>
<body>
	<div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
           <div class="primarypanel custompanel" style="margin-left:5px;">    
	             <div class="border1">
	                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
		          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button> 
	            </div>                               
		  	 </div>   
	        
	         <div class="otherpanel custompanel"  style="margin-left:5px;">   
			        <div class="border1">     
			              <input type="file" id="fileexcelimport" name="file" style="width:75%;" > 
			         </div> 
		     </div> 
         <div class="otherpanel custompanel"  style="margin-left:5px;">        
			   <div class="border1">
		          <button type="button" class="btn btn-default btnStyle" id="btnimport" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title=" Excel Import" data-placement="bottom"></i></button>
		           <button type="button" class="btn btn-default btnStyle" id="btnaccount" data-toggle="tooltip" title="Account" data-placement="bottom"><i class="fa fa-user-circle-o" aria-hidden="true" ></i></button>
		           <button type="button" class="btn btn-default btnStyle" id="btndesignation" data-toggle="tooltip" title="Designation" data-placement="bottom"><i class="fa fa-black-tie" aria-hidden="true" ></i></button>
		           <button type="button" class="btn btn-default btnStyle" id="btnnationality" data-toggle="tooltip" title="Nationality" data-placement="bottom"><i class="fa fa-flag " aria-hidden="true"></i></button> 
		           <button type="button" class="btn btn-default btnStyle" id="btndepartment" data-toggle="tooltip" title="Department" data-placement="bottom"><i class="fa fa-users" aria-hidden="true"></i></button>       
		           <button type="button" class="btn btn-default btnStyle" id="btnpayrollcategory" data-toggle="tooltip" title="Payroll Category" data-placement="bottom"><i class="fa fa-delicious" aria-hidden="true"></i></button>       
		           <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true" ></i></button>
              </div>
	      </div>
      </div>
     </div>  
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" class="borderStyle">   
        <div id="empdiv"><jsp:include page="employeeGrid.jsp"></jsp:include></div>   
      </div>
    </div>
	
   
       <!-- Account modal-->                
    <div id="modalAccount" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Account</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="accountdiv" class="borderStyle"><jsp:include page="accountGrid.jsp"></jsp:include></div>                        
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Account</label>           
							<select class="form-control input-sm" id="cmbaccount" name="cmbaccount" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateAccount" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveAccount" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>     
               </div>
              </form>
           </div>   
          </div>  
          </div>  
        </div>    
      </div> 
	
      <!-- Designation modal-->                
    <div id="modalDesignation" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Designation</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">              
			        <div id="designdiv" class="borderStyle"><jsp:include page="designationGrid.jsp"></jsp:include></div>                          
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Designation</label>           
							<select class="form-control input-sm" id="cmbdesignation" name="cmbdesignation" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateDesignation" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveDesignation" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>     
               </div>
              </form>
           </div>   
          </div>  
          </div>  
        </div>    
      </div> 
    
    <!-- Nationality modal-->                
    <div id="modalNationality" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Nationality</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">          
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="nationdiv" class="borderStyle"><jsp:include page="nationalityGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Nationality</label>           
							<select class="form-control input-sm" id="cmbnation" name="cmbnation" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateNationality" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveNationality" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>     
               </div>
              </form>
           </div>   
          </div>  
          </div>  
        </div>    
      </div> 
   
    <!-- modalDepartment modal-->                
    <div id="modalDepartment" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Department</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">          
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="departmentdiv" class="borderStyle"><jsp:include page="departmentGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Department</label>           
							<select class="form-control input-sm" id="cmbdepartment" name="cmbdepartment" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateDepartment" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveDepartment" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>     
               </div>
              </form>
           </div>   
          </div>  
          </div>  
        </div>    
      </div> 
    
    <!-- modalPayrollcategory modal-->                
    <div id="modalPayrollcategory" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Payroll Category</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">          
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="payrollcategorydiv" class="borderStyle"><jsp:include page="payrollcategoryGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Payroll Category</label>           
							<select class="form-control input-sm" id="cmbcategory" name="cmbcategory" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateCategory" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveCategory" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>     
               </div>
              </form>
           </div>   
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
 </div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){  
   //	 $("#pytstartdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
   
    		
     	$('[data-toggle="tooltip"]').tooltip();
      
		$("#btnconfirm").attr({'disabled':true});	
		$('#btnsubmit').click(function(){   
	        	funcleardata();
			 funload();
			 funConfirmEnable();
			  $('.textpanel p').text('');  
		});
		$('#btnexcel').click(function(){
			$("#empdiv").excelexportjs({  
				containerid: "empdiv",
				datatype: 'json',
				dataset: null,
				gridId: "employeeGrid",
				columns: getColumns("employeeGrid"),
				worksheetName: "Employee Master "
			});
		});
		
       
       
        $('#btnimport').click(function(){
       		upload();
        });
     
        $('#btnaccount').click(function(){
        	var type = "Account";
        	populateSelectBox('getEmployeeData.jsp?type='+type, 'cmbaccount');    
   		    $('#accountdiv').load("accountGrid.jsp?id="+1);     
            $('#modalAccount').modal('toggle');   
             });
		
        $('#btndesignation').click(function(){
        	var type = "Designation";
        	populateSelectBox('getEmployeeData.jsp?type='+type, 'cmbdesignation');    
   		    $('#designdiv').load("designationGrid.jsp?id="+1);     
            $('#modalDesignation').modal('toggle');   
             });
        
        $('#btnnationality').click(function(){
        	var type = "Nationality";
        	populateSelectBox('getEmployeeData.jsp?type='+type, 'cmbnation');  
   		    $('#nationdiv').load("nationalityGrid.jsp?id="+1);     
            $('#modalNationality').modal('toggle');    
             });
        
        
         $('#btndepartment').click(function(){
        	var type = "Department";
        	populateSelectBox('getEmployeeData.jsp?type='+type, 'cmbdepartment');  
   		    $('#departmentdiv').load("departmentGrid.jsp?id="+1);     
            $('#modalDepartment').modal('toggle');    
             });
        
        $('#btnpayrollcategory').click(function(){
        	var type = "PayrollCategory";
        	populateSelectBox('getEmployeeData.jsp?type='+type, 'cmbcategory');  
   		    $('#payrollcategorydiv').load("payrollcategoryGrid.jsp?id="+1);     
            $('#modalPayrollcategory').modal('toggle');    
             }); 
        
       
        $("#cmbaccount").select2({
		    placeholder: "Select an Account",
		    allowClear: true
		});
        
       
        $("#cmbdesignation").select2({
		    placeholder: "Select an Designation",
		    allowClear: true
		});
        
        $("#cmbnation").select2({
		    placeholder: "Select an Nationality",
		    allowClear: true
		});
        
      $("#cmbdepartment").select2({
		    placeholder: "Select an Department",
		    allowClear: true
		});
        
       $("#cmbcategory").select2({
		    placeholder: "Select an PayrollCategory",
		    allowClear: true
		});
        
        $('#btnsaveAccount').click(function() {  
			 var type = "Account";  
     	 funAccountDataSave(type, "modalAccount");      
     });
		
		$('#btnupdateAccount').click(function() {  
			 var type = "Account";  
     	 funAccountDataUpdate(type, "modalAccount");     
     });
        
		 $('#btnsaveDesignation').click(function() {  
			 var type = "Designation";  
     	 funDesignationDataSave(type, "modalDesignation");      
     });
		
		$('#btnupdateDesignation').click(function() {  
			 var type = "Designation";  
     	 funDesignationDataUpdate(type, "modalDesignation");     
     });
		
		
		$('#btnsaveNationality').click(function() {  
			 var type = "Nationality";  
     	 funNationalityDataSave(type, "modalNationality");      
     });
		
		$('#btnupdateNationality').click(function() {  
			 var type = "Nationality";  
     	 funNationalityDataUpdate(type, "modalNationality");     
     });
		
		 $('#btnsaveDepartment').click(function() {  
			 var type = "Department";  
    	 funDepartmentDataSave(type, "modalDepartment");      
    });
		
		$('#btnupdateDepartment').click(function() {  
			 var type = "Department";  
    	 funDepartmentDataUpdate(type, "modalDepartment");     
    });
		
		$('#btnsaveCategory').click(function() {  
			 var type = "PayrollCategory";  
   	 funCategoryDataSave(type, "modalPayrollcategory");      
   });
		
		$('#btnupdateCategory').click(function() {  
			 var type = "PayrollCategory";  
   	 funCategoryDataUpdate(type, "modalPayrollcategory");     
   }); 
		
		$('#btnconfirm').click(function(){
        	funconfirm();
        });
	});
   
    function populateSelectBox(url, selectBoxId) {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.split('####');
	            var ids = items[0].split(",");
	            var names = items[1].split(",");
	            var options = '<option value="">--Select--</option>';
	            for (var i = 0; i < names.length; i++) {
	                options += '<option value="' + ids[i] + '">' + names[i] + '</option>';    
	            }
	            document.querySelector('select#' + selectBoxId).innerHTML = options;    
	        } 
	    };
	    x.open("GET", url, true);                       
	    x.send();  
	}   
 	
	
	function funRoundAmt(value,id){
			  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
			 }
		
	 
		function funload(){    
				$('#overlay,#PleaseWait').show();
			$('#empdiv').load('employeeGrid.jsp?check=1');  
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
	
		
		
	
		function  funcleardata()
		{
			 $("#employeeGrid").jqxGrid('clear');

			   		
			}
		

		function  funReadOnly(){
			
		}
		function funRemoveReadOnly(){
			
		}
	
		
		
		function getAttachDocumentNo(){   
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items>0){
						
						var path=document.getElementById("fileexcelimport").value;
						var fsize = $('#fileexcelimport')[0].files[0].size;
						var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
						
						if((extn=='xls') || (extn=='csv')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
			                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
			                     }); 
						            return;
					     } 
					}
					
			  }
			}
				
		x.open("GET","getAttachDocumentNo.jsp",true);
		x.send();
		}
		
		function upload(){
			 
			//$('#txtexcelvalidation').val(1);
			getAttachDocumentNo();
			 
		 }
		
		function ajaxFileUpload(docNo) {  
			
			 /*  var jvtdate = $("#jqxJournalVouchersDate").val();
   		      var newDate = jvtdate.split('.');
   		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
   		   */
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        var fsize = $('#fileexcelimport')[0].files[0].size;
			        
			        if(fsize>1048576) {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                          style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                      }); 
			            return;
			        }
			    }else{
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=EMP&doc_no='+docNo+'&descpt=Excel Import' ,
	                  secureuri:false,  
	                  fileElementId:'fileexcelimport',    
	                  dataType: 'json', 
	                  success: function (data, status)   
	                  {  
	                     
	                     if(status=='success'){
	                         saveExcelDataData(docNo);
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	              	          }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e){  
	                      $.messager.alert('Message',e);
	                  }  
	              });  
	          return false;  
	      }
		function saveExcelDataData(docNo){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1){
						$("#empdiv").load("employeeGrid.jsp");
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
		
		function funAccountDataUpdate(type, modalid){
			var account = $("#cmbaccount").val();
		    var selectedrows=$("#jqxAccountGrid").jqxGrid('selectedrowindexes');         
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(account == "" || account == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Account Name'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAccountGrid').jqxGrid('getcellvalue', selectedrows[i], "description");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAccountGrid').jqxGrid('getcellvalue', selectedrows[i], "description");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
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
						saveEmployeeData("update", account, temptrno, type, modalid);       
					}
			});  
		       
		}
		
		
		function funAccountDataSave(type, modalid){   
		    var selectedrows=$("#jqxAccountGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, desnamecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				   var description = $('#jqxAccountGrid').jqxGrid('getcellvalue', selectedrows[i], "description");   
				 if(description=="" || typeof(description)=="NaN" || typeof(description)=="undefined" || description==null){
					 desnamecheck=1;
				 }
				
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAccountGrid').jqxGrid('getcellvalue', selectedrows[i], "description");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAccountGrid').jqxGrid('getcellvalue', selectedrows[i], "description");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
		    
			 if(desnamecheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Account Name'        
				});    
				return false;
		    }
			
			
			var validate = funValidate(temptrno, type);
			if(validate==1){  
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
						saveEmployeeData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funDesignationDataUpdate(type, modalid){
			var designation = $("#cmbdesignation").val();    
		    var selectedrows=$("#jqxDesignationGrid").jqxGrid('selectedrowindexes');            
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			//alert(1);
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(designation == "" || designation == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Designation'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "desc1");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "desc1");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
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
						saveEmployeeData("update", designation, temptrno, type, modalid);    
						//alert(designation, temptrno, type, modalid);
					}
			});  
		       
		}
		
		
		function funDesignationDataSave(type, modalid){   
		    var selectedrows=$("#jqxDesignationGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, descgnamecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var desc1 = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "desc1");
				 if(desc1=="" || typeof(desc1)=="NaN" || typeof(desc1)=="undefined" || desc1==null){
					 descgnamecheck=1;
				 }
				/* var acgrp = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "description");
				 if(acgrp=="" || typeof(acgrp)=="NaN" || typeof(acgrp)=="undefined" || acgrp==null){ 
					 acgrpcheck=1;
				 }  */
				if(i == 0){      
					 var srvdetmtrno = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "desc1");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxDesignationGrid').jqxGrid('getcellvalue', selectedrows[i], "desc1");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
		    
			if(descgnamecheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Designation'        
				});    
				return false;
		    }
			
			/* if(acgrpcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select an Account Group'        
				});    
				return false;
		    }  */
			
			var validate = funValidate(temptrno, type);
			if(validate==1){  
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
						saveEmployeeData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funNationalityDataUpdate(type, modalid){  
			var nationid = $("#cmbnation").val();
		    var selectedrows=$("#jqxNationalityGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(nationid == "" || nationid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Nationality'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxNationalityGrid').jqxGrid('getcellvalue', selectedrows[i], "nationality");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxNationalityGrid').jqxGrid('getcellvalue', selectedrows[i], "nationality");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
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
						saveEmployeeData("update", nationid, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funNationalityDataSave(type, modalid){   
		    var selectedrows=$("#jqxNationalityGrid").jqxGrid('selectedrowindexes');   
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}  
   
	        var i=0,salidcheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {   
				 var nationality = $('#jqxNationalityGrid').jqxGrid('getcellvalue', selectedrows[i], "nationality");
				 if(nationality=="" || typeof(nationality)=="NaN" || typeof(nationality)=="undefined" || nationality==null){
					 salidcheck=1;
				 }
				if(i == 0){      
					 var srvdetmtrno = $('#jqxNationalityGrid').jqxGrid('getcellvalue', selectedrows[i], "nationality");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxNationalityGrid').jqxGrid('getcellvalue', selectedrows[i], "nationality");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			} 
		    if(salidcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Nationality'        
				});    
			return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
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
						saveEmployeeData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		 function funDepartmentDataUpdate(type, modalid){  
			var departmentid = $("#cmbdepartment").val();
		    var selectedrows=$("#departGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(departmentid == "" || departmentid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Department'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#departGrid').jqxGrid('getcellvalue', selectedrows[i], "department");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#departGrid').jqxGrid('getcellvalue', selectedrows[i], "department");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
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
						saveEmployeeData("update", departmentid, temptrno, type, modalid);       
					}
			});  
		       
		}
		
		function funDepartmentDataSave(type, modalid){   
		    var selectedrows=$("#departGrid").jqxGrid('selectedrowindexes');       
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}  
   
	        var i=0,salidcheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {   
				 var department = $('#departGrid').jqxGrid('getcellvalue', selectedrows[i], "department");
				 if(department=="" || typeof(department)=="NaN" || typeof(department)=="undefined" || department==null){
					 salidcheck=1;
				 }
				if(i == 0){      
					 var srvdetmtrno = $('#departGrid').jqxGrid('getcellvalue', selectedrows[i], "department");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#departGrid').jqxGrid('getcellvalue', selectedrows[i], "department");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			} 
		    if(salidcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Department'        
				});    
			return false;
		    }
		    
		    var validate = funValidate(temptrno, type);  
		    if(validate==1){  
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
						saveEmployeeData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}   
		
		function funCategoryDataUpdate(type, modalid){      
			var payrollid = $("#cmbcategory").val();
		    var selectedrows=$("#jqxPayrollGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(payrollid == "" || payrollid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Payroll Category'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxPayrollGrid').jqxGrid('getcellvalue', selectedrows[i], "paycat");    
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxPayrollGrid').jqxGrid('getcellvalue', selectedrows[i], "paycat");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
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
						saveEmployeeData("update", payrollid, temptrno, type, modalid);       
					}
			});  
		       
		}
		
		function funCategoryDataSave(type, modalid){      
		    var selectedrows=$("#jqxPayrollGrid").jqxGrid('selectedrowindexes');          
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}  
   
	        var i=0,salidcheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {   
				 /* var payroll = $('#jqxPayrollGrid').jqxGrid('getcellvalue', selectedrows[i], "paycat");
				 if(payroll=="" || typeof(payroll)=="NaN" || typeof(payroll)=="undefined" || payroll==null){
					 salidcheck=1;
				 }  */
				if(i == 0){      
					 var srvdetmtrno = $('#jqxPayrollGrid').jqxGrid('getcellvalue', selectedrows[i], "paycat");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxPayrollGrid').jqxGrid('getcellvalue', selectedrows[i], "paycat");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			} 
		    /* if(salidcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Payroll Category'        
				});    
			return false;
		    } */
		    
		    var validate = funValidate(temptrno, type);  
		    if(validate==1){  
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
						saveEmployeeData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function saveEmployeeData(process, docno, temptrno, type, modalid){                 
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items=x.responseText.trim();
					if(parseInt(items)>0){
						$('#'+modalid).modal('toggle');
						funload();
						funConfirmEnable();
						if(process=="update"){
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Updated Successfully'        
							});
						}else{
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Successfully Saved'        
							});
						}
					}else{
						if(process=="update"){  
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Updated'        
							});
						}else{
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Saved'        
							});
						}
					}
					
			  }
			}
			x.open("GET","saveEmployeeData.jsp?process="+process+"&type="+type+"&docno="+docno+"&dataarr="+encodeURIComponent(temptrno),true);       
			x.send();
		} 
		
		function funValidate(dataarr, type){
		    var val = 0;
		    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items = x.responseText.trim();
					if(items!=""){
							swal.fire({  
								    icon: 'warning',
									title: 'Warning',
									text: items           
							});
							val = 1;
					}else{
						 val = 0;
					}
			  }
			}
			x.open("GET","validateData.jsp?dataarr="+encodeURIComponent(dataarr)+"&type="+type,false);       
			x.send();
			
			return val;
	 }
		
		function funConfirmEnable(){  
		    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items = x.responseText.trim();
					if(parseInt(items)==0){
						 $("#btnconfirm").attr({'disabled':false});		 
					}else{
						 $("#btnconfirm").attr({'disabled':true});	
					}
			  }
			}
			x.open("GET","getConfirmChk.jsp",true);       
			x.send();
	 }
		
		function funconfirm(){  
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
						Saveconfirm("Confirm");      
					}else{
					}
			});  
			
		}
		
		function Saveconfirm(process){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items=x.responseText.trim();
					if(parseInt(items)>0){
						funload();
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Successfully Confirmed'            
							});
					}else{
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Confirmed'        
							});
						 
					}
					
			  }
			}
			x.open("GET","saveEmployeeData.jsp?type="+process,true);       
			x.send();
		}

</script>

</body>
</html>
