<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client Change</title>             
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
  		width:500px;  
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
          <label>Type: </label>
            <select id="agmttype" name="agmttype" class="form-control">
                <option value="RAG">RAG</option>
                <option value="LAG">LAG</option>    
            </select> 
        </div>
    </div>
    
       <div class="form-group mb-2">
        <div class="form-group mb-2">
           <label>Branch: </label>
            <select id="branch" name="branch" class="form-control">
           <option value="">--Select--</option></select>
        </div>
    </div>
       <div class="form-group mb-2">
        <div class="form-group mb-2">
       <label >Client: </label>
              <input type="text" class="form-control" id="client" list="client" placeholder="Search for client">    
               </div>
    </div>
    		<button type="button" class="btn btn-default" id="btnclear"  data-toggle="tooltip" title="Clear" data-placement="bottom"><i class="fa fa-times-circle " aria-hidden="true"></i></button>    
      
  
   </div> 
       <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh " aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>   
        
         <div class="primarypanel custompanel1">     
  			<button type="button" class="btn btn-default" id="btnclientchange"  data-toggle="tooltip" title="Client Change" data-placement="bottom"><i class="fa fa-user " aria-hidden="true"></i></button>    
        </div>  
        
         <div class="textpanel custompanel" >
			<p style="font-size:85%;padding-top:9px;padding-left:6px">&nbsp;</p>          
        </div>
          </form>
      </div>
    </div>
    
      
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="ccDiv"><jsp:include page="clientchangeGrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    
      <input type="hidden" name="hiddocno" id="hiddocno">   
      <input type="hidden" name="hidcldocno" id="hidcldocno"> 
      <input type="hidden" name="hidacno" id="hidacno">  
     <input type="hidden" name="hiddrid" id="hiddrid">  
    <input type="hidden" name="hidclient" id="hidclient">  
    
   
      
      
      
    <div class="modal fade" id="clientchangeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0 text-center" style="background-color: #007bff; color: white; height: 45px; padding: 5px 20px;">
        <h4 class="modal-title font-weight-bold" id="exampleModalLabel">Client Change</h4>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <form autocomplete="off">
        <div class="modal-body">    
          <div class="row">
          
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 form-group">  
              <label for="Client">Client</label>
              <input type="text" class="form-control" id="txtclient" list="clientlist" placeholder="Search for client">    
              <datalist id="clientlist"></datalist>   
            </div>
          </div>
          <div class="row" >
           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 form-group">  
              <label for=driver>Driver</label>
              <input type="text" class="form-control" id="txtdriver" list="driverlist" placeholder="Search for Driver">    
              <datalist id="driverlist"></datalist>   
            </div>
          
        </div>
         
       
       
        <div class="modal-footer border-top-0 d-flex justify-content-between">
          <button type="button" class="btn btn-success" id="btnclientsave">Save</button>  
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>   
        </div>
      </form>
      </div>
    </div>
  </div>


    
    <script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="../../../../vendors/cookie/cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){ 
    	  $('#clientwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  		$('#clientwindow').jqxWindow('close');
  	
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
	    $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		
				  
				  var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
				  var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));

				  $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));

				  $('#todate').on('change', function () {
				      var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate')); // Get updated From Date
				      var todates = new Date($('#todate').jqxDateTimeInput('getDate')); // Get updated To Date
				      
				    //  console.log("From Date:", fromdates);
				   //   console.log("To Date:", todates);
				      
				      if (todates < fromdates) {
				          Swal.fire({  
				              icon: 'warning',
				              title: 'Warning',
				              text: 'To Date cannot be less than From Date'
				          });
				          return false;  
				      }
				  });

				   
				  $('#client').dblclick(function(){
						
						 $('#clientwindow').jqxWindow('open');
							$('#clientwindow').jqxWindow('focus');
							 clientSearchContent('getClient.jsp');
						});
				  getClientdetails();getBranch();
	    $('#btnsubmit').click(function(){  
	        	loads(); 
        }); 
	    
	    $('#btnclear').click(function(){  
        	clear(); 
    }); 
    
	    $('#btnexcel').click(function(){  
	        
			$("#ccDiv").excelexportjs({
				containerid: "ccDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxccDivGrid", 
				columns: getColumns("jqxccDivGrid") ,     
				worksheetName:"Client Change list"
				});
			
	    }); 
	    $('#btnclientchange').click(function(){  
        	$('#clientchangeModal').modal('show');
        });
	 
	    $('#btnclientsave').click(function(){    
        	var hiddocno = $("#hiddocno").val();
        	var hidcldocno = $("#hidcldocno").val();
        	var hidacno = $("#hidacno").val();
        	var hiddrid = $("#hiddrid").val();
        	var agmttype = $("#agmttype").val();
        	if(hidcldocno == null || hidcldocno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Client'
				});
		        return false; 
        	}
        	if(hidacno == null || hidacno == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Client'
				});
		        return false; 
        	}
        	
        	if(hiddrid == null || hiddrid == ""){
        		Swal.fire({  
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Driver'
				});
		        return false; 
        	}
        	
        	
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to Update Client?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						 $('#clientchangeModal').modal('hide'); 
						$("#overlay, #PleaseWait").show();
							saveClient(agmttype,hiddocno, hidcldocno, hidacno, hiddrid); 
						
					}
			});
        });
        
	    
	 
	    
        $("#txtclient").change(function() {  
            var el = $("#txtclient")[0];
            if (el.value.trim() != '') {
                var selectedOption = $("#clientlist option[value='" + $('#txtclient').val() + "']");
                
                var cldocno = selectedOption.attr('data-cldocno');
                var acno = selectedOption.attr('data-acno');

                $("#hidcldocno").val(cldocno); 
                $("#hidacno").val(acno); 
                getDriverdetails();
             //   console.log("cldocno:", cldocno);
              //   console.log("acno:", acno);
            } 
        });
        
        $("#txtdriver").change(function() {  
            var el = $("#txtdriver")[0];
            if (el.value.trim() != '') {
                var selectedOption = $("#driverlist option[value='" + $('#txtdriver').val() + "']");
                
                var drid = selectedOption.attr('data-drid');

                $("#hiddrid").val(drid); 
           //   console.log("drid:", drid);
            } 
        });
    });
    
    function saveClient(agmttype,hiddocno, hidcldocno, hidacno, hiddrid){
    	 var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.trim();
				
					 if(parseInt(items)>0){  	  
						
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $('#clientchangeModal').modal('hide'); 
								 $('#txtclient').val('');
								 $('#txtdriver').val('');
								 $('#hiddocno').val('');
								 $('#hidcldocno').val('');
								 $('#hidacno').val('');
								 $('#hiddrid').val('');
								 $('#hidclient').val(''); 
								 $('#client').val(''); 
								 loads() ;
								 $("#overlay, #PleaseWait").hide();
								 
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Saved'  
								 });
						} 
				}
		}
	x.open("GET","saveData.jsp?agmttype="+agmttype+"&hiddocno="+hiddocno+"&hidcldocno="+hidcldocno+"&hidacno="+hidacno+"&hiddrid="+hiddrid,true);      
	x.send();    
    }function clear(){
    	
     	 $('#txtclient').val('');
		 $('#txtdriver').val('');
		 $('#hiddocno').val('');
		 $('#hidcldocno').val('');
		 $('#hidacno').val('');
		 $('#hiddrid').val('');
		 $('#hidclient').val(''); 
		 $('#client').val('');  
		 $('#branch').val('');  
    }
	    function loads(){   
	  
		    $("#overlay, #PleaseWait").show();
		    var fromdate= $("#fromdate").val();
		    var todate= $("#todate").val();
	        var agmttype = $("#agmttype").val();
	        var branch = $("#branch").val();
	        var client = $("#hidclient").val();
		      
			$('#ccDiv').load('clientchangeGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&agmttype='+encodeURIComponent(agmttype)+'&branch='+branch+'&client='+encodeURIComponent(client)+'&id=1');                    
			$(".textpanel p").text("");   
	    } 
	    function getClientdetails() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(","); 
					var yearacno=items[2].split(","); 
					var optionsyear = "";
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearItems[i] + '" data-cldocno="'+yearIdItems[i]+'"data-acno="'+yearacno[i]+'"></option>';
						
					}  
					$("datalist#clientlist").html(optionsyear);  
				} else {
				}
			}
			x.open("GET", "getClientdetails.jsp", true);
			x.send();
		}
	   
	    function getBranch(){
	 	   var x = new XMLHttpRequest();
	 		x.onreadystatechange = function() {
	 			if (x.readyState == 4 && x.status == 200) {
	 				var items = x.responseText;
	 				items = items.split('####');
	 				var branch = items[0].split(",");
	 				var brhid = items[1].split(",");
	 				var optionsloc = '<option value="">--Select--</option>';
	 				for (var i = 0; i < branch.length; i++) {
	 					optionsloc += '<option value="' + brhid[i] + '">'
	 							+ branch[i] + '</option>';
	 				}
	 				$("select#branch").html(optionsloc);
	 				
	 			} else {
	 			}
	 		}
	 		x.open("GET", "getBranch.jsp", true);
	 		x.send();
	 }

	    
	  

	    
	    
	    function getDriverdetails() {
	    	var hidcldocno = $("#hidcldocno").val(); 
	    	var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var drname = items[0].split(",");
					var drid = items[1].split(","); 
					var optionsyear = "";
					for (var i = 0; i < drname.length; i++) {
						optionsyear += '<option value="' + drname[i] + '" data-drid="'+drid[i]+'"></option>';
						
					}  
					$("datalist#driverlist").html(optionsyear);  
				} else {
				}
			}
			
			x.open("GET", "getdriverdetails.jsp?hidcldocno="+hidcldocno, true);     
			x.send();
		}
	    
	  
   
    function getClient(event){
    	var x= event.keyCode;
    	if(x==114){
    		
    		 $('#clientwindow').jqxWindow('open');
    			$('#clientwindow').jqxWindow('focus');
    			 clientSearchContent('getClient.jsp');			 
    	}
    }
    function clientSearchContent(url) {
        $.get(url).done(function (data) {
        	$('#clientwindow').jqxWindow('setContent', data);
    	}); 
    }
    </script>
    
  </div>
<div id="clientwindow">
<div></div>
</div>
</body>
</html>