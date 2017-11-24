$(function  () {
	$(".leaderPhoto li").hover(function  () {
		$(this).find("p").stop(true).slideDown(300);
	},function  () {
		$(this).find("p").stop(true).slideUp(300);
	})
	//校长图片高度动态适应图片长宽比1:0.68
	function leaderPhoto(){
		for(i=0;i<$(".leaderPhoto li div img").length;i++){
			var changeH=$(".leaderPhoto li div img").eq(i).width()*0.68;
			$(".leaderPhoto li div img").eq(i).height(changeH)
		}
		window.onresize= function () {
			for(i=0;i<$(".leaderPhoto li div img").length;i++){
				var changeH=$(".leaderPhoto li div img").eq(i).width()*0.68;
				$(".leaderPhoto li div img").eq(i).height(changeH)
			}
		}
	}
	leaderPhoto();
})
