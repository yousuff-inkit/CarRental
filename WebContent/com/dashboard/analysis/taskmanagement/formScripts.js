$(document).ready(function(){
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();
		$("#fromdate").jqxDateTimeInput({ width: '110px', height: '21px',formatString:"dd.MM.yyyy"});     
	    $("#todate").jqxDateTimeInput({ width: '110px', height: '21px',formatString:"dd.MM.yyyy"});
	    $("#jqxExpDateComp").jqxDateTimeInput({ width: '110px', height: '21px', formatString:"dd.MM.yyyy"});  
    	var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));   
		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	    $('#todate').on('change', function (event) {
			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  
		    if(fromdates>todates){  
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				   return false;
		    }
	    }); 
	    fromdateEnable();  
	    
	    $('#fromdtchk').on('change', function (event) {          
	    	  fromdateEnable();            
	    });
	    
	    getCountData();
 
        $('#btnsubmit').click(function(){ 
	        clearFields()    
            taskLoad()
            getCountData();
        });
 
        $('#btnexcel').click(function(){  
        	$("#taskdiv").excelexportjs({ 
        		containerid: "taskdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "pendingGrid",   
        		columns: getColumns("pendingGrid") ,   
        		worksheetName:"Task Management Main"  
         		});
         	
         	$("#subdiv").excelexportjs({ 
        		containerid: "subdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "taskfollowupGrid",   
        		columns: getColumns("taskfollowupGrid") ,     
        		worksheetName:"Task Management Sub"  
         		});
        });
 
        $("#btnschedule").click(function() { 
	        scheduleLoad()
	    	$("#modalschedule").modal('show');
	    });  
        
        $("#btnScheduleCreate").click(function() {    
	         funScheduleCreate();
	    });
	    
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#pendingGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
 
    function addGridFilters(filtervalue, datafield){     
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);  
    	filtergroup.addfilter(filter_or_operator, filter1);
    	$("#pendingGrid").jqxGrid('addfilter', datafield, filtergroup);  
    	$("#pendingGrid").jqxGrid('applyfilters');    
 	}
 
	function taskLoad(){
		 var fromdate = $('#fromdate').jqxDateTimeInput('val');     
	     var todate = $('#todate').jqxDateTimeInput('val');  
	     var fromdtchk = $('#fromdtchk').val();
		 $("#taskdiv").load("taskGrid.jsp?userid="+userid+"&fromdate="+fromdate+"&todate="+todate+"&id="+1+"&fromdtchk="+fromdtchk);     
    }
    
    function subLoad(){    
	     var docno = $('#docno').val();    
		 $("#subdiv").load("subGrid.jsp?docno="+docno+"&id="+1);        
    }
    
    function scheduleLoad(){
		$("#schdiv").load("scheduleGrid.jsp?id="+1);
    }
  
	function getCountData(){     
		var fromdate = $('#fromdate').jqxDateTimeInput('val');     
	    var todate = $('#todate').jqxDateTimeInput('val');  
	    var fromdtchk = $('#fromdtchk').val();        
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				$('.badge-Assigned').text(items[0]);
				$('.badge-Accepted').text(items[1]);  
				$('.badge-Completed').text(items[2]);   
				$('.badge-Confirmed').text(items[3]);      
			}      
			else
			{
			}  
		}
		x.open("GET","getCountData.jsp?fromdate="+fromdate+"&todate="+todate+"&userid="+userid+"&fromdtchk="+fromdtchk,true);             
		x.send();
    } 
    
    function fromdateEnable(){
	     clearFields()
	     getCountData();  
	     if(document.getElementById("fromdtchk").checked){  
		      $("#fromdate").jqxDateTimeInput({disabled:false}) 
		      $("#confirmgrp").show()     
	     }else{
		      $("#fromdate").jqxDateTimeInput({disabled:true})
		      $("#confirmgrp").hide() 
	     }        
    }
    
    function clearFields(){
	        $('.textpanel p').text(''); 
            $("#taskfollowupGrid").jqxGrid('clear');
            $("#pendingGrid").jqxGrid('clear');
        	document.getElementById("docno").value=""; 
        	document.getElementById("schrowindex").value="";  
    }
    
    function funScheduleCreate(){
	    var rowindex = $("#schrowindex").val();
		var type = $("#jqxScheduleGrid").jqxGrid('getcellvalue', rowindex, "typeid")
		var remarks = $("#jqxScheduleGrid").jqxGrid('getcellvalue', rowindex, "remarks")
		if(remarks=="" || remarks==null || typeof(remarks)=="undefined" || typeof(remarks)=="NaN"){     
			    swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Select a Document!!!'   
					});
	  		      return false;      
	    }
		var userid = $("#hiduser").val();
		if(userid=="" || userid==null){     
			    swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Select a User!!!'
					});
	  		      return false;      
	    }
		var edcdate = $("#jqxExpDateComp").val();
		var refno = $("#txtrefno").val();
		var currentDate = new Date();
		var createduser = userid;     
		var stdate = currentDate.getFullYear() + '-' + ('0' + (currentDate.getMonth() + 1)).slice(-2) + '-' + ('0' + currentDate.getDate()).slice(-2);
		var sttime = ('0' + currentDate.getHours()).slice(-2) + ':' + ('0' + currentDate.getMinutes()).slice(-2) + ':' + ('0' + currentDate.getSeconds()).slice(-2);
		Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to create Task?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						CreateTask(type, userid, edcdate, remarks, refno, stdate, sttime, createduser);	
					}
			});
    }  
    
    function CreateTask(type, userid, edcdate, remarks, refno, stdate, sttime, createduser){            
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim(); 
				if(parseInt(items)>0){
					$("#hiduser").val('')
					$("#jqxInputUser").val('')
					$("#txtrefno").val('') 
					$("#jqxExpDateComp").val(new Date())  
					getCountData();taskLoad();subLoad();scheduleLoad();  
					$("#modalschedule").modal('hide');  
					swal.fire({  
					    icon: 'success',
						title: 'Success',
						text: 'Successfully Created'   
					});
				}else{
					swal.fire({  
					    icon: 'error',
						title: 'Error',
						text: 'Not Created'
					});
				}
			} else {}    
		}
		x.open("GET", contPath+"com/dashboard/saveTask.jsp?reftype="+type+"&hiduser="+userid+"&userid="+createduser+"&sdate="+stdate+"&stime="+sttime+"&edcdate="+edcdate+"&desc="+encodeURIComponent(remarks)+"&refno="+encodeURIComponent(refno), true);          
		x.send();  
   }   