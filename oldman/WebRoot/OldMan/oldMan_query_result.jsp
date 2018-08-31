<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/oldMan.css" /> 

<div id="oldMan_manage"></div>
<div id="oldMan_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="oldMan_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="oldMan_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="oldMan_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="oldMan_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="oldMan_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="oldManQueryForm" method="post">
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			登记用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			登记时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oldMan_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="oldManEditDiv">
	<form id="oldManEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">老人编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="oldMan_oldManId_edit" name="oldMan.oldManId" style="width:200px" />
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
				<script name="oldMan.manDesc" id="oldMan_manDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var oldMan_manDesc_editor = UE.getEditor('oldMan_manDesc_edit'); //老人介绍编辑器
</script>
<script type="text/javascript" src="OldMan/js/oldMan_manage.js"></script> 
