$(document).on "click", '#sidebar-collapse', (event) ->
  event.preventDefault()


  if $("#wrapper").hasClass("sb-collapsed")
    $(".toggle-i").addClass("fa-angle-left").removeClass("fa-angle-right");
    $("#wrapper").removeClass("sb-collapsed")
    $('#sub-menu-nav').addClass("hidden")
  else
    $(".toggle-i").removeClass("fa-angle-left").addClass("fa-angle-right");
    $("#wrapper").addClass("sb-collapsed")


$(document).on "click", '.parent-toggle', (event) ->
  event.preventDefault()

  if $(this).parent().hasClass("open")
    $(this).parent().removeClass("open")
    $(this).next().removeClass("block")
  else
    $(this).parent().addClass("open")
    $(this).next().addClass("block")

