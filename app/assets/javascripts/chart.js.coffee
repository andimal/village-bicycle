window.make_chart = ->
  chart_width       = $('.chart').outerWidth()
  chart_height      = $('.chart').outerHeight()
  width_increments  = $(window).outerWidth() / 12
  path_string       = "M0,#{chart_height}L"
  top_limit         = Math.max.apply( Math, trip_duration )

  r = Raphael( $('.chart')[0], '100%', '100%')
  l = r.linechart( -10, 10, chart_width + 20, chart_height, [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23], trip_duration,
  {
    shade   : true
    smooth  : true
  })

  window.chart_points = []
  l.each ->
    window.chart_points.push(this)