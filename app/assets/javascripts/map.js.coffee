zoom        = 12
center      = new google.maps.LatLng(41.886407,-87.6576544)
scrollwheel = false

opts_map_day =
  zoom        : zoom
  center      : center
  mapTypeId   : google.maps.MapTypeId.ROADMAP
  scrollwheel : scrollwheel
  styles      : [{"featureType":"water","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]},{"featureType":"landscape","stylers":[{"color":"#f2e5d4"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"administrative","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"road"},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{},{"featureType":"road","stylers":[{"lightness":20}]}]
  disableDefaultUI: true

opts_map_night =
  zoom              : zoom
  center            : center
  mapTypeId         : google.maps.MapTypeId.ROADMAP
  scrollwheel       : scrollwheel
  styles            : [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#000000"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#000000"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":17},{"weight":1.2}]}]
  panControl        : false
  streetViewControl : false
  mapTypeControl    : false
  # zoomControl: boolean,
  # scaleControl: boolean,
  # overviewMapControl: boolean      

map_day   = new google.maps.Map(document.getElementById('map-day'), opts_map_day)
map_night = new google.maps.Map(document.getElementById('map-night'), opts_map_night)

# map_00 = new google.maps.Map(document.getElementById('map-00'), opts_map_night)
# map_01 = new google.maps.Map(document.getElementById('map-01'), opts_map_night)
# map_02 = new google.maps.Map(document.getElementById('map-02'), opts_map_night)
# map_03 = new google.maps.Map(document.getElementById('map-03'), opts_map_night)
# map_04 = new google.maps.Map(document.getElementById('map-04'), opts_map_night)
# map_05 = new google.maps.Map(document.getElementById('map-05'), opts_map_night)
# map_11 = new google.maps.Map(document.getElementById('map-11'), opts_map_night)
# map_12 = new google.maps.Map(document.getElementById('map-12'), opts_map_night)
# map_13 = new google.maps.Map(document.getElementById('map-13'), opts_map_night)
# map_14 = new google.maps.Map(document.getElementById('map-14'), opts_map_night)
# map_20 = new google.maps.Map(document.getElementById('map-20'), opts_map_night)

# directionsService = new google.maps.DirectionsService()
# directionsDisplay = new google.maps.DirectionsRenderer()
# directionsDisplay.setMap(map_night)

make_heatmap = (trip_data, map) ->
  new_map = new google.maps.Map(map, opts_map_night)
  directions_points_array = []

  $.each trip_data, ->
    decoded = google.maps.geometry.encoding.decodePath( this )
    directions_points_array = directions_points_array.concat( decoded )

  point_array = new google.maps.MVCArray( directions_points_array )
  heatmap = new google.maps.visualization.HeatmapLayer(data: point_array)
  heatmap.set('radius', 7)
  heatmap.setMap new_map

directions_points_array = []

make_heatmap(trip_data_00, $('.map-00')[0] )
# make_heatmap(trip_data_01, map_01)
# make_heatmap(trip_data_02, map_02)
# make_heatmap(trip_data_03, map_03)
# make_heatmap(trip_data_04, map_04)
# make_heatmap(trip_data_05, map_05)
# make_heatmap(trip_data_11, map_11)
# make_heatmap(trip_data_12, map_12)
# make_heatmap(trip_data_13, map_13)
# make_heatmap(trip_data_14, map_14)
# make_heatmap(trip_data_20, map_20)

# decoded = google.maps.geometry.encoding.decodePath( "cjs~Frl|uOd@??_HkJHgJHqCN]@oGF@aAKmCEsKAi@aDB?f@HfI{H~FcErCWTaBpAy@r@a@Pq@?SABvAAbEe@?{BB_DHmEB[E_DBy@H" )
# console.log decoded

# i       = 0
# loaded  = 0
# while i < trip_data.length / 2
#   start = trip_data[i * 2]
#   end = trip_data[(i * 2) + 1]
#   request =
#     origin: start
#     destination: end
#     travelMode: google.maps.TravelMode.BICYCLING

#   directionsService.route request, (response, status) ->
#     console.log status
#     directions_points_array = directions_points_array.concat(response.routes[0].overview_path)
#     loaded++
#     if loaded is trip_data.length / 2
#       # console.log JSON.stringify( directions_points_array )
#       point_array = new google.maps.MVCArray( directions_points_array )
#       heatmap = new google.maps.visualization.HeatmapLayer(data: point_array)
#       heatmap.set('radius', 5)
#       heatmap.setMap map_night
#   i++

google.maps.event.addListener map_night, 'tilesloaded', ->
  $map_night_inner    = $('#map-night .gm-style div').first()
  sunrise             = 7
  sunset              = 18
  transition_duration = 1
  ratio               = 100 / 24
  current_map         = 'night'
  current_hour        = $('.map-slider').attr('data-hour')
  change_values = [
    (sunrise - transition_duration) * ratio,
    (sunrise + transition_duration) * ratio,
    (sunset - transition_duration) * ratio,
    (sunset + transition_duration) * ratio 
  ]

  adjust_map_display = (value) ->
    if value < change_values[0]
      $map_night_inner.css
        opacity : 1

    else if value > change_values[0] and value < change_values[1]
      $map_night_inner.css
        opacity : 1 - ( ( value - change_values[0] ) / ( change_values[0] - change_values[1] ) * -1 )

    else if value > change_values[1] and value < change_values[2]
      $map_night_inner.css
        opacity : 0

    else if value > change_values[2] and value < change_values[3]
      $map_night_inner.css
        opacity : ( ( value - change_values[2] ) / ( change_values[2] - change_values[3] ) * -1 )

    else if value > change_values[3]
      $map_night_inner.css
        opacity : 1

  $('.map-slider').slider
    create : ->
      $(this).slider 'value', current_hour * ratio
      adjust_map_display( current_hour * ratio )
    slide  : ( event, ui ) ->
      adjust_map_display( ui.value )
      $current = $('.current-heatmap')
      $current.removeClass('current-heatmap')
      if $('.heatmap').index( $current ) < $('.heatmap').length - 1
        $current.next().addClass('current-heatmap')
      else
        $('.heatmap:first').addClass('current-heatmap')

  google.maps.event.addListener map_night, 'center_changed', ->
    map_day.panTo map_night.getCenter()

  google.maps.event.addListener map_night, 'zoom_changed', ->
    map_day.setZoom map_night.getZoom()


