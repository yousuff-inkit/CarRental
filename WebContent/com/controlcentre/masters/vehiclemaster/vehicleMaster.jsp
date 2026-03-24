<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>


<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO(); %>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
		$('#leasecdwdiv').hide();
		var cdwstatus='<%=cdwdao.getActiveStatus()%>';
		if(cdwstatus=="1"){
			$('#leasecdwdiv').show();
		}
		else{
			$('#leasecdwdiv').hide();
		}
	});
	document.addEventListener("DOMContentLoaded", function () {
		  const buttons = document.querySelectorAll(".myButton");

		  buttons.forEach(btn => {
		    btn.addEventListener("click", function () {
		      // Remove active from all buttons
		      buttons.forEach(b => b.classList.remove("active"));

		      // Add active to clicked button
		      this.classList.add("active");
		    });
		  });

		  // ✅ Auto-highlight first button on page load
		  if (buttons.length > 0) {
		    buttons[0].classList.add("active");
		  }
		});
	</script>

<style type="text/css">
/* Create a flex container for the whole page */
body {
  display: flex;
  margin: 0;
  padding: 0;
  height: 100vh;
  overflow: hidden;
  font-family: sans-serif;
}

/* Sidebar Navigation */
#nav {
  width: 220px; /* Fixed width for sidebar */
  height: 100vh;
  padding: 20px 15px;
  box-sizing: border-box;
  background: #f8fafc;
  border-right: 1px solid #ddd;
  overflow-y: auto; /* Scrollable if many buttons */
}

/* Change grid to 1 column for vertical stacking */
.nav-buttons {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.nav-item {
  width: 100%;
}

.myButton {
  font-weight: 700;
  font-size: 13px;
  width: 90%; 
  height: 32px;
  padding: 8px 12px;
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
  color: #ffffff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-transform: uppercase;
  letter-spacing: 0.3px;
  text-align: left; 
  padding-left: 15px;
}

.myButton.active {
  background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
  transform: translateX(5px); /* Subtle shift to the right when active */
}

/* Content Area */
#comiframe {
  flex-grow: 1; /* Take up all remaining width */
  height: 100vh;
  background: #fff;
}

#comiframe iframe {
  width: 100%;
  height: 100%;
  border: none;
}

body::-webkit-scrollbar {
  width: 0px;
}
</style>


</head>
<body >
<div id="nav">
    <div id="header">
        <h3>Veh.Related Master</h3>
        <hr style="border: 0; border-top: 1px solid #ccc; margin: 15px 0;">
    </div>
  <div class="nav-buttons">
    <div class="nav-item"><input type="button" name="btnbrand" class="myButton" value="Brand" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnmodel" class="myButton" value="Model" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/model.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnauthority" class="myButton" value="Authority" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/authority.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnplatecode" class="myButton" value="Plate Code" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/plateCode.jsp";'></div>
    <div class="nav-item"><input type="button" name="btngroup" class="myButton" value="Group" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/group.jsp";'></div>
    <div class="nav-item"><input type="button" name="btndealer" class="myButton" value="Dealer" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/dealer.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnfinance" class="myButton" value="Financier" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/financier.jsp";'></div>
    <div class="nav-item"><input type="button" name="btninsurance" class="myButton" value="Insurance" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/insurance.jsp";'></div>
    <div class="nav-item"><input type="button" name="btncolor" class="myButton" value="Color" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/color.jsp";'></div>
    <!-- <div class="nav-item"><input type="button" name="btnvehicle" class="myButton" value="Vehicle" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehicle/vehicle2.jsp";'></div> -->
    <div class="nav-item"><input type="button" name="btnunit" class="myButton" value="Unit" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/unit.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnspecs" class="myButton" value="Specification" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/specification.jsp";'></div>
    <div class="nav-item"><input type="button" id="btnproject" name="btnproject" class="myButton" value="Project" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/project.jsp";'></div>
    <div class="nav-item"><input type="button" id="btnleasecdw" name="btnleasecdw" class="myButton" value="Lease CDW" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/leasecdw.jsp";'></div>
    <div class="nav-item"><input type="button" id="btnsecuritypass" name="btnsecuritypass" class="myButton" value="Security Pass" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/securityPass.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnyom" class="myButton" value="Yom" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/yom.jsp";'></div>
    <div class="nav-item"><input type="button" name="btnvehtype" class="myButton" value="Vehicle Type" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/vehType.jsp";'></div>
  </div>
</div>
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe1" align="right" frameborder="0" marginwidth="100%" scrolling="yes" src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp"></iframe>
</div>
<div id="mainBG" class="homeContent" data-type="background">



<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='veh'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
</div>


<script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe1]
                    .document.body.scrollHeight;
}
</script>
</div>
</body>
</html>