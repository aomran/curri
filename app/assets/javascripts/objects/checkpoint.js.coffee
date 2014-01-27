@Checkpoint =
  remove: (id) ->
    $("#checkpoint_#{id}").fadeOut 'slow', ->
      $(this).remove()

  showCriteria: (el) ->
    el.closest('.row').find('.success-criteria').toggle()

  openChoices: (el) ->
    el.closest('.ratings').find('.choices').toggle()

  closeChoices: (el) ->
    $ratings = el.closest('.ratings')
    $ratings.find('.choices-toggle').fadeOut()
    $ratings.find('.choices').toggle()

  updateRating: (data) ->
    $("#checkpoint_#{data.checkpoint_id} .choices-toggle").html(data.partial).fadeIn()

  sortable: ->
    $('.checkpoints').sortable
      items: "> div.row"
      handle: '.expectation'
      cursor: 'move'
      axis: 'y'
      placeholder: "checkpoint-drop-highlight expectation content"
      start: (e, ui) ->
        ui.placeholder.height(ui.item.height())
        ui.placeholder.width(ui.item.width())
      update: ->
        $.post($(this).data('url'), $(this).sortable('serialize'))