<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/nurse.css" />
<div id="nurse_editDiv">
	<form id="nurseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_nurseId_edit" name="nurse.nurseId" value="<%=request.getParameter("nurseId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">信息类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_nurseType_edit" name="nurse.nurseType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_title_edit" name="nurse.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息内容:</span>
			<span class="inputControl">
				<script id="nurse_content_edit" name="nurse.content" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_publishDate_edit" name="nurse.publishDate" />

			</span>

		</div>
		<div class="operation">
			<a id="nurseModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Nurse/js/nurse_modify.js"></script> 
