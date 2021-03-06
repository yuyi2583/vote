<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,zjut.vote.person.Student" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
   
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
 
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<%@ include file="../other/select.jsp" %>

<table class="table table-striped">
	  <caption class="text-center">所有学院投票排名</caption>
	<button class="btn btn-info pull-right" id="export">导出投票数据</button>
	  <thead>
	    <tr>
	      <th>姓名</th>
	      <th>学院</th>
	      <th>学号</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<%ArrayList<Student> list=(ArrayList<Student>)session.getAttribute("notVoteInSecondtList");
	  	  for(int i=0;i<list.size();i++){
	  	%>
	    <tr>
	      <td><%=list.get(i).getName() %></td>
	      <td><%=list.get(i).getCollege() %>
	      <td><%=list.get(i).getNo() %></td>
	    </tr>
	    <%} %>
	  </tbody>
	</table>
<div id="frame" style="display:none;"></div>
	<script>
		var windowHeight=$(window).height();
		var l=$("table").offset().top;
		$("table").height(windowHeight-150);
		$("select").val("所有学院");
		$(document).ready(function(){
			$("#search").on("click",function(){
				var college=$("select").val();
				$.ajax({
		    		url:"../notVoteInSecond",
		    		type:"post",
		    		cache:false,
		    		data:{
		    			'college':college
		    		},
		    		success:function(data){
		    			if(data!=null){
		    				var detail=eval("("+data+")");
		    				var $str="";
		    				for(var i=0;i<detail.length;i++){
		    					$str+="<tr><td>"+detail[i].name+"</td><td>"+detail[i].college+"</td><td>"+detail[i].no+"</td></tr>";
		    				}
		    				$("tbody").html($str);
		    				$("caption").text(college+"未投票信息");
		    			}
		    		}
				});
			});
			
			$("#export").on("click",function(){
				var $str="<iframe src='../ExportNotVoteInSecond?college="+$("select").val()+"' style='display:none;'></iframe>";
				$("#frame").html($str);
			});
		});
	</script>
</body>
</html>