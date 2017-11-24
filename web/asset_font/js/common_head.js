
$(function () {
    $.post("/jsons/loadbackgroud.form",{},function(data){
        if(data.rows&&data.rows.length>0){
            var str="<li class='first'><img src='/Files/Images/"+ data.rows[0].img + "'onerror='src=\'/asset_font/images/detailBg_01.png\''/></li>";
            for(var i=1;i<data.rows.length;i++){
                var row=data.rows[i];
                str+="<li><img src='/Files/Images/"+ row.img + "'onerror='src=\'/asset_font/images/detailBg_01.png\''/></li>"
            }
            $("#swiperimage").html(str);
            comHead();
            setInterval(banner,5000);
        }
    })
    var i=0;
    function banner(){
        i++;
        if(i==$(".banner ul li").length){
            i=0;
        }
        $(".banner ul li").eq(i).fadeIn(600);
        $(".banner ul li").eq(i).siblings("li").fadeOut(600);
    }
})
