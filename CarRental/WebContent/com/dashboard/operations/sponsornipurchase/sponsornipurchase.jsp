<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<% String contextPath=request.getContextPath();%>
<head>
<title>Sponsor NI Purchase</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 



  <style type="text/css">
  	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	}
	@font-face {
  		font-family: Poppins;
  		src: url('../../../../vendors/fonts/Poppins/Poppins-Regular.ttf')  format('truetype');
	}
	body{
		font-family:Poppins;
		font-size:12px;
	}
	input.form-control{
		height:34px !important;
		font-size:12px !important;
	}
	p{
		margin-bottom:0;
		
	}
	.panel-body{
		border:0;
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
	   position:absolute;right:-5px;top:-8px;z-index:2;
	   background-color:red;
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
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
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .textpanel p.h8{
   		margin-top: 4px;
    	margin-bottom: 3px;
    	text-size:10;
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
	
	.card-item{
		background-color: #fff;
	    padding-left: 10px;
	    padding-right: 10px;
	    border-radius: 4px;
	    padding-top: 1px;
	    padding-bottom: 4px;
	    margin-bottom:8px;
	    box-shadow:0 5px 10px rgba(154,160,185,.05), 0 15px 40px rgba(166,173,201,.2);
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		box-shadow: 0 2px 4px 0 rgb(62 57 107 / 13%);
		position:relative;
		transition:all 0.3s ease;
		cursor:pointer;
		
	}
	
	.card-item:hover,.card-item.active{
		transform:scale(1.1);
	}
	.card-item.active{
		border-bottom: 5px solid #08ad13;
	}
	.card-item:hover svg,.card-item.active svg {
		transform:rotate(12deg);
	}
	.card-item h2{
		margin-top: 5px;
    	margin-bottom: 5px;
    	color:#fff;
    	display:inline-block;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.2px;
		font-weight:200;
		display:inline-block;
	}
	.card-item .progress{
		height: 6px;
    	margin-bottom: 6px;
		background-color:#fff;
	}
	.card-item .progress .progress-bar{
		background-color:var(--theme-secondary);
		opacity:0.7;
	}
	.card-item small{
		color: #f8f9fa;
		display:block;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;
		width: 48px;height:48px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	}
	button[data-dismiss="modal"] {
		background-color:#fff;
	}
	.modal .well{
		padding:15px;
		margin-bottom:10px;
	}
	.modal .well fieldset legend{
		margin-bottom:10px;
	}
	.help-block{
		margin-bottom:0;
	}
.custom-file-upload {
    padding: 4px 10px;
    background-color: #aeb6bf;
    color: black;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.custom-file-upload:hover {
    /* background-color: #0056b3; */
}

.file-name {
    margin-left: 10px; /* Space between button and file name */
    font-size: 14px;
    color: #333; /* Customize text color */
    font-weight: normal;
}
  </style>
</head>
<body >
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    	<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div class=" primarypanel custompanel">
        			<div class="form-group"  style="display:flex; align-items:center; margin: 0px 0px;">
        				<div style="display:flex; align-items:center;">
 		       				<label for="todate" >Date : &nbsp; </label>
        					<div id="todate"></div>
        				</div>
        				<div style="margin-left:4px;">
	        				<select name="cmbbranch" id="cmbbranch" class="form-control" style="width:200px;"><option value="">--Select--</option></select>
        				</div>
	        			<div style="margin-left:4px;">
	  						<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
	          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	          				<button type="button" class="btn btn-default" id="btnguidlines" data-toggle="tooltip" title="Guidelines" data-placement="bottom"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
	        			</div>
        			</div>
        		</div>
        		<div class="detailpanel custompanel">
          			<button type="button" class="btn btn-default" id="btncreate" data-toggle="tooltip" title="Create" data-placement="bottom"><i class="fa fa-plus-circle" aria-hidden="true"></i></button>
        		</div>
        		<div class="textpanel custompanel" style="max-width:300px;height:55px;display:flex;justify-content:center;align-items:center;">
					<p style="word-wrap: break-word;font-size:1.2rem;color:blue;">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="sponsornipdiv"><jsp:include page="sponsornipurchasegrid.jsp"></jsp:include></div>
      		</div>
    	</div>
  </div>
  <input type="hidden" name="empdocno" id="empdocno">
  <input type="hidden" name="rowindex" id="rowindex">
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	
    	
    	 $("#todate").jqxDateTimeInput({
             width: '110px',
             height: '30px',
             formatString:"dd.MM.yyyy",
             dropDownHorizontalAlignment: 'left', // Align dropdown
         });

    	 $('#btncreate').click(function(){         
	    	 funSave();    
	     });
        
    	
        $('[data-toggle="tooltip"]').tooltip();
        
        getInitData();
        $('.load-wrapp').hide();
        
       
        $('#btnsubmit').click(function(){
        	$('.page-loader').show();
        	loadGrid();
        	var brhid=$('#cmbbranch').val();
        	//$('#maingriddiv').load('riderGrid.jsp?id=1&brhid='+brhid);
        });
        
        $('#btnexcel').click(function(){
        	$("#jqxsponsornipgrid").excelexportjs({
				containerid: "jqxsponsornipgrid",
				datatype: 'json',
				dataset: null,
				gridId: "jqxsponsornipgrid",
				columns: getColumns("jqxsponsornipgrid"),
				worksheetName: "Sponsor NI Purchase Data"
			});
        });
    }); 
    	
    function getInitData(){
		$.get('getinitdata.jsp',function(data){
			data=JSON.parse(data);
			var htmldata="";
			$.each(data.branchdata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#cmbbranch').html($.parseHTML(htmldata));
			
		});
	}
    
	function loadGrid(){
		var date = $('#todate').val();
		var brchid=$('#cmbbranch').val();
		if(brchid==null || brchid==0){
			   $('.page-loader').hide();
			   $.messager.show({
                   title: 'Message',
                   msg: 'Select Branch',
                   showType: 'show',
                   style: {
                       left: '',
                       right: 27,
                       top: document.body.scrollTop + document.documentElement.scrollTop,
                       bottom: ''
                   }
               });
			   return false;
		}
		$("#sponsornipdiv").load("sponsornipurchasegrid.jsp?date="+date+"&chk=1");
	}
	
	function funSave(){   
		var date = $('#todate').jqxDateTimeInput('getDate');
		   
		// Format the date to "YYYY-MM-DD"
		var formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0');
		var reftype='DIR';
		var accdoc=null;
		var accname=null;
		var cur=null;
		var rate=null;
		var mode='A';
		var nettotal=0;
		var nettotalval=0;
		var formdetailcode='SNP';
		var billtype='1';
		var invdate=$('#todate').val();
		var cmbbranch=$('#cmbbranch').val();
		if(cmbbranch=='a'){
			swal.fire({
				icon:'warning',
				type: 'warning',
				title: 'Warning',
				text: 'Please Select Branch'
			});
			return false;
		}
		   
	    var rows = $("#jqxsponsornipgrid").jqxGrid('getrows');
		var ordselectedrows = $("#jqxsponsornipgrid").jqxGrid('selectedrowindexes');
		var firstIndex = ordselectedrows[0];
		   //alert('ordselectedrows :'+firstIndex)
		   var lenchk=ordselectedrows.length;
		   if(parseInt(lenchk)==0){
			   swal.fire({
				    icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please Select Documents'
				});
			 return false;
		   }
		   
		 var chk=ordselectedrows[0];
		 var masArray= new Array();
		 var masArrayList= new Array();  // to log all the entries
		 var count=0;
		 var scodearray=new Array();
		 var temp='';
		 var qty='1';
		 var srno='0';
		 var description=null;
		
		 var taxperamt='0.0';
		 var taxamount='0.0';
		 
		 var rowIds = $("#jqxsponsornipgrid").jqxGrid('getrowid', firstIndex);
		 var rowDatas = $("#jqxsponsornipgrid").jqxGrid('getrowdatabyid', rowIds);

		 // Always check before accessing
		 if (!rowDatas) {
		     console.error("Row data not found. Index:", firstIndex);
		     return false;
		 }

		 accdoc = rowDatas.acc_no;
		 accname = rowDatas.vendor;
		 cur = rowDatas.curid;
		 rate = rowDatas.rate;
		 
		 /* accdoc=rows[firstIndex].acc_no;
		 accname=rows[firstIndex].vendor;
		 cur=rows[firstIndex].curid;
		 rate=rows[firstIndex].rate; */
		 
		 
		 let putot = 0;
	     let dotot = 0;
	     let puctot = 0;
	     let doctot = 0;
	     let putotcount = 0;
	     let dototcount = 0;
	     let puctotcount = 0;
	     let doctotcount = 0;
			 
		 for (var i = 0; i < ordselectedrows.length; i++) {
			    var rowIndex = ordselectedrows[i];  // Get the index of the selected row
			    var rowData = $("#jqxsponsornipgrid").jqxGrid('getrowdata', rowIndex);  // Get the row data for the specific index
			    srno=parseInt(srno)+1;
			    // Now, you can access the data from the selected row:
			     let totalrent = 0;
			     let rate = 0;
			     let totaldays=0;
			     description = rowData.empdocno + "-" + rowData.empname + "-" + rowData.vehicletype;
			    if(rowData.vehicletype=='Car'){
			    	totaldays=(new Date(new Date(formattedDate).getFullYear(), new Date(formattedDate).getMonth() + 1, 0).getDate());
			    	rate = parseFloat(rowData.carrate);
			    	totalrent = (parseFloat(rowData.carrate)/parseFloat((new Date(new Date(formattedDate).getFullYear(), new Date(formattedDate).getMonth() + 1, 0).getDate()) )* parseFloat(rowData.daysofwork));
			    	taxperamt = totalrent * parseFloat(rowData.taxper)/ 100;
			    	taxamount = totalrent + parseFloat(taxperamt);
			    	nettotalval=parseFloat(nettotalval) + totalrent ;
			    } else if(rowData.vehicletype=='Motorbike'){
			    	rate = rowData.pickupratebike;
			    	console.log(rate);
			    	putot += parseFloat(rowData.putot);
			    	dotot += parseFloat(rowData.dotot);
			    	puctot += parseFloat(rowData.puctot);
			    	doctot += parseFloat(rowData.doctot);
			    	putotcount += parseInt(rowData.pickupcount);
			    	dototcount += parseInt(rowData.dropoffcount);
			    	puctotcount += parseInt(rowData.pickupcancel);
			    	doctotcount += parseInt(rowData.dropoffcancel);
			    	totalrent = ( parseFloat(rowData.putot)+ parseFloat(rowData.dotot)+ parseFloat(rowData.puctot)+ parseFloat(rowData.doctot))
			    	taxperamt = totalrent * parseFloat(rowData.taxper) / 100;
			    	taxamount = totalrent + parseFloat(taxperamt);
			    	nettotalval=parseFloat(nettotalval)+parseFloat(totalrent);
			    } 
			    // taxperamt = parseFloat(rowData.totalrent) * parseFloat(rowData.taxper) / 100;
			    // taxamount = parseFloat(rowData.totalrent) + parseFloat(taxperamt);
			    // nettotalval=parseFloat(nettotalval)+parseFloat(putot+dotot+puctot+doctot);
			    // Alerts for debugging

			    if (typeof(rowData.vendorid) != 'undefined' && rowData.vendorid !== '' && rowData.vendorid !== null && rowData.vendorid !== "0" && totalrent!==0) {
			    
			    	if(rowData.vehicletype=='Car'){
			    		masArrayList.push(srno+"::"+qty+"::"+description+"::"+totalrent+"::"+totalrent+"::"+"0"+"::"+totalrent+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+taxperamt+"::"+taxamount+"::"+rate+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
				    	masArray.push(srno+"::"+qty+"::"+description+"::"+totalrent+"::"+totalrent+"::"+"0"+"::"+totalrent+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+taxperamt+"::"+taxamount+"::"+rate+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
			    	} else if(rowData.vehicletype=='Motorbike'){
				    	masArrayList.push(srno+"::"+qty+"::"+description+"::"+totalrent+"::"+totalrent+"::"+"0"+"::"+totalrent+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+taxperamt+"::"+taxamount+"::"+rowData.pickupratebike+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
			    	}

			    	if(i==ordselectedrows.length-1){
			    		if(putotcount!=0) masArray.push(srno+"::"+putotcount+"::"+'Pickup'+"::"+rowData.pickupratebike+"::"+putot+"::"+"0"+"::"+putot+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+(putot*parseFloat(rowData.taxper)/100)+"::"+(putot+(putot*parseFloat(rowData.taxper)/100))+"::"+rowData.pickupratebike+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
			    		if(dototcount!=0) masArray.push(srno+"::"+dototcount+"::"+'Dropoff'+"::"+rowData.droppoffratebike+"::"+dotot+"::"+"0"+"::"+dotot+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+(dotot*parseFloat(rowData.taxper)/100)+"::"+(dotot+(dotot*parseFloat(rowData.taxper)/100))+"::"+rowData.droppoffratebike+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
				    	if(puctotcount!=0) masArray.push(srno+"::"+(puctotcount*-1)+"::"+'Pickup Cancel'+"::"+rowData.pickupratebike+"::"+puctot+"::"+"0"+"::"+puctot+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+(puctot*parseFloat(rowData.taxper)/100)+"::"+(puctot+(puctot*parseFloat(rowData.taxper)/100))+"::"+rowData.pickupratebike+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
				    	if(doctotcount!=0) masArray.push(srno+"::"+(doctotcount*-1)+"::"+'Dropoff Cancel'+"::"+rowData.droppoffratebike+"::"+doctot+"::"+"0"+"::"+doctot+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0"+"::"+'2868'+"::"+"0"+"::"+rowData.taxper+"::"+(doctot*parseFloat(rowData.taxper)/100)+"::"+(doctot+(doctot*parseFloat(rowData.taxper)/100))+"::"+rowData.droppoffratebike+"::"+rowData.daysofwork+"::"+totaldays+"::"+rowData.pickupcount+"::"+rowData.dropoffcount+"::"+rowData.pickupcancel+"::"+rowData.dropoffcancel+"::"+rowData.carrate+"::"+rowData.pickupratebike+"::"+rowData.droppoffratebike+"::");
			    	}
			    
			    }
			    nettotal = parseFloat(nettotal) + parseFloat(taxamount);

			}
		 
		 if(masArray.length<=0){
			  swal.fire({
					type: 'warning',
					title: 'Warning',
					icon:'warning',
					text: 'Please Select Valid Documents'
				});
			 return false;
		 }
		   
		   Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to Create Ni Purchase?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.value) {
					 $("#overlay, #PleaseWait").show();
				
					createNIP(masArrayList,masArray,date,accdoc,accname,cur,rate,nettotal,invdate,formattedDate,nettotal);
				}	
					
		        });
		   
	   }
	   
	    function createNIP(masArrayList,masArray, date, accdoc, accname, cur, rate, nettotal, invdate, formattedDate, nettotalval) {
		    var dates = $('#todate').val();
		    var brchid = $('#cmbbranch').val();

		    var x = new XMLHttpRequest();
		    x.onreadystatechange = function () {
		        if (x.readyState == 4 && x.status == 200) {
		            var items = x.responseText;
		            var itemval = items.trim();
		            $("#overlay, #PleaseWait").hide();

		            if (parseInt(itemval) > 0) {
		            	$('.page-loader').show();
		                $("#overlay, #PleaseWait").show();
		                Swal.fire({
		                	icon:'success',
		                    type: 'success',
		                    title: 'Success',
		                    text: 'NIP ' + itemval + ' Successfully Created'
		                });
		                $("#sponsornipdiv").load("sponsornipurchasegrid.jsp?date="+dates+"&chk=1");
		            } else {
		                Swal.fire({
		                	icon:'error',
		                    type: 'error',
		                    title: 'Error',
		                    text: 'Not Created'
		                });
		            }
		        }
		    };

		    // Open the request without parameters in the URL
		    x.open("POST", "createNIP.jsp");

		    // Set the request headers
		    x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

		    // Prepare the data to be sent in the request body
		    const data = new URLSearchParams();
		    data.append("date", formattedDate);
		    data.append("accdoc", accdoc);
		    data.append("accname", accname);
		    data.append("masArray", JSON.stringify(masArray)); // Stringify the array
		    data.append("masArrayList", JSON.stringify(masArrayList)); // Stringify the array
		    data.append("cur", cur);
		    data.append("rate", rate);
		    data.append("nettotal", nettotal);
		    data.append("invdate", invdate);
		    data.append("nettotalval", nettotalval);

		    // Send the request with the data in the body
		    x.send(data);
		}

</script>
</body>
</html>
