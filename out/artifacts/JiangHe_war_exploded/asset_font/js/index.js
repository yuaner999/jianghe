$(function  () {
	setTimeout(function () {
		for (i=0;i<$(".banner img").length;i++){
			if($(".banner img").eq(i).css("display")!="none"){
				var oldh=$(".banner img").eq(i).height();
			}
		}
		$(".banner").height(oldh);
		var h=$(".banner").height();
		$(".home_items li div").height(h+10);
	},0)
	window.onresize=function  () {
		for (i=0;i<$(".banner img").length;i++){
			if($(".banner img").eq(i).css("display")!="none"){
				var oldh=$(".banner img").eq(i).height();
			}
		}
		$(".banner").height(oldh);
		var h=$(".banner").height();
		$(".home_items li div").height(h+10);
	}
})
