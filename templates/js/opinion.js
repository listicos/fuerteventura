var FECHAS_DISPONIBLES = new Array();
var map;
var DESCUENTO_CUPON = 0;
//var myLatlng = new google.maps.LatLng("40.4216737855101","-3.7001175433777");

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

$(document).ready(function(){
    /*
    initialize();
    
    google.maps.event.trigger(map, 'resize');
    map.setCenter(myLatlng);*/
    $('#blocker').slideUp('fast');
    
    
    rating();
    
    enviarOpinion();

});

function rating() {
    
    
    $('#rating').raty({
        starOn: BASE_URL + '/templates/imagenes/star-on-big.png',
        starOff: BASE_URL + '/templates/imagenes/star-off-big.png',
        starHalf: BASE_URL + '/templates/imagenes/star-half-big.png',
        width: false,
        target: '#puntuacion',
        targetType: 'score',
        targetKeep: true,
        hints: EVALUACIONES
    });
    
    $('#puntuacion').on('change', function(){
        $('#rating').raty({
            score:$(this).val(),
            starOn: BASE_URL + '/templates/imagenes/star-on-big.png',
            starOff: BASE_URL + '/templates/imagenes/star-off-big.png',
            starHalf: BASE_URL + '/templates/imagenes/star-half-big.png',
            width: false,
            target: '#puntuacion',
            targetType: 'score',
            targetKeep: true,
            hints: EVALUACIONES
        });
    });
    
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

function enviarOpinion() {
    $('#opinionFrm').on('submit', function(e){
        e.preventDefault();
        var valid = $(this).validationEngine('validate');
        
        if(valid) {
            var data = $(this).serialize();
            $.ajax({
                url: BASE_URL + '/ajax-opinion',
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(response) {
                    if(response.result == 'ok') {
                        toastr.success(response.msg);
                        setTimeout(function(){
                            $(window).attr('location', BASE_URL);
                        }, 5000);
                    } else {
                        toastr.error(response.msg);
                    }
                }
            });
        }
    });
}
