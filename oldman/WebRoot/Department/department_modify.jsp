<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" />
<div id="department_editDiv">
	<form id="departmentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">部门编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentId_edit" name="department.departmentId" value="<%=request.getParameter("departmentId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">部门名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departName_edit" name="department.departName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_bornDate_edit" name="department.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">负责人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_mainPerson_edit" name="department.mainPerson" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="departmentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Department/js/department_modify.js"></script> 
