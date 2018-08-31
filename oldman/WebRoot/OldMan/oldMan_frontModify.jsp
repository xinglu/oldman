<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OldMan" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    OldMan oldMan = (OldMan)request.getAttribute("oldMan");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改老人信息</TITLE>
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
  		<li class="active">老人信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="oldManEditForm" id="oldManEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="oldMan_oldManId_edit" class="col-md-3 text-right">老人编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="oldMan_oldManId_edit" name="oldMan.oldManId" class="form-control" placeholder="请输入老人编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="oldMan_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_name_edit" name="oldMan.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_sex_edit" name="oldMan.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_age_edit" class="col-md-3 text-right">年龄:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_age_edit" name="oldMan.age" class="form-control" placeholder="请输入年龄">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_manPhoto_edit" class="col-md-3 text-right">老人照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="oldMan_manPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="oldMan_manPhoto" name="oldMan.manPhoto"/>
			    <input id="manPhotoFile" name="manPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_manDesc_edit" class="col-md-3 text-right">老人介绍:</label>
		  	 <div class="col-md-9">
			    <script name="oldMan.manDesc" id="oldMan_manDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_userObj_user_name_edit" class="col-md-3 text-right">登记用户:</label>
		  	 <div class="col-md-9">
			    <select id="oldMan_userObj_user_name_edit" name="oldMan.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_addTime_edit" class="col-md-3 text-right">登记时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date oldMan_addTime_edit col-md-12" data-link-field="oldMan_addTime_edit">
                    <input class="form-control" id="oldMan_addTime_edit" name="oldMan.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOldManModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#oldManEditForm .form-group {margin-bottom:5px;}  </style>
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
var oldMan_manDesc_editor = UE.getEditor('oldMan_manDesc_edit'); //老人介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改老人界面并初始化数据*/
function oldManEdit(oldManId) {
  oldMan_manDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(oldManId);
  });
}
 function ajaxModifyQuery(oldManId) {
	$.ajax({
		url :  basePath + "OldMan/" + oldManId + "/update",
		type : "get",
		dataType: "json",
		success : function (oldMan, response, status) {
			if (oldMan) {
				$("#oldMan_oldManId_edit").val(oldMan.oldManId);
				$("#oldMan_name_edit").val(oldMan.name);
				$("#oldMan_sex_edit").val(oldMan.sex);
				$("#oldMan_age_edit").val(oldMan.age);
				$("#oldMan_manPhoto").val(oldMan.manPhoto);
				$("#oldMan_manPhotoImg").attr("src", basePath +　oldMan.manPhoto);
				oldMan_manDesc_editor.setContent(oldMan.manDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#oldMan_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#oldMan_userObj_user_name_edit").html(html);
		        		$("#oldMan_userObj_user_name_edit").val(oldMan.userObjPri);
					}
				});
				$("#oldMan_addTime_edit").val(oldMan.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交老人信息表单给服务器端修改*/
function ajaxOldManModify() {
	$.ajax({
		url :  basePath + "OldMan/" + $("#oldMan_oldManId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#oldManEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#oldManQueryForm").submit();
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
    /*登记时间组件*/
    $('.oldMan_addTime_edit').datetimepicker({
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
    oldManEdit("<%=request.getParameter("oldManId")%>");
 })
 </script> 
</body>
</html>

