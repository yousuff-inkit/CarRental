<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
form label.error {
	color: red;
	font-weight: bold;
}
.center {
  margin-left: auto;
  margin-right: auto;
}
</style>
<script type="text/javascript">
    /*  $(document).ready(function () { 
    	  $("#jqxUserMasterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  $('#roleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    	  $('#roleDetailsWindow').jqxWindow('close');
    	  
    	  $('#txtpasswordconfirm').on('keyup', function () {
        	 // alert($(this).val() == $('#txtuserpassword').val());
        	    if ($(this).val() == $('#txtuserpassword').val()) {
        	    	//alert("in");
        	        $('#message').html('Matching').css('color', 'green');
        	    } else $('#message').html('Not Matching').css('color', 'red');
        	});
    	   
    	       
    	  $('#txtbrole').dblclick(function(){
  	  	    $('#roleDetailsWindow').jqxWindow('open');
  	   
  	  	roleSearchContent('userRoleSearchGrid.jsp?', $('#roleDetailsWindow')); 
         
    	  
    	  });
    	  
    	  alert("a");
      });*/
     
      
      
      
      function roleSearchContent(url) {
          $('#roleDetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
       $('#roleDetailsWindow').jqxWindow('setContent', data);
       $('#roleDetailsWindow').jqxWindow('bringToFront');
      }); 
       
      }
     
		function funReadOnly(){
			$('#frmSatMaster input').attr('readonly', true );
			$('#frmSatMaster select').attr('disabled', true );
			$('#frmSatMaster input[type=checkbox]').attr('disabled', true );
			//$('#jqxUserMasterDate').jqx({ disabled: true});
			
			
		}
		
		/*Date*/
		function funFocus(){
			$('#txtuser').jqxGrid('focus'); 
		}
		function funRemoveReadOnly(){
			$('#frmSatMaster input').attr('readonly', false );
			$('#frmSatMaster select').attr('disabled', false );
			$('#frmSatMaster input[type=checkbox]').attr('disabled', false );
			$('#docno').attr('readonly', true);
			
			$('#txtbrole').attr('readonly', true);
			if($('#mode').val()=="A")
				{
						  
			
				}
			
			if ($("#mode").val() == "E") {
				
			}
		}

		
		
		function funSearchLoad()
		{
		 changeContent('satMasterSearch.jsp'); 
		}
		
		
		function checkUserid() {
		
			var userid=document.getElementById("txtuser").value;
			
			  var masterdoc=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("useridchk").value=1;				 		
				 			document.getElementById("errormsg").innerText="User ID Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("useridchk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUserid.jsp?userid="+userid+"&masterdoc="+masterdoc, true);
			x.send();
		}
		
		function checkUsername() {
		
			var username=document.getElementById("txtusername").value;
			
			  var masterdocs=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("usernamechk").value=1;		
				 			document.getElementById("errormsg").innerText="User Name Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("usernamechk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUsername.jsp?username="+username+"&masterdocs="+masterdocs, true);
			x.send();
		}
		
		
		$(function(){
		    $('#frmUserMaster').validate({
		             rules: {
		            	 txtuser:{
		                	 required:true,maxlength:10
		                 },
		                 txtusername:{
		                	 required:true,maxlength:30
		                 },
		               
		            	 txtuserpassword:{
		                	 required:true,maxlength:100
			                 },
			             txtpasswordconfirm:{
		                	 required:true
			                 },
			                 
			                 txtusermail:"required"
		            
		             },
		             messages: {
		            	 txtuser:{
		            		 required:" *required",maxlength:"max 10 chars"
		                 },
		                 txtusername:{
		                	 required:"*required",maxlength:" max 30 chars"
		                 },
		              
		            	 txtuserpassword:{
		                	  required:" *required",maxlength:" max 100 chars"
		                  },
		                  txtpasswordconfirm:{
		                	  required:" *required"
				                 },
				                 txtusermail:" *Enter Valid Email",          
				  
		             }
		    });
		    });
		
		  function funNotify(){
			
			 
           var useridchk= document.getElementById("useridchk").value;
			 
			 if(parseInt(useridchk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User ID Already Exists";
				 document.getElementById("txtuser").focus();
		 			return  0;
				 
				 }
              var usernamechk= document.getElementById("usernamechk").value;
			 
			 if(parseInt(usernamechk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User Name Already Exists";
				 document.getElementById("txtusername").focus();
		 			return  0; 
				 
				 }
			 var uname=document.getElementById("txtuser").value;
			 if(uname==""){
				 document.getElementById("errormsg").innerText="Enter User Name";
				 document.getElementById("txtuser").focus();
		 			return  0;
			 }
			 var pwd=document.getElementById("txtusername").value;
			 if(pwd==""){
				 document.getElementById("errormsg").innerText="Enter Password";
				 document.getElementById("txtusername").focus();
		 			return  0;
			 }
			/* var levelss= document.getElementById("levels").value;
			 if(levelss=="")
				 {
				 document.getElementById("errormsg").innerText="Select Discount Level";
				 document.getElementById("levels").focus();
		 			return  0; 
				 }*/
			/* var rolelevel= document.getElementById("txtbrole").value;
			 if(rolelevel=="")
				 {
				 document.getElementById("errormsg").innerText="Select Role";
				 document.getElementById("txtbrole").focus();
		 			return  0; 
				 }*/
			 
			 
			 /*if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val())
				 {
				 
				 document.getElementById("errormsg").innerText="Password Is Not Matching";
		 			return  0; 
				 }*/
			
			 
			 
			    if($('#cmpermission').val()==1)

		    	   {	   			    
			   var z=0;
		       var rows = $("#jqxUserMaster").jqxGrid('getrows');                    
		           
		       var selectedRecords = new Array();
		       var selectedrows=$("#jqxUserMaster").jqxGrid('selectedrowindexes');
		      
			  if(selectedrows.length==0){
			   $.messager.alert('Warning','Select Branch & Company.');
			   return false;
			  }
		  
		      $('#existusermaster').val(selectedrows.length);
		    /*   alert("Length = "+$('#existusermaster').val()); */
		      for (var i = 0; i < rows.length; i++) {
		      for(var j=0;j<selectedrows.length;j++){
		       if(selectedrows[j]==i){
		        
		        newTextBox = $(document.createElement("input"))
		           .attr("type", "dil")
		           .attr("id", "test"+z)
		           .attr("name", "test"+z)
		           .attr("hidden","true");
		        
		       newTextBox.val(rows[i].brhid+"::"+rows[i].compid);
		     /*   alert("newTextBox.val() = "+newTextBox.val()); */
		       newTextBox.appendTo('form');
		       z++;
		       }
		      }
		   }
		    
		    	   }
		    	   
		    	    var remarks= document.getElementById("remarks").value;
			 if(remarks=="")
				 {
				 document.getElementById("errormsg").innerText="Select Remarks";
				 document.getElementById("remarks").focus();
		 			return  0; 
				 }
		    	    var site= document.getElementById("site").value;
			 if(site=="")
				 {
				 document.getElementById("errormsg").innerText="Select site";
				 document.getElementById("site").focus();
		 			return  0; 
				 }
		
		    
			    return 1;
		} 
		  
	
	       function getURole(event){
	              var x= event.keyCode;
	              if(x==114){
	               roleSearchContent('userRoleSearchGrid.jsp');
	              }
	              else{
	               }
	              }
	     function fungriddis()
	     {
	       
	       if($('#cmpermission').val()==1)

	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
	    	   
	    	   
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   
	    	   }
	       else
	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: true}); 
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   }
	     }
	     
	   
	     function checkvals()
	     {
	     
	 
	   if($('#permissionval').val()!="")
	  {
	  
	 
	  $('#cmpermission').val($('#permissionval').val());
	  }
	   
	   if($('#hidremrk').val()!="")
	  {
	 
	  $('#remarks').val($('#hidremrk').val());
	  }
	   if($('#hidsite').val()!="")
	  {
	 
	  $('#site').val($('#hidsite').val());
	  }
	   
	     }

function funClickChk(){
 if (document.getElementById('captch').checked) {
 		    document.getElementById('hidCaptcha').value=1;	
 	   }else{
 	    		    document.getElementById('hidCaptcha').value=0;	
 	   
 	   }
 	   } 
 	   
 	   function fucntionRtaChk(){
 	   if(document.getElementById('rta').checked){
 	   document.getElementById('hidRta').value=1;
 	   }else{
 	    	   document.getElementById('hidRta').value=0;
 	   
 	   }
 	   }
 	   
 	 
	     
		function setValues() {
			if($('#hidjqxUserMasterDate').val()){
				$("#jqxUserMasterDate").jqxDateTimeInput('val', $('#hidjqxUserMasterDate').val());
			}
			var docnumber=document.getElementById("docno").value;
			
			if(parseInt(docnumber)>0)
				{ 
				
		
				 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);
			}  
			
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
		    }
			
			
			 //getLang();
	        checkvals();
			document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			funSetlabel();
			
		
			  if(document.getElementById("hidCaptcha").value==1){
 	   document.getElementById('captch').checked = true;
 	   }else{
 	    	   document.getElementById('captch').checked = false;
 	   
 	   }
 	   
 	   if(document.getElementById('hidRta').value==1){
 	    	   document.getElementById('rta').checked = true;
 	   
 	   }else{
 	    	    	   document.getElementById('rta').checked = false;
 	   
 	   }
 	   
		}

		
  </script>
</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmSatMaster" action="satMastersAction" autocomplete="off">
			<jsp:include page="../../../../header.jsp"></jsp:include>
			<fieldset>
				<legend>User Master Info</legend>
				<table width="100%">
				<tr>
				<td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td colspan="5"></td><td align="right">Doc No <input type="text" id="docno" name="docno" 
							tabindex="-1;" value='<s:property value="docno"/>'>
						</td></tr>
					<tr>
						<td style="margin-right: 10px;padding: 0px;width:60px;">User Name</td>
						<td colspan="3"> <input type="text" id="txtuser" name="username"
							 placeholder="Enter User Name" value='<s:property value="username"/>'
							onblur="checkUserid()">
						</td>

						<td style="margin-right: 10px;padding: 0px;width:60px;">Password</td><td colspan="3"><input type="password" id="txtusername"
							name="password" placeholder="Enter Password" 
							value='<s:property value="password"/>'>
						</td>
						<td style="margin-right: 10px;padding: 0px;width:60px;">Site</td><td colspan="3"><select
							id="site" name="site" style="width: 45%;"  value='<s:property value="site"/>'>
								<option value="">--Select--</option>
								<option value="DXB">DXB</option>
								<option value="AUH">AUH</option>
						</select> <input type="hidden" id="hidsite" name="hidsite"  value='<s:property value="hidsite"/>'>
						</td>
						
						
					</tr>
					<tr>
						<td >TC no</td><td colspan="3"> <input type="text" id="tcno" name="tcno" style="width: 43%;"
							placeholder="TC number" value='<s:property value="tcno"/>'>
						</td>


						<td >Time Period</td><td colspan="3"> <input type="text" id="txtperiod" name="timeperiod"
							style="width: 43%;" placeholder="Time Period" value='<s:property value="timeperiod"/>'>
						</td>
						<td>Remarks</td><td colspan="3"><select
							id="remarks" name="remarks" style="width: 45%;" value='<s:property value="remarks"/>'>
								<option value="">--Select--</option>
								<option value="Traffic Fines">Traffic Fines</option>
								<option value="Salik">Salik</option>
						</select> <input type="hidden" id="hidremrk" name="hidremrk" value='<s:property value="hidremrk"/>'>

						</td>
					</tr>
					<tr>
						<td>IsCaptch</td>
						<td colspan="3"><input type="checkbox" id="captch"
							placeholder="" name="captch" onclick="funClickChk()"> <input
							type="hidden" id="hidCaptcha" name="hidCaptcha" value='<s:property value="hidCaptcha"/>'>RTA<input
							type="checkbox" id="rta" placeholder="RTA type" name="rta"
							onclick="fucntionRtaChk()"><input type="hidden"
							id="hidRta" name="hidRta" value='<s:property value="hidRta"/>'></td>
						<td>Sq Number</td>
						<td colspan="3"><input type="text" id="sqno"
							placeholder="Sequence number" name="sqno" style="width: 43%;"
							value='<s:property value="sqno"/>'>
						</td>
						
					</tr>

				</table>
				<br />
			</fieldset>
			<br />
			<!-- Here is the head -->
			<input type="hidden" id="mode" name="mode"
				value='<s:property value="mode"/>' /> 
				<input type="hidden"name="deleted" id="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" id="msg" name="msg"
				value='<s:property value="msg"/>' /> <input type="hidden"
				id="useridchk" name="useridchk"
				value='<s:property value="useridchk"/>' /> <input type="hidden"
				id="usernamechk" name="usernamechk"
				value='<s:property value="usernamechk"/>' /> <input type="hidden"
				id="langval" name="langval" value='<s:property value="langval"/>' />
			<input type="hidden" id="permissionval" name="permissionval"
				value='<s:property value="permissionval"/>' /> <input type="hidden"
				id="existusermaster" name="existusermaster"
				value='<s:property value="existusermaster"/>' />
			<%--   <input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>
 --%>
		</form>
		<div id="roleDetailsWindow">
			<div></div>
		</div>
	</div>
</body>
</html>