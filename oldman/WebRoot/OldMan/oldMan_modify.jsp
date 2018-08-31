<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/oldMan.css" />
<div id="oldMan_editDiv">
	<form id="oldManEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">老人编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_oldManId_edit" name="oldMan.oldManId" value="<%=request.getParameter("oldManId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_name_edit" name="oldMan.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_sex_edit" name="oldMan.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">年龄:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_age_edit" name="oldMan.age" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">老人照片:</span>
			<span class="inputControl">
				<img id="oldMan_manPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="oldMan_manPhoto" name="oldMan.manPhoto"/>
				<input id="manPhotoFile" name="manPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">老人介绍:</span>
			<span class="inputControl">
				<script id="oldMan_manDesc_edit" name="oldMan.manDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">登记用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="oldMan_userObj_user_name_edit" name="oldMan.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_addTime_edit" name="oldMan.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="oldManModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OldMan/js/oldMan_modify.js"></script> 
