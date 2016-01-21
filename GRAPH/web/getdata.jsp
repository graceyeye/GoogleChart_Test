
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>

<%
	Connection con = null;
	try {
		//드라이버 생성 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test", "root", "1234");

		//ResultSet : 쿼리문에 대한 반환값
		ResultSet rs = null;

		List empdetails = new LinkedList();
		JSONObject responseObj = new JSONObject();

		String query = "SELECT id,name from employee";
		//PreparedStatement: 쿼리문장 미리 준비해놓음
		PreparedStatement pstm = con.prepareStatement(query);

		rs = pstm.executeQuery();

		JSONObject empObj = null;

		//rs에 다음값이 있을 때 까지
		while (rs.next()) {
			String name = rs.getString("name");
			int empid = rs.getInt("id");
			empObj = new JSONObject();
			empObj.put("name", name);
			empObj.put("empid", empid);
			empdetails.add(empObj);
		}
		responseObj.put("empdetails", empdetails);
		out.print(responseObj.toString());
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
%>

