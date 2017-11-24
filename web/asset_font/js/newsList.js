var trans="";
$.getUrlParam = function(name) {
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r!=null) return unescape(r[2]); return null;
}

$(function  () {

	//设置三张图片的盒子高度随比例变化
	for(i=0;i<$(".imgBox li").length;i++){
		var pH=$(".imgBox li").eq(i).width()*.55;
		$(".imgBox li").eq(i).height(pH);
	}
	//更多的高度
		var pH=$("img.load").eq(0).parent().width();
			$(".imgBox").css("line-height",pH*0.18+"px")
	window.onresize=function  () {
		//设置三张图片的盒子高度随比例变化
		for(i=0;i<$(".imgBox li").length;i++){
			var pH=$(".imgBox li").eq(i).width()*.55;
			$(".imgBox li").eq(i).height(pH);
		}
		var pH=$("img.load").eq(0).parent().width();
			$(".imgBox").css("line-height",pH*0.18+"px")
	}
	//左导航
	trans=$.getUrlParam("trans");
	$(".leftNav li b").eq(trans).css("background","url(../../asset_font/images/redlibg_18.png)");

})
