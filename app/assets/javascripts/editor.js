var editor;

var fileName = null;
var operation = null;
var url = null;
$(document).ready(function(){
	editor = ace.edit('editor');
	editor.setTheme("ace/theme/monokai");
    	editor.getSession().setMode("ace/mode/xml");
	$("#close").click(function(){
		$("#editorModal").modal("hide");
	});

	$("#urlinsert").click(function(){
		fileName = "urls/seed.txt";
		operation = "insertUrl";
		url = "/home/get_seeds.json";
	});

	$("#regexUrl").click(function(){
		fileName = "conf/regex-urlfilter.txt";
		operation = "regexUrl";
		url = "/home/read_file.json";
	});
	$("#urlCrawlDiv").click(function(){
		fileName = "conf/div.json";
		operation = "crawlUrlDiv";
		url = "/home/read_file.json";
	});

	$("#urlParseDiv").click(function(){
		fileName = "conf/div_selector.json";
		operation = "urlParseDiv";
		url = "/home/read_file.json";
	});

	$("#crawl").click(function(){
		fileName = "crawl.sh";
		operation = "crawl.sh";
		url = "/home/read_file.json";
	});

	$("#urlFilter").click(function(){
		fileName = "conf/index-filter.json";
		operation = "urlParseDiv";
		url = "/home/read_file.json";
	});

	$('#editorModal').on('shown.bs.modal', function (e) {
		$.ajax({
			method: "post",
			url: url,
			data: {
				filename: fileName,
				operation: operation
			},
			dataType: "html",
			success: function(data){
				editor.getSession().setValue(data);
			}
		    });
	});
	
	$('#insert').click(function(){
		$(this).button('loading');
		var value =  editor.getSession().getValue();
		$.ajax({
			method: "post",
			url: "/home/save_file.json",
			data: {
				filename: fileName,
				data:	value,
				operation: operation
			},
			dataType: "html",
			success: function(data){
				$("#insert").button('reset');
			}
		    });
	});
	function doUpdate()   
	{   
		$.ajax({
				method: "get",
				url: "/home/get_logs",
				dataType: "html",
				success: function(data){
					$("#crawl-logs").append(data);
					var scrollTop = $("#crawl-logs")[0].scrollHeight;
					$("#crawl-logs").scrollTop(scrollTop);
					doUpdate();
				}
			    });
	}  
	doUpdate();

});
