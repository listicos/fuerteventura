var FECHAS_EXCURSIONES = new Array();

var SELECTED_DATE;
var SELECTED_TIPOLOGIES = new Array();

var IS_MOUSE_IN_MENU = false;
$(document).ready(function(){
    $('#blocker').slideUp('fast');
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

    var menorFecha = 0;
    $('select[name=fechasDisponibles]').each(function(){
        
        var fechas = new Array();
        
        $(this).find('option').each(function(){
            var fecha_disponible = new Date($(this).attr('value'));
            if(fecha_disponible) {
                RANGOS_FECHAS_DISPONIBLES.push(fecha_disponible.getTime());
                if(menorFecha == 0 || menorFecha > fecha_disponible.getTime())
                    menorFecha = fecha_disponible.getTime();
            }
            fechas.push(fecha_disponible.getTime());
        })
        FECHAS_EXCURSIONES.push(fechas);        
        
    });
    if(menorFecha == 0) menorFecha = new Date().getTime();
    
    $('#sandbox-container div').datepicker({
        format: "dd/mm/yyyy",
        language: LANGUAGE,
        startDate: new Date(menorFecha),
        beforeShowDay: function (date){
            return RANGOS_FECHAS_DISPONIBLES.indexOf(date.getTime()) !== -1 ;
        }
    }).on('changeDate', function(e) {
            SELECTED_DATE = e.date.getTime();
            /*
            var tours = $('div.row.tour-item');
            
            for(i = 0; i < FECHAS_EXCURSIONES.length; i++) {
                if(FECHAS_EXCURSIONES[i].indexOf(e.date.getTime()) > -1)
                    $(tours[i]).show();
                else
                    $(tours[i]).hide();
            }
            */
            $('a.reservar-btn, a.title-link-reservar').each(function(){
                var href = $(this).attr('href');
                href = href.split('/fecha:')[0];
                href += ('/fecha:' + e.date.getDate() + '-' + (e.date.getMonth() + 1) + '-' + e.date.getFullYear());
                $(this).attr('href', href);
            })
            
            filterExcursiones();
        });
        
    $('.filter_box input[type=checkbox]').change(function(e){
        
        filterExcursiones();
        
    });
    
    initWeather();
    makeAQuestion();
    
    rating();
});

function filterExcursiones() {
    var tours = $('div.row.tour-item');
      
    if(SELECTED_DATE)
    for(i = 0; i < FECHAS_EXCURSIONES.length; i++) {
        var tour = $(tours[i]);
        if(FECHAS_EXCURSIONES[i].indexOf(SELECTED_DATE) > -1) {
            if($('.filter_box input[type=checkbox]:checked').length == 0)
                tour.show();
            else {
                tour.hide();
                $('.filter_box input[type=checkbox]:checked').each(function(){
                    if(tour.hasClass('tipologia-' + $(this).val())) {
                        tour.show();
                    }
                });
            }
        } else
            tour.hide();
    }
    else if($('.filter_box input[type=checkbox]:checked').length > 0) {
        tours.each(function(){
            var tour = $(this);
            tour.hide();
            $('.filter_box input[type=checkbox]:checked').each(function(){
                    if(tour.hasClass('tipologia-' + $(this).val())) {
                        tour.show();
                    }
                });
        })
    } else {
        tours.show();
    }
    
    
}

function makeAQuestion(){
    $('.tour-item a.make_a_question').on('click', function(){
        var eventoId = $(this).attr('event-id');
        $('#question-event-id').val(eventoId);
    });
    $("#btn-send-question").click(function(ev){
        
        var form = $('#make-question-form');
        var valid_form;
        valid_form = form.validationEngine('validate');
        if(valid_form){
            $.ajax({
                dataType: "json",
                url: BASE_URL + "/ajax-reservacion",
                type: "POST",
                data: form.serialize(),
                success: function(response) {
                    if(response.result == 'ok') {
                        toastr.success('Se ha enviado su pregunta');
                        $("#make_question_modal").modal('hide');
                    } else {
                        toastr.error(response.msg);
                    }
                    
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

function rating() {
        
    $('.excursion-rating').each(function(){
        $(this).raty({
            starOn: BASE_URL + '/templates/imagenes/star-on-big.png',
            starOff: BASE_URL + '/templates/imagenes/star-off-big.png',
            starHalf: BASE_URL + '/templates/imagenes/star-half-big.png',
            width: false,  
            space: false,
            hints: EVALUACIONES,
            score: $(this).attr('puntuacion'),
            readOnly: true
        });
    });
}
