<%@ page import="com.dashboard.operations.whatsappmessaging.ClsWhatsappMessagingDAO" %>
<%  ClsWhatsappMessagingDAO cod=new ClsWhatsappMessagingDAO(); %>     
<style>
#jqxGroupSearch{
	background-color:#fff;        
	height: 20px;
}
</style>
<script type="text/javascript">
		$(document).ready(function () { 	
			var grpdata='<%=cod.groupdetails()%>';
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'groups', type: 'string'  },
                        ],
                 	localdata: grpdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxGroupSearch").jqxInput({ source: dataAdapter, displayMember: "groups", valueMember: "groups",width: '100%', height: 20,placeHolder: "Please Enter Group"});
        });
		 
    </script>
    <input type="text" id="jqxGroupSearch" class="p-l-5 input-sm form-control"  /> 