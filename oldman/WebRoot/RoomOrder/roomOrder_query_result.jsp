<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomOrder.css" /> 

<div id="roomOrder_manage"></div>
<div id="roomOrder_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="roomOrder_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="roomOrder_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="roomOrder_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="roomOrder_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="roomOrder_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="roomOrderQueryForm" method="post">
			入住房间：<input class="textbox" type="text" id="roomObj_roomNo_query" name="roomObj.roomNo" style="width: auto"/>
			入住老人：<input class="textbox" type="text" id="oldManObj_oldManId_query" name="oldManObj.oldManId" style="width: auto"/>
			入住日期：<input type="text" id="liveDate" name="liveDate" class="easyui-datebox" editable="false" style="width:100px">
			订单状态：<input type="text" class="textbox" id="orderState" name="orderState" style="width:110px" />
			订单时间：<input type="text" id="orderTime" name="orderTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="roomOrder_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="roomOrderEditDiv">
	<form id="roomOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderId_edit" name="roomOrder.orderId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">入住房间:</span>
			<span class="inputControl">
				<input class="textbox"  id="roomOrder_roomObj_roomNo_edit" name="roomOrder.roomObj.roomNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住老人:</span>
			<span class="inputControl">
				<input class="textbox"  id="roomOrder_oldManObj_oldManId_edit" name="roomOrder.oldManObj.oldManId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_liveDate_edit" name="roomOrder.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">入住时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_monthNum_edit" name="roomOrder.monthNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单总金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderMoney_edit" name="roomOrder.orderMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderState_edit" name="roomOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单费用明细:</span>
			<span class="inputControl">
				<script name="roomOrder.orderDesc" id="roomOrder_orderDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">订单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderTime_edit" name="roomOrder.orderTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var roomOrder_orderDesc_editor = UE.getEditor('roomOrder_orderDesc_edit'); //订单费用明细编辑器
</script>
<script type="text/javascript" src="RoomOrder/js/roomOrder_manage.js"></script> 
