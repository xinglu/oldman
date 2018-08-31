<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomOrder.css" />
<div id="roomOrderAddDiv">
	<form id="roomOrderAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">入住房间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_roomObj_roomNo" name="roomOrder.roomObj.roomNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住老人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_oldManObj_oldManId" name="roomOrder.oldManObj.oldManId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_liveDate" name="roomOrder.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">入住时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_monthNum" name="roomOrder.monthNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单总金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderMoney" name="roomOrder.orderMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderState" name="roomOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">订单费用明细:</span>
			<span class="inputControl">
				<script name="roomOrder.orderDesc" id="roomOrder_orderDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">订单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderTime" name="roomOrder.orderTime" />

			</span>

		</div>
		<div class="operation">
			<a id="roomOrderAddButton" class="easyui-linkbutton">添加</a>
			<a id="roomOrderClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomOrder/js/roomOrder_add.js"></script> 
