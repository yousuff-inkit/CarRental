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
 
 
<style>
        :root {
            --primary-color: #2563eb;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --bg-gray: #f8fafc;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f1f5f9;
            margin: 0;
            padding: 20px;
            font-size: 16px;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            display: flex;
            min-height: 550px;
            overflow: visible !important; /* Ensures dropdown isn't cut off */
        }

        /* Left Section (40%) */
        .input-section {
            flex: 0 0 40%;
            padding: 30px;
            border-right: 1px solid var(--border-color);
            background-color: var(--bg-gray);
            box-sizing: border-box;
        }

        /* Right Section (60%) */
        .display-section {
            flex: 0 0 60%;
            padding: 30px;
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
        }

        .section-title {
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 25px;
        }

        /* Form Elements */
        .form-row { margin-bottom: 20px; }
        .field-label { display: block; font-weight: 500; margin-bottom: 8px; }
        
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .btn-submit {
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
        }

        /* FIX: Dropdown Visibility */
        .status-container {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
        }

        .modern-select {
            appearance: none;
            background-color: #ffffff;
            width: 220px;
            /* Critical Fix: specific height + line-height normal to stop clipping */
            height: 45px;
            line-height: 1.2; 
            padding: 0 35px 0 15px; 
            font-size: 16px;
            font-weight: 600;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            cursor: pointer;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%232563eb'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 18px;
        }


/* Also update the options inside the dropdown */
.modern-select option {
    font-size: 16px; 
    padding: 10px;
}
        /* RESTORE: Grid Headers (User, Submit Time, Remarks) */
        .grid-container {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            flex-grow: 1;
            background: #fff;
            overflow: hidden;
        }

        .grid-table {
            width: 100%;
            border-collapse: collapse;
        }

        .grid-table th {
            background-color: #f1f5f9;
            color: var(--text-muted);
            font-size: 13px;
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
            font-style: italic;
            font-size: 14px;
        }
    </style>

	<script type="text/javascript">
	$(document).ready(function(){
		getStatOpt();
		funcurdate();
	 	
		var data4='<%=cef.approvalGridload(session,dtype,brch,docNo)%>';
		//alert("===data4===="+data4);
		Check(data4);
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
	
	function gridLoad(){
		var aprstatus='<%=aprstatus%>';
		var isfirstappr='<%=isfirstappr%>';
		var apprlevel=document.getElementById('apprlevel').value;
		
		  if((parseInt(isfirstappr)==0)){
			$('#optdiv').hide();
		} 
		  
		  if((parseInt(aprstatus)==0)){
			  $('#masdiv').hide();
			} 
		
	}
	
	function getapprlevel(){
		
		var docno=document.getElementById('hidocno').value;
		var dtype=document.getElementById('hidtype').value;
		var brch='<%=session.getAttribute("BRANCHID")%>';
		var usrid='<%=session.getAttribute("USERID")%>';
		var isfirstappr='<%=isfirstappr%>';
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 		var apprlevel = items[1];
			 		var minapprl= items[2];
			 		var apprlist= items[3];
			 		document.getElementById('apprlevel').value=apprlevel;
			 		document.getElementById('minapprl').value=minapprl;
			 		document.getElementById('apprlist').value=apprlist;
			 		gridLoad();
			 		//alert("===apprlevel===="+apprlevel);
					
				}
		       else
			  {}
	     }
	      x.open("GET", <%=contextPath+"/"%>+"com/common/getApprLevel.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid+"&isfirstappr="+isfirstappr,true);
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

<div class="container">
    <div class="input-section">
        <h2 class="section-title">Entry Details</h2>
        <div class="form-row">
            <span class="field-label">Date & Time</span>
            <div style="display: flex; gap: 10px;">
                <input type="text" value="6/1/2026" readonly style="flex: 2;">
                <input type="text" value="5:10" readonly style="flex: 1;">
            </div>
        </div>
        <div class="form-row">
            <span class="field-label">Remarks / Description</span>
            <textarea id="apprdesc" name="apprdesc" placeholder="Enter remarks here..."></textarea>
        </div>
        <button class="btn-submit" type="button" id="btnSend" name="btnSend" onClick="saveApprlevel()">SUBMIT APPROVAL</button>
    </div>

    <div class="display-section">
        <h2 class="section-title">Status & Records</h2>
        
        <div class="status-container">
            <span class="field-label" style="margin:0">Current Status:</span>
            <select class="modern-select">
                <option>Approved</option>
                <option>Rejected</option>
                <option>Returned</option>
            </select>
        </div>

        <div class="grid-container">
            <table class="grid-table">
                <thead>
                    <tr>
                        <th width="20%">User</th>
                        <th width="30%">Submit Time</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
            </table>
            <div class="no-data">No data to display in approval history</div>
        </div>
    </div>
</div>

</body>

</html>
