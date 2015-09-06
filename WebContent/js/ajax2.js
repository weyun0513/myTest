function sendjQueryRequest(path, data) {
	var options = new Object();
	options.url = path;
	options.data = "regID="+data;
	options.async = true;
	options.cache = false;
	options.type = "post";
	options.dataType = "json";
	options.success = processJSON;
	jQuery.ajax(options);
}
function processJSON(text) {
	var array = eval(text);
	jQuery("#message").text(array[0].text);
}

function sendRequest(){alert("bb");}