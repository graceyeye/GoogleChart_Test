
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
	//커넥션 선언
	Connection con = null;
	try {
		//드라이버 호출, 커넥션 연결
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test", "root", "1234");

		//ResultSet : 쿼리문에 대한 반환값
		ResultSet rs = null;

		//DB에서 뽑아온 데이터(JSON) 을 담을 객체. 후에 responseObj에 담기는 값
		List barlist = new LinkedList();

		//ajax에 반환할 JSON 생성
		JSONObject responseObj = new JSONObject();

		String query = "SELECT * FROM BAR";
		PreparedStatement pstm = con.prepareStatement(query);

		rs = pstm.executeQuery();
		JSONObject barObj = null;
		
		//소수점 2번째 이하로 자름
		DecimalFormat f1 = new DecimalFormat("0.00");
		
		while (rs.next()) {
			String city = rs.getString("city");
			float amount = rs.getFloat("amount");
			float per = rs.getFloat("per");
			barObj = new JSONObject();
			barObj.put("city", city);
			barObj.put("amount", f1.format(amount));
			barObj.put("per", f1.format(per));
			barlist.add(barObj);
		}

		responseObj.put("barlist", barlist);
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