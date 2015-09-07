@is_valid_email = (class_name) ->
  value = ""
  if $(class_name).length != 0
    value = $(class_name).val().trim()

  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  if re.test(value)
    $(class_name).removeClass("error")
    return true
  else
    $(class_name).addClass("error")
    return false




@is_group_unique = (class_name, module_name) ->
  unique_flag = 0
  required_flag = 0
  flag = 0
  $(class_name).each (index) ->
    $this = $(this)
    value = $this.val().trim()
    bigger_index = index
    if value != ""
      if $(class_name).length != 1
        $(class_name).each (index) ->
          current_value = $(this).val().trim()
          if current_value !=""
            if bigger_index != index

              if current_value.toLowerCase() is value.toLowerCase()
                unique_flag = 1
                flag = 1
                $this.css "border", "1px solid #d43"
                $(this).css "border", "1px solid #d43"
              else
                $this.css "border", "1px solid #ddd"
                $(this).css "border", "1px solid #ddd"


          $(this).val current_value

      else
        $this.val value
        $this.css "border", "1px solid #ddd"
    else
      required_flag = 1
      flag = 1
      $this.css "border", "1px solid #d43"

  if unique_flag == 1
    $(".error-class").append module_name + " must be unique<Br/>"  
  if required_flag is 1
    $(".error-class").append module_name + " is Required<Br/>"

  if flag is 1
    $(".alert-danger").removeClass "hidden"
    return 1


@is_required = (class_name, module_name) ->
  $this = $(class_name)
  flag = 0

  $this.each ->
    value = $(this).val().trim()
    if value == ""
      $(this).css "border", "1px solid #d43"
      flag = 1
    else
      $(this).val value
      $(this).css "border", "1px solid #ddd"

  if flag is 1
    $(".error-class").append module_name + " is required<Br/>"
    $(".alert-danger").removeClass "hidden"
    return 1


@is_not_blank = (class_name) ->
  $this = $(class_name)
  flag = 0

  $this.each ->
    value = $(this).val().trim()
    if value == ""
      $(this).addClass("error")
      flag = 1
    else
      $(this).val value
      $(this).removeClass("error")

  if flag == 1
    return false
  else
    return true

    

@is_the_same = (value1, value2) ->
  if value1.trim() == value2.trim()
    return 1
  else
    return 0

@check_length = (value, length)->
  if value.trim().length < 6
    return 0
  else
    return 1



@contains_at_least_one = (parent_class,child_class, parent_name, child_name) ->
  $this = $(parent_class)
  flag = 0

  $(parent_class).each ->
    if $(this).find(child_class).length ==0
      flag = 1

  if flag == 0 
    return 0 
  else
    $(".alert-danger").removeClass "hidden"
    $(".error-class").append parent_name+" must have at least one "+child_name+"<br>"
    return 1


###
url = ajax url
class_name = DOM class or id
module_name = name of field
current_value = check if it is on edit
form = form to be submitted
###

@is_duplicate = (url, class_name, module_name, current_value,form) ->
  value = $(class_name).val().trim()
  flag = 0
  if value != current_value
    value = escapeHtml(value)
    $.ajax
      url: url + value + ".json"


      success: (data) ->
        console.log "aaaa"
        flag =0
        if data is 1
          $(".alert-danger").removeClass "hidden"
          $(class_name).css "border", "1px solid #d43"
          $(".error-class").append module_name+" already exists<br>"
          return 1
        else
          $("#overlay_loading").removeClass("hide_loading")
          $("#overlay_loading").addClass("loading")
          form.submit()
  else
    $("#overlay_loading").removeClass("hide_loading")
    $("#overlay_loading").addClass("loading")
    form.submit()







@has_no_illegal_character=(class_name)->
  illegal_chars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?"
  $this = $(class_name)
  if $this.length >=1
    flag = 0

    $this.each ->
      value = $(this).val().trim()

      if  /[^A-Za-z\d]/.test(value) == true
        console.log value
        $(this).addClass("error")
        flag = 1
      else
        $(this).val value
        $(this).removeClass("error")

    if flag == 1
      return true
    else
      return false
  else
    return true



escapeHtml = (text) ->
  text.replace(/&/g, "&amp;").
  replace(/</g, "&lt;").
  replace(/>/g, "&gt;").
  replace(/"/g, "&quot;").
  replace(/'/g, "&#039;").
  replace(/\./g, "")
