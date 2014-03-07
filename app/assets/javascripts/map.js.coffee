mouse_x = 0
mouse_y = 0
$(document).mousemove (e) ->
  mouse_x = e.pageX
  mouse_y = e.pageY

zoom              = 12
center            = new google.maps.LatLng(41.886407,-87.6576544)
scrollwheel       = false
gradient_array_1  = ['rgba(0,255,0,0)']
gradient_array_2  = ['rgba(0,0,255,0)']

opts_map_day =
  zoom              : zoom
  center            : center
  mapTypeId         : google.maps.MapTypeId.ROADMAP
  scrollwheel       : scrollwheel
  draggable         : false
  styles            : [{"featureType":"water","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]},{"featureType":"landscape","stylers":[{"color":"#f2e5d4"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"administrative","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"road"},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{},{"featureType":"road","stylers":[{"lightness":20}]}]
  disableDefaultUI  : true

opts_map_night =
  zoom              : zoom
  center            : center
  mapTypeId         : google.maps.MapTypeId.ROADMAP
  scrollwheel       : scrollwheel
  draggable         : false
  styles            : [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#000000"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#000000"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":17},{"weight":1.2}]}]
  panControl        : false
  streetViewControl : false
  mapTypeControl    : false
  disableDefaultUI  : true
  # zoomControlOptions  :
  #   position: google.maps.ControlPosition.LEFT_CENTER
  # zoomControl: boolean,
  # scaleControl: boolean,
  # overviewMapControl: boolean

opts_map_control =
  zoom                : zoom
  center              : center
  mapTypeId           : google.maps.MapTypeId.ROADMAP
  scrollwheel         : scrollwheel
  panControl          : false
  streetViewControl   : false
  mapTypeControl      : false
  zoomControlOptions  :
    position: google.maps.ControlPosition.LEFT_CENTER

map_day     = new google.maps.Map(document.getElementById('map-day'), opts_map_day)
map_night   = new google.maps.Map(document.getElementById('map-night'), opts_map_night)
map_markers = new google.maps.Map($('.map-markers')[0], opts_map_day)
map_control = new google.maps.Map($('.map-control')[0], opts_map_control)

map_array   = [map_day,map_night,map_markers]

make_heatmap = (trip_data, map, index) ->
  new_map = new google.maps.Map(map, opts_map_night)
  map_array.push( new_map )
  directions_points_array = []

  $.each trip_data, ->
    decoded = google.maps.geometry.encoding.decodePath( this )
    directions_points_array = directions_points_array.concat( decoded )

  point_array = new google.maps.MVCArray( directions_points_array )
  heatmap = new google.maps.visualization.HeatmapLayer(data: point_array)
  heatmap.set('radius', 8)
  
  index = parseInt(index, 10)
  if index > 6 and index < 18
    heatmap.set('gradient', gradient_array_2)
  else
    heatmap.set('gradient', gradient_array_1)

  heatmap.setMap new_map

  if index is 23
    google.maps.event.addListener map, 'tilesloaded', ->
      console.log 'done!!!'

google.maps.event.addListener map_control, 'tilesloaded', ->

  google.maps.event.addListener map_control, 'center_changed', ->
    $.each map_array, ->
      this.panTo map_control.getCenter()

  google.maps.event.addListener map_control, 'zoom_changed', ->
    $.each map_array, ->
      this.setZoom map_control.getZoom()

  $.each station_data,(i) ->
    station_lat_lng = new google.maps.LatLng(this.lat,this.lng)
    
    if i < 11
      pin_icon = new google.maps.MarkerImage(
        "images/top-marker.svg"
        null
        null
        null
        new google.maps.Size(24, 33)
      )
    else
      pin_icon = new google.maps.MarkerImage(
        "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        null
        null
        null
        new google.maps.Size(16, 16)
      )

    marker = new google.maps.Marker(
      position  : station_lat_lng
      map       : map_markers
      title     : this['name']
      icon      : pin_icon
    )

    $cloned_popover = ''
    google.maps.event.addListener marker, 'mouseover', (e) ->
      $cloned_popover = $('#marker-popover-template').clone().appendTo('body')
      $cloned_popover.css
        'top' : mouse_x
        'left' : mouse_y

    google.maps.event.addListener marker, 'mouseout', ->
      $cloned_popover.remove()

$ ->
  gradient_1 = new Rainbow()
  gradient_1.setSpectrum('#00FF00', '#FFFF00', '#FF0000')
  gradient_1.setNumberRange(0,12)

  i = 0
  while i < 12
    gradient_array_1.push( '#' + gradient_1.colourAt(i) )
    i++

  gradient_2 = new Rainbow()
  gradient_2.setSpectrum('blue', 'yellow', 'red')
  gradient_2.setNumberRange(0,12)

  i = 0
  while i < 12
    gradient_array_2.push( '#' + gradient_2.colourAt(i) )
    i++

$(window).load ->
  $.getScript 'static-data.js', ->
    window.make_chart()

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
        $('.heatmap').eq(current_hour).addClass('current-heatmap')
        adjust_map_display( current_hour * ratio )
      slide  : ( event, ui ) ->
        current_hour    = parseInt(ui.value / 100 * 24, 10)
        current_section = window.chart_points[ current_hour ]

        $('.chart-point').css
          top: current_section.y - ( $('.chart-point').outerHeight() / 2 )
          left: current_section.x - ( $('.chart-point').outerWidth() / 2 )

        $('.chart-caption')
          .css
            top: current_section.y - $('.chart-caption').outerHeight() - 40
            left: current_section.x - ( $('.chart-caption').outerWidth() / 2 )
          .find('h4').text("#{current_section.value} hours")

        if !$('.show-chart').length
          $('.chart').addClass('show-chart')

        adjust_map_display( ui.value )
        
        $current = $('.current-heatmap')
        $current.removeClass('current-heatmap')

        $('.heatmap').eq(current_hour).addClass('current-heatmap')
      
      stop  : ->
        $('.chart').removeClass('show-chart')

    i = 0
    while i < 24
      if i < 10
        i = "0#{i}"

      # make_heatmap( window["trip_data_#{i}"], $('.map-' + i)[0], i )

      i++

