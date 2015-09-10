$(document).on 'ready page:load', ->

  $(".navigation li").hover ->

    if $('#wrapper').hasClass("sb-collapsed")
      top = ($(this).offset().top + 2) - $(window).scrollTop();
      left = 69
      submenu = $(this).find('.sub-menu')
      $submenu_con = $('#sub-menu-nav')
      if submenu.length >0
        li = submenu.html()
        console.log li
        $submenu_con.css "top", top
        $submenu_con.css "left", left
        $submenu_con.find('.sub-menu').html(li)
        $submenu_con.removeClass("hidden")
      else
        $submenu_con.addClass("hidden")



  $("#sub-menu-nav").hover (->
  ), ->
    $('#sub-menu-nav').addClass("hidden")


  if $('.date').length >0
    $(".date").datetimepicker({
      timepicker:false,
      format:'d-M-Y'
      });


  startSpinner = ->
    $("#overlay_loading").removeClass "hidden"
  stopSpinner = ->
    $("#overlay_loading").addClass "hidden"
  document.addEventListener "page:fetch", startSpinner
  document.addEventListener "ready page:change", stopSpinner
