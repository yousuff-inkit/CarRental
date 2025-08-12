<jsp:include page="../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%> 
<% String userid = request.getParameter("userid")==null || request.getParameter("userid").equals("")?"0":request.getParameter("userid").trim(); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WhatsApp Chatbox</title>
<link href="../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
<link href="../../vendors/bootstrap-v5/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />  
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

body {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: #ccc;
  width: 100%;
}

.background-green {
  position: absolute;
  top: 0;
  width: 100%;
  height: 20%;
  background-color: #009688;
}

.main-container {
  position: relative;
  width: calc(100% - 100px);
  max-width: 100%;
  height: calc(100vh - 40px);
  background: #fff;
  display: flex;
  box-shadow: 0px 1px 1px  0 rgba(0,0,0,0.5), 0px 2px 5px 0 rgba(0,0,0,0.6);
}

.main-container .left-container {
  position:relative;
  width: 30%;
  height:100%;
  flex: 30%;
  background: #fff;
  z-index: 1;
  box-shadow: 5px 0 5px -5px rgba(0, 0, 0, 0.08);  
}

.main-container .right-container {
  position: relative;
  width: 70%;
  height: 100%;
  flex: 70%;
  background: #e5ddd5;
}

.main-container .right-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url(https://camo.githubusercontent.com/854a93c27d64274c4f8f5a0b6ec36ee1d053cfcd934eac6c63bed9eaef9764bd/68747470733a2f2f7765622e77686174736170702e636f6d2f696d672f62672d636861742d74696c652d6461726b5f61346265353132653731393562366237333364393131306234303866303735642e706e67);
  opacity: 0.5;
}

.header {
  position: relative;
  display: flex;
  align-items: center;
  width: 100%;
  height: 53px;   
  background: #ededed;
  padding: 0 15px;
}

.user-img {
  position:relative;
  width: 35px;
  height: 25px;
  overflow: hidden;
}

.dp {
  position:absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  cursor: pointer;
}

.nav-icons {
  display:flex;
  justify-content: flex-end;
  padding-left: 110px;
}

.nav-icons li {
  backgroud-color:pink;
  list-style: none;
  display: flex;
  cursor: pointer;
  color: #51585c;
  margin-left: 22px;
  font-size: 18px;
}

.notif-box {
  position: relative;
  display: flex;
  width: 100%;
  height: 70px;
  background: #76daff;
  align-items: center;
  font-size: 0.9em;
  text-decoration: none;
}

.notif-box i {
  position:relative;
  left: 13px;
  background:#fff;
  padding:10px;
  width: 42px;
  height: auto;
  font-size: 20px;
  border-radius: 55%;
  cursor: pointer;
  color:#76daff;
}

.notif-box .fa-xmark {
  position: absolute;
  left: 260px;
  text-align:center;
  background:#76daff;
  color: #fff;
}

.notif-text {
  margin: 25px;
}

.notif-text a {
  text-decoration: none;
  color: #333;
  font-size: 0.9em;
}

.search-container {
  position:relative;
  width: 100%;
  height: 40px;
  background: #f6f6f6;
  display: flex;
/*   justify-content: center; */
  align-items: center;
}

.search-container .input input {
  width: 121%;
  outline: none;
  border: none;
  background: #fff;
  padding: 5px;
  height: 30x;
  border-radius: 10px;
  font-size: 12px;
  padding-left: 60px;
  margin: 10px
}

.search-container .input i {
  position: absolute;
  left: 26px;
  top: 14px;
  color:#bbb;
  font-size: 0.9em;
}

.chat-list {
  position: relative;
  height:calc(100% - 170px);
  overflow-y: auto;
}

.chat-list .chat-box {
  position: relative;
  width: 100%;
  display:flex;
/*   justify-content: center; */
  align-items:center;
  cursor: pointer;
  padding: 1px;
  border-bottom: 1px solid #eee;
}

.chat-list .chat-box .img-box {
  position:relative;
  width: 55px;
  height:45px;
  overflow:hidden;
  border-radius: 50%;
  padding:10px;
}

.chat-list .chat-box .chat-details {
  width: 100%;
  margin-left: 0px;    
}

.chat-list .chat-box .chat-details .text-head {
  display:flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom:2px;
}

.chat-list .chat-box .chat-details .text-head h6 {
  font-size: 0.9em;
  font-weight: 600;
  color: #000;
}

.chat-list .chat-box .chat-details .text-head .time {
  font-size: 0.9em;
  color: #aaa;
}

.chat-list .chat-box .chat-details .text-message {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chat-list .chat-box .chat-details .text-message p {
  color: #aaa;
  font-size: 0.9em;
  overlay: hidden;
}

/* img {
  width: 70%;
  object-fit: cover;
} */

.chat-list .chat-box .chat-details .text-message b {
  background: #06e744;
  color: #fff;
  min-width: 20px;
  height: 20px;
  border-radius: 50%;
/*   text-align: center; */
  font-size: 0.9em;
  font-weight: 400;
  display:flex;
  justify-content:center;
  align-items:center;
}

.chat-list .active {
  background: #ebebeb;
}

.chat-list .chat-box:hover {
  background: #f5f5f5;
}

.chat-list .chat-box .chat-details .text-head .unread {
  color: #06e744;
}


/* right-container */


.right-container .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.right-container .header .img-text .user-img .dp {
  position:relative;
  left: 0px;
  width: 25px;
  height:auto;
  overflow:hidden;
  object-fit: cover;
}

.right-container .header .img-text {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

.right-container .header .img-text h6 {
  font-weight: 500;
  font-size: 0.9em;
  line-height: 1.2em;
  margin-left: 10px;
}

.right-container .header .img-text h6 span {
  font-size: 0.9em;
  color: #555;
}

.right-container .header .nav-icons {
  position: relative;
  margin-right:0px;
/*   padding: 5px; */
}

.right-container .header .nav-icons i {
  padding: 10px;
}

.chat-container {
  position:relative;
  width: 100%;
  height: calc(100% - 103px);
  padding: 20px;
  overflow-y: auto;
}

.message-box {
  position:relative;
  display: flex;
  width:100%;
  margin: 5px 0;
}

.message-box p,.img-msg {
  position:relative;
  right: 0;
  text-align: right;
  max-width: 20%;
  padding: 12px;
  background: #dcf8c6;
  border-radius: 10px;
  font-size: 0.9em;           
}

.message-box.my-message p::before {
  content : '';
  position: absolute;
  top: 0;
  right: -12px;
  width: 20px;
  height: 20px;
  background: linear-gradient(135deg, #dcf8c6 0%, #dcf8c6 50%, transparent 50%, transparent);
}

.message-box p span {
  display: inline;
  margin-top: 5px;
  font-size: 0.9em;
  opacity: 0.5;
}

.message-box .img-msg span {
  display: inline;
  margin-top: 5px;
  font-size: 0.9em;
  opacity: 0.5;
}

.my-message {
  justify-content: flex-end;
}

.friend-message p {
  background: #fff;
}

.friend-message {
  justify-content: flex-start;

}

.chat-container .my-message i {
  color: yellow;
}

.message-box.friend-message::before {
  content : '';
  position: absolute;
  top: 0;
  left: -12px;
  width: 20px;
  height: 20px;
  background: linear-gradient(225deg, #fff 0%, #fff 50%, transparent 50%, transparent);
}

.chatbox-input {
  position:relative;
  width: 100%;
  height: 50px;
  background: #f0f0f0;
  padding: 10px;
}

.chatbox-input i {
  cursor: pointer;
  font-size: 0.9em;
  color: #515855;
}

.chatbox-input i:nth-child(1) {
   padding: 2px;
}

.chatbox-input i:last-child {
   padding: 2px;
}

 .chatbox-input input {
    position: relative;
    width: 86%;
    margin: 0 10px;
    padding: 5px 5px;
    border-radius:10px;
    font-size: 0.9em;
    border:none;
    outline:none;
    height: 30px;
 }	
 
 .chatbox-input button{
    padding: 5px; 
    border: none;    
  }
  
  .button-37 {
	  background-image: linear-gradient(#4ce31d, #09fa05);
	  border-radius: 4px;
	  box-shadow: rgba(0, 0, 0, .3) 0 5px 15px;
	  box-sizing: border-box;
	  color: #fff;
	  cursor: pointer;
	  user-select: none;
	  -webkit-user-select: none;
	  touch-action: manipulation;
	  cursor: pointer;
	  transition: all 150ms ease-in-out;
}

.button-37:hover {
  filter: brightness(1.05);
}

.button-37:active {
  transform: scale(.95);
}
 p{
 margin-bottom:0rem;
 }  
 
/* CSS Styling */
.message-box {
  position: relative;
  margin: 5px 0;
  text-align: right; /* Align message boxes to the right */
}

.media-wrapper {
  position: relative;
  display: inline-block;
  max-width: 70%; /* Adjust as needed */
  text-align: center; /* Center image and time */
  position: relative; /* Relative positioning for absolute child elements */
}

.media-wrapper img {
  max-width: 100%;
  height: auto;
  border-radius: 10px; /* Rounded corners for the chat bubble */
}

.sent-time {
  position: absolute;
  top: -20px; /* Adjust vertical position above the image */
  right: 0; /* Align the time to the right */
  background-color: rgba(255, 255, 255, 0.8); /* Background color for better visibility */
  padding: 2px 5px;
  font-size: 0.8em;
  border-radius: 5px;
}

.message-body {
  position: relative;
  background-color: #DCF8C6; /* Assuming sent messages have a green background */
  padding: 10px 15px;
  border-radius: 15px;
  max-width: 70%;
}

.message.sent .message-body {
  background-color: #DCF8C6;
  margin-left: auto;
  border-top-left-radius: 15px;
}

.message.received .message-body {
  background-color: #e5e5ea;
  border-top-right-radius: 15px;
}

.message-body img {
  max-width: 100%;
  border-radius: 10px;
  margin-top: 10px;
}

.message-time {
  font-size: 12px;
  color: #777;
  position: absolute;
  bottom: -20px;
  right: 10px;
}
.media-container{
   width: 400px;  
   height: 300px;  
   border: 1px solid #ccc;  
   overflow: hidden;  
}

.container img,
    .container iframe,
    .container video,
    .container audio {
        width: 100%;  
        height: 100%;  
        object-fit: cover;  
    }
    
</style>
</head>
<body>
  <div class="background-green"></div>
  <div class="main-container">
    <div class="left-container">  

	 <nav class="navbar navbar-light bg-light">
	  <div class="container-fluid">
	    <form class="d-flex" autocomplete="off">  
	      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" id="txtsearch" onkeyup="funUserSearch()">
	      <div>&nbsp;&nbsp;&nbsp;</div>  
	      <div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
		   <i class="fa fa-user" aria-hidden="true"></i>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
		    <li><a class="dropdown-item" href="login.jsp">Logout</a></li>
		  </ul>    
		</div>
	    </form>
	  </div>
	</nav>  


<!--chats -->
      <div class="chat-list">
        <div class="chat-box">
          <div class="img-box">
            <!-- <img class="img-cover" src="icons/whatsapp_user_dp.png" alt="">    -->
            <img src = "icons/person-circle.svg" alt=""/></img>
          </div>
          <div class="chat-details">
            <div class="text-head">
              <h6>&nbsp;</h6>
              <input type="hidden" id="userno" name="userno" value="1">  
              <!--<p class="time unread">11:49</p>-->
            </div>
            <!--<div class="text-message">
              <p>Ã¢ÂÂHow are you?Ã¢ÂÂ</p>
              <b>1</b>
            </div>-->
          </div>
        </div>
      </div>
    </div>

    <div class="right-container">
          <div class="img-land">
            <img src = "icons/whatsapplandingpage.jpg" alt=""/></img>  
          </div>
    </div>
    
	<input type="hidden" id="cldocno" name="cldocno"/> 
	<input type="hidden" id="status" name="status"/>
	<input type="file" id="fileInput" style="display: none;"/>
	<input type="hidden" id="firstuser" name="firstuser"/>       
  </div>
  <script type="text/javascript" src="../../vendors/sweetalert/sweetalert2.all.min.js"></script>    
  <script type="text/javascript" src="../../vendors/bootstrap-v5/js/bootstrap.min.js"></script>    
  <script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function() {
	    var inputField = document.getElementById('txtsearch');
	    inputField.addEventListener('search', function(event) {
	        if (event.target.value === '') {
	        	funUserSearch();
	        }
	    });
	});
  
	$(document).ready(function(){
		  fetchDataFromServer()
		  $('.chat-list').on('click', '.chat-box', function() {
			  var userInput = $(this).find('input[type="hidden"]');
			  var userNoValue = userInput.val();
			  $("#cldocno").val(userNoValue)
			  fetchChatlist(userNoValue)
          })
          
         /*  document.getElementById('btnattach').addEventListener('click', function() {
          	document.getElementById('fileInput').click();  
          }) */
	  })
	  
      function fetchDataFromServer() {
		    var userid = '<%= userid%>';   
            var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				var fielddata = JSON.parse(items.trim());          
	  				var fieldshtml=""; 
	  				var users = fielddata.users;
	  				for(var i = 0; i < users.length; i++) {
					    var user = users[i];
					    fieldshtml+='<div class="chat-box">'
						fieldshtml+='<div class="img-box">'
						//fieldshtml+='<img class="img-cover" src="icons/whatsapp_user_dp.png" alt=""></div>'
						fieldshtml+='<img src = "icons/person-circle.svg" alt=""/></img></div>'
						fieldshtml+='<div class="chat-details">'
						fieldshtml+='<div class="text-head"><h6>'+user.wauser+'</h6>'
						fieldshtml+='<input type="hidden" id="userno' + i + '" name="userno' + i + '" value="' + user.cldocno + '">';  
						fieldshtml+='</div></div></div>'   
					}
					if(fieldshtml!=''){
						$('.chat-list').html($.parseHTML(fieldshtml));
					}
	  			}
	  		}
	  		x.open("GET", "getData.jsp?userid="+userid, true);        
	  		x.send();
        }
        
      function fetchChatlist(wano) {   
      	var fieldshtml="";
          var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				var fielddata = JSON.parse(items.trim());          
	  				 
	  				var users = fielddata.chatlist;
	  				var j = 1;
	  				for(var i = 0; i < users.length; i++) {  
					    var user = users[i];
					    if(i==0){
							fieldshtml+='<div class="header">'
							fieldshtml+='<div class="img-text">'
							fieldshtml+='<div class="user-img">'
							//fieldshtml+='<img class="dp" src="icons/whatsapp_dp.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" alt="">'
							fieldshtml+='<img src = "icons/person-circle.svg" alt=""/></img>'
							fieldshtml+='</div>';
							fieldshtml+='<h6>'+user.touser+'</h6> ';  
							fieldshtml+='</div></div>';  
							fieldshtml+='<div class="chat-container">';
						}
						
						if(user.chat=="F" && user.mediaid!=""){
							if(user.mediatype=="IMAGE"){
								fieldshtml+='<div class="message-box my-message">';    
								fieldshtml+='<div class="img-msg media-container"><img id="frommedia' + j + '" src = "icons/file-image.svg" alt="" data-value="' + user.mediaid + '" data-attachdoc="' + user.attachdoc + '"></img>&emsp;<span>'+user.time+'</span></div>'; 
								//fieldshtml+='<div class="img-msg"><img id="frommedia' + j + '" src = "http://localhost:8088/Qudra/attachment/WAM/WAM-50-1.png" alt="" data-value="' + user.mediaid + '"></img>&emsp;<span>'+user.time+'</span></div>'; 
								fieldshtml+='</div>';
							}
							if(user.mediatype=="APPLICATION"){
								fieldshtml+='<div class="message-box my-message">';      //width="600" height="400"
								fieldshtml+='<div class="img-msg media-container"><iframe src="icons/file-pdf.svg" data-value="' + user.mediaid + '" data-attachdoc="' + user.attachdoc + '"></iframe>&emsp;<span>'+user.time+'</span></div>'; 
								//fieldshtml+='<div class="img-msg"><img id="frommedia' + j + '" src = "http://localhost:8088/Qudra/attachment/WAM/WAM-50-1.png" alt="" data-value="' + user.mediaid + '"></img>&emsp;<span>'+user.time+'</span></div>'; 
								fieldshtml+='</div>';
							}
							if(user.mediatype=="VIDEO"){
								fieldshtml+='<div class="message-box my-message">';    
								fieldshtml+='<div class="img-msg media-container"><video width="320" height="240" controls><source src="icons/file-slides.svg"  data-value="' + user.mediaid + '" data-attachdoc="' + user.attachdoc + '" type="video/mp4"></video>&emsp;<span>'+user.time+'</span></div>'; 
								//fieldshtml+='<div class="img-msg"><img id="frommedia' + j + '" src = "http://localhost:8088/Qudra/attachment/WAM/WAM-50-1.png" alt="" data-value="' + user.mediaid + '"></img>&emsp;<span>'+user.time+'</span></div>'; 
								fieldshtml+='</div>';
							}
							if(user.mediatype=="AUDIO"){
								fieldshtml+='<div class="message-box my-message">';    
								fieldshtml+='<div class="img-msg media-container"><audio controls> <source src="icons/file-music.svg" data-value="' + user.mediaid + '" data-attachdoc="' + user.attachdoc + '" type="audio/mpeg"></audio>&emsp;<span>'+user.time+'</span></div>'; 
								//fieldshtml+='<div class="img-msg"><img id="frommedia' + j + '" src = "http://localhost:8088/Qudra/attachment/WAM/WAM-50-1.png" alt="" data-value="' + user.mediaid + '"></img>&emsp;<span>'+user.time+'</span></div>'; 
								fieldshtml+='</div>';
							}
							j++
						}
					    
						if(user.fromtext!="" && user.fromtext!=null){
							fieldshtml+='<div class="message-box my-message">';
							fieldshtml+='<p>'+user.fromtext+'&emsp;<span>'+user.time+'</span></p>';
							fieldshtml+='</div>';
						}
							
						if(user.totext!="" && user.totext!=null){
							fieldshtml+='<div class="message-box friend-message">';
							fieldshtml+='<p>'+user.totext+'&emsp;<span>'+user.time+'</span></p>';
							fieldshtml+='</div>';
						}
						
						if((users.length-1)==i){ 
							fieldshtml+='</div>' 
							fieldshtml+='<div class="chatbox-input">'
							//fieldshtml+='<button id="btnemoji" name="btnemoji"><i class="fa-regular fa-face-grin"></i></button>'
							//fieldshtml+='<button id="btnattach" name="btnattach"><i class="fa fa-paperclip" aria-hidden="true"></i></button>'
							fieldshtml+='<input type="text" id="txtmessage" name="txtmessage" placeholder="Type a message" onchange="funcheckInput();">'
							//fieldshtml+='<button id="btnvoice" name="btnvoice"><i class="fa fa-microphone" aria-hidden="true"></i></button>'
							fieldshtml+='<button id="btnsend" name="btnsend" onclick="funSendMessage()"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>'
							fieldshtml+='</div>'   
						}  
					}
					//if(fieldshtml!=''){
						$('.right-container').html($.parseHTML(fieldshtml));
					//}
						 // Attaching event listeners after adding content to the DOM
						for (var k = 1; k < j; k++) {
						    (function(k) {
						        var imageElement = document.getElementById('frommedia' + k); 
						        //alert(k + "===" + imageElement);
						        if (imageElement) {
						            //alert(k + "=V=" + imageElement);
						            imageElement.addEventListener('click', function() {
						                var mediaId = imageElement.getAttribute('data-value');
						                var attachDoc = imageElement.getAttribute('data-attachdoc');
						                //alert(k + ' : Image Clicked! Value: ' + mediaId);
						                funDownloadMedia(mediaId, imageElement, attachDoc)   
						            });
						        }
						    })(k);
						}
	  			}
	  		}
	  		x.open("GET", "getChatlist.jsp?wano="+wano, true);            
	  		x.send();
      }
        
        function funcheckInput(){
			var messgae = $('#txtmessage').val()
			if(messgae != "" || messgae != null){
				$("#btnsend").show()
		  		$("#btnvoice").hide()
			}else{
				$("#btnsend").hide()
		  		$("#btnvoice").show()
			}  
		}
        
	   function funSendMessage(){  
		var attachdoc = "", extn = ""      
		var msg = $("#txtmessage").val()
		msg = msg.replace(/\n/g, " ")
		if(msg=="" || msg==null){
			/* Swal.fire({
			  title: "Warning",
			  text: "Please enter message!",
			  icon: "warning",
			  width: 400,
			}); */   
			return false  
		} 
		var cldocno = $("#cldocno").val()
		/* Swal.fire({
		  title: "Are you sure?",
		  text: "You want to send",
		  icon: "warning",
		  showCancelButton: true,  
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "Yes"
		}).then((result) => {
		  if (result.isConfirmed) {
			  sendMessage(cldocno, msg, attachdoc, extn);
		  }
		}); */ 
		sendMessage(cldocno, msg, attachdoc, extn); 
	}
	
	function sendMessage(cldocnos, msg, attachdoc, extn){
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			 if (x.readyState==4 && x.status==200){
			    var items=x.responseText.trim();
			    if(parseInt(items)>0){
				  fetchChatlist(cldocnos)
				  /* Swal.fire({
					  title: "Success",
					  text: "Successfully Sent",
					  icon: "success",
					  width: 400,
					}); */ 
			    }else{
				  /* Swal.fire({
					  title: "Error",
					  text: "Not Sent",
					  icon: "error",
					  width: 400,
					});  */
				}
			} 
		}  
		x.open("GET","sendMessage.jsp?cldocno="+cldocnos+"&msg="+encodeURIComponent(msg)+"&attachdoc="+attachdoc+"&extn="+extn,true);  
		x.send();        
	}
	
	function funUserSearch(){
		var searchtxt = $('#txtsearch').val(); 
		var userid = '<%= userid%>';
		$('.chat-list').html('');
  		$.ajax({
             type: "POST",
             url: "getData.jsp",      
             data: {
            	 name: encodeURIComponent(searchtxt),
            	 userid: userid
             },
             success: function(response) {
             	var items = response.trim();
  				var fielddata = JSON.parse(items.trim());          
  				var fieldshtml=""; 
  				var users = fielddata.users;
  				for(var i = 0; i < users.length; i++) {
				    var user = users[i];
				    fieldshtml+='<div class="chat-box">'
					fieldshtml+='<div class="img-box">'
					//fieldshtml+='<img class="img-cover" src="icons/whatsapp_user_dp.png" alt=""></div>'
					fieldshtml+='<i class="fa fa-user" aria-hidden="true"></i></div>'
					fieldshtml+='<div class="chat-details">'
					fieldshtml+='<div class="text-head"><h6>'+user.wauser+'</h6>'
					fieldshtml+='<input type="hidden" id="userno' + i + '" name="userno' + i + '" value="' + user.cldocno + '">'  
					fieldshtml+='</div></div></div>'   
				}
				if(fieldshtml!=''){
					$('.chat-list').html($.parseHTML(fieldshtml));
				}
             },
             error: function() {
             }
         });
	}
	
	function funDownloadMedia(mediaId, imageElement, attachDoc){   
		$.ajax({
            type: "POST",
            url: "downloadMedia.jsp",        
            data: {
            	mediaId:  mediaId,
            	attachDoc:  attachDoc
            },
            success: function(response) {
            	var items = response.split('####');
            	if(parseInt(items[0].trim())>0){
            		Swal.fire({
  					  title: "Success",
  					  text: "Successfully Downloaded",
  					  icon: "success",
  					  width: 400,
  					});
            		var filenames = items[3].trim().split('.')
            		//alert(items[1].trim()+"=="+items[2].trim()+"=="+filenames[0])
            		fileName = filenames[0]
            		fileURL = items[2].trim()
            		var host = window.location.origin;
          		    //var splt = fileURL.split("webapps");
          		    var splt = fileURL.split("webContent");
          		    var repl = splt[1].replace( /;/g, "/");
          		    fileURL=host+"/Qudra/"+repl;
          		    imageElement.src = fileURL;
          		    //alert("fileURL==="+fileURL)
          		    if (!window.ActiveXObject) {  
          		        var save = document.createElement('a');
          		        save.href = fileURL;
          		        save.target = '_blank';
          		        save.download = fileName || 'unknown';
          				
          		        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
          		    } else if ( !! window.ActiveXObject && document.execCommand)     {
          		        var _window = window.open(fileURL, '_blank');
          		        _window.document.close();
          		        _window.document.execCommand('SaveAs', true, fileName || fileURL)
          		        _window.close();
          		    }else{}
          		    
            	}else{
            		Swal.fire({
    					  title: "Error",
    					  text: "Failed to Download",
    					  icon: "error",
    					  width: 400,
    				});
            	}  
            },
            error: function() {
            }
        });
	} 
  </script>
</body>
</html>