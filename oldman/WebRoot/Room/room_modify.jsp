<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" />
<div id="room_editDiv">
	<form id="roomEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomNo_edit" name="room.roomNo" value="<%=request.getParameter("roomNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="room_roomTypeObj_typeId_edit" name="room.roomTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomName_edit" name="room.roomName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间主图:</span>
			<span class="inputControl">
				<img id="room_mainPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="room_mainPhoto" name="room.mainPhoto"/>
				<input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">房间价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_price_edit" name="room.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">房间详情:</span>
			<span class="inputControl">
				<script id="room_roomDesc_edit" name="room.roomDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">房间状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomState_edit" name="room.roomState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Room/js/room_modify.js"></script> 
