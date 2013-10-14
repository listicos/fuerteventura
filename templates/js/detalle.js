var FECHAS_DISPONIBLES = new Array();
var map;
var DESCUENTO_CUPON = 0;
var myLatlng = new google.maps.LatLng("40.4216737855101","-3.7001175433777");

function initialize() {
    if($('input[name=lat]').val() != "") {
        var lat = $('input[name=lat]').val();
        var lon = $('input[name=lon]').val()
        myLatlng = new google.maps.LatLng(lat,lon);
    }
    var mapOptions = {
        zoom: 15,
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
        theme: "clean"
    });
}
$(document).ready(function(){
    
    initialize();
    if($('#captchadiv').length > 0)
        showRecaptcha();
    google.maps.event.trigger(map, 'resize');
    map.setCenter(myLatlng);
    $('#blocker').slideUp('fast');
    
    $('.selectpicker').selectpicker();
    var menorFecha = 0;
    $('#fechas option').each(function(){
        var fecha_disponible =  new Date($(this).attr('value'));
        if(fecha_disponible) {
            RANGOS_FECHAS_DISPONIBLES.push(fecha_disponible.getTime());
            if(menorFecha == 0 || menorFecha > fecha_disponible.getTime())
                menorFecha = fecha_disponible.getTime();
        }
    });
    if(menorFecha == 0) menorFecha = new Date().getTime();
    $('#fecha').datepicker({
        format:'dd/mm/yyyy',
        language: LANGUAGE,
        startDate: new Date(menorFecha),
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
    
    //scrollMap();
    
    var fechaSeleccionada = $('input[name=fechaSeleccionada]').val();
    
    if(fechaSeleccionada && fechaSeleccionada.trim().length > 0) {
        var fecha = fechaSeleccionada.split('-');
        fechaSeleccionada = new Date(fecha[1] + '/' + fecha[0] + '/' + fecha[2]);
        $('#fecha').datepicker('_setDate', fechaSeleccionada).datepicker('fill');
        
        $('#fecha td.day:contains(' + parseInt(fecha[0]) + '):not(.disabled)').each(function(){
            
            if($(this).html() == parseInt(fecha[0]) ) {
                $(this).click();                
            }
        })
    } else {
        var fecha = new Date(menorFecha);
        $('#fecha td.day:contains(' + fecha.getDate() + '):not(.disabled)').each(function(){
            
            if($(this).html() == fecha.getDate() ) {
                $(this).click();                
            }
        })
    }
    
    /*$('.content-title').on('click', function(e){
        e.preventDefault();
        var top = $('#payment-register-form').offset().top;
        $('html, body').animate({scrollTop:top}, 500);
    })*/
    
    if($('input[name=fechaExpiracion]').length > 0) {
        $('input[name=fechaExpiracion]').datepicker({
            format:'dd/mm/yyyy',
            startDate:new Date()
        });
    }
    cardValidation();
    
    $('input[name=email]').on('change', function(){
        var mail = $(this).val();
        $('#enviaremos-email').html(mail);
    });
    /*
    var name_has_change = false;
    $('#nombre').on('change',function(){
        if(!name_has_change){
            $('#BillingFirstnames').val($(this).val());
        }
    });
    $('#BillingFirstnames').on('change',function(){
        name_has_change = true;
    });

    var surname_has_change = false;
    $('#apellido').on('change',function(){
        if(!surname_has_change){
            $('#BillingSurname').val($(this).val());
        }
    });
    $('#BillingSurname').on('change',function(){
        surname_has_change = true;
    });
*/

    cuponFunction();
    
    rating();
    
    selectTicketsFunctions();

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
            $('#blocker').fadeIn('slow');
            var data = form.serialize();
            $.ajax({
                url: BASE_URL + '/ajax-reservacion',
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(response) {
                    $('#blocker').fadeOut('slow');
                    if(response.result == 'ok') {
                        toastr.success('Se ha enviado su pregunta');
                        $('#question-container').slideUp(500);
                    } else {
                        toastr.error(response.msg);
                    }
                }
            });
        }
    });
}

function reservacionFunctions() {
    
    $('#payment-register-form').off('submit').on('submit', function(e){
        
        
        var valid = $(this).validationEngine('validate');
        var data = $(this).serialize();
        if(valid) {
            $('.second_step_information input[type="submit"]').addClass('disabled');
            $('#blocker').slideDown('fast');
            
            if($('#forma_pago').val()=='Online' && $('input[name=onRequest]').val() != '1'){
                //Pago Caixa
                var win=window.open(BASE_URL+'/cargando','tpv','fullscreen=yes,scrollbars=no,resizable=no,status=yes,menubar=no,location=no,titlebar=no');
                //Termina pago Caixa
            }

            $.ajax({
                url: BASE_URL + '/ajax-reservacion',
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(response) {
                    
                    
                    if($('#forma_pago').val()=='Online' && response.order && $('input[name=onRequest]').val() != '1'){
                        //Pago Caixa
                        $('.order').val(response.order);
                        $('.signature').val(response.signature);
                        $('#caixa_pago_form').submit();
                        $('#blocker').slideUp('slow');
                        //Termina pago Caixa
                    }else{
                        $('.second_step_information input[type="submit"]').removeClass('disabled');
                        $('#blocker').slideUp('slow');
                    }

                    if(response.result == 'ok') {
                        toastr.success(response.msg);
                        if($('#forma_pago').val()!='Online' || response.order && $('input[name=onRequest]').val() == '1'){
                            setTimeout(function(){
                               $(window).attr('location', BASE_URL + '/confirmacion/codigo:' + response.data.codigo);
                            }, 2000);
                        }

                    } else {
                        toastr.error(response.msg);
                         var top = $('#payment-register-form .second_step_information').offset().top;
                        $('html, body').animate({scrollTop:top}, 500);
                    }
                },
                error: function(ev) {
                    $('.second_step_information input[type="submit"]').removeClass('disabled');
                    $('#blocker').fadeOut('slow');
                    console.log(ev);
                }
            });
        }
        e.preventDefault();
        
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
        
        var sesiones = $('.sesionesTarifas[tarifa-id=' + tarifa + ']').html();
        if(sesiones.trim().length > 0) {
            $('p.horaSeleccionada select', '.calendar2').prop('disabled', false).html('');
            sesiones = sesiones.split(',');
            for(i=0;i<sesiones.length; i++) {
                $('p.horaSeleccionada select', '.calendar2').append('<option value="' + sesiones[i].trim() + '">' + sesiones[i].trim() + '</option>');
            }
            $('p.horaSeleccionada', '.calendar2').show();
        } else {
            $('p.horaSeleccionada', '.calendar2').hide();
            $('p.horaSeleccionada select', '.calendar2').prop('disabled', true);
        }
        
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

    $('div.tarifas-table div[tarifa-id="' + tarifa +'"] select:not([disabled=""])').each(function(){
        if(isNumber($(this).val())) {
            $('.second_step_information').slideDown('fast');
            totalEntradas += parseFloat($(this).val());
            totalPrecio += ( parseFloat($(this).val()) * parseFloat($(this).attr('precio')) );
        }
    });
    
    //$('div.tarifas-table div.totalEntradasTarifa label.precio span').html(totalEntradas);
    $('.tota_container').slideDown('fast');
    $('.cupon-container').slideDown('fast');
    if (DESCUENTO_CUPON > 0) {
        var realPrecio = totalPrecio - (totalPrecio * DESCUENTO_CUPON / 100);
        $('label.precio_total, span#confirmar-total').html("<s>" + formatEuro(totalPrecio) + "</s><br> -" + formatEuro(totalPrecio * DESCUENTO_CUPON / 100) + "<br><hr style='margin: 0; border: 1px solid #cecece;'> " + formatEuro(realPrecio));
        totalPrecio = realPrecio;
    } else {
        $('label.precio_total, span#confirmar-total').html(formatEuro(totalPrecio));
    }
    
    if($('#confirmar-total').length > 0) {
        if($('#porcientoAdelanto').length > 0) {
            var descuento = parseFloat($('#porcientoAdelanto').html());
            $('#pagoAdelantado').html(formatEuro(totalPrecio * descuento / 100));
            $('.amount').val(totalPrecio * descuento);
            if($('input[name=onRequest]').val() != '1')
                $('#total_reservar_button').val('✓ Realizar pago de '+formatEuro(totalPrecio * descuento / 100));
        } else {
            $('.amount').val(totalPrecio);
        }
    }
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

function cardValidation() {
    
    var cards = new Array();
    $('ul.cards li').each(function(){
        
        cards.push($(this).attr('card'));
    });
    
    if($('input[name=CardNumber]').length > 0) {
        $('input[name=CardNumber]').attr('valid-card', false);
        $('input[name=CardNumber]').validateCreditCard(function(ev){
                $(".cards li").addClass("off");
                $('input[name=CardNumber]').removeClass('validCreditCard');
                if(ev.card_type==null){
                        $('input[name=CardNumber]').attr('valid-card', false);
                        $('input[name=CardType]').val('');
                        return
                }
                $(".cards ." + ev.card_type.name).removeClass("off");
                $('input[name=CardType]').val($(".cards ." + ev.card_type.name).attr('title'));
                if(ev.length_valid && ev.luhn_valid) {                
                     $('input[name=CardNumber]').attr('valid-card', true).addClass('validCreditCard');
                     
                     return true;
                }
                return false;
        },
        {accept:cards}
        );
    }
    
}

function cuponFunction() {
    $('input[name=cupon]').on('change', function(){
        if(DESCUENTO_CUPON > 0) {
            DESCUENTO_CUPON = 0;
            calcularTotal();
        }
    })
    $('#validar_cupon').on('click', function(e){
        e.preventDefault();
        var cupon = $('input[name=cupon]').val();
        var tarifaId = $('#tarifa').val();
        var sesion = $('#sesion').val();
        var fecha = $('[name=fecha]').val();
        if(cupon.trim().length > 0 && tarifaId.trim().length > 0 && fecha.trim().length > 0) {
            var data = { 
                codigo: cupon,
                tarifaId: tarifaId,
                sesion: sesion,
                fecha: fecha,
                action: 'validarCupon'
            };
            $.ajax({
                type: 'post',
                dataType: 'json',
                data: data,
                url : BASE_URL + '/ajax-reservacion',
                success: function(response) {
                    if(response.result == 'ok') {
                        toastr.success('El código es válido');
                        DESCUENTO_CUPON = parseFloat(response.data.descuento);
                        calcularTotal();
                    } else {
                        toastr.error('El código no es válido');
                        if(DESCUENTO_CUPON > 0) {
                            DESCUENTO_CUPON = 0;
                            calcularTotal();
                        }
                    }
                }
            })
        }
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

function selectTicketsFunctions() {
    if($('div.select-tickets').length > 0) {
        selectTicket();
        $('div.select-tickets input[type=radio]').change(selectTicket)
    }
}

function selectTicket() {
    if($('div.select-tickets input[type=radio]:checked').length == 0)
            $($('div.select-tickets input[type=radio]')[0]).prop('checked', true);
    $('div.select-tickets input[type=radio]').each(function(){
        $(this).parent().parent().find('select').prop('disabled', !$(this).prop('checked'));
        if($(this).prop('checked')) {
            $(this).parent().parent().addClass('entrada-selected');
        } else {
            $(this).parent().parent().removeClass('entrada-selected');
        }
    });
    calcularTotal();
}
