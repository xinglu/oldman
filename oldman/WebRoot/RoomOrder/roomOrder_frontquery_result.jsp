<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.RoomOrder" %>
<%@ page import="com.shuangyulin.po.OldMan" %>
<%@ page import="com.shuangyulin.po.Room" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<RoomOrder> roomOrderList = (List<RoomOrder>)request.getAttribute("roomOrderList");
    //获取所有的oldManObj信息
    List<OldMan> oldManList = (List<OldMan>)request.getAttribute("oldManList");
    //获取所有的roomObj信息
    List<Room> roomList = (List<Room>)request.getAttribute("roomList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Room roomObj = (Room)request.getAttribute("roomObj");
    OldMan oldManObj = (OldMan)request.getAttribute("oldManObj");
    String liveDate = (String)request.getAttribute("liveDate"); //入住日期查询关键字
    String orderState = (String)request.getAttribute("orderState"); //订单状态查询关键字
    String orderTime = (String)request.getAttribute("orderTime"); //订单时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订单查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#roomOrderListPanel" aria-controls="roomOrderListPanel" role="tab" data-toggle="tab">订单列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>RoomOrder/roomOrder_frontAdd.jsp" style="display:none;">添加订单</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="roomOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单编号</td><td>入住房间</td><td>入住老人</td><td>入住日期</td><td>入住时间</td><td>订单总金额</td><td>订单状态</td><td>订单时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<roomOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		RoomOrder roomOrder = roomOrderList.get(i); //获取到订单对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=roomOrder.getOrderId() %></td>
 											<td><%=roomOrder.getRoomObj().getRoomName() %></td>
 											<td><%=roomOrder.getOldManObj().getName() %></td>
 											<td><%=roomOrder.getLiveDate() %></td>
 											<td><%=roomOrder.getMonthNum() %></td>
 											<td><%=roomOrder.getOrderMoney() %></td>
 											<td><%=roomOrder.getOrderState() %></td>
 											<td><%=roomOrder.getOrderTime() %></td>
 											<td>
 												<a href="<%=basePath  %>RoomOrder/<%=roomOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="roomOrderEdit('<%=roomOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="roomOrderDelete('<%=roomOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>订单查询</h1>
		</div>
		<form name="roomOrderQueryForm" id="roomOrderQueryForm" action="<%=basePath %>RoomOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="roomObj_roomNo">入住房间：</label>
                <select id="roomObj_roomNo" name="roomObj.roomNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Room roomTemp:roomList) {
	 					String selected = "";
 					if(roomObj!=null && roomObj.getRoomNo()!=null && roomObj.getRoomNo().equals(roomTemp.getRoomNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=roomTemp.getRoomNo() %>" <%=selected %>><%=roomTemp.getRoomName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="oldManObj_oldManId">入住老人：</label>
                <select id="oldManObj_oldManId" name="oldManObj.oldManId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(OldMan oldManTemp:oldManList) {
	 					String selected = "";
 					if(oldManObj!=null && oldManObj.getOldManId()!=null && oldManObj.getOldManId().intValue()==oldManTemp.getOldManId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=oldManTemp.getOldManId() %>" <%=selected %>><%=oldManTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="liveDate">入住日期:</label>
				<input type="text" id="liveDate" name="liveDate" class="form-control"  placeholder="请选择入住日期" value="<%=liveDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="orderState">订单状态:</label>
				<input type="text" id="orderState" name="orderState" value="<%=orderState %>" class="form-control" placeholder="请输入订单状态">
			</div>






			<div class="form-group">
				<label for="orderTime">订单时间:</label>
				<input type="text" id="orderTime" name="orderTime" class="form-control"  placeholder="请选择订单时间" value="<%=orderTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="roomOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date roomOrder_liveDate_edit col-md-12" data-link-field="roomOrder_liveDate_edit"  data-link-format="yyyy-mm-dd">
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
			 	<textarea name="roomOrder.orderDesc" id="roomOrder_orderDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#roomOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRoomOrderModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var roomOrder_orderDesc_edit = UE.getEditor('roomOrder_orderDesc_edit'); //订单费用明细编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.roomOrderQueryForm.currentPage.value = currentPage;
    document.roomOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.roomOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.roomOrderQueryForm.currentPage.value = pageValue;
    documentroomOrderQueryForm.submit();
}

/*弹出修改订单界面并初始化数据*/
function roomOrderEdit(orderId) {
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
				roomOrder_orderDesc_edit.setContent(roomOrder.orderDesc, false);
				$("#roomOrder_orderTime_edit").val(roomOrder.orderTime);
				$('#roomOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除订单信息*/
function roomOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "RoomOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#roomOrderQueryForm").submit();
					//location.href= basePath + "RoomOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

