
$(function () {
    $.post("/jsons/loadbackgroud.form",{},function(data){
        console.log(data.rows);
        if(data.rows&&data.rows.length>0){
            for(var i=0;i<data.rows.length;i++){
                var row=data.rows[i];
                $(".banner img").eq(i).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.img);
            }
        }
    })
    setInterval(banner,5000);
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
