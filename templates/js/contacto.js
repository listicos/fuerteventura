var map;
var myLatlng = new google.maps.LatLng("28.7361111111","-13.8677777778");

function initialize() {
  
    var mapOptions = {
        zoom: 14,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('contact-map'), mapOptions);

    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map
    });
}

$(document).ready(function(){
    $('#blocker').slideUp('fast');
    initialize();
    google.maps.event.trigger(map, 'resize');
    map.setCenter(myLatlng);
    
    $('#contact-form').submit(function(e){
        e.preventDefault();
        var valid = $(this).validationEngine('validate');
        if(valid) {
            var data = $(this).serialize();
            $.ajax({
                url: BASE_URL + '/ajax-contacto',
                data: data,
                type: 'post',
                dataType: 'json',
                success: function(response) {
                    if(response.result == 'ok') {
                        toastr.success(response.msg);
                    } else {
                        toastr.error(response.msg);
                    }                    
                }
            });
        }
    });
    
    $('#subscribe_form').submit(function(e){
        e.preventDefault();
        var valid = $(this).validationEngine('validate');
        if(valid) {
            var data = $(this).serialize();
            $.ajax({
                url: BASE_URL + '/ajax-suscripcion',
                data: data,
                type: 'post',
                dataType: 'json',
                success: function(response) {
                    if(response.result == 'ok') {
                        toastr.success(response.msg);
                    } else {
                        toastr.error(response.msg);
                    } 
                }
            });
        }
    })
});

