$(function(){
	//获取banner的高度
	var banner_height = $('.banner').height();
	//设置banner 的css样式
	$('.banner').css('margin-top',-1*(banner_height/2));
	//设置banner 外层div的高度
	$('.content>div').height(banner_height*1.6);
	//随浏览器大小渐变的banner和外层div的样式的resize事件
	$(window).resize(function(){
		//获取banner的高度
		var banner_height = $('.banner').height();
		//设置banner 的css样式
		$('.banner').css('margin-top',-1*(banner_height/2));
		//设置banner 外层div的高度
		$('.content>div').height(banner_height*1.6);
	});
});
