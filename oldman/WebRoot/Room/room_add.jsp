<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" />
<div id="roomAddDiv">
	<form id="roomAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomNo" name="room.roomNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomTypeObj_typeId" name="room.roomTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomName" name="room.roomName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间主图:</span>
			<span class="inputControl">
				<input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">房间价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_price" name="room.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">房间详情:</span>
			<span class="inputControl">
				<script name="room.roomDesc" id="room_roomDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">房间状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomState" name="room.roomState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomAddButton" class="easyui-linkbutton">添加</a>
			<a id="roomClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Room/js/room_add.js"></script> 
