<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reception.css" />
<div id="receptionAddDiv">
	<form id="receptionAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">接待类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptType" name="reception.receptType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">接待主题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_title" name="reception.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">接待内容:</span>
			<span class="inputControl">
				<script name="reception.content" id="reception_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">接待日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptDate" name="reception.receptDate" />

			</span>

		</div>
		<div class="operation">
			<a id="receptionAddButton" class="easyui-linkbutton">添加</a>
			<a id="receptionClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Reception/js/reception_add.js"></script> 
