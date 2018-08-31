$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('nurse_content');
	var nurse_content_editor = UE.getEditor('nurse_content'); //信息内容编辑框
	$("#nurse_nurseType").validatebox({
		required : true, 
		missingMessage : '请输入信息类别',
	});

	$("#nurse_title").validatebox({
		required : true, 
		missingMessage : '请输入信息标题',
	});

	$("#nurse_publishDate").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#nurseAddButton").click(function () {
		if(nurse_content_editor.getContent() == "") {
			alert("请输入信息内容");
			return;
		}
		//验证表单 
		if(!$("#nurseAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#nurseAddForm").form({
			    url:"Nurse/add",
			    onSubmit: function(){
					if($("#nurseAddForm").form("validate"))  { 
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
                        $("#nurseAddForm").form("clear");
                        nurse_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#nurseAddForm").submit();
		}
	});

	//单击清空按钮
	$("#nurseClearButton").click(function () { 
		$("#nurseAddForm").form("clear"); 
	});
});
