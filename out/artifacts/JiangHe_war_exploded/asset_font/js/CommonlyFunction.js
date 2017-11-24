/*该脚本封装了一些常用的函数库 作者： lws*///注 ：该脚本需要jquery库
			function Calendar(windowC,show_date_btn,close,chenge_html_date,select_day_bgc,holiday_color) {
	//日期参数说明：外部大盒子对象|显示日历的按钮元素|关闭日历元素|被影响的元素文本|被选中的天数背景|周末天数字体颜色、、、、、、、、、
				$(show_date_btn).click(function() {
					$(windowC).siblings(".black").show();
					$(windowC).fadeIn(0);
				})
				var now = new Date();
				var nowyear = now.getFullYear();
				//循环添加年
				$(windowC).find(".date>div:first-of-type>input").val(nowyear);
				//循环添加月
				var nowmonth = now.getMonth() + 1;
				if(nowmonth<10){
					nowmonth="0"+nowmonth;
				}
				$(windowC).find(".date>div:last-of-type>input").val(nowmonth+"月");
				//换年月
				$(windowC).find(".date>div:first-of-type b:first-of-type").click(function  () {
					var val=parseInt($(windowC).find(".date>div:first-of-type>input").val())-1;
					$(windowC).find(".date>div:first-of-type>input").val(val);
				})
				$(windowC).find(".date>div:first-of-type b:last-of-type").click(function  () {
					var val=parseInt($(windowC).find(".date>div:first-of-type>input").val())+1;
					$(windowC).find(".date>div:first-of-type>input").val(val);
				})
				$(windowC).find(".date>div:last-of-type b:first-of-type").click(function  () {
					var val=parseInt($(windowC).find(".date>div:last-of-type>input").val())-1;
					if(val!=0&&val!=13){
						if(val<10){
							val="0"+val;
						}
						$(windowC).find(".date>div:last-of-type>input").val(val+"月");
					}
				})
				$(windowC).find(".date>div:last-of-type b:last-of-type").click(function  () {
					var val=parseInt($(windowC).find(".date>div:last-of-type>input").val())+1;
					if(val!=0&&val!=13){
						if(val<10){
							val="0"+val;
						}
						$(windowC).find(".date>div:last-of-type>input").val(val+"月");
					}
				})
				//循环添加日
				var beginday = new Date();
				beginday.setDate(1);
				var month = ["31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"];
			
				function isLeapYear(Year) {
					if(((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
						return(true);
					} else {
						return(false);
					}
				}
				if(isLeapYear(beginday.getFullYear())) {
					month[1] = 29;
				}
				for(i = 0; i < beginday.getDay(); i++) {
					$("<li><a></a></li>").appendTo($(windowC).find(".day"));
				}
				for(i = 0; i < month[beginday.getMonth() ]; i++) {
					$("<li><a></a></li>").appendTo($(windowC).find(".day"));
				}
				for(i = 0; i < month[now.getMonth()]; i++) {
					$(windowC).find(".day li ").eq(beginday.getDay() + i).children("a").text(i + 1)
				}
				//初始化头部的日期
				var d = now.getDate();
				if(d < 10) {
					d = "0" + d;
				}
				$(chenge_html_date).html($(windowC).find(".year").val()+$(windowC).find(".month").val()+d);
				//网页样式
				for(i = 0; i < $(windowC).find(".day li").length / 7 + 1; i++) {
					$(windowC).find(".day li").eq(0 + i * 7).children("a").css("color", holiday_color);
					$(windowC).find(".day li").eq(6 + i * 7).children("a").css("color", holiday_color)
				}
				$(windowC).find(".day li").eq(now.getDate() + beginday.getDay() - 1).children("a").css({
					"background": select_day_bgc,
					"color": holiday_color
				});
				$(windowC).find(".date>div b").click(function() {
					$(windowC).find(".day li").remove();
					//循环添加日
					var beginday = new Date();
					beginday.setFullYear($(windowC).find(".year").val());
					beginday.setMonth(parseInt($(windowC).find(".month").val()) - 1, 1);
					var month = ["31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"];
			
					function isLeapYear(Year) {
						if(((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
							return(true);
						} else {
							return(false);
						}
					}
					if(isLeapYear(beginday.getFullYear())) {
						month[1] = 29;
					}
					for(i = 0; i < beginday.getDay(); i++) {
						$("<li><a></a></li>").appendTo($(windowC).find(".day"));
					}
					for(i = 0; i < month[parseInt($(windowC).find(".month").val()) - 1]; i++) {
						$("<li><a></a></li>").appendTo($(windowC).find(".day"));
					}
					for(i = 0; i < month[parseInt($(windowC).find(".month").val()) - 1]; i++) {
						$(windowC).find(".day li ").eq(beginday.getDay() + i).children("a").text(i + 1)
					}
					//网页样式
					for(i = 0; i < $(windowC).find(".day li").length / 7 + 1; i++) {
						$(windowC).find(".day li").eq(0 + i * 7).children("a").css("color", holiday_color);
						$(windowC).find(".day li").eq(6 + i * 7).children("a").css("color", holiday_color)
					}
					$(windowC).find(".day li").eq(beginday.getDate() + beginday.getDay() - 1).children("a").css({
						"background": select_day_bgc,
						"color": holiday_color
					});
					var d=$(windowC).find(".day li").eq(beginday.getDate() + beginday.getDay() - 1).children("a").text();
					if(d<10){
						d="0"+d;
					}
					$(chenge_html_date).html($(windowC).find(".year").val()+$(windowC).find(".month").val()+d);
					$(windowC).find(".day li a").click(function() {
						if($(this).html() == "") {
							return
						};
						$(this).parent().siblings().children("a").css({
							"background": "transparent",
							"color": "#3E4A61"
						});
						for(i = 0; i < $(windowC).find(".day li").length / 7 + 1; i++) {
							$(windowC).find(".day li").eq(0 + i * 7).children("a").css("color", holiday_color);
							$(windowC).find(".day li").eq(6 + i * 7).children("a").css("color", holiday_color);
						}
						$(this).css({
							"background": select_day_bgc,
							"color": holiday_color
						});
						var d = $(this).text()
						if($(this).text() < 10) {
							d = "0" + d;
						}
						$(chenge_html_date).html($(windowC).find(".year").val()+$(windowC).find(".month").val()+d);
						$(windowC).addClass("bounceOutUp");
						setTimeout(function  () {
							$(windowC).removeClass("bounceOutUp");
							$(windowC).hide();
							$(windowC).siblings(".black").hide();
							$("body").css("overflow","auto")
						},1000)
					})
				})
				$(windowC).find(".day li a").click(function() {
					if($(this).html() == "") {
						return
					};
					$(this).parent().siblings().children("a").css({
						"background": "transparent",
						"color": "#3E4A61"
					});
					for(i = 0; i < $(windowC).find(".day li").length / 7 + 1; i++) {
						$(windowC).find(".day li").eq(0 + i * 7).children("a").css("color", holiday_color);
						$(windowC).find(".day li").eq(6 + i * 7).children("a").css("color", holiday_color);
					}
					$(this).css({
						"background": select_day_bgc,
						"color": holiday_color
					});
					var d = $(this).text()
					if($(this).text() < 10) {
						d = "0" + d;
					}
					$(chenge_html_date).html($(windowC).find(".year").val()+$(windowC).find(".month").val()+d);
					$(windowC).addClass("bounceOutUp");
					setTimeout(function  () {
						$(windowC).removeClass("bounceOutUp");
						$(windowC).hide();
						$(windowC).siblings(".black").hide();
						$("body").css("overflow","auto")
					},1000)
				})
				$(close).click(function  () {
					$(windowC).addClass("bounceOutUp");
					setTimeout(function  () {
						$(windowC).removeClass("bounceOutUp");
						$(windowC).hide();
						$(windowC).siblings(".black").hide();
					},1000)
				})
			}
//点击对象更换（自己或兄弟或父兄弟后代）背景
//参数：“对象，新的背景（必选）”，“siblings/parentSiblings ，兄弟元素变的背景  ”（可选）
			function objClickChangeUrl (targetObj,newUrl,siblingsObj,siblingsUrl) {
				if(siblingsObj=="siblings"){
					$(targetObj).click(function  () {
						$(this).css("background",newUrl);
						$(this).siblings().css("background",siblingsUrl);
					})
				}
				else if(siblingsObj=="parentSiblings"){
					$(targetObj).click(function  () {
						$(this).css("background",newUrl);
						var nodeName=$(this).get(0).nodeName;
						$(this).parent().siblings().find(nodeName).css("background",siblingsUrl);
					})
				}
				else{
					var oldUrl;
					var num=0;
					$(targetObj).click(function  () {
						num++;
						if(num==1){
							oldUrl=$(this).css("background");
						}
						if($(this).css("background")==oldUrl){
							$(this).css("background",newUrl);
						}else{
							$(this).css("background",oldUrl);
						}
					})
				}
			}
var siblings="siblings",parentSiblings="parentSiblings";


//元素悬停改变背景
//参数说明：触发的元素，变换成的新背景
			function objHoverChengeUrl  (targetObj,newUrl) {
				var oldUrl;
				var num=0;
				$(targetObj).hover(function  () {
					num++;
					if(num==1){
						oldUrl=$(this).css("background");
					}
					$(this).css("background",newUrl);
				},function  () {
					$(this).css("background",oldUrl);
				})
			}


//图片加载
			function imgLoad () {
				if(num){
					
				}else{
					var num=1
				}
				$("img.load").load(function  () {
					$(this).css("background","transparent");
				});
				setTimeout(function  () {
					$("img.load").css("background","url()");
				},50);
				$("img.load").error(function  () {
					var parentH=$(this).parent().height();
					$(this).attr("src","/asset_font/img/noload.png");
					if($(this).parent().height()>$(this).parent().width()/2){
						$(this).width("100%");
						$(this).height("auto");
						$(this).parent().css("background","#fff")
					}else{
						$(this).width("auto");
						$(this).height("100%");
					}
					$(this).load(function  () {
						$(this).parent().css("background","#fff")
						$(this).css("margin-top",(parentH-$(this).height())/2);
					})
				});
			}
			//$(function  () {
			//	imgLoad();
			//})
				