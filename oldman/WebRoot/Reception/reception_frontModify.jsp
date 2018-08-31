<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Reception" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Reception reception = (Reception)request.getAttribute("reception");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改接待信息</TITLE>
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
  		<li class="active">接待信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="receptionEditForm" id="receptionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="reception_receptionId_edit" class="col-md-3 text-right">接待记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="reception_receptionId_edit" name="reception.receptionId" class="form-control" placeholder="请输入接待记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="reception_receptType_edit" class="col-md-3 text-right">接待类别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="reception_receptType_edit" name="reception.receptType" class="form-control" placeholder="请输入接待类别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_title_edit" class="col-md-3 text-right">接待主题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="reception_title_edit" name="reception.title" class="form-control" placeholder="请输入接待主题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_content_edit" class="col-md-3 text-right">接待内容:</label>
		  	 <div class="col-md-9">
			    <script name="reception.content" id="reception_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_receptDate_edit" class="col-md-3 text-right">接待日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date reception_receptDate_edit col-md-12" data-link-field="reception_receptDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="reception_receptDate_edit" name="reception.receptDate" size="16" type="text" value="" placeholder="请选择接待日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxReceptionModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#receptionEditForm .form-group {margin-bottom:5px;}  </style>
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
var reception_content_editor = UE.getEditor('reception_content_edit'); //接待内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改接待界面并初始化数据*/
function receptionEdit(receptionId) {
  reception_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(receptionId);
  });
}
 function ajaxModifyQuery(receptionId) {
	$.ajax({
		url :  basePath + "Reception/" + receptionId + "/update",
		type : "get",
		dataType: "json",
		success : function (reception, response, status) {
			if (reception) {
				$("#reception_receptionId_edit").val(reception.receptionId);
				$("#reception_receptType_edit").val(reception.receptType);
				$("#reception_title_edit").val(reception.title);
				reception_content_editor.setContent(reception.content, false);
				$("#reception_receptDate_edit").val(reception.receptDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交接待信息表单给服务器端修改*/
function ajaxReceptionModify() {
	$.ajax({
		url :  basePath + "Reception/" + $("#reception_receptionId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#receptionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#receptionQueryForm").submit();
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
    /*接待日期组件*/
    $('.reception_receptDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    receptionEdit("<%=request.getParameter("receptionId")%>");
 })
 </script> 
</body>
</html>

