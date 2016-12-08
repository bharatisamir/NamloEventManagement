/**
 * Created by bharati_sameer on 11/16/16.
 */

function initMap(first, second) {

    var uluru = {lat: first, lng: second};
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 4,
        center: uluru
    });
    var marker = new google.maps.Marker({
        position: uluru,
        map: map
    });
}



$(".a-unique-class").html('<%= j render "invitations/event_detail" %>')