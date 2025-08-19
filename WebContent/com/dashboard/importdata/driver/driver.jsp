<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <% String contextPath=request.getContextPath();%>   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Driver</title> 
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
			                 <button type="button" class="btn btn-default btnStyle" id="btnimport" data-toggle="tooltip" title="Excel Import" data-placement="bottom"><i class="fa fa-download" aria-hidden="true" ></i></button>
			                 <button type="button" class="btn btn-default btnStyle" id="btnnationality" data-toggle="tooltip" title="Nationality" data-placement="bottom"><i class="fa fa-flag " aria-hidden="true"></i></button>       
			                 <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true" ></i></button>
			         </div> 
		     </div>   
        </div>  
      </div>
		
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
        <div id="driverdiv" class="borderStyle"><jsp:include page="driverGrid.jsp"></jsp:include></div>
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
	 </div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){  
   //	 $("#pytstartdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
     $("#btnconfirm").attr({'disabled':true});	
    	$('[data-toggle="tooltip"]').tooltip();
      
					$("#driverGrid").jqxGrid('clear');

		$('#btnsubmit').click(function(){   
	        	funcleardata();
			 funload();
			 funConfirmEnable();
			  $('.textpanel p').text('');  
		});
		$('#btnexcel').click(function(){
			$("#driverdiv").excelexportjs({  
				containerid: "driverdiv",
				datatype: 'json',
				dataset: null,
				gridId: "driverGrid",
				columns: getColumns("driverGrid"),
				worksheetName: "Driver"
			});
		});
       
        $('#btnimport').click(function(){
      		 upload();
        });
     
        $('#btnnationality').click(function(){
        	var type = "Nationality";
        	populateSelectBox('getNationalityData.jsp?type='+type, 'cmbnation');  
   		    $('#nationdiv').load("nationalityGrid.jsp?id="+1);     
            $('#modalNationality').modal('toggle');    
             });
        
        $("#cmbnation").select2({
		    placeholder: "Select an Nationality",
		    allowClear: true
		});
        
        $('#btnsaveNationality').click(function() {  
			 var type = "Nationality";  
      	 funNationalityDataSave(type, "modalNationality");      
      });
		
		$('#btnupdateNationality').click(function() {  
			 var type = "Nationality";  
      	 funNationalityDataUpdate(type, "modalNationality");     
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
	            var ids = items[0].split("$$$$");
	            var names = items[1].split("$$$$");
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
			// $("#amcfollowupGrid").jqxGrid('clear');
			$('#driverdiv').load('driverGrid.jsp');  
		}
		
		function  funcleardata()
		{
			 $("#driverGrid").jqxGrid('clear');

			   		
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
	                  url:'fileAttachAction.action?formCode=DRV&doc_no='+docNo+'&descpt=Excel Import' ,
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
						$("#driverdiv").load("driverGrid.jsp");
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
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
						saveNationalityData("update", nationid, temptrno, type, modalid);  
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
						saveNationalityData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function saveNationalityData(process, docno, temptrno, type, modalid){         
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
			x.open("GET","saveNationalityData.jsp?process="+process+"&type="+type+"&docno="+docno+"&dataarr="+encodeURIComponent(temptrno),true);       
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
			x.open("GET","saveNationalityData.jsp?type="+process,true);       
			x.send();
		}
</script>

</body>
</html>
