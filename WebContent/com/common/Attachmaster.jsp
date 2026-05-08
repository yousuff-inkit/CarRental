<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="<%=contextPath+"/"%>icons/ink_new_logo_2025.png" >
<title>INK IT Business Solutions</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

<% 
 String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
 String jobname = request.getParameter("jobname")==null?"":request.getParameter("jobname"); 
 String formcode = request.getParameter("formCode")==null?"NA":request.getParameter("formCode"); 
 String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid"); 
 String frmname = request.getParameter("frmname")==null?"":request.getParameter("frmname"); 
%>

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Attachment Popup Style
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui {
    padding: 15px;
}

/* Panels */
.modern-ui .header-panel {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 10px 15px;
    margin-bottom: 15px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
}

.modern-ui .upload-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 15px;
    margin-bottom: 15px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 100px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
}

/* Typography & Layout */
.modern-ui .header-title {
    color: #0b45a2;
    font-weight: 700;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.modern-ui .header-actions {
    display: flex;
    gap: 12px;
}

.modern-ui table {
    width: 100%;
    border-spacing: 8px;
}

.modern-ui td.label {
    text-align: right;
    font-size: 12px;
    font-weight: 600;
    color: #444;
    padding-right: 8px;
    white-space: nowrap;
}

/* Inputs & Selects (24px standardized) */
.modern-ui input[type="text"], 
.modern-ui select {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', sans-serif !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    width: 100%;
    outline: none;
    transition: border-color 0.2s;
}

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

.modern-ui select {
    padding-right: 24px !important;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Standardize File Input Text */
.modern-ui input[type="file"] {
    font-size: 12px;
    font-family: 'Segoe UI', sans-serif;
    color: #444;
    outline: none;
}

/* Master UI Custom File Choose Button */
.modern-ui input[type="file"]::file-selector-button {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; 
    line-height: 20px !important; 
    padding: 0 15px;
    margin-right: 10px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a; 
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
}

.modern-ui input[type="file"]::file-selector-button:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}

/* Icon Buttons */
.modern-ui .icon-btn {
    background: #f4f7f9;
    border: 1px solid #dce4ec;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 4px 8px;
    border-radius: 4px;
    transition: all 0.2s;
}

.modern-ui .icon-btn:hover {
    background: #e1e8ed;
    border-color: #b8c6d8;
}

.modern-ui .icon-btn img {
    height: 20px;
    object-fit: contain;
}

.scanned {
    height: 100px;
    width: 100px;
    border-radius: 4px;
    border: 1px solid #ddd;
    margin: 5px;
}
</style>

<script type="text/javascript"> 
$(document).ready(function(){
    $("body").prepend('<div id="attachoverlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='attachPleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:400px;'><img src='../../icons/31load.gif'/></div>");
    
    var masterdocno='<%=docNo%>';
    var formcode='<%=formcode%>';
    var jobname='<%=jobname%>';
    var brchid='<%=brchid%>';
    var frmname='<%=frmname%>';
    
    if(jobname!=null && jobname!="" && jobname!="undefined" && typeof(jobname)!="undefined" && jobname!="null"){
        document.getElementById("jobname").value=jobname;
    }
    if(masterdocno>0) { document.getElementById("docno").value=masterdocno; }
    if(formcode!='NA') { document.getElementById("formdetailcode").value=formcode; }
    if(brchid>0) { document.getElementById("brchid").value=brchid; }
    if(frmname!="") {
        document.getElementById("frmnames").innerText=frmname;
        document.getElementById("formnames").value=frmname;
    }
    
    getRefType();
    var indexVal2 = document.getElementById("docno").value;
    $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&brchid="+brchid+"&jobname="+jobname);
}); 

function ajaxFileUpload() {
    var reftypid=document.getElementById("reftypid").value;
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        var fsize = $('#file')[0].files[0].size;
    } else {
        $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
        }); 
        return;
    }
        
    $.ajaxFileUpload({  
        url:'fileAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&jobname=<%=request.getParameter("jobname")%>&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val() ,
        secureuri:false, 
        fileElementId:'file', 
        dataType: 'json',
        success: function (data, status) {  
            if(status=='success'){
                $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); 
            }
            $("#testImg").attr("src",data.message);
            if(typeof(data.error) != 'undefined') {  
                if(data.error != '') {  
                    $.messager.show({title:'Message',msg: data.error,showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                } else {  
                    $.messager.show({title:'Message',msg: data.message,showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                }  
            }  
        },  
        error: function (data, status, e) {  
            $.messager.alert('Message',e);
        }  
    })  
    return false;  
}

function reload(){
    $("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
}

function SaveToDisk(fileURL, fileName) {
    var host = window.location.origin;
    var splt = fileURL.split("webapps"); 
    var repl = splt[1].replace( /;/g, "/");
    fileURL=host+repl;
    
    if (!window.ActiveXObject) {
        var save = document.createElement('a');
        save.href = fileURL;
        save.target = '_blank';
        save.download = fileName || 'unknown';
        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
    } else if ( !! window.ActiveXObject && document.execCommand) {
        var _window = window.open(fileURL, '_blank');
        _window.document.close();
        _window.document.execCommand('SaveAs', true, fileName || fileURL)
        _window.close();
    }
}

function Delete(){
    var filename=document.getElementById("filename").value;
    var x=new XMLHttpRequest();
    var items,brchItems,currItems,mcloseItems;
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            if(items>0){
                var indexVal2 = document.getElementById("docno").value;
                $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&jobname="+jobname);
                $.messager.alert('Message','Successfully Deleted');
            } else {
                $.messager.alert('Message','Not Deleted');
            }
        }
    }
    x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
    x.send();
}

function saveViaAJAX() {
    var testCanvas =null;
    var formname=document.getElementById("formdetailcode").value;
    var docno=document.getElementById("docno").value;
    var reftypid=document.getElementById("reftype").value;
    if(docno==""){
        document.getElementById("errormsg").innerText="Please Select a Document Number";
        return false;
    }
    var iscapture=document.getElementById("iscapture").value;
    if(iscapture==1){
        testCanvas = document.getElementById("canvasids"); 
    } else {
        testCanvas = document.getElementById("canvasid");  
    }
    
    var canvasData = testCanvas.toDataURL("image/png");
    var postData = "canvasData="+canvasData;
    var ajax = new XMLHttpRequest();
    ajax.open("POST",<%=contextPath+"/"%>+'saveImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid,true);    
    ajax.setRequestHeader('Content-Type', 'canvas/upload');
    
    ajax.onreadystatechange=function() {
        if (ajax.readyState == 4) { 
            var indexVal2 = document.getElementById("docno").value;
            $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&jobname="+jobname);
            $.messager.alert('Message',"Successfully Attached");
        }
    }
    ajax.send(postData);  
}

function upload(){
    var iscapture=document.getElementById("iscapture").value;
    if(iscapture==1){
        saveViaAJAX();
    } else if(iscapture==2){
        savedata();
    } else {
        var path=document.getElementById("file").value;
        var fsize = $('#file')[0].files[0].size;
        var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
        if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP')) {
            if(fsize>1048576) { 
                saveViaAJAX();
            } else {
                ajaxFileUpload();   
            }
        } else {
            ajaxFileUpload();   
        }
    }
}
 
function loading(){
    document.getElementById("iscapture").value=0;
    var path=document.getElementById("file").value;
    var fsize = $('#file')[0].files[0].size;
    var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
    if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP')) {
        if(fsize>1048576) {
            document.getElementById("errormsg").innerText="Please Wait......";
        }
    }
}

function comonsnapshotWindow() {
    document.getElementById("iscapture").value=1;
    window.open(<%=contextPath+"/"%>+"com/common/snapshot.jsp", "CommonCamera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
}

function getRefType() {   
    var dtype=document.getElementById("formdetailcode").value;
    var x=new XMLHttpRequest();
    var items,refname,refcode,refdocno;
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {  
            items= x.responseText;
            items=items.split('####');
            refname=items[0].split(",");
            refcode=items[1].split(",");
            refdocno=items[2].split(",");
            var optionref = '';
            for ( var i = 0; i < refname.length; i++) {
                getRef(refname[0]);
                optionref += '<option value="' + refdocno[i] + '">' + refname[i] + '</option>';
            }
            $("select#reftype").html(optionref); 
        }
    }
    x.open("GET",<%=contextPath+"/"%>+"com/common/getRefType.jsp?dtype="+dtype,true);
    x.send();
}

function getRef(c){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items = items.split('####');
            var reftype = items[0].split(",");
            var refcode  = items[1].split(",");
            var refdocno  = items[2].split(",");
            document.getElementById("reftypid").value=refdocno;
        }
    }
    x.open("GET", <%=contextPath+"/"%>+"com/common/getRef.jsp?reftype="+c,true);
    x.send();
}

function formsub() {
    var iscapture=document.getElementById("iscapture").value;
    if(iscapture==1){
        saveViaAJAX();
    } else if(iscapture==2){
        $( "#from1").submit();
    } else {
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            var fileInput = document.getElementById("file");
            var file = fileInput.files[0];
            var fsize = $('#file')[0].files[0].size;
            
            if(fsize>10380902) {
                $.messager.alert('Message',fsize +' bytes too big ! Maximum Size 9.9 MB!','warning');
                return false;
            }
            
            if (file.type.startsWith("image/")) {
                if (fsize < 307200) { 
                    $("#from1").submit();
                    return;
                }
                
                resizeAndCompressImage(file).then(compressedFile => {
                    if (!compressedFile) {
                        $.messager.alert("Message", "Error processing image!", "error");
                        return false;
                    }
                    var dataTransfer = new DataTransfer();
                    dataTransfer.items.add(compressedFile);
                    fileInput.files = dataTransfer.files;
                    $("#from1").submit();
                });
                return false; 
            } else {
                $("#from1").submit(); 
            }
        } 
    }
}
    
function resizeAndCompressImage(file) {
    return new Promise((resolve, reject) => {
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (event) {
            var img = new Image();
            img.src = event.target.result;
            img.onload = function () {
                var canvas = document.createElement("canvas");
                var ctx = canvas.getContext("2d");
                var maxWidth = 1024; 
                var maxHeight = 1024; 
                var width = img.width;
                var height = img.height;

                if (width > height) {
                    if (width > maxWidth) {
                        height *= maxWidth / width;
                        width = maxWidth;
                    }
                } else {
                    if (height > maxHeight) {
                        width *= maxHeight / height;
                        height = maxHeight;
                    }
                }

                canvas.width = width;
                canvas.height = height;
                ctx.drawImage(img, 0, 0, width, height);

                canvas.toBlob(blob => {
                    if (!blob) {
                        resolve(null); 
                        return;
                    }
                    var compressedFile = new File([blob], file.name, { type: file.type });
                    resolve(compressedFile);
                }, file.type, 0.7); 
            };
            img.onerror = () => resolve(null); 
        };
        reader.onerror = () => resolve(null); 
    });
}

function setValuess() {
    if($('#msgs').val()!=""){
        $.messager.alert('Message',$('#msgs').val());
        $('#msgs').val('');
    }
}
    
function scans(paths) {
    scanner.scan(displayResponseOnPage, {
        "output_settings": [{
            "type": "save",
            "format": "jpg",
            "save_path": ""+paths
        }]
    });
}

function displayResponseOnPage(successful, mesg, response) {
    document.getElementById('response').innerHTML = scanner.getSaveResponse(response);
}
        
function savedata() {
    var formname=document.getElementById("formdetailcode").value;
    var docno=document.getElementById("docno").value;
    var reftypid=document.getElementById("reftype").value;
    var typeid=2;
    if(docno==""){
        document.getElementById("errormsg").innerText="Please Select a Document Number";
        return false;
    }
    
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)) {
                var indexVal2 = document.getElementById("docno").value;
                $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&jobname="+jobname);
                $.messager.alert('Message',"Successfully Attached"); 
                document.getElementById("iscapture").value=0;
            } else {
                $.messager.alert('Message',"Not Attached"); 
                document.getElementById("iscapture").value=0;
            }
        } 
    }
    x.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid+'&typeid='+typeid,true);   
    x.send();
}

function scansdata() {
    var formname=document.getElementById("formdetailcode").value;
    var docno=document.getElementById("docno").value;
    var reftypid=document.getElementById("reftype").value;
    var typeid=1;
    if(docno==""){
        document.getElementById("errormsg").innerText="Please Select a Document Number";
        return false;
    }
    
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            document.getElementById("iscapture").value=2;
            scans(items);
        }
    }
    x.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid+'&typeid='+typeid,true);   
    x.send();
}
</script>
    
<script type="text/javascript" >
var scanRequest = {
    "use_asprise_dialog": true, 
    "show_scanner_ui": false, 
    "twain_cap_setting": { 
        "ICAP_PIXELTYPE": "TWPT_RGB" 
    },
    "output_settings": [{
        "type": "return-base64",
        "format": "jpg"
    }]
};
 
function scan() {
    scanner.scan(displayImagesOnPage, scanRequest);
}
 
function displayImagesOnPage(successful, mesg, response) {
    if (!successful) { 
        console.error('Failed: ' + mesg);
        return;
    }
    if (successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { 
        console.info('User cancelled');
        return;
    }
    var scannedImages = scanner.getScannedImages(response, true, false); 
    for (var i = 0; (scannedImages instanceof Array) && i < scannedImages.length; i++) {
        var scannedImage = scannedImages[i];
        var elementImg = scanner.createDomElementFromModel({
            'name': 'img',
            'id': 'canvasids',
            'attributes': {
                'class': 'scanned',
                'src': scannedImage.src
            }
        });
        (document.getElementById('images') ? document.getElementById('images') : document.body).appendChild(elementImg);
    }
    $("#attachoverlay, #attachPleaseWait").show();
    
    document.getElementById("scansrc").value=scannedImage.src;
    document.getElementById("iscapture").value=2;
    document.getElementById("scansrcid").value=1;
  
    setTimeout(function() {
        $("#attachoverlay, #attachPleaseWait").hide();
    }, 2000);
}

function saveViaAJAX1(scannedImages) {
    var testCanvas =null;
    var formname=document.getElementById("formdetailcode").value;
    var docno=document.getElementById("docno").value;
    var reftypid=document.getElementById("reftype").value;
    if(docno==""){
        document.getElementById("errormsg").innerText="Please Select a Document Number";
        return false;
    }
    var postData = "canvasData="+scannedImages;
    var ajax = new XMLHttpRequest();
    
    ajax.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid,true);    
    ajax.setRequestHeader('Content-Type', 'canvas/upload');
    
    ajax.onreadystatechange=function() {
        if (ajax.readyState == 4) { 
            var indexVal2 = document.getElementById("docno").value;
            $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&jobname="+jobname);
            $.messager.alert('Message',"Successfully Attached");
            $("#attachoverlay, #attachPleaseWait").hide();
        }
    }
    ajax.send(postData);  
}
</script> 
</head>

<body onload="setValuess();">
<div class="modern-ui">

    <div id="images" hidden="true" style="border: 1px" height="480" width="640"></div>

    <!-- HEADER PANEL -->
    <div class="header-panel">
        <div class="header-title" id="frmnames"><s:property value="frmnames"/></div>
        
        <div class="header-actions">
            <button class="icon-btn" id="btnAttachDelete" title="Delete current Document" type="button" onclick="Delete();">
                <img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
            </button>
            <button class="icon-btn" id="click" title="Take SnapShot" type="button" onclick="comonsnapshotWindow();">
                <img alt="take snapshot" src="<%=contextPath%>/icons/asnapshot.png">
            </button>   
        </div>
    </div>

    <!-- MAIN UPLOAD FORM -->
    <form action="fileAttachActionmaster" id="from1" method="post" enctype="multipart/form-data">
        
        <div class="upload-panel">
            <table width="100%" cellpadding="0" cellspacing="0">
                <colgroup>
                    <col width="10%">  <col width="30%">
                    <col width="10%">  <col width="20%">
                    <col width="22%">  <col width="8%">
                </colgroup>
                <tr>
                    <td class="label">Description</td>
                    <td>
                        <input type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
                    </td>
                    
                    <td class="label">Ref Type</td>
                    <td>
                        <select name="reftype" id="reftype"></select>
                    </td>
                    
                    <td style="padding-left: 15px;">
                        <input type="file" id="file" name="file" onChange="return loading();" />
                    </td>
                    
                    <td align="center">
                        <button class="icon-btn" id="alttachsss" title="Attach" type="button" onclick="formsub()">
                            <img alt="Attach" src="<%=contextPath%>/icons/attachicon.png">
                        </button>
                    </td>
                </tr>
            </table>
        </div>

        <!-- GRID DATA -->
        <div class="grid-container">
            <div id="attachs">
                <jsp:include page="Attachgridmaster.jsp"></jsp:include>
            </div>
        </div>

        <!-- HIDDEN FIELDS & CANVAS DATA -->
        <input type="hidden" name="scansrc" id="scansrc" value='<s:property value="scansrc"/>'>
        <input type="hidden" name="scansrcid" id="scansrcid" value='<s:property value="scansrcid"/>'>
        <input type="hidden" name="formnames" id="formnames" value='<s:property value="formnames"/>'/>
        <input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
        <input type="hidden" name="msgs" id="msgs" value='<s:property value="msgs"/>'/>
        <input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'/> 
        <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'/>
        <input type="hidden" name="brchid" id="brchid" value='<s:property value="brchid"/>'/>
        <input type="text" hidden="true" name="jobname" id="jobname">
        <input id="reftypid" type="hidden" />                                   
        <input id="width" type="hidden" value="640" />
        <input id="height" type="hidden" />
        <input id="data" type="hidden" />
        <input id="iscapture" type="hidden" />
        
        <br /><span id="message"></span><br />
        <span id="errormsg" style="color:red; font-size:12px; font-weight:bold;"></span>

        <canvas id="canvasid" hidden="true" height="480" width="640"></canvas>
        <canvas id="canvasids" hidden="true" height="240" width="320"></canvas>
        <div id="img"></div>
    </form>
    
</div>

<script>
    (function ( $width, $height, $file) {
        function resampled(data) {
            document.getElementById("data").value=data;
            var imgid = new Image();
            imgid.src =data;
            var temp_paint = $('#canvasid');
            var temp_ctx = temp_paint[0].getContext('2d');
            document.getElementById("errormsg").innerText=" ";
            temp_ctx.drawImage(imgid, 0, 0,640, 480);
        }
        
        function load(e) {
            Resample(
                this.result,
                this._width || null,
                this._height || null,
                resampled
            );
        }
        
        function abort(e) {}
        function error(e) {}
        
        $file.addEventListener("change", function change() {
            var width = parseInt($width.value, 10),
                height = parseInt($height.value, 10),
                file;
            if (!width && !height) {
                $file.parentNode.replaceChild(
                    file = $file.cloneNode(false),
                    $file
                );
                $file.removeEventListener("change", change, false);
                ($file = file).addEventListener("change", change, false);
            } else if(
                ($file.files || []).length &&
                /^image\//.test((file = $file.files[0]).type)
            ) {
                file = new FileReader;
                file.onload = load;
                file.onabort = abort;
                file.onerror = error;
                file._width = width;
                file._height = height;
                file.readAsDataURL($file.files[0]);
            } 
        }, false);
    }(
        document.getElementById("width"),
        document.getElementById("height"),
        document.getElementById("file")
    ));
</script>

</body>
</html>