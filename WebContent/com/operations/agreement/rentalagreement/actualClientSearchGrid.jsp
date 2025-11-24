<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
<%
	ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
	String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 	String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 	String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 	String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
 	String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 	String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
 	String catdocno = request.getParameter("catdocno")==null?"0":request.getParameter("catdocno");
%> 
<link rel="stylesheet" type="text/css" 
href="<%=request.getContextPath()%>/css/premiumSearchOverride.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/searchTheme.css?v=9" />



<script type="text/javascript">
	var actualclienturl='getActualClientUrl.jsp?clname=<%=clname%>&mob=<%=mob%>&lcno=<%=lcno%>&passno=<%=passno%>&nation=<%=nation%>&dob=<%=dob%>&id=<%=id%>&catdocno=<%=catdocno%>';
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
     						
      						{name : 'pcase', type: 'String' },
      						
      						{name : 'advance', type: 'int' },
      						{name : 'invc_method', type: 'int' },
      						
      						{name : 'method', type: 'int' },
      						{name : 'outstanding',type:'number'},
      						{name : 'retailstatus',type:'number'},
      						{name : 'lpoconfig',type:'number'},
      						{name : 'lpostatus',type:'number'},
      						{name : 'racratestatus',type:'number'},
      						{name : 'actualclientstatus',type:'number'},
      						{name : 'catdocno',type:'number'}
      					
      						
                          	],
                          	url: actualclienturl,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#actualClientSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
             
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
					{ text: 'NAME', datafield: 'refname', width: '16%' },
					{ text: 'DRIVER NAME', datafield: 'drname', width: '14%' },
					 { text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
						{ text: 'MOB', datafield: 'per_mob', width: '9%' },
						 { text: 'TEL', datafield: 'per_tel', width: '8%' },
					 { text: 'LICENCE', datafield: 'dlno', width: '9%' },
					 { text: 'NATION', datafield: 'nation', width: '9%' },
					{ text: 'ADDRESS', datafield: 'address', width: '21%' }, 
					 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
					 { text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
					 { text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
					 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
					 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
					 { text: 'pcase', datafield: 'pcase', width: '20%',hidden:true},
					 
					 { text: 'advance', datafield: 'advance', width: '20%',hidden:true},
					 
					 { text: 'invc_method', datafield: 'invc_method', width: '20%',hidden:true},
					 
					 { text: 'method', datafield: 'method', width: '20%',hidden:true}, 
					 { text: 'Outstanding Amount', datafield: 'outstanding', width: '20%',hidden:true,cellsformat:'d2'},
					 { text: 'Retail Status', datafield: 'retailstatus', width: '20%',hidden:true},
					 { text: 'LPO Config', datafield: 'lpoconfig', width: '20%',hidden:true},
					 { text: 'LPO Status', datafield: 'lpostatus', width: '20%',hidden:true},
					 { text: 'RAC Rate Status', datafield: 'racratestatus', width: '20%',hidden:true},
					 { text: 'Actual Client Status', datafield: 'actualclientstatus', width: '20%',hidden:true},
					 { text: 'Category Doc No', datafield: 'catdocno', width: '20%',hidden:true}
					 
					
					 

					
					]
            });
    
         /*    $("#actualClientSearchGrid").jqxGrid('addrow', null, {}); */
      
		$('#actualClientSearchGrid').on('rowdoubleclick', function (event){
			var rowindex1=event.args.rowindex;
			$("#jqxgrid2").jqxGrid('clear');
	        $("#jqxgrid2").jqxGrid('addrow', null, {});
	        $("#jqxgrid2").jqxGrid('addrow', null, {});	              	
				              	
				            	 var temp=$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "refname")+", ";
				            	  temp=temp+" CONTACT PERSON : "+$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "contactperson");
				                temp=temp+","+" MOB : "+$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
				                temp=temp+","+" EMAIL : "+$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "mail1");
				                temp=temp+","+" ADDRESS : "+$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "address");
				                temp=temp+","+" TEL NO : "+$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_tel");
				               
				                
				            	document.getElementById("actualclientname").value=temp; 
				            	document.getElementById("actualcldocno").value=$('#actualClientSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
				            	$('#actualclientwindow').jqxWindow('close');
				     }); 	 
				           
        
                  }); 
				 
    </script>
    <div class="search-container">

    <!-- HEADER -->
    <div class="search-header">
        Client Search
        <small>Search by Name, Mobile, Reg No, Fleet No, LPO etc.</small>
    </div>

    <!-- BODY -->
    <div class="search-body">

        <div class="row">
            <div class="col">
                <label class="search-label">Name</label>
                <input type="text" id="clname" class="search-input"
                       value="<%=clname%>">
            </div>

            <div class="col">
                <label class="search-label">MOB</label>
                <input type="text" id="mob" class="search-input"
                       value="<%=mob%>">
            </div>

            <div class="col">
                <label class="search-label">MRA</label>
                <input type="text" id="lcno" class="search-input"
                       value="<%=lcno%>">
            </div>

            <div class="col" style="display:flex; align-items:flex-end;">
                <button class="search-btn" onclick="loadActualClientSearch()">Search</button>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="catdocno" class="search-input"
                       value="<%=catdocno%>">
            </div>

            <div class="col">
                <label class="search-label">Fleet No</label>
                <input type="text" id="fleet" class="search-input">
            </div>

            <div class="col">
                <label class="search-label">Reg No</label>
                <input type="text" id="reg" class="search-input">
            </div>

            <div class="col">
                <label class="search-label">LPO#</label>
                <input type="text" id="lpo" class="search-input">
            </div>
        </div>

    </div>

    <!-- GRID AREA -->
    <div class="search-grid-area">
        <div id="actualClientSearchGrid"></div>
    </div>

</div>


    </body>
</html>