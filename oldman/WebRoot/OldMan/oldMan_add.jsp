<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/oldMan.css" />
<div id="oldManAddDiv">
	<form id="oldManAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_name" name="oldMan.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_sex" name="oldMan.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">年龄:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_age" name="oldMan.age" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">老人照片:</span>
			<span class="inputControl">
				<input id="manPhotoFile" name="manPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">老人介绍:</span>
			<span class="inputControl">
				<script name="oldMan.manDesc" id="oldMan_manDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">登记用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_userObj_user_name" name="oldMan.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_addTime" name="oldMan.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="oldManAddButton" class="easyui-linkbutton">添加</a>
			<a id="oldManClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/OldMan/js/oldMan_add.js"></script> 
