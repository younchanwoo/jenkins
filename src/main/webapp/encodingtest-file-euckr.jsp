<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
    
<%@ page import="java.io.*" %>

<!-- 
Encoding Ȯ�ι��
1. ����ɼǿ� -Dfile.encoding=euc-kr �Ǵ� utf-8 �߰�
2. FileOutputStream ������ ���ڵ� ����
2. jsp������ ���ڵ��� ������ ������ ���ڵ����� �����.
3. ������ ���� Ȯ�� �� ������ LANG������ ���߾� �����Ѵ�. (LANG=ko_KR.euckr �Ǵ� LANG=ko_KR.utf8)
4. �͹̳� ���ڵ��� �����.
 -->

<%
        
    String first = null ;
    String word = null;
    String filename = "/tmp/test.txt";
    
    if ( request.getParameter("data") != null )
    {
	    first = request.getParameter("data");
	    word = first;
	    
	    System.out.println("Default Encoding        : " + word);
	    
	    try {
				File fileDir = new File(filename);
					
				//Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir), "UTF8"));
				Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir), "EUC_KR"));
				//Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir)));
				
				writer.append("�ѱ�------------------------").append("\r\n");
				writer.append(word).append("\r\n");
				writer.append("iso-8859-1 => euc-kr : ").append(new String(word.getBytes("iso-8859-1"), "euc-kr")).append("\r\n");
				writer.append("iso-8859-1 => utf-8 : ").append(new String(word.getBytes("iso-8859-1"), "utf-8")).append("\r\n");
				writer.append("utf-8 => utf-8 : ").append(new String(word.getBytes("utf-8"), "utf-8")).append("\r\n");
				writer.append("euc-kr => euc-kr : ").append(new String(word.getBytes("euc-kr"), "euc-kr")).append("\r\n");
				
				writer.flush();
				writer.close();
		        
		    } 
		   catch (UnsupportedEncodingException e) 
		   {
			System.out.println(e.getMessage());
		   } 
		   catch (IOException e) 
		   {
			System.out.println(e.getMessage());
		    }
		   catch (Exception e)
		   {
			System.out.println(e.getMessage());
		   } 
	    
    } else first = "NULL";
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>encoding test result</title>
<script type="text/javascript">
	function send_by_post(){
		var frm=document.encoding;
		frm.method="post";
		frm.submit();
	}
	function send_by_get(){
		var frm=document.encoding;
		frm.method="get";
		frm.submit();
	}
</script>
</head>
<body>
<form name="encoding">
<table border="1" cellspacing="0" width="500">
  <tr>
    <th width="10%">����</th><th width="25%">�Է°�</th>
  </tr>
  <tr>
      <td>Input Data</td>
      <td><input name="data"></td>
  </tr>
  <tr>
      <td colspan=2>
      		<input type="button" value="Send by Post" onclick="javascript:send_by_post()">
      		<input type="button" value="Send by Get" onclick="javascript:send_by_get()">
      </td>     
  </tr>
</table>
</form>
<br>
<br>
# Encoding Result
<br>
<%
    if ( first.equals("NULL")) {
	  	out.println("�Է°� : " + first);
    } else {
        out.println("�Է°� : " + first);
        out.println("<br><br>");
%>
    	<table border="1" cellspacing="0" width="800">
    	  <tr>
    	    <th width="10%">����</th><th width="25%">�����</th>
    	  </tr>
    	  <tr>
    	      <td>File</td>
    	      <td> <% out.println(filename); %></td>
    	  </tr>
    	  
    	</table>
<%
    }
%>
</form>
</body>
</html>