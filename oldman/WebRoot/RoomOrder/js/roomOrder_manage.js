var roomOrder_manage_tool = null; 
$(function () { 
	initRoomOrderManageTool(); //建立RoomOrder管理对象
	roomOrder_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#roomOrder_manage").datagrid({
		url : 'RoomOrder/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "orderId",
		sortOrder : "desc",
		toolbar : "#roomOrder_manage_tool",
		columns : [[
			{
				field : "orderId",
				title : "订单编号",
				width : 70,
			},
			{
				field : "roomObj",
				title : "入住房间",
				width : 140,
			},
			{
				field : "oldManObj",
				title : "入住老人",
				width : 140,
			},
			{
				field : "liveDate",
				title : "入住日期",
				width : 140,
			},
			{
				field : "monthNum",
				title : "入住时间",
				width : 70,
			},
			{
				field : "orderMoney",
				title : "订单总金额",
				width : 70,
			},
			{
				field : "orderState",
				title : "订单状态",
				width : 140,
			},
			{
				field : "orderTime",
				title : "订单时间",
				width : 140,
			},
		]],
	});

	$("#roomOrderEditDiv").dialog({
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
				if ($("#roomOrderEditForm").form("validate")) {
					//验证表单 
					if(!$("#roomOrderEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#roomOrderEditForm").form({
						    url:"RoomOrder/" + $("#roomOrder_orderId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#roomOrderEditForm").form("validate"))  {
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
			                        $("#roomOrderEditDiv").dialog("close");
			                        roomOrder_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#roomOrderEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#roomOrderEditDiv").dialog("close");
				$("#roomOrderEditForm").form("reset"); 
			},
		}],
	});
});

function initRoomOrderManageTool() {
	roomOrder_manage_tool = {
		init: function() {
			$.ajax({
				url : "Room/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#roomObj_roomNo_query").combobox({ 
					    valueField:"roomNo",
					    textField:"roomName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{roomNo:"",roomName:"不限制"});
					$("#roomObj_roomNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "OldMan/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#oldManObj_oldManId_query").combobox({ 
					    valueField:"oldManId",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{oldManId:0,name:"不限制"});
					$("#oldManObj_oldManId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#roomOrder_manage").datagrid("reload");
		},
		redo : function () {
			$("#roomOrder_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#roomOrder_manage").datagrid("options").queryParams;
			queryParams["roomObj.roomNo"] = $("#roomObj_roomNo_query").combobox("getValue");
			queryParams["oldManObj.oldManId"] = $("#oldManObj_oldManId_query").combobox("getValue");
			queryParams["liveDate"] = $("#liveDate").datebox("getValue"); 
			queryParams["orderState"] = $("#orderState").val();
			queryParams["orderTime"] = $("#orderTime").datebox("getValue"); 
			$("#roomOrder_manage").datagrid("options").queryParams=queryParams; 
			$("#roomOrder_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#roomOrderQueryForm").form({
			    url:"RoomOrder/OutToExcel",
			});
			//提交表单
			$("#roomOrderQueryForm").submit();
		},
		remove : function () {
			var rows = $("#roomOrder_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var orderIds = [];
						for (var i = 0; i < rows.length; i ++) {
							orderIds.push(rows[i].orderId);
						}
						$.ajax({
							type : "POST",
							url : "RoomOrder/deletes",
							data : {
								orderIds : orderIds.join(","),
							},
							beforeSend : function () {
								$("#roomOrder_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#roomOrder_manage").datagrid("loaded");
									$("#roomOrder_manage").datagrid("load");
									$("#roomOrder_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#roomOrder_manage").datagrid("loaded");
									$("#roomOrder_manage").datagrid("load");
									$("#roomOrder_manage").datagrid("unselectAll");
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
			var rows = $("#roomOrder_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "RoomOrder/" + rows[0].orderId +  "/update",
					type : "get",
					data : {
						//orderId : rows[0].orderId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (roomOrder, response, status) {
						$.messager.progress("close");
						if (roomOrder) { 
							$("#roomOrderEditDiv").dialog("open");
							$("#roomOrder_orderId_edit").val(roomOrder.orderId);
							$("#roomOrder_orderId_edit").validatebox({
								required : true,
								missingMessage : "请输入订单编号",
								editable: false
							});
							$("#roomOrder_roomObj_roomNo_edit").combobox({
								url:"Room/listAll",
							    valueField:"roomNo",
							    textField:"roomName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#roomOrder_roomObj_roomNo_edit").combobox("select", roomOrder.roomObjPri);
									//var data = $("#roomOrder_roomObj_roomNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#roomOrder_roomObj_roomNo_edit").combobox("select", data[0].roomNo);
						            //}
								}
							});
							$("#roomOrder_oldManObj_oldManId_edit").combobox({
								url:"OldMan/listAll",
							    valueField:"oldManId",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#roomOrder_oldManObj_oldManId_edit").combobox("select", roomOrder.oldManObjPri);
									//var data = $("#roomOrder_oldManObj_oldManId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#roomOrder_oldManObj_oldManId_edit").combobox("select", data[0].oldManId);
						            //}
								}
							});
							$("#roomOrder_liveDate_edit").datebox({
								value: roomOrder.liveDate,
							    required: true,
							    showSeconds: true,
							});
							$("#roomOrder_monthNum_edit").val(roomOrder.monthNum);
							$("#roomOrder_monthNum_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入入住时间",
								invalidMessage : "入住时间输入不对",
							});
							$("#roomOrder_orderMoney_edit").val(roomOrder.orderMoney);
							$("#roomOrder_orderMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入订单总金额",
								invalidMessage : "订单总金额输入不对",
							});
							$("#roomOrder_orderState_edit").val(roomOrder.orderState);
							$("#roomOrder_orderState_edit").validatebox({
								required : true,
								missingMessage : "请输入订单状态",
							});
							roomOrder_orderDesc_editor.setContent(roomOrder.orderDesc, false);
							$("#roomOrder_orderTime_edit").datetimebox({
								value: roomOrder.orderTime,
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
