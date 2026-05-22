<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />  
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function(e) {
		$("#searchagmtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
        $('.branch').css('background-color','transparent');
        $('input[type=text]').css('height','18px');
		$('#btnagmtsearch').click(function(e) {
            var docno=$('#searchagmtno').val();
			var client=$('#searchagmtclient').val();
			var date=$('#searchagmtdate').jqxDateTimeInput('val');
			var fleetno=$('#searchagmtfleetno').val();
			var regno=$('#searchagmtregno').val();
			var mobile=$('#searchagmtmobile').val();
			var branch=$('#cmbbranch').val();
			client=encodeURIComponent(client);
			$('#agmtsearchdiv').load('agmtSearchGrid.jsp?docno='+docno+'&client='+client+'&date='+date+'&fleetno='+fleetno+'&regno='+regno+'&mobile='+mobile+'&branch='+branch+'&id=1');
        });
    });
</script>
</head>
<style type="text/css">

/* ===== MASTER UI STRICT ===== */

body{
    margin:0;
    background:#f5f7fa;
}

/* MAIN */
#search.modern-ui{
    width:96%;
    margin:8px auto;
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    font-size:12px !important;
}

/* PANEL */
.modern-ui .search-panel{
    background:#fff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:10px 8px;
    margin-bottom:10px;
    box-shadow:0 2px 6px rgba(0,0,0,0.04);
}

/* GRID */
.modern-ui .grid-container{
    background:#fff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:5px;
}

/* TABLE */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:4px 8px;
}

/* LABEL */
.modern-ui td.label{
    font-size:12px !important;
    font-weight:600;
    color:#444;
    text-align:right;
    white-space:nowrap;
}

/* INPUT */
.modern-ui input[type="text"]{
    width:100%;
    height:24px !important;
    padding:2px 6px !important;
    border:1px solid #b8c6d8;
    border-radius:3px;
    background:#fff;
    box-sizing:border-box;
    font-size:12px !important;
}

/* DATE */
.modern-ui #searchagmtdate{
    height:24px;
    display:flex;
    align-items:center;
}

/* BUTTON */
.modern-ui .myButton{
    height:24px !important;
    line-height:22px !important;
    padding:0 14px;
    font-size:12px !important;
    font-weight:700;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%);
    color:#fff;
    border:1px solid #083a8a;
    border-radius:3px;
    cursor:pointer;
    white-space:nowrap;
}

</style>

<body>

<div id="search" class="modern-ui">

    <!-- SEARCH PANEL -->
    <div class="search-panel">

        <table>

            <colgroup>

                <!-- ROW 1 -->
                <col width="7%">
                <col width="20%">

                <col width="7%">
                <col width="18%">

                <col width="7%">
                <col width="25%">

                <!-- ROW 2 -->
                <col width="7%">
                <col width="14%">

                <col width="7%">
                <col width="14%">

                <col width="7%">
                <col width="17%">

            </colgroup>

            <!-- FIRST ROW -->
            <tr>

                <td class="label">Doc No</td>
                <td>
                    <input type="text"
                           name="searchagmtno"
                           id="searchagmtno">
                </td>

                <td class="label">Date</td>
                <td>
                    <div name="searchagmtdate"
                         id="searchagmtdate"></div>
                </td>

                <td class="label">Client</td>
                <td colspan="7">
                    <input type="text"
                           name="searchagmtclient"
                           id="searchagmtclient">
                </td>

            </tr>

            <!-- SECOND ROW -->
            <tr>

                <td class="label">Fleet No</td>
                <td>
                    <input type="text"
                           name="searchagmtfleetno"
                           id="searchagmtfleetno">
                </td>

                <td class="label">Reg No</td>
                <td>
                    <input type="text"
                           name="searchagmtregno"
                           id="searchagmtregno">
                </td>

                <td class="label">Mobile</td>
                <td>
                    <input type="text"
                           name="searchagmtmobile"
                           id="searchagmtmobile">
                </td>

                <td align="left">
                    <button type="button"
                            id="btnagmtsearch"
                            name="btnagmtsearch"
                            class="myButton">
                        Search
                    </button>
                </td>

            </tr>

            <!-- GRID -->
            <tr>
                <td colspan="12">
                    <div id="agmtsearchdiv">
                        <jsp:include page="agmtSearchGrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>

        </table>

    </div>

</div>

</body>
</html>