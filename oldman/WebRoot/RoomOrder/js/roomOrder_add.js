$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('roomOrder_orderDesc');
	var roomOrder_orderDesc_editor = UE.getEditor('roomOrder_orderDesc'); //订单费用明细编辑框
	$("#roomOrder_roomObj_roomNo").combobox({
	    url:'Room/listAll',
	    valueField: "roomNo",
	    textField: "roomName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#roomOrder_roomObj_roomNo").combobox("getData"); 
            if (data.length > 0) {
                $("#roomOrder_roomObj_roomNo").combobox("select", data[0].roomNo);
            }
        }
	});
	$("#roomOrder_oldManObj_oldManId").combobox({
	    url:'OldMan/listAll',
	    valueField: "oldManId",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#roomOrder_oldManObj_oldManId").combobox("getData"); 
            if (data.length > 0) {
                $("#roomOrder_oldManObj_oldManId").combobox("select", data[0].oldManId);
            }
        }
	});
	$("#roomOrder_liveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#roomOrder_monthNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入入住时间',
		invalidMessage : '入住时间输入不对',
	});

	$("#roomOrder_orderMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入订单总金额',
		invalidMessage : '订单总金额输入不对',
	});

	$("#roomOrder_orderState").validatebox({
		required : true, 
		missingMessage : '请输入订单状态',
	});

	$("#roomOrder_orderTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#roomOrderAddButton").click(function () {
		//验证表单 
		if(!$("#roomOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomOrderAddForm").form({
			    url:"RoomOrder/add",
			    onSubmit: function(){
					if($("#roomOrderAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#roomOrderAddForm").form("clear");
                        roomOrder_orderDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomOrderClearButton").click(function () { 
		$("#roomOrderAddForm").form("clear"); 
	});
});
