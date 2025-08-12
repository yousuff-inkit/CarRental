<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.employeeanalysis.ClsEmployeeAnalysisDAO"%>

<% ClsEmployeeAnalysisDAO DAO= new ClsEmployeeAnalysisDAO (); %>
<% 
   String department = request.getParameter("department")==null?"":request.getParameter("department");
   String category = request.getParameter("category")==null?"":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"":request.getParameter("empId");
   String employeebranchchk = request.getParameter("employeebranchchk")==null?"":request.getParameter("employeebranchchk"); 
   String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
   int check = request.getParameter("check")==null || request.getParameter("check").trim().equals("")?0:Integer.parseInt(request.getParameter("check").toString()); %> 

<script type="text/javascript">

	var check='<%=check%>';
	var temp ='';
	
	$(document).ready(function () {
		var data ="";
		
		if(parseInt(check)==1||parseInt(check)==2){
	   	    data = '<%=DAO.empload(department, category, empId, check, employeebranchchk, branch)%>';  
	   	 }else{
	   		data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"4%"},{"text":"Emp ID","datafield":"empid","cellsAlign":"left","align":"left","width":"7%"},{"text":"Name","datafield":"name","cellsAlign":"left","align":"left","width":"10%"},{"text":"Designation","datafield":"designation","cellsAlign":"left","align":"left","width":"7%"},{"text":"Department","datafield":"department","cellsAlign":"left","align":"left","width":"7%"},{"text":"Category","datafield":"category","cellsAlign":"left","align":"left","width":"7%"},{"text":"Date of Join","datafield":"dtjoin","cellsAlign":"left","align":"left","width":"6%"},{"text":"Address","datafield":"address","cellsAlign":"left","align":"left","width":"7%"},{"text":"Mobile","datafield":"mobile","cellsAlign":"left","align":"left","width":"7%"},{"text":"Email Id","datafield":"email","cellsAlign":"left","align":"left","width":"10%"},{"text":"DOB","datafield":"dob","cellsAlign":"left","align":"left","width":"9%"},{"text":"Gender","datafield":"gender","cellsAlign":"left","align":"left","width":"7%"},{"text":"Bank Account","datafield":"bankaccount","cellsAlign":"left","align":"left","width":"7%"},{"text":"IFSC Code","datafield":"ifsccode","cellsAlign":"left","align":"left","width":"7%"},{"text":"Est. Code","datafield":"estcode","cellsAlign":"left","align":"left","width":"7%"},{"text":"Company","datafield":"compname","cellsAlign":"left","align":"left","width":"7%"},{"text":"Status","datafield":"status","cellsAlign":"left","align":"left","width":"7%"},{"text":"Basic Salary","datafield":"basicsalary","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2"},{"text":"Branch","datafield":"branchname","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2"},{"text":"Allowance","datafield":"allowance1","cellsAlign":"right","align":"right","width":"7%","cellsFormat":"d2"},{"text":"Document No","datafield":"docidnum1","cellsAlign":"left","align":"left","width":"7%"},{"text":"Issue Date","datafield":"issdt1","cellsAlign":"left","align":"left","width":"10%"},{"text":"Exp. Date","datafield":"expdt1","cellsAlign":"left","align":"left","width":"10%"},{"text":"Place of Issue","datafield":"placeofiss1","cellsAlign":"left","align":"left","width":"12%"}]},{"rows":[{"id":"1","empid":"","name":"","designation":"","department":"","category":"","dtjoin":"","address":"","mobile":"","email":"","dob":"","gender":"","bankaccount":"","ifsccode":"","estcode":"","compname":"","status":"","basicsalary":"","branchname":"","allowance1":"","docidnum1":"","issdt1":"","expdt1":"","placeofiss1":""},{"text":"BranchId","datafield":"branchid","cellsAlign":"center","align":"left","width":"10%","hidden":"true"},{"text":"Empdocno","datafield":"empdocno","cellsAlign":"center","align":"left","width":"10%","hidden":"true"}]}]';
		}
		var obj = $.parseJSON(data);
        var columns = obj[0].columns;
        var rows = obj[1].rows;
        var source =
        {
            datatype: "json",
            datafields: [
					{ name: 'id', type: "int" },
					{ name: 'empid', type: "string" },
                    { name: 'name', type: "string" },
                    { name: 'designation', type: "string" },
                    { name: 'department', type: "string" },
                    { name: 'category', type: "string" },
                    { name: 'dtjoin', type: "date" },
                    { name: 'address', type: "string" },
                    { name: 'mobile', type: "string" },
                    { name: 'email', type: "string" },
                    { name: 'dob', type: "date" },
                    { name: 'gender', type: "string" },
                    { name: 'bankaccount', type: "string" },
                    { name: 'ifsccode', type: "string" },
                    { name: 'estcode', type: "string" },
                    { name: 'compname', type: "string" },
                    { name: 'status', type: "string" },
                    { name : 'basicsalary', type: "number" },
						{name : 'allowance1', type: "number"   },
						{name : 'allowance2', type: "number"  },
						{name : 'allowance3', type: "number"   },
						{name : 'allowance4', type: "number"   },
						{name : 'allowance5', type: "number" },
						{name : 'allowance6', type: "number"  },
					{name : 'allowance7', type: "number" },
					{name : 'allowance8', type: "number"  },
						{name : 'allowance9', type: "number" },
						{name : 'allowance10', type: "number" },
						{ name: 'docidnum1', type: "string" },
						{ name: 'issdt1', type: "date" },
						{ name: 'expdt1', type: "date" },
						{ name: 'placeofiss1', type: "string" },
						{ name: 'docidnum2', type: "string" },
						{ name: 'issdt2', type: "date" },
						{ name: 'expdt2', type: "date" },
						{ name: 'placeofiss2', type: "string" },
						{ name: 'docidnum3', type: "string" },
						{ name: 'issdt3', type: "date" },
						{ name: 'expdt3', type: "date" },
						{ name: 'placeofiss3', type: "string" },
						{ name: 'docidnum4', type: "string" },
						{ name: 'issdt4', type: "date" },
						{ name: 'expdt4', type: "date" },
						{ name: 'placeofiss4', type: "string" },
						{ name: 'docidnum5', type: "string" },
						{ name: 'issdt5', type: "date" },
						{ name: 'expdt5', type: "date" },
						{ name: 'placeofiss5', type: "string" },
						{ name: 'docidnum6', type: "string" },
						{ name: 'issdt6', type: "date" },
						{ name: 'expdt6', type: "date" },
						{ name: 'placeofiss6', type: "string" },
						{ name: 'docidnum7', type: "string" },
						{ name: 'issdt7', type: "date" },
						{ name: 'expdt7', type: "date" },
						{ name: 'placeofiss7', type: "string" },
						{ name: 'docidnum8', type: "string" },
						{ name: 'issdt8', type: "date" },
						{ name: 'expdt8', type: "date" },
						{ name: 'placeofiss8', type: "string" },
						{ name: 'docidnum9', type: "string" },
						{ name: 'issdt9', type: "date" },
						{ name: 'expdt9', type: "date" },
						{ name: 'placeofiss9', type: "string" },
						{ name: 'docidnum10', type: "string" },
						{ name: 'issdt10', type: "date" },
						{ name: 'expdt10', type: "date" },
						{ name: 'branchname', type: "string" },
						{ name: 'placeofiss10', type: "string" },
						{ name: 'branchid', type: "string" },
						{ name: 'rtastatus', type: 'String' },
             			{ name: 'rtastatusid', type: 'String' },
             			{ name: 'isrtaavail', type: 'String' },
						{ name: 'empdocno', type: "string" },
			            
            ],
            id: 'id',
            localdata: rows
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#employeeanalysis").jqxGrid(
        {
        	width: '100%',
            height: 515,
            source: dataAdapter,
            //pageable: true,
            altRows: true,
            sortable: true,
            selectionmode: 'singlerow',  
            filterable: true,
            showfilterrow: true,
            enabletooltips:true,
            columnsresize: true,
            //pagermode: 'default',
            sortable: true,
        	columns: columns
        });
        
		$("#overlay, #PleaseWait").hide();

		 $('#employeeanalysis').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
			 var rowData = $("#employeeanalysis").jqxGrid('getrowdata', rowindex1);
              document.getElementById("branchid").value= $('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "branchid");
              document.getElementById("empdocno").value= $('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "empdocno");
              $('.textpanel p').text($('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "empid")+' - '+$('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "name"));   
              document.getElementById("lblotherdetails1").innerHTML=$('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "empid")+' - '+$('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "name");   
              document.getElementById("lblotherdetails2").innerHTML=$('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "empid")+' - '+$('#employeeanalysis').jqxGrid('getcellvalue', rowindex1, "name");   
              rowData.isrtaavail==1?$("#rtacardavailable").prop('checked', true):$("#rtacardavailable").prop('checked', false);
              temp = rowData.rtastatusid;     
		 });   
		 
		   
		 
	 });
	  		
     
		
                       
</script>
<div id="employeeanalysis"></div>