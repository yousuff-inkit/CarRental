<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
    /* FORCE FULL HEIGHT/WIDTH */
    html, body, #mainBG, form, #approvalDataGrid {
        height: 100%; width: 100%; margin: 0; padding: 0; overflow: hidden;
    }
</style>
</head>
<body>
    <div id="mainBG" class="homeContent" data-type="background">
        <form autocomplete="off">    
            <div id="approvalDataGrid">
                <jsp:include page="approvalDataGridNew.jsp"></jsp:include>
            </div>
            <input type="hidden" id="formData" />
            <input type="hidden" id="formName" />
            <input type="hidden" id="formCode" />
        </form>
    </div>
</body>
</html>