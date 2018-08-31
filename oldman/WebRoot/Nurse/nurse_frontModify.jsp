<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Nurse" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Nurse nurse = (Nurse)request.getAttribute("nurse");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改老人看护信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">老人看护信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="nurseEditForm" id="nurseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="nurse_nurseId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="nurse_nurseId_edit" name="nurse.nurseId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="nurse_nurseType_edit" class="col-md-3 text-right">信息类别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="nurse_nurseType_edit" name="nurse.nurseType" class="form-control" placeholder="请输入信息类别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_title_edit" class="col-md-3 text-right">信息标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="nurse_title_edit" name="nurse.title" class="form-control" placeholder="请输入信息标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_content_edit" class="col-md-3 text-right">信息内容:</label>
		  	 <div class="col-md-9">
			    <script name="nurse.content" id="nurse_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_publishDate_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date nurse_publishDate_edit col-md-12" data-link-field="nurse_publishDate_edit">
                    <input class="form-control" id="nurse_publishDate_edit" name="nurse.publishDate" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNurseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#nurseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var nurse_content_editor = UE.getEditor('nurse_content_edit'); //信息内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改老人看护界面并初始化数据*/
function nurseEdit(nurseId) {
  nurse_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(nurseId);
  });
}
 function ajaxModifyQuery(nurseId) {
	$.ajax({
		url :  basePath + "Nurse/" + nurseId + "/update",
		type : "get",
		dataType: "json",
		success : function (nurse, response, status) {
			if (nurse) {
				$("#nurse_nurseId_edit").val(nurse.nurseId);
				$("#nurse_nurseType_edit").val(nurse.nurseType);
				$("#nurse_title_edit").val(nurse.title);
				nurse_content_editor.setContent(nurse.content, false);
				$("#nurse_publishDate_edit").val(nurse.publishDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交老人看护信息表单给服务器端修改*/
function ajaxNurseModify() {
	$.ajax({
		url :  basePath + "Nurse/" + $("#nurse_nurseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#nurseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#nurseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*发布时间组件*/
    $('.nurse_publishDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    nurseEdit("<%=request.getParameter("nurseId")%>");
 })
 </script> 
</body>
</html>

