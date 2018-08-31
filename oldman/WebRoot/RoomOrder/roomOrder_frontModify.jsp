<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.RoomOrder" %>
<%@ page import="com.shuangyulin.po.OldMan" %>
<%@ page import="com.shuangyulin.po.Room" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的oldManObj信息
    List<OldMan> oldManList = (List<OldMan>)request.getAttribute("oldManList");
    //获取所有的roomObj信息
    List<Room> roomList = (List<Room>)request.getAttribute("roomList");
    RoomOrder roomOrder = (RoomOrder)request.getAttribute("roomOrder");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改订单信息</TITLE>
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
  		<li class="active">订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="roomOrderEditForm" id="roomOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="roomOrder_orderId_edit" class="col-md-3 text-right">订单编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="roomOrder_orderId_edit" name="roomOrder.orderId" class="form-control" placeholder="请输入订单编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="roomOrder_roomObj_roomNo_edit" class="col-md-3 text-right">入住房间:</label>
		  	 <div class="col-md-9">
			    <select id="roomOrder_roomObj_roomNo_edit" name="roomOrder.roomObj.roomNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_oldManObj_oldManId_edit" class="col-md-3 text-right">入住老人:</label>
		  	 <div class="col-md-9">
			    <select id="roomOrder_oldManObj_oldManId_edit" name="roomOrder.oldManObj.oldManId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_liveDate_edit" class="col-md-3 text-right">入住日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date roomOrder_liveDate_edit col-md-12" data-link-field="roomOrder_liveDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="roomOrder_liveDate_edit" name="roomOrder.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_monthNum_edit" class="col-md-3 text-right">入住时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomOrder_monthNum_edit" name="roomOrder.monthNum" class="form-control" placeholder="请输入入住时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_orderMoney_edit" class="col-md-3 text-right">订单总金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomOrder_orderMoney_edit" name="roomOrder.orderMoney" class="form-control" placeholder="请输入订单总金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_orderState_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomOrder_orderState_edit" name="roomOrder.orderState" class="form-control" placeholder="请输入订单状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_orderDesc_edit" class="col-md-3 text-right">订单费用明细:</label>
		  	 <div class="col-md-9">
			    <script name="roomOrder.orderDesc" id="roomOrder_orderDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomOrder_orderTime_edit" class="col-md-3 text-right">订单时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date roomOrder_orderTime_edit col-md-12" data-link-field="roomOrder_orderTime_edit">
                    <input class="form-control" id="roomOrder_orderTime_edit" name="roomOrder.orderTime" size="16" type="text" value="" placeholder="请选择订单时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRoomOrderModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#roomOrderEditForm .form-group {margin-bottom:5px;}  </style>
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
var roomOrder_orderDesc_editor = UE.getEditor('roomOrder_orderDesc_edit'); //订单费用明细编辑框
var basePath = "<%=basePath%>";
/*弹出修改订单界面并初始化数据*/
function roomOrderEdit(orderId) {
  roomOrder_orderDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(orderId);
  });
}
 function ajaxModifyQuery(orderId) {
	$.ajax({
		url :  basePath + "RoomOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (roomOrder, response, status) {
			if (roomOrder) {
				$("#roomOrder_orderId_edit").val(roomOrder.orderId);
				$.ajax({
					url: basePath + "Room/listAll",
					type: "get",
					success: function(rooms,response,status) { 
						$("#roomOrder_roomObj_roomNo_edit").empty();
						var html="";
		        		$(rooms).each(function(i,room){
		        			html += "<option value='" + room.roomNo + "'>" + room.roomName + "</option>";
		        		});
		        		$("#roomOrder_roomObj_roomNo_edit").html(html);
		        		$("#roomOrder_roomObj_roomNo_edit").val(roomOrder.roomObjPri);
					}
				});
				$.ajax({
					url: basePath + "OldMan/listAll",
					type: "get",
					success: function(oldMans,response,status) { 
						$("#roomOrder_oldManObj_oldManId_edit").empty();
						var html="";
		        		$(oldMans).each(function(i,oldMan){
		        			html += "<option value='" + oldMan.oldManId + "'>" + oldMan.name + "</option>";
		        		});
		        		$("#roomOrder_oldManObj_oldManId_edit").html(html);
		        		$("#roomOrder_oldManObj_oldManId_edit").val(roomOrder.oldManObjPri);
					}
				});
				$("#roomOrder_liveDate_edit").val(roomOrder.liveDate);
				$("#roomOrder_monthNum_edit").val(roomOrder.monthNum);
				$("#roomOrder_orderMoney_edit").val(roomOrder.orderMoney);
				$("#roomOrder_orderState_edit").val(roomOrder.orderState);
				roomOrder_orderDesc_editor.setContent(roomOrder.orderDesc, false);
				$("#roomOrder_orderTime_edit").val(roomOrder.orderTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交订单信息表单给服务器端修改*/
function ajaxRoomOrderModify() {
	$.ajax({
		url :  basePath + "RoomOrder/" + $("#roomOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#roomOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#roomOrderQueryForm").submit();
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
    /*入住日期组件*/
    $('.roomOrder_liveDate_edit').datetimepicker({
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
    /*订单时间组件*/
    $('.roomOrder_orderTime_edit').datetimepicker({
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
    roomOrderEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

