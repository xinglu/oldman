<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reception.css" />
<div id="reception_editDiv">
	<form id="receptionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">接待记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptionId_edit" name="reception.receptionId" value="<%=request.getParameter("receptionId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">接待类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptType_edit" name="reception.receptType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">接待主题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_title_edit" name="reception.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">接待内容:</span>
			<span class="inputControl">
				<script id="reception_content_edit" name="reception.content" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">接待日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptDate_edit" name="reception.receptDate" />

			</span>

		</div>
		<div class="operation">
			<a id="receptionModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Reception/js/reception_modify.js"></script> 
