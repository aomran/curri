$ = jQuery

$ ->
  # Update Header
  if $('#student-help-toggle').length
    HelpStatus.poll()

  if $('#requesters_link').length
    RequestsNumber.poll()

  $('#student-help-toggle a').on 'ajax:success', (e, data) ->
    HelpStatus.helpToggle(data)
    HelpStatus.showTooltip(data)