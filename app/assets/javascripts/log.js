$(function(){  $("#auto_complete").typeahead({source: autocomplete_items})})

$(".newmsg").click(function(){
	$("#shift_msg_log_id").val(this.id);
});

$(document).keydown(function(e){
    if (e.keyCode == 39) { 
		var href = $('.pagination').find('a[rel=next]').attr('href');
		if (href!=null){
			window.location.replace(href);
		}
    }
    else if(e.keyCode ==37){
    	var href = $('.pagination').find('a[rel=prev]').attr('href');
		if (href!=null){
			window.location.replace(href);
		}
		else{
			var href = $("a[rel~='prev']").attr('href');
			if (href!=null){
				window.location.replace(href);
			}
		}
    }
});

