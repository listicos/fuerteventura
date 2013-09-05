

var IS_MOUSE_IN_MENU = false;
$(document).ready(function(){
    $('#blocker').fadeOut('slow');
    $('.dropdown-menu').dropdown();
    
    $('.carousel').carousel({
        interval: 5000
    });
    
    $('.make_a_question').click(function(){
        $('#make_question_modal').modal('toggle')
        return false; 
    });
    
    $('.dropdown-menu').each(function(){
        var menu = $(this);
        menu.parent().find('a').mouseover(function(){
            menu.parent().addClass('open');
        }).mouseout(function(){
            window.setTimeout(function(){
                if(!IS_MOUSE_IN_MENU)
                    menu.parent().removeClass('open');
            },100);
        });
        menu.mouseover(function(){
            IS_MOUSE_IN_MENU = true;
        }).mouseout(function(){
            IS_MOUSE_IN_MENU = false;
            window.setTimeout(function(){
                if(!IS_MOUSE_IN_MENU)
                    menu.parent().removeClass('open');
            },100);
        });
    });

    $('input[name=fechasDisponibles]').each(function(){
        var rango = $(this).val().split("-");
        if(rango.length == 2) {
            rango[0] = new Date(rango[0]);
            rango[1] = new Date(rango[1]);
            RANGOS_FECHAS_DISPONIBLES.push(rango);
        }
    });
    
    $('#sandbox-container div').datepicker({
        format: "dd/mm/yyyy",
        language: "es",
        beforeShowDay: function (date){
            var v = false;
            for(i=0;i<RANGOS_FECHAS_DISPONIBLES.length;i++){
                if(date >= RANGOS_FECHAS_DISPONIBLES[i][0] && date <= RANGOS_FECHAS_DISPONIBLES[i][1]) {
                    v = true;
                    break;
                }
            }
            return v;
        }
    }).on('changeDate', function(e) {
            var tours = $('div.row.tour-item');
            
            for(i = 0; i < RANGOS_FECHAS_DISPONIBLES.length; i++) {
                if(e.date >= RANGOS_FECHAS_DISPONIBLES[i][0] && e.date <= RANGOS_FECHAS_DISPONIBLES[i][1])
                    $(tours[i]).show();
                else
                    $(tours[i]).hide();
            }
            
            $('a.reservar-btn').each(function(){
                var href = $(this).attr('href');
                href = href.split('/fecha:')[0];
                href += ('/fecha:' + e.date.getDate() + '-' + (e.date.getMonth() + 1) + '-' + e.date.getFullYear());
                $(this).attr('href', href);
            })
            
            
        });
    
    initWeather();
    makeAQuestion();
    
});

function makeAQuestion(){
    $("#make-question-form").submit(function(ev){
        ev.preventDefault();
        var form = $(this);
        var valid_form;
        valid_form = form.validationEngine('validate');
        if(valid_form){
            $.ajax({
                dataType: "json",
                url: BASE_URL + "/ajax-main",
                type: "POST",
                data: form.serialize(),
                success: function(response) {
                    if (response.msg === 'ok') {
                        //location.href = BASE_URL;
                        toastr.success("Mensaje: ", response.data);
                    }else{
                        toastr.error(response.data, "Mensaje: ");
                    }
                    $("#make_question_modal").modal('hide');
                }
      
            }); 
        }
    });
}

function initWeather(){
    $('#weatherslider').weatherSlider({
        responsive        : true,
        measurement       : 'metric',
        timeFormat        : 12,
        daytime           : [7,19],
        windyWeather      : 18,
        icyTemp           : -2,
        slideDelay        : 0,
        refreshInterval   : 0,
        keybNav           : true,
        touchNav          : true,
        hideBackground    : false,
        enableSearchField : true,
        alwaysShowSearch  : false,
        enableWeatherInfo : true,
        enableForecast    : true,
        alwaysShowForecast: false,
        CSSanimations     : true,
        JSanimations      : true,
        infoDuration      : 450,
        reduction         : 'auto',
        showLoc           : true,
        showTime          : true,
        showCond          : true,
        showTemp          : true,
        showLow           : true,
        showHigh          : true,
        showHum           : true,
        showPrec          : true,
        showWind          : true,
        showPress         : true,
        showVis           : true,
        showFDay          : true,
        showFCond         : true,
        showFLow          : true,
        showFHigh         : true,
        snow		  : true,
        rain		  : true,
        wind		  : true,
        lightnings	  : true,
        windDirection	  : 'auto'
					
    });
}
