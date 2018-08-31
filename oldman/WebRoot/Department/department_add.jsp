<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" />
<div id="departmentAddDiv">
	<form id="departmentAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">部门名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departName" name="department.departName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_bornDate" name="department.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">负责人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_mainPerson" name="department.mainPerson" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="departmentAddButton" class="easyui-linkbutton">添加</a>
			<a id="departmentClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Department/js/department_add.js"></script> 
