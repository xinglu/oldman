var oldMan_manage_tool = null; 
$(function () { 
	initOldManManageTool(); //建立OldMan管理对象
	oldMan_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#oldMan_manage").datagrid({
		url : 'OldMan/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "oldManId",
		sortOrder : "desc",
		toolbar : "#oldMan_manage_tool",
		columns : [[
			{
				field : "oldManId",
				title : "老人编号",
				width : 70,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "sex",
				title : "性别",
				width : 140,
			},
			{
				field : "age",
				title : "年龄",
				width : 70,
			},
			{
				field : "manPhoto",
				title : "老人照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "userObj",
				title : "登记用户",
				width : 140,
			},
			{
				field : "addTime",
				title : "登记时间",
				width : 140,
			},
		]],
	});

	$("#oldManEditDiv").dialog({
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
				if ($("#oldManEditForm").form("validate")) {
					//验证表单 
					if(!$("#oldManEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#oldManEditForm").form({
						    url:"OldMan/" + $("#oldMan_oldManId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#oldManEditForm").form("validate"))  {
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
			                        $("#oldManEditDiv").dialog("close");
			                        oldMan_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#oldManEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#oldManEditDiv").dialog("close");
				$("#oldManEditForm").form("reset"); 
			},
		}],
	});
});

function initOldManManageTool() {
	oldMan_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#oldMan_manage").datagrid("reload");
		},
		redo : function () {
			$("#oldMan_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#oldMan_manage").datagrid("options").queryParams;
			queryParams["name"] = $("#name").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#oldMan_manage").datagrid("options").queryParams=queryParams; 
			$("#oldMan_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#oldManQueryForm").form({
			    url:"OldMan/OutToExcel",
			});
			//提交表单
			$("#oldManQueryForm").submit();
		},
		remove : function () {
			var rows = $("#oldMan_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var oldManIds = [];
						for (var i = 0; i < rows.length; i ++) {
							oldManIds.push(rows[i].oldManId);
						}
						$.ajax({
							type : "POST",
							url : "OldMan/deletes",
							data : {
								oldManIds : oldManIds.join(","),
							},
							beforeSend : function () {
								$("#oldMan_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#oldMan_manage").datagrid("loaded");
									$("#oldMan_manage").datagrid("load");
									$("#oldMan_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#oldMan_manage").datagrid("loaded");
									$("#oldMan_manage").datagrid("load");
									$("#oldMan_manage").datagrid("unselectAll");
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
			var rows = $("#oldMan_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "OldMan/" + rows[0].oldManId +  "/update",
					type : "get",
					data : {
						//oldManId : rows[0].oldManId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (oldMan, response, status) {
						$.messager.progress("close");
						if (oldMan) { 
							$("#oldManEditDiv").dialog("open");
							$("#oldMan_oldManId_edit").val(oldMan.oldManId);
							$("#oldMan_oldManId_edit").validatebox({
								required : true,
								missingMessage : "请输入老人编号",
								editable: false
							});
							$("#oldMan_name_edit").val(oldMan.name);
							$("#oldMan_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#oldMan_sex_edit").val(oldMan.sex);
							$("#oldMan_sex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#oldMan_age_edit").val(oldMan.age);
							$("#oldMan_age_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入年龄",
								invalidMessage : "年龄输入不对",
							});
							$("#oldMan_manPhoto").val(oldMan.manPhoto);
							$("#oldMan_manPhotoImg").attr("src", oldMan.manPhoto);
							oldMan_manDesc_editor.setContent(oldMan.manDesc, false);
							$("#oldMan_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#oldMan_userObj_user_name_edit").combobox("select", oldMan.userObjPri);
									//var data = $("#oldMan_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#oldMan_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#oldMan_addTime_edit").datetimebox({
								value: oldMan.addTime,
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
