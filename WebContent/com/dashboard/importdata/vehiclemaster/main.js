$(document).ready(function(){  
	    $("#btnconfirm").attr({'disabled':true});	
    	$('[data-toggle="tooltip"]').tooltip();    
		$("#vehicleGrid").jqxGrid('clear');
		$('#clientaccinfowindow').jqxWindow({ width: '40%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' ,title: ' Client Search' , position: { x: 150, y: 70 }, keyboardCloseKey: 27});
	   	 $('#clientaccinfowindow').jqxWindow('close');
	   	 
		$('#btnsubmit').click(function(){   
	          funcleardata();
			  funload();
			  funConfirmEnable();
			  $('.textpanel p').text('');  
		});
		
		$('#btnexcel').click(function(){
			$("#vehiclediv").excelexportjs({  
				containerid: "vehiclediv",
				datatype: 'json',
				dataset: null,
				gridId: "vehicleGrid",
				columns: getColumns("vehicleGrid"),
				worksheetName: "Vehicle Master "
			});
		});
		
        $('#btnimport').click(function(){
       		upload();
        });
       
         $('#btnconfirm').click(function(){
        	funconfirm();
        });
        
        $('#btnauthority').click(function() {
        	var type = "AUTHORITY";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbauth');  
   		    $('#authdiv').load("authorityGrid.jsp?id="+1);     
            $('#modalAuthority').modal('toggle');       
        });
        
        $('#btnplatecode').click(function() {
        	var type = "PLATECODE";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbplc');
   		    $('#platediv').load("platecodeGrid.jsp?id="+1);     
            $('#modalPlatecode').modal('toggle');          
        });
        
        $('#btnbrand').click(function() {
        	var type = "BRAND";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbbrand');
   		    $('#brddiv').load("brandGrid.jsp?id="+1);     
            $('#modalBrand').modal('toggle');       
        });
        
        $('#btnmodel').click(function() { 
        	var type = "MODEL";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbmodel');
   		    $('#mdldiv').load("modelGrid.jsp?id="+1);     
            $('#modalModel').modal('toggle');       
        });
        
        $('#btnyom').click(function() { 
        	var type = "YOM";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbyom');
   		    $('#yomdiv').load("yomGrid.jsp?id="+1);     
            $('#modalYOM').modal('toggle');       
        });
        
        $('#btncolor').click(function() {   
        	var type = "COLOR";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbcolor');  
   		    $('#clrdiv').load("colorGrid.jsp?id="+1);     
            $('#modalColor').modal('toggle');         
        });
        
        $('#btngroup').click(function() {   
        	var type = "Group";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbgroup');  
   		    $('#groupdiv').load("groupGrid.jsp?id="+1);     
            $('#modalGroup').modal('toggle');         
        });
        
        $('#btnspecification').click(function() {   
        	var type = "Specification";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbspecification');  
   		    $('#specificationdiv').load("specificationGrid.jsp?id="+1);     
            $('#modalSpecification').modal('toggle');         
        });
        
        $('#btnproject').click(function() {   
        	var type = "Project";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbproject');  
   		    $('#projectdiv').load("projectGrid.jsp?id="+1);     
            $('#modalProject').modal('toggle');  
        });
        
        $('#btndealer').click(function() {   
        	var type = "Dealer";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbdealer');  
   		    $('#dealerdiv').load("dealerGrid.jsp?id="+1);     
            $('#modalDealer').modal('toggle');         
        });
        
        $('#btninsurance').click(function() {   
        	var type = "Insurace";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbinsurance');  
   		    $('#insurancediv').load("insuranceGrid.jsp?id="+1);     
            $('#modalInsurance').modal('toggle');         
        });
        
        $('#btnfinance').click(function() {   
        	var type = "Finance";
        	populateSelectBox('getVehData.jsp?type='+type, 'cmbfinance');  
   		    $('#financediv').load("financeGrid.jsp?id="+1);     
            $('#modalFinance').modal('toggle');         
        });
        
        
        $("#cmbauth").select2({
		    placeholder: "Select an Authority",
		    allowClear: true
		});
        
        $("#cmbplc").select2({
		    placeholder: "Select a Plate Code",
		    allowClear: true
		});
        
        $("#cmbbrand").select2({
		    placeholder: "Select a Brand",
		    allowClear: true
		});
        
        $("#cmbmodel").select2({
		    placeholder: "Select a Model",
		    allowClear: true
		});
        
        $("#cmbyom").select2({
		    placeholder: "Select a YOM",
		    allowClear: true
		});
        
        $("#cmbcolor").select2({
		    placeholder: "Select a Color",
		    allowClear: true
		});
        
        $("#cmbgroup").select2({
		    placeholder: "Select a Group",
		    allowClear: true
		});
        
        $("#cmbspecification").select2({
		    placeholder: "Select a Specification",
		    allowClear: true
		});
        
        $("#cmbfinance").select2({
		    placeholder: "Select a Finance",
		    allowClear: true
		});
        
        $("#cmbproject").select2({
		    placeholder: "Select a Project",
		    allowClear: true
		});
        
        $("#cmbdealer").select2({
		    placeholder: "Select a Dealer",
		    allowClear: true
		});
        
        $("#cmbinsurance").select2({
		    placeholder: "Select a Insurance",
		    allowClear: true
		});
		
		$('#btnsaveAuthority').click(function() {     
			 var type = "Authority";  
        	 funAuthoritySave(type, "modalAuthority");      
        });
		
		$('#btnupdateAuthority').click(function() {  
			 var type = "Authority";  
        	 funAuthorityUpdate(type, "modalAuthority");     
        });
        
        $('#btnsavePlatecode').click(function() {     
			 var type = "Platecode";  
        	 funPlatecodeSave(type, "modalPlatecode");      
        });
		
		$('#btnupdatePlatecode').click(function() {  
			 var type = "Platecode";  
        	 funPlatecodeUpdate(type, "modalPlatecode");     
        });
        
        $('#btnsaveBrand').click(function() {     
			 var type = "Brand";  
        	 funBrandSave(type, "modalBrand");      
        });
		
		$('#btnupdateBrand').click(function() {    
			 var type = "Brand";  
        	 funBrandUpdate(type, "modalBrand");     
        });
        
        $('#btnsaveModel').click(function() {     
			 var type = "Model";  
        	 funModelSave(type, "modalModel");      
        });
		
		$('#btnupdateModel').click(function() {  
			 var type = "Model";  
        	 funModelUpdate(type, "modalModel");     
        });
        
        $('#btnsaveYOM').click(function() {     
			 var type = "YOM";  
        	 funYOMSave(type, "modalYOM");      
        });
		
		$('#btnupdateYOM').click(function() {  
			 var type = "YOM";  
        	 funYOMUpdate(type, "modalYOM");     
        });
        
        $('#btnsaveColor').click(function() {     
			 var type = "Color";  
        	 funColorSave(type, "modalColor");      
        });
		
		$('#btnupdateColor').click(function() {  
			 var type = "Color";  
        	 funColorUpdate(type, "modalColor");     
        });
		
		$('#btnsaveGroup').click(function() {     
			 var type = "Group";  
       	 funGroupSave(type, "modalGroup");      
       });
		
		$('#btnupdateGroup').click(function() {  
			 var type = "Group";  
       	 funGroupUpdate(type, "modalGroup");     
       });
		
		$('#btnsaveSpecification').click(function() {     
			 var type = "Specification";  
      	 funSpecificationSave(type, "modalSpecification");      
      });
		
		$('#btnupdateSpecification').click(function() {  
			 var type = "Specification";  
      	 funSpecificationUpdate(type, "modalSpecification");     
      });
		
		$('#btnsaveProject').click(function() {     
			 var type = "Project";  
     	 funProjectSave(type, "modalProject");      
     });
		
		$('#btnupdateProject').click(function() {  
			 var type = "Project";  
     	 funProjectUpdate(type, "modalProject");     
     });
		
		$('#btnsaveDealer').click(function() {     
			 var type = "Dealer";  
    	 funDealerSave(type, "modalDealer");      
    });
		
		$('#btnupdateDealer').click(function() {  
			 var type = "Dealer";  
    	 funDealerUpdate(type, "modalDealer");     
    });
       
		$('#btnsaveInsurance').click(function() {     
			 var type = "Insurance";  
   	 funInsuranceSave(type, "modalInsurance");      
   });
		
		$('#btnupdateInsurance').click(function() {  
			 var type = "Insurance";  
   	 funInsuranceUpdate(type, "modalInsurance");     
   });
	
		$('#btnsaveFinance').click(function() {     
			 var type = "Finance";  
  	 funFinanceSave(type, "modalFinance");      
  });
		
		$('#btnupdateFinance').click(function() {  
			 var type = "Finance";  
  	 funFinanceUpdate(type, "modalFinance");     
  });	
		
	 });
   
		function getClientAcc(rowBoundIndex){ 
			    $('#clientaccinfowindow').jqxWindow('open');
		    clientaccSearchContent('clientAccGrid.jsp?rowBoundIndex='+rowBoundIndex);
		}
		     	 
		function clientaccSearchContent(url) { 
			 $.get(url).done(function (data) { 
				$('#clientaccinfowindow').jqxWindow('setContent', data);
		 }); 
		}
	 	function funRoundAmt(value,id){
			  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
	 	}   
	 
		function funload(){
			$('#vehiclediv').load('vehicleGrid.jsp?id=1');    
		}
	
		function  funcleardata() {
			 $("#vehicleGrid").jqxGrid('clear');
		}
		
		function funConfirmEnable(){    
			    var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200) {   
						var items = x.responseText.trim();
						if(parseInt(items)==0){
							 $("#btnconfirm").attr({'disabled':false});		 
						}else{
							 $("#btnconfirm").attr({'disabled':true});	
						}
				  }
				}
				x.open("GET","getConfirmChk.jsp",true);       
				x.send();
		 }
		 
		 function funValidate(dataarr, type){
			    var val = 0;
			    var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200) {   
						var items = x.responseText.trim();
						if(items!=""){
								swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: items           
								});
								val = 1;
						}else{
							 val = 0;
						}
				  }
				}
				x.open("GET","validateData.jsp?dataarr="+encodeURIComponent(dataarr)+"&type="+type,false);       
				x.send();
				
				return val;
		 }
		 
		function getAttachDocumentNo(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items>0){
						
						var path=document.getElementById("fileexcelimport").value;
						var fsize = $('#fileexcelimport')[0].files[0].size;
						var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
						
						if((extn=='xls') || (extn=='csv')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
			                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
			                     }); 
						            return;
					     } 
					}
					
			  }
			}
				
		x.open("GET","getAttachDocumentNo.jsp",true);
		x.send();
		}
		
		function upload(){
			getAttachDocumentNo();
		 }
		
		function ajaxFileUpload(docNo) {  
			
			 /*  var jvtdate = $("#jqxJournalVouchersDate").val();
   		      var newDate = jvtdate.split('.');
   		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
   		   */
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        var fsize = $('#fileexcelimport')[0].files[0].size;
			        
			        if(fsize>1048576) {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                          style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                      }); 
			            return;
			        }
			    }else{
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=VHM&doc_no='+docNo+'&descpt=Excel Import' ,
	                  secureuri:false,  
	                  fileElementId:'fileexcelimport',    
	                  dataType: 'json', 
	                  success: function (data, status)   
	                  {  
	                     
	                     if(status=='success'){
	                         saveExcelDataData(docNo);
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	              	          }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e){  
	                      $.messager.alert('Message',e);
	                  }  
	              });  
	          return false;  
	      }
		function saveExcelDataData(docNo){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1){
						$("#vehiclediv").load("vehicleGrid.jsp");
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
		function populateSelectBox(url, selectBoxId) {
		    var x = new XMLHttpRequest();
		    x.onreadystatechange = function() {
		        if (x.readyState == 4 && x.status == 200) {
		            var items = x.responseText.split('####');
		            var ids = items[0].split(",");
		            var names = items[1].split(",");
		            var options = '<option value="">--Select--</option>';
		            for (var i = 0; i < names.length; i++) {
		                options += '<option value="' + ids[i] + '">' + names[i] + '</option>';    
		            }
		            document.querySelector('select#' + selectBoxId).innerHTML = options;    
		        } 
		    };
		    x.open("GET", url, true);                       
		    x.send();  
		}
		
		function funAuthorityUpdate(type, modalid){
			var authid = $("#cmbauth").val();
		    var selectedrows=$("#jqxAuthorityGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(authid == "" || authid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Authority'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "authority");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "authority");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", authid, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funAuthoritySave(type, modalid){  
		    var selectedrows=$("#jqxAuthorityGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, authoritycheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var code = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "code");
				 if(code=="" || typeof(code)=="NaN" || typeof(code)=="undefined" || code==null){
					 codecheck=1;
				 }
                 
                 var authority = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "authority");
				 if(authority=="" || typeof(authority)=="NaN" || typeof(authority)=="undefined" || authority==null){
					 authoritycheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "code")+" :: "+$('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "authority");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "code")+" :: "+$('#jqxAuthorityGrid').jqxGrid('getcellvalue', selectedrows[i], "authority");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			
		    if(codecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Code'        
				});    
			  return false;
		    }
		    
		    if(authoritycheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Authority'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funPlatecodeUpdate(type, modalid){
			var platecodeid = $("#cmbplc").val();
		    var selectedrows=$("#jqxPlatecodeGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(platecodeid == "" || platecodeid == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select Plate Code'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "platecode");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "platecode");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", platecodeid, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funPlatecodeSave(type, modalid){  
		    var selectedrows=$("#jqxPlatecodeGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0, authchk = 0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var code = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "platecode");
				 if(code=="" || typeof(code)=="NaN" || typeof(code)=="undefined" || code==null){
					 codecheck=1;
				 }
                 
                 var auth = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "auth");
				 if(auth=="" || typeof(auth)=="NaN" || typeof(auth)=="undefined" || auth==null){
					 authchk=1;
				 }
				 
				 var name = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "name");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "platecode")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "name")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "auth")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "authid");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "platecode")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "name")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "auth")+" :: "+$('#jqxPlatecodeGrid').jqxGrid('getcellvalue', selectedrows[i], "authid");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			
			if(authchk==1){    
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Authority is missing'          
				});    
			  return false;
		    }
		    
		    if(codecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Plate Code'        
				});    
			  return false;
		    }
		    
		    if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Name'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funBrandUpdate(type, modalid){
			var docno = $("#cmbbrand").val();
		    var selectedrows=$("#jqxBrandGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Brand'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxBrandGrid').jqxGrid('getcellvalue', selectedrows[i], "brand");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxBrandGrid').jqxGrid('getcellvalue', selectedrows[i], "brand");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funBrandSave(type, modalid){  
		    var selectedrows=$("#jqxBrandGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxBrandGrid').jqxGrid('getcellvalue', selectedrows[i], "brand");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxBrandGrid').jqxGrid('getcellvalue', selectedrows[i], "brand");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxBrandGrid').jqxGrid('getcellvalue', selectedrows[i], "brand");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Brand'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funModelUpdate(type, modalid){
			var docno = $("#cmbmodel").val();
		    var selectedrows=$("#jqxModelGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Model'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "model");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "model");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funModelSave(type, modalid){  
		    var selectedrows=$("#jqxModelGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, brdcheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "model");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 	
				var brdid = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "brdid");
				 if(brdid=="" || typeof(brdid)=="NaN" || typeof(brdid)=="undefined" || brdid==null){
					 brdcheck=1;
				 }
				  				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "model")+" :: "+$('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "brdid");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "model")+" :: "+$('#jqxModelGrid').jqxGrid('getcellvalue', selectedrows[i], "brdid");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Model'        
				});    
			  return false;
		    }
		    
		    if(brdcheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Brand is missing'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funYOMUpdate(type, modalid){
			var docno = $("#cmbyom").val();
		    var selectedrows=$("#jqxYomGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select an YOM'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxYomGrid').jqxGrid('getcellvalue', selectedrows[i], "yom");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxYomGrid').jqxGrid('getcellvalue', selectedrows[i], "yom");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funYOMSave(type, modalid){  
		    var selectedrows=$("#jqxYomGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxYomGrid').jqxGrid('getcellvalue', selectedrows[i], "yom");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxYomGrid').jqxGrid('getcellvalue', selectedrows[i], "yom");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxYomGrid').jqxGrid('getcellvalue', selectedrows[i], "yom");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter YOM'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funColorUpdate(type, modalid){
			var docno = $("#cmbcolor").val();
		    var selectedrows=$("#jqxColorGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Color'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxColorGrid').jqxGrid('getcellvalue', selectedrows[i], "color");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxColorGrid').jqxGrid('getcellvalue', selectedrows[i], "color");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funColorSave(type, modalid){  
		    var selectedrows=$("#jqxColorGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxColorGrid').jqxGrid('getcellvalue', selectedrows[i], "color");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxColorGrid').jqxGrid('getcellvalue', selectedrows[i], "color");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxColorGrid').jqxGrid('getcellvalue', selectedrows[i], "color");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Color'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funGroupUpdate(type, modalid){
			var docno = $("#cmbgroup").val();
		    var selectedrows=$("#jqxGroupGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Group'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "group_name");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "group_name");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funGroupSave(type, modalid){  
		    var selectedrows=$("#jqxGroupGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "groupid");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "group_name")+"::"+$('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "groupid");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "group_name")+"::"+$('#jqxGroupGrid').jqxGrid('getcellvalue', selectedrows[i], "groupid");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Group ID'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funSpecificationUpdate(type, modalid){
			var docno = $("#cmbspecification").val();
		    var selectedrows=$("#jqxSpecificationGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Specification'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxSpecificationGrid').jqxGrid('getcellvalue', selectedrows[i], "spec");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxSpecificationGrid').jqxGrid('getcellvalue', selectedrows[i], "spec");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funSpecificationSave(type, modalid){  
		    var selectedrows=$("#jqxSpecificationGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxSpecificationGrid').jqxGrid('getcellvalue', selectedrows[i], "spec");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxSpecificationGrid').jqxGrid('getcellvalue', selectedrows[i], "spec");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxSpecificationGrid').jqxGrid('getcellvalue', selectedrows[i], "spec");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Specification'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funProjectUpdate(type, modalid){
			var docno = $("#cmbproject").val();
		    var selectedrows=$("#jqxProjectGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Project'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "project");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "project");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funProjectSave(type, modalid){  
		    var selectedrows=$("#jqxProjectGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "project");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "project")+" :: "+$('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "project")+" :: "+$('#jqxProjectGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Project'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funDealerUpdate(type, modalid){
			var docno = $("#cmbdealer").val();
		    var selectedrows=$("#jqxDealerGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Dealer'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxDealerGrid').jqxGrid('getcellvalue', selectedrows[i], "dealer");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxDealerGrid').jqxGrid('getcellvalue', selectedrows[i], "dealer");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funDealerSave(type, modalid){  
		    var selectedrows=$("#jqxDealerGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxDealerGrid').jqxGrid('getcellvalue', selectedrows[i], "dealer");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxDealerGrid').jqxGrid('getcellvalue', selectedrows[i], "dealer");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxDealerGrid').jqxGrid('getcellvalue', selectedrows[i], "dealer");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Dealer'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funInsuranceUpdate(type, modalid){
			var docno = $("#cmbinsurance").val();
		    var selectedrows=$("#jqxInsuranceGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Insurance'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "ins_type");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "ins_type");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funInsuranceSave(type, modalid){  //1
		    var selectedrows=$("#jqxInsuranceGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i = 0, codecheck = 0, namecheck = 0;
	        var temptrno = "";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "ins_type");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "ins_type")+" :: "+$('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "ins_type")+" :: "+$('#jqxInsuranceGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Insurance'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function funFinanceUpdate(type, modalid){
			var docno = $("#cmbfinance").val();
		    var selectedrows=$("#jqxFinanceGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
					});
				return false;
			}  
			
			if(docno == "" || docno == "0"){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a Finance'        
					});
				return false;
			}  
	        
	        var i=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				if(i == 0){      
					 var srvdetmtrno = $('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "financier");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "financier");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveVehData("update", docno, temptrno, type, modalid);  
					}
			});  
		       
		}
		
		function funFinanceSave(type, modalid){   
		    var selectedrows=$("#jqxFinanceGrid").jqxGrid('selectedrowindexes');
		    selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
				swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select documents'        
				});
				return false;  
			}   
   
	        var i=0, codecheck=0, namecheck=0;
	        var temptrno="";    
			for (i = 0; i < selectedrows.length; i++) {
				 var name = $('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "financier");
				 if(name=="" || typeof(name)=="NaN" || typeof(name)=="undefined" || name==null){
					 namecheck=1;
				 }
				 				 
				if(i == 0){      
					 var srvdetmtrno = $('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "financier")+" :: "+$('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "code")+" :: "+$('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = srvdetmtrno;   
				} else{  
					 var srvdetmtrno = $('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "financier")+" :: "+$('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "code")+" :: "+$('#jqxFinanceGrid').jqxGrid('getcellvalue', selectedrows[i], "accdoc");
					 temptrno = temptrno+","+srvdetmtrno;  
				}
			}  
			 
			 if(namecheck==1){  
		    	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter Finance'        
				});    
			  return false;
		    }
		    
		    var validate = funValidate(temptrno, type);
		    if(validate==1){  
			  	return false;   
		    }
		    
		    Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {  
						saveVehData("save", "", temptrno, type, modalid);    
					}else{
					}
			});     
		}
		
		function saveVehData(process, docno, temptrno, type, modalid){         
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items=x.responseText.trim();
					if(parseInt(items)>0){
						$('#'+modalid).modal('toggle');
						funload();
						funConfirmEnable();
						if(process=="update"){
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Updated Successfully'        
							});
						}else{
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Successfully Saved'        
							});
						}
					}else{
						if(process=="update"){  
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Updated'        
							});
						}else{
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Saved'        
							});
						}
					}
			  }
			}
			x.open("GET","saveVehData.jsp?process="+process+"&type="+type+"&docno="+docno+"&dataarr="+encodeURIComponent(temptrno),true);         
			x.send();
		}   
		
		function funconfirm(){
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {     
					if (result.isConfirmed) {    
						Saveconfirm("Confirm");      
					}else{
					}
			});  
			
		}
		
		function Saveconfirm(process){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {   
					var items=x.responseText.trim();
					if(parseInt(items)>0){
						funload();
							swal.fire({  
								    icon: 'success',
									title: 'Success',
									text: 'Successfully Confirmed'            
							});
					}else{
							swal.fire({  
								    icon: 'error',
									title: 'Error',
									text: 'Not Confirmed'        
							});
						 
					}
					
			  }
			}
			x.open("GET","saveVehData.jsp?type="+process,true);       
			x.send();
		}