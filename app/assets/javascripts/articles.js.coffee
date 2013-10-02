# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$("input").keypress( (event) -> 
  if event.which == 13 
    event.preventDefault();
    $("form").submit();
);

$(document).on('click', '.filter', ( ->
    $(this).toggleClass("down");
    suppliers = $.map($(".down.supplier"), (el) ->
      el.text
    )
    types = $.map($(".down.type"), (el) ->
      el.text
    )
    $("li.long").hide();
    $.each suppliers, (supplierIndex) ->
      $.each types, (typeIndex) ->
        $("." + suppliers[supplierIndex] + "." + types[typeIndex]).show()
));