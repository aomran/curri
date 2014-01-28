@HelpStatus =
  status:
    "In Help Queue": true
    "Ask for Help": false

  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('.help-toggle a').attr('href')
      dataType: 'JSON'
      success: (data) ->
        HelpStatus.helpToggle(data)
        HelpStatus.poll()

  helpToggle: (data) ->
    $helpLink = $(".help-toggle a")
    if data.help != HelpStatus.status[$helpLink.text()]
      $helpLink.removeClass('in-queue ask-help')
      $helpLink.text("In Help Queue").addClass('in-queue') if data.help
      $helpLink.text("Ask for Help").addClass('ask-help') if !data.help

  showTooltip: (data) ->
    $('#help-tooltip').text(data.message).show()
    setTimeout(HelpStatus.hideTooltip, 2000)

  hideTooltip: ->
    $('#help-tooltip').fadeOut()