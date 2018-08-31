<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/nurse.css" />
<div id="nurseAddDiv">
	<form id="nurseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">信息类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_nurseType" name="nurse.nurseType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_title" name="nurse.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信息内容:</span>
			<span class="inputControl">
				<script name="nurse.content" id="nurse_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="nurse_publishDate" name="nurse.publishDate" />

			</span>

		</div>
		<div class="operation">
			<a id="nurseAddButton" class="easyui-linkbutton">添加</a>
			<a id="nurseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Nurse/js/nurse_add.js"></script> 
