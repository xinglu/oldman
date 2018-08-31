<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OldMan" %>
<%@ page import="com.shuangyulin.po.Room" %>
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
<title>订单添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>RoomOrder/frontlist">订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#roomOrderAdd" aria-controls="roomOrderAdd" role="tab" data-toggle="tab">添加订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="roomOrderList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="roomOrderAdd"> 
				      	<form class="form-horizontal" name="roomOrderAddForm" id="roomOrderAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="roomOrder_roomObj_roomNo" class="col-md-2 text-right">入住房间:</label>
						  	 <div class="col-md-8">
							    <select id="roomOrder_roomObj_roomNo" name="roomOrder.roomObj.roomNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_oldManObj_oldManId" class="col-md-2 text-right">入住老人:</label>
						  	 <div class="col-md-8">
							    <select id="roomOrder_oldManObj_oldManId" name="roomOrder.oldManObj.oldManId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_liveDateDiv" class="col-md-2 text-right">入住日期:</label>
						  	 <div class="col-md-8">
				                <div id="roomOrder_liveDateDiv" class="input-group date roomOrder_liveDate col-md-12" data-link-field="roomOrder_liveDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="roomOrder_liveDate" name="roomOrder.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_monthNum" class="col-md-2 text-right">入住时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomOrder_monthNum" name="roomOrder.monthNum" class="form-control" placeholder="请输入入住时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_orderMoney" class="col-md-2 text-right">订单总金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomOrder_orderMoney" name="roomOrder.orderMoney" class="form-control" placeholder="请输入订单总金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_orderState" class="col-md-2 text-right">订单状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="roomOrder_orderState" name="roomOrder.orderState" class="form-control" placeholder="请输入订单状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_orderDesc" class="col-md-2 text-right">订单费用明细:</label>
						  	 <div class="col-md-8">
							    <textarea name="roomOrder.orderDesc" id="roomOrder_orderDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="roomOrder_orderTimeDiv" class="col-md-2 text-right">订单时间:</label>
						  	 <div class="col-md-8">
				                <div id="roomOrder_orderTimeDiv" class="input-group date roomOrder_orderTime col-md-12" data-link-field="roomOrder_orderTime">
				                    <input class="form-control" id="roomOrder_orderTime" name="roomOrder.orderTime" size="16" type="text" value="" placeholder="请选择订单时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxRoomOrderAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#roomOrderAddForm .form-group {margin:10px;}  </style>
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
var roomOrder_orderDesc_editor = UE.getEditor('roomOrder_orderDesc'); //订单费用明细编辑器
var basePath = "<%=basePath%>";
	//提交添加订单信息
	function ajaxRoomOrderAdd() { 
		//提交之前先验证表单
		$("#roomOrderAddForm").data('bootstrapValidator').validate();
		if(!$("#roomOrderAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "RoomOrder/add",
			dataType : "json" , 
			data: new FormData($("#roomOrderAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#roomOrderAddForm").find("input").val("");
					$("#roomOrderAddForm").find("textarea").val("");
					roomOrder_orderDesc_editor.setContent("");
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
	//验证订单添加表单字段
	$('#roomOrderAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"roomOrder.liveDate": {
				validators: {
					notEmpty: {
						message: "入住日期不能为空",
					}
				}
			},
			"roomOrder.monthNum": {
				validators: {
					notEmpty: {
						message: "入住时间不能为空",
					},
					integer: {
						message: "入住时间不正确"
					}
				}
			},
			"roomOrder.orderMoney": {
				validators: {
					notEmpty: {
						message: "订单总金额不能为空",
					},
					numeric: {
						message: "订单总金额不正确"
					}
				}
			},
			"roomOrder.orderState": {
				validators: {
					notEmpty: {
						message: "订单状态不能为空",
					}
				}
			},
			"roomOrder.orderTime": {
				validators: {
					notEmpty: {
						message: "订单时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化入住房间下拉框值 
	$.ajax({
		url: basePath + "Room/listAll",
		type: "get",
		success: function(rooms,response,status) { 
			$("#roomOrder_roomObj_roomNo").empty();
			var html="";
    		$(rooms).each(function(i,room){
    			html += "<option value='" + room.roomNo + "'>" + room.roomName + "</option>";
    		});
    		$("#roomOrder_roomObj_roomNo").html(html);
    	}
	});
	//初始化入住老人下拉框值 
	$.ajax({
		url: basePath + "OldMan/listAll",
		type: "get",
		success: function(oldMans,response,status) { 
			$("#roomOrder_oldManObj_oldManId").empty();
			var html="";
    		$(oldMans).each(function(i,oldMan){
    			html += "<option value='" + oldMan.oldManId + "'>" + oldMan.name + "</option>";
    		});
    		$("#roomOrder_oldManObj_oldManId").html(html);
    	}
	});
	//入住日期组件
	$('#roomOrder_liveDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#roomOrderAddForm').data('bootstrapValidator').updateStatus('roomOrder.liveDate', 'NOT_VALIDATED',null).validateField('roomOrder.liveDate');
	});
	//订单时间组件
	$('#roomOrder_orderTimeDiv').datetimepicker({
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
		$('#roomOrderAddForm').data('bootstrapValidator').updateStatus('roomOrder.orderTime', 'NOT_VALIDATED',null).validateField('roomOrder.orderTime');
	});
})
</script>
</body>
</html>
