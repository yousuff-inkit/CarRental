<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.*"%>
<%@page import="java.util.ArrayList"%>


<%
	String br1 = request.getParameter("br1") == null || request.getParameter("br1").equals("") ? "0"
		: request.getParameter("br1");
String br2 = request.getParameter("br2") == null || request.getParameter("br2").equals("") ? "0"
		: request.getParameter("br2");
String br3 = request.getParameter("list1") == null || request.getParameter("list1").equals("")? ""
		: request.getParameter("list1");
System.out.println("br1========" + br1);
System.out.println("br2========" + br2);
System.out.println("br3 : " + br3);

Connection con = null;
int val1 = 0;
try {
	ClsConnection connDAO = new ClsConnection();
	con = connDAO.getMyConnection();
	Statement st = con.createStatement();
	String sql = "";
	ResultSet rs;

	int val = 0, kval = 0, jval=0;
	if (!br2.equals("0")) {
		kval++;
		if(!br1.equals(br2)){
			sql = "select doc_no from my_intr where (br1='"+br1+"' and br2='"+br2+"') or (br2='"+br1+"' and br1='"+br2+"')";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				val++;
			}
		}else{
			val++;
			jval++;
		}
	}
	ArrayList<String> newarray = new ArrayList();
	String temparray[] = br3.split(",");
	 
	for (int i = 0; i < temparray.length; i++) {
		if(!temparray[i].equals("")){
			kval++;
			if(!br1.equals(temparray[i])){  
				sql = "select doc_no from my_intr where (br1='"+br1+"' and br2='"+temparray[i]+"') or (br2='"+br1+"' and br1='"+temparray[i]+"')";
				rs = st.executeQuery(sql);
				if (rs.next()) {
					val++;
				}
			}else{
				val++;
				jval++;

			}
			
			
		}
	}

	if (val == kval && kval !=0) {
		val1 = 1;
	}
	if(jval==kval){
		val1=0;
	}

	con.close();
	st.close();
	

} catch (Exception e) {
	e.printStackTrace();
	con.close();
}
response.getWriter().print(val1);
%>