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
<link rel="shortcut icon" href="<%=contextPath+"/"%>icons/ink_new_logo_2025.png" >
<title>INK IT Business solutions</title>
<jsp:include page="includes.jsp"></jsp:include>
<link href='http://fonts.googleapis.com/css?family=Mr+Dafoe' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
<link href="css/modern-theme.css" rel="stylesheet" type="text/css">

<script type = "text/javascript">
if (window.performance && window.performance.navigation.type === window.performance.navigation.TYPE_BACK_FORWARD) {
    // User clicked back or forward button, redirect to login or logged-out page
    window.location.href = "login.jsp"; // or logged-out page URL
}
		$(document).ready(function () {
			getDecimal();
			getBackDate();
			getPdcAsCdcDate();
			getCardNumberValidator();
			//getMsgCount();
			funChkMenu();
			getEmployeeBranchChk();
			funChkExport();
			
			/* if($('#roleid').val() =="4"){
				// alert("in")
				$('#frame').attr('src', "com/dashboard/travel/travel/travelnew.jsp");
			} */
			var admingate='<%=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString().trim()%>';
			if(admingate=="999"){
				$('#btnquery').css('display','inline-block');
			}
		$('#windowcp').jqxWindow({width: '45%', height: '36%',  maxHeight: '36%' ,maxWidth: '45%' , title: 'Change Password',position: { x: 130, y: 55 } , theme: 'energyblue', showCloseButton: true});
		    $('#windowcp').jqxWindow('close');

			 $("#menuBody").keydown(function (evt) {
			 if (evt.keyCode == 8) {
				  var d = event.srcElement || event.target;
			        if ((d.tagName.toUpperCase() === 'INPUT' && 
			             (
			                 d.type.toUpperCase() === 'TEXT' ||
			                 d.type.toUpperCase() === 'PASSWORD' || 
			                 d.type.toUpperCase() === 'FILE' || 
			                 d.type.toUpperCase() === 'EMAIL' || 
			                 d.type.toUpperCase() === 'SEARCH' || 
			                 d.type.toUpperCase() === 'DATE' )
			             ) || 
			             d.tagName.toUpperCase() === 'TEXTAREA') {
			            doPrevent = d.readOnly || d.disabled;
			        }
			        else {
			            doPrevent = true;
			        }
			    }
				if(doPrevent) {
			        event.preventDefault();
				}
		}); 
		});
		
		function addTab(title, url){
			if ($('#tt').tabs('exists', title)){
				$.messager.alert('Message','Form Already Exists in Tab.','warning');
				$('#tt').tabs('select', title);
				return;
			} else {
			 
			 var formcode=$('#formCode').val().trim();
				var content = '<iframe scrolling="auto" frameborder="0" data-formname="'+title+'" data-formcode="'+formcode+'"  src="'+url+'"  style="width:100%;height:100%;"></iframe>';	
			// var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
				$('#tt').tabs('add', {
					title:title,
					content:content,
					closable:true
					/* showCloseButtons: true */
				 });
			} 
		}
		
		function addTabWithCode(title, url, formcode){
			if ($('#tt').tabs('exists', title)){
				$.messager.alert('Message','Form Already Exists in Tab.','warning');
				$('#tt').tabs('select', title);
				return;
			} else {
			 
				var content = '<iframe scrolling="auto" frameborder="0" data-formname="'+title+'" data-formcode="'+formcode+'"  src="'+url+'"  style="width:100%;height:100%;"></iframe>';	
			// var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
				$('#tt').tabs('add', {
					title:title,
					content:content,
					closable:true
					/* showCloseButtons: true */
				 });
			} 
		}
		
	function geturl(aa){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		 			document.getElementById("formData").value = x.responseText; 
					var Data = document.getElementById("formData").value;
					//document.getElementById('content2').src = Data.split("$$$$$",1);
					document.getElementById('formName').value = aa;
					document.getElementById('formCode').value = Data.split("$$$$$",2)[1];
					//document.getElementById('Name').innerHTML = aa;
					//makeWindow(Data.split("$$$$$",1),aa,Data.split("$$$$$",2)[1]);
					var url=document.URL;
					var reurl=url.split("login");
					if(Data.split("$$$$$",1)!=""){
						var formcode=Data.split("$$$$$",2)[1].trim();    //  edited 
						//addTab(aa,reurl[0]+Data.split("$$$$$",1));
						addTabWithCode(aa,reurl[0]+Data.split("$$$$$",1),formcode);
					}
				}
			else
				{
				}
		}
		x.open("GET","getPageDetails.jsp?name="+aa,true);
		x.send();
	//document.write(document.getElementById("authname").value);
     }

	function getDecimal(){
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	    var res = x.responseText;
	    res=res.split('####');
	    $('#amtdec').val(res[0]);
	    $('#curdec').val(res[1]);
	   }
	  else
	   {}
	 }
	 x.open("GET","getDecimal.jsp",true);
	 x.send();
	}
	
	function getBackDate(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#backdateallowed').val(items);
  		}
  		}
  		x.open("GET", "getBackDateAllowed.jsp", true);
  		x.send();
      }
	function getEmployeeBranchChk(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#employeebranchchk').val(items);  
  		}
  		}
  		x.open("GET", "getEmployeeBranchChk.jsp", true);
  		x.send();
      }
	function funChkExport(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#chkexportdata').val(items);
  		}
  		}
  		x.open("GET", "chkexportdata.jsp", true);
  		x.send();
      }
	
	
	
	
	  
	  function getPdcAsCdcDate(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#pdcascdcdateallowed').val(items);
  		}
  		}
  		x.open("GET", "getPdcAsCdcDateAllowed.jsp", true);
  		x.send();
      }
	  
	  function getCardNumberValidator(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#cardnumbervalidator').val(items);
  		}
  		}
  		x.open("GET", "getCardNumberValidator.jsp", true);
  		x.send();
      }

	 function funexit(){
		$.messager.confirm('Confirm', 'Do you Want To Quit Application?', function(result){
			if (result){
				window.close();
			 }
		   });
	 }
	 
	  /* window.setInterval(function(){
		   funSession();
		   }, 5000); */ 
		   
   function funSession(){
     var x = new XMLHttpRequest();
     x.onreadystatechange = function() {
      if (x.readyState == 4 && x.status == 200) {
       var item=x.responseText.trim();
      if(item=="1"){
      window.location.href="<%=contextPath+"/"%>sessionout.jsp";
      
      }
     }
    }
     x.open("GET", "<%=contextPath+"/"%>getSessionDetails.jsp", true);
     x.send();   
   }


function funSendEmail(){
				
				
				<%-- emailSearchContent("<%=contextPath%>/com/email/EmailFrom.jsp"); --%>
				window.open("<%=contextPath%>/com/email/Email.jsp","E-Mail","menubar=0,resizable=1,width=900,height=525 ");
			
		}
		
function funSendSms(){
			
			window.open("<%=contextPath%>/com/sms/Sms.jsp","SMS","menubar=0,resizable=1,width=500,height=325 ");
		
	}
		
		
function funMsngr(){
			
			window.open("<%=contextPath%>/com/messenger/chatForm.jsp","Messenger","menubar=0,resizable=1,width=800,height=525 ,top=100, left=260");
		
	}


function funSupport(){
	
	var userid='<%=session.getAttribute("USERID").toString().trim()%>';
	var username='<%=session.getAttribute("USERNAME").toString().trim()%>';
	var compname='<%=session.getAttribute("COMPANYREFID").toString().trim()%>';
	
	
	window.open("http://gate-way.dyndns.org:8889/GateWay/com/support/supportCenterForm.jsp?userfrmid="+userid+"&username="+username+"&compname="+compname+"","Support","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");

}

function funQueryBuilder(){
	var userid='<%=session.getAttribute("USERID").toString().trim()%>';
	var username='<%=session.getAttribute("USERNAME").toString().trim()%>';
	var compname='<%=session.getAttribute("COMPANYREFID").toString().trim()%>';
	
	window.open("com/querybuilder/index.jsp","Query Builder","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");
	
}

		
function getMsgCount()
			{


			var x=new XMLHttpRequest();
			var msgcnt;
			var user;
			x.onreadystatechange=function(){
				
				if (x.readyState==4 && x.status==200)
					{
					
						items= x.responseText;
					
						items=items.split('####');
						user=items[0];
						msgcnt=items[1];
							if(msgcnt>0){
								$('#iconnm').hide();
								$('#iconym').show();
							}
							else{
								$('#iconym').hide();
								$('#iconnm').show();
							}
						
					    
					}
				else
					{
					}
			}
			x.open("GET","getMsgCount.jsp",true);
			x.send();
			}
	
		function funChkMenu(){
			
			
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					items = items.split('##');
					var email  = items[0].split(",");
					var sms = items[1].split(",");
					var support  = items[2].split(",");
					var approve = items[3].split(",");
					var msngr = items[4].split(",");
					var passchnge = items[5].split(",");
					var user = items[6].split(",");
				
					//alert("==email==="+email+"===sms==="+sms+"==approve==="+approve+"==support="+support);
					
			if(parseInt(email)==0)
				{		
					$("#email").attr('disabled', true ); 
			    }
			if(parseInt(sms)==0)
			   {
			      //  $("#sms").attr('disabled', true );
			   }
			if(parseInt(approve)==0)
			   {
				    $("#approve").attr('disabled', true );
			   } 
			if(parseInt(support)==0)
			   {
				    $("#support").attr('disabled', true );
				  
			   }
			
			if(parseInt(msngr)==0)
			   {
				    $("#iconym").attr('disabled', true );
				    $("#iconnm ").attr('disabled', true );
				  
			   } 
			
			if(parseInt(passchnge)==0)
			   {
				    $("#passchange ").attr('disabled', true );
				  
			   } 
			
			if(parseInt(user)==0)
			   {
				    $("#user").attr('disabled', true );
				  
			   } 
			
			 			
			}else {}
			}
			
			x.open("GET",<%=contextPath+"/"%>+"chkmainmenu.jsp",true);
			x.send();
		
		
		}


		   

		function funApprove(){
	
	var userid='<%=session.getAttribute("USERID").toString().trim()%>';
	var username='<%=session.getAttribute("USERNAME").toString().trim()%>';
	var compname='<%=session.getAttribute("COMPANYREFID").toString().trim()%>';
	
	 top.addTab( 'Executive Folio',"<%=contextPath%>/com/common/executiveFolioNew.jsp");
	
	<%--  window.open("<%=contextPath%>/com/common/approvalForm.jsp","Approval Form","menubar=0,resizable=1,width=350,height=380 ,top=100, left=260"); --%>
}


function funchgpass(){
				 $("#windowcp").jqxWindow('setTitle','<%=session.getAttribute("USERNAME")%>'+" - "+'<%=session.getAttribute("BRANCHID")%>');
				var brch='<%=session.getAttribute("BRANCHID")%>';
				var userid='<%=session.getAttribute("USERID")%>';
				
				changePassword("<%=contextPath%>/com/common/changePassword.jsp?userid="+userid+"&branchid="+brch);	
			
		}

function changePassword(url) {
			$.get(url).done(function (data) {
				    $('#windowcp').jqxWindow('open');
					$('#windowcp').jqxWindow('setContent',data);
					$('#windowcp').jqxWindow('bringToFront');
		}); 
		}
 
function  funHelp(){
	window.open("Help_Fahim.htm","Help","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");
}
function funClear(){
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	    var res = x.responseText;
	    console.log(res);
	   }
	  else
	   {}
	 }
	 x.open("GET","getClear.jsp",true);
	 x.send();
	}
</script>

<style>

/*Messenger Image*/

.animated {
  animation-duration: 2.5s;
  animation-fill-mode: both;
  animation-iteration-count: infinite;
}

@keyframes wobble {
  0% {transform: translateX(0%);}
  15% {transform: translateX(-25%) rotate(-5deg);}
  30% {transform: translateX(20%) rotate(3deg);}
  45% {transform: translateX(-15%) rotate(-3deg);}
  60% {transform: translateX(10%) rotate(2deg);}
  75% {transform: translateX(-5%) rotate(-1deg);}
  100% {transform: translateX(0%);}
}
.wobble {
  animation-name: wobble;
}
/*Messenger Image Ends*/

@font-face {
	font-family: myriad pro;
    src: local('Myriad Pro'), url('../fonts/Myriad-Pro-Black-Italic_31618.ttf)') format('truetype'); 
}

  #menuBody {
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    font-size: 12px;
	width: 100%;
	height: 100%;
	background: #f1f5f9;
}
 
 #HeadIcons {
	width: 100%;
	height: auto;
	padding: 0;
	margin: 0;
	background: transparent;
}

select{
   font-size: 10px;
   background-color: #FFFFFF;
   border: 1px solid #ccc;
   height: 15px;
   padding: 0px; 
   -webkit-border-radius: 5px;
   -moz-border-radius: 5px;
   border-radius: 5px;
   
}
option{
    height:12px;
    font-size:9px;
}

#icon {
    background-color: #f0f0f0;
	width: 3em;
	height: 2em;
	border: none;
}

#iconym {
    background-color: #f0f0f0;
	width: 3em;
	height: 2em;
	border: none;
}

#iconnm {
    background-color: #f0f0f0;
	width: 3em;
	height: 2em;
	border: none;
}

#icon1 {
    background-color: #f0f0f0;
	width: 3em;
	height: 2em;
	border: none;
    float: right; 
}
label{
   cursor: default;
}

.company{
   /*font-size: 13px;
   font-family: myriad pro;
   font-style: bold;
   color: red;
   width:auto;*/
   
   font-size: 13px;
   font-family: myriad pro;
   font-style: bold;
   -webkit-box-sizing: content-box;
   -moz-box-sizing: content-box;
   box-sizing: content-box;
   margin: 0 auto;
   border: none;
   color: red;
   text-align: center;
   text-transform: uppercase;
   -o-text-overflow: clip;
   text-overflow: clip;
   letter-spacing: 3px;
   text-shadow: 0px 0px 0 rgba(249,162,162,1) , 1px 1px 0 red;
   -webkit-transform: rotateX(1.7188733853924696deg) rotateY(1.7188733853924696deg);
   transform: rotateX(1.7188733853924696deg) rotateY(1.7188733853924696deg);
  
}

label.space{
    width:auto;
    padding-right: 8%;
}

label.user1{
    /*font-size: 12px;
    font-family: Tahoma;
    font-style: italic;
    color: blue;
    width:auto;
    padding-right: 4%;*/
	
   font-family: Mr Dafoe, sans-serif;
   font-size: 14px;
   color: blue;
   text-align: center;
   text-transform: capitalize;
   width:auto;
   padding-right: 4%;
   letter-spacing: 1px; 
   text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.9), 0 1px 0 #E5E8E8, 0 2px 0 #E5E8E8, 0 3px 0 #E5E8E8, 0 4px 0 #E5E8E8, 0 5px 0 #E5E8E8, 0 6px 0 #E5E8E8, 0 7px 0 #E5E8E8, 0 8px 0 #E5E8E8, 0 9px 0 #E5E8E8, 0 10px 0 #E5E8E8, 0 11px 0 #E5E8E8, 0 12px 0 #E5E8E8, 0 13px 0 #E5E8E8, 0 14px 0 #E5E8E8, 0 15px 0 #E5E8E8, 0 22px 30px rgba(0, 0, 0, 0.9);
}
label.user{
    font-size: 12px;
    font-family: Tahoma;
    font-style: normal;
    width:auto;
    padding-right: 1%;
}

label.logTime{
   font-size: 12px;
   font-family: Tahoma;
   font-style: normal;
   width: auto; 
   padding-right: 6%;
}

label.period{
   font-size: 12px;
   font-family: Tahoma;
   font-style: normal;
   width: auto;
   padding-right: 1%;
}

label.period1{
   font-size: 12px;
   font-family: Tahoma;
   font-style: normal;
   width: auto;
   padding-right: 1%;
}

.bicon {
    background-color: #f0f0f0;
	width: 3em;
	height: 2em;
	border: none;
}

a:link {
    text-decoration: none;
 color: #000000;
}

a:visited {
    text-decoration: none;
 color: #000000;
}


button.bicon:disabled { opacity: 0.5; };
button.iconym:disabled { opacity: 0.5; };
button.iconnm:disabled { opacity: 0.5; };

label.licenceExpiry{
	text-align:center;
	font-size:13px;
	 font-style: bold;
	-webkit-transition-property: background;
	-webkit-transition-duration: 3s;
	-webkit-transition-timing-function: ease-out;
	background: -webkit-linear-gradient(left,  rgba(255,0,0,1) 0%,rgba(255,0,0,1) 99%); 
	-webkit-background-clip: text;
	color:transparent;
}
	
label.licenceExpiry:hover{
	-webkit-transition-property: background;
	-webkit-transition-duration: 2s;
	-webkit-transition-timing-function: ease-out;
	-webkit-text-stroke: 1px rgba(255,255,255,1);
	background: -webkit-linear-gradient(left,  rgba(255,0,0,1) 0%,rgba(255,255,0,1) 19%,rgba(0,255,0,1) 38%,rgba(0,255,255,1) 51%,rgba(0,0,255,1) 67%,rgba(255,0,255,1) 83%,rgba(255,0,0,1) 99%); /* Chrome10+,Safari5.1+ */
	-webkit-background-clip: text;
	color:transparent;
	background-position:-500px;
}
body::-webkit-scrollbar {
	width: 0px;
}
.jqx-widget-header {
    background: #e8e8e8 !important;
    border-color: #c5c5c5 !important;
    color: inherit !important;
}

.jqx-menu-item-top {
    color: inherit !important;
    font-weight: normal !important;
    font-size: 13px !important;
    padding: 3px 6px 3px 6px !important;
    border-radius: 0px !important;
    margin: 0px 1px 0px 1px !important;
}

.jqx-menu-item-top-hover {
    background: #e8e8e8 !important;
    color: inherit !important;
    border-radius: 0px !important;
}

.jqx-menu-item-top-selected {
    background: #e8e8e8 !important;
    color: inherit !important;
    border-radius: 0px !important;
}

.jqx-menu-dropdown {
    background: #ffffff !important;
    border: 1px solid #c5c5c5 !important;
    border-radius: 0px !important;
    box-shadow: none !important;
    padding: 2px !important;
}

.jqx-menu-item {
    color: inherit !important;
    font-size: 13px !important;
    padding: 3px 6px 3px 6px !important;
    border-radius: 0px !important;
    margin: 1px 3px !important;
}

.jqx-menu-item-hover {
    background: #e8e8e8 !important;
    color: inherit !important;
    border-radius: 0px !important;
}

.jqx-menu-item-selected {
    background: #e8e8e8 !important;
    color: inherit !important;
    border-radius: 0px !important;
}

.jqx-menu-item-separator {
    background-color: #ddd !important;
    margin: 1px 2px !important;
}
</style>
</head>
<!-- style="overflow:;  onload="getBrchCurr();" -->
<body id="menuBody" >
<div id="mainBG" class="homeContent" data-type="background" style='margin-top:0px; width: 100%;'>
<!-- <div id='content'> -->
        <script type="text/javascript">
            $(document).ready(function () {
                // Create a jqxMenu
                $("#jqxMenu").jqxMenu({ width: '100%', height: '20', mode: 'horizontal', showTopLevelArrows: true});
                // Set up the open directions.
                $("#jqxMenu").css('visibility', 'hidden');
                
            });
			
			function funAutoSalik(){
				var testurl="http://localhost:8998/CarRental/autoDownload.jsp";
				var produrl="http://gatewayerp.fortiddns.com:8880/FASTTRACKAUTO/autoDownload.jsp";
            	window.open(testurl,"Auto Download","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");
            }
        </script>
        <div>
        
         <div id='jqxMenu' style="visibility: hidden;display:none;margin-top:-9px;margin-left:-8px;">
			<ul >
				<s:iterator var="first" status="status" value="%{#request.MenuMap}">
					<li><s:property value="key"></s:property>
						<ul>
							<s:iterator var="second" status="status1" value="%{#first.getValue()}">
								<a href="#" onClick="geturl('<s:property value='key'/>')">
								<li>
									 
									<s:property value='key'></s:property>
									<ul>
										<s:iterator var="al" status="status1" value="%{#second.getValue()}">
											<a href="#" onClick="geturl('<s:property value='key'/>')">
											<li>
												<label> <s:property value='key'></s:property>	 </label>
													
														<ul>
															<s:iterator var="al1" status="status1" value="%{#al.getValue()}">
																
																<a href="#"	onClick="geturl('<s:property value='al1'/>')">
																<label><li>
																	 <s:property value='al1' />
																</li>
																</label>
																</a>
															
															</s:iterator>
														 	</ul>
														<%-- <a href="#" onClick="geturl('<s:property value='al'/>')"> <s:property value='al'/></a> --%>
											</li> </a>
										</s:iterator>
									</ul>
								</li></a>
							</s:iterator>
						</ul></li>
				</s:iterator>

					<b><font class="company"><%=session.getAttribute("COMPANYNAME") %></font></b>
			</ul>
			
			</div>
		
        
    
		<!-- MODERN TOP BAR -->
		<div id="HeadIcons" style="width:100%;margin:0;padding:0;">
		<style>
		#modern-topbar {
			display: flex;
			align-items: center;
			justify-content: space-between;
			background: #1e293b;
			padding: 0 16px;
			height: 46px;
			width: 100%;
			box-sizing: border-box;
		}
		#modern-topbar .tb-left {
			display: flex;
			align-items: center;
			gap: 4px;
		}
		#modern-topbar .tb-right {
			display: flex;
			align-items: center;
			gap: 12px;
		}
		.tb-btn {
			display: inline-flex;
			align-items: center;
			gap: 5px;
			padding: 5px 11px;
			border: none;
			background: transparent;
			color: #94a3b8;
			font-size: 11.5px;
			font-weight: 500;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			border-radius: 6px;
			cursor: pointer;
			transition: background 0.15s, color 0.15s;
			white-space: nowrap;
		}
		.tb-btn:hover { background: rgba(255,255,255,0.08); color: #f1f5f9; }
		.tb-btn:disabled { opacity: 0.35; cursor: not-allowed; }
		.tb-btn svg { width: 14px; height: 14px; fill: currentColor; flex-shrink: 0; }
		.tb-divider {
			width: 1px; height: 22px;
			background: rgba(255,255,255,0.1);
			margin: 0 4px;
		}
		.tb-company-label {
			font-size: 13px;
			font-weight: 700;
			color: #f1f5f9;
			letter-spacing: 0.5px;
			padding: 0 8px;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			text-transform: uppercase;
		}
		.tb-user-block {
			display: flex;
			align-items: center;
			gap: 10px;
			padding: 4px 10px;
			background: rgba(255,255,255,0.06);
			border-radius: 8px;
		}
		.tb-avatar {
			width: 28px; height: 28px;
			background: #2563eb;
			border-radius: 50%;
			display: flex; align-items: center; justify-content: center;
			font-size: 11px; font-weight: 700; color: #fff;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			flex-shrink: 0;
		}
		.tb-user-info { display: flex; flex-direction: column; }
		.tb-username {
			font-size: 12px; font-weight: 600;
			color: #f1f5f9;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			line-height: 1.2;
		}
		.tb-period {
			font-size: 10px; color: #64748b;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			line-height: 1.2;
		}
		.tb-logout-btn {
			display: inline-flex; align-items: center; gap: 5px;
			padding: 5px 12px;
			background: rgba(239,68,68,0.1);
			border: 1px solid rgba(239,68,68,0.3);
			color: #fca5a5;
			border-radius: 6px;
			font-size: 11.5px; font-weight: 600;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			cursor: pointer; transition: all 0.15s;
		}
		.tb-logout-btn:hover { background: rgba(239,68,68,0.2); color: #fecaca; }
		.tb-logout-btn svg { width: 13px; height: 13px; fill: currentColor; }
		.tb-licence {
			font-size: 10px; color: #f59e0b;
			font-family: 'Inter','Segoe UI',Arial,sans-serif;
			font-weight: 600;
		}
		/* keep hidden messenger buttons with IDs the JS needs */
		#iconym, #iconnm { display: none !important; }
		</style>

		<div id="modern-topbar">
			<!-- LEFT: company label + action buttons -->
			<div class="tb-left">
				<span class="tb-company-label"><%=session.getAttribute("COMPANYNAME") %></span>
				<div class="tb-divider"></div>

				<button type="button" class="tb-btn" id="approve" title="Executive Folio" onclick="funApprove()">
					<svg viewBox="0 0 20 20"><path d="M7.629 15.314l-4.71-4.71 1.414-1.415 3.296 3.296 8.042-8.042 1.414 1.414z"/></svg>
					Approvals
				</button>

				<button type="button" class="tb-btn" id="email" title="Send E-Mail" onclick="funSendEmail()">
					<svg viewBox="0 0 20 20"><path d="M2 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4zm2 0v.511l6 4.8 6-4.8V4H4zm0 2.489V16h12V6.489l-6 4.8-6-4.8z"/></svg>
					E-Mail
				</button>

				<button type="button" class="tb-btn" id="sms" title="Send SMS" onclick="funSendSms()">
					<svg viewBox="0 0 20 20"><path d="M2 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H9l-4 3v-3H4a2 2 0 0 1-2-2V4zm5 3a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm3 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm3 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/></svg>
					SMS
				</button>

				<button type="button" class="tb-btn" id="support" title="Support Center" onclick="funSupport()">
					<svg viewBox="0 0 20 20"><path d="M10 2a8 8 0 1 0 0 16A8 8 0 0 0 10 2zm0 14a6 6 0 1 1 0-12 6 6 0 0 1 0 12zm-.75-5h1.5v4h-1.5v-4zm0-6h1.5v4h-1.5V5z"/></svg>
					Support
				</button>

				<button type="button" class="tb-btn" id="passchange" title="Change Password" onclick="funchgpass()">
					<svg viewBox="0 0 20 20"><path d="M10 2a4 4 0 0 0-4 4v1H5a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-1V6a4 4 0 0 0-4-4zm0 2a2 2 0 0 1 2 2v1H8V6a2 2 0 0 1 2-2zm0 7a2 2 0 1 1 0 4 2 2 0 0 1 0-4z"/></svg>
					Password
				</button>

				<button type="button" class="tb-btn" id="btnsalik" title="Auto Salik" onclick="funAutoSalik()">
					<svg viewBox="0 0 20 20"><path d="M10 2a8 8 0 1 0 0 16A8 8 0 0 0 10 2zm0 2a6 6 0 1 1 0 12A6 6 0 0 1 10 4zm0 2a4 4 0 0 0-4 4h2a2 2 0 1 1 4 0h2a4 4 0 0 0-4-4z"/></svg>
					Salik
				</button>

				<button type="button" class="tb-btn" id="btnquery" title="Query Builder" onclick="funQueryBuilder()" style="display:none;">
					<svg viewBox="0 0 20 20"><path d="M3 4h14v2H3V4zm0 4h14v2H3V8zm0 4h8v2H3v-2z"/></svg>
					Query
				</button>

				<button type="button" class="tb-btn" id="qa" title="Quit Application" onclick="funexit()">
					<svg viewBox="0 0 20 20"><path d="M14.348 5.652l-1.414-1.414L10 7.172 7.066 4.238 5.652 5.652 8.586 8.586 5.652 11.52l1.414 1.414L10 10l2.934 2.934 1.414-1.414L11.414 8.586z"/></svg>
					Quit
				</button>

				<!-- hidden messenger buttons – IDs kept for JS compatibility -->
				<button id="iconym" class="animated wobble" title="Messenger" onclick="funMsngr()"><img alt="Messenger" src="icons/chat3.png"></button>
				<button id="iconnm" title="Messenger" onclick="funMsngr()"><img alt="Messenger" src="icons/chat1.png"></button>
				<button id="icon" name="clear" title="Data Clear" onclick="funClear()" style="display:none;"><img alt="Data Clear" src="icons/clear.png"></button>
			</div>

			<!-- RIGHT: period + user info + logout -->
			<div class="tb-right">
				<span class="tb-licence"><b><%=session.getAttribute("ERA") %></b></span>
				<div class="tb-user-block">
					<div class="tb-avatar"><%=session.getAttribute("USERNAME").toString().trim().substring(0,1).toUpperCase()%></div>
					<div class="tb-user-info">
						<span class="tb-username"><%=session.getAttribute("USERNAME")%></span>
						<span class="tb-period">Period: <input type="text" id="txtaccountperiodfrom" name="txtaccountperiodfrom" readonly value='<%=session.getAttribute("STYEAR")%>' style="border:none;background:transparent;color:#64748b;font-size:10px;width:62px;padding:0;"> – <input type="text" id="txtaccountperiodto" name="txtaccountperiodto" readonly value='<%=session.getAttribute("EDYEAR")%>' style="border:none;background:transparent;color:#64748b;font-size:10px;width:62px;padding:0;"></span>
					</div>
				</div>
				<button class="tb-logout-btn" title="Logout" onclick="location.href='logout';">
					<svg viewBox="0 0 20 20"><path d="M3 3h8v2H5v10h6v2H3V3zm10.293 4.293l3 3a1 1 0 0 1 0 1.414l-3 3-1.414-1.414L13.586 11H7V9h6.586l-1.707-1.707 1.414-1.414z"/></svg>
					Logout
				</button>
			</div>
		</div>
		</div>
		<!-- END MODERN TOP BAR -->
	</div>
			
</div>
<input type="hidden" id="formData" />
<input type="hidden" id="formName" />
<input type="hidden" id="formCode" />
<input type="hidden" id="branchid" />
<input type="hidden" id="mode" />
<input type="hidden" id="employeebranchchk" name="employeebranchchk"/>    
<input type="hidden" id="backdateallowed" name="backdateallowed" value='<s:property value="backdateallowed"/>' />
<input type="hidden" id="pdcascdcdateallowed" name="pdcascdcdateallowed" value='<s:property value="pdcascdcdateallowed"/>' />
<input type="hidden" id="cardnumbervalidator" name="cardnumbervalidator" value='<s:property value="cardnumbervalidator"/>' />
<input type="hidden" id="monthclosed" name="monthclosed" value='<s:property value="monthclosed"/>' />
<input type="hidden" name="formcurrencytype" id="formcurrencytype" value='<s:property value="formcurrencytype"/>' />
<input type="hidden" id="curdec" name="curdec" value='<s:property value="curdec"/>' />
<input type="hidden" id="amtdec" name="amtdec" value='<s:property value="amtdec"/>' />
<input type="hidden" id="chkexportdata" name="chkexportdata" value='<s:property value="chkexportdata"/>' />
<input type="hidden" id="roleid" name="roleid" value='<s:property value="roleid"/>' />

 
 <div id="tt" class="easyui-tabs" style="width:100%;height:100%;margin-left:-8px;" >

     <div title="New Home">
         <iframe scrolling="auto" frameborder="0" id="frame" src="com/dashboard/dashBoardTiles.jsp" style="width:100%;height:100%;"></iframe>
     </div>

<div title="New Home 1">
         <iframe scrolling="auto" frameborder="0" id="frame2" src="com/dashboard/dashboardtiels2.jsp" style="width:100%;height:100%;"></iframe>
     </div>

 <div title="Home">
		<iframe scrolling="auto" frameborder="0" id="frame" src="com/dashboard/dashBoard.jsp" style="width:100%;height:100%;"></iframe>
		</div>


 </div>
<div id="windowcp">
	<div></div>
</div>
 
</body>
</html> 
