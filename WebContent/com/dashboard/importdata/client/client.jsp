<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client</title> 
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
<body >
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
			                 <button type="button" class="btn btn-default btnStyle" id="btnimport" data-toggle="tooltip" title="Excel Import" data-placement="bottom"><i class="fa fa-download" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btnsalesman" data-toggle="tooltip" title="Salesman" data-placement="bottom"><i class="fa fa-street-view" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btncategory" data-toggle="tooltip" title="Category" data-placement="bottom"><i class="fa fa-list" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btnarea" data-toggle="tooltip" title="Area" data-placement="bottom"><i class="fa fa-th-large" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true" ></i></button>
			         </div> 
		     </div>   
        </div>  
      </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="clientdiv" class="borderStyle"><jsp:include page="clientGrid.jsp"></jsp:include></div>
      </div>
    </div>
    
    
    <!-- Salesman modal-->                
    <div id="modalSalesman" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Salesman</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="saldiv" class="borderStyle"><jsp:include page="salesmanGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Salesman</label>           
							<select class="form-control input-sm" id="cmbsal" name="cmbsal" style="width:200px;">
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateSalesman" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveSalesman" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
    
    <!-- Category modal-->                
    <div id="modalCategory" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Category</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="categorydiv" class="borderStyle"><jsp:include page="categoryGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Category</label>           
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
      
      <!-- Area modal-->                
    <div id="modalArea" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Area</h4>                  
          </div>                             
          <div class="modal-body">
            <div class="container-fluid">
            <form class="form-inline">
                <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="areadiv" class="borderStyle"><jsp:include page="areaGrid.jsp"></jsp:include></div>                    
			      </div>                                  
			    </div> 
			    <div class="row rowgap">  
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
				    <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Update:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">           
		                <div class="form-group">
							<label>Area</label>           
							<select class="form-control input-sm" id="cmbarea" name="cmbarea" style="width:200px;">  
			  							<option></option>   
							</select>                   
						</div>       
					 </div>  
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">
							<button type="button" class="btn btn-default btnStyle" id="btnupdateArea" title="Update" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
						</div>       
					 </div> 
					 </fieldset> 
				 </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">     
					 <fieldset>   
	                 <legend style="font-size:14px;font-weight: bold">Save:</legend>    
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">         
		                <div class="form-group">  
							<button type="button" class="btn btn-default btnStyle" id="btnsaveArea" title="Save" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>   
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
	<div id="categoryaccinfowindow">
   <div ></div>
   </div>
	<div id="salesmanaccinfowindow">
   <div ></div>
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
     $("#btnconfirm").attr({'disabled':true});	
     $('#salesmanaccinfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Account Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	 $('#salesmanaccinfowindow').jqxWindow('close');
   	 $('#categoryaccinfowindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Category Search' , position: { x: 350, y: 60 }, keyboardCloseKey: 27});
   	 $('#categoryaccinfowindow').jqxWindow('close');
     $('[data-toggle="tooltip"]').tooltip();  
      
	 $("#clientGrid").jqxGrid('clear');

		$('#btnsubmit').click(function(){   
	        	funcleardata();
			 funload();
			 funConfirmEnable();
			  $('.textpanel p').text('');  
		});
		$('#btnexcel').click(function(){
			$("#clientdiv").excelexportjs({  
				containerid: "clientdiv",
				datatype: 'json',
				dataset: null,
				gridId: "clientGrid",
				columns: getColumns("clientGrid"),
				worksheetName: "Client Master "
			});
		});
       
        $('#btnimport').click(function(){
      	 upload();
        });
     
        $('#btnsalesman').click(function(){
        	var type = "Salesman";
        	populateSelectBox('getClientData.jsp?type='+type, 'cmbsal');  
   		    $('#saldiv').load("salesmanGrid.jsp?id="+1);     
            $('#modalSalesman').modal('toggle');    
             });
        
        $('#btncategory').click(function(){
        	var type = "Category";
        	populateSelectBox('getClientData.jsp?type='+type, 'cmbcategory');    
   		    $('#categorydiv').load("categoryGrid.jsp?id="+1);     
            $('#modalCategory').modal('toggle');   
             });
        
        $('#btnarea').click(function(){
        	var type = "Area";
        	populateSelectBox('getClientData.jsp?type='+type, 'cmbarea');  
   		    $('#areadiv').load("areaGrid.jsp?id="+1);        
            $('#modalArea').modal('toggle');   
        });
        
        $('#btnconfirm').click(function(){
        	funconfirm();
        });
        
        $("#cmbsal").select2({
		    placeholder: "Select an Salesman",
		    allowClear: true
		});
        
        $("#cmbcategory").select2({
		    placeholder: "Select an Category",
		    allowClear: true
		});
        
        $("#cmbarea").select2({
		    placeholder: "Select an Area",
		    allowClear: true
		});
        
        $('#btnsaveSalesman').click(function() {  
			 var type = "Salesman";  
       	 funSalesmanDataSave(type, "modalSalesman");      
       });
		
		$('#btnupdateSalesman').click(function() {  
			 var type = "Salesman";  
       	 funSalesmanDataUpdate(type, "modalSalesman");     
       });
		
		$('#btnsaveCategory').click(function() {  
			 var type = "Category";  
      	 funCategoryDataSave(type, "modalCategory");      
      });
		
		$('#btnupdateCategory').click(function() {  
			 var type = "Category";  
      	 funCategoryDataUpdate(type, "modalCategory");     
      });
		
		$('#btnsaveArea').click(function() {  
			 var type = "Area";  
      	 funAreaDataSave(type, "modalArea");      
      });
		
		$('#btnupdateArea').click(function() {  
			 var type = "Area";  
      	 funAreaDataUpdate(type, "modalArea");     
      });
	});
   
	function funRoundAmt(value,id){
			  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
			 }
		
	 
		function funload(){
			$('#clientdiv').load('clientGrid.jsp');  
		}
	
		function  funcleardata()
		{
			 $("#clientGrid").jqxGrid('clear');
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
			getAttachDocumentNo();
		 }
		
		function ajaxFileUpload(docNo) {  
			
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
	                  url:'fileAttachAction.action?formCode=CLT&doc_no='+docNo+'&descpt=Excel Import' ,
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
						$("#clientdiv").load("clientGrid.jsp");
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
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

		 function getSalemanAcc(rowBoundIndex){ 
		  	    $('#salesmanaccinfowindow').jqxWindow('open');
		        salesmanaccSearchContent('salesmanAccGrid.jsp?rowBoundIndex='+rowBoundIndex);
		 }
		         	 
		 function salesmanaccSearchContent(url) { 
		  	 $.get(url).done(function (data) { 
		 		$('#salesmanaccinfowindow').jqxWindow('setContent', data);
             }); 
		  }
		 
		 function getCategoryAcc(rowBoundIndex){ 
		  	    $('#categoryaccinfowindow').jqxWindow('open');
		        categoryaccSearchContent('categoryAccGrid.jsp?rowBoundIndex='+rowBoundIndex);
		 }
		 
		 function categoryaccSearchContent(url) { 
		  	 $.get(url).done(function (data) { 
		 		$('#categoryaccinfowindow').jqxWindow('setContent', data);
             }); 
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
		 
		function funSalesmanDataUpdate(type, modalid){
			var salid = $("#cmbsal").val();
		    var selectedrows=$("#jqxSalesmanGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(salid == "" || salid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Salesman'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_name");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_name");
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
						saveClientData("update", salid, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funSalesmanDataSave(type, modalid){   
		    var selectedrows=$("#jqxSalesmanGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}  
   
	        var i=0,salidcheck=0, accountchk=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var salid = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_id");
				 if(salid=="" || typeof(salid)=="NaN" || typeof(salid)=="undefined" || salid==null){
					 salidcheck=1;
				 }
				 var accdoc = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
				 if(accdoc=="" || typeof(accdoc)=="NaN" || typeof(accdoc)=="undefined" || accdoc==null){
					 accountchk=1;
				 }
				if(i == 0){      
					 var srvdetmtrno = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_id")+" :: "+$('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_name")+" :: "+$('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_id")+" :: "+$('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "sal_name")+" :: "+$('#jqxSalesmanGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			} 
			
		    if(salidcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Code'        
				});    
			  return false;
		    }
		    
		    if(accountchk==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select an Account'        
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
						saveClientData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		
		function funCategoryDataUpdate(type, modalid){
			var category = $("#cmbcategory").val();
		    var selectedrows=$("#jqxCategoryGrid").jqxGrid('selectedrowindexes');   
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(category == "" || category == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Category'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "cat_name");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "cat_name");
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
						saveClientData("update", category, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funCategoryDataSave(type, modalid){   
		    var selectedrows=$("#jqxCategoryGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, catnamecheck=0, acgrpcheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var catname = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "category");
				 if(catname=="" || typeof(catname)=="NaN" || typeof(catname)=="undefined" || catname==null){
					 catnamecheck=1;
				 }
				 var acgrp = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
				 if(acgrp=="" || typeof(acgrp)=="NaN" || typeof(acgrp)=="undefined" || acgrp==null){ 
					 acgrpcheck=1;
				 }
				if(i == 0){      
					 var srvdetmtrno = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "category")+" :: "+$('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "cat_name")+" :: "+$('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "category")+" :: "+$('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "cat_name")+" :: "+$('#jqxCategoryGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
		    
			if(catnamecheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Category'        
				});    
				return false;
		    }
			
			if(acgrpcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select an Account Group'        
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
						saveClientData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		
		function funAreaDataUpdate(type, modalid){
			var area = $("#cmbarea").val();
		    var selectedrows=$("#jqxAreaGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(area == "" || area == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Area'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "area");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "area");
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
						saveClientData("update", area, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funAreaDataSave(type, modalid){   
		    var selectedrows=$("#jqxAreaGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0,areaidcheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				var areaid = $('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "area");      
				 if(areaid=="" || typeof(areaid)=="NaN" || typeof(areaid)=="undefined" || areaid==null){
					 areaidcheck=1;
				 }
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "area")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "zone")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "region")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "po_box");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "area")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "zone")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "region")+" :: "+$('#jqxAreaGrid').jqxGrid('getcellvalue', selectedrows[i], "po_box");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
				   
			}  
			
			if(areaidcheck==1){
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Area'           
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
						saveClientData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		
		function saveClientData(process, docno, temptrno, type, modalid){         
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
			x.open("GET","saveClientData.jsp?process="+process+"&type="+type+"&docno="+docno+"&dataarr="+encodeURIComponent(temptrno),true);       
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
			x.open("GET","saveClientData.jsp?type="+process,true);       
			x.send();
		}
</script>

</body>
</html>
