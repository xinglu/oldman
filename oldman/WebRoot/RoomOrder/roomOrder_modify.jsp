<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomOrder.css" />
<div id="roomOrder_editDiv">
	<form id="roomOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderId_edit" name="roomOrder.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
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
				<script id="roomOrder_orderDesc_edit" name="roomOrder.orderDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">订单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomOrder_orderTime_edit" name="roomOrder.orderTime" />

			</span>

		</div>
		<div class="operation">
			<a id="roomOrderModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomOrder/js/roomOrder_modify.js"></script> 
