var nurse_manage_tool = null; 
$(function () { 
	initNurseManageTool(); //建立Nurse管理对象
	nurse_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#nurse_manage").datagrid({
		url : 'Nurse/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "nurseId",
		sortOrder : "desc",
		toolbar : "#nurse_manage_tool",
		columns : [[
			{
				field : "nurseId",
				title : "记录id",
				width : 70,
			},
			{
				field : "nurseType",
				title : "信息类别",
				width : 140,
			},
			{
				field : "title",
				title : "信息标题",
				width : 140,
			},
			{
				field : "publishDate",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#nurseEditDiv").dialog({
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
				if ($("#nurseEditForm").form("validate")) {
					//验证表单 
					if(!$("#nurseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#nurseEditForm").form({
						    url:"Nurse/" + $("#nurse_nurseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#nurseEditForm").form("validate"))  {
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
			                        $("#nurseEditDiv").dialog("close");
			                        nurse_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#nurseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#nurseEditDiv").dialog("close");
				$("#nurseEditForm").form("reset"); 
			},
		}],
	});
});

function initNurseManageTool() {
	nurse_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#nurse_manage").datagrid("reload");
		},
		redo : function () {
			$("#nurse_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#nurse_manage").datagrid("options").queryParams;
			queryParams["nurseType"] = $("#nurseType").val();
			queryParams["title"] = $("#title").val();
			queryParams["publishDate"] = $("#publishDate").datebox("getValue"); 
			$("#nurse_manage").datagrid("options").queryParams=queryParams; 
			$("#nurse_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#nurseQueryForm").form({
			    url:"Nurse/OutToExcel",
			});
			//提交表单
			$("#nurseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#nurse_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var nurseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							nurseIds.push(rows[i].nurseId);
						}
						$.ajax({
							type : "POST",
							url : "Nurse/deletes",
							data : {
								nurseIds : nurseIds.join(","),
							},
							beforeSend : function () {
								$("#nurse_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#nurse_manage").datagrid("loaded");
									$("#nurse_manage").datagrid("load");
									$("#nurse_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#nurse_manage").datagrid("loaded");
									$("#nurse_manage").datagrid("load");
									$("#nurse_manage").datagrid("unselectAll");
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
			var rows = $("#nurse_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Nurse/" + rows[0].nurseId +  "/update",
					type : "get",
					data : {
						//nurseId : rows[0].nurseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (nurse, response, status) {
						$.messager.progress("close");
						if (nurse) { 
							$("#nurseEditDiv").dialog("open");
							$("#nurse_nurseId_edit").val(nurse.nurseId);
							$("#nurse_nurseId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#nurse_nurseType_edit").val(nurse.nurseType);
							$("#nurse_nurseType_edit").validatebox({
								required : true,
								missingMessage : "请输入信息类别",
							});
							$("#nurse_title_edit").val(nurse.title);
							$("#nurse_title_edit").validatebox({
								required : true,
								missingMessage : "请输入信息标题",
							});
							nurse_content_editor.setContent(nurse.content, false);
							$("#nurse_publishDate_edit").datetimebox({
								value: nurse.publishDate,
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
