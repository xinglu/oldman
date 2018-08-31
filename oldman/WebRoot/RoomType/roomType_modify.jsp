<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomType.css" />
<div id="roomType_editDiv">
	<form id="roomTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_typeId_edit" name="roomType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">房间类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_typeName_edit" name="roomType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomType/js/roomType_modify.js"></script> 
