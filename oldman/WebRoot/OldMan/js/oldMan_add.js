$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('oldMan_manDesc');
	var oldMan_manDesc_editor = UE.getEditor('oldMan_manDesc'); //老人介绍编辑框
	$("#oldMan_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#oldMan_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#oldMan_age").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入年龄',
		invalidMessage : '年龄输入不对',
	});

	$("#oldMan_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#oldMan_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#oldMan_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#oldMan_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#oldManAddButton").click(function () {
		//验证表单 
		if(!$("#oldManAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#oldManAddForm").form({
			    url:"OldMan/add",
			    onSubmit: function(){
					if($("#oldManAddForm").form("validate"))  { 
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
                        $("#oldManAddForm").form("clear");
                        oldMan_manDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#oldManAddForm").submit();
		}
	});

	//单击清空按钮
	$("#oldManClearButton").click(function () { 
		$("#oldManAddForm").form("clear"); 
	});
});
