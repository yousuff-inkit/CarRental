<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<%-- <meta http-equiv="refresh" content="${pageContext.session.maxInactiveInterval};url=<%=contextPath%>/sessionout.jsp" /> --%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="HandheldFriendly" content="true">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" >
<title>Gateway ERP(Integrated) Copyright &#169; 2017 GW INNOVATIONS PVT. LTD.</title>
<jsp:include page="includes.jsp"></jsp:include>
<link href="vendors/bootstrap-v3/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="js/sweetalert2.all.min.js"></script>
<style type="text/css">
	@keyframes blink {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
    }
    
    .curdownload{
    	animation:blink 1s infinite;
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
</style>
<script type = "text/javascript">
	$(document).ready(function () {
		var interval=setInterval(function() {getAutoDownloadCount();},3000);
		$.post('triggerAutoDownload.jsp',function(data,status){
			data=JSON.parse(data);
			clearInterval(interval);
			$('.load-wrapp').hide();
			if(data.errorstatus=="0"){
				//$.messager.alert('Message','Auto Download completed');
				Swal.fire({
					icon:'info',
					title: 'Message',
					text: 'Auto Download completed'
				});
            }
            else{
            	//$.messager.alert('Warning','Auto Download failed');
            	Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Auto Download Failed'
				});
            	return false;
            }
		});
		
		
	});
	
	function getAutoDownloadCount(){
		$.post('getAutoDownloadCount.jsp',function(data,status){
			console.log(data);
			data=JSON.parse(data);
			var salikhtml="",traffichtml="";
			$('.curdownload').text(data.curdownload);
			if(data.salikdata.length>0){
				//htmldata+='<table class="table">';
				$.each(data.salikdata,function(index,value){
					salikhtml+='<tr>';
					salikhtml+='<td style="width:75%;">'+value.user+'</td>';
					salikhtml+='<td style="width:25%;">'+value.itemcount+'</td>';
					salikhtml+='</tr>';
				});
				//htmldata+='</table>';
				$('#tblsalik tbody').html($.parseHTML(salikhtml));
			
			}
			if(data.trafficdata.length>0){
				//htmldata+='<table style="width:100%;border:1px solid #000;">';
				$.each(data.trafficdata,function(index,value){
					traffichtml+='<tr>';
					traffichtml+='<td style="width:75%;">'+value.user+'</td>';
					traffichtml+='<td style="width:25%;">'+value.itemcount+'</td>';
					traffichtml+='</tr>';
				});
				//htmldata+='</table>';
				$('#tbltraffic tbody').html($.parseHTML(traffichtml));
			}
			
		});
	}
</script>
</head>
<!-- style="overflow:;  onload="getBrchCurr();" -->
<body id="menuBody" >
<div id="mainBG" class="homeContent" data-type="background" style='margin-top:0px; width: 100%;'>
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 table-responsive">
				<table class="table" id="tblmain">
					<tbody>
						<tr>
							<td colspan="2" align="center">Currently Downloading <span class="curdownload"></span></td>
						</tr>
						<tr>
							<td>
								<table class="table" id="tblsalik">
									<thead>
										<tr><th width="75%">Salik User</th><th width="25%">Count</th></tr>
									</thead>
									<tbody></tbody>
								</table>
							</td>
							<td>
								<table class="table" id="tbltraffic">
									<thead>
										<tr><th width="75%">Traffic User</th><th width="25%">Count</th></tr>
									</thead>
									<tbody></tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
</div>
</body>
</html> 
