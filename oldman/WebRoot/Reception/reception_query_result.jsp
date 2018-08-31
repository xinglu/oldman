<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reception.css" /> 

<div id="reception_manage"></div>
<div id="reception_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="reception_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="reception_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="reception_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="reception_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="reception_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="receptionQueryForm" method="post">
			接待类别：<input type="text" class="textbox" id="receptType" name="receptType" style="width:110px" />
			接待主题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			接待日期：<input type="text" id="receptDate" name="receptDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="reception_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="receptionEditDiv">
	<form id="receptionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">接待记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptionId_edit" name="reception.receptionId" style="width:200px" />
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
				<script name="reception.content" id="reception_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">接待日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reception_receptDate_edit" name="reception.receptDate" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var reception_content_editor = UE.getEditor('reception_content_edit'); //接待内容编辑器
</script>
<script type="text/javascript" src="Reception/js/reception_manage.js"></script> 
