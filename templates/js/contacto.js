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
    $('#blocker').fadeOut();
    initialize();
    google.maps.event.trigger(map, 'resize');
    map.setCenter(myLatlng);
    
});

