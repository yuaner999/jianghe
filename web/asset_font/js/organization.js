$(function  () {
	//组织结构图
	function  structure() {
		var i=$(".b").length;
		var w=$(".a").width()/i;
		$(".b").width(w-2);
		
		for(i=0;i<$(".b").length;i++){
			var j=$(".b").eq(i).find("li").length;
			var w=$(".b").eq(i).width()/j;
			$(".b").eq(i).find("li").width(w-2);
		}
		window.onresize=function  () {
			var i=$(".b").length;
		var w=$(".a").width()/i;
		$(".b").width(w-2);
		
		for(i=0;i<$(".b").length;i++){
			var j=$(".b").eq(i).find("li").length;
			var w=$(".b").eq(i).width()/j;
			$(".b").eq(i).find("li").width(w-2);
		}
		}
	}
	structure();
})
