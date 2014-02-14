$ = jQuery

$ ->
  if Curri.user.classrole_type == 'Teacher'
    if $('#track').length
      # Delete Checkpoints
      $('.expectation-actions .trash-icon').on "ajax:success", (e, data)->
        Curri.Checkpoint.remove(data.id)

      # Checkpoints sort
      Curri.Checkpoint.sortable()

    if $('.tracks').length
      $('.tracks').sortable
        items: "> div.grid-unit"
        handle: '.unit-header'
        cursor: 'move'
        placeholder: "track-drop-highlight"
        start: (e, ui) ->
          ui.placeholder.height(ui.item.height())
          ui.placeholder.width(ui.item.width())
          $(ui.placeholder).addClass("grid-unit narrow")
        update: ->
          $.post($(this).data('url'), $(this).sortable('serialize'))

    if $('.new_track').length || $('.edit_track').length
      $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
      $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
      $('#track_start_time').pickatime({format: 'hh:i a'})
      $('#track_end_time').pickatime({format: 'hh:i a'})
      editor = new wysihtml5.Editor("wysihtml5-textarea", { toolbar: "wysihtml5-toolbar", parserRules: wysihtml5ParserRules })