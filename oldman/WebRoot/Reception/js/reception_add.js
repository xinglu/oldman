$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('reception_content');
	var reception_content_editor = UE.getEditor('reception_content'); //接待内容编辑框
	$("#reception_receptType").validatebox({
		required : true, 
		missingMessage : '请输入接待类别',
	});

	$("#reception_title").validatebox({
		required : true, 
		missingMessage : '请输入接待主题',
	});

	$("#reception_receptDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#receptionAddButton").click(function () {
		//验证表单 
		if(!$("#receptionAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#receptionAddForm").form({
			    url:"Reception/add",
			    onSubmit: function(){
					if($("#receptionAddForm").form("validate"))  { 
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
                        $("#receptionAddForm").form("clear");
                        reception_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#receptionAddForm").submit();
		}
	});

	//单击清空按钮
	$("#receptionClearButton").click(function () { 
		$("#receptionAddForm").form("clear"); 
	});
});
