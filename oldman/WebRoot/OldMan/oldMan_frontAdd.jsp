<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>老人添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>OldMan/frontlist">老人管理</a></li>
  			<li class="active">添加老人</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="oldManAddForm" id="oldManAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="oldMan_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="oldMan_name" name="oldMan.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_sex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="oldMan_sex" name="oldMan.sex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_age" class="col-md-2 text-right">年龄:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="oldMan_age" name="oldMan.age" class="form-control" placeholder="请输入年龄">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_manPhoto" class="col-md-2 text-right">老人照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="oldMan_manPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="oldMan_manPhoto" name="oldMan.manPhoto"/>
					    <input id="manPhotoFile" name="manPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_manDesc" class="col-md-2 text-right">老人介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="oldMan.manDesc" id="oldMan_manDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_userObj_user_name" class="col-md-2 text-right">登记用户:</label>
				  	 <div class="col-md-8">
					    <select id="oldMan_userObj_user_name" name="oldMan.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="oldMan_addTimeDiv" class="col-md-2 text-right">登记时间:</label>
				  	 <div class="col-md-8">
		                <div id="oldMan_addTimeDiv" class="input-group date oldMan_addTime col-md-12" data-link-field="oldMan_addTime">
		                    <input class="form-control" id="oldMan_addTime" name="oldMan.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxOldManAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#oldManAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var oldMan_manDesc_editor = UE.getEditor('oldMan_manDesc'); //老人介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加老人信息
	function ajaxOldManAdd() { 
		//提交之前先验证表单
		$("#oldManAddForm").data('bootstrapValidator').validate();
		if(!$("#oldManAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "OldMan/add",
			dataType : "json" , 
			data: new FormData($("#oldManAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#oldManAddForm").find("input").val("");
					$("#oldManAddForm").find("textarea").val("");
					oldMan_manDesc_editor.setContent("");
				} else {
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
	//验证老人添加表单字段
	$('#oldManAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"oldMan.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"oldMan.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"oldMan.age": {
				validators: {
					notEmpty: {
						message: "年龄不能为空",
					},
					integer: {
						message: "年龄不正确"
					}
				}
			},
			"oldMan.addTime": {
				validators: {
					notEmpty: {
						message: "登记时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化登记用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#oldMan_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#oldMan_userObj_user_name").html(html);
    	}
	});
	//登记时间组件
	$('#oldMan_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#oldManAddForm').data('bootstrapValidator').updateStatus('oldMan.addTime', 'NOT_VALIDATED',null).validateField('oldMan.addTime');
	});
})
</script>
</body>
</html>
