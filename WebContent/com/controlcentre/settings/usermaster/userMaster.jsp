<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
* {
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 0;
    height: 100vh; 
    width: 100%;
    overflow-x: hidden; 
    display: flex;
    flex-direction: column;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    width: 100%;
    max-width: 100%;
    margin: 0;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    display: flex;
    flex-direction: column;
    position: relative;
    flex: 1; 
    overflow-x: hidden;
}

#formdet {
    text-align: left !important;
    display: block;
    font-size: 22px;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 8px;
    padding-left: 5px;
}

.receipt-header {
    display: block;
    margin-bottom: 12px;
    padding: 0 5px;
}

.receipt-header table {
    width: 100%;
    table-layout: fixed; 
}

.jqx-datetimeinput, 
.jqx-datetimeinput input,
#docno, 
.header-docno {
    width: 130px !important;
}

input[type="text"], 
input[type="password"], 
input[type="email"], 
select {
    height: 30px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 8px;
    background: #fff;
    font-size: 14px;
    width: 100%;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 12px;
    display: block;
    line-height: 30px;
}

.table-section {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 10px;
    width: 100%;
}

.table-section h3 {
    font-size: 17.6px;
    font-weight: 700;
    margin: 0 0 15px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
    line-height: 1.2;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
}

.cr-table td {
    padding: 6px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 16px;
    white-space: nowrap !important;
    font-weight: 600 !important;
}

input[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
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
<body onload="setValues();getLang();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div id="mainBG">
    

    <div class="receipt-header">
        <table width="100%">
            <tr>
                <td width="60px" align="right"><label>Date</label></td>
                <td width="140px">
                    <div id="jqxUserMasterDate" name="jqxUserMasterDate" value='<s:property value="jqxUserMasterDate"/>'></div>
                    <input type="hidden" id="hidjqxUserMasterDate" name="hidjqxUserMasterDate" value='<s:property value="hidjqxUserMasterDate"/>'/>
                </td>
                <td></td>
                <td width="80px" align="right"><label>Doc No</label></td>
                <td width="140px" align="right">
                    <input type="text" id="docno" name="docno" class="header-docno" value='<s:property value="docno"/>' readonly tabindex="-1"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="table-section">
        <table class="cr-table" width="100%">
            <tr>
                <td align="right" style="width:10%;">User ID</td>
                <td style="width:40%;">
                    <input type="text" id="txtuser" name="txtuser" placeholder="Enter user ID" value='<s:property value="txtuser"/>' onblur="checkUserid()"/>
                </td>
                <td align="right" style="width:10%;">User Name</td>
                <td style="width:40%;">
                    <input type="text" id="txtusername" name="txtusername" placeholder="Enter user name" value='<s:property value="txtusername"/>' onblur="checkUsername()"/>
                </td>
            </tr>
            <tr>
                <td align="right">Discount Level</td>
                <td>
                    <select id="levels" name="levels" value='<s:property value="levels"/>'>
                        <option value="">--Select--</option>
                        <option value="1">Level 1</option>
                        <option value="2">Level 2</option>
                        <option value="3">Level 3</option>
                    </select>
                </td>
                <td align="right">Role</td>
                <td>
                    <input type="text" id="txtbrole" name="txtbrole" placeholder="Press F3 to Search" value='<s:property value="txtbrole"/>' onkeydown="getURole(event);"/>
                    <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">Language</td>
                <td>
                    <select id="cmblanguage" name="cmblanguage" value='<s:property value="cmblanguage"/>'></select>
                    <input type="hidden" id="hidcmblanguage" name="hidcmblanguage" value='<s:property value="hidcmblanguage"/>'/>
                </td>
                <td align="right">Mobile</td>
                <td>
                    <input type="text" id="mobile" name="mobile" placeholder="Enter mobile" value='<s:property value="mobile"/>' onblur="mobileValid(this.value);"/>
                </td>
            </tr>
            <tr>
                <td align="right">Email</td>
                <td>
                    <input type="email" id="txtusermail" name="txtusermail" placeholder="Email" value='<s:property value="txtusermail"/>'/>
                </td>
                <td align="right">Permission</td>
                <td>
                    <select id="cmpermission" name="cmpermission" value='<s:property value="cmpermission"/>' onchange="fungriddis()">
                        <option value="0">All Branch</option>
                        <option value="1">Selected Branch</option>
                    </select>
                    <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">E-mail Password</td>
                <td>
                    <input type="password" id="txtmailpswd" name="txtmailpswd" placeholder="Email Password" value='<s:property value="txtmailpswd"/>'/>
                </td>
                <td align="right">Signature</td>
                <td>
                    <input type="text" id="txtmailsign" name="txtmailsign" placeholder="Email Signature" value='<s:property value="txtmailsign"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">E-mail Host</td>
                <td>
                    <input type="text" id="txtmailhost" name="txtmailhost" placeholder="Email Host" value='<s:property value="txtmailhost"/>'/>
                </td>
                <td align="right">E-mail Port</td>
                <td>
                    <input type="text" id="txtmailport" name="txtmailport" placeholder="Email Port" value='<s:property value="txtmailport"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">Password</td>
                <td>
                    <input type="password" id="txtuserpassword" name="txtuserpassword" placeholder="Enter Password" value='<s:property value="txtuserpassword"/>'/>
                </td>
                <td align="right">Confirm</td>
                <td>
                    <input type="password" id="txtpasswordconfirm" name="txtpasswordconfirm" placeholder="Enter Confirm Password" value='<s:property value="txtpasswordconfirm"/>'/>
                    <span style="font-weight:bold;" id="message"></span>
                </td>
            </tr>
        </table>
    </div>

    <div class="table-section">
        <h3>Branch Permissions</h3>
        <div id="userMasterDiv" align="center">
            <jsp:include page="userMasterGrid.jsp"></jsp:include>
        </div>
    </div>

    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="useridchk" name="useridchk" value='<s:property value="useridchk"/>'/>
    <input type="hidden" id="usernamechk" name="usernamechk" value='<s:property value="usernamechk"/>'/>
    <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
    <input type="hidden" id="langval" name="langval" value='<s:property value="langval"/>'/>
    <input type="hidden" id="permissionval" name="permissionval" value='<s:property value="permissionval"/>'/>
    <input type="hidden" id="existusermaster" name="existusermaster" value='<s:property value="existusermaster"/>'/>
    <input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>
</div>

        <br/>

        <div class="cr-table" id="userMasterDiv" align="center">
            <jsp:include page="userMasterGrid.jsp"></jsp:include>
        </div>

        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>'/>
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>

        <input type="hidden" id="useridchk" name="useridchk"
               value='<s:property value="useridchk"/>'/>
        <input type="hidden" id="usernamechk" name="usernamechk"
               value='<s:property value="usernamechk"/>'/>
        <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation"
               value='<s:property value="txtmobilevalidation"/>'/>

        <input type="hidden" id="langval" name="langval"
               value='<s:property value="langval"/>'/>
        <input type="hidden" id="permissionval" name="permissionval"
               value='<s:property value="permissionval"/>'/>

        <input type="hidden" id="existusermaster" name="existusermaster"
               value='<s:property value="existusermaster"/>'/>
        <input type="hidden" id="hidelevels" name="hidelevels"
               value='<s:property value="hidelevels"/>'/>
    </div>
</form>

<div id="roleDetailsWindow">
    <div></div>
</div>

</div>
</body>


</html>