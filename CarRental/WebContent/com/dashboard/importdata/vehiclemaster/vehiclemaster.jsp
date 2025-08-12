<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Vehicle Master</title> 
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
		     
		     <div class="otherpanel custompanel" style="margin-left:5px;">        
			        <div class="border1">     
			                 <button type="button" class="btn btn-default btnStyle" id="btnimport" data-toggle="tooltip" title="Excel Import" data-placement="bottom"><i class="fa fa-download" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnauthority" data-toggle="tooltip" title="Authority" data-placement="bottom"><i class="fa fa-university" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnplatecode" data-toggle="tooltip" title="Plate Code" data-placement="bottom"><i class="fa fa-window-maximize" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnbrand" data-toggle="tooltip" title="Brand" data-placement="bottom"><i class="fa fa-bold" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnmodel" data-toggle="tooltip" title="Model" data-placement="bottom"><i class="fa fa-car" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnyom" data-toggle="tooltip" title="Yom" data-placement="bottom"><i class="fa fa-calendar" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btncolor" data-toggle="tooltip" title="Color" data-placement="bottom"><i class="fa fa-paint-brush" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btngroup" data-toggle="tooltip" title="Group" data-placement="bottom"><i class="fa fa-users" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnspecification" data-toggle="tooltip" title="Specification" data-placement="bottom"><i class="fa fa-user-circle-o" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnproject" data-toggle="tooltip" title="Project" data-placement="bottom"><i class="fa fa-sellsy" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btndealer" data-toggle="tooltip" title="Dealer" data-placement="bottom"><i class="fa fa-address-card-o" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btninsurance" data-toggle="tooltip" title="Insurance" data-placement="bottom"><i class="fa fa-child" aria-hidden="true" ></i></button>
					         <button type="button" class="btn btn-default btnStyle" id="btnfinance" data-toggle="tooltip" title="Finance" data-placement="bottom"><i class="fa fa-folder-open" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true" ></i></button>
			         </div> 
		     </div>   
        </div>  
	</div>
	 
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="vehiclediv" class="borderStyle"><jsp:include page="vehicleGrid.jsp"></jsp:include></div>
      </div>
    </div>  
    
    <!-- Authority modal-->                
    <div id="modalAuthority" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Authority</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="authdiv" class="borderStyle"><jsp:include page="authorityGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Authority</label>           
							<select class="form-control input-sm" id="cmbauth" name="cmbauth" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateAuthority" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveAuthority" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
    <!-- Plate code modal-->                  
    <div id="modalPlatecode" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Plate Code</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">          
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="platediv" class="borderStyle"><jsp:include page="platecodeGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Plate Code</label>           
							<select class="form-control input-sm" id="cmbplc" name="cmbplc" style="width:200px;"> </select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">           
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdatePlatecode" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsavePlatecode" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
   
    <!-- Brand modal-->                
    <div id="modalBrand" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Brand</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="brddiv" class="borderStyle"><jsp:include page="brandGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Brand</label>           
							<select class="form-control input-sm" id="cmbbrand" name="cmbbrand" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateBrand" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveBrand" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
    <!-- Model modal-->                
    <div id="modalModel" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Model</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="mdldiv" class="borderStyle"><jsp:include page="modelGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Model</label>           
							<select class="form-control input-sm" id="cmbmodel" name="cmbmodel" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateModel" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveModel" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- YOM modal-->                
    <div id="modalYOM" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">YOM</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="yomdiv" class="borderStyle"><jsp:include page="yomGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>YOM</label>           
							<select class="form-control input-sm" id="cmbyom" name="cmbyom" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateYOM" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveYOM" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Colors modal-->                
    <div id="modalColor" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Color</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="clrdiv" class="borderStyle"><jsp:include page="colorGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Color</label>           
							<select class="form-control input-sm" id="cmbcolor" name="cmbcolor" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateColor" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveColor" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Group modal-->                
    <div id="modalGroup" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Group</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="groupdiv" class="borderStyle"><jsp:include page="groupGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Group</label>           
							<select class="form-control input-sm" id="cmbgroup" name="cmbgroup" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateGroup" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveGroup" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Specification modal-->                
    <div id="modalSpecification" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Specification</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="specificationdiv" class="borderStyle"><jsp:include page="specificationGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Specification</label>           
							<select class="form-control input-sm" id="cmbspecification" name="cmbspecification" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateSpecification" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveSpecification" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Project modal-->                
    <div id="modalProject" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Project</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="projectdiv" class="borderStyle"><jsp:include page="projectGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Project</label>           
							<select class="form-control input-sm" id="cmbproject" name="cmbproject" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateProject" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveProject" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      
      <!-- Dealer modal-->                
    <div id="modalDealer" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Dealer</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="dealerdiv" class="borderStyle"><jsp:include page="dealerGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Dealer</label>           
							<select class="form-control input-sm" id="cmbdealer" name="cmbdealer" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateDealer" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveDealer" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Insurance modal-->                
    <div id="modalInsurance" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Insurance</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="insurancediv" class="borderStyle"><jsp:include page="insuranceGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Insurance</label>           
							<select class="form-control input-sm" id="cmbinsurance" name="cmbinsurance" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateInsurance" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveInsurance" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
      
      <!-- Finance modal-->                
    <div id="modalFinance" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Finance</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="financediv" class="borderStyle"><jsp:include page="financeGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Finance</label>           
							<select class="form-control input-sm" id="cmbfinance" name="cmbfinance" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateFinance" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>      
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnsaveFinance" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
       <input type="hidden" id="divname" name="divname">      
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

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script src="main.js"></script> 
<script type="text/javascript">
      $(document).ready(function () {          
          $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
      });	  
</script> 		  
</div>
  <div id="accountWindow">
				<div></div><div></div>
				</div> 
<div id="clientaccinfowindow">
   <div ></div>
   </div>
</body>
</html>