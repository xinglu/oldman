var reception_manage_tool = null; 
$(function () { 
	initReceptionManageTool(); //建立Reception管理对象
	reception_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#reception_manage").datagrid({
		url : 'Reception/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "receptionId",
		sortOrder : "desc",
		toolbar : "#reception_manage_tool",
		columns : [[
			{
				field : "receptionId",
				title : "接待记录id",
				width : 70,
			},
			{
				field : "receptType",
				title : "接待类别",
				width : 140,
			},
			{
				field : "title",
				title : "接待主题",
				width : 140,
			},
			{
				field : "receptDate",
				title : "接待日期",
				width : 140,
			},
		]],
	});

	$("#receptionEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#receptionEditForm").form("validate")) {
					//验证表单 
					if(!$("#receptionEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#receptionEditForm").form({
						    url:"Reception/" + $("#reception_receptionId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#receptionEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#receptionEditDiv").dialog("close");
			                        reception_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#receptionEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#receptionEditDiv").dialog("close");
				$("#receptionEditForm").form("reset"); 
			},
		}],
	});
});

function initReceptionManageTool() {
	reception_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#reception_manage").datagrid("reload");
		},
		redo : function () {
			$("#reception_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#reception_manage").datagrid("options").queryParams;
			queryParams["receptType"] = $("#receptType").val();
			queryParams["title"] = $("#title").val();
			queryParams["receptDate"] = $("#receptDate").datebox("getValue"); 
			$("#reception_manage").datagrid("options").queryParams=queryParams; 
			$("#reception_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#receptionQueryForm").form({
			    url:"Reception/OutToExcel",
			});
			//提交表单
			$("#receptionQueryForm").submit();
		},
		remove : function () {
			var rows = $("#reception_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var receptionIds = [];
						for (var i = 0; i < rows.length; i ++) {
							receptionIds.push(rows[i].receptionId);
						}
						$.ajax({
							type : "POST",
							url : "Reception/deletes",
							data : {
								receptionIds : receptionIds.join(","),
							},
							beforeSend : function () {
								$("#reception_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#reception_manage").datagrid("loaded");
									$("#reception_manage").datagrid("load");
									$("#reception_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#reception_manage").datagrid("loaded");
									$("#reception_manage").datagrid("load");
									$("#reception_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#reception_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Reception/" + rows[0].receptionId +  "/update",
					type : "get",
					data : {
						//receptionId : rows[0].receptionId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (reception, response, status) {
						$.messager.progress("close");
						if (reception) { 
							$("#receptionEditDiv").dialog("open");
							$("#reception_receptionId_edit").val(reception.receptionId);
							$("#reception_receptionId_edit").validatebox({
								required : true,
								missingMessage : "请输入接待记录id",
								editable: false
							});
							$("#reception_receptType_edit").val(reception.receptType);
							$("#reception_receptType_edit").validatebox({
								required : true,
								missingMessage : "请输入接待类别",
							});
							$("#reception_title_edit").val(reception.title);
							$("#reception_title_edit").validatebox({
								required : true,
								missingMessage : "请输入接待主题",
							});
							reception_content_editor.setContent(reception.content, false);
							$("#reception_receptDate_edit").datebox({
								value: reception.receptDate,
							    required: true,
							    showSeconds: true,
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
