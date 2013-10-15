# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$("input").keypress( (event) -> 
  if event.which == 13 
    event.preventDefault();
    $("form").submit();
);

$(document).ready -> 
     user_id = $("#user_id").val()
     article_id = $("#article_id").val()
     $('#notes').editable('/notes/'+article_id+'/'+user_id, { 
         type      : 'autogrow',
         cancel    : 'Cancel',
         submit    : 'Save',
         tooltip   : 'Click to edit...',
         autogrow : {
          lineHeight : 16,
          maxHeight  : 512
         }
     });

$(document).on('click', '.filter', ( ->
    $(this).toggleClass("down");
    suppliers = $.map($(".down.supplier"), (el) ->
      el.text
    )
    types = $.map($(".down.type"), (el) ->
      el.text
    )
    costs = $.map($(".down.cost"), (el) ->
      el.text
    )
    $("li.long").hide();
    s = 0
    while s < suppliers.length
      t = 0
      while t < types.length
        c = 0
        while c < costs.length
          $("." + suppliers[s] + "." + types[t] + "." + costs[c]).show();
          c++
        t++
      s++
));