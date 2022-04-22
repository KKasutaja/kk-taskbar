$(function(){
    window.onload = (e) => { 
        window.addEventListener('message', (event) => {	            
            var item = event.data;
            if (item !== undefined && item.type === "ui") {		                
                if (item.display === true) {
                    $(".container").show();

                    var text = item.text;
                    var time = item.time;

                    $('.task_text').text(text);

                    $('.task_bar').stop().css({ width: '0px' }).animate({
                        width: '100%',
                    }, time, 'linear', function () {
                        $(".container").hide();
                    });			

                } else {
                    $(".container").hide();
                }
            }
        });
    };
});