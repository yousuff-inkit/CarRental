<%@page import="com.emailnew.ClsEmailDAO" %> 
<%ClsEmailDAO ced=new ClsEmailDAO(); %>
 <%@page import="javax.servlet.http.HttpSession" %>          
 <%      
 //System.out.println("=dtype==dtype==="+request.getParameter("dtype"));
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 int value = Integer.parseInt(request.getParameter("value"));
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
%>      
     
  <script type="text/javascript">
    var datas= '<%=ced.addressbook(session,name,dtype,cldocno,id)%>';
    var nums='<%=value%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'String'  },
							{name : 'e_mail', type: 'String'  },
							{name : 'dtype', type: 'String'  },
							{name : 'cperson', type: 'String'  },
							{name : 'activity', type: 'String'  },  
						
                 ],
                 localdata: datas,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.	
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxAddressbook").jqxGrid(
            {
            	width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                showfilterrow:'true',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
					{ text: 'E-mail ID',columntype: 'textbox', filtertype: 'input', datafield: 'e_mail', width: '30%' },
					{ text: 'Contact Person',columntype: 'textbox', filtertype: 'input', datafield: 'cperson', width: '20%' },
					{ text: 'Activity',columntype: 'textbox', filtertype: 'input', datafield: 'activity', width: '20%' },
					{ text: 'Doc Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtype', width: '20%' },
					   ]
            });

            $('#jqxAddressbook').on('rowdoubleclick', function (event)   { 
            	 if (event.args.value) {
                     $("#jqxAddressbook").jqxGrid('selectrow', event.args.rowindex);
                 }
                 else {
                     $("#jqxAddressbook").jqxGrid('unselectrow', event.args.rowindex);
                 }
             }); 
           
        });
        
        function funUpdate(){
        	var temp="";
	        var rows = $("#jqxAddressbook").jqxGrid('selectedrowindexes');
            var selectedRecords = new Array();
            for (var m = 0; m < rows.length; m++) {
                var row = $("#jqxAddressbook").jqxGrid('getrowdata', rows[m]);
                //alert("==row===="+ row.service);
                var rowlength=$("#jqxAddressbook").jqxGrid('rows').records.length;
                /* alert("row.serid"+row.e_mail);
                alert("mmmmmmm"+m); */
                //alert("grid data"+$('#jqxAddressbook').jqxGrid('getcellvalue', m, "e_mail"));
               
			            	  //temp=temp+","+$('#jqxccaddressGrid').jqxGrid('getcellvalue', m, "e_mail");
			            	  if(m==0){
			            		  temp=row.e_mail;
			            	  }
			            	  else{
			            		  temp=temp+","+row.e_mail;
			            	  }
			            	  
			               //alert("==num===="+num);
			               if(nums==0){
			            	   document.getElementById("recipient").value=temp;
			               }
			               if(nums==1){
			            	   document.getElementById("CC").value=temp;
			               }
			               if(nums==2){
			            	   document.getElementById("BCC").value=temp;
			               }
			               
                //selectedRecords[selectedRecords.length] = row;
            }
            //alert("window close");
            $('#ccaddressWindow').jqxWindow('close');
        }; 
       
        
        
        
    </script>
    <div id="jqxAddressbook"></div>
        <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
</head>
 <body bgcolor="#E0ECF8">
<div id=btnok>
<table width="100%" >
  <tr >
   <td align="left"><input type="button" name="btnOk" id="btnOk" class="myButton" value="OK" onclick="funUpdate();"></td>
   </tr></br>
   </table>
   </div>
   </body>
   </html>
