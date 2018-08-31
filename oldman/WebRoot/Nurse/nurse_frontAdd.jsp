<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>老人看护添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Nurse/frontlist">老人看护列表</a></li>
			    	<li role="presentation" class="active"><a href="#nurseAdd" aria-controls="nurseAdd" role="tab" data-toggle="tab">添加老人看护</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="nurseList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="nurseAdd"> 
				      	<form class="form-horizontal" name="nurseAddForm" id="nurseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="nurse_nurseType" class="col-md-2 text-right">信息类别:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="nurse_nurseType" name="nurse.nurseType" class="form-control" placeholder="请输入信息类别">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="nurse_title" class="col-md-2 text-right">信息标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="nurse_title" name="nurse.title" class="form-control" placeholder="请输入信息标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="nurse_content" class="col-md-2 text-right">信息内容:</label>
						  	 <div class="col-md-8">
							    <textarea name="nurse.content" id="nurse_content" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="nurse_publishDateDiv" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
				                <div id="nurse_publishDateDiv" class="input-group date nurse_publishDate col-md-12" data-link-field="nurse_publishDate">
				                    <input class="form-control" id="nurse_publishDate" name="nurse.publishDate" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNurseAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#nurseAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
var nurse_content_editor = UE.getEditor('nurse_content'); //信息内容编辑器
var basePath = "<%=basePath%>";
	//提交添加老人看护信息
	function ajaxNurseAdd() { 
		//提交之前先验证表单
		$("#nurseAddForm").data('bootstrapValidator').validate();
		if(!$("#nurseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(nurse_content_editor.getContent() == "") {
			alert('信息内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Nurse/add",
			dataType : "json" , 
			data: new FormData($("#nurseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#nurseAddForm").find("input").val("");
					$("#nurseAddForm").find("textarea").val("");
					nurse_content_editor.setContent("");
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
	//验证老人看护添加表单字段
	$('#nurseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"nurse.nurseType": {
				validators: {
					notEmpty: {
						message: "信息类别不能为空",
					}
				}
			},
			"nurse.title": {
				validators: {
					notEmpty: {
						message: "信息标题不能为空",
					}
				}
			},
			"nurse.publishDate": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//发布时间组件
	$('#nurse_publishDateDiv').datetimepicker({
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
		$('#nurseAddForm').data('bootstrapValidator').updateStatus('nurse.publishDate', 'NOT_VALIDATED',null).validateField('nurse.publishDate');
	});
})
</script>
</body>
</html>
