<%@ taglib prefix="s" uri="/struts-tags" %>
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
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}
#mainBG {
    background: #fff;
    border-radius: 16px;
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
    padding-inline: 1.04em;
    padding-block: 1.04em;
    border-radius: 8px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
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
      });
     
      
      
      
      function roleSearchContent(url) {
          $('#roleDetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
       $('#roleDetailsWindow').jqxWindow('setContent', data);
       $('#roleDetailsWindow').jqxWindow('bringToFront');
      }); 
       
      }
     
		function funReadOnly(){
			$('#frmUserMaster input').attr('readonly', true );
			$('#frmUserMaster select').attr('disabled', true );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: true});
			
			
		}
		function funFocus(){
			$('#jqxUserMasterDate').jqxDateTimeInput('focus'); 
		}
		function funRemoveReadOnly(){
			$('#frmUserMaster input').attr('readonly', false );
			$('#frmUserMaster select').attr('disabled', false );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			$('#docno').attr('readonly', true);
			
			$('#txtbrole').attr('readonly', true);
			if($('#mode').val()=="A")
				{
				 $('#jqxUserMasterDate').val(new Date());
			 $("#userMasterDiv").load("userMasterGrid.jsp");
			  
			
				}
			
			if ($("#mode").val() == "E") {
				if(document.getElementById("permissionval").value==1)
					{
					
				/*     $("#jqxUserMaster").jqxGrid('clear');	 */
				/* 	 var docnumber=document.getElementById("docno").value;
					 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);  */
			    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
			    	 /*   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
					 $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); */ 
					}
			}
			
			if ($("#mode").val() == "D") {
				
				
				$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			}
			
			 getLang();
			
		}

		function getLang() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					items = items.split('####');
					var langItems = items[0].split(",");
					var optionslang = '';
					for (var i = 0; i < langItems.length; i++) {
						optionslang += '<option value="' + langItems[i] + '">'
								+ langItems[i] + '</option>';
					}
					
					$("select#cmblanguage").html(optionslang);
					
					if ($('#langval').val()!="") {
						
					
						var aa=$('#langval').val().trim();
						
					    $('#cmblanguage').val(aa) ;
			            
			            }
			
					
				} else {
				}
			}
			x.open("GET", "getLang.jsp", true);
			x.send();
		}
		
		
		function funSearchLoad()
		{
		 changeContent('masterSearchuser.jsp'); 
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
			 var levelss= document.getElementById("levels").value;
			 if(levelss=="")
				 {
				 document.getElementById("errormsg").innerText="Select Discount Level";
				 document.getElementById("levels").focus();
		 			return  0; 
				 }
			 var rolelevel= document.getElementById("txtbrole").value;
			 if(rolelevel=="")
				 {
				 document.getElementById("errormsg").innerText="Select Role";
				 document.getElementById("txtbrole").focus();
		 			return  0; 
				 }
			 
			 
			 if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val())
				 {
				 
				 document.getElementById("errormsg").innerText="Password Is Not Matching";
		 			return  0; 
				 }
			
			 mobilevalid=document.getElementById("txtmobilevalidation").value;
			 if(mobilevalid==1){
				 document.getElementById("errormsg").innerText="Invalid Mobile Number.";
				 return 0;
			 }
			 
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
	   
	   if($('#hidelevels').val()!="")
	  {
	 
	  $('#levels').val($('#hidelevels').val());
	  }
	     
	   
	   
	   
	   
	     }
		 function mobileValid(value){
	    	   if(value!=""){ 
	    	    var phoneno = /^\d{12}$/;  
				if(value.match(phoneno)){
					document.getElementById("errormsg").innerText="";
					$('#txtmobilevalidation').val(0);
					return true;
				}
				else{
					document.getElementById("errormsg").innerText="Invalid Mobile Number";
					$('#txtmobilevalidation').val(1);
					return false;
				}
	    	    }
	    	   
	    	   return true;
	    	   
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
			
			
			 getLang();
	        checkvals();
			document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			funSetlabel();
			
		
			
		}

		
  </script>
</head>
<body onload="setValues();getLang();" >
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="receipt-header hidden-scrollbar">

<div class="table-section" style="width:100%;">
<h3 style="font-size:18px;font-weight:600;color:#1B4F9A;">User Master Info</h3>

<table class="cr-table" width="100%" style="background:#ffffff;border-radius:12px;">

<!-- Row 1 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Date</td>
    <td width="20%">
        <div id="jqxUserMasterDate"></div>
        <input type="hidden" id="hidjqxUserMasterDate" name="hidjqxUserMasterDate"
               value='<s:property value="hidjqxUserMasterDate"/>'>
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Doc No</td>
    <td width="30%">
        <input type="text" id="docno" name="docno"
               value='<s:property value="docno"/>'
               readonly tabindex="-1"
               style="width:60%;padding:8px;border-radius:8px;
               background:#f0f5ff;border:1px solid #cfe0ff;">
    </td>
</tr>

<!-- Row 2 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">User ID</td>
    <td>
        <input type="text" id="txtuser" name="txtuser"
               value='<s:property value="txtuser"/>'
               placeholder="Enter User ID"
               style="width:90%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;"
               onblur="checkUserid()">
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">User Name</td>
    <td>
        <input type="text" id="txtusername" name="txtusername"
               placeholder="Enter User Name"
               value='<s:property value="txtusername"/>'
               onblur="checkUsername()"
               style="width:85%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
    </td>
</tr>

<!-- Row 3 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Discount Level</td>
    <td>
        <select id="levels" name="levels"
                style="width:60%;padding:7px;border-radius:8px;
                border:1px solid #cfe0ff;background:#ffffff;">
            <option value="">--Select--</option>
            <option value="1">Level 1</option>
            <option value="2">Level 2</option>
            <option value="3">Level 3</option>
        </select>
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Role</td>
    <td>
        <input type="text" id="txtbrole" name="txtbrole"
               placeholder="Press F3 to Search"
               onkeydown="getURole(event);"
               value='<s:property value="txtbrole"/>'
               style="width:85%;padding:8px;
               border-radius:8px;border:1px solid #cfe0ff;background:#f0f5ff;">
        <input type="hidden" id="txtroleid" name="txtroleid"
               value='<s:property value="txtroleid"/>'>
    </td>
</tr>

<!-- Row 4 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Language</td>
    <td>
        <select id="cmblanguage" name="cmblanguage"
                style="width:60%;padding:7px;border-radius:8px;
                border:1px solid #cfe0ff;background:white;">
        </select>
        <input type="hidden" id="hidcmblanguage" name="hidcmblanguage"
               value='<s:property value="hidcmblanguage"/>'>
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Mobile</td>
    <td>
        <input type="text" id="mobile" name="mobile"
               value='<s:property value="mobile"/>'
               onblur="mobileValid(this.value);"
               style="width:85%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
    </td>
</tr>

<!-- Row 5 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Email</td>
    <td colspan="3">
        <input type="email" id="txtusermail" name="txtusermail"
               placeholder="Email"
               value='<s:property value="txtusermail"/>'
               style="width:70%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
    </td>
</tr>

<!-- Row 6 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Permission</td>
    <td>
        <select id="cmpermission" name="cmpermission"
                style="width:60%;padding:7px;border-radius:8px;
                border:1px solid #cfe0ff;background:white;"
                onchange="fungriddis()">
            <option value="0">All Branch</option>
            <option value="1">Selected Branch</option>
        </select>
        <input type="hidden" id="hidcmpermission" name="hidcmpermission"
               value='<s:property value="hidcmpermission"/>'>
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Signature</td>
    <td>
        <input type="text" id="txtmailsign" name="txtmailsign"
               value='<s:property value="txtmailsign"/>'
               placeholder="Email Signature"
               style="width:85%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#ffffff;">
    </td>
</tr>

<!-- Row 7 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Email Password</td>
    <td>
        <input type="password" id="txtmailpswd" name="txtmailpswd"
               value='<s:property value="txtmailpswd"/>'
               placeholder="Email Password"
               style="width:90%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Email Host</td>
    <td>
        <input type="text" id="txtmailhost" name="txtmailhost"
               value='<s:property value="txtmailhost"/>'
               placeholder="Email Host"
               style="width:85%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#ffffff;">
    </td>
</tr>

<!-- Row 8 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Email Port</td>
    <td>
        <input type="text" id="txtmailport" name="txtmailport"
               value='<s:property value="txtmailport"/>'
               placeholder="Email Port"
               style="width:60%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#ffffff;">
    </td>

    <td align="right" style="font-weight:600;color:#1A3E7A;">Password</td>
    <td>
        <input type="password" id="txtuserpassword" name="txtuserpassword"
               value='<s:property value="txtuserpassword"/>'
               placeholder="User Password"
               style="width:85%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
    </td>
</tr>

<!-- Row 9 -->
<tr>
    <td align="right" style="font-weight:600;color:#1A3E7A;">Confirm Password</td>
    <td colspan="3">
        <input type="password" id="txtpasswordconfirm" name="txtpasswordconfirm"
               value='<s:property value="txtpasswordconfirm"/>'
               placeholder="Confirm Password"
               style="width:60%;padding:8px;border-radius:8px;
               border:1px solid #cfe0ff;background:#f9fbff;">
        <span id="message" style="font-weight:bold;"></span>
    </td>
</tr>

</table>
</div>

<br>

<!-- GRID -->
<div class="cr-table" id="userMasterDiv" align="center">
    <jsp:include page="userMasterGrid.jsp"></jsp:include>
</div>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="useridchk" name="useridchk" value='<s:property value="useridchk"/>'>
<input type="hidden" id="usernamechk" name="usernamechk" value='<s:property value="usernamechk"/>'>
<input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'>

<input type="hidden" id="langval" name="langval" value='<s:property value="langval"/>'>
<input type="hidden" id="permissionval" name="permissionval" value='<s:property value="permissionval"/>'>

</div>
</form>

<!-- Role search popup styling -->
<style>
#roleDetailsWindow {
    background:#ffffff !important;
    border-radius:12px !important;
}
#roleDetailsWindow .jqx-window-content {
    background:white !important;
    padding:15px !important;
}
#roleDetailsWindow .jqx-widget-header {
    background:#1e6ed8 !important;
    color:white !important;
    font-weight:bold !important;
    border-radius:10px 10px 0 0;
}
</style>

<div id="roleDetailsWindow"><div></div></div>

</div>
</body>

</html>