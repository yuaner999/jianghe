$(function(){
	//图片简介的显示和隐藏
	$('.pictures img').hover(function(){
		$(this).siblings().stop(true).fadeIn(300);
	},function(){
		$(this).siblings().stop(true).fadeOut(300);
	});
	$('.pictures .imgText').hover(function(){
		$(this).stop(true).fadeIn(300);
	},function(){
		$(this).stop(true).fadeOut(300);
	});
	//文本溢出
	var oldTxt=[];
	for(i=0;i<$(".imgText").length;i++){
		oldTxt.push($(".imgText").eq(i).text());
	}
	function txtOverflow () {
		for(i=0;i<$(".imgText").length;i++){
			$(".imgText").eq(i).text(oldTxt[i]);
		}
		$(".imgText").dotdotdot();
		$(".imgText").hide();
	}
	txtOverflow();
	//t=图片盒子高度等比
	function imgB(){
		for(i=0;i<$(" .imgB:not(#heightImg)").length;i++){
			var w=$(" .imgB:not(#heightImg)").eq(i).width();
			$(" .imgB:not(#heightImg)").eq(i).height(w);
		}
		$("#heightImg").height($(" .imgB").eq(0).height());
	}
	//图片的加载
	function imgH () {
		$(".pictures img:not(.lastrect .bottom>span img)").load(function  () {
			var w=$(this).width();
			var h=$(this).height();
			if (w>h){
				$(this).css("height","100%");
				$(this).css("width","auto");
			}
			else{
				$(this).css("width","100%");
				$(this).css("height","auto");
			}
		})
		$(".lastrect .bottom>span img").load(function  () {
			var w=$(".pictures_right .bottom .img_big img").width();
			$(this).height(w);
		})
		//图片盒子高度等比
		imgB();
		window.onresize=function  () {
			//文本溢出
			txtOverflow();
			//图片盒子高度等比
			imgB();
			//图片尺寸
			imgSize($(".window div img"))
			////t图片
			//for(i=0;i<$(".pictures img:not(.lastrect .bottom>span img)").length;i++){
			//	var w=$(".pictures img:not(.lastrect .bottom>span img)").eq(i).width();
			//	$(".pictures img:not(.lastrect .bottom>span img)").eq(i).height(w);
			//}
			//var w2=$(".pictures_right .bottom .img_big img").width();
			//$(".lastrect .bottom>span img").height(w2);
		}
	}
	imgH();

	//点击看大图
	var windowImg;
	function clickBigImg(){
		$(".imgText").parent().click(function () {
			windowImg=$(this).find("img").clone();
			windowImg.removeClass();
			$(".window div").append(windowImg);
			$(".window").stop(true).fadeIn(400);
			$(".black").stop(true).show();
			windowImg.load(function () {
				imgSize(windowImg);
			})
		})
	}
	clickBigImg()
	//关闭看大图
	$(".window div b").click(function () {
		$(this).parent().parent().fadeOut(400);
		setTimeout(function () {
			$(".window div img").remove();
			$(".black").hide();
		},400)
	})
});
function imgSize(windowImg){
	var w=windowImg.width();
	var h=windowImg.height();
	if(w>h*2){
		windowImg.css("width","100%");
		var mT=$(".window").height();
		var newH=windowImg.height();
		windowImg.parent().css("margin-top",(mT-newH)/2);
	}else {
		windowImg.parent().css("height","100%");
		windowImg.css("height","100%");
		var sonW=windowImg.width();
		windowImg.parent().css("width",sonW+40+"px")
	}
}