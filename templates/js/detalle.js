var FECHAS_DISPONIBLES = new Array();
var map;
var myLatlng = new google.maps.LatLng("40.4216737855101","-3.7001175433777");

function initialize() {
    if($('input[name=lat]').val() != "") {
        var lat = $('input[name=lat]').val();
        var lon = $('input[name=lon]').val()
        myLatlng = new google.maps.LatLng(lat,lon);
    }
    var mapOptions = {
        zoom: 10,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('details-map-location'), mapOptions);

    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map
    });
}
function showRecaptcha() {
    Recaptcha.create("6LcY-uYSAAAAACBIaBBmfEdbYqJxCkDdtOONaeIE", 'captchadiv', {
        tabindex: 1,
        theme: "clean",
        callback: Recaptcha.focus_response_field
    });
}
$(document).ready(function(){
    
    initialize();
    showRecaptcha();
    google.maps.event.trigger(map, 'resize');
    map.setCenter(myLatlng);
    $('#blocker').fadeOut('slow');
    
    $('.selectpicker').selectpicker();
    
    $('#fechas option').each(function(){
        var fecha_disponible =  new Date($(this).attr('value'));
        if(fecha_disponible)
        RANGOS_FECHAS_DISPONIBLES.push(fecha_disponible.getTime());
    });

    $('#fecha').datepicker({format:'dd/mm/yyyy',
        beforeShowDay: function (date){
            return RANGOS_FECHAS_DISPONIBLES.indexOf(date.getTime()) !== -1 ;
        }
    });
    
    
    
    reservacionFunctions();
    
    questionFunctions();
    
    $('#book_conditions, #privacy_policies').off('click').on('click', function(e){
        e.preventDefault();
        var id = $(this).attr('id');
        $('#' + id + '_modal').modal();
    });
    
    scrollMap();
    
    var fechaSeleccionada = $('input[name=fechaSeleccionada]').val();
    
    if(fechaSeleccionada && fechaSeleccionada.trim().length > 0) {
        var fecha = fechaSeleccionada.split('-');
        fechaSeleccionada = new Date(fecha[1] + '/' + fecha[0] + '/' + fecha[2]);
        $('#fecha').datepicker('_setDate', fechaSeleccionada).datepicker('fill');
        
        $('#fecha td.day:contains(' + parseInt(fecha[0]) + '):not(.disabled)').each(function(){
            
            if($(this).html() == parseInt(fecha[0]) ) {
                $(this).addClass('active');                
            }
        })
    }
    
    $('.content-title').on('click', function(e){
        e.preventDefault();
        var top = $('#payment-register-form').offset().top;
        $('html, body').animate({scrollTop:top}, 500);
    })
    
});

function questionFunctions() {
    $('#btn-make-question').on('click', function(e){
       $('#question-container').slideDown(500); 
    });
    $('#btn-make-question-close').on('click', function(e){
       $('#question-container').slideUp(500); 
    });
    $('#btn-make-question-send').on('click', function(){
        var form = $('#make-question-form');
        var valid = form.validationEngine('validate');
        if(valid) {
            var data = form.serialize();
            $.ajax({
                url: BASE_URL + '/ajax-reservacion',
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(response) {
                    toastr.success('Se ha enviado su pregunta');
                    $('#question-container').slideUp(500);
                }
            });
        }
    });
}

function reservacionFunctions() {
    
    $('#payment-register-form').off('submit').on('submit', function(e){
        e.preventDefault();
        

        var valid = $(this).validationEngine('validate');
        var data = $(this).serialize();
        if(valid) {
            $('.second_step_information input[type="submit"]').addClass('disabled');
            $('#blocker').fadeIn('slow');
            $.ajax({
                url: BASE_URL + '/ajax-reservacion',
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(response) {
                    $('.second_step_information input[type="submit"]').removeClass('disabled');
                    $('#blocker').fadeOut('slow');
                    if(response.result == 'ok') {
                        toastr.success(response.msg);
                        $('#payment-register-form input[type="text"]').val('');
                    } else {
                        toastr.error(response.msg);
                         var top = $('#payment-register-form .second_step_information').offset().top;
                        $('html, body').animate({scrollTop:top}, 500);
                    }
                },
                error: function(ev) {
                    console.log(ev);
                }
            });
        }
        
    });
    
    fechasTarifasFunctions();
    
}

function fechasTarifasFunctions() {
    $('#fecha').off('changeDate').on('changeDate', function(e){
        
        var y = e.date.getFullYear(),
            _m = e.date.getMonth() + 1,
            m = (_m > 9 ? _m : '0'+_m),
            _d = e.date.getDate(),
            d = (_d);
        
        var fecha = d + '/' + m + '/' + y;
        var tarifa = $('.fechasTarifas:contains(' + fecha +')').attr('tarifa-id');
        
        $('input[name=fecha]').val(fecha);
        $('#tarifas-table').show();
        $('#tarifa option:not([value="' + tarifa + '"])').hide();
        $('#tarifa option[value="' + tarifa + '"]').show().prop('selected', true);
        
        $('#tarifa').val(tarifa);
        MostrarEntradas();
        calcularTotal();
        
        var Months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
                  
        var fechaMostrar = d + " de " + Months[_m - 1] + ", " + y;
        $('.calendar2 p.seleccionaFecha').hide();
        $('.calendar2 p.fechaSeleccionada span').html(fechaMostrar);
        $('p.completaAhora, p.fechaSeleccionada', '.calendar2').show();
        
    });
    
    $('.tarifas-table select').off('change').on('change', function(e){
        var entradas = $(this).val();
        var costo = $(this).attr('precio');
        $(this).parent().parent().find('label.totalEntradas strong').html(formatEuro(1 * entradas * costo));
        calcularTotal();
    });
    
    $('.tarifas-table select').each(function(e){
        var entradas = $(this).val();
        var costo = $(this).attr('precio');
        $(this).parent().parent().find('label.totalEntradas strong').html(formatEuro(1 * entradas * costo));
    });
    
    $('#reset-reserva').on('click', resetFormReserva);
}

function isNumber(str) {
    if(str && str.trim().length > 0) {
        for(i=0;i<str.length;i++)
            if(str[i] < "0" || str[i] > "9")
                return false
        return true;
    } else
        return false
}

function MostrarEntradas() {
    var tarifa = $('#tarifa').val();
    if(tarifa != "Seleccione la Tarifa") {
        $('div.tarifas-table .tarifa_container').slideDown('fast');
        $('.tarifas-table .alert').slideUp('fast');
        $('div.tarifas-table .tarifa_container[tarifa-id="' + tarifa +'"]').show().find('select').prop('disabled', false);
        $('div.tarifas-table .tarifa_container:not([tarifa-id="' + tarifa +'"])').hide().find('select').prop('disabled', true);
    }
}

function calcularTotal() {
    var tarifa = $('#tarifa').val();
    var totalEntradas = 0;
    var totalPrecio = 0;

    $('div.tarifas-table div[tarifa-id="' + tarifa +'"] select').each(function(){
        if(isNumber($(this).val())) {
            $('.second_step_information').slideDown('fast');
            totalEntradas += parseFloat($(this).val());
            totalPrecio += ( parseFloat($(this).val()) * parseFloat($(this).attr('precio')) );
        }
    });
    
    //$('div.tarifas-table div.totalEntradasTarifa label.precio span').html(totalEntradas);
    $('.tota_container').slideDown('fast');
    $('.cupon-container').slideDown('fast');
    $('label.precio_total').html(formatEuro(totalPrecio));
}

function formatEuro(cant) {
    var c = parseFloat(cant).toFixed(2);
    c = ("" + c).replace(".", ",") + "€";
    return c;
}

function resetFormReserva() {
    $('#payment-register-form input[type=text]').val('');
    $('div.tarifas-table div.tarifa_container, .tota_container, .cupon-container').hide();
    $('div.tarifas-table .tarifa_container').hide('fast');
    $('.second_step_information').hide('fast');
    $('.tarifas-table .alert').show('fast');
    $('.calendar2 p.fechaSeleccionada span').html('');
    $('p.completaAhora, p.fechaSeleccionada', '.calendar2').hide();
    $('.calendar2 p.seleccionaFecha').show();
    $('#tarifas-table').hide();
}

var mapY = 0, mapX = 0, mapWidth = 0;

function scrollMap() {
    
    
    $(document).on('scroll', function(e){
        var windowTop = $(window).scrollTop();
        
        if(!$('#mapa').hasClass('fixed') && windowTop > $('#mapa').offset().top) {
            mapY = $('#mapa').offset().top;
            $('#mapa').addClass('fixed');
            
        }
        
        else if ($('#mapa').hasClass('fixed') && windowTop <= mapY ) {
            $('#mapa').removeClass('fixed');
        }
    });
}

