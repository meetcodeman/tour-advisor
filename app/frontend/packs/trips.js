$(document).ready(function() {
    $('.trips').on('click', '.trip-button', function(event) {
      var selectedShipmentId = $(this).data('attribute-id');
      var lat = $(this).data('lat');
      var long = $(this).data('long');

      renderGoogleMap(lat, long)
    });
  });

  function renderGoogleMap(lat, long) {
    var mapOptions = {
      center: { lat: lat, lng: long },
      zoom: 20
    };

    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

    var marker = new google.maps.Marker({
      position: { lat: lat, lng: long },
      map: map,
      title: 'Selected Location'
    });
    console.log(marker)
  }
  