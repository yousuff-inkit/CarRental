<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style type="text/css">
/* =========================================================
SCOPED UI: Compact Formula Modal Layout
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 15px;
    box-sizing: border-box;
    width: 100%;
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
}

/* Flexbox Layout for Columns */
.modern-ui .split-panel {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
}

.modern-ui .left-column {
    flex: 0 0 35%;
}

.modern-ui .right-column {
    flex: 1;
}

/* Fieldset Styling */
.modern-ui fieldset {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 10px;
    margin: 0;
    background: #fff;
    height: 100%;
    box-sizing: border-box;
}

.modern-ui legend {
    font-weight: bold;
    color: #0056b3;
    padding: 0 5px;
    font-size: 12px;
}

/* Fake "Inputs" that look like clickable links */
.modern-ui .field-item {
    color: #e4685d;
    font-weight: bold;
    cursor: pointer;
    padding: 5px;
    margin-bottom: 2px;
    border-radius: 3px;
    transition: background 0.2s;
    user-select: none;
}
.modern-ui .field-item:hover {
    background-color: #f0f0f0;
}

/* Expression Text Area */
.modern-ui textarea {
    width: 100%;
    height: 150px;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 8px;
    font-size: 14px;
    font-family: monospace;
    box-sizing: border-box;
    resize: none;
    text-transform: uppercase;
}
.modern-ui textarea:focus {
    border-color: #007bff;
    outline: none;
}

/* Button Bar Flexbox Container */
.modern-ui .operator-bar {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    align-items: center;
}

/* Operator Buttons */
.modern-ui .op-btn {
    width: 32px;
    height: 28px;
    background-color: #6c757d;
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: background 0.2s;
}
.modern-ui .op-btn:hover { background-color: #5a6268; }

/* Action Buttons */
.modern-ui .action-btn {
    height: 28px;
    padding: 0 16px;
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    transition: all 0.2s;
    margin-left: auto; /* Pushes OK/Close to the right */
}

.modern-ui .btn-ok { background-color: #28a745; margin-left: 15px; }
.modern-ui .btn-ok:hover { background-color: #218838; }

.modern-ui .btn-close { background-color: #dc3545; }
.modern-ui .btn-close:hover { background-color: #c82333; }

/* Description Text */
.modern-ui .desc-text {
    color: #b22222;
    font-size: 12px;
    font-weight: bold;
    min-height: 15px;
    margin-top: 10px;
    display: block;
}
</style>

<% String id = request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
$(document).ready(function () {   
	
	var ided='<%=id%>';
	if(document.getElementById(ided)) {
	    document.getElementById("expression").value=document.getElementById(ided).value;
	}
	
	/* Hover Descriptions */
	$('#days').click(function(){ document.getElementById("desc").innerText=" No.of Days Within The Month"; }); 
	$('#years').click(function(){ document.getElementById("desc").innerText=" No.of Days Within The Year"; }); 
	$('#hrs').click(function(){ document.getElementById("desc").innerText=" Minimum Hours To Be Worked"; }); 
	$('#nh').click(function(){ document.getElementById("desc").innerText=" Per Hour Rate"; }); 
	$('#basic').click(function(){ document.getElementById("desc").innerText=" Basic Salary"; }); 
	$('#amount').click(function(){ document.getElementById("desc").innerText=" Calculating Field Value (Salary/Allowance)"; }); 
	
	$('#closebtn').click(function(){
		 $('#formulawindow').jqxWindow('close');
	}); 
	
	/* Double Click Insertions */
	$('#days').dblclick(function(){ setval("[DAYS]"); }); 
	$('#years').dblclick(function(){ setval("[YEARS]"); }); 
	$('#hrs').dblclick(function(){ setval("[HRS]"); }); 
	$('#nh').dblclick(function(){ setval("[NH]"); }); 
	$('#basic').dblclick(function(){ setval("[BASIC]"); }); 
	$('#amount').dblclick(function(){ setval("[GROSS]"); }); 
	
	/* Operators */
	$('#a').click(function(){ setval("+"); }); 
	$('#s').click(function(){ setval("-"); }); 
	$('#m').click(function(){ setval("*"); }); 
	$('#d').click(function(){ setval("/"); }); 
	$('#ex').click(function(){ setval("!"); }); 
	$('#equal').click(function(){ setval("="); }); 
	$('#less').click(function(){ setval("<"); }); 
	$('#grater').click(function(){ setval(">"); }); 
	$('#amp').click(function(){ setval("&"); });
	$('#sep').click(function(){ setval("|"); });
	$('#open').click(function(){ setval("("); });
	$('#close').click(function(){ setval(")"); });
	
	$('#okbtn').click(function(){
    	var ids='<%=id%>';
    	var no=document.getElementById("expression").value;
    	
    	if(no.indexOf('+')== -1 && no.indexOf('-')== -1 && no.indexOf('*')== -1 &&  no.indexOf('/')== -1 &&  no.indexOf('!')== -1 &&  no.indexOf('=')== -1 &&  no.indexOf('<')== -1 &&  no.indexOf('>')== -1 &&  no.indexOf('|')== -1 &&  no.indexOf('&')== -1 &&  no.indexOf('(')== -1 &&  no.indexOf(')') == -1)
    	{  
    	  if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText=" Not A Valid Expression";
    	  document.getElementById("expression").focus();
    	  return 0;
    	}
    	else
    	{
    	  if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
    	  if(document.getElementById(ids)) {
        	  document.getElementById(ids).value="";
        	  document.getElementById(ids).value=document.getElementById("expression").value;
    	  }
    	  $('#formulawindow').jqxWindow('close');
    	}
	});
}); 

function setval(values) {
	document.getElementById("expression").value=document.getElementById("expression").value+values;
}
</script>

</head>

<body>

<div class="modern-ui">

    <div class="split-panel">
        
        <div class="left-column">
            <fieldset>
                <legend>Fields - Double Click To Insert</legend>
                <div class="field-item" id="days">DAYS</div>
                <div class="field-item" id="years">YEARS</div>
                <div class="field-item" id="hrs">HRS</div>
                <div class="field-item" id="nh">NH</div>
                <div class="field-item" id="basic">BASIC</div>
                <div class="field-item" id="amount">GROSS</div>
            </fieldset>
        </div>

        <div class="right-column">
            <fieldset>
                <legend>Expression</legend>
                <textarea id="expression" name="expression" onkeypress="if (this.value.length > 100) { return false; }"></textarea>
            </fieldset>
        </div>

    </div>

    <fieldset>
        <div class="operator-bar">
            <input type="button" class="op-btn" name="a" id="a" value="+"> 
            <input type="button" class="op-btn" name="s" id="s" value="-"> 
            <input type="button" class="op-btn" name="m" id="m" value="*"> 
            <input type="button" class="op-btn" name="d" id="d" value="/"> 
            <input type="button" class="op-btn" name="ex" id="ex" value="!"> 
            <input type="button" class="op-btn" name="equal" id="equal" value="="> 
            <input type="button" class="op-btn" name="less" id="less" value="<"> 
            <input type="button" class="op-btn" name="grater" id="grater" value=">"> 
            <input type="button" class="op-btn" name="amp" id="amp" value="&">  
            <input type="button" class="op-btn" name="sep" id="sep" value="|">
            <input type="button" class="op-btn" name="open" id="open" value="("> 
            <input type="button" class="op-btn" name="close" id="close" value=")"> 
            
            <input type="button" class="action-btn btn-ok" name="okbtn" id="okbtn" value="OK"> 
            <input type="button" class="action-btn btn-close" name="closebtn" id="closebtn" value="Close">
        </div>
    </fieldset>

    <span class="desc-text" id="desc">&nbsp;</span>

</div>

</body>
</html>