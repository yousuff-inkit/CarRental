<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Distribution Mapping</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css"> -->
<link rel="stylesheet" type="text/css" href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../../../../vendors/select2/select2.min.css">
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<link href="../../../../vendors/sweetalert/sweetalert2.min.css" rel="stylesheet">
<script src="../../../../vendors/select2/select2.min.js"></script>
<script src="../../../../vendors/cookie/cookie.min.js"></script>
<style type="text/css">
  
   .select2-selection--single {
    width: 100%;
}
   .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: none;
         margin-top: 5px;
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
    
     .custompanel3{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
      font-size:15px;
    }
    .custompanel1{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 7px; 
      margin-bottom: 7px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
      height:55px;
    }
    
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 7px; 
      margin-bottom: 7px;
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 17px;
      padding-bottom: 10px;
      border-radius: 8px;
      height:55px;
    }
    .custompanel2{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
      font-size:15px;
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
    
    .hidden-scrollbar{
    height: 82vh;
    overflow-x: hidden;

}
  </style>

  
<script type="text/javascript">
$(document).ready(function(){
	$('#cmbtype').select2();  
	 getaccounts();
	 
	 
	 $('#btnsubmit').click(function(){
			funload();
		});
	 
	 $('#btnupdate').click(function(){
		 
		    var rows = $("#jqxdistmapgrid").jqxGrid('getrows');
			  var lenchk=rows.length;
			   if(parseInt(lenchk)==0){
				   swal.fire({
						type: 'warning',
						title: 'Warning',
						text: 'Please Select Documents !'
					});
				 return false;
			   }
		    	 
			   
			   var rows1 = $("#jqxdistmapgrid").jqxGrid('getselectedrowindexes');
			    var lenchks=rows1.length;
				if(parseInt(lenchks)==0){
					   swal.fire({
							type: 'warning',
							title: 'Warning',
							text: 'Please Select Atleast One Documents !'
						});
					 return false;
				   }
				   
				   
			updatesave();
		});
	 
	   $('#btnexcel').click(function(){    
		   
		   
		    var rows = $("#jqxdistmapgrid").jqxGrid('getrows');
			  var lenchk=rows.length;
			   if(parseInt(lenchk)==0){
				   swal.fire({
						type: 'warning',
						title: 'Warning',
						text: 'Please Select Documents !'
					});
				 return false;
			   }
		   
	         $("#distmapgrid").excelexportjs({
				containerid: "distmapgrid",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxdistmapgrid",
				columns: getColumns("jqxdistmapgrid") ,   
				worksheetName:"Distribution Mapping"       
			});    
      });
});
	
	
	function getaccounts() {
	    var x = new XMLHttpRequest();
	    var items, currIdItems, currCodeItems;
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	            items = x.responseText;
	            items = items.split('####');
	            currIdItems = items[0].split(",");
	            currCodeItems = items[1].split(",");
              // alert(items)
	           // var optionscurr = '<option value="">--Select--</option>';
	           var optionscurr = '';
	           for (var i = 0; i < currCodeItems.length; i++) {
	                optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
	            }
	            $("select#cmbtype").html(optionscurr);
	           
	        } else {}

	    
	    }
	    x.open("GET", "getaccounts.jsp", true);
	    x.send();
	}	


	function funload(){
	    var chk="1";
		var type=$("#cmbtype").val();
		$('.load-wrapp').show();
   $('#distmapgrid').load("distributionmappingGrid.jsp?chk="+chk+"&type="+type);
	  
}
	
	function updatesave(){
		 
		  Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to Update?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.value) {
					 $('.load-wrapp').show();
				
					 funupdate();
				}	
					
		       });
		
	}
	
	function funupdate(){
		 $('#jqxdistmapgrid').jqxGrid('clearfilters');

		  var rows=$("#jqxdistmapgrid").jqxGrid('getrows');
		  
		   var chksize=rows.length;
		   var ordselectedrows = $("#jqxdistmapgrid").jqxGrid('getselectedrowindexes');
			  

		   var count=0;
		   var chkcount=0; 
		   for(var j=0;j<rows.length;j++){
				 
				    var chkval=rows[j].rowchng;
				    if(parseInt(chkval)>0){
						   count=parseInt(count)+1;
					   }  
				    
		   }
		   
		   if(parseInt(count)==0){
			   $('.load-wrapp').hide();
				   
				  swal.fire({
						type: 'warning',
						title: 'Warning',
						text: 'Make Changes and Try Again !'
					});
		return false;
				   
			   }
		   
		   
		   var docss="";
			  for(var j=0;j<ordselectedrows.length;j++){
				  var chk=ordselectedrows[j];
				  if(parseInt(j)==0){
					  docss=$('#jqxdistmapgrid').jqxGrid('getcellvalue', chk, "docno");
				  }
				  else{
					  docss=docss+","+$('#jqxdistmapgrid').jqxGrid('getcellvalue', chk, "docno");
				  }
				
			  }
		   
		   for(var i=0;i<rows.length;i++){
			   var grdArray=new Array();
			   var chkval=rows[i].rowchng;
			   if(parseInt(chkval)>0){
				   
				   chkcount=parseInt(chkcount)+1;
				   grdArray.push(rows[i].docno+" :: "+rows[i].br1+" :: "+rows[i].br2+" :: "+rows[i].br3+" :: "+rows[i].br4+" :: "+rows[i].br5+" :: ")
				      
				   save(grdArray,chkcount,count,docss);
					  
			   }
				  
		   }
		   
	   }   
		   
		   
	function save(grdArray,chkcount,count,docss){
		  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) 
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				 	 $('.load-wrapp').hide();
	     if(parseInt(itemval)>0)
	     	{
				 //alert("itemval=="+itemval);	 	
				 if(parseInt(chkcount)==parseInt(count)){
					  
							 	 	
								     Swal.fire({
						   					type: 'success',
						   				  	title: 'Success',  
						   				  	text: ' Successfully Saved '
						   				});
				   }
				 funload();	
			}
		else
			{
			swal.fire({
				type: 'warning',
				title: 'Warning',
				text: ' Not Saved '
			});		
			}  
		}
	}  
		grdArray=(grdArray);
	x.open("POST","savedata.jsp?list="+encodeURIComponent(grdArray)+"&docss="+docss);
		x.send();
	}	   
		   

	</script>

</head>
<!-- <body onload="getBranch();"> -->
<body>
<div class='hidden-scrollbar'>
<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    
    
     <div class="primarypanel custompanel padding-top">
        
       <table> 
       
     <tr>
    <td><label class="branch">Accounts : </label>&nbsp;<select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>' style="width:170px;"></select>
     </tr>
     
 </table></div>
   
    <div class="primarypanel custompanel1">
   
     	<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button> 
        <button type="button" class="btn btn-default" id="btnupdate" data-toggle="tooltip" title="Update"  data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true"></i></button>
      
    </div>  
   
    <br>
  
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="distmapgrid"><jsp:include page="distributionmappingGrid.jsp"></jsp:include></div>
      </div>
      </div>
      
     </div> 
        </body>
</html>