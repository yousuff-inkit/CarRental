<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" import="java.util.*" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno"); %>
 <% String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); %>  
 <% String brch = request.getParameter("brch")==null || request.getParameter("brch").equals("")?"0":request.getParameter("brch"); %>
 <% String userid = request.getParameter("userid")==null?"0":request.getParameter("userid");%>
 <% String aprstatus = request.getParameter("aprstatus")==null?"0":request.getParameter("aprstatus");%>
 <% String isfirstappr = request.getParameter("isfirstappr")==null?"0":request.getParameter("isfirstappr"); %>
 
 <style type="text/css">
    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background-color: #f0f4f8;
        margin: 0;
        padding: 20px;
        color: #2d3436;
    }

    /* Original functional classes preserved */
    .redClass { background-color: #FFEBEB; }
    .yellowClass { background-color: #FFFFD1; }
    .greyClass { background-color: #D8D8D8; }

    .main-container {
        display: flex;
        gap: 20px;
        max-width: 100%;
        margin: 0 auto;
    }

    /* Left Section - 40% */
    .left-section {
        flex: 0 0 40%;
        background: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* Right Section - 60% */
    .right-section {
        flex: 1;
        background: #ffffff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        min-height: 600px;
    }

    .header-label {
        font-size: 20px;
        font-weight: 700;
        color: #4530f6;
        margin-bottom: 5px;
        border-bottom: 2px solid #f1f2f6;
        padding-bottom: 10px;
    }

    .field-label {
        font-weight: 600;
        font-size: 16px;
        color: #2d3436;
        margin-bottom: 5px;
        display: block;
    }

    /* Input & Textarea Styling */
    input[type="text"], textarea {
        width: 100%;
        padding: 15px;
        font-size: 18px;
        border: 2px solid #dfe6e9;
        border-radius: 8px;
        box-sizing: border-box;
        background-color: #f9f9f9;
    }

    textarea {
        height: 150px !important;
        resize: none;
        background-color: #ffffff;
    }

   /* Update this specific section in your <style> tag */
select.list1 {
    width: 100%;
    padding: 10px 15px !important; /* Reduced vertical padding */
    font-size: 20px !important; 
    font-weight: 600;
    border: 2px solid #0984e3;
    border-radius: 8px;
    background-color: #ffffff !important;
    color: #2d3436 !important; /* High contrast black/grey text */
    cursor: pointer;
    height: auto !important; /* Ensures the box grows to fit the text */
    line-height: 1.5 !important; /* Centers the text vertically */
    display: block !important;
}

select.list1 option {
    font-size: 18px !important;
    padding: 10px;
    background-color: #ffffff;
    color: #2d3436;
}

    .btn-row {
        text-align: right;
        margin-top: 10px;
    }

    .my {
        background-color: #4530f6;
        color: white;
        border: none;
        padding: 15px 50px;
        font-size: 20px;
        font-weight: 700;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.2s;
    }

    .my:hover {
        background-color: #074b83;
    }

    .flex-row {
        display: flex;
        gap: 15px;
    }

    #jqxApprovalGrid {
        width: 100% !important;
    }
.approval-locked #btn {
    display: none !important;
}

.approval-locked select,
.approval-locked textarea {
    pointer-events: none;
    background-color: #f0f0f0 !important;
    opacity: 0.7;
}


    
</style>

	<script type="text/javascript">
	$(document).ready(function(){
	    getStatOpt();
	    funcurdate();
	    
	    var data4='<%=cef.approvalGridload(session,dtype,brch,docNo)%>';
	    Check(data4);
	    
	  
	    var aprstatus = '<%=aprstatus%>';
	    console.log("Page loaded - aprstatus from JSP:", aprstatus); 
	    lockApprovalUI(aprstatus);
	});
	
	function Check(data4){
		   
		
		  var source =
          {
              datatype: "json",
              datafields: [
						{name : 'apprtype', type: 'String'   },
							{name : 'user_name', type: 'string'  }, 
      						{name : 'apprdatetime', type: 'string'   },
      						{name : 'remarks', type: 'string'   },
      						{name : 'apprlevel', type: 'string'   }
   						     						
               ],
               localdata: data4, 
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
		  
		  var cellclassname = function (row, column, value, data) {
      		if (data.apprlevel==1) {
                  return "redClass";
              } else if (data.apprlevel==2) {
                  return "yellowClass";
              }
              else{
              	return "greyClass";
              };
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
          $("#jqxApprovalGrid").jqxGrid(
          {
              width: '100%',
              height: 250,
              source: dataAdapter,
              columnsresize: true,
              editable: false,
              rowsheight:40,
              selectionmode: 'singlerow',
              columns: [
				{ text: '', datafield: 'apprtype',  width: '10%',cellclassname: cellclassname },
				{ text: 'User', datafield: 'user_name', width: '15%',cellclassname: cellclassname },
				{ text: 'Submit Time', datafield: 'apprdatetime', width: '12%',cellclassname: cellclassname },	
				{ text: 'Remarks' , datafield: 'remarks', width: '63%',cellclassname: cellclassname },
				{ text: 'ApprlLevel', datafield: 'apprlevel', hidden:true , width: '10%',cellclassname: cellclassname },
							
          ]
          });	
		 $('#jqxApprovalGrid').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               /* SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename")); */
              }); 
		 
		 $('#jqxApprovalGrid').on('rowclick', function (event) 
	              { 
	               var rowindexes=event.args.rowindex;
	               /* document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"); */
	              });
		 $("#jqxApprovalGrid").jqxGrid('autoresizecolumns');
	}
	 function saveApprlevel()  
	      {  
		
		 setTimeout(function() {$("#btnSend").attr("disabled", true);},1000);
		 var uri=encodeURI('saveApprove.action?docno='+$("#hidocno").val()+'&dtype='+$("#hidtype").val()+'&userid='+$("#hiuserid").val()+'&brchid='+$("#hibrchid").val()+'&desc='+$("#apprdesc").val()+'&apprlevel='+$("#apprlevel").val()+'&minapprl='+$("#minapprl").val()+'&optid='+$("#optid").val()+'&apprlist='+$("#apprlist").val());
		 //alert(uri);
		  /*  var reftypid=document.getElementById("reftypid").value; */     
			/* alert("===docno==="+$("#hidocno").val()+"===&dtype="+$("#hidtype").val()+"&userid===="+$("#hiuserid").val()+"==&brchid="+$("#hibrchid").val()+"===&desc="+$("#apprdesc").val()); */
	          $.ajaxFileUpload  
	          (    
	              {  
	                  url: uri,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'String',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                     
	                     if(status=='success'){   
	                    	 // funApproveBtn();
	                    	/*  getapprcount(); */
	                         $.messager.show({title:'Message',msg:'Transaction Completed',showType:'show',
	                            style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        });
	                         $("#windowapprove").jqxWindow('Close');     
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              //$.messager.alert('Message',data.error);
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              //$.messager.alert('Message',data.message);
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      //alert(e);  
	                      $.messager.alert('Message',e);
	                  }  
	              }  
	          )  
	          return false;  
	      }
		

	function funcurdate(){
	var currentdate=new Date();
	var date = currentdate.getDate()+ "/"+ (currentdate.getMonth()+1)+ "/"+currentdate.getFullYear(); 
    var time= currentdate.getHours() + ":"+currentdate.getMinutes();
   /*  + currentdate.getSeconds();
	alert("===datetime======"+datetime); */
	
    document.getElementById("apprdate").value=date;
    document.getElementById("apprtime").value=time;
    document.getElementById("hidocno").value='<%=docNo%>';
    document.getElementById("hidtype").value='<%=dtype%>';
    document.getElementById("hiuserid").value='<%=userid%>';
    document.getElementById("hibrchid").value='<%=brch%>';
     getapprlevel();
	}
	
	
	function lockApprovalUI(aprstatus) {
	    // Trim whitespace and convert to string for consistent comparison
	    var status = String(aprstatus).trim();
	    
	    console.log("lockApprovalUI - Original:", aprstatus, "Cleaned:", status, "Type:", typeof status);
	    
	    // Check if status is 3 or 4
	    if (status === "3" || status === "4") {
	        console.log("✓ Status is 3 or 4 - HIDING button and disabling fields");
	        document.body.classList.add("approval-locked");
	        $("#btn").hide();
	        $("#apprdesc").prop("disabled", true);
	        $("#optname").prop("disabled", true);
	    } else {
	        console.log("✗ Status is NOT 3 or 4 - SHOWING button and enabling fields");
	        document.body.classList.remove("approval-locked");
	        $("#btn").show();
	        $("#apprdesc").prop("disabled", false);
	        $("#optname").prop("disabled", false);
	    }
	}





	
	function getapprlevel(){
	    var docno=document.getElementById('hidocno').value;
	    var dtype=document.getElementById('hidtype').value;
	    var brch='<%=request.getParameter("brch")%>';
	    var usrid='<%=session.getAttribute("USERID")%>';
	    var isfirstappr='<%=isfirstappr%>';
	    
	    var x=new XMLHttpRequest();
	    x.onreadystatechange=function(){
	        if (x.readyState==4 && x.status==200) {
	            var items = x.responseText.split('####');
	            var apprlevel = items[1];
	            var minapprl  = items[2];
	            var apprlist  = items[3];
	            var aprstatus = items[4];
	            
	            $("#apprlevel").val(apprlevel);
	            $("#minapprl").val(minapprl);
	            $("#apprlist").val(apprlist);
	            $("#hidAprStatus").val(aprstatus);
	            lockApprovalUI(aprstatus);	
	        }
	    }
	    x.open("GET", "<%=contextPath+"/"%>com/common/getApprLevel.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid+"&isfirstappr="+isfirstappr,true);
	    x.send();
	}
	

	
	function getStat(c){
			
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 	
			 		var reftype = items[0].split(",");
			 		var refcode  = items[1].split(",");
			 		var refdocno  = items[2].split(",");
			 		
			 		document.getElementById("optid").value=refdocno;
			    }
		       else
			  {}
	     }
	      x.open("GET", <%=contextPath+"/"%>+"com/common/getStat.jsp?opt_name="+c,true);
	     x.send();
	    
	   }
	
	function getStatOpt()
	{	
		
		
	var x=new XMLHttpRequest();
	var items,refname,refcode,refdocno;
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{  
	        items= x.responseText;
	        items=items.split('####');
	        
	        refname=items[0].split(",");
	        refcode=items[1].split(",");
	        refdocno=items[2].split(",");
	       
	        	var optionref = '';
	        	var optionscurr = '';
	       for ( var i = 0; i < refname.length; i++) {
	    	   
	    	   
	    	   getStat(refname[0]);
	    	   optionref += '<option value="' + refname[i] + '">' + refname[i] + '</option>';
	    	  
	        }
	       $("select#optname").html(optionref); 
	       
	        	
	        }
		else
			{
			}
	}
	x.open("GET",<%=contextPath+"/"%>+"com/common/getStatOpt.jsp",true);
	x.send();
	}
	 
	</script>
	
	
<body>

<div id="search">
    <div class="main-container">
        
        <div class="left-section">
            <div class="header-label">Approval Details</div>
            
            <div class="flex-row">
                <div style="flex: 1;">
                    <label class="field-label">Date</label>
                    <input type="text" name="apprdate" id="apprdate" readonly value='<s:property value="apprdate"/>'>
                </div>
                <div style="flex: 1;">
                    <label class="field-label">Time</label>
                    <input type="text" name="apprtime" id="apprtime" readonly value='<s:property value="apprtime"/>'>
                </div>
            </div>

            <div>
                <label class="field-label">Remarks / Description</label>
                <textarea maxlength="540" id="apprdesc" name="apprdesc"><s:property value="apprdesc" ></s:property></textarea>
            </div>

            <div>
                <label class="field-label">Status</label>
                <select name="optname" class="list1" id="optname" onchange="getStat(this.value);">
                    <option value="">-- Choose Status --</option>
                    <option value="Approved">Approved</option>
                    <option value="Rejected">Rejected</option>
                    <option value="Returned">Returned</option>
                </select>
            </div>

            <div class="btn-row">
                <button class="my" type="button" id="btn" name="btnSend" onClick="saveApprlevel()">SUBMIT</button>
            </div>
        </div>

        <div class="right-section">
            <div class="header-label">Approval Queue / History</div>
            <div id="refreshdiv">
                <div id="jqxApprovalGrid"></div>
            </div>
        </div>

    </div>

    <input type="hidden" id="optid"/>
    <input type="hidden" id="hidtype"/>
    <input type="hidden" id="hidocno"/>
    <input type="hidden" id="hiuserid"/>
    <input type="hidden" id="hibrchid"/>
    <input type="hidden" id="apprlevel"/>
    <input type="hidden" id="minapprl"/>
    <input type="hidden" id="apprlist"/>
    <input type="hidden" id="hidAprStatus"/>
    
</div>



</body>

</html>

